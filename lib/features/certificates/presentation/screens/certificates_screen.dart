import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/certificates_entities.dart';
import '../bloc/certificates_bloc.dart';
import '../bloc/certificates_event.dart';
import '../bloc/certificates_state.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

/// Certificates screen - View and manage certificates
class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({super.key});

  static const String routeName = '/certificates';

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  late TextEditingController _nameController;
  late TextEditingController _issuerController;
  late TextEditingController _credentialIdController;
  late TextEditingController _credentialUrlController;
  DateTime? _issueDate;
  DateTime? _expiryDate;
  bool _doesNotExpire = false;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _loadCertificates();
  }

  void _initControllers() {
    _nameController = TextEditingController();
    _issuerController = TextEditingController();
    _credentialIdController = TextEditingController();
    _credentialUrlController = TextEditingController();
  }

  void _loadCertificates() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<CertificatesBloc>().add(
            LoadCertificatesEvent(authState.session.user.id),
          );
    }
  }

  void _clearControllers() {
    _nameController.clear();
    _issuerController.clear();
    _credentialIdController.clear();
    _credentialUrlController.clear();
    _issueDate = null;
    _expiryDate = null;
    _doesNotExpire = false;
  }

  void _showAddEditDialog(BuildContext context, [Certificate? certificate]) {
    if (certificate != null) {
      _nameController.text = certificate.name;
      _issuerController.text = certificate.issuer;
      _credentialIdController.text = certificate.credentialId ?? '';
      _credentialUrlController.text = certificate.credentialUrl ?? '';
      _issueDate = certificate.issueDate;
      _expiryDate = certificate.expiryDate;
      _doesNotExpire = certificate.doesNotExpire;
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(certificate == null ? 'إضافة شهادة' : 'تعديل الشهادة'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'اسم الشهادة',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _issuerController,
                  decoration: const InputDecoration(
                    labelText: 'الجهة المصدرة',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _credentialIdController,
                  decoration: const InputDecoration(
                    labelText: 'معرّف الشهادة',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _credentialUrlController,
                  decoration: const InputDecoration(
                    labelText: 'رابط التحقق',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _issueDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() => _issueDate = date);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 8),
                        Text(
                          _issueDate == null
                              ? 'تاريخ الإصدار'
                              : _issueDate.toString().split(' ')[0],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  title: const Text('لا تنتهي الصلاحية'),
                  value: _doesNotExpire,
                  onChanged: (value) {
                    setState(() => _doesNotExpire = value ?? false);
                  },
                  contentPadding: EdgeInsets.zero,
                ),
                if (!_doesNotExpire) ...[
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _expiryDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() => _expiryDate = date);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 8),
                          Text(
                            _expiryDate == null
                                ? 'تاريخ انتهاء الصلاحية'
                                : _expiryDate.toString().split(' ')[0],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                if (_nameController.text.isEmpty ||
                    _issuerController.text.isEmpty ||
                    _issueDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('يرجى ملء جميع الحقول المطلوبة')),
                  );
                  return;
                }

                final authState = context.read<AuthBloc>().state;
                if (authState is AuthAuthenticated) {
                  if (certificate == null) {
                    context.read<CertificatesBloc>().add(
                          CreateCertificateEvent(
                            authState.session.user.id,
                            _nameController.text,
                            _issuerController.text,
                            _issueDate!,
                            credentialId:
                                _credentialIdController.text.isNotEmpty
                                    ? _credentialIdController.text
                                    : null,
                            credentialUrl:
                                _credentialUrlController.text.isNotEmpty
                                    ? _credentialUrlController.text
                                    : null,
                            expiryDate: _doesNotExpire ? null : _expiryDate,
                            doesNotExpire: _doesNotExpire,
                          ),
                        );
                  } else {
                    context.read<CertificatesBloc>().add(
                          UpdateCertificateEvent(
                            certificate.id,
                            name: _nameController.text.isNotEmpty
                                ? _nameController.text
                                : null,
                            issuer: _issuerController.text.isNotEmpty
                                ? _issuerController.text
                                : null,
                            credentialId:
                                _credentialIdController.text.isNotEmpty
                                    ? _credentialIdController.text
                                    : null,
                            credentialUrl:
                                _credentialUrlController.text.isNotEmpty
                                    ? _credentialUrlController.text
                                    : null,
                            issueDate: _issueDate,
                            expiryDate: _doesNotExpire ? null : _expiryDate,
                            doesNotExpire: _doesNotExpire,
                          ),
                        );
                  }
                }
                _clearControllers();
                Navigator.pop(context);
              },
              child: Text(certificate == null ? 'إضافة' : 'تحديث'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _issuerController.dispose();
    _credentialIdController.dispose();
    _credentialUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الشهادات'),
        elevation: 0,
      ),
      body: BlocListener<CertificatesBloc, CertificatesState>(
        listener: (context, state) {
          if (state is CertificateCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم إضافة الشهادة بنجاح')),
            );
          } else if (state is CertificateUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تحديث الشهادة بنجاح')),
            );
          } else if (state is CertificateDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم حذف الشهادة بنجاح')),
            );
          } else if (state is CertificatesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطأ: ${state.message}')),
            );
          }
        },
        child: BlocBuilder<CertificatesBloc, CertificatesState>(
          builder: (context, state) {
            if (state is CertificatesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CertificatesLoaded) {
              if (state.certificates.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.verified, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('لا توجد شهادات مسجلة'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _showAddEditDialog(context),
                        child: const Text('إضافة شهادة'),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.certificates.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final certificate = state.certificates[index];
                  final statusColor = certificate.verificationStatus ==
                          CertificateVerificationStatus.verified
                      ? Colors.green
                      : certificate.verificationStatus ==
                              CertificateVerificationStatus.rejected
                          ? Colors.red
                          : Colors.orange;

                  final statusLabel = certificate.verificationStatus ==
                          CertificateVerificationStatus.verified
                      ? 'موثق'
                      : certificate.verificationStatus ==
                              CertificateVerificationStatus.rejected
                          ? 'مرفوض'
                          : 'قيد الانتظار';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(certificate.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(certificate.issuer),
                          if (certificate.credentialId != null)
                            Text(certificate.credentialId!),
                          Text(certificate.issueDate.toString().split(' ')[0]),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              statusLabel,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: const Text('تعديل'),
                                onTap: () =>
                                    _showAddEditDialog(context, certificate),
                              ),
                              PopupMenuItem(
                                child: const Text('حذف'),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('حذف الشهادة'),
                                      content: const Text(
                                          'هل أنت متأكد من حذف هذه الشهادة؟'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('إلغاء'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<CertificatesBloc>()
                                                .add(
                                                  DeleteCertificateEvent(
                                                      certificate.id),
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
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is CertificatesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('خطأ: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadCertificates,
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
        tooltip: 'إضافة شهادة',
        child: const Icon(Icons.add),
      ),
    );
  }
}
