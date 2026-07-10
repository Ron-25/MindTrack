import 'package:mind_track/features/login/domain/entities/auth_token.dart';
import 'package:mind_track/features/login/domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AuthToken> login({required String email, required String password}) {
    return _remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<AuthToken> register({
    required String name,
    required String email,
    required String password,
  }) {
    return _remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<String> forgotPassword({
    required String email,
    required String newPassword,
  }) {
    return _remoteDataSource.forgotPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}
