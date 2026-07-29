import '../../domain/entities/attachment_entities.dart';
import '../../domain/repositories/attachment_repository.dart';
import '../datasources/attachment_local_datasource.dart';
import '../datasources/attachment_remote_datasource.dart';
import '../models/attachment_models.dart';

class AttachmentRepositoryImpl implements AttachmentRepository {
  final AttachmentRemoteDataSource remoteDataSource;
  final AttachmentLocalDataSource localDataSource;

  AttachmentRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AttachmentEntity> uploadAttachment(AttachmentEntity attachment) async {
    final dto = CreateAttachmentDto.fromEntity(attachment);
    final model = await remoteDataSource.uploadAttachment(dto);
    return model.toEntity();
  }

  @override
  Future<List<AttachmentEntity>> getAttachments({
    required String careerProfileId,
    AttachmentCategory? category,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final models = await remoteDataSource.getAttachments(
        careerProfileId: careerProfileId,
        category: category?.value,
        page: page,
        limit: limit,
      );
      await localDataSource.cacheAttachments(careerProfileId, models);
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      // Try to get cached data on error
      final cached = await localDataSource.getCachedAttachments(
        careerProfileId,
      );
      if (cached != null) {
        return cached.map((m) => m.toEntity()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<AttachmentEntity?> getAttachmentById(String id) async {
    try {
      final model = await remoteDataSource.getAttachmentById(id);
      return model?.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<AttachmentEntity>> getAttachmentsByCareerProfileId(
    String careerProfileId,
  ) async {
    try {
      final models = await remoteDataSource.getAttachments(
        careerProfileId: careerProfileId,
      );
      await localDataSource.cacheAttachments(careerProfileId, models);
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      // Try to get cached data on error
      final cached = await localDataSource.getCachedAttachments(
        careerProfileId,
      );
      if (cached != null) {
        return cached.map((m) => m.toEntity()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<AttachmentEntity> updateAttachment(
    String id,
    AttachmentEntity attachment,
  ) async {
    final updateDto = UpdateAttachmentDto(
      description: attachment.description,
      isPrimary: attachment.isPrimary,
    );
    final model = await remoteDataSource.updateAttachment(id, updateDto);
    return model.toEntity();
  }

  @override
  Future<AttachmentEntity> setPrimaryResume(String attachmentId) async {
    final model = await remoteDataSource.setPrimaryResume(attachmentId);
    return model.toEntity();
  }

  @override
  Future<void> deleteAttachment(String id) async {
    await remoteDataSource.deleteAttachment(id);
    await localDataSource.clearCache();
  }

  @override
  Future<void> deleteAttachmentsByCareerProfileId(
    String careerProfileId,
  ) async {
    await localDataSource.clearCache();
  }
}
