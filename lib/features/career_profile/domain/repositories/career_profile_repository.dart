import '../entities/career_profile.dart';

abstract class CareerProfileRepository {
  Future<CareerProfile?> getCareerProfile(
    String userId,
  );

  Future<void> createCareerProfile(
    CareerProfile profile,
  );

  Future<void> updateCareerProfile(
    CareerProfile profile,
  );

  Future<void> deleteCareerProfile(
    String careerProfileId,
  );

  Future<void> activateCareerProfile(
    String careerProfileId,
  );

  Future<bool> exists(
    String userId,
  );
}