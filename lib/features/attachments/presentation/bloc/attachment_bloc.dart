import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/attachment_entities.dart';
import '../../domain/usecases/attachment_usecases.dart';

part 'attachment_event.dart';
part 'attachment_state.dart';

class AttachmentBloc extends Bloc<AttachmentEvent, AttachmentState> {
  final GetAttachmentsUseCase getAttachments;
  final UploadAttachmentUseCase uploadAttachment;
  final UpdateAttachmentUseCase updateAttachment;
  final SetPrimaryResumeUseCase setPrimaryResume;
  final DeleteAttachmentUseCase deleteAttachment;

  AttachmentBloc({
    required this.getAttachments,
    required this.uploadAttachment,
    required this.updateAttachment,
    required this.setPrimaryResume,
    required this.deleteAttachment,
  }) : super(const AttachmentInitial()) {
    on<GetAttachmentsEvent>(_onGetAttachments);
    on<UploadAttachmentEvent>(_onUploadAttachment);
    on<UpdateAttachmentEvent>(_onUpdateAttachment);
    on<SetPrimaryResumeEvent>(_onSetPrimaryResume);
    on<DeleteAttachmentEvent>(_onDeleteAttachment);
  }

  Future<void> _onGetAttachments(
    GetAttachmentsEvent event,
    Emitter<AttachmentState> emit,
  ) async {
    emit(const AttachmentLoading());
    try {
      final attachments = await getAttachments(
        careerProfileId: event.careerProfileId,
        category: event.category,
        page: event.page,
        limit: event.limit,
      );
      emit(AttachmentSuccess(attachments));
    } catch (e) {
      emit(AttachmentError(e.toString()));
    }
  }

  Future<void> _onUploadAttachment(
    UploadAttachmentEvent event,
    Emitter<AttachmentState> emit,
  ) async {
    emit(const AttachmentLoading());
    try {
      final result = await uploadAttachment(event.attachment);
      emit(AttachmentUploaded(result));
    } catch (e) {
      emit(AttachmentError(e.toString()));
    }
  }

  Future<void> _onUpdateAttachment(
    UpdateAttachmentEvent event,
    Emitter<AttachmentState> emit,
  ) async {
    emit(const AttachmentLoading());
    try {
      final result = await updateAttachment(event.id, event.attachment);
      emit(AttachmentUpdated(result));
    } catch (e) {
      emit(AttachmentError(e.toString()));
    }
  }

  Future<void> _onSetPrimaryResume(
    SetPrimaryResumeEvent event,
    Emitter<AttachmentState> emit,
  ) async {
    emit(const AttachmentLoading());
    try {
      final result = await setPrimaryResume(event.attachmentId);
      emit(AttachmentUpdated(result));
    } catch (e) {
      emit(AttachmentError(e.toString()));
    }
  }

  Future<void> _onDeleteAttachment(
    DeleteAttachmentEvent event,
    Emitter<AttachmentState> emit,
  ) async {
    emit(const AttachmentLoading());
    try {
      await deleteAttachment(event.id);
      emit(const AttachmentDeleted());
    } catch (e) {
      emit(AttachmentError(e.toString()));
    }
  }
}
