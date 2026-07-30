import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/index.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../domain/entities/profile_entities.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

/// Profile screen - View and edit user profile information
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _headlineController;
  late TextEditingController _locationController;
  late TextEditingController _websiteController;
  late TextEditingController _linkedinController;
  late TextEditingController _githubController;

  bool _isEditing = false;
  CareerProfile? _currentProfile;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _loadProfile();
  }

  void _initControllers() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _bioController = TextEditingController();
    _headlineController = TextEditingController();
    _locationController = TextEditingController();
    _websiteController = TextEditingController();
    _linkedinController = TextEditingController();
    _githubController = TextEditingController();
  }

  void _loadProfile() {
    context.read<ProfileBloc>().add(const LoadProfileEvent());
  }

  void _populateControllers(CareerProfile profile) {
    _firstNameController.text = profile.firstName ?? '';
    _lastNameController.text = profile.lastName ?? '';
    _phoneController.text = profile.phoneNumber ?? '';
    _bioController.text = profile.bio ?? '';
    _headlineController.text = profile.headline ?? '';
    _locationController.text = profile.location ?? '';
    _websiteController.text = profile.website ?? '';
    _linkedinController.text = profile.linkedinUrl ?? '';
    _githubController.text = profile.githubUrl ?? '';
  }

  void _saveProfile() {
    context.read<ProfileBloc>().add(
      UpdateProfileEvent(
        firstName: _firstNameController.text.isNotEmpty
            ? _firstNameController.text
            : null,
        lastName: _lastNameController.text.isNotEmpty
            ? _lastNameController.text
            : null,
        phoneNumber: _phoneController.text.isNotEmpty
            ? _phoneController.text
            : null,
        bio: _bioController.text.isNotEmpty ? _bioController.text : null,
        headline: _headlineController.text.isNotEmpty
            ? _headlineController.text
            : null,
        location: _locationController.text.isNotEmpty
            ? _locationController.text
            : null,
        website: _websiteController.text.isNotEmpty
            ? _websiteController.text
            : null,
        linkedinUrl: _linkedinController.text.isNotEmpty
            ? _linkedinController.text
            : null,
        githubUrl: _githubController.text.isNotEmpty
            ? _githubController.text
            : null,
      ),
    );
  }

  int _completionPercentage(CareerProfile profile) {
    final fields = <bool>[
      profile.firstName?.isNotEmpty ?? false,
      profile.lastName?.isNotEmpty ?? false,
      profile.headline?.isNotEmpty ?? false,
      profile.bio?.isNotEmpty ?? false,
      profile.location?.isNotEmpty ?? false,
      profile.phoneNumber?.isNotEmpty ?? false,
      profile.website?.isNotEmpty ?? false,
      profile.linkedinUrl?.isNotEmpty ?? false,
      profile.githubUrl?.isNotEmpty ?? false,
    ];

    final completed = fields.where((value) => value).length;
    return ((completed / fields.length) * 100).round();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _headlineController.dispose();
    _locationController.dispose();
    _websiteController.dispose();
    _linkedinController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => setState(() => _isEditing = true),
            ),
        ],
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded || state is ProfileUpdated) {
            setState(() => _isEditing = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile saved successfully')),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            CareerProfile? profile;
            if (state is ProfileLoaded) {
              profile = state.profile;
              if (_currentProfile == null) {
                _currentProfile = profile;
                _populateControllers(profile);
              }
            } else if (state is ProfileUpdated) {
              profile = state.profile;
              _currentProfile = profile;
              _populateControllers(profile);
            } else if (state is ProfileUpdating) {
              profile = state.profile;
            } else if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: context.colorScheme.error,
                    ),
                    SizedBox(height: AppSpacing.md),
                    Text(
                      'Error: ${state.message}',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSpacing.md),
                    ElevatedButton(
                      onPressed: _loadProfile,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (profile == null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, size: 56, color: context.colorScheme.primary),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        'No profile data yet',
                        style: context.textTheme.titleMedium,
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        'Start by adding your information to complete your profile.',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.outline,
                        ),
                      ),
                      SizedBox(height: AppSpacing.lg),
                      ElevatedButton.icon(
                        onPressed: () => setState(() => _isEditing = true),
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Create Profile'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(profile),
                  SizedBox(height: AppSpacing.lg),
                  if (_isEditing) ...[
                    _buildProfileForm(),
                    SizedBox(height: AppSpacing.lg),
                    _buildActionButtons(),
                  ] else ...[
                    _buildCompletionCard(profile),
                    SizedBox(height: AppSpacing.lg),
                    _buildAboutCard(profile),
                    SizedBox(height: AppSpacing.lg),
                    _buildContactCard(profile),
                    SizedBox(height: AppSpacing.lg),
                    _buildQuickActions(),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(CareerProfile profile) {
    final fullName = '${profile.firstName ?? ''} ${profile.lastName ?? ''}'.trim();

    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: LinearGradient(
          colors: [
            context.colorScheme.primary,
            context.colorScheme.primary.withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
              image: profile.profileImageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(profile.profileImageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: profile.profileImageUrl == null
                ? Icon(
                    Icons.person,
                    size: 42,
                    color: Colors.white,
                  )
                : null,
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName.isEmpty ? 'Your Name' : fullName,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  profile.headline?.isNotEmpty == true
                      ? profile.headline!
                      : 'Add your professional headline',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 16, color: Colors.white),
                    SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        profile.location?.isNotEmpty == true
                            ? profile.location!
                            : 'Add your location',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionCard(CareerProfile profile) {
    final percent = _completionPercentage(profile);

    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Profile completion',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$percent%',
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: percent / 100,
              minHeight: 10,
              color: context.colorScheme.primary,
              backgroundColor: context.colorScheme.surfaceContainerHighest,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Complete your profile to unlock better job opportunities.',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard(CareerProfile profile) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: context.colorScheme.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            profile.bio?.isNotEmpty == true
                ? profile.bio!
                : 'Tell employers a bit about yourself and your goals.',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(CareerProfile profile) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: context.colorScheme.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact & Links',
            style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppSpacing.md),
          _buildInfoRow(Icons.phone_outlined, 'Phone', profile.phoneNumber),
          _buildInfoRow(Icons.language_outlined, 'Website', profile.website),
          _buildInfoRow(Icons.business_outlined, 'LinkedIn', profile.linkedinUrl),
          _buildInfoRow(Icons.code_outlined, 'GitHub', profile.githubUrl),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    final displayValue = value?.isNotEmpty == true ? value! : 'Not added yet';

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 18, color: context.colorScheme.primary),
          SizedBox(width: AppSpacing.sm),
          Text('$label: ', style: context.textTheme.labelMedium),
          Expanded(
            child: Text(
              displayValue,
              style: context.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _buildActionChip('Edit Profile', Icons.edit_outlined, () => setState(() => _isEditing = true)),
        _buildActionChip('Add Skills', Icons.star_outline, () {}),
        _buildActionChip('Add Experience', Icons.work_outline, () {}),
      ],
    );
  }

  Widget _buildActionChip(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: context.colorScheme.primary),
            SizedBox(width: AppSpacing.xs),
            Text(label, style: context.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileForm() {
    return Column(
      children: [
        _buildTextField('First Name', _firstNameController),
        SizedBox(height: AppSpacing.md),
        _buildTextField('Last Name', _lastNameController),
        SizedBox(height: AppSpacing.md),
        _buildTextField('Phone', _phoneController, keyboardType: TextInputType.phone),
        SizedBox(height: AppSpacing.md),
        _buildTextField('Headline', _headlineController),
        SizedBox(height: AppSpacing.md),
        _buildTextField('Bio', _bioController, maxLines: 3),
        SizedBox(height: AppSpacing.md),
        _buildTextField('Location', _locationController),
        SizedBox(height: AppSpacing.md),
        _buildTextField('Website', _websiteController, keyboardType: TextInputType.url),
        SizedBox(height: AppSpacing.md),
        _buildTextField('LinkedIn', _linkedinController, keyboardType: TextInputType.url),
        SizedBox(height: AppSpacing.md),
        _buildTextField('GitHub', _githubController, keyboardType: TextInputType.url),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              setState(() => _isEditing = false);
              if (_currentProfile != null) {
                _populateControllers(_currentProfile!);
              }
            },
            child: const Text('Cancel'),
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: ElevatedButton(
            onPressed: _saveProfile,
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }
}
