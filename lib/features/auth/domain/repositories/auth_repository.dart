import '../entities/auth_session.dart';

abstract class AuthRepository {
  /// Login using email and password.
  Future<AuthSession> login({
    required String email,
    required String password,
  });

  /// Create a new account.
  Future<AuthSession> register({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  });

  /// Refresh expired access token.
  Future<AuthSession> refreshSession(
    String refreshToken,
  );

  /// Logout current user.
  Future<void> logout();

  /// Returns current authenticated session if available.
  Future<AuthSession?> getCurrentSession();

  /// Returns true if the user is authenticated.
  Future<bool> isAuthenticated();
}