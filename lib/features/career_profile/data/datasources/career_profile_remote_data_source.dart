import '../models/career_profile_model.dart';

abstract class CareerProfileRemoteDataSource {
  Future<CareerProfileModel?> getCareerProfile(
    String userId,
  );

  Future<void> createCareerProfile(
    CareerProfileModel profile,
  );

  Future<void> updateCareerProfile(
    CareerProfileModel profile,
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