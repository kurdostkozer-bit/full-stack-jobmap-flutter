import '../entities/job_preference_entities.dart';

abstract class JobPreferenceRepository {
  // Create
  Future<JobPreferenceEntity> createJobPreference(
    JobPreferenceEntity preference,
  );

  // Read
  Future<JobPreferenceEntity?> getJobPreference(String careerProfileId);

  Future<JobPreferenceEntity?> getJobPreferenceById(String id);

  // Update
  Future<JobPreferenceEntity> updateJobPreference(
    String id,
    JobPreferenceEntity preference,
  );

  // Delete
  Future<void> deleteJobPreference(String id);
}
