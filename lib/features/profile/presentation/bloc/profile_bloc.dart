import 'package:bloc/bloc.dart';
import '../../domain/usecases/profile_usecases.dart';
import '../../../../core/network/app_exception.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetCachedProfileUseCase getCachedProfileUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.getCachedProfileUseCase,
  }) : super(const ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<ClearProfileEvent>(_onClearProfile);
  }

  /// Handle LoadProfileEvent
  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final profile = await getProfileUseCase();
      emit(ProfileLoaded(profile: profile));
    } on AppException catch (e) {
      emit(ProfileError(message: e.message));
    } catch (e) {
      emit(ProfileError(message: 'Failed to load profile: $e'));
    }
  }

  /// Handle UpdateProfileEvent
  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;

    // Keep track of previous profile for rollback
    final previousProfile = currentState is ProfileLoaded
        ? currentState.profile
        : currentState is ProfileUpdated
            ? currentState.profile
            : null;

    try {
      // Show updating state with current data
      if (previousProfile != null) {
        emit(ProfileUpdating(profile: previousProfile));
      } else {
        emit(const ProfileLoading());
      }

      // Call update usecase
      final updatedProfile = await updateProfileUseCase(
        firstName: event.firstName,
        lastName: event.lastName,
        phoneNumber: event.phoneNumber,
        profileImageUrl: event.profileImageUrl,
        bio: event.bio,
        headline: event.headline,
        location: event.location,
        website: event.website,
        linkedinUrl: event.linkedinUrl,
        githubUrl: event.githubUrl,
      );

      emit(ProfileUpdated(profile: updatedProfile));
    } on AppException catch (e) {
      emit(ProfileError(
        message: e.message,
        previousProfile: previousProfile,
      ));
    } catch (e) {
      emit(ProfileError(
        message: 'Failed to update profile: $e',
        previousProfile: previousProfile,
      ));
    }
  }

  /// Handle ClearProfileEvent
  Future<void> _onClearProfile(
    ClearProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileCleared());
  }
}
