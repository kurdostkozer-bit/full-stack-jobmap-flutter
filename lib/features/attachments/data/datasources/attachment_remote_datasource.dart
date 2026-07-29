import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/network/api_client.dart';
import '../models/attachment_models.dart';

abstract class AttachmentRemoteDataSource {
  Future<AttachmentModel> uploadAttachment(CreateAttachmentDto dto);
  Future<List<AttachmentModel>> getAttachments({
    required String careerProfileId,
    String? category,
    int page = 1,
    int limit = 20,
  });
  Future<AttachmentModel?> getAttachmentById(String id);
  Future<AttachmentModel> updateAttachment(
    String id,
    UpdateAttachmentDto dto,
  );
  Future<AttachmentModel> setPrimaryResume(String attachmentId);
  Future<void> deleteAttachment(String id);
}

class AttachmentRemoteDataSourceImpl implements AttachmentRemoteDataSource {
  final ApiClient apiClient;
  final FlutterSecureStorage secureStorage;

  AttachmentRemoteDataSourceImpl({
    required this.apiClient,
    required this.secureStorage,
  });

  @override
  Future<AttachmentModel> uploadAttachment(CreateAttachmentDto dto) async {
    try {
      final response = await apiClient.post(
        '/attachments',
        data: dto.toJson(),
      );
      return AttachmentModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AttachmentModel>> getAttachments({
    required String careerProfileId,
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await apiClient.get(
        '/career-profiles/$careerProfileId/attachments',
        queryParameters: {
          ...?category != null ? {'category': category} : null,
          'page': page,
          'limit': limit,
        },
      );
      final List<dynamic> data = response.data['data'] ?? response.data;
      return data
          .map((item) => AttachmentModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AttachmentModel?> getAttachmentById(String id) async {
    try {
      final response = await apiClient.get('/attachments/$id');
      return AttachmentModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AttachmentModel> updateAttachment(
    String id,
    UpdateAttachmentDto dto,
  ) async {
    try {
      final response = await apiClient.patch(
        '/attachments/$id',
        data: dto.toJson(),
      );
      return AttachmentModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AttachmentModel> setPrimaryResume(String attachmentId) async {
    try {
      final response = await apiClient.patch(
        '/attachments/$attachmentId/set-primary',
      );
      return AttachmentModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAttachment(String id) async {
    try {
      await apiClient.delete('/attachments/$id');
    } catch (e) {
      rethrow;
    }
  }
}
