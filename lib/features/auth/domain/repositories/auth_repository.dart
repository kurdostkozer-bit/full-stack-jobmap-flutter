import '../../data/models/auth_models.dart';

abstract class AuthRepository {
  Future<AuthResponse> register(
    String email,
    String password,
    String firstName,
    String lastName,
  );

  Future<void> verifyEmail(String email, String code);

  Future<AuthResponse> login(String email, String password);

  Future<UserResponse> getCurrentUser();

  Future<void> logout();

  Future<void> forgotPassword(String email);

  Future<void> resetPassword(String email, String code, String newPassword);

  Future<AuthResponse> refreshToken(String refreshToken);

  Future<bool> isUserAuthenticated();

  Future<AuthResponse?> getCachedAuthResponse();

  Future<UserResponse?> getCachedUser();
}
