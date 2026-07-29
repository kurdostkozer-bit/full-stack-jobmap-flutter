import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/usecases/auth_usecases.dart';
import '../../../../core/network/models/api_exception.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final CheckAuthUseCase checkAuthUseCase;
  final GetCurrentSessionUseCase getCurrentSessionUseCase;
  final RefreshSessionUseCase refreshSessionUseCase;

  AuthBloc({
    required this.registerUseCase,
    required this.verifyEmailUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.checkAuthUseCase,
    required this.getCurrentSessionUseCase,
    required this.refreshSessionUseCase,
  }) : super(const AuthInitial()) {
    on<CheckAuthEvent>(_onCheckAuth);
    on<RegisterEvent>(_onRegister);
    on<VerifyEmailEvent>(_onVerifyEmail);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ResetPasswordEvent>(_onResetPassword);
    on<RefreshSessionEvent>(_onRefreshSession);
  }

  Future<void> _onCheckAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final isAuthenticated = await checkAuthUseCase();
      if (isAuthenticated) {
        final session = await getCurrentSessionUseCase();
        if (session != null) {
          emit(AuthAuthenticated(session: session));
        } else {
          emit(const AuthUnauthenticated());
        }
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await registerUseCase(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
        phone: event.phone,
      );
      emit(EmailVerificationNeeded(email: event.email));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'Registration failed: $e'));
    }
  }

  Future<void> _onVerifyEmail(VerifyEmailEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await verifyEmailUseCase(email: event.email, code: event.code);
      emit(const AuthSuccess(message: 'Email verified successfully'));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'Verification failed: $e'));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final session = await loginUseCase(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(session: session));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'Login failed: $e'));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await logoutUseCase();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: 'Logout failed: $e'));
    }
  }

  Future<void> _onForgotPassword(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await forgotPasswordUseCase(email: event.email);
      emit(const PasswordResetSent(
        message: 'Password reset code sent to your email',
      ));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'Forgot password failed: $e'));
    }
  }

  Future<void> _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await resetPasswordUseCase(
        email: event.email,
        code: event.code,
        newPassword: event.newPassword,
      );
      emit(const AuthSuccess(message: 'Password reset successfully'));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'Password reset failed: $e'));
    }
  }

  Future<void> _onRefreshSession(RefreshSessionEvent event, Emitter<AuthState> emit) async {
    try {
      final session = await refreshSessionUseCase(
        refreshToken: event.refreshToken,
      );
      emit(AuthAuthenticated(session: session));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'Session refresh failed: $e'));
    }
  }
}
