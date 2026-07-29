import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/social_link_entities.dart';
import '../bloc/social_link_bloc.dart';

class SocialLinksScreen extends StatelessWidget {
  static const String routeName = '/social-links';

  const SocialLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SocialLinkBloc>(),
      child: const _SocialLinksView(),
    );
  }
}

class _SocialLinksView extends StatefulWidget {
  const _SocialLinksView();

  @override
  State<_SocialLinksView> createState() => _SocialLinksViewState();
}

class _SocialLinksViewState extends State<_SocialLinksView> {
  late String careerProfileId;

  @override
  void initState() {
    super.initState();
    // Replace with real profile id lookup (Auth/Profile)
    careerProfileId = '';
    if (careerProfileId.isNotEmpty) _loadSocialLinks();
  }

  void _loadSocialLinks() {
    context.read<SocialLinkBloc>().add(
          GetSocialLinksEvent(careerProfileId: careerProfileId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio & Social Links'),
        elevation: 0,
      ),
      body: BlocListener<SocialLinkBloc, SocialLinkState>(
        listener: (context, state) {
          if (state is SocialLinkError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<SocialLinkBloc, SocialLinkState>(
          builder: (context, state) {
            if (state is SocialLinkLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SocialLinkSuccess) {
              if (state.socialLinks.isEmpty) {
                return _buildEmptyState();
              }
              return _buildSocialLinksList(state.socialLinks);
            }

            if (state is SocialLinkError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadSocialLinks,
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
        onPressed: () => _showAddDialog(),
        tooltip: 'Add Social Link',
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
            Icons.link,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Social Links Yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Add your portfolio and social media links',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinksList(List<SocialLinkEntity> links) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: links.length,
      itemBuilder: (context, index) {
        final link = links[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(
              _getPlatformIcon(link.platform),
              color: Colors.blue,
            ),
            title: Text(link.platform.label),
            subtitle: Text(
              link.url,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: link.isVisible
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onTap: () => _showLinkOptions(link),
          ),
        );
      },
    );
  }

  IconData _getPlatformIcon(SocialLinkPlatform platform) {
    switch (platform) {
      case SocialLinkPlatform.github:
        return Icons.code;
      case SocialLinkPlatform.linkedin:
        return Icons.business;
      case SocialLinkPlatform.portfolio:
        return Icons.business;
      case SocialLinkPlatform.twitter:
        return Icons.share;
      case SocialLinkPlatform.instagram:
        return Icons.camera_alt;
      case SocialLinkPlatform.codepen:
        return Icons.code;
      case SocialLinkPlatform.behance:
        return Icons.palette;
      case SocialLinkPlatform.dribbble:
        return Icons.sports_basketball;
      case SocialLinkPlatform.medium:
        return Icons.article;
      case SocialLinkPlatform.devto:
        return Icons.developer_mode;
      case SocialLinkPlatform.youtube:
        return Icons.play_circle;
      case SocialLinkPlatform.website:
        return Icons.public;
      case SocialLinkPlatform.other:
        return Icons.link;
    }
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Social Link'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select platform:'),
              const SizedBox(height: 16),
              ...SocialLinkPlatform.values.map((platform) {
                return ListTile(
                  leading: Icon(_getPlatformIcon(platform)),
                  title: Text(platform.label),
                  onTap: () {
                    Navigator.pop(context);
                    _showUrlDialog(platform);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showUrlDialog(SocialLinkPlatform platform) {
    final urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add ${platform.label}'),
        content: TextField(
          controller: urlController,
          decoration: InputDecoration(
            hintText: 'Enter ${platform.label} URL',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Placeholder: create social link implementation pending.
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Create social link (TODO)')),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showLinkOptions(SocialLinkEntity link) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                link.isVisible ? Icons.visibility_off : Icons.visibility,
              ),
              title: Text(
                link.isVisible ? 'Hide Link' : 'Show Link',
              ),
              onTap: () {
                // Placeholder: toggle not implemented yet. Replace with
                // dispatching an UpdateSocialLinkEvent to change visibility.
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Toggle visibility (TODO)')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                // Placeholder: show edit dialog not implemented yet.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit social link (TODO)')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete'),
              onTap: () {
                context.read<SocialLinkBloc>().add(
                      DeleteSocialLinkEvent(link.id),
                    );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
