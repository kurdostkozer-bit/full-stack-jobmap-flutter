import 'package:flutter/material.dart';
import '../../../../design_system/index.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import 'login_screen.dart';
import 'register_screen.dart';

/// Welcome screen with login and register options
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const String routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: Icon(
                        AppIcons.briefcase,
                        size: 50,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg),
                    Text(
                      'Welcome to JobMap',
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSpacing.md),
                    Text(
                      'Discover amazing opportunities and advance your career',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.outline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Buttons
              AppButton(
                label: 'Login',
                onPressed: () => Navigator.of(context).pushNamed(LoginScreen.routeName),
              ),
              SizedBox(height: AppSpacing.md),
              AppButton.outline(
                label: 'Create Account',
                onPressed: () => Navigator.of(context).pushNamed(RegisterScreen.routeName),
              ),

              SizedBox(height: AppSpacing.md),
              Center(
                child: Text(
                  'Continue as guest',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
