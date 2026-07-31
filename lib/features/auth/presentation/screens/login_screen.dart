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
        body: SafeArea(
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
                    color: context.colorScheme.primary,
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
                    Expanded(child: Divider(color: context.colorScheme.outline)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                      child: Text('OR', style: context.textTheme.labelSmall),
                    ),
                    Expanded(child: Divider(color: context.colorScheme.outline)),
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
            ),
          ),
        ),
      ),
    );
  }
}
