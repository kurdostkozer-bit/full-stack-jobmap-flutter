import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/index.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/navigation/navigation_map.dart';
import '../../../map/presentation/screens/map_screen.dart';
import '../bloc/auth_bloc.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  String _selectedLanguage = 'en';

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

  void _handleLogin() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      context.showError('Please fill all fields');
      return;
    }

    context.read<AuthBloc>().add(
      LoginEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  void _changeLanguage(String languageCode) {
    setState(() => _selectedLanguage = languageCode);
    // TODO: Implement language change when app supports i18n
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.showSuccess('Logged in successfully!');
          context.go(MapScreen.routeName);
        } else if (state is AuthError) {
          context.showError('Login failed: ${state.message}');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFFCD34D),
                    const Color(0xFFFDE047),
                  ],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => GoRouter.of(context).pop(),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black.withValues(alpha: 0.8),
                            ),
                          ),
                          DropdownButton<String>(
                            value: _selectedLanguage,
                            underline: Container(),
                            items: const [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: 'ar',
                                child: Text('العربية'),
                              ),
                              DropdownMenuItem(
                                value: 'ku',
                                child: Text('کوردی'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                _changeLanguage(value);
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        'Welcome Back',
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withValues(alpha: 0.95),
                        ),
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        'Login to your account',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withValues(alpha: 0.75),
                        ),
                      ),
                      SizedBox(height: AppSpacing.lg),
                      AppTextField.email(
                        controller: _emailController,
                        hintText: 'Enter your email',
                      ),
                      SizedBox(height: AppSpacing.md),
                      AppTextField.password(
                        controller: _passwordController,
                        hintText: 'Enter your password',
                      ),
                      SizedBox(height: AppSpacing.md),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
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
                      AppButton.glassGreen(
                        label: 'Login',
                        isLoading: isLoading,
                        onPressed: _handleLogin,
                      ),
                      SizedBox(height: AppSpacing.lg),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            context.go(RegisterScreen.routeName);
                          },
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
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
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
        },
      ),
    );
  }
}
