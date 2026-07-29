import '../entities/education_entities.dart';
import '../repositories/education_repository.dart';

/// Get all educations for a career profile
class GetEducationsUseCase {
  final EducationRepository repository;

  GetEducationsUseCase({required this.repository});

  Future<List<Education>> call(String careerProfileId) {
    return repository.getEducations(careerProfileId);
  }
}

/// Create a new education
class CreateEducationUseCase {
  final EducationRepository repository;

  CreateEducationUseCase({required this.repository});

  Future<Education> call(
    String careerProfileId,
    String school,
    String degree, {
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool currentlyStudying = false,
    String? description,
  }) {
    return repository.createEducation(
      careerProfileId,
      school,
      degree,
      fieldOfStudy: fieldOfStudy,
      startDate: startDate,
      endDate: endDate,
      currentlyStudying: currentlyStudying,
      description: description,
    );
  }
}

/// Update an education
class UpdateEducationUseCase {
  final EducationRepository repository;

  UpdateEducationUseCase({required this.repository});

  Future<Education> call(
    String educationId, {
    String? school,
    String? degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool? currentlyStudying,
    String? description,
  }) {
    return repository.updateEducation(
      educationId,
      school: school,
      degree: degree,
      fieldOfStudy: fieldOfStudy,
      startDate: startDate,
      endDate: endDate,
      currentlyStudying: currentlyStudying,
      description: description,
    );
  }
}

/// Delete an education
class DeleteEducationUseCase {
  final EducationRepository repository;

  DeleteEducationUseCase({required this.repository});

  Future<void> call(String educationId) {
    return repository.deleteEducation(educationId);
  }
}
