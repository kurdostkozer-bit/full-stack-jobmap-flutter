import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/attachment_models.dart';

abstract class AttachmentLocalDataSource {
  Future<void> cacheAttachments(
    String careerProfileId,
    List<AttachmentModel> attachments,
  );
  Future<List<AttachmentModel>?> getCachedAttachments(String careerProfileId);
  Future<void> clearCache();
}

class AttachmentLocalDataSourceImpl implements AttachmentLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String _cacheKeyPrefix = 'attachments_';

  AttachmentLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> cacheAttachments(
    String careerProfileId,
    List<AttachmentModel> attachments,
  ) async {
    try {
      final key = '$_cacheKeyPrefix$careerProfileId';
      final json = jsonEncode(
        attachments.map((a) => a.toJson()).toList(),
      );
      await secureStorage.write(key: key, value: json);
    } catch (e) {
      // Silent fail on cache write
    }
  }

  @override
  Future<List<AttachmentModel>?> getCachedAttachments(
    String careerProfileId,
  ) async {
    try {
      final key = '$_cacheKeyPrefix$careerProfileId';
      final cached = await secureStorage.read(key: key);
      if (cached != null) {
        final List<dynamic> data = jsonDecode(cached);
        return data
            .map((item) =>
                AttachmentModel.fromJson(item as Map<String, dynamic>))
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
