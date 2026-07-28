import '../repositories/career_profile_repository.dart';

class ActivateCareerProfile {
  final CareerProfileRepository repository;

  const ActivateCareerProfile(this.repository);

  Future<void> call(String careerProfileId) {
    return repository.activateCareerProfile(careerProfileId);
  }
}