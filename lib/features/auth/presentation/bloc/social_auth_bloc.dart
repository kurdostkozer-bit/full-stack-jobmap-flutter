import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/services/email_auth_service.dart';

part 'social_auth_event.dart';
part 'social_auth_state.dart';

class SocialAuthBloc extends Bloc<SocialAuthEvent, SocialAuthState> {
  final EmailAuthService emailAuthService;
  final AuthRepository authRepository;

  SocialAuthBloc({
    required this.emailAuthService,
    required this.authRepository,
  }) : super(SocialAuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<SocialAuthState> emit,
  ) async {
    emit(SocialAuthLoading());
    try {
      // Validate email format
      if (!emailAuthService.isValidEmail(event.email)) {
        emit(const SocialAuthFailure(message: 'Invalid email format'));
        return;
      }

      // Validate password
      if (event.password.isEmpty) {
        emit(const SocialAuthFailure(message: 'Password is required'));
        return;
      }

      final authSession = await authRepository.login(
        email: event.email,
        password: event.password,
      );

      emit(SocialAuthSuccess(authSession: authSession));
      emailAuthService.logAuthEvent('User logged in', email: event.email);
    } catch (e) {
      debugPrint('Login error: $e');
      emit(SocialAuthFailure(message: e.toString()));
      emailAuthService.logAuthEvent('Login failed', email: event.email, error: e.toString());
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<SocialAuthState> emit,
  ) async {
    emit(SocialAuthLoading());
    try {
      // Validate full name
      if (!emailAuthService.isValidFullName(event.fullName)) {
        emit(const SocialAuthFailure(message: 'Invalid full name'));
        return;
      }

      // Validate email format
      if (!emailAuthService.isValidEmail(event.email)) {
        emit(const SocialAuthFailure(message: 'Invalid email format'));
        return;
      }

      // Validate password strength
      if (!emailAuthService.isValidPassword(event.password)) {
        final feedback = emailAuthService.getPasswordStrengthFeedback(event.password);
        emit(SocialAuthFailure(message: feedback));
        return;
      }

      // Validate phone if provided
      if (!emailAuthService.isValidPhone(event.phone)) {
        emit(const SocialAuthFailure(message: 'Invalid phone number'));
        return;
      }

      final authSession = await authRepository.register(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
        phone: event.phone,
      );

      emit(SocialAuthSuccess(authSession: authSession));
      emailAuthService.logAuthEvent('User registered', email: event.email);
    } catch (e) {
      debugPrint('Registration error: $e');
      emit(SocialAuthFailure(message: e.toString()));
      emailAuthService.logAuthEvent('Registration failed', email: event.email, error: e.toString());
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<SocialAuthState> emit,
  ) async {
    emit(SocialAuthLoading());
    try {
      await authRepository.logout();
      emit(SocialAuthInitial());
      emailAuthService.logAuthEvent('User logged out');
    } catch (e) {
      debugPrint('Logout error: $e');
      emit(SocialAuthFailure(message: e.toString()));
      emailAuthService.logAuthEvent('Logout failed', error: e.toString());
    }
  }
}
