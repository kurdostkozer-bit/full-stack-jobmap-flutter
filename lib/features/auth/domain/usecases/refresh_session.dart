import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class RefreshSession {
  final AuthRepository repository;

  const RefreshSession(this.repository);

  Future<AuthSession> call(String refreshToken) {
    return repository.refreshSession(refreshToken);
  }
}