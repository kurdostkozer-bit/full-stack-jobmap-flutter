import 'package:flutter/foundation.dart';
import '../datasources/skill_local_datasource.dart';
import '../datasources/skill_remote_datasource.dart';
import '../models/skill_models.dart';
import '../../domain/entities/skill_entities.dart';
import '../../domain/repositories/skill_repository.dart';

class SkillRepositoryImpl implements SkillRepository {
  final SkillRemoteDataSource remoteDataSource;
  final SkillLocalDataSource localDataSource;

  SkillRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Skill>> getSkills(String careerProfileId) async {
    try {
      // Try to get from remote (API)
      final responses = await remoteDataSource.getSkills(careerProfileId);

      // Cache locally
      await localDataSource.cacheSkills(careerProfileId, responses);

      // Convert to domain entities
      return responses.map((r) => r.toDomain()).toList();
    } catch (e) {
      // If remote fails, try to get from cache
      final cached = await localDataSource.getCachedSkills(careerProfileId);
      if (cached != null) {
        return cached.map((r) => r.toDomain()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<Skill> createSkill(
    String careerProfileId,
    String name,
    int proficiency, {
    String? description,
  }) async {
    try {
      final request = CreateSkillRequest(
        name: name,
        proficiency: proficiency,
        description: description,
      );

      final response = await remoteDataSource.createSkill(
        careerProfileId,
        request.toJson(),
      );

      // Invalidate cache by clearing it
      await localDataSource.clearSkills(careerProfileId);

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Skill> updateSkill(
    String skillId, {
    String? name,
    int? proficiency,
    String? description,
  }) async {
    try {
      final request = UpdateSkillRequest(
        name: name,
        proficiency: proficiency,
        description: description,
      );

      final response = await remoteDataSource.updateSkill(
        skillId,
        request.toApiJson(),
      );

      // Note: We should invalidate cache but we don't have careerProfileId here
      // This will be handled by the BLoC/UI layer

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteSkill(String skillId) async {
    try {
      await remoteDataSource.deleteSkill(skillId);
      // Cache invalidation handled by BLoC
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Skill>?> getCachedSkills(String careerProfileId) async {
    try {
      final cached = await localDataSource.getCachedSkills(careerProfileId);
      return cached?.map((r) => r.toDomain()).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCachedSkills(String careerProfileId) async {
    try {
      await localDataSource.clearSkills(careerProfileId);
    } catch (e) {
      debugPrint('Error clearing cached skills: $e');
    }
  }
}
