import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/index.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/navigation/navigation_map.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../bloc/social_auth_bloc.dart';

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
      context.go(HomeScreen.routeName);
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
    // TODO: Implement Apple login
  }

  void _handleFacebookLogin() {
    context.showError('Facebook login coming soon');
    // TODO: Implement Facebook login
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocialAuthBloc, SocialAuthState>(
      listener: (context, state) {
        if (state is SocialAuthSuccess) {
          context.showSuccess('Logged in successfully!');
          context.go(HomeScreen.routeName);
        } else if (state is SocialAuthFailure) {
          context.showError('Login failed: ${state.message}');
        }
      },
      child: Scaffold(
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
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      TextButton(
                        onPressed: () => GoRouter.of(context).pop(),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black.withValues(alpha: 0.8),
                        ),
                      ),
                      SizedBox(height: AppSpacing.md),

                      // Title
                      Text(
                        'Welcome Back',
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withValues(alpha: 0.95),
                          shadows: [
                            Shadow(
                              color: Colors.white.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        'Login to your account',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withValues(alpha: 0.75),
                          shadows: [
                            Shadow(
                              color: Colors.white.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
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
                              color: Colors.black.withValues(alpha: 0.8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacing.lg),

                      // Login button - Glass Green
                      AppButton.glassGreen(
                        label: 'Login',
                        isLoading: _isLoading,
                        onPressed: _handleLogin,
                      ),
                      SizedBox(height: AppSpacing.lg),

                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.black.withValues(alpha: 0.2),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                            ),
                            child: Text(
                              'OR',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: Colors.black.withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black.withValues(alpha: 0.2),
                            ),
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
                              icon: Icons.g_mobiledata,
                              label: 'G',
                              onPressed: _handleGoogleLogin,
                              backgroundColor: Colors.black.withValues(alpha: 0.15),
                            ),
                            SizedBox(width: AppSpacing.xl),

                            // Apple button
                            _SocialLoginButton(
                              icon: Icons.apple,
                              label: 'A',
                              onPressed: _handleAppleLogin,
                              backgroundColor: Colors.black.withValues(alpha: 0.15),
                            ),
                            SizedBox(width: AppSpacing.xl),

                            // Facebook button
                            _SocialLoginButton(
                              imagePath: 'assets/images/facebook-logo.jpg',
                              onPressed: _handleFacebookLogin,
                              backgroundColor: Colors.black.withValues(alpha: 0.15),
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
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.black.withValues(alpha: 0.7),
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign up',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.black.withValues(alpha: 0.95),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Social login button widget
class _SocialLoginButton extends StatelessWidget {
  final String? imagePath;
  final IconData? icon;
  final String? label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const _SocialLoginButton({
    this.imagePath,
    this.icon,
    this.label,
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
            child: imagePath != null
                ? Image.asset(
                    imagePath!,
                    height: 40,
                    width: 40,
                    fit: BoxFit.contain,
                  )
                : icon != null
                    ? Icon(
                        icon,
                        size: 32,
                        color: Colors.black.withValues(alpha: 0.8),
                      )
                    : Text(
                        label ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
