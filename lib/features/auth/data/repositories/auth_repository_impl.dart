import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final session = await remoteDataSource.login(
      email: email,
      password: password,
    );

    await localDataSource.saveSession(session);

    return session;
  }

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

    await localDataSource.saveSession(session);

    return session;
  }

  @override
  Future<AuthSession> refreshSession(
    String refreshToken,
  ) async {
    final session = await remoteDataSource.refreshSession(
      refreshToken,
    );

    await localDataSource.saveSession(session);

    return session;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.clearSession();
  }

  @override
  Future<AuthSession?> getCurrentSession() async {
    return await localDataSource.getSession();
  }

  @override
  Future<bool> isAuthenticated() async {
    return await localDataSource.hasSession();
  }
}