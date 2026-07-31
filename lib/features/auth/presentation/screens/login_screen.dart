import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/index.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../bloc/auth_bloc.dart';
import '../../../../core/localization/localization_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late LocalizationService _localizationService;
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _localizationService = LocalizationService.instance;
    _selectedLanguage = _localizationService.currentLanguage;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      context.showError(_localizationService.translate('please_fill_all_fields'));
      return;
    }

    context.read<AuthBloc>().add(
      LoginEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  Future<void> _changeLanguage(String languageCode) async {
    await _localizationService.setLanguage(languageCode);
    if (mounted) {
      setState(() => _selectedLanguage = languageCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.showSuccess(_localizationService.translate('logged_in_successfully'));
          context.go('/home');
        } else if (state is AuthError) {
          context.showError('${_localizationService.translate('login_failed')}: ${state.message}');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          final isRTL = _selectedLanguage == 'ar' || _selectedLanguage == 'ku';

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
                      crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => context.go('/welcome'),
                              child: Icon(
                                isRTL ? Icons.arrow_forward : Icons.arrow_back,
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
                          _localizationService.translate('welcome_back'),
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          _localizationService.translate('login_to_account'),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: AppSpacing.lg),
                        AppTextField.email(
                          controller: _emailController,
                          hintText: _localizationService.translate('enter_your_email'),
                        ),
                        SizedBox(height: AppSpacing.md),
                        AppTextField.password(
                          controller: _passwordController,
                          hintText: _localizationService.translate('enter_your_password'),
                        ),
                        SizedBox(height: AppSpacing.md),
                        Align(
                          alignment: isRTL ? Alignment.centerLeft : Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              context.go('/forgot-password');
                            },
                            child: Text(
                              _localizationService.translate('forgot_password'),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSpacing.lg),
                        AppButton.glassGreen(
                          label: _localizationService.translate('login'),
                          isLoading: isLoading,
                          onPressed: _handleLogin,
                        ),
                        SizedBox(height: AppSpacing.lg),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.go('/register');
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "${_localizationService.translate('dont_have_account')} ",
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: _localizationService.translate('sign_up'),
                                    style: context.textTheme.bodySmall?.copyWith(
                                      color: Colors.black,
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
            ),
          );
        },
      ),
    );
  }
}
