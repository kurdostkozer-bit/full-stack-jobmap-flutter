import '../../../../core/network/api_client.dart';
import '../models/auth_models.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> register(RegisterRequest request);
  Future<void> verifyEmail(VerifyEmailRequest request);
  Future<AuthResponse> login(LoginRequest request);
  Future<UserResponse> getCurrentUser();
  Future<void> logout();
  Future<void> forgotPassword(ForgotPasswordRequest request);
  Future<void> resetPassword(ResetPasswordRequest request);
  Future<AuthResponse> refreshToken(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    return await apiClient.post(
      '/auth/register',
      data: request.toJson(),
      fromJson: (json) => AuthResponse.fromJson(json),
    );
  }

  @override
  Future<void> verifyEmail(VerifyEmailRequest request) async {
    await apiClient.post(
      '/auth/verify-email',
      data: request.toJson(),
    );
  }

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    return await apiClient.post(
      '/auth/login',
      data: request.toJson(),
      fromJson: (json) => AuthResponse.fromJson(json),
    );
  }

  @override
  Future<UserResponse> getCurrentUser() async {
    return await apiClient.get(
      '/auth/me',
      fromJson: (json) => UserResponse.fromJson(json),
    );
  }

  @override
  Future<void> logout() async {
    await apiClient.post('/auth/logout');
  }

  @override
  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    await apiClient.post(
      '/auth/forgot-password',
      data: request.toJson(),
    );
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {
    await apiClient.post(
      '/auth/reset-password',
      data: request.toJson(),
    );
  }

  @override
  Future<AuthResponse> refreshToken(String refreshToken) async {
    return await apiClient.post(
      '/auth/refresh-token',
      data: {'refreshToken': refreshToken},
      fromJson: (json) => AuthResponse.fromJson(json),
    );
  }
}
