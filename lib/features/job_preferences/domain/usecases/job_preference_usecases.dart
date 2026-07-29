import '../entities/job_preference_entities.dart';
import '../repositories/job_preference_repository.dart';

/// Get job preferences for a career profile
class GetJobPreferenceUseCase {
  final JobPreferenceRepository repository;

  GetJobPreferenceUseCase(this.repository);

  Future<JobPreferenceEntity?> call(String careerProfileId) =>
      repository.getJobPreference(careerProfileId);
}

/// Get single job preference by ID
class GetJobPreferenceByIdUseCase {
  final JobPreferenceRepository repository;

  GetJobPreferenceByIdUseCase(this.repository);

  Future<JobPreferenceEntity?> call(String id) =>
      repository.getJobPreferenceById(id);
}

/// Create job preference
class CreateJobPreferenceUseCase {
  final JobPreferenceRepository repository;

  CreateJobPreferenceUseCase(this.repository);

  Future<JobPreferenceEntity> call(JobPreferenceEntity preference) =>
      repository.createJobPreference(preference);
}

/// Update job preference
class UpdateJobPreferenceUseCase {
  final JobPreferenceRepository repository;

  UpdateJobPreferenceUseCase(this.repository);

  Future<JobPreferenceEntity> call(String id, JobPreferenceEntity preference) =>
      repository.updateJobPreference(id, preference);
}

/// Delete job preference
class DeleteJobPreferenceUseCase {
  final JobPreferenceRepository repository;

  DeleteJobPreferenceUseCase(this.repository);

  Future<void> call(String id) => repository.deleteJobPreference(id);
}
