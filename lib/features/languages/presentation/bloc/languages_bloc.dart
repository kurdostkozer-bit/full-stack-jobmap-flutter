import 'package:bloc/bloc.dart';
import '../../domain/entities/languages_entities.dart';
import '../../domain/usecases/languages_usecases.dart';
import '../../../../core/network/app_exception.dart';
import 'languages_event.dart';
import 'languages_state.dart';

class LanguagesBloc extends Bloc<LanguagesEvent, LanguagesState> {
  final GetLanguagesUseCase getLanguagesUseCase;
  final CreateLanguageUseCase createLanguageUseCase;
  final UpdateLanguageUseCase updateLanguageUseCase;
  final DeleteLanguageUseCase deleteLanguageUseCase;

  LanguagesBloc({
    required this.getLanguagesUseCase,
    required this.createLanguageUseCase,
    required this.updateLanguageUseCase,
    required this.deleteLanguageUseCase,
  }) : super(const LanguagesInitial()) {
    on<LoadLanguagesEvent>(_onLoadLanguages);
    on<CreateLanguageEvent>(_onCreateLanguage);
    on<UpdateLanguageEvent>(_onUpdateLanguage);
    on<DeleteLanguageEvent>(_onDeleteLanguage);
    on<RefreshLanguagesEvent>(_onRefreshLanguages);
  }

  Future<void> _onLoadLanguages(
    LoadLanguagesEvent event,
    Emitter<LanguagesState> emit,
  ) async {
    emit(const LanguagesLoading());
    try {
      final languages = await getLanguagesUseCase(event.careerProfileId);
      emit(LanguagesLoaded(languages: languages));
    } on AppException catch (e) {
      emit(LanguagesError(message: e.message));
    } catch (e) {
      emit(LanguagesError(message: 'Failed to load languages: $e'));
    }
  }

  Future<void> _onCreateLanguage(
    CreateLanguageEvent event,
    Emitter<LanguagesState> emit,
  ) async {
    final currentState = state;
    final List<Language> previousLanguages =
        currentState is LanguagesLoaded ? currentState.languages : <Language>[];

    try {
      emit(LanguageCreating(currentLanguages: previousLanguages));

      final newLanguage = await createLanguageUseCase(
        event.careerProfileId,
        event.name,
        event.proficiency,
      );

      final updatedLanguages = [...previousLanguages, newLanguage];
      emit(LanguageCreated(languages: updatedLanguages));
    } on AppException catch (e) {
      emit(LanguagesError(
        message: e.message,
        previousLanguages: previousLanguages,
      ));
    } catch (e) {
      emit(LanguagesError(
        message: 'Failed to create language: $e',
        previousLanguages: previousLanguages,
      ));
    }
  }

  Future<void> _onUpdateLanguage(
    UpdateLanguageEvent event,
    Emitter<LanguagesState> emit,
  ) async {
    final currentState = state;
    final List<Language> previousLanguages =
        currentState is LanguagesLoaded ? currentState.languages : <Language>[];

    try {
      emit(LanguageUpdating(currentLanguages: previousLanguages));

      final updatedLanguage = await updateLanguageUseCase(
        event.languageId,
        name: event.name,
        proficiency: event.proficiency,
      );

      final updatedLanguages = previousLanguages.map((l) {
        return l.id == event.languageId ? updatedLanguage : l;
      }).toList();

      emit(LanguageUpdated(languages: updatedLanguages));
    } on AppException catch (e) {
      emit(LanguagesError(
        message: e.message,
        previousLanguages: previousLanguages,
      ));
    } catch (e) {
      emit(LanguagesError(
        message: 'Failed to update language: $e',
        previousLanguages: previousLanguages,
      ));
    }
  }

  Future<void> _onDeleteLanguage(
    DeleteLanguageEvent event,
    Emitter<LanguagesState> emit,
  ) async {
    final currentState = state;
    final List<Language> previousLanguages =
        currentState is LanguagesLoaded ? currentState.languages : <Language>[];

    try {
      emit(LanguageDeleting(currentLanguages: previousLanguages));

      await deleteLanguageUseCase(event.languageId);

      final updatedLanguages =
          previousLanguages.where((l) => l.id != event.languageId).toList();

      emit(LanguageDeleted(languages: updatedLanguages));
    } on AppException catch (e) {
      emit(LanguagesError(
        message: e.message,
        previousLanguages: previousLanguages,
      ));
    } catch (e) {
      emit(LanguagesError(
        message: 'Failed to delete language: $e',
        previousLanguages: previousLanguages,
      ));
    }
  }

  Future<void> _onRefreshLanguages(
    RefreshLanguagesEvent event,
    Emitter<LanguagesState> emit,
  ) async {
    try {
      final languages = await getLanguagesUseCase(event.careerProfileId);
      emit(LanguagesLoaded(languages: languages));
    } on AppException catch (e) {
      emit(LanguagesError(message: e.message));
    } catch (e) {
      emit(LanguagesError(message: 'Failed to refresh languages: $e'));
    }
  }
}
