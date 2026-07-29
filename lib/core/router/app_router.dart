import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/education/presentation/bloc/education_bloc.dart';
import '../../features/education/presentation/screens/education_screen.dart';
import '../../features/languages/presentation/bloc/languages_bloc.dart';
import '../../features/languages/presentation/screens/languages_screen.dart';
import '../../features/projects/presentation/bloc/projects_bloc.dart';
import '../../features/projects/presentation/screens/projects_screen.dart';
import '../../features/certificates/presentation/bloc/certificates_bloc.dart';
import '../../features/certificates/presentation/screens/certificates_screen.dart';
import '../di/service_locator.dart';

/// App Router configuration with GoRouter
final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    // Welcome
    GoRoute(
      path: WelcomeScreen.routeName,
      builder: (context, state) => const WelcomeScreen(),
    ),

    // Login
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),

    // Register
    GoRoute(
      path: RegisterScreen.routeName,
      builder: (context, state) => const RegisterScreen(),
    ),

    // Home
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),

    // Profile
    GoRoute(
      path: ProfileScreen.routeName,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<ProfileBloc>(),
        child: const ProfileScreen(),
      ),
    ),

    // Education
    GoRoute(
      path: EducationScreen.routeName,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<EducationBloc>(),
        child: const EducationScreen(),
      ),
    ),

    // Languages
    GoRoute(
      path: LanguagesScreen.routeName,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<LanguagesBloc>(),
        child: const LanguagesScreen(),
      ),
    ),

    // Projects
    GoRoute(
      path: ProjectsScreen.routeName,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<ProjectsBloc>(),
        child: const ProjectsScreen(),
      ),
    ),

    // Certificates
    GoRoute(
      path: CertificatesScreen.routeName,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<CertificatesBloc>(),
        child: const CertificatesScreen(),
      ),
    ),
  ],

  // Error handler
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.error}'),
    ),
  ),
);
