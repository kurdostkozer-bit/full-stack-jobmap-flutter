import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/languages_models.dart';

abstract class LanguagesLocalDataSource {
  /// Cache languages locally
  Future<void> cacheLanguages(
    String careerProfileId,
    List<LanguageResponse> languages,
  );

  /// Get cached languages
  Future<List<LanguageResponse>?> getCachedLanguages(String careerProfileId);

  /// Clear cached languages
  Future<void> clearLanguages(String careerProfileId);
}

class LanguagesLocalDataSourceImpl implements LanguagesLocalDataSource {
  final FlutterSecureStorage secureStorage;

  LanguagesLocalDataSourceImpl({required this.secureStorage});

  String _getKey(String careerProfileId) => 'languages_$careerProfileId';

  @override
  Future<void> cacheLanguages(
    String careerProfileId,
    List<LanguageResponse> languages,
  ) async {
    try {
      final json = languages.map((e) => e.toJson()).toList();
      await secureStorage.write(
        key: _getKey(careerProfileId),
        value: jsonEncode(json),
      );
    } catch (e) {
      debugPrint('Error caching languages: $e');
      rethrow;
    }
  }

  @override
  Future<List<LanguageResponse>?> getCachedLanguages(
    String careerProfileId,
  ) async {
    try {
      final json = await secureStorage.read(key: _getKey(careerProfileId));
      if (json != null) {
        final list = jsonDecode(json) as List;
        return list
            .map((item) =>
                LanguageResponse.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error reading cached languages: $e');
    }
    return null;
  }

  @override
  Future<void> clearLanguages(String careerProfileId) async {
    try {
      await secureStorage.delete(key: _getKey(careerProfileId));
    } catch (e) {
      debugPrint('Error clearing languages: $e');
    }
  }
}
