import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:jobmap/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:jobmap/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:jobmap/features/auth/data/repositories/auth_repository_impl.dart';
import '../../../fixtures/auth_fixtures.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('AuthRepository', () {
    group('login', () {
      test('should return AuthResponse and save to local storage on success', () async {
        // Arrange
        when(mockRemoteDataSource.login(any))
            .thenAnswer((_) async => AuthFixtures.testAuthResponse);
        when(mockLocalDataSource.saveAuthResponse(any))
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.login(
          AuthFixtures.testEmail,
          AuthFixtures.testPassword,
        );

        // Assert
        expect(result, equals(AuthFixtures.testAuthResponse));
        verify(mockRemoteDataSource.login(any)).called(1);
        verify(mockLocalDataSource.saveAuthResponse(any)).called(1);
      });
    });

    group('register', () {
      test('should return AuthResponse on successful registration', () async {
        // Arrange
        when(mockRemoteDataSource.register(any))
            .thenAnswer((_) async => AuthFixtures.testAuthResponse);
        when(mockLocalDataSource.saveAuthResponse(any))
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.register(
          AuthFixtures.testEmail,
          AuthFixtures.testPassword,
          AuthFixtures.testFirstName,
          AuthFixtures.testLastName,
        );

        // Assert
        expect(result, equals(AuthFixtures.testAuthResponse));
        verify(mockRemoteDataSource.register(any)).called(1);
      });
    });

    group('logout', () {
      test('should clear local storage on logout', () async {
        // Arrange
        when(mockRemoteDataSource.logout()).thenAnswer((_) async => {});
        when(mockLocalDataSource.clearAuth()).thenAnswer((_) async => {});

        // Act
        await repository.logout();

        // Assert
        verify(mockRemoteDataSource.logout()).called(1);
        verify(mockLocalDataSource.clearAuth()).called(1);
      });
    });

    group('getCurrentUser', () {
      test('should return UserResponse from remote', () async {
        // Arrange
        when(mockRemoteDataSource.getCurrentUser())
            .thenAnswer((_) async => AuthFixtures.testUserResponse);

        // Act
        final result = await repository.getCurrentUser();

        // Assert
        expect(result, equals(AuthFixtures.testUserResponse));
        verify(mockRemoteDataSource.getCurrentUser()).called(1);
      });
    });

    group('isUserAuthenticated', () {
      test('should return true when token exists', () async {
        // Arrange
        when(mockLocalDataSource.hasValidToken())
            .thenAnswer((_) async => true);

        // Act
        final result = await repository.isUserAuthenticated();

        // Assert
        expect(result, true);
        verify(mockLocalDataSource.hasValidToken()).called(1);
      });

      test('should return false when token is invalid', () async {
        // Arrange
        when(mockLocalDataSource.hasValidToken())
            .thenAnswer((_) async => false);

        // Act
        final result = await repository.isUserAuthenticated();

        // Assert
        expect(result, false);
      });
    });
  });
}
