import '../../domain/entities/job_preference_entities.dart';
import '../../domain/repositories/job_preference_repository.dart';
import '../datasources/job_preference_local_datasource.dart';
import '../datasources/job_preference_remote_datasource.dart';
import '../models/job_preference_models.dart';

class JobPreferenceRepositoryImpl implements JobPreferenceRepository {
  final JobPreferenceRemoteDataSource remoteDataSource;
  final JobPreferenceLocalDataSource localDataSource;

  JobPreferenceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<JobPreferenceEntity> createJobPreference(
    JobPreferenceEntity preference,
  ) async {
    final dto = CreateJobPreferenceDto.fromEntity(preference);
    final model = await remoteDataSource.createJobPreference(dto);
    return model.toEntity();
  }

  @override
  Future<JobPreferenceEntity?> getJobPreference(String careerProfileId) async {
    try {
      final model = await remoteDataSource.getJobPreference(careerProfileId);
      if (model != null) {
        await localDataSource.cacheJobPreference(careerProfileId, model);
        return model.toEntity();
      }
      return null;
    } catch (e) {
      // Try to get cached data on error
      final cached = await localDataSource.getCachedJobPreference(
        careerProfileId,
      );
      return cached?.toEntity();
    }
  }

  @override
  Future<JobPreferenceEntity?> getJobPreferenceById(String id) async {
    try {
      final model = await remoteDataSource.getJobPreferenceById(id);
      return model?.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<JobPreferenceEntity> updateJobPreference(
    String id,
    JobPreferenceEntity preference,
  ) async {
    final updateDto = UpdateJobPreferenceDto(
      jobTitles: preference.jobTitles,
      industries: preference.industries,
      workEnvironments: preference.workEnvironments,
      employmentTypes: preference.employmentTypes,
      locations: preference.locations,
      minSalary: preference.minSalary,
      maxSalary: preference.maxSalary,
      salaryCurrency: preference.salaryCurrency,
      isActive: preference.isActive,
    );
    final model = await remoteDataSource.updateJobPreference(id, updateDto);
    return model.toEntity();
  }

  @override
  Future<void> deleteJobPreference(String id) async {
    await remoteDataSource.deleteJobPreference(id);
    await localDataSource.clearCache();
  }
}
