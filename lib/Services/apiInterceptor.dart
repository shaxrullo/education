import 'package:dio/dio.dart';
import 'package:education/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Bu — main.dart'da MaterialApp'ga bog'lanishi kerak:
// MaterialApp(navigatorKey: navigatorKey, ...)
final navigatorKey = GlobalKey<NavigatorState>();

class ApiInterceptor extends Interceptor {
  final Dio dio;

  ApiInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1-tuzatish: login/register/refresh so'rovlariga eski token qo'shilmaydi
    final isAuthFree =
        options.path.contains('login') ||
        options.path.contains('register') ||
        options.path.contains('token/refresh');

    if (!isAuthFree) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 2-tuzatish: 401 kelganda ham, agar bu login/register/refresh so'rovining
    // o'zi bo'lsa — qayta refresh urinishga hojat yo'q, chunki bu cheksiz
    // tsiklga olib kelishi mumkin (masalan refresh so'rovi 401 qaytarsa)
    final isAuthFree =
        err.requestOptions.path.contains('login') ||
        err.requestOptions.path.contains('register') ||
        err.requestOptions.path.contains('token/refresh');

    if (err.response?.statusCode == 401 && !isAuthFree) {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token');

      if (refreshToken != null) {
        try {
          final response = await Dio().post(
            'http://10.225.34.50:8000/api/auth/token/refresh/',
            data: {'refresh': refreshToken},
          );

          if (response.statusCode == 200) {
            final newAccessToken = response.data['access'];
            await prefs.setString('access_token', newAccessToken);

            err.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';
            final clonedRequest = await dio.fetch(err.requestOptions);

            return handler.resolve(clonedRequest);
          }
        } catch (e) {
          // 3-tuzatish: refresh ham muvaffaqiyatsiz bo'lsa,
          // ma'lumotlar tozalanadi VA foydalanuvchi Login ekraniga
          // haqiqatan yo'naltiriladi (avval faqat izoh bo'lib, hech narsa
          // qilinmasdi)
          await prefs.clear();
          _redirectToLogin();
        }
      } else {
        // refreshToken umuman yo'q bo'lsa ham, Login ekraniga yo'naltiriladi
        await prefs.clear();
        _redirectToLogin();
      }
    }

    return handler.next(err);
  }

  void _redirectToLogin() {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context == null) return;

    // Diqqat: "LoginScreen" o'rniga sizning haqiqiy Login widget nomingizni
    // va importini qo'ying
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }
}
