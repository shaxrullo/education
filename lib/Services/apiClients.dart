import 'package:dio/dio.dart';
import 'package:education/Services/apiInterceptor.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.225.34.50:8000/api/', // O'zingizning Base URL
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // INTERCEPTOR SHU YERGA QO'SHILADI:
    dio.interceptors.add(ApiInterceptor(dio));
  }
}

final apiClients = ApiClient();
