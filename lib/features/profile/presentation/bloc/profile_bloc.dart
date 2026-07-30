import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../domain/usecases/profile_usecases.dart';
import '../../../../core/network/models/api_exception.dart';
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
      debugPrint('🔄 ProfileBloc: Loading profile...');
      final profile = await getProfileUseCase();
      debugPrint('✅ ProfileBloc: Profile loaded successfully');
      emit(ProfileLoaded(profile: profile));
    } on ApiException catch (e) {
      debugPrint('❌ ProfileBloc: ApiException - Status: ${e.statusCode}, Message: ${e.message}');
      debugPrint('   Original Exception: ${e.originalException}');
      if (e.originalException is DioException) {
        final dioEx = e.originalException as DioException;
        debugPrint('   Response Body: ${dioEx.response?.data}');
      }
      emit(ProfileError(message: e.message));
    } catch (e, st) {
      debugPrint('❌ ProfileBloc: Unexpected exception - $e');
      debugPrint('   StackTrace: $st');
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
      debugPrint('🔄 ProfileBloc: Updating profile...');
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

      debugPrint('✅ ProfileBloc: Profile updated successfully');
      emit(ProfileUpdated(profile: updatedProfile));
    } on ApiException catch (e) {
      debugPrint('❌ ProfileBloc: Update failed - Status: ${e.statusCode}, Message: ${e.message}');
      debugPrint('   Original Exception: ${e.originalException}');
      if (e.originalException is DioException) {
        final dioEx = e.originalException as DioException;
        debugPrint('   Response Body: ${dioEx.response?.data}');
      }
      emit(ProfileError(
        message: e.message,
        previousProfile: previousProfile,
      ));
    } catch (e, st) {
      debugPrint('❌ ProfileBloc: Unexpected exception during update - $e');
      debugPrint('   StackTrace: $st');
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
