import '../entities/profile_entities.dart';

/// Abstract repository for career profile operations
abstract class ProfileRepository {
  /// Get current user's career profile
  Future<CareerProfile> getProfile();

  /// Update career profile
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
  });

  /// Get cached profile (local storage)
  Future<CareerProfile?> getCachedProfile();

  /// Clear cached profile
  Future<void> clearCachedProfile();
}

