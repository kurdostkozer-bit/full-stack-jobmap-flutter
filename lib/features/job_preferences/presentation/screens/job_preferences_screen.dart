import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/job_preference_entities.dart';
import '../bloc/job_preference_bloc.dart';

class JobPreferencesScreen extends StatelessWidget {
  static const String routeName = '/job-preferences';

  const JobPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<JobPreferenceBloc>(),
      child: const _JobPreferencesView(),
    );
  }
}

class _JobPreferencesView extends StatefulWidget {
  const _JobPreferencesView();

  @override
  State<_JobPreferencesView> createState() => _JobPreferencesViewState();
}

class _JobPreferencesViewState extends State<_JobPreferencesView> {
  late String careerProfileId;

  @override
  void initState() {
    super.initState();
    // Replace with real profile id lookup (Auth/Profile)
    careerProfileId = '';
    if (careerProfileId.isNotEmpty) _loadPreferences();
  }

  void _loadPreferences() {
    context.read<JobPreferenceBloc>().add(
          GetJobPreferenceEvent(careerProfileId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Preferences'),
        elevation: 0,
      ),
      body: BlocListener<JobPreferenceBloc, JobPreferenceState>(
        listener: (context, state) {
          if (state is JobPreferenceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<JobPreferenceBloc, JobPreferenceState>(
          builder: (context, state) {
            if (state is JobPreferenceLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is JobPreferenceEmpty) {
              return _buildEmptyState();
            }

            if (state is JobPreferenceLoaded) {
              return _buildPreferencesList(state.preference);
            }

            if (state is JobPreferenceError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadPreferences,
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            return _buildEmptyState();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(),
        tooltip: 'Add Job Preferences',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Job Preferences Yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Set your job preferences to help us recommend matching jobs',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _showCreateDialog(),
            child: const Text('Create Preferences'),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesList(JobPreferenceEntity preference) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Job Titles',
            preference.jobTitles,
          ),
          _buildSection(
            'Industries',
            preference.industries,
          ),
          _buildSection(
            'Work Environment',
            preference.workEnvironments,
          ),
          _buildSection(
            'Employment Type',
            preference.employmentTypes,
          ),
          _buildSection(
            'Locations',
            preference.locations,
          ),
          const SizedBox(height: 24),
          if (preference.minSalary != null || preference.maxSalary != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Salary Range',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${preference.minSalary ?? 'N/A'} - ${preference.maxSalary ?? 'N/A'} ${preference.salaryCurrency}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showEditDialog(preference),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<JobPreferenceBloc>().add(
                          DeleteJobPreferenceEvent(preference.id),
                        );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items
              .map(
                (item) => Chip(label: Text(item)),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showCreateDialog() {
    // Job preferences form implementation pending
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Job preferences form coming soon')),
    );
  }

  void _showEditDialog(JobPreferenceEntity preference) {
    // Edit job preferences form implementation pending
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit preferences form coming soon')),
    );
  }
}
