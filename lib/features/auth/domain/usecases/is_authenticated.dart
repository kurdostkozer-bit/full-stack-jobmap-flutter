import '../repositories/auth_repository.dart';

class IsAuthenticated {
  final AuthRepository repository;

  const IsAuthenticated(this.repository);

  Future<bool> call() {
    return repository.isAuthenticated();
  }
}