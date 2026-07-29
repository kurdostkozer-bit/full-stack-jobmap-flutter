import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/index.dart';
import '../../domain/entities/profile_entities.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

/// Profile screen - View and edit user profile information
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
            bio:
                _bioController.text.isNotEmpty ? _bioController.text : null,
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
        title: const Text('Profile'),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
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
              return const Center(child: Text('No profile data'));
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile header
                  _buildProfileHeader(profile),
                  SizedBox(height: AppSpacing.xl),

                  // Profile form
                  if (_isEditing) ...[
                    _buildProfileForm(),
                    SizedBox(height: AppSpacing.lg),
                    _buildActionButtons(),
                  ] else ...[
                    _buildProfileInfo(profile),
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
    return Column(
      children: [
        // Profile image
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.primaryContainer,
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
                  size: 60,
                  color: context.colorScheme.primary,
                )
              : null,
        ),
        SizedBox(height: AppSpacing.md),
        Text(
          '${profile.firstName ?? ''} ${profile.lastName ?? ''}'.trim(),
          style: context.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        if (profile.headline != null) ...[
          SizedBox(height: AppSpacing.sm),
          Text(
            profile.headline!,
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ],
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

  Widget _buildProfileInfo(CareerProfile profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard('Phone', profile.phoneNumber),
        _buildInfoCard('Headline', profile.headline),
        _buildInfoCard('Bio', profile.bio),
        _buildInfoCard('Location', profile.location),
        _buildInfoCard('Website', profile.website),
        _buildInfoCard('LinkedIn', profile.linkedinUrl),
        _buildInfoCard('GitHub', profile.githubUrl),
      ],
    );
  }

  Widget _buildInfoCard(String label, String? value) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.labelSmall,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: context.textTheme.bodyMedium,
          ),
        ],
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
