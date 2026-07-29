import 'package:flutter/material.dart';
import '../../../../design_system/index.dart';

/// Register screen
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
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

    setState(() => _isLoading = true);
    try {
      // TODO: Call register API
      await Future.delayed(const Duration(seconds: 2));
      context.showSuccess('Registration successful!');
      // TODO: Navigate to email verification or login
    } catch (e) {
      context.showError('Registration failed: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'Create Account',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get Started',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              'Create account to explore opportunities',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
            SizedBox(height: AppSpacing.lg),

            // Name field
            AppTextField(
              label: 'Full Name',
              hintText: 'Enter your full name',
              controller: _nameController,
              prefixIcon: const Icon(Icons.person_outline),
            ),
            SizedBox(height: AppSpacing.md),

            // Email field
            AppTextField.email(
              controller: _emailController,
              hintText: 'Enter your email',
            ),
            SizedBox(height: AppSpacing.md),

            // Password field
            AppTextField.password(
              controller: _passwordController,
              hintText: 'Create password',
            ),
            SizedBox(height: AppSpacing.md),

            // Confirm password field
            AppTextField.password(
              label: 'Confirm Password',
              controller: _confirmPasswordController,
              hintText: 'Confirm your password',
            ),
            SizedBox(height: AppSpacing.md),

            // Terms checkbox
            CheckboxListTile(
              value: _agreeToTerms,
              onChanged: (value) {
                setState(() => _agreeToTerms = value ?? false);
              },
              title: Text(
                'I agree to Terms & Conditions',
                style: context.textTheme.bodySmall,
              ),
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
            SizedBox(height: AppSpacing.lg),

            // Register button
            AppButton(
              label: 'Create Account',
              isLoading: _isLoading,
              onPressed: _handleRegister,
            ),
            SizedBox(height: AppSpacing.md),

            // Sign in link
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: context.textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: 'Sign in',
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
