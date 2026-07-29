import 'package:flutter/material.dart';
import '../../../../design_system/index.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/navigation_map.dart';

/// Login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      context.showError('Please fill all fields');
      return;
    }

    setState(() => _isLoading = true);
    try {
      // Placeholder: replace with real login API call.
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      context.showSuccess('Login successful!');
      // Placeholder navigation: return to root. Replace with
      // `GoRouter.of(context).go(NavigationMap.Auth.home)` or the
      // app's preferred navigation approach.
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      context.showError('Login failed: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'Login',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              'Login to continue',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
            SizedBox(height: AppSpacing.lg),

            // Email field
            AppTextField.email(
              controller: _emailController,
              hintText: 'Enter your email',
            ),
            SizedBox(height: AppSpacing.md),

            // Password field
            AppTextField.password(
              controller: _passwordController,
              hintText: 'Enter your password',
            ),
            SizedBox(height: AppSpacing.md),

            // Forgot password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to forgot-password screen
                  context.go(NavigationMap.authRoutes.forgotPassword);
                },
                child: Text(
                  'Forgot Password?',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.lg),

            // Login button
            AppButton(
              label: 'Login',
              isLoading: _isLoading,
              onPressed: _handleLogin,
            ),
            SizedBox(height: AppSpacing.md),

            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: context.colorScheme.outline)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                  child: Text('OR', style: context.textTheme.labelSmall),
                ),
                Expanded(child: Divider(color: context.colorScheme.outline)),
              ],
            ),
            SizedBox(height: AppSpacing.md),

            // Social login buttons
            AppButton.outline(
              label: 'Continue with Google',
              prefixIcon: const Icon(Icons.login),
              onPressed: () {
                // Placeholder Google login flow. Replace with real OAuth logic.
                context.showSnackBar('Google login (TODO)');
              },
            ),
            SizedBox(height: AppSpacing.md),

            // Sign up link
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: context.textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
