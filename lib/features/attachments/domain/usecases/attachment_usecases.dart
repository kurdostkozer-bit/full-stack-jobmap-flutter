import '../entities/attachment_entities.dart';
import '../repositories/attachment_repository.dart';

/// Get all attachments for a career profile
class GetAttachmentsUseCase {
  final AttachmentRepository repository;

  GetAttachmentsUseCase(this.repository);

  Future<List<AttachmentEntity>> call({
    required String careerProfileId,
    AttachmentCategory? category,
    int page = 1,
    int limit = 20,
  }) =>
      repository.getAttachments(
        careerProfileId: careerProfileId,
        category: category,
        page: page,
        limit: limit,
      );
}

/// Get single attachment
class GetAttachmentUseCase {
  final AttachmentRepository repository;

  GetAttachmentUseCase(this.repository);

  Future<AttachmentEntity?> call(String id) => repository.getAttachmentById(id);
}

/// Upload new attachment
class UploadAttachmentUseCase {
  final AttachmentRepository repository;

  UploadAttachmentUseCase(this.repository);

  Future<AttachmentEntity> call(AttachmentEntity attachment) =>
      repository.uploadAttachment(attachment);
}

/// Update attachment details
class UpdateAttachmentUseCase {
  final AttachmentRepository repository;

  UpdateAttachmentUseCase(this.repository);

  Future<AttachmentEntity> call(String id, AttachmentEntity attachment) =>
      repository.updateAttachment(id, attachment);
}

/// Set primary resume
class SetPrimaryResumeUseCase {
  final AttachmentRepository repository;

  SetPrimaryResumeUseCase(this.repository);

  Future<AttachmentEntity> call(String attachmentId) =>
      repository.setPrimaryResume(attachmentId);
}

/// Delete attachment
class DeleteAttachmentUseCase {
  final AttachmentRepository repository;

  DeleteAttachmentUseCase(this.repository);

  Future<void> call(String id) => repository.deleteAttachment(id);
}
