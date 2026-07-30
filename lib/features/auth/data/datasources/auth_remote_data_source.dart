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

  /// Social login (Google, Facebook, etc.)
  Future<AuthSessionModel?> socialLogin({
    required String email,
    required String firstName,
    required String lastName,
    required String provider,
    required String providerId,
    required String idToken,
  });

  /// Verify email with code.
  Future<void> verifyEmail({
    required String email,
    required String code,
  });

  /// Request password reset.
  Future<void> forgotPassword({required String email});

  /// Reset password with code and new password.
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  });

  /// Refresh an expired session.
  Future<AuthSessionModel> refreshSession(
    String refreshToken,
  );

  /// Logout current user.
  Future<void> logout();
}
