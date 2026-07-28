import '../entities/career_profile.dart';
import '../repositories/career_profile_repository.dart';

class CreateCareerProfile {
  final CareerProfileRepository repository;

  const CreateCareerProfile(this.repository);

  Future<void> call(CareerProfile profile) {
    return repository.createCareerProfile(profile);
  }
}