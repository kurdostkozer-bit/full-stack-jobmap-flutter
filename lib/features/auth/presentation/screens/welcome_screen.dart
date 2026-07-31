import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/index.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/navigation/navigation_map.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../map/presentation/screens/map_screen.dart';
import '../bloc/social_auth_bloc.dart';
import 'register_screen.dart';

/// Unified Welcome & Login screen
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String routeName = '/welcome';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _showLoginForm = false;
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
      context.go(MapScreen.routeName);
    } catch (e) {
      if (!mounted) return;
      context.showError('Login failed: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleGoogleLogin() {
    context.read<SocialAuthBloc>().add(const GoogleSignInRequested());
  }

  void _handleAppleLogin() {
    context.showError('Apple login coming soon');
  }

  void _handleFacebookLogin() {
    context.showError('Facebook login coming soon');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocialAuthBloc, SocialAuthState>(
      listener: (context, state) {
        if (state is SocialAuthSuccess) {
          context.showSuccess('Logged in successfully!');
          context.go(MapScreen.routeName);
        } else if (state is SocialAuthFailure) {
          context.showError('Login failed: ${state.message}');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!_showLoginForm) ...[
                    // ============= WELCOME VIEW =============
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
                        AppIcons.briefcase,
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
                        setState(() => _showLoginForm = true);
                      },
                    ),
                    SizedBox(height: AppSpacing.md),

                    // Create Account Button
                    AppButton.outline(
                      label: 'Create Account',
                      onPressed: () => context.go(RegisterScreen.routeName),
                    ),
                    SizedBox(height: AppSpacing.md),

                    // Continue as Guest
                    Center(
                      child: TextButton(
                        onPressed: () => context.go(MapScreen.routeName),
                        child: Text(
                          'Continue as guest',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    // ============= LOGIN FORM VIEW =============
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          setState(() => _showLoginForm = false);
                          _emailController.clear();
                          _passwordController.clear();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.md),

                    // Title
                    Text(
                      'Welcome Back',
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Text(
                      'Login to your account',
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
                    SizedBox(height: AppSpacing.lg),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: context.colorScheme.outline),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                          child: Text(
                            'OR',
                            style: context.textTheme.labelSmall,
                          ),
                        ),
                        Expanded(
                          child: Divider(color: context.colorScheme.outline),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.lg),

                    // Social login buttons - Circular with logos
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google button
                          _SocialLoginButton(
                            imagePath: 'assets/images/google-logo.png',
                            onPressed: _handleGoogleLogin,
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: AppSpacing.xl),

                          // Apple button
                          _SocialLoginButton(
                            imagePath: 'assets/images/apple-logo.png',
                            onPressed: _handleAppleLogin,
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: AppSpacing.xl),

                          // Facebook button
                          _SocialLoginButton(
                            imagePath: 'assets/images/facebook-logo.png',
                            onPressed: _handleFacebookLogin,
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg),

                    // Sign up link
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: context.textTheme.bodySmall,
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    GoRouter.of(context).go(RegisterScreen.routeName),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Social login button widget
class _SocialLoginButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const _SocialLoginButton({
    required this.imagePath,
    required this.onPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(32),
          child: Center(
            child: Image.asset(
              imagePath,
              height: 40,
              width: 40,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  size: 32,
                  color: Colors.red,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
