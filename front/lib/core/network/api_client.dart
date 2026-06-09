import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mind_track/app/navigation_service.dart';
import 'package:mind_track/app/routes/route_names.dart';
import 'package:mind_track/core/services/token_storage_service.dart';
import 'package:toastification/toastification.dart';

class ApiClient {
  ApiClient(this._tokenStorage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: <String, String>{'Content-Type': 'application/json'},
      ),
    );
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
              if (!_isPublicPath(options.path)) {
                final String? accessToken = await _tokenStorage
                    .getAccessToken();
                if (accessToken != null && accessToken.isNotEmpty) {
                  options.headers['Authorization'] = 'Bearer $accessToken';
                }
              }
              handler.next(options);
            },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {
            await _tokenStorage.clearTokens();
            toastification.show(
              context: navigatorKey.currentContext,
              type: ToastificationType.warning,
              title: const Text('Sesión expirada'),
              description: const Text('Por favor inicia sesión nuevamente.'),
              autoCloseDuration: const Duration(seconds: 4),
              alignment: Alignment.topRight,
              showProgressBar: true,
            );
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              RouteNames.signIn,
              (Route<dynamic> route) => false,
            );
          }
          handler.next(error);
        },
      ),
    );
  }

  final TokenStorageService _tokenStorage;
  late final Dio _dio;

  Dio get dio => _dio;

  bool _isPublicPath(String path) {
    return path.contains('/api/v1/auth/login') ||
        path.contains('/api/v1/auth/register') ||
        path.contains('/api/v1/auth/refresh');
  }
}
