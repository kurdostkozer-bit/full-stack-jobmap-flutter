import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/social_link_entities.dart';
import '../../domain/usecases/social_link_usecases.dart';

part 'social_link_event.dart';
part 'social_link_state.dart';

class SocialLinkBloc extends Bloc<SocialLinkEvent, SocialLinkState> {
  final GetSocialLinksUseCase getSocialLinks;
  final CreateSocialLinkUseCase createSocialLink;
  final UpdateSocialLinkUseCase updateSocialLink;
  final DeleteSocialLinkUseCase deleteSocialLink;

  SocialLinkBloc({
    required this.getSocialLinks,
    required this.createSocialLink,
    required this.updateSocialLink,
    required this.deleteSocialLink,
  }) : super(const SocialLinkInitial()) {
    on<GetSocialLinksEvent>(_onGetSocialLinks);
    on<CreateSocialLinkEvent>(_onCreateSocialLink);
    on<UpdateSocialLinkEvent>(_onUpdateSocialLink);
    on<DeleteSocialLinkEvent>(_onDeleteSocialLink);
  }

  Future<void> _onGetSocialLinks(
    GetSocialLinksEvent event,
    Emitter<SocialLinkState> emit,
  ) async {
    emit(const SocialLinkLoading());
    try {
      final links = await getSocialLinks(
        careerProfileId: event.careerProfileId,
        page: event.page,
        limit: event.limit,
      );
      emit(SocialLinkSuccess(links));
    } catch (e) {
      emit(SocialLinkError(e.toString()));
    }
  }

  Future<void> _onCreateSocialLink(
    CreateSocialLinkEvent event,
    Emitter<SocialLinkState> emit,
  ) async {
    emit(const SocialLinkLoading());
    try {
      final result = await createSocialLink(event.socialLink);
      emit(SocialLinkCreated(result));
    } catch (e) {
      emit(SocialLinkError(e.toString()));
    }
  }

  Future<void> _onUpdateSocialLink(
    UpdateSocialLinkEvent event,
    Emitter<SocialLinkState> emit,
  ) async {
    emit(const SocialLinkLoading());
    try {
      final result = await updateSocialLink(event.id, event.socialLink);
      emit(SocialLinkUpdated(result));
    } catch (e) {
      emit(SocialLinkError(e.toString()));
    }
  }

  Future<void> _onDeleteSocialLink(
    DeleteSocialLinkEvent event,
    Emitter<SocialLinkState> emit,
  ) async {
    emit(const SocialLinkLoading());
    try {
      await deleteSocialLink(event.id);
      emit(const SocialLinkDeleted());
    } catch (e) {
      emit(SocialLinkError(e.toString()));
    }
  }
}
