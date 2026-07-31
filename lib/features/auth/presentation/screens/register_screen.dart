import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../design_system/index.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../bloc/auth_bloc.dart';
import '../../../../core/localization/localization_service.dart';

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
  String? _userType;
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
    _selectedLanguage = LocalizationService.instance.currentLanguage;
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
    final loc = LocalizationService.instance;
    
    if (_userType == null) {
      context.showError(loc.translate('select_user_type'));
      return;
    }

    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      context.showError(loc.translate('please_fill_all_fields'));
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      context.showError(loc.translate('passwords_not_match'));
      return;
    }

    if (!_agreeToTerms) {
      context.showError(loc.translate('agree_to_terms'));
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

  void _changeLanguage(String languageCode) {
    setState(() => _selectedLanguage = languageCode);
    LocalizationService.instance.setLanguage(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is EmailVerificationNeeded) {
          context.showSuccess(LocalizationService.instance.translate('please_verify_email'));
          context.go('/verify-email?email=${state.email}');
        } else if (state is AuthError) {
          context.showError('${LocalizationService.instance.translate('registration_failed')}: ${state.message}');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          final isRTL = _selectedLanguage == 'ar' || _selectedLanguage == 'ku';
          final loc = LocalizationService.instance;

          return Directionality(
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
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
                              onPressed: () => context.go('/login'),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                            DropdownButton<String>(
                              value: _selectedLanguage,
                              underline: Container(),
                              items: [
                                DropdownMenuItem(
                                  value: 'en',
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/usa-flag.png',
                                        width: 24,
                                        height: 16,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 8),
                                      Text('English'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'ar',
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/iraq-flag.png',
                                        width: 24,
                                        height: 16,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 8),
                                      Text('العربية'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'ku',
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/kurdish-flag.png',
                                        width: 24,
                                        height: 16,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 8),
                                      Text('کوردی'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'tr',
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/turkish-flag.png',
                                        width: 24,
                                        height: 16,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 8),
                                      Text('Türkçe'),
                                    ],
                                  ),
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
                          loc.translate('create_account'),
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          loc.translate('register_to_get_started'),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: AppSpacing.lg),
                        Text(
                          loc.translate('i_am_a'),
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
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
                                        loc.translate('employer'),
                                        style: context.textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: _userType == 'employer'
                                              ? Colors.green
                                              : Colors.black,
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
                                        loc.translate('job_seeker'),
                                        style: context.textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: _userType == 'jobSeeker'
                                              ? Colors.blue
                                              : Colors.black,
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
                        AppTextField(
                          controller: _nameController,
                          hintText: loc.translate('full_name'),
                        ),
                        SizedBox(height: AppSpacing.md),
                        AppTextField.email(
                          controller: _emailController,
                          hintText: loc.translate('email'),
                        ),
                        SizedBox(height: AppSpacing.md),
                        AppTextField(
                          controller: _phoneController,
                          hintText: loc.translate('phone_number'),
                        ),
                        SizedBox(height: AppSpacing.md),
                        AppTextField.password(
                          controller: _passwordController,
                          hintText: loc.translate('password'),
                        ),
                        SizedBox(height: AppSpacing.md),
                        AppTextField.password(
                          controller: _confirmPasswordController,
                          hintText: loc.translate('confirm_password'),
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
                                loc.translate('agree_terms'),
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpacing.lg),
                        AppButton.glassGreen(
                          label: loc.translate('register'),
                          isLoading: isLoading,
                          onPressed: _handleRegister,
                        ),
                        SizedBox(height: AppSpacing.lg),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.go('/login');
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "${loc.translate('already_have_account')} ",
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: loc.translate('login'),
                                    style: context.textTheme.bodySmall?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
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
            ),
          );
        },
      ),
    );
  }
}
