import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../design_system/index.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String routeName = '/welcome';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSpacing.xl),

                // Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Icon(
                    Icons.work_outline,
                    size: 60,
                    color: context.colorScheme.primary,
                  ),
                ),
                SizedBox(height: AppSpacing.xl),

                // Title
                Text(
                  'Welcome to JobMap',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.md),

                // Subtitle
                Text(
                  'Discover amazing opportunities and advance your career',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.xl * 2),

                // Login Button
                AppButton(
                  label: 'Login',
                  onPressed: () {
                    context.go('/login');
                  },
                ),
                SizedBox(height: AppSpacing.md),

                // Create Account Button
                AppButton.outline(
                  label: 'Create Account',
                  onPressed: () => context.go('/register'),
                ),
                SizedBox(height: AppSpacing.md),

                // Continue as Guest
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/home'),
                    child: Text(
                      'Continue as guest',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
