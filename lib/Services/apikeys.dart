import 'package:dio/dio.dart';
import 'package:education/Model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Storage loyihangizdagi joylashuviga ko'ra o'zgartiring

class Apikeys {
  final Dio dio = Dio(BaseOptions(baseUrl: "http://10.225.34.50:8000/api/"));

  String? accessToken;
  String? refreshToken;
  UserModel? currentUser;

  // Interceptor konstruktor ichiga qo'shildi
  Apikeys() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // SharedPreferences'dan saqlangan tokenni olamiz
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('access_token');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (DioException error, handler) {
          print("API Error [${error.response?.statusCode}]: ${error.response?.data}");
          return handler.next(error);
        },
      ),
    );
  }

  void setToken(String token) {
    accessToken = token;
  }

  void getToken(String tokeni) {
    refreshToken = tokeni;
  }
}

final apiService = Apikeys();