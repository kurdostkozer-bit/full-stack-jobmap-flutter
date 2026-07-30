import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    on<CheckSocialAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onGoogleSignIn(
    GoogleSignInRequested event,
    Emitter<SocialAuthState> emit,
  ) async {
    emit(SocialAuthLoading());
    try {
      final userCredential = await socialAuthService.signInWithGoogle();

      if (userCredential == null) {
        emit(SocialAuthInitial());
        return;
      }

      final idToken = await userCredential.user?.getIdToken();
      final user = userCredential.user;

      if (user != null && idToken != null) {
        // ربط مع Backend API
        final authSession = await authRepository.socialLogin(
          email: user.email ?? '',
          firstName: user.displayName?.split(' ').first ?? '',
          lastName: user.displayName?.split(' ').last ?? '',
          provider: 'google',
          providerId: user.uid,
          idToken: idToken,
        );

        if (authSession != null) {
          emit(SocialAuthSuccess(authSession: authSession));
        } else {
          emit(const SocialAuthFailure(message: 'Failed to create session'));
        }
      }
    } catch (e) {
      emit(SocialAuthFailure(message: e.toString()));
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
      emit(SocialAuthFailure(message: e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckSocialAuthStatus event,
    Emitter<SocialAuthState> emit,
  ) async {
    final isAuthenticated = socialAuthService.isAuthenticated();
    final currentUser = socialAuthService.getCurrentUser();

    if (isAuthenticated && currentUser != null) {
      emit(SocialAuthAuthenticated(user: currentUser));
    } else {
      emit(SocialAuthInitial());
    }
  }
}
