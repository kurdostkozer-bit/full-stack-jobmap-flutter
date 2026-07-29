import 'package:flutter/foundation.dart';
import '../datasources/experience_local_datasource.dart';
import '../datasources/experience_remote_datasource.dart';
import '../models/experience_models.dart';
import '../../domain/entities/experience_entities.dart';
import '../../domain/repositories/experience_repository.dart';

class ExperienceRepositoryImpl implements ExperienceRepository {
  final ExperienceRemoteDataSource remoteDataSource;
  final ExperienceLocalDataSource localDataSource;

  ExperienceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Experience>> getExperiences(String careerProfileId) async {
    try {
      // Try to get from remote (API)
      final responses = await remoteDataSource.getExperiences(careerProfileId);

      // Cache locally
      await localDataSource.cacheExperiences(careerProfileId, responses);

      // Convert to domain entities
      return responses.map((r) => r.toDomain()).toList();
    } catch (e) {
      // If remote fails, try to get from cache
      final cached = await localDataSource.getCachedExperiences(careerProfileId);
      if (cached != null) {
        return cached.map((r) => r.toDomain()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<Experience> createExperience(
    String careerProfileId,
    String jobTitle,
    String companyName,
    String location,
    DateTime startDate, {
    DateTime? endDate,
    bool isCurrent = false,
    String? description,
    String? companyWebsite,
  }) async {
    try {
      final request = CreateExperienceRequest(
        jobTitle: jobTitle,
        companyName: companyName,
        companyWebsite: companyWebsite,
        location: location,
        startDate: startDate,
        endDate: endDate,
        isCurrent: isCurrent,
        description: description,
      );

      final response = await remoteDataSource.createExperience(
        careerProfileId,
        request.toJson(),
      );

      // Invalidate cache
      await localDataSource.clearExperiences(careerProfileId);

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Experience> updateExperience(
    String experienceId, {
    String? jobTitle,
    String? companyName,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
  }) async {
    try {
      final request = UpdateExperienceRequest(
        jobTitle: jobTitle,
        companyName: companyName,
        location: location,
        startDate: startDate,
        endDate: endDate,
        isCurrent: isCurrent,
        description: description,
      );

      final response = await remoteDataSource.updateExperience(
        experienceId,
        request.toApiJson(),
      );

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteExperience(String experienceId) async {
    try {
      await remoteDataSource.deleteExperience(experienceId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Experience>?> getCachedExperiences(String careerProfileId) async {
    try {
      final cached =
          await localDataSource.getCachedExperiences(careerProfileId);
      return cached?.map((r) => r.toDomain()).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCachedExperiences(String careerProfileId) async {
    try {
      await localDataSource.clearExperiences(careerProfileId);
    } catch (e) {
      debugPrint('Error clearing cached experiences: $e');
    }
  }
}
