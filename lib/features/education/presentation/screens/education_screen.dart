import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/index.dart';
import '../../domain/entities/education_entities.dart';
import '../bloc/education_bloc.dart';
import '../bloc/education_event.dart';
import '../bloc/education_state.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

/// Education screen - View and manage education records
class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  static const String routeName = '/education';

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  late TextEditingController _schoolController;
  late TextEditingController _degreeController;
  late TextEditingController _fieldOfStudyController;
  late TextEditingController _descriptionController;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _currentlyStudying = false;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _loadEducations();
  }

  void _initControllers() {
    _schoolController = TextEditingController();
    _degreeController = TextEditingController();
    _fieldOfStudyController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  void _loadEducations() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<EducationBloc>().add(
            LoadEducationsEvent(authState.user.careerProfileId!),
          );
    }
  }

  void _clearControllers() {
    _schoolController.clear();
    _degreeController.clear();
    _fieldOfStudyController.clear();
    _descriptionController.clear();
    _startDate = null;
    _endDate = null;
    _currentlyStudying = false;
  }

  void _showAddEditDialog(BuildContext context, [Education? education]) {
    if (education != null) {
      _schoolController.text = education.school;
      _degreeController.text = education.degree;
      _fieldOfStudyController.text = education.fieldOfStudy ?? '';
      _descriptionController.text = education.description ?? '';
      _startDate = education.startDate;
      _endDate = education.endDate;
      _currentlyStudying = education.currentlyStudying;
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(education == null ? 'إضافة تعليم' : 'تعديل التعليم'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _schoolController,
                  decoration: const InputDecoration(
                    labelText: 'المدرسة/الجامعة',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _degreeController,
                  decoration: const InputDecoration(
                    labelText: 'الدرجة العلمية',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _fieldOfStudyController,
                  decoration: const InputDecoration(
                    labelText: 'التخصص',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _startDate ?? DateTime.now(),
                            firstDate: DateTime(1990),
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
                                ? 'تاريخ البداية'
                                : _startDate.toString().split(' ')[0],
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
                            firstDate: DateTime(1990),
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
                                ? 'تاريخ النهاية'
                                : _endDate.toString().split(' ')[0],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text('أدرس حاليًا'),
                  value: _currentlyStudying,
                  onChanged: (value) {
                    setState(() => _currentlyStudying = value ?? false);
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'الوصف',
                    border: OutlineInputBorder(),
                  ),
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
                final authState = context.read<AuthBloc>().state;
                if (authState is AuthAuthenticated) {
                  if (education == null) {
                    context.read<EducationBloc>().add(
                          CreateEducationEvent(
                            authState.user.careerProfileId!,
                            _schoolController.text,
                            _degreeController.text,
                            fieldOfStudy:
                                _fieldOfStudyController.text.isNotEmpty
                                    ? _fieldOfStudyController.text
                                    : null,
                            startDate: _startDate,
                            endDate: _endDate,
                            currentlyStudying: _currentlyStudying,
                            description: _descriptionController.text.isNotEmpty
                                ? _descriptionController.text
                                : null,
                          ),
                        );
                  } else {
                    context.read<EducationBloc>().add(
                          UpdateEducationEvent(
                            education.id,
                            school: _schoolController.text.isNotEmpty
                                ? _schoolController.text
                                : null,
                            degree: _degreeController.text.isNotEmpty
                                ? _degreeController.text
                                : null,
                            fieldOfStudy:
                                _fieldOfStudyController.text.isNotEmpty
                                    ? _fieldOfStudyController.text
                                    : null,
                            startDate: _startDate,
                            endDate: _endDate,
                            currentlyStudying: _currentlyStudying,
                            description: _descriptionController.text.isNotEmpty
                                ? _descriptionController.text
                                : null,
                          ),
                        );
                  }
                }
                _clearControllers();
                Navigator.pop(context);
              },
              child: Text(education == null ? 'إضافة' : 'تحديث'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _schoolController.dispose();
    _degreeController.dispose();
    _fieldOfStudyController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التعليم'),
        elevation: 0,
      ),
      body: BlocListener<EducationBloc, EducationState>(
        listener: (context, state) {
          if (state is EducationCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم إضافة التعليم بنجاح')),
            );
          } else if (state is EducationUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تحديث التعليم بنجاح')),
            );
          } else if (state is EducationDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم حذف التعليم بنجاح')),
            );
          } else if (state is EducationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطأ: ${state.message}')),
            );
          }
        },
        child: BlocBuilder<EducationBloc, EducationState>(
          builder: (context, state) {
            if (state is EducationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EducationsLoaded) {
              if (state.educations.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.school, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('لا توجد سجلات تعليمية'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _showAddEditDialog(context),
                        child: const Text('إضافة تعليم'),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.educations.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final education = state.educations[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(education.school),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(education.degree),
                          if (education.fieldOfStudy != null)
                            Text(education.fieldOfStudy!),
                        ],
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text('تعديل'),
                            onTap: () =>
                                _showAddEditDialog(context, education),
                          ),
                          PopupMenuItem(
                            child: const Text('حذف'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('حذف التعليم'),
                                  content: const Text(
                                      'هل أنت متأكد من حذف هذا السجل؟'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('إلغاء'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<EducationBloc>().add(
                                              DeleteEducationEvent(
                                                  education.id),
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
            } else if (state is EducationError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('خطأ: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadEducations,
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
        tooltip: 'إضافة تعليم',
        child: const Icon(Icons.add),
      ),
    );
  }
}
