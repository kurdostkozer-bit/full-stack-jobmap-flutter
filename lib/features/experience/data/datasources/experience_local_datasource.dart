import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/experience_models.dart';

abstract class ExperienceLocalDataSource {
  /// Cache experiences locally
  Future<void> cacheExperiences(
    String careerProfileId,
    List<ExperienceResponse> experiences,
  );

  /// Get cached experiences
  Future<List<ExperienceResponse>?> getCachedExperiences(String careerProfileId);

  /// Clear cached experiences
  Future<void> clearExperiences(String careerProfileId);
}

class ExperienceLocalDataSourceImpl implements ExperienceLocalDataSource {
  final FlutterSecureStorage secureStorage;

  ExperienceLocalDataSourceImpl({required this.secureStorage});

  String _getKey(String careerProfileId) => 'experience_$careerProfileId';

  @override
  Future<void> cacheExperiences(
    String careerProfileId,
    List<ExperienceResponse> experiences,
  ) async {
    try {
      final json = experiences.map((e) => e.toJson()).toList();
      await secureStorage.write(
        key: _getKey(careerProfileId),
        value: jsonEncode(json),
      );
    } catch (e) {
      print('Error caching experiences: $e');
      rethrow;
    }
  }

  @override
  Future<List<ExperienceResponse>?> getCachedExperiences(
    String careerProfileId,
  ) async {
    try {
      final json = await secureStorage.read(key: _getKey(careerProfileId));
      if (json != null) {
        final list = jsonDecode(json) as List;
        return list
            .map((item) =>
                ExperienceResponse.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Error reading cached experiences: $e');
    }
    return null;
  }

  @override
  Future<void> clearExperiences(String careerProfileId) async {
    try {
      await secureStorage.delete(key: _getKey(careerProfileId));
    } catch (e) {
      print('Error clearing experiences: $e');
    }
  }
}
