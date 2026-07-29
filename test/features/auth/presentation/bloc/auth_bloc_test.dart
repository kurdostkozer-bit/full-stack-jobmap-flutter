import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:jobmap/features/auth/domain/usecases/auth_usecases.dart';
import 'package:jobmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:jobmap/core/network/models/api_exception.dart';
import '../../../fixtures/auth_fixtures.dart';

@GenerateMocks([
  RegisterUseCase,
  VerifyEmailUseCase,
  LoginUseCase,
  GetCurrentUserUseCase,
  LogoutUseCase,
  ForgotPasswordUseCase,
  ResetPasswordUseCase,
  CheckAuthUseCase,
  GetCachedUserUseCase,
])
void main() {
  late AuthBloc authBloc;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockCheckAuthUseCase mockCheckAuthUseCase;

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockCheckAuthUseCase = MockCheckAuthUseCase();

    authBloc = AuthBloc(
      registerUseCase: mockRegisterUseCase,
      verifyEmailUseCase: MockVerifyEmailUseCase(),
      loginUseCase: mockLoginUseCase,
      getCurrentUserUseCase: MockGetCurrentUserUseCase(),
      logoutUseCase: mockLogoutUseCase,
      forgotPasswordUseCase: MockForgotPasswordUseCase(),
      resetPasswordUseCase: MockResetPasswordUseCase(),
      checkAuthUseCase: mockCheckAuthUseCase,
      getCachedUserUseCase: MockGetCachedUserUseCase(),
    );
  });

  tearDown(() => authBloc.close());

  group('AuthBloc', () {
    group('LoginEvent', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when login succeeds',
        build: () {
          when(mockLoginUseCase(
            AuthFixtures.testEmail,
            AuthFixtures.testPassword,
          )).thenAnswer((_) async => AuthFixtures.testAuthResponse);
          return authBloc;
        },
        act: (bloc) => bloc.add(
          LoginEvent(
            email: AuthFixtures.testEmail,
            password: AuthFixtures.testPassword,
          ),
        ),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthAuthenticated>()
              .having((state) => state.user.email, 'email', AuthFixtures.testEmail)
              .having((state) => state.token, 'token', AuthFixtures.testToken),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when login fails',
        build: () {
          when(mockLoginUseCase(any, any))
              .thenThrow(ApiException(message: 'Invalid credentials'));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          LoginEvent(
            email: AuthFixtures.testEmail,
            password: 'wrong-password',
          ),
        ),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthError>(),
        ],
      );
    });

    group('LogoutEvent', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when logout succeeds',
        build: () {
          when(mockLogoutUseCase()).thenAnswer((_) async => {});
          return authBloc;
        },
        act: (bloc) => bloc.add(const LogoutEvent()),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthUnauthenticated>(),
        ],
      );
    });

    group('CheckAuthEvent', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when user is authenticated',
        build: () {
          when(mockCheckAuthUseCase()).thenAnswer((_) async => true);
          return authBloc;
        },
        act: (bloc) => bloc.add(const CheckAuthEvent()),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthAuthenticated>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when user is not authenticated',
        build: () {
          when(mockCheckAuthUseCase()).thenAnswer((_) async => false);
          return authBloc;
        },
        act: (bloc) => bloc.add(const CheckAuthEvent()),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthUnauthenticated>(),
        ],
      );
    });
  });
}
