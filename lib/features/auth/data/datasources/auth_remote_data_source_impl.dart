import '../../../../core/network/api_client.dart';
import '../models/auth_session_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  const AuthRemoteDataSourceImpl({
    required this.apiClient,
  });

  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    return AuthSessionModel.fromJson(response);
  }

  @override
  Future<AuthSessionModel> register({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) async {
    final response = await apiClient.post(
      '/auth/register',
      data: {
        'fullName': fullName,
        'email': email,
        'password': password,
        ...?phone != null ? {'phone': phone} : null,
      },
    );

    return AuthSessionModel.fromJson(response);
  }

  @override
  Future<AuthSessionModel> socialLogin({
    required String idToken,
  }) async {
    final response = await apiClient.post(
      '/auth/social/google',
      data: {
        'idToken': idToken,
      },
    );

    return AuthSessionModel.fromJson(response);
  }

  @override
  Future<void> verifyEmail({
    required String email,
    required String code,
  }) async {
    await apiClient.post(
      '/auth/verify-email',
      data: {
        'email': email,
        'code': code,
      },
    );
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await apiClient.post(
      '/auth/request-password-reset',
      data: {
        'email': email,
      },
    );
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    await apiClient.post(
      '/auth/reset-password',
      data: {
        'email': email,
        'code': code,
        'newPassword': newPassword,
      },
    );
  }

  @override
  Future<AuthSessionModel> refreshSession(
    String refreshToken,
  ) async {
    final response = await apiClient.post(
      '/auth/refresh-token',
      data: {
        'refreshToken': refreshToken,
      },
    );

    return AuthSessionModel.fromJson(response);
  }

  @override
  Future<void> logout() async {
    await apiClient.post(
      '/auth/logout',
      data: const {},
    );
  }
}
