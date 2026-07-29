import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/job_preference_models.dart';

abstract class JobPreferenceLocalDataSource {
  Future<void> cacheJobPreference(String careerProfileId, JobPreferenceModel preference);
  Future<JobPreferenceModel?> getCachedJobPreference(String careerProfileId);
  Future<void> clearCache();
}

class JobPreferenceLocalDataSourceImpl implements JobPreferenceLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String _cacheKeyPrefix = 'job_preference_';

  JobPreferenceLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> cacheJobPreference(
    String careerProfileId,
    JobPreferenceModel preference,
  ) async {
    try {
      final key = '$_cacheKeyPrefix$careerProfileId';
      final json = jsonEncode(preference.toJson());
      await secureStorage.write(key: key, value: json);
    } catch (e) {
      // Silent fail on cache write
    }
  }

  @override
  Future<JobPreferenceModel?> getCachedJobPreference(
    String careerProfileId,
  ) async {
    try {
      final key = '$_cacheKeyPrefix$careerProfileId';
      final cached = await secureStorage.read(key: key);
      if (cached != null) {
        return JobPreferenceModel.fromJson(jsonDecode(cached));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final allKeys = await secureStorage.readAll();
      for (final key in allKeys.keys) {
        if (key.startsWith(_cacheKeyPrefix)) {
          await secureStorage.delete(key: key);
        }
      }
    } catch (e) {
      // Silent fail
    }
  }
}
