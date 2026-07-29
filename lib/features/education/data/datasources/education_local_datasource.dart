import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/education_models.dart';

abstract class EducationLocalDataSource {
  /// Cache educations locally
  Future<void> cacheEducations(
    String careerProfileId,
    List<EducationResponse> educations,
  );

  /// Get cached educations
  Future<List<EducationResponse>?> getCachedEducations(String careerProfileId);

  /// Clear cached educations
  Future<void> clearEducations(String careerProfileId);
}

class EducationLocalDataSourceImpl implements EducationLocalDataSource {
  final FlutterSecureStorage secureStorage;

  EducationLocalDataSourceImpl({required this.secureStorage});

  String _getKey(String careerProfileId) => 'education_$careerProfileId';

  @override
  Future<void> cacheEducations(
    String careerProfileId,
    List<EducationResponse> educations,
  ) async {
    try {
      final json = educations.map((e) => e.toJson()).toList();
      await secureStorage.write(
        key: _getKey(careerProfileId),
        value: jsonEncode(json),
      );
    } catch (e) {
      print('Error caching educations: $e');
      rethrow;
    }
  }

  @override
  Future<List<EducationResponse>?> getCachedEducations(
    String careerProfileId,
  ) async {
    try {
      final json = await secureStorage.read(key: _getKey(careerProfileId));
      if (json != null) {
        final list = jsonDecode(json) as List;
        return list
            .map((item) =>
                EducationResponse.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Error reading cached educations: $e');
    }
    return null;
  }

  @override
  Future<void> clearEducations(String careerProfileId) async {
    try {
      await secureStorage.delete(key: _getKey(careerProfileId));
    } catch (e) {
      print('Error clearing educations: $e');
    }
  }
}
