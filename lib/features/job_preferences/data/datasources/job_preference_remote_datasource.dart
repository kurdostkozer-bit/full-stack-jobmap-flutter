import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/network/api_client.dart';
import '../models/job_preference_models.dart';

abstract class JobPreferenceRemoteDataSource {
  Future<JobPreferenceModel> createJobPreference(CreateJobPreferenceDto dto);
  Future<JobPreferenceModel?> getJobPreference(String careerProfileId);
  Future<JobPreferenceModel?> getJobPreferenceById(String id);
  Future<JobPreferenceModel> updateJobPreference(
    String id,
    UpdateJobPreferenceDto dto,
  );
  Future<void> deleteJobPreference(String id);
}

class JobPreferenceRemoteDataSourceImpl implements JobPreferenceRemoteDataSource {
  final ApiClient apiClient;
  final FlutterSecureStorage secureStorage;

  JobPreferenceRemoteDataSourceImpl({
    required this.apiClient,
    required this.secureStorage,
  });

  @override
  Future<JobPreferenceModel> createJobPreference(CreateJobPreferenceDto dto) async {
    try {
      final response = await apiClient.post(
        '/job-preferences',
        data: dto.toJson(),
      );
      return JobPreferenceModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<JobPreferenceModel?> getJobPreference(String careerProfileId) async {
    try {
      final response = await apiClient.get(
        '/career-profiles/$careerProfileId/job-preferences',
      );
      if (response.data != null) {
        return JobPreferenceModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<JobPreferenceModel?> getJobPreferenceById(String id) async {
    try {
      final response = await apiClient.get('/job-preferences/$id');
      return JobPreferenceModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<JobPreferenceModel> updateJobPreference(
    String id,
    UpdateJobPreferenceDto dto,
  ) async {
    try {
      final response = await apiClient.patch(
        '/job-preferences/$id',
        data: dto.toJson(),
      );
      return JobPreferenceModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteJobPreference(String id) async {
    try {
      await apiClient.delete('/job-preferences/$id');
    } catch (e) {
      rethrow;
    }
  }
}
