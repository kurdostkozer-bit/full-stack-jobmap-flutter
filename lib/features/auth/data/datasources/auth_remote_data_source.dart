import '../models/auth_session_model.dart';

abstract class AuthRemoteDataSource {
  /// Login with email and password.
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  });

  /// Register a new account.
  Future<AuthSessionModel> register({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  });

  /// Refresh an expired session.
  Future<AuthSessionModel> refreshSession(
    String refreshToken,
  );

  /// Logout current user.
  Future<void> logout();
}