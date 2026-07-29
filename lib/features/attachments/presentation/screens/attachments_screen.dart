import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/attachment_entities.dart';
import '../bloc/attachment_bloc.dart';

class AttachmentsScreen extends StatelessWidget {
  static const String routeName = '/attachments';

  const AttachmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AttachmentBloc>(),
      child: const _AttachmentsView(),
    );
  }
}

class _AttachmentsView extends StatefulWidget {
  const _AttachmentsView();

  @override
  State<_AttachmentsView> createState() => _AttachmentsViewState();
}

class _AttachmentsViewState extends State<_AttachmentsView> {
  late String careerProfileId;

  @override
  void initState() {
    super.initState();
    careerProfileId = 'profile_id'; // TODO: Get from auth or profile
    _loadAttachments();
  }

  void _loadAttachments() {
    context.read<AttachmentBloc>().add(
          GetAttachmentsEvent(careerProfileId: careerProfileId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume & Attachments'),
        elevation: 0,
      ),
      body: BlocListener<AttachmentBloc, AttachmentState>(
        listener: (context, state) {
          if (state is AttachmentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<AttachmentBloc, AttachmentState>(
          builder: (context, state) {
            if (state is AttachmentLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AttachmentSuccess) {
              if (state.attachments.isEmpty) {
                return _buildEmptyState();
              }
              return _buildAttachmentsList(state.attachments);
            }

            if (state is AttachmentError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadAttachments,
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
        onPressed: () => _showUploadDialog(),
        tooltip: 'Add Attachment',
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
            Icons.description_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Attachments Yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Upload your resume and other documents',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsList(List<AttachmentEntity> attachments) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: attachments.length,
      itemBuilder: (context, index) {
        final attachment = attachments[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(
              _getFileIcon(attachment.fileType),
              color: Colors.blue,
            ),
            title: Text(attachment.fileName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(attachment.category.label),
                if (attachment.description != null)
                  Text(attachment.description!),
              ],
            ),
            trailing: attachment.isPrimary
                ? const Chip(label: Text('Primary'))
                : null,
            onTap: () => _showAttachmentOptions(attachment),
          ),
        );
      },
    );
  }

  IconData _getFileIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'docx':
      case 'doc':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      default:
        return Icons.attach_file;
    }
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Attachment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select attachment type:'),
            const SizedBox(height: 16),
            ...AttachmentCategory.values.map((category) {
              return ListTile(
                title: Text(category.label),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement file picker
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showAttachmentOptions(AttachmentEntity attachment) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (attachment.category == AttachmentCategory.resume &&
                !attachment.isPrimary)
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Set as Primary'),
                onTap: () {
                  context.read<AttachmentBloc>().add(
                        SetPrimaryResumeEvent(attachment.id),
                      );
                  Navigator.pop(context);
                },
              ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Show edit dialog
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete'),
              onTap: () {
                context.read<AttachmentBloc>().add(
                      DeleteAttachmentEvent(attachment.id),
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
