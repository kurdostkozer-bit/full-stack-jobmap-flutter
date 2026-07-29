import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../design_system/index.dart';
import '../bloc/auth_bloc.dart';

/// Splash screen with auto-login
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkAuthentication();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Check if user is already authenticated
  void _checkAuthentication() {
    // Delay to show splash screen briefly
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        context.read<AuthBloc>().add(const CheckAuthEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // User already logged in, go to home
          context.go('/home');
        } else if (state is AuthUnauthenticated) {
          // No active session, show welcome
          context.go('/welcome');
        } else if (state is AuthError) {
          // Error during auth check, show welcome
          context.go('/welcome');
        }
      },
      child: _buildSplashUI(),
    );
  }

  Widget _buildSplashUI() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.colorScheme.primary,
              context.colorScheme.primaryContainer,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo / Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.work_outline,
                  size: 60,
                  color: context.colorScheme.primary,
                ),
              ),
              SizedBox(height: AppSpacing.lg),

              // App Name
              Text(
                'JobMap',
                style: context.textTheme.displaySmall?.copyWith(
                  color: context.colorScheme.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSpacing.sm),

              // Tagline
              Text(
                'Find Your Perfect Job',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.surface.withOpacity(0.8),
                ),
              ),
              SizedBox(height: AppSpacing.xl),

              // Loading Indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(
                    context.colorScheme.surface,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.lg),

              // Loading Text
              Text(
                'Loading...',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
