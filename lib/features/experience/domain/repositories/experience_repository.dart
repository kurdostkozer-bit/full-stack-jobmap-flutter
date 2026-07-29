import '../entities/experience_entities.dart';

/// Abstract repository for experience operations
abstract class ExperienceRepository {
  /// Get all experiences for a career profile
  Future<List<Experience>> getExperiences(String careerProfileId);

  /// Create a new experience
  Future<Experience> createExperience(
    String careerProfileId,
    String jobTitle,
    String companyName,
    String location,
    DateTime startDate, {
    DateTime? endDate,
    bool isCurrent = false,
    String? description,
    String? companyWebsite,
  });

  /// Update an experience
  Future<Experience> updateExperience(
    String experienceId, {
    String? jobTitle,
    String? companyName,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
  });

  /// Delete an experience
  Future<void> deleteExperience(String experienceId);

  /// Get cached experiences
  Future<List<Experience>?> getCachedExperiences(String careerProfileId);

  /// Clear cached experiences
  Future<void> clearCachedExperiences(String careerProfileId);
}
