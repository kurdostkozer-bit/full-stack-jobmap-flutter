import '../entities/auth_session.dart';

abstract class AuthRepository {
  Future<AuthSession> register({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  });

  Future<void> verifyEmail({
    required String email,
    required String code,
  });

  Future<AuthSession> login({
    required String email,
    required String password,
  });

  Future<AuthSession?> socialLogin({
    required String email,
    required String firstName,
    required String lastName,
    required String provider,
    required String providerId,
    required String idToken,
  });

  Future<void> logout();

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  });

  Future<AuthSession> refreshSession({required String refreshToken});

  Future<bool> isAuthenticated();

  Future<AuthSession?> getCurrentSession();
}

