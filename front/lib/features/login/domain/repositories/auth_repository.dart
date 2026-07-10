import '../entities/auth_token.dart';

abstract class AuthRepository {
  Future<AuthToken> login({
    required String email,
    required String password,
  });

  Future<AuthToken> register({
    required String name,
    required String email,
    required String password,
  });

  Future<String> forgotPassword({required String email});
}
