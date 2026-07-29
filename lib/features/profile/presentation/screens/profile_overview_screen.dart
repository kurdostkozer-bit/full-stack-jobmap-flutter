import 'package:flutter/material.dart';
import '../../../../design_system/index.dart';
import '../../../../core/navigation/navigation_map.dart';

/// Career Profile Overview - main hub for all profile sections
class ProfileOverviewScreen extends StatelessWidget {
  const ProfileOverviewScreen({Key? key}) : super(key: key);

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'Career Profile',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header Card
            AppCard(
              child: Row(
                children: [
                  AppAvatar(initials: 'JD', size: 60),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          'Software Developer',
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
            SizedBox(height: AppSpacing.lg),

            // Profile Completion Progress
            Text(
              'Profile Completion',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            AppProgressIndicator(
              value: 0.35,
              label: '35% Complete',
            ),
            SizedBox(height: AppSpacing.lg),

            // Profile Sections
            Text(
              'Profile Sections',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            _buildProfileSection(
              context,
              title: 'Personal Information',
              description: 'Your name, bio, and profile picture',
              icon: AppIcons.person,
              onTap: () => context.push(NavigationMap.JobSeeker.Profile.personalInfo),
              isComplete: true,
            ),
            SizedBox(height: AppSpacing.md),
            _buildProfileSection(
              context,
              title: 'Skills',
              description: 'Add your professional skills',
              icon: AppIcons.skill,
              onTap: () => context.push(NavigationMap.JobSeeker.Profile.skills),
              isComplete: false,
            ),
            SizedBox(height: AppSpacing.md),
            _buildProfileSection(
              context,
              title: 'Experience',
              description: 'Your work experience',
              icon: AppIcons.experience,
              onTap: () => context.push(NavigationMap.JobSeeker.Profile.experience),
              isComplete: false,
            ),
            SizedBox(height: AppSpacing.md),
            _buildProfileSection(
              context,
              title: 'Education',
              description: 'Your educational background',
              icon: AppIcons.education,
              onTap: () => context.push(NavigationMap.JobSeeker.Profile.education),
              isComplete: false,
            ),
            SizedBox(height: AppSpacing.md),
            _buildProfileSection(
              context,
              title: 'Projects',
              description: 'Showcase your work',
              icon: AppIcons.portfolio,
              onTap: () => context.push(NavigationMap.JobSeeker.Profile.projects),
              isComplete: false,
            ),
            SizedBox(height: AppSpacing.md),
            _buildProfileSection(
              context,
              title: 'Certificates',
              description: 'Add your certifications',
              icon: AppIcons.certificate,
              onTap: () => context.push(NavigationMap.JobSeeker.Profile.certificates),
              isComplete: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
    required bool isComplete,
  }) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isComplete
                  ? context.colorScheme.primary.withOpacity(0.1)
                  : context.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(
              icon,
              color: isComplete
                  ? context.colorScheme.primary
                  : context.colorScheme.outline,
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.labelLarge,
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  description,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: context.colorScheme.outline,
          ),
        ],
      ),
    );
  }
}
