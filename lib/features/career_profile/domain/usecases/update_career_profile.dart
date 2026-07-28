import '../entities/career_profile.dart';
import '../repositories/career_profile_repository.dart';

class UpdateCareerProfile {
  final CareerProfileRepository repository;

  const UpdateCareerProfile(this.repository);

  Future<void> call(CareerProfile profile) {
    return repository.updateCareerProfile(profile);
  }
}