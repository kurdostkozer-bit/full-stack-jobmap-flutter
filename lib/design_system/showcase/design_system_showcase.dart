import 'package:flutter/material.dart';
import '../index.dart';

/// Complete Design System Showcase - Demonstrates all tokens and components
class DesignSystemShowcase extends StatefulWidget {
  const DesignSystemShowcase({Key? key}) : super(key: key);

  @override
  State<DesignSystemShowcase> createState() => _DesignSystemShowcaseState();
}

class _DesignSystemShowcaseState extends State<DesignSystemShowcase>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System v1.0'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Colors'),
            Tab(text: 'Typography'),
            Tab(text: 'Components'),
            Tab(text: 'Spacing'),
            Tab(text: 'Icons'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildColorsTab(context),
          _buildTypographyTab(context),
          _buildComponentsTab(context),
          _buildSpacingTab(context),
          _buildIconsTab(context),
        ],
      ),
    );
  }

  /// Colors Tab
  Widget _buildColorsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Light Theme', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _colorBox('Primary', AppColors.primary),
              _colorBox('Secondary', AppColors.secondary),
              _colorBox('Tertiary', AppColors.tertiary),
              _colorBox('Error', AppColors.error),
              _colorBox('Success', AppColors.success),
              _colorBox('Warning', AppColors.warning),
              _colorBox('Info', AppColors.info),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          Text('Dark Theme', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _colorBox('Primary Light', AppColors.primaryLight),
              _colorBox('Secondary Light', AppColors.secondaryLight),
              _colorBox('Tertiary Light', AppColors.tertiaryLight),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          Text('Neutral Scale', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _colorBox('Neutral 50', AppColors.neutral50),
              _colorBox('Neutral 100', AppColors.neutral100),
              _colorBox('Neutral 200', AppColors.neutral200),
              _colorBox('Neutral 300', AppColors.neutral300),
              _colorBox('Neutral 400', AppColors.neutral400),
              _colorBox('Neutral 500', AppColors.neutral500),
              _colorBox('Neutral 600', AppColors.neutral600),
              _colorBox('Neutral 700', AppColors.neutral700),
              _colorBox('Neutral 800', AppColors.neutral800),
              _colorBox('Neutral 900', AppColors.neutral900),
            ],
          ),
        ],
      ),
    );
  }

  /// Typography Tab
  Widget _buildTypographyTab(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Display', style: context.textTheme.displayLarge),
          SizedBox(height: AppSpacing.md),
          Text('Heading Large', style: context.textTheme.headlineLarge),
          SizedBox(height: AppSpacing.md),
          Text('Heading Medium', style: context.textTheme.headlineMedium),
          SizedBox(height: AppSpacing.md),
          Text('Title Large', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          Text('Body Large', style: context.textTheme.bodyLarge),
          SizedBox(height: AppSpacing.md),
          Text('Body Medium', style: context.textTheme.bodyMedium),
          SizedBox(height: AppSpacing.md),
          Text('Body Small', style: context.textTheme.bodySmall),
          SizedBox(height: AppSpacing.md),
          Text('Label Large', style: context.textTheme.labelLarge),
          SizedBox(height: AppSpacing.md),
          Text('Label Medium', style: context.textTheme.labelMedium),
          SizedBox(height: AppSpacing.md),
          Text('Label Small', style: context.textTheme.labelSmall),
        ],
      ),
    );
  }

  /// Components Tab
  Widget _buildComponentsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Buttons', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          AppButton(label: 'Primary', onPressed: () {}),
          SizedBox(height: AppSpacing.sm),
          AppButton.secondary(label: 'Secondary', onPressed: () {}),
          SizedBox(height: AppSpacing.sm),
          AppButton.tertiary(label: 'Tertiary', onPressed: () {}),
          SizedBox(height: AppSpacing.sm),
          AppButton.outline(label: 'Outline', onPressed: () {}),
          SizedBox(height: AppSpacing.md),
          Text('Input Fields', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          AppTextField(label: 'Text Field', hintText: 'Enter text...'),
          SizedBox(height: AppSpacing.md),
          AppTextField.email(),
          SizedBox(height: AppSpacing.md),
          AppTextField.password(),
          SizedBox(height: AppSpacing.md),
          Text('Cards', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          AppCard(
            child: Text('Basic Card', style: context.textTheme.bodyLarge),
          ),
          SizedBox(height: AppSpacing.md),
          AppCard.elevated(
            child: Text('Elevated Card', style: context.textTheme.bodyLarge),
          ),
          SizedBox(height: AppSpacing.md),
          AppCard.outlined(
            child: Text('Outlined Card', style: context.textTheme.bodyLarge),
          ),
          SizedBox(height: AppSpacing.md),
          Text('Chips & Badges', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              AppChip(label: 'Chip 1'),
              AppChip(label: 'Chip 2', selected: true),
              AppBadge(label: '5', child: const Icon(Icons.notifications)),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Text('Avatars', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          Row(
            children: [
              AppAvatar(initials: 'JD'),
              SizedBox(width: AppSpacing.md),
              AppAvatar.large(initials: 'AB', isOnline: true),
              SizedBox(width: AppSpacing.md),
              AppAvatar.small(initials: 'XY'),
            ],
          ),
        ],
      ),
    );
  }

  /// Spacing Tab
  Widget _buildSpacingTab(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('8dp Scale System', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          _spacingRow('XS', AppSpacing.xs),
          SizedBox(height: AppSpacing.md),
          _spacingRow('SM', AppSpacing.sm),
          SizedBox(height: AppSpacing.md),
          _spacingRow('MD', AppSpacing.md),
          SizedBox(height: AppSpacing.md),
          _spacingRow('LG', AppSpacing.lg),
          SizedBox(height: AppSpacing.md),
          _spacingRow('XL', AppSpacing.xl),
          SizedBox(height: AppSpacing.md),
          _spacingRow('XXL', AppSpacing.xxl),
        ],
      ),
    );
  }

  /// Icons Tab
  Widget _buildIconsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Navigation Icons', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _iconBox(AppIcons.home, 'Home'),
              _iconBox(AppIcons.search, 'Search'),
              _iconBox(AppIcons.notifications, 'Notifications'),
              _iconBox(AppIcons.messages, 'Messages'),
              _iconBox(AppIcons.profile, 'Profile'),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          Text('Job Icons', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _iconBox(AppIcons.briefcase, 'Briefcase'),
              _iconBox(AppIcons.jobs, 'Jobs'),
              _iconBox(AppIcons.company, 'Company'),
              _iconBox(AppIcons.location, 'Location'),
              _iconBox(AppIcons.salary, 'Salary'),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          Text('Status Icons', style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _iconBox(AppIcons.success, 'Success'),
              _iconBox(AppIcons.error, 'Error'),
              _iconBox(AppIcons.warning, 'Warning'),
              _iconBox(AppIcons.info, 'Info'),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper: Color box
  Widget _colorBox(String name, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.colorScheme.outline),
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(name, style: context.textTheme.labelSmall),
      ],
    );
  }

  /// Helper: Spacing row
  Widget _spacingRow(String label, double size) {
    return Row(
      children: [
        SizedBox(width: 40, child: Text(label)),
        Container(
          width: size * 4,
          height: 30,
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: AppSpacing.sm),
        Text('${size.toInt()}dp'),
      ],
    );
  }

  /// Helper: Icon box
  Widget _iconBox(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 32, color: context.colorScheme.primary),
        SizedBox(height: AppSpacing.xs),
        Text(label, style: context.textTheme.labelSmall),
      ],
    );
  }
}
