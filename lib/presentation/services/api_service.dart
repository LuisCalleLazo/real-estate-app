import 'package:dio/dio.dart';
import 'package:real_estate_app/shared/constants/storage_value.dart';
import 'package:real_estate_app/shared/utils/types.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiSecure {
  final ServicesInmo service;

  late final Dio _dio;

  ApiSecure({required this.service}) {
    // Obtiene la URL base según el servicio seleccionado
    String baseUrl = _getBaseUrl(service);

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          const storage = FlutterSecureStorage();
          final currentToken = await storage.read(
            key: StorageValue.getCurrentToken(),
          );
          if (currentToken != null) {
            options.headers['Authorization'] = 'Bearer $currentToken';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            const FlutterSecureStorage().delete(
              key: StorageValue.getCurrentToken(),
            );
            const FlutterSecureStorage().delete(
              key: StorageValue.getRefreshToken(),
            );
            const FlutterSecureStorage().delete(key: StorageValue.getUser());
          }
          return handler.next(e);
        },
      ),
    );
  }
  Dio get client => _dio;

  String _getBaseUrl(ServicesInmo service) {
    switch (service) {
      case ServicesInmo.authService:
        return dotenv.env['API_AUTH_URL']!;
      case ServicesInmo.inmoService:
        return dotenv.env['API_INMO_URL']!;
    }
  }
}

final apiAuto = ApiSecure(service: ServicesInmo.authService).client;
