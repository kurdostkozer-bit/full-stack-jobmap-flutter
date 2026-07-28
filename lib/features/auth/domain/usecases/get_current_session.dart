import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class GetCurrentSession {
  final AuthRepository repository;

  const GetCurrentSession(this.repository);

  Future<AuthSession?> call() {
    return repository.getCurrentSession();
  }
}