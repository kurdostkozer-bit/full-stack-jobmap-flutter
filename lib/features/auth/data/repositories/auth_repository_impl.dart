import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/auth_session.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthSession> register({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) async {
    final session = await remoteDataSource.register(
      fullName: fullName,
      email: email,
      password: password,
      phone: phone,
    );
    await localDataSource.saveAuthSession(session);
    return session;
  }

  @override
  Future<void> verifyEmail({
    required String email,
    required String code,
  }) async {
    await remoteDataSource.verifyEmail(email: email, code: code);
  }

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final session = await remoteDataSource.login(
      email: email,
      password: password,
    );
    await localDataSource.saveAuthSession(session);
    return session;
  }

  @override
  Future<AuthSession?> socialLogin({
    required String idToken,
  }) async {
    final session = await remoteDataSource.socialLogin(
      idToken: idToken,
    );
    if (session != null) {
      await localDataSource.saveAuthSession(session);
    }
    return session;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.clearAuth();
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await remoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    await remoteDataSource.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
  }

  @override
  Future<AuthSession> refreshSession({required String refreshToken}) async {
    final session = await remoteDataSource.refreshSession(refreshToken);
    await localDataSource.saveAuthSession(session);
    return session;
  }

  @override
  Future<bool> isAuthenticated() async {
    return await localDataSource.hasValidToken();
  }

  @override
  Future<AuthSession?> getCurrentSession() async {
    return await localDataSource.getAuthSession();
  }
}
