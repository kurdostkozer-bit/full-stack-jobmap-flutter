import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  const Register(this.repository);

  Future<AuthSession> call({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) {
    return repository.register(
      fullName: fullName,
      email: email,
      password: password,
      phone: phone,
    );
  }
}