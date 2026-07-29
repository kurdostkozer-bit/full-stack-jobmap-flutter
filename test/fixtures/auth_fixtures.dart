import 'package:jobmap/features/auth/data/models/auth_models.dart';

/// Auth test fixtures
class AuthFixtures {
  static const String testEmail = 'test@example.com';
  static const String testPassword = 'Test@123456';
  static const String testFirstName = 'John';
  static const String testLastName = 'Doe';
  static const String testToken = 'test-token-123';
  static const String testRefreshToken = 'test-refresh-token-456';

  static final testUserResponse = UserResponse(
    id: 'user-123',
    email: testEmail,
    firstName: testFirstName,
    lastName: testLastName,
    profileImage: null,
    bio: null,
    emailVerified: true,
    createdAt: DateTime.now(),
  );

  static final testAuthResponse = AuthResponse(
    token: testToken,
    refreshToken: testRefreshToken,
    user: testUserResponse,
  );

  static final testLoginRequest = LoginRequest(
    email: testEmail,
    password: testPassword,
  );

  static final testRegisterRequest = RegisterRequest(
    email: testEmail,
    password: testPassword,
    firstName: testFirstName,
    lastName: testLastName,
  );

  static final testVerifyEmailRequest = VerifyEmailRequest(
    email: testEmail,
    code: '123456',
  );

  static final testForgotPasswordRequest = ForgotPasswordRequest(
    email: testEmail,
  );

  static final testResetPasswordRequest = ResetPasswordRequest(
    email: testEmail,
    code: '123456',
    newPassword: 'NewPass@123456',
  );
}
