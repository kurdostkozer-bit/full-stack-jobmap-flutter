import 'package:flutter/foundation.dart';
import '../datasources/projects_local_datasource.dart';
import '../datasources/projects_remote_datasource.dart';
import '../models/projects_models.dart';
import '../../domain/entities/projects_entities.dart';
import '../../domain/repositories/projects_repository.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsRemoteDataSource remoteDataSource;
  final ProjectsLocalDataSource localDataSource;

  ProjectsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Project>> getProjects(String careerProfileId) async {
    try {
      // Try to get from remote (API)
      final responses = await remoteDataSource.getProjects(careerProfileId);

      // Cache locally
      await localDataSource.cacheProjects(careerProfileId, responses);

      // Convert to domain entities
      return responses.map((r) => r.toDomain()).toList();
    } catch (e) {
      // If remote fails, try to get from cache
      final cached = await localDataSource.getCachedProjects(careerProfileId);
      if (cached != null) {
        return cached.map((r) => r.toDomain()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<Project> createProject(
    String careerProfileId,
    String title,
    List<String> technologies, {
    String? description,
    String? role,
    DateTime? startDate,
    DateTime? endDate,
    bool isCurrently = false,
    String? imageUrl,
  }) async {
    try {
      final request = CreateProjectRequest(
        title: title,
        description: description,
        role: role,
        technologies: technologies,
        startDate: startDate,
        endDate: endDate,
        isCurrently: isCurrently,
        imageUrl: imageUrl,
      );

      final response = await remoteDataSource.createProject(
        careerProfileId,
        request.toJson(),
      );

      // Invalidate cache
      await localDataSource.clearProjects(careerProfileId);

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Project> updateProject(
    String projectId, {
    String? title,
    String? description,
    String? role,
    List<String>? technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrently,
    String? imageUrl,
  }) async {
    try {
      final request = UpdateProjectRequest(
        title: title,
        description: description,
        role: role,
        technologies: technologies,
        startDate: startDate,
        endDate: endDate,
        isCurrently: isCurrently,
        imageUrl: imageUrl,
      );

      final response = await remoteDataSource.updateProject(
        projectId,
        request.toApiJson(),
      );

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteProject(String projectId) async {
    try {
      await remoteDataSource.deleteProject(projectId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Project>?> getCachedProjects(String careerProfileId) async {
    try {
      final cached =
          await localDataSource.getCachedProjects(careerProfileId);
      return cached?.map((r) => r.toDomain()).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCachedProjects(String careerProfileId) async {
    try {
      await localDataSource.clearProjects(careerProfileId);
    } catch (e) {
      debugPrint('Error clearing cached projects: $e');
    }
  }
}
