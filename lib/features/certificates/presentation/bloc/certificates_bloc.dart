import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/certificates_entities.dart';
import '../../domain/usecases/certificates_usecases.dart';
import '../../../../core/network/models/api_exception.dart';
import 'certificates_event.dart';
import 'certificates_state.dart';

class CertificatesBloc extends Bloc<CertificatesEvent, CertificatesState> {
  final GetCertificatesUseCase getCertificatesUseCase;
  final CreateCertificateUseCase createCertificateUseCase;
  final UpdateCertificateUseCase updateCertificateUseCase;
  final DeleteCertificateUseCase deleteCertificateUseCase;

  CertificatesBloc({
    required this.getCertificatesUseCase,
    required this.createCertificateUseCase,
    required this.updateCertificateUseCase,
    required this.deleteCertificateUseCase,
  }) : super(const CertificatesInitial()) {
    on<LoadCertificatesEvent>(_onLoadCertificates);
    on<CreateCertificateEvent>(_onCreateCertificate);
    on<UpdateCertificateEvent>(_onUpdateCertificate);
    on<DeleteCertificateEvent>(_onDeleteCertificate);
    on<RefreshCertificatesEvent>(_onRefreshCertificates);
  }

  Future<void> _onLoadCertificates(
    LoadCertificatesEvent event,
    Emitter<CertificatesState> emit,
  ) async {
    emit(const CertificatesLoading());
    try {
      final certificates = await getCertificatesUseCase(event.careerProfileId);
      emit(CertificatesLoaded(certificates: certificates));
    } on ApiException catch (e) {
      debugPrint('❌ CertificatesBloc: Error - ${e.message}');
      emit(CertificatesError(message: e.message));
    } catch (e) {
      emit(CertificatesError(message: 'Failed to load certificates: $e'));
    }
  }

  Future<void> _onCreateCertificate(
    CreateCertificateEvent event,
    Emitter<CertificatesState> emit,
  ) async {
    final currentState = state;
    final List<Certificate> previousCertificates = currentState is CertificatesLoaded 
        ? currentState.certificates 
        : <Certificate>[];

    try {
      emit(CertificateCreating(currentCertificates: previousCertificates));

      final newCertificate = await createCertificateUseCase(
        event.careerProfileId,
        event.name,
        event.issuer,
        event.issueDate,
        credentialId: event.credentialId,
        credentialUrl: event.credentialUrl,
        expiryDate: event.expiryDate,
        doesNotExpire: event.doesNotExpire,
      );

      final updatedCertificates = [...previousCertificates, newCertificate];
      emit(CertificateCreated(certificates: updatedCertificates));
    } on ApiException catch (e) {
      debugPrint('❌ CertificatesBloc: Error - ${e.message}');
      emit(CertificatesError(
        message: e.message,
        previousCertificates: previousCertificates,
      ));
    } catch (e) {
      emit(CertificatesError(
        message: 'Failed to create certificate: $e',
        previousCertificates: previousCertificates,
      ));
    }
  }

  Future<void> _onUpdateCertificate(
    UpdateCertificateEvent event,
    Emitter<CertificatesState> emit,
  ) async {
    final currentState = state;
    final List<Certificate> previousCertificates =
        currentState is CertificatesLoaded ? currentState.certificates : <Certificate>[];

    try {
      emit(CertificateUpdating(currentCertificates: previousCertificates));

      final updatedCertificate = await updateCertificateUseCase(
        event.certificateId,
        name: event.name,
        issuer: event.issuer,
        credentialId: event.credentialId,
        credentialUrl: event.credentialUrl,
        issueDate: event.issueDate,
        expiryDate: event.expiryDate,
        doesNotExpire: event.doesNotExpire,
      );

      final updatedCertificates = previousCertificates.map((c) {
        return c.id == event.certificateId ? updatedCertificate : c;
      }).toList();

      emit(CertificateUpdated(certificates: updatedCertificates));
    } on ApiException catch (e) {
      debugPrint('❌ CertificatesBloc: Error - ${e.message}');
      emit(CertificatesError(
        message: e.message,
        previousCertificates: previousCertificates,
      ));
    } catch (e) {
      emit(CertificatesError(
        message: 'Failed to update certificate: $e',
        previousCertificates: previousCertificates,
      ));
    }
  }

  Future<void> _onDeleteCertificate(
    DeleteCertificateEvent event,
    Emitter<CertificatesState> emit,
  ) async {
    final currentState = state;
    final List<Certificate> previousCertificates =
        currentState is CertificatesLoaded ? currentState.certificates : <Certificate>[];

    try {
      emit(CertificateDeleting(currentCertificates: previousCertificates));

      await deleteCertificateUseCase(event.certificateId);

      final updatedCertificates = previousCertificates
          .where((c) => c.id != event.certificateId)
          .toList();

      emit(CertificateDeleted(certificates: updatedCertificates));
    } on ApiException catch (e) {
      debugPrint('❌ CertificatesBloc: Error - ${e.message}');
      emit(CertificatesError(
        message: e.message,
        previousCertificates: previousCertificates,
      ));
    } catch (e) {
      emit(CertificatesError(
        message: 'Failed to delete certificate: $e',
        previousCertificates: previousCertificates,
      ));
    }
  }

  Future<void> _onRefreshCertificates(
    RefreshCertificatesEvent event,
    Emitter<CertificatesState> emit,
  ) async {
    try {
      final certificates = await getCertificatesUseCase(event.careerProfileId);
      emit(CertificatesLoaded(certificates: certificates));
    } on ApiException catch (e) {
      debugPrint('❌ CertificatesBloc: Error - ${e.message}');
      emit(CertificatesError(message: e.message));
    } catch (e) {
      emit(CertificatesError(message: 'Failed to refresh certificates: $e'));
    }
  }
}
