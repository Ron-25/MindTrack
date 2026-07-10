import 'package:dio/dio.dart';
import 'package:mind_track/core/network/api_client.dart';
import 'package:mind_track/features/login/domain/exceptions/auth_exception.dart';
import '../models/auth_token_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokenModel> login({
    required String email,
    required String password,
  });

  Future<AuthTokenModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<String> forgotPassword({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<AuthTokenModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final Response<dynamic> response = await _client.dio.post<dynamic>(
        '/api/v1/auth/login',
        data: <String, String>{'email': email, 'password': password},
      );
      return AuthTokenModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw AuthException(_extractDetail(e));
    }
  }

  @override
  Future<AuthTokenModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final Response<dynamic> response = await _client.dio.post<dynamic>(
        '/api/v1/auth/register',
        data: <String, String>{
          'name': name,
          'email': email,
          'password': password,
        },
      );
      return AuthTokenModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw AuthException(_extractDetail(e));
    }
  }

  @override
  Future<String> forgotPassword({required String email}) async {
    try {
      final Response<dynamic> response = await _client.dio.post<dynamic>(
        '/api/v1/auth/forgot-password',
        data: <String, String>{'email': email},
      );
      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      return json['message'] as String? ??
          'Si el correo está registrado, recibirás instrucciones para restablecer tu contraseña.';
    } on DioException catch (e) {
      throw AuthException(_extractDetail(e));
    }
  }

  String _extractDetail(DioException e) {
    final dynamic data = e.response?.data;
    if (data is Map<String, dynamic>) {
      return (data['detail'] as String?) ?? 'Error desconocido';
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Tiempo de espera agotado. Verifica tu conexión.';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'No se pudo conectar al servidor.';
    }
    return 'Error de red. Inténtalo de nuevo.';
  }
}
