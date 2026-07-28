import '../entities/career_profile.dart';
import '../repositories/career_profile_repository.dart';

class GetCareerProfile {
  final CareerProfileRepository repository;

  const GetCareerProfile(this.repository);

  Future<CareerProfile?> call(String userId) {
    return repository.getCareerProfile(userId);
  }
}