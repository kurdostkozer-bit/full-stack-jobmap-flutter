import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/services/social_auth_service.dart';

part 'social_auth_event.dart';
part 'social_auth_state.dart';

class SocialAuthBloc extends Bloc<SocialAuthEvent, SocialAuthState> {
  final SocialAuthService socialAuthService;
  final AuthRepository authRepository;

  SocialAuthBloc({
    required this.socialAuthService,
    required this.authRepository,
  }) : super(SocialAuthInitial()) {
    on<GoogleSignInRequested>(_onGoogleSignIn);
    on<SocialSignOutRequested>(_onSocialSignOut);
  }

  Future<void> _onGoogleSignIn(
    GoogleSignInRequested event,
    Emitter<SocialAuthState> emit,
  ) async {
    emit(SocialAuthLoading());
    try {
      final googleIdToken = await socialAuthService.signInWithGoogle();

      if (googleIdToken == null) {
        emit(SocialAuthInitial());
        return;
      }

      final authSession = await authRepository.socialLogin(
        idToken: googleIdToken.token,
      );

      if (authSession != null) {
        emit(SocialAuthSuccess(authSession: authSession));
      } else {
        emit(const SocialAuthFailure(message: 'Google sign-in failed'));
      }
    } catch (e) {
      debugPrint('Google sign-in error: $e');
      emit(const SocialAuthFailure(message: 'Google sign-in failed'));
    }
  }

  Future<void> _onSocialSignOut(
    SocialSignOutRequested event,
    Emitter<SocialAuthState> emit,
  ) async {
    emit(SocialAuthLoading());
    try {
      await socialAuthService.signOut();
      emit(SocialSignOutSuccess());
    } catch (e) {
      debugPrint('Google sign-out error: $e');
      emit(const SocialAuthFailure(message: 'Google sign-out failed'));
    }
  }
}
