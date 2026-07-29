import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/projects_entities.dart';
import '../bloc/projects_bloc.dart';
import '../bloc/projects_event.dart';
import '../bloc/projects_state.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

/// Projects screen - View and manage projects
class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  static const String routeName = '/projects';

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _roleController;
  late TextEditingController _imageUrlController;
  late TextEditingController _technologiesController;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrently = false;
  List<String> _technologies = [];

  @override
  void initState() {
    super.initState();
    _initControllers();
    _loadProjects();
  }

  void _initControllers() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _roleController = TextEditingController();
    _imageUrlController = TextEditingController();
    _technologiesController = TextEditingController();
  }

  void _loadProjects() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ProjectsBloc>().add(
            LoadProjectsEvent(authState.user.careerProfileId!),
          );
    }
  }

  void _clearControllers() {
    _titleController.clear();
    _descriptionController.clear();
    _roleController.clear();
    _imageUrlController.clear();
    _technologiesController.clear();
    _startDate = null;
    _endDate = null;
    _isCurrently = false;
    _technologies = [];
  }

  void _showAddEditDialog(BuildContext context, [Project? project]) {
    if (project != null) {
      _titleController.text = project.title;
      _descriptionController.text = project.description ?? '';
      _roleController.text = project.role ?? '';
      _imageUrlController.text = project.imageUrl ?? '';
      _startDate = project.startDate;
      _endDate = project.endDate;
      _isCurrently = project.isCurrently;
      _technologies = List.from(project.technologies);
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(project == null ? 'إضافة مشروع' : 'تعديل المشروع'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'اسم المشروع',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descriptionController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'الوصف',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _roleController,
                  decoration: const InputDecoration(
                    labelText: 'دورك',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _startDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() => _startDate = date);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _startDate == null
                                ? 'البداية'
                                : _startDate.toString().split(' ')[0],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _endDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            setState(() => _endDate = date);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _endDate == null
                                ? 'النهاية'
                                : _endDate.toString().split(' ')[0],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  title: const Text('مشروع حالي'),
                  value: _isCurrently,
                  onChanged: (value) {
                    setState(() => _isCurrently = value ?? false);
                  },
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'رابط الصورة',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _technologiesController,
                        decoration: const InputDecoration(
                          labelText: 'التكنولوجيا',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (_technologiesController.text.isNotEmpty) {
                          setState(() {
                            _technologies.add(_technologiesController.text);
                            _technologiesController.clear();
                          });
                        }
                      },
                      child: const Text('أضف'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_technologies.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: _technologies.map((tech) {
                      return Chip(
                        label: Text(tech),
                        onDeleted: () {
                          setState(() => _technologies.remove(tech));
                        },
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isEmpty ||
                    _technologies.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'يرجى إدخال العنوان وإضافة تكنولوجيا واحدة على الأقل')),
                  );
                  return;
                }

                final authState = context.read<AuthBloc>().state;
                if (authState is AuthAuthenticated) {
                  if (project == null) {
                    context.read<ProjectsBloc>().add(
                          CreateProjectEvent(
                            authState.user.careerProfileId!,
                            _titleController.text,
                            _technologies,
                            description: _descriptionController.text.isNotEmpty
                                ? _descriptionController.text
                                : null,
                            role: _roleController.text.isNotEmpty
                                ? _roleController.text
                                : null,
                            startDate: _startDate,
                            endDate: _endDate,
                            isCurrently: _isCurrently,
                            imageUrl: _imageUrlController.text.isNotEmpty
                                ? _imageUrlController.text
                                : null,
                          ),
                        );
                  } else {
                    context.read<ProjectsBloc>().add(
                          UpdateProjectEvent(
                            project.id,
                            title: _titleController.text.isNotEmpty
                                ? _titleController.text
                                : null,
                            description: _descriptionController.text.isNotEmpty
                                ? _descriptionController.text
                                : null,
                            role: _roleController.text.isNotEmpty
                                ? _roleController.text
                                : null,
                            technologies:
                                _technologies.isNotEmpty ? _technologies : null,
                            startDate: _startDate,
                            endDate: _endDate,
                            isCurrently: _isCurrently,
                            imageUrl: _imageUrlController.text.isNotEmpty
                                ? _imageUrlController.text
                                : null,
                          ),
                        );
                  }
                }
                _clearControllers();
                Navigator.pop(context);
              },
              child: Text(project == null ? 'إضافة' : 'تحديث'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _roleController.dispose();
    _imageUrlController.dispose();
    _technologiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المشاريع'),
        elevation: 0,
      ),
      body: BlocListener<ProjectsBloc, ProjectsState>(
        listener: (context, state) {
          if (state is ProjectCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم إضافة المشروع بنجاح')),
            );
          } else if (state is ProjectUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تحديث المشروع بنجاح')),
            );
          } else if (state is ProjectDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم حذف المشروع بنجاح')),
            );
          } else if (state is ProjectsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطأ: ${state.message}')),
            );
          }
        },
        child: BlocBuilder<ProjectsBloc, ProjectsState>(
          builder: (context, state) {
            if (state is ProjectsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectsLoaded) {
              if (state.projects.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.work, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('لا توجد مشاريع مسجلة'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _showAddEditDialog(context),
                        child: const Text('إضافة مشروع'),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.projects.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final project = state.projects[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(project.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (project.role != null) Text(project.role!),
                          Wrap(
                            spacing: 4,
                            children: project.technologies
                                .map((tech) =>
                                    Chip(label: Text(tech), compact: true))
                                .toList(),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text('تعديل'),
                            onTap: () => _showAddEditDialog(context, project),
                          ),
                          PopupMenuItem(
                            child: const Text('حذف'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('حذف المشروع'),
                                  content: const Text(
                                      'هل أنت متأكد من حذف هذا المشروع؟'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('إلغاء'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<ProjectsBloc>().add(
                                              DeleteProjectEvent(project.id),
                                            );
                                        Navigator.pop(context);
                                      },
                                      child: const Text('حذف'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is ProjectsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('خطأ: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadProjects,
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(context),
        tooltip: 'إضافة مشروع',
        child: const Icon(Icons.add),
      ),
    );
  }
}
