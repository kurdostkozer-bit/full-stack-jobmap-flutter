import '../datasources/profile_local_datasource.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/profile_models.dart';
import '../../domain/entities/profile_entities.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<CareerProfile> getProfile() async {
    try {
      // Try to get from remote (API)
      final response = await remoteDataSource.getProfile();
      
      // Cache locally
      await localDataSource.cacheProfile(response);
      
      // Convert to domain entity
      return response.toDomain();
    } catch (e) {
      // If remote fails, try to get from cache
      final cached = await localDataSource.getCachedProfile();
      if (cached != null) {
        return cached.toDomain();
      }
      rethrow;
    }
  }

  @override
  Future<CareerProfile> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
    String? bio,
    String? headline,
    String? location,
    String? website,
    String? linkedinUrl,
    String? githubUrl,
  }) async {
    try {
      // Create request object
      final request = UpdateProfileRequest(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        profileImageUrl: profileImageUrl,
        bio: bio,
        headline: headline,
        location: location,
        website: website,
        linkedinUrl: linkedinUrl,
        githubUrl: githubUrl,
      );

      // Send to API
      final response = await remoteDataSource.updateProfile(
        request.toApiJson(),
      );

      // Cache locally
      await localDataSource.cacheProfile(response);

      // Return domain entity
      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CareerProfile?> getCachedProfile() async {
    try {
      final cached = await localDataSource.getCachedProfile();
      return cached?.toDomain();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCachedProfile() async {
    try {
      await localDataSource.clearProfile();
    } catch (e) {
      print('Error clearing cached profile: $e');
    }
  }
}
