import '../../domain/entities/career_profile.dart';
import '../../domain/repositories/career_profile_repository.dart';
import '../datasources/career_profile_remote_data_source.dart';
import '../models/career_profile_model.dart';

class CareerProfileRepositoryImpl
    implements CareerProfileRepository {
  final CareerProfileRemoteDataSource remoteDataSource;

  const CareerProfileRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<CareerProfile?> getCareerProfile(
    String userId,
  ) {
    return remoteDataSource.getCareerProfile(userId);
  }

  @override
  Future<void> createCareerProfile(
    CareerProfile profile,
  ) {
    return remoteDataSource.createCareerProfile(
      CareerProfileModel(
        id: profile.id,
        userId: profile.userId,
        firstName: profile.firstName,
        lastName: profile.lastName,
        headline: profile.headline,
        about: profile.about,
        country: profile.country,
        city: profile.city,
        phone: profile.phone,
        email: profile.email,
        profileImage: profile.profileImage,
        isProfileActivated: profile.isProfileActivated,
        createdAt: profile.createdAt,
        updatedAt: profile.updatedAt,
      ),
    );
  }

  @override
  Future<void> updateCareerProfile(
    CareerProfile profile,
  ) {
    return remoteDataSource.updateCareerProfile(
      CareerProfileModel(
        id: profile.id,
        userId: profile.userId,
        firstName: profile.firstName,
        lastName: profile.lastName,
        headline: profile.headline,
        about: profile.about,
        country: profile.country,
        city: profile.city,
        phone: profile.phone,
        email: profile.email,
        profileImage: profile.profileImage,
        isProfileActivated: profile.isProfileActivated,
        createdAt: profile.createdAt,
        updatedAt: profile.updatedAt,
      ),
    );
  }

  @override
  Future<void> deleteCareerProfile(
    String careerProfileId,
  ) {
    return remoteDataSource.deleteCareerProfile(
      careerProfileId,
    );
  }

  @override
  Future<void> activateCareerProfile(
    String careerProfileId,
  ) {
    return remoteDataSource.activateCareerProfile(
      careerProfileId,
    );
  }

  @override
  Future<bool> exists(
    String userId,
  ) {
    return remoteDataSource.exists(userId);
  }
}
