import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/domain/usecases/get_current_session.dart';
import '../../features/auth/domain/usecases/is_authenticated.dart';
import '../../features/auth/domain/usecases/logout.dart';
import '../../features/auth/domain/usecases/refresh_session.dart';
import '../../features/auth/domain/usecases/register.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_local_data_source_impl.dart';
import '../network/api_client.dart';
import '../network/dio_api_client.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Secure Storage
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

// Auth Bloc
sl.registerFactory<AuthBloc>(
  () => AuthBloc(
    login: sl<Login>(),
    register: sl<Register>(),
    logout: sl<Logout>(),
    refreshSession: sl<RefreshSession>(),
    getCurrentSession: sl<GetCurrentSession>(),
    isAuthenticated: sl<IsAuthenticated>(),
  ),
);

  // Dio
sl.registerLazySingleton<Dio>(
  () => Dio(
    BaseOptions(
      baseUrl: 'https://YOUR_API_BASE_URL',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  ),
);

  // Api Client
  sl.registerLazySingleton<ApiClient>(
    () => DioApiClient(
      dio: sl<Dio>(),
    ),
  );

  // Auth Remote Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      apiClient: sl<ApiClient>(),
    ),
  );
  
  // Auth Local Data Source
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      secureStorage: sl<FlutterSecureStorage>(),
    ),
  );
// Auth Repository
sl.registerLazySingleton<AuthRepository>(
  () => AuthRepositoryImpl(
    remoteDataSource: sl<AuthRemoteDataSource>(),
    localDataSource: sl<AuthLocalDataSource>(),
  ),
);

sl.registerLazySingleton<Login>(
  () => Login(
    sl<AuthRepository>(),
  ),
);

// Register
sl.registerLazySingleton<Register>(
  () => Register(
    sl<AuthRepository>(),
  ),
);

// Logout
sl.registerLazySingleton<Logout>(
  () => Logout(
    sl<AuthRepository>(),
  ),
);

// Refresh Session
sl.registerLazySingleton<RefreshSession>(
  () => RefreshSession(
    sl<AuthRepository>(),
  ),
);

// Get Current Session
sl.registerLazySingleton<GetCurrentSession>(
  () => GetCurrentSession(
    sl<AuthRepository>(),
  ),
);

// Is Authenticated
sl.registerLazySingleton<IsAuthenticated>(
  () => IsAuthenticated(
    sl<AuthRepository>(),
  ),
);

}