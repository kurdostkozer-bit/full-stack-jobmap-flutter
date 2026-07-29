import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/auth_models.dart';
import '../../domain/usecases/auth_usecases.dart';
import '../../../../core/network/models/api_exception.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;
  final LoginUseCase loginUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final LogoutUseCase logoutUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final CheckAuthUseCase checkAuthUseCase;
  final GetCachedUserUseCase getCachedUserUseCase;

  AuthBloc({
    required this.registerUseCase,
    required this.verifyEmailUseCase,
    required this.loginUseCase,
    required this.getCurrentUserUseCase,
    required this.logoutUseCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.checkAuthUseCase,
    required this.getCachedUserUseCase,
  }) : super(const AuthInitial()) {
    on<CheckAuthEvent>(_onCheckAuth);
    on<RegisterEvent>(_onRegister);
    on<VerifyEmailEvent>(_onVerifyEmail);
    on<LoginEvent>(_onLogin);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<LogoutEvent>(_onLogout);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onCheckAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final isAuthenticated = await checkAuthUseCase();
      if (isAuthenticated) {
        final user = await getCachedUserUseCase();
        if (user != null) {
          emit(AuthAuthenticated(user: user, token: ''));
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
        event.email,
        event.password,
        event.firstName,
        event.lastName,
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
      await verifyEmailUseCase(event.email, event.code);
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
      final response = await loginUseCase(event.email, event.password);
      emit(AuthAuthenticated(user: response.user, token: response.token));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'Login failed: $e'));
    }
  }

  Future<void> _onGetCurrentUser(GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final user = await getCurrentUserUseCase();
      emit(AuthAuthenticated(user: user, token: ''));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'Failed to get user: $e'));
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
      await forgotPasswordUseCase(event.email);
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
      await resetPasswordUseCase(event.email, event.code, event.newPassword);
      emit(const AuthSuccess(message: 'Password reset successfully'));
    } on ApiException catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: 'Password reset failed: $e'));
    }
  }
}
