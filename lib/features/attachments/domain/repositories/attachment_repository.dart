import '../entities/attachment_entities.dart';

abstract class AttachmentRepository {
  // Create
  Future<AttachmentEntity> uploadAttachment(AttachmentEntity attachment);

  // Read
  Future<List<AttachmentEntity>> getAttachments({
    required String careerProfileId,
    AttachmentCategory? category,
    int page = 1,
    int limit = 20,
  });

  Future<AttachmentEntity?> getAttachmentById(String id);

  Future<List<AttachmentEntity>> getAttachmentsByCareerProfileId(
    String careerProfileId,
  );

  // Update
  Future<AttachmentEntity> updateAttachment(
    String id,
    AttachmentEntity attachment,
  );

  Future<AttachmentEntity> setPrimaryResume(String attachmentId);

  // Delete
  Future<void> deleteAttachment(String id);

  Future<void> deleteAttachmentsByCareerProfileId(String careerProfileId);
}
