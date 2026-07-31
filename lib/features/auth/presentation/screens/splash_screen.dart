import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../design_system/index.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../bloc/auth_bloc.dart';
import 'login_screen.dart';

/// Splash screen with auto-login
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
    // Delay to show splash screen for 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
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
          // User already logged in, go to map
          context.go('/map');
        } else if (state is AuthUnauthenticated) {
          // No active session, show login directly
          context.go(LoginScreen.routeName);
        } else if (state is AuthError) {
          // Error during auth check, show login directly
          context.go(LoginScreen.routeName);
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
              const Color(0xFFFCD34D), // Glass Yellow
              const Color(0xFFFDE047), // Glass Yellow Light
            ],
          ),
        ),
        child: Stack(
          children: [
            // Glassmorphism background elements
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.2),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.15),
                      blurRadius: 50,
                      spreadRadius: 15,
                    ),
                  ],
                ),
              ),
            ),
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo / Icon with glassmorphism
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.2),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                        BoxShadow(
                          color: const Color(0xFFFCD34D).withValues(alpha: 0.1),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),

                  // App Name
                  Text(
                    'JobMap',
                    style: context.textTheme.displaySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),

                  // Tagline
                  Text(
                    'Find Your Perfect Job',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
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
                        Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),

                  // Loading Text
                  Text(
                    'Loading...',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
