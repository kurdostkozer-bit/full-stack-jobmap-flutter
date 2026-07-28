import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_current_session.dart';
import '../../domain/usecases/is_authenticated.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/refresh_session.dart';
import '../../domain/usecases/register.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;
  final Logout logout;
  final GetCurrentSession getCurrentSession;
  final IsAuthenticated isAuthenticated;
  final RefreshSession refreshSession;

  AuthBloc({
    required this.login,
    required this.register,
    required this.logout,
    required this.getCurrentSession,
    required this.isAuthenticated,
    required this.refreshSession,
  }) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthenticationRequested>(_onCheckAuthenticationRequested);
    on<RefreshSessionRequested>(_onRefreshSessionRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final session = await login(
        email: event.email,
        password: event.password,
      );

      emit(AuthAuthenticated(session));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final session = await register(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
        phone: event.phone,
      );

      emit(AuthAuthenticated(session));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await logout();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onCheckAuthenticationRequested(
    CheckAuthenticationRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final authenticated = await isAuthenticated();

      if (!authenticated) {
        emit(const AuthUnauthenticated());
        return;
      }

      final session = await getCurrentSession();

      if (session == null) {
        emit(const AuthUnauthenticated());
      } else {
        emit(AuthAuthenticated(session));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRefreshSessionRequested(
    RefreshSessionRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final session = await getCurrentSession();

      if (session == null) {
        emit(const AuthUnauthenticated());
        return;
      }

      final refreshedSession = await refreshSession(
        session.refreshToken,
      );

      emit(AuthAuthenticated(refreshedSession));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}