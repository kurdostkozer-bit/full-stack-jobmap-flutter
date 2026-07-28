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
      body: {
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
      body: {
        'fullName': fullName,
        'email': email,
        'password': password,
        'phone': phone,
      },
    );

    return AuthSessionModel.fromJson(response);
  }

  @override
  Future<AuthSessionModel> refreshSession(
    String refreshToken,
  ) async {
    final response = await apiClient.post(
      '/auth/refresh',
      body: {
        'refreshToken': refreshToken,
      },
    );

    return AuthSessionModel.fromJson(response);
  }

  @override
  Future<void> logout() async {
    await apiClient.post(
      '/auth/logout',
      body: {},
    );
  }
}