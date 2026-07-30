import 'package:flutter/foundation.dart';
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
      debugPrint('📦 ProfileRepository: Fetching profile from remote...');
      final response = await remoteDataSource.getProfile();
      
      debugPrint('📦 ProfileRepository: Got profile response - ID: ${response.id}');
      
      // Cache locally
      await localDataSource.cacheProfile(response);
      debugPrint('📦 ProfileRepository: Profile cached locally');
      
      // Convert to domain entity
      return response.toDomain();
    } catch (e, st) {
      debugPrint('❌ ProfileRepository: Error fetching profile - $e');
      debugPrint('   StackTrace: $st');
      
      // If remote fails, try to get from cache
      try {
        debugPrint('📦 ProfileRepository: Attempting to load from cache...');
        final cached = await localDataSource.getCachedProfile();
        if (cached != null) {
          debugPrint('✅ ProfileRepository: Loaded profile from cache');
          return cached.toDomain();
        }
      } catch (cacheErr) {
        debugPrint('❌ ProfileRepository: Cache retrieval also failed - $cacheErr');
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
      debugPrint('📦 ProfileRepository: Updating profile...');
      
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

      debugPrint('📦 ProfileRepository: Profile updated - ID: ${response.id}');

      // Cache locally
      await localDataSource.cacheProfile(response);

      // Return domain entity
      return response.toDomain();
    } catch (e, st) {
      debugPrint('❌ ProfileRepository: Error updating profile - $e');
      debugPrint('   StackTrace: $st');
      rethrow;
    }
  }

  @override
  Future<CareerProfile?> getCachedProfile() async {
    try {
      final cached = await localDataSource.getCachedProfile();
      return cached?.toDomain();
    } catch (e) {
      debugPrint('❌ ProfileRepository: Error getting cached profile - $e');
      return null;
    }
  }

  @override
  Future<void> clearCachedProfile() async {
    try {
      await localDataSource.clearProfile();
      debugPrint('✅ ProfileRepository: Cached profile cleared');
    } catch (e) {
      debugPrint('❌ ProfileRepository: Error clearing cached profile - $e');
    }
  }
}
