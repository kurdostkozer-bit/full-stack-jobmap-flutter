import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_models.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/auth_entities.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthResponse> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    final request = RegisterRequest(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    final response = await remoteDataSource.register(request);
    await localDataSource.saveAuthResponse(response);
    return response;
  }

  @override
  Future<void> verifyEmail(String email, String code) async {
    final request = VerifyEmailRequest(email: email, code: code);
    await remoteDataSource.verifyEmail(request);
  }

  @override
  Future<AuthResponse> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final response = await remoteDataSource.login(request);
    await localDataSource.saveAuthResponse(response);
    return response;
  }

  @override
  Future<UserResponse> getCurrentUser() async {
    return await remoteDataSource.getCurrentUser();
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.clearAuth();
  }

  @override
  Future<void> forgotPassword(String email) async {
    final request = ForgotPasswordRequest(email: email);
    await remoteDataSource.forgotPassword(request);
  }

  @override
  Future<void> resetPassword(String email, String code, String newPassword) async {
    final request = ResetPasswordRequest(
      email: email,
      code: code,
      newPassword: newPassword,
    );
    await remoteDataSource.resetPassword(request);
  }

  @override
  Future<AuthResponse> refreshToken(String refreshToken) async {
    final response = await remoteDataSource.refreshToken(refreshToken);
    await localDataSource.saveAuthResponse(response);
    return response;
  }

  @override
  Future<bool> isUserAuthenticated() async {
    return await localDataSource.hasValidToken();
  }

  @override
  Future<AuthResponse?> getCachedAuthResponse() async {
    return await localDataSource.getAuthResponse();
  }

  @override
  Future<UserResponse?> getCachedUser() async {
    return await localDataSource.getCachedUser();
  }
}
