import '../repositories/career_profile_repository.dart';

class DeleteCareerProfile {
  final CareerProfileRepository repository;

  const DeleteCareerProfile(this.repository);

  Future<void> call(String careerProfileId) {
    return repository.deleteCareerProfile(careerProfileId);
  }
}