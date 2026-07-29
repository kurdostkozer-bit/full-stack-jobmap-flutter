part of 'attachment_bloc.dart';

abstract class AttachmentState extends Equatable {
  const AttachmentState();

  @override
  List<Object?> get props => [];
}

class AttachmentInitial extends AttachmentState {
  const AttachmentInitial();
}

class AttachmentLoading extends AttachmentState {
  const AttachmentLoading();
}

class AttachmentSuccess extends AttachmentState {
  final List<AttachmentEntity> attachments;

  const AttachmentSuccess(this.attachments);

  @override
  List<Object?> get props => [attachments];
}

class AttachmentUploaded extends AttachmentState {
  final AttachmentEntity attachment;

  const AttachmentUploaded(this.attachment);

  @override
  List<Object?> get props => [attachment];
}

class AttachmentUpdated extends AttachmentState {
  final AttachmentEntity attachment;

  const AttachmentUpdated(this.attachment);

  @override
  List<Object?> get props => [attachment];
}

class AttachmentDeleted extends AttachmentState {
  const AttachmentDeleted();
}

class AttachmentError extends AttachmentState {
  final String message;

  const AttachmentError(this.message);

  @override
  List<Object?> get props => [message];
}
