import '../entities/experience_entities.dart';
import '../repositories/experience_repository.dart';

/// Get all experiences for a career profile
class GetExperiencesUseCase {
  final ExperienceRepository repository;

  GetExperiencesUseCase({required this.repository});

  Future<List<Experience>> call(String careerProfileId) {
    return repository.getExperiences(careerProfileId);
  }
}

/// Create a new experience
class CreateExperienceUseCase {
  final ExperienceRepository repository;

  CreateExperienceUseCase({required this.repository});

  Future<Experience> call(
    String careerProfileId,
    String jobTitle,
    String companyName,
    String location,
    DateTime startDate, {
    DateTime? endDate,
    bool isCurrent = false,
    String? description,
    String? companyWebsite,
  }) {
    return repository.createExperience(
      careerProfileId,
      jobTitle,
      companyName,
      location,
      startDate,
      endDate: endDate,
      isCurrent: isCurrent,
      description: description,
      companyWebsite: companyWebsite,
    );
  }
}

/// Update an experience
class UpdateExperienceUseCase {
  final ExperienceRepository repository;

  UpdateExperienceUseCase({required this.repository});

  Future<Experience> call(
    String experienceId, {
    String? jobTitle,
    String? companyName,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
  }) {
    return repository.updateExperience(
      experienceId,
      jobTitle: jobTitle,
      companyName: companyName,
      location: location,
      startDate: startDate,
      endDate: endDate,
      isCurrent: isCurrent,
      description: description,
    );
  }
}

/// Delete an experience
class DeleteExperienceUseCase {
  final ExperienceRepository repository;

  DeleteExperienceUseCase({required this.repository});

  Future<void> call(String experienceId) {
    return repository.deleteExperience(experienceId);
  }
}
