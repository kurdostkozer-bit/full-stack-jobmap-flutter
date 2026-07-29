import 'package:flutter/material.dart';
import '../../../../design_system/index.dart';

/// Personal Information screen - part of Career Profile
class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  static const String routeName = '/profile/personal-info';

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _bioController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: 'John');
    _lastNameController = TextEditingController(text: 'Doe');
    _bioController = TextEditingController(text: 'Software Developer');
    // TODO: Load actual user data from API
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    setState(() => _isLoading = true);
    try {
      // TODO: Call update profile API
      await Future.delayed(const Duration(seconds: 1));
      context.showSuccess('Profile updated successfully');
    } catch (e) {
      context.showError('Failed to update profile: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'Personal Information',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            Center(
              child: Column(
                children: [
                  AppAvatar.large(
                    initials: 'JD',
                    isOnline: false,
                  ),
                  SizedBox(height: AppSpacing.md),
                  AppButton.outline(
                    label: 'Change Photo',
                    isFullWidth: false,
                    onPressed: () {
                      // TODO: Implement image picker
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.lg),

            // First Name
            AppTextField(
              label: 'First Name',
              controller: _firstNameController,
              prefixIcon: const Icon(Icons.person_outline),
            ),
            SizedBox(height: AppSpacing.md),

            // Last Name
            AppTextField(
              label: 'Last Name',
              controller: _lastNameController,
              prefixIcon: const Icon(Icons.person_outline),
            ),
            SizedBox(height: AppSpacing.md),

            // Bio
            AppTextField(
              label: 'Professional Bio',
              hintText: 'Tell us about yourself',
              controller: _bioController,
              maxLines: 4,
              prefixIcon: const Icon(Icons.description_outlined),
            ),
            SizedBox(height: AppSpacing.lg),

            // Save Button
            AppButton(
              label: 'Save Changes',
              isLoading: _isLoading,
              onPressed: _handleSave,
            ),
            SizedBox(height: AppSpacing.md),

            // Info Card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Completion',
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  AppProgressIndicator(
                    value: 0.25,
                    label: 'Personal Info: 25%',
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    'Complete your skills, experience, and education to improve your match rate',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
