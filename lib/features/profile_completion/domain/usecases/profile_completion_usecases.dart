import '../entities/profile_completion_entities.dart';
import '../repositories/profile_completion_repository.dart';

/// Calculate profile completion
class CalculateProfileCompletionUseCase {
  final ProfileCompletionRepository repository;

  CalculateProfileCompletionUseCase(this.repository);

  Future<ProfileCompletionEntity> call(String careerProfileId) =>
      repository.calculateProfileCompletion(careerProfileId);
}

/// Get profile completion
class GetProfileCompletionUseCase {
  final ProfileCompletionRepository repository;

  GetProfileCompletionUseCase(this.repository);

  Future<ProfileCompletionEntity?> call(String careerProfileId) =>
      repository.getProfileCompletion(careerProfileId);
}

/// Update section completion
class UpdateSectionCompletionUseCase {
  final ProfileCompletionRepository repository;

  UpdateSectionCompletionUseCase(this.repository);

  Future<void> call(
    String careerProfileId,
    CompletionSection section,
    bool isCompleted,
  ) =>
      repository.updateSectionCompletion(careerProfileId, section, isCompleted);
}

/// Get next steps
class GetNextStepsUseCase {
  final ProfileCompletionRepository repository;

  GetNextStepsUseCase(this.repository);

  Future<List<String>> call(String careerProfileId) =>
      repository.getNextSteps(careerProfileId);
}
