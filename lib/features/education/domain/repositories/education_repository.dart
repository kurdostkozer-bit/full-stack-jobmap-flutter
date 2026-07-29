import '../entities/education_entities.dart';

/// Abstract repository for education operations
abstract class EducationRepository {
  /// Get all educations for a career profile
  Future<List<Education>> getEducations(String careerProfileId);

  /// Create a new education
  Future<Education> createEducation(
    String careerProfileId,
    String school,
    String degree, {
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool currentlyStudying = false,
    String? description,
  });

  /// Update an education
  Future<Education> updateEducation(
    String educationId, {
    String? school,
    String? degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool? currentlyStudying,
    String? description,
  });

  /// Delete an education
  Future<void> deleteEducation(String educationId);

  /// Get cached educations
  Future<List<Education>?> getCachedEducations(String careerProfileId);

  /// Clear cached educations
  Future<void> clearCachedEducations(String careerProfileId);
}
