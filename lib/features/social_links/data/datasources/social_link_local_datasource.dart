import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/social_link_models.dart';

abstract class SocialLinkLocalDataSource {
  Future<void> cacheSocialLinks(
    String careerProfileId,
    List<SocialLinkModel> links,
  );
  Future<List<SocialLinkModel>?> getCachedSocialLinks(String careerProfileId);
  Future<void> clearCache();
}

class SocialLinkLocalDataSourceImpl implements SocialLinkLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String _cacheKeyPrefix = 'social_links_';

  SocialLinkLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> cacheSocialLinks(
    String careerProfileId,
    List<SocialLinkModel> links,
  ) async {
    try {
      final key = '$_cacheKeyPrefix$careerProfileId';
      final json = jsonEncode(
        links.map((l) => l.toJson()).toList(),
      );
      await secureStorage.write(key: key, value: json);
    } catch (e) {
      // Silent fail on cache write
    }
  }

  @override
  Future<List<SocialLinkModel>?> getCachedSocialLinks(
    String careerProfileId,
  ) async {
    try {
      final key = '$_cacheKeyPrefix$careerProfileId';
      final cached = await secureStorage.read(key: key);
      if (cached != null) {
        final List<dynamic> data = jsonDecode(cached);
        return data
            .map((item) =>
                SocialLinkModel.fromJson(item as Map<String, dynamic>))
            .toList();
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
