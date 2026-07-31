import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../design_system/index.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../map/presentation/screens/map_screen.dart';
import '../bloc/auth_bloc.dart';
import '../../../../core/services/email_auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _phoneController;
  bool _agreeToTerms = false;
  String? _userType; // 'employer' or 'jobSeeker'

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_userType == null) {
      context.showError('Please select user type');
      return;
    }

    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      context.showError('Please fill all fields');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      context.showError('Passwords do not match');
      return;
    }

    if (!_agreeToTerms) {
      context.showError('Please agree to terms and conditions');
      return;
    }

    context.read<AuthBloc>().add(
      RegisterEvent(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        phone: _phoneController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is EmailVerificationNeeded) {
          context.showSuccess('Please verify your email');
          context.go('/verify-email?email=${state.email}');
        } else if (state is AuthError) {
          context.showError('Registration failed: ${state.message}');
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
                      TextButton(
                        onPressed: () => GoRouter.of(context).pop(),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black.withValues(alpha: 0.8),
                        ),
                      ),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        'Create Account',
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withValues(alpha: 0.95),
                        ),
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        'Register to get started',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withValues(alpha: 0.75),
                        ),
                      ),
                      SizedBox(height: AppSpacing.lg),
                      Text(
                        'I am a...',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withValues(alpha: 0.95),
                        ),
                      ),
                      SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _userType = 'employer');
                              },
                              child: Container(
                                padding: EdgeInsets.all(AppSpacing.md),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _userType == 'employer'
                                        ? Colors.green
                                        : Colors.black.withValues(alpha: 0.3),
                                    width: _userType == 'employer' ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: _userType == 'employer'
                                      ? Colors.green.withValues(alpha: 0.1)
                                      : Colors.transparent,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.business,
                                      size: 32,
                                      color: _userType == 'employer'
                                          ? Colors.green
                                          : Colors.black.withValues(alpha: 0.6),
                                    ),
                                    SizedBox(height: AppSpacing.sm),
                                    Text(
                                      'Employer',
                                      style: context.textTheme.labelMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: _userType == 'employer'
                                            ? Colors.green
                                            : Colors.black.withValues(alpha: 0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _userType = 'jobSeeker');
                              },
                              child: Container(
                                padding: EdgeInsets.all(AppSpacing.md),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _userType == 'jobSeeker'
                                        ? Colors.blue
                                        : Colors.black.withValues(alpha: 0.3),
                                    width: _userType == 'jobSeeker' ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: _userType == 'jobSeeker'
                                      ? Colors.blue.withValues(alpha: 0.1)
                                      : Colors.transparent,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.person_search,
                                      size: 32,
                                      color: _userType == 'jobSeeker'
                                          ? Colors.blue
                                          : Colors.black.withValues(alpha: 0.6),
                                    ),
                                    SizedBox(height: AppSpacing.sm),
                                    Text(
                                      'Job Seeker',
                                      style: context.textTheme.labelMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: _userType == 'jobSeeker'
                                            ? Colors.blue
                                            : Colors.black.withValues(alpha: 0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.lg),
                      SizedBox(height: AppSpacing.md),
                      AppTextField.email(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      SizedBox(height: AppSpacing.md),
                      AppTextField(
                        controller: _phoneController,
                        hintText: 'Phone Number',
                      ),
                      SizedBox(height: AppSpacing.md),
                      AppTextField.password(
                        controller: _passwordController,
                        hintText: 'Password',
                      ),
                      SizedBox(height: AppSpacing.md),
                      AppTextField.password(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                      ),
                      SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreeToTerms,
                            onChanged: (value) {
                              setState(() => _agreeToTerms = value ?? false);
                            },
                          ),
                          Expanded(
                            child: Text(
                              'I agree to terms and conditions',
                              style: context.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.lg),
                      AppButton.glassGreen(
                        label: 'Register',
                        isLoading: isLoading,
                        onPressed: _handleRegister,
                      ),
                      SizedBox(height: AppSpacing.lg),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.black.withValues(alpha: 0.7),
                            ),
                            children: [
                              TextSpan(
                                text: 'Login',
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
            ),
          );
        },
      ),
    );
  }
}
