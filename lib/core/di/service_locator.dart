import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/domain/usecases/auth_usecases.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/profile/domain/usecases/profile_usecases.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/datasources/profile_local_datasource.dart';
import '../../features/education/presentation/bloc/education_bloc.dart';
import '../../features/education/domain/usecases/education_usecases.dart';
import '../../features/education/data/repositories/education_repository_impl.dart';
import '../../features/education/domain/repositories/education_repository.dart';
import '../../features/education/data/datasources/education_remote_datasource.dart';
import '../../features/education/data/datasources/education_local_datasource.dart';
import '../../features/languages/presentation/bloc/languages_bloc.dart';
import '../../features/languages/domain/usecases/languages_usecases.dart';
import '../../features/languages/data/repositories/languages_repository_impl.dart';
import '../../features/languages/domain/repositories/languages_repository.dart';
import '../../features/languages/data/datasources/languages_remote_datasource.dart';
import '../../features/languages/data/datasources/languages_local_datasource.dart';
import '../../features/projects/presentation/bloc/projects_bloc.dart';
import '../../features/projects/domain/usecases/projects_usecases.dart';
import '../../features/projects/data/repositories/projects_repository_impl.dart';
import '../../features/projects/domain/repositories/projects_repository.dart';
import '../../features/projects/data/datasources/projects_remote_datasource.dart';
import '../../features/projects/data/datasources/projects_local_datasource.dart';
import '../../features/certificates/presentation/bloc/certificates_bloc.dart';
import '../../features/certificates/domain/usecases/certificates_usecases.dart';
import '../../features/certificates/data/repositories/certificates_repository_impl.dart';
import '../../features/certificates/domain/repositories/certificates_repository.dart';
import '../../features/certificates/data/datasources/certificates_remote_datasource.dart';
import '../../features/certificates/data/datasources/certificates_local_datasource.dart';
import '../network/api_client.dart';
import '../network/dio_provider.dart';
import '../config/app_config.dart';
import '../infrastructure/cache_service.dart';
import '../infrastructure/offline_service.dart';
import '../infrastructure/connectivity_service.dart';
import '../infrastructure/analytics_service.dart';
import '../infrastructure/crash_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // App Config
  AppConfig.init(AppConfig.environment);

  // Secure Storage
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Infrastructure Services
  sl.registerLazySingleton<CacheService>(
    () => MemoryCacheService(),
  );

  sl.registerLazySingleton<ConnectivityService>(
    () => SimpleConnectivityService(),
  );

  sl.registerLazySingleton<OfflineService>(
    () => SimpleOfflineService(),
  );

  sl.registerLazySingleton<AnalyticsService>(
    () => SimpleAnalyticsService(),
  );

  sl.registerLazySingleton<CrashService>(
    () => SimpleCrashService(),
  );

  // Dio
  sl.registerLazySingleton<Dio>(
    () => DioProvider.createDio(
      baseUrl: AppConfig.fullApiUrl,
      secureStorage: sl<FlutterSecureStorage>(),
      enableLogging: AppConfig.enableLogging,
    ),
  );

  // API Client
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: sl<Dio>()),
  );

  // Auth Remote DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  // Auth Local DataSource
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(secureStorage: sl<FlutterSecureStorage>()),
  );

  // Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  // Auth UseCases
  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<VerifyEmailUseCase>(
    () => VerifyEmailUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<CheckAuthUseCase>(
    () => CheckAuthUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<GetCachedUserUseCase>(
    () => GetCachedUserUseCase(repository: sl<AuthRepository>()),
  );

  // Auth Bloc
  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      registerUseCase: sl<RegisterUseCase>(),
      verifyEmailUseCase: sl<VerifyEmailUseCase>(),
      loginUseCase: sl<LoginUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      forgotPasswordUseCase: sl<ForgotPasswordUseCase>(),
      resetPasswordUseCase: sl<ResetPasswordUseCase>(),
      checkAuthUseCase: sl<CheckAuthUseCase>(),
      getCachedUserUseCase: sl<GetCachedUserUseCase>(),
    ),
  );

  // Profile Remote DataSource
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  // Profile Local DataSource
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(secureStorage: sl<FlutterSecureStorage>()),
  );

  // Profile Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl<ProfileRemoteDataSource>(),
      localDataSource: sl<ProfileLocalDataSource>(),
    ),
  );

  // Profile UseCases
  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(repository: sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(repository: sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<GetCachedProfileUseCase>(
    () => GetCachedProfileUseCase(repository: sl<ProfileRepository>()),
  );

  // Profile Bloc
  sl.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(
      getProfileUseCase: sl<GetProfileUseCase>(),
      updateProfileUseCase: sl<UpdateProfileUseCase>(),
      getCachedProfileUseCase: sl<GetCachedProfileUseCase>(),
    ),
  );

  // ============ EDUCATION FEATURE ============

  // Education Remote DataSource
  sl.registerLazySingleton<EducationRemoteDataSource>(
    () => EducationRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  // Education Local DataSource
  sl.registerLazySingleton<EducationLocalDataSource>(
    () => EducationLocalDataSourceImpl(secureStorage: sl<FlutterSecureStorage>()),
  );

  // Education Repository
  sl.registerLazySingleton<EducationRepository>(
    () => EducationRepositoryImpl(
      remoteDataSource: sl<EducationRemoteDataSource>(),
      localDataSource: sl<EducationLocalDataSource>(),
    ),
  );

  // Education UseCases
  sl.registerLazySingleton<GetEducationsUseCase>(
    () => GetEducationsUseCase(repository: sl<EducationRepository>()),
  );

  sl.registerLazySingleton<CreateEducationUseCase>(
    () => CreateEducationUseCase(repository: sl<EducationRepository>()),
  );

  sl.registerLazySingleton<UpdateEducationUseCase>(
    () => UpdateEducationUseCase(repository: sl<EducationRepository>()),
  );

  sl.registerLazySingleton<DeleteEducationUseCase>(
    () => DeleteEducationUseCase(repository: sl<EducationRepository>()),
  );

  // Education Bloc
  sl.registerLazySingleton<EducationBloc>(
    () => EducationBloc(
      getEducationsUseCase: sl<GetEducationsUseCase>(),
      createEducationUseCase: sl<CreateEducationUseCase>(),
      updateEducationUseCase: sl<UpdateEducationUseCase>(),
      deleteEducationUseCase: sl<DeleteEducationUseCase>(),
    ),
  );

  // ============ LANGUAGES FEATURE ============

  // Languages Remote DataSource
  sl.registerLazySingleton<LanguagesRemoteDataSource>(
    () => LanguagesRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  // Languages Local DataSource
  sl.registerLazySingleton<LanguagesLocalDataSource>(
    () => LanguagesLocalDataSourceImpl(secureStorage: sl<FlutterSecureStorage>()),
  );

  // Languages Repository
  sl.registerLazySingleton<LanguagesRepository>(
    () => LanguagesRepositoryImpl(
      remoteDataSource: sl<LanguagesRemoteDataSource>(),
      localDataSource: sl<LanguagesLocalDataSource>(),
    ),
  );

  // Languages UseCases
  sl.registerLazySingleton<GetLanguagesUseCase>(
    () => GetLanguagesUseCase(repository: sl<LanguagesRepository>()),
  );

  sl.registerLazySingleton<CreateLanguageUseCase>(
    () => CreateLanguageUseCase(repository: sl<LanguagesRepository>()),
  );

  sl.registerLazySingleton<UpdateLanguageUseCase>(
    () => UpdateLanguageUseCase(repository: sl<LanguagesRepository>()),
  );

  sl.registerLazySingleton<DeleteLanguageUseCase>(
    () => DeleteLanguageUseCase(repository: sl<LanguagesRepository>()),
  );

  // Languages Bloc
  sl.registerLazySingleton<LanguagesBloc>(
    () => LanguagesBloc(
      getLanguagesUseCase: sl<GetLanguagesUseCase>(),
      createLanguageUseCase: sl<CreateLanguageUseCase>(),
      updateLanguageUseCase: sl<UpdateLanguageUseCase>(),
      deleteLanguageUseCase: sl<DeleteLanguageUseCase>(),
    ),
  );

  // ============ PROJECTS FEATURE ============

  // Projects Remote DataSource
  sl.registerLazySingleton<ProjectsRemoteDataSource>(
    () => ProjectsRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  // Projects Local DataSource
  sl.registerLazySingleton<ProjectsLocalDataSource>(
    () => ProjectsLocalDataSourceImpl(secureStorage: sl<FlutterSecureStorage>()),
  );

  // Projects Repository
  sl.registerLazySingleton<ProjectsRepository>(
    () => ProjectsRepositoryImpl(
      remoteDataSource: sl<ProjectsRemoteDataSource>(),
      localDataSource: sl<ProjectsLocalDataSource>(),
    ),
  );

  // Projects UseCases
  sl.registerLazySingleton<GetProjectsUseCase>(
    () => GetProjectsUseCase(repository: sl<ProjectsRepository>()),
  );

  sl.registerLazySingleton<CreateProjectUseCase>(
    () => CreateProjectUseCase(repository: sl<ProjectsRepository>()),
  );

  sl.registerLazySingleton<UpdateProjectUseCase>(
    () => UpdateProjectUseCase(repository: sl<ProjectsRepository>()),
  );

  sl.registerLazySingleton<DeleteProjectUseCase>(
    () => DeleteProjectUseCase(repository: sl<ProjectsRepository>()),
  );

  // Projects Bloc
  sl.registerLazySingleton<ProjectsBloc>(
    () => ProjectsBloc(
      getProjectsUseCase: sl<GetProjectsUseCase>(),
      createProjectUseCase: sl<CreateProjectUseCase>(),
      updateProjectUseCase: sl<UpdateProjectUseCase>(),
      deleteProjectUseCase: sl<DeleteProjectUseCase>(),
    ),
  );

  // ============ CERTIFICATES FEATURE ============

  // Certificates Remote DataSource
  sl.registerLazySingleton<CertificatesRemoteDataSource>(
    () => CertificatesRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  // Certificates Local DataSource
  sl.registerLazySingleton<CertificatesLocalDataSource>(
    () => CertificatesLocalDataSourceImpl(secureStorage: sl<FlutterSecureStorage>()),
  );

  // Certificates Repository
  sl.registerLazySingleton<CertificatesRepository>(
    () => CertificatesRepositoryImpl(
      remoteDataSource: sl<CertificatesRemoteDataSource>(),
      localDataSource: sl<CertificatesLocalDataSource>(),
    ),
  );

  // Certificates UseCases
  sl.registerLazySingleton<GetCertificatesUseCase>(
    () => GetCertificatesUseCase(repository: sl<CertificatesRepository>()),
  );

  sl.registerLazySingleton<CreateCertificateUseCase>(
    () => CreateCertificateUseCase(repository: sl<CertificatesRepository>()),
  );

  sl.registerLazySingleton<UpdateCertificateUseCase>(
    () => UpdateCertificateUseCase(repository: sl<CertificatesRepository>()),
  );

  sl.registerLazySingleton<DeleteCertificateUseCase>(
    () => DeleteCertificateUseCase(repository: sl<CertificatesRepository>()),
  );

  // Certificates Bloc
  sl.registerLazySingleton<CertificatesBloc>(
    () => CertificatesBloc(
      getCertificatesUseCase: sl<GetCertificatesUseCase>(),
      createCertificateUseCase: sl<CreateCertificateUseCase>(),
      updateCertificateUseCase: sl<UpdateCertificateUseCase>(),
      deleteCertificateUseCase: sl<DeleteCertificateUseCase>(),
    ),
  );
}