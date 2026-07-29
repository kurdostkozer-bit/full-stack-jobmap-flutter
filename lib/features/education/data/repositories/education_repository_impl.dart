import '../datasources/education_local_datasource.dart';
import '../datasources/education_remote_datasource.dart';
import '../models/education_models.dart';
import '../../domain/entities/education_entities.dart';
import '../../domain/repositories/education_repository.dart';

class EducationRepositoryImpl implements EducationRepository {
  final EducationRemoteDataSource remoteDataSource;
  final EducationLocalDataSource localDataSource;

  EducationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Education>> getEducations(String careerProfileId) async {
    try {
      // Try to get from remote (API)
      final responses = await remoteDataSource.getEducations(careerProfileId);

      // Cache locally
      await localDataSource.cacheEducations(careerProfileId, responses);

      // Convert to domain entities
      return responses.map((r) => r.toDomain()).toList();
    } catch (e) {
      // If remote fails, try to get from cache
      final cached = await localDataSource.getCachedEducations(careerProfileId);
      if (cached != null) {
        return cached.map((r) => r.toDomain()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<Education> createEducation(
    String careerProfileId,
    String school,
    String degree, {
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool currentlyStudying = false,
    String? description,
  }) async {
    try {
      final request = CreateEducationRequest(
        school: school,
        degree: degree,
        fieldOfStudy: fieldOfStudy,
        startDate: startDate,
        endDate: endDate,
        currentlyStudying: currentlyStudying,
        description: description,
      );

      final response = await remoteDataSource.createEducation(
        careerProfileId,
        request.toJson(),
      );

      // Invalidate cache
      await localDataSource.clearEducations(careerProfileId);

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Education> updateEducation(
    String educationId, {
    String? school,
    String? degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool? currentlyStudying,
    String? description,
  }) async {
    try {
      final request = UpdateEducationRequest(
        school: school,
        degree: degree,
        fieldOfStudy: fieldOfStudy,
        startDate: startDate,
        endDate: endDate,
        currentlyStudying: currentlyStudying,
        description: description,
      );

      final response = await remoteDataSource.updateEducation(
        educationId,
        request.toApiJson(),
      );

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteEducation(String educationId) async {
    try {
      await remoteDataSource.deleteEducation(educationId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Education>?> getCachedEducations(String careerProfileId) async {
    try {
      final cached =
          await localDataSource.getCachedEducations(careerProfileId);
      return cached?.map((r) => r.toDomain()).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCachedEducations(String careerProfileId) async {
    try {
      await localDataSource.clearEducations(careerProfileId);
    } catch (e) {
      print('Error clearing cached educations: $e');
    }
  }
}
