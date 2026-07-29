import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/projects_models.dart';

abstract class ProjectsLocalDataSource {
  /// Cache projects locally
  Future<void> cacheProjects(
    String careerProfileId,
    List<ProjectResponse> projects,
  );

  /// Get cached projects
  Future<List<ProjectResponse>?> getCachedProjects(String careerProfileId);

  /// Clear cached projects
  Future<void> clearProjects(String careerProfileId);
}

class ProjectsLocalDataSourceImpl implements ProjectsLocalDataSource {
  final FlutterSecureStorage secureStorage;

  ProjectsLocalDataSourceImpl({required this.secureStorage});

  String _getKey(String careerProfileId) => 'projects_$careerProfileId';

  @override
  Future<void> cacheProjects(
    String careerProfileId,
    List<ProjectResponse> projects,
  ) async {
    try {
      final json = projects.map((e) => e.toJson()).toList();
      await secureStorage.write(
        key: _getKey(careerProfileId),
        value: jsonEncode(json),
      );
    } catch (e) {
      debugPrint('Error caching projects: $e');
      rethrow;
    }
  }

  @override
  Future<List<ProjectResponse>?> getCachedProjects(
    String careerProfileId,
  ) async {
    try {
      final json = await secureStorage.read(key: _getKey(careerProfileId));
      if (json != null) {
        final list = jsonDecode(json) as List;
        return list
            .map((item) =>
                ProjectResponse.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error reading cached projects: $e');
    }
    return null;
  }

  @override
  Future<void> clearProjects(String careerProfileId) async {
    try {
      await secureStorage.delete(key: _getKey(careerProfileId));
    } catch (e) {
      debugPrint('Error clearing projects: $e');
    }
  }
}
