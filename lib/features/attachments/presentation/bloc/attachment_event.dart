part of 'attachment_bloc.dart';

abstract class AttachmentEvent extends Equatable {
  const AttachmentEvent();

  @override
  List<Object?> get props => [];
}

class GetAttachmentsEvent extends AttachmentEvent {
  final String careerProfileId;
  final AttachmentCategory? category;
  final int page;
  final int limit;

  const GetAttachmentsEvent({
    required this.careerProfileId,
    this.category,
    this.page = 1,
    this.limit = 20,
  });

  @override
  List<Object?> get props =>
      [careerProfileId, category, page, limit];
}

class UploadAttachmentEvent extends AttachmentEvent {
  final AttachmentEntity attachment;

  const UploadAttachmentEvent(this.attachment);

  @override
  List<Object?> get props => [attachment];
}

class UpdateAttachmentEvent extends AttachmentEvent {
  final String id;
  final AttachmentEntity attachment;

  const UpdateAttachmentEvent({
    required this.id,
    required this.attachment,
  });

  @override
  List<Object?> get props => [id, attachment];
}

class SetPrimaryResumeEvent extends AttachmentEvent {
  final String attachmentId;

  const SetPrimaryResumeEvent(this.attachmentId);

  @override
  List<Object?> get props => [attachmentId];
}

class DeleteAttachmentEvent extends AttachmentEvent {
  final String id;

  const DeleteAttachmentEvent(this.id);

  @override
  List<Object?> get props => [id];
}
