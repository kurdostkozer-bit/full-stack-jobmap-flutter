import '../entities/profile_completion_entities.dart';

abstract class ProfileCompletionRepository {
  /// Calculate profile completion based on current data
  Future<ProfileCompletionEntity> calculateProfileCompletion(
    String careerProfileId,
  );

  /// Get cached completion status
  Future<ProfileCompletionEntity?> getProfileCompletion(
    String careerProfileId,
  );

  /// Update section completion status
  Future<void> updateSectionCompletion(
    String careerProfileId,
    CompletionSection section,
    bool isCompleted,
  );

  /// Get next recommended steps
  Future<List<String>> getNextSteps(String careerProfileId);
}
