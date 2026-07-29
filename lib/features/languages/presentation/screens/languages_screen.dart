import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/languages_entities.dart';
import '../bloc/languages_bloc.dart';
import '../bloc/languages_event.dart';
import '../bloc/languages_state.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

/// Languages screen - View and manage languages
class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  static const String routeName = '/languages';

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  late TextEditingController _nameController;
  LanguageProficiency? _selectedProficiency;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _loadLanguages();
  }

  void _loadLanguages() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<LanguagesBloc>().add(
            LoadLanguagesEvent(authState.user.careerProfileId!),
          );
    }
  }

  void _clearControllers() {
    _nameController.clear();
    _selectedProficiency = null;
  }

  void _showAddEditDialog(BuildContext context, [Language? language]) {
    if (language != null) {
      _nameController.text = language.name;
      _selectedProficiency = language.proficiency;
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(language == null ? 'إضافة لغة' : 'تعديل اللغة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم اللغة',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<LanguageProficiency>(
                value: _selectedProficiency,
                decoration: const InputDecoration(
                  labelText: 'مستوى الإتقان',
                  border: OutlineInputBorder(),
                ),
                items: LanguageProficiency.values.map((level) {
                  final labelMap = {
                    LanguageProficiency.beginner: 'مبتدئ',
                    LanguageProficiency.intermediate: 'متوسط',
                    LanguageProficiency.advanced: 'متقدم',
                    LanguageProficiency.fluent: 'طلاقة',
                  };
                  return DropdownMenuItem(
                    value: level,
                    child: Text(labelMap[level] ?? ''),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedProficiency = value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isEmpty ||
                    _selectedProficiency == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('يرجى ملء جميع الحقول')),
                  );
                  return;
                }

                final authState = context.read<AuthBloc>().state;
                if (authState is AuthAuthenticated) {
                  if (language == null) {
                    context.read<LanguagesBloc>().add(
                          CreateLanguageEvent(
                            authState.user.careerProfileId!,
                            _nameController.text,
                            _selectedProficiency!,
                          ),
                        );
                  } else {
                    context.read<LanguagesBloc>().add(
                          UpdateLanguageEvent(
                            language.id,
                            name: _nameController.text.isNotEmpty
                                ? _nameController.text
                                : null,
                            proficiency: _selectedProficiency,
                          ),
                        );
                  }
                }
                _clearControllers();
                Navigator.pop(context);
              },
              child: Text(language == null ? 'إضافة' : 'تحديث'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اللغات'),
        elevation: 0,
      ),
      body: BlocListener<LanguagesBloc, LanguagesState>(
        listener: (context, state) {
          if (state is LanguageCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم إضافة اللغة بنجاح')),
            );
          } else if (state is LanguageUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تحديث اللغة بنجاح')),
            );
          } else if (state is LanguageDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم حذف اللغة بنجاح')),
            );
          } else if (state is LanguagesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطأ: ${state.message}')),
            );
          }
        },
        child: BlocBuilder<LanguagesBloc, LanguagesState>(
          builder: (context, state) {
            if (state is LanguagesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LanguagesLoaded) {
              if (state.languages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.language, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('لا توجد لغات مسجلة'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _showAddEditDialog(context),
                        child: const Text('إضافة لغة'),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.languages.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final language = state.languages[index];
                  final proficiencyLabels = {
                    LanguageProficiency.beginner: 'مبتدئ',
                    LanguageProficiency.intermediate: 'متوسط',
                    LanguageProficiency.advanced: 'متقدم',
                    LanguageProficiency.fluent: 'طلاقة',
                  };
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(language.name),
                      subtitle: Text(
                          proficiencyLabels[language.proficiency] ?? ''),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text('تعديل'),
                            onTap: () =>
                                _showAddEditDialog(context, language),
                          ),
                          PopupMenuItem(
                            child: const Text('حذف'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('حذف اللغة'),
                                  content: const Text(
                                      'هل أنت متأكد من حذف هذه اللغة؟'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('إلغاء'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<LanguagesBloc>().add(
                                              DeleteLanguageEvent(
                                                  language.id),
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
            } else if (state is LanguagesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('خطأ: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadLanguages,
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
        tooltip: 'إضافة لغة',
        child: const Icon(Icons.add),
      ),
    );
  }
}
