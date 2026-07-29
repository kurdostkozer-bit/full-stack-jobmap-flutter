import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/skill_models.dart';

abstract class SkillLocalDataSource {
  /// Cache skills locally
  Future<void> cacheSkills(String careerProfileId, List<SkillResponse> skills);

  /// Get cached skills
  Future<List<SkillResponse>?> getCachedSkills(String careerProfileId);

  /// Clear cached skills
  Future<void> clearSkills(String careerProfileId);
}

class SkillLocalDataSourceImpl implements SkillLocalDataSource {
  final FlutterSecureStorage secureStorage;

  SkillLocalDataSourceImpl({required this.secureStorage});

  String _getKey(String careerProfileId) => 'skills_$careerProfileId';

  @override
  Future<void> cacheSkills(
    String careerProfileId,
    List<SkillResponse> skills,
  ) async {
    try {
      final json = skills.map((s) => s.toJson()).toList();
      await secureStorage.write(
        key: _getKey(careerProfileId),
        value: jsonEncode(json),
      );
    } catch (e) {
      print('Error caching skills: $e');
      rethrow;
    }
  }

  @override
  Future<List<SkillResponse>?> getCachedSkills(String careerProfileId) async {
    try {
      final json = await secureStorage.read(key: _getKey(careerProfileId));
      if (json != null) {
        final list = jsonDecode(json) as List;
        return list
            .map((item) => SkillResponse.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Error reading cached skills: $e');
    }
    return null;
  }

  @override
  Future<void> clearSkills(String careerProfileId) async {
    try {
      await secureStorage.delete(key: _getKey(careerProfileId));
    } catch (e) {
      print('Error clearing skills: $e');
    }
  }
}
