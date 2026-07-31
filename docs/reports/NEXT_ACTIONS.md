# Next Actions - Complete Career Profile Implementation

**Current Status**: 50% Complete (Profile + Skills)  
**Remaining**: Experience, Education, Languages, Projects, Certificates (5 features)  
**Estimated Time**: 2-3 hours to complete all

---

## Strategy: Bulk Implementation

Instead of building one feature at a time, implement all 5 features in parallel using the template pattern.

---

## Step 1: Create Domain Layer for All 5 Features (20 min)

For each feature (Experience, Education, Languages, Projects, Certificates):

### Experience Domain
```dart
// lib/features/experience/domain/entities/experience_entities.dart
@freezed
class Experience with _$Experience {
  const factory Experience({
    required String id,
    required String careerProfileId,
    required String jobTitle,
    required String companyName,
    String? companyWebsite,
    required String location,
    required DateTime startDate,
    DateTime? endDate,
    required bool isCurrent,
    String? description,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Experience;
  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
}
```

### Education Domain
```dart
@freezed
class Education with _$Education {
  const factory Education({
    required String id,
    required String careerProfileId,
    required String schoolName,
    required String fieldOfStudy,
    required String degreeType,
    DateTime? startDate,
    DateTime? endDate,
    String? grade,
    String? description,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Education;
  // ... fromJson
}
```

### Languages Domain
```dart
@freezed
class Language with _$Language {
  const factory Language({
    required String id,
    required String careerProfileId,
    required String name,
    required String proficiency, // Native, Fluent, Intermediate, Basic
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Language;
}
```

### Projects Domain
```dart
@freezed
class Project with _$Project {
  const factory Project({
    required String id,
    required String careerProfileId,
    required String title,
    String? description,
    List<String>? technologies,
    String? projectUrl,
    String? imageUrl,
    required String role,
    required DateTime startDate,
    DateTime? endDate,
    required bool isCurrent,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Project;
}
```

### Certificates Domain
```dart
@freezed
class Certificate with _$Certificate {
  const factory Certificate({
    required String id,
    required String careerProfileId,
    required String name,
    required String issuer,
    String? credentialId,
    String? credentialUrl,
    required DateTime issueDate,
    DateTime? expiryDate,
    required bool doesNotExpire,
    required String verificationStatus, // PENDING, VERIFIED, REJECTED
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Certificate;
}
```

---

## Step 2: Copy Repository Interfaces (10 min)

For each feature, create repository interface following the Skill pattern:

```dart
abstract class [Feature]Repository {
  Future<List<[Feature]>> get[Features](String careerProfileId);
  Future<[Feature]> create[Feature](String careerProfileId, ...fields);
  Future<[Feature]> update[Feature](String [feature]Id, ...fields);
  Future<void> delete[Feature](String [feature]Id);
  Future<List<[Feature]>?> getCached[Features](String careerProfileId);
  Future<void> clearCached[Features](String careerProfileId);
}
```

---

## Step 3: Create Data Models (15 min)

For each feature:
- `[feature]_models.dart` with Response/Request models
- Add `.toApiJson()` extension for null-field filtering
- Add `.toDomain()` extension for entity conversion

```dart
@freezed
class [Feature]Response with _$[Feature]Response {
  const factory [Feature]Response({
    required String id,
    // ... all fields
  }) = _[Feature]Response;
  factory [Feature]Response.fromJson(Map<String, dynamic> json) =>
      _$[Feature]ResponseFromJson(json);
}

extension [Feature]ResponseX on [Feature]Response {
  [Feature] toDomain() => [Feature](
    id: id,
    // ... map all fields
  );
}
```

---

## Step 4: Create DataSources (20 min)

For each feature:
- `[feature]_remote_datasource.dart` with CRUD endpoints
- `[feature]_local_datasource.dart` with caching
- `[feature]_repository_impl.dart` with remote+local coordination

```dart
// Remote
class [Feature]RemoteDataSourceImpl implements [Feature]RemoteDataSource {
  Future<List<[Feature]Response>> get[Features](String careerProfileId) async {
    return await apiClient.get(
      '/profile/[features]',
      fromJson: (json) => _parseList(json),
    );
  }

  Future<[Feature]Response> create[Feature](String careerProfileId, data) async {
    return await apiClient.post('/profile/[features]', data: data);
  }

  Future<[Feature]Response> update[Feature](String [feature]Id, data) async {
    return await apiClient.patch('/profile/[features]/$[feature]Id', data: data);
  }

  Future<void> delete[Feature](String [feature]Id) async {
    await apiClient.delete('/profile/[features]/$[feature]Id');
  }
}
```

---

## Step 5: Create BLoCs (20 min)

For each feature, create BLoC following Skill pattern:

```dart
class [Feature]Bloc extends Bloc<[Feature]Event, [Feature]State> {
  final Get[Features]UseCase get[Features]UseCase;
  final Create[Feature]UseCase create[Feature]UseCase;
  final Update[Feature]UseCase update[Feature]UseCase;
  final Delete[Feature]UseCase delete[Feature]UseCase;

  [Feature]Bloc({
    required this.get[Features]UseCase,
    required this.create[Feature]UseCase,
    required this.update[Feature]UseCase,
    required this.delete[Feature]UseCase,
  }) : super(const [Feature]Initial()) {
    on<Load[Features]Event>(_onLoad);
    on<Create[Feature]Event>(_onCreate);
    on<Update[Feature]Event>(_onUpdate);
    on<Delete[Feature]Event>(_onDelete);
  }

  Future<void> _onLoad(Load[Features]Event event, Emitter<[Feature]State> emit) async {
    emit(const [Feature]Loading());
    try {
      final items = await get[Features]UseCase(event.careerProfileId);
      emit([Feature]Loaded(items: items));
    } catch (e) {
      emit([Feature]Error(message: e.toString()));
    }
  }

  // ... other handlers similar to Skills
}
```

---

## Step 6: Register All in Service Locator (10 min)

Add to `lib/core/di/service_locator.dart`:

```dart
// Experience
sl.registerLazySingleton<ExperienceRemoteDataSource>(
  () => ExperienceRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
);
sl.registerLazySingleton<ExperienceLocalDataSource>(
  () => ExperienceLocalDataSourceImpl(secureStorage: sl<FlutterSecureStorage>()),
);
sl.registerLazySingleton<ExperienceRepository>(
  () => ExperienceRepositoryImpl(
    remoteDataSource: sl<ExperienceRemoteDataSource>(),
    localDataSource: sl<ExperienceLocalDataSource>(),
  ),
);
sl.registerLazySingleton<GetExperienceUseCase>(
  () => GetExperienceUseCase(repository: sl<ExperienceRepository>()),
);
sl.registerLazySingleton<CreateExperienceUseCase>(
  () => CreateExperienceUseCase(repository: sl<ExperienceRepository>()),
);
sl.registerLazySingleton<UpdateExperienceUseCase>(
  () => UpdateExperienceUseCase(repository: sl<ExperienceRepository>()),
);
sl.registerLazySingleton<DeleteExperienceUseCase>(
  () => DeleteExperienceUseCase(repository: sl<ExperienceRepository>()),
);
sl.registerLazySingleton<ExperienceBloc>(
  () => ExperienceBloc(
    getExperienceUseCase: sl<GetExperienceUseCase>(),
    createExperienceUseCase: sl<CreateExperienceUseCase>(),
    updateExperienceUseCase: sl<UpdateExperienceUseCase>(),
    deleteExperienceUseCase: sl<DeleteExperienceUseCase>(),
  ),
);

// Repeat for Education, Languages, Projects, Certificates
```

---

## Step 7: Add Routes (5 min)

Add to `lib/core/router/app_router.dart`:

```dart
GoRoute(
  path: ExperienceScreen.routeName,
  builder: (context, state) => BlocProvider(
    create: (context) => sl<ExperienceBloc>(),
    child: const ExperienceScreen(),
  ),
),
// Repeat for other features
```

---

## Step 8: Build UI Screens (30-45 min per screen, optional)

For each feature, create `[feature]_screen.dart` following ProfileScreen pattern:

```dart
class ExperienceScreen extends StatefulWidget {
  static const String routeName = '/experience';

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  @override
  void initState() {
    super.initState();
    _loadExperience();
  }

  void _loadExperience() {
    context.read<ExperienceBloc>().add(LoadExperienceEvent(careerProfileId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experience')),
      body: BlocBuilder<ExperienceBloc, ExperienceState>(
        builder: (context, state) {
          if (state is ExperienceLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ExperiencesLoaded) {
            return ListView.builder(
              itemCount: state.experiences.length,
              itemBuilder: (context, index) {
                final exp = state.experiences[index];
                return ExperienceTile(
                  experience: exp,
                  onEdit: () => _editExperience(exp),
                  onDelete: () => _deleteExperience(exp.id),
                );
              },
            );
          }

          if (state is ExperienceError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const Center(child: Text('No experiences'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExperience,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addExperience() {
    // Show form dialog
  }

  void _editExperience(Experience experience) {
    // Show edit form dialog
  }

  void _deleteExperience(String id) {
    context.read<ExperienceBloc>().add(DeleteExperienceEvent(id));
  }
}
```

---

## Recommended Execution Plan

### Phase 1: Domain + Data Layers (1 hour)
✓ Complete all domain layer files  
✓ Complete all data layer files (datasources + models + repositories)  
✓ All 5 features ready for BLoC integration

### Phase 2: BLoCs + Integration (45 min)
✓ Create all 5 BLoCs  
✓ Register all in Service Locator  
✓ Add all routes  
✓ Ready for testing

### Phase 3: UI Screens (Optional, 2-3 hours)
✓ Build one screen, use as template  
✓ Copy + customize for others  
✓ Test with real backend

### Phase 4: Testing (1 hour)
✓ Test each feature with real API  
✓ Fix any issues  
✓ Verify caching works

---

## Quick Checklist

- [ ] Experience: Domain + Data + BLoC
- [ ] Education: Domain + Data + BLoC
- [ ] Languages: Domain + Data + BLoC
- [ ] Projects: Domain + Data + BLoC
- [ ] Certificates: Domain + Data + BLoC
- [ ] Register all in Service Locator
- [ ] Add all routes
- [ ] Test with real backend
- [ ] Build UI screens (if time permits)
- [ ] Integrate with Dashboard

---

## Pro Tips for Faster Implementation

1. **Use Find & Replace in IDE**:
   - Open Skills folder
   - Select all files
   - Find: `Skill` → Replace: `Experience`
   - Repeat for each feature

2. **Batch File Creation**:
   - Create all empty files at once
   - Fill them in parallel
   - Less switching between contexts

3. **Use Code Snippets**:
   - Create snippet for entity with all fields
   - Create snippet for repository interface
   - Create snippet for BLoC boilerplate

4. **Test Early**:
   - Test 1 feature fully before rest
   - Find API issues early
   - Debug pattern once, apply everywhere

5. **Defer UI Screens**:
   - Backend working first
   - UI screens can come later
   - MVP works with lists only

---

## Post-Implementation

Once all 5 Career Profile features are complete:

1. **Build Dashboard**:
   - Load Profile (get basic user info)
   - Get Skills count
   - Get Experience count
   - Calculate profile completion %
   - Show recent items from each section

2. **Test End-to-End**:
   - Create profile
   - Add 1 skill
   - Add 1 experience
   - Logout/Login
   - Verify data persisted

3. **Move to Jobs Domain**:
   - Repeat pattern for Jobs
   - Build Job Listing
   - Build Application tracking
   - Build Saved Jobs

---

## Time Estimate

| Task | Time |
|------|------|
| Domain layer (all 5) | 20 min |
| Repositories (all 5) | 10 min |
| Data models (all 5) | 15 min |
| Datasources (all 5) | 20 min |
| BLoCs (all 5) | 20 min |
| Service Locator | 10 min |
| Routes | 5 min |
| Testing | 30 min |
| UI Screens (optional) | 2-3 hours |
| **Total** | **1.5-3.5 hours** |

---

## Ready?

All patterns established. Template provided. Next developer can implement remaining features independently.

**Start with Phase 1 and work through systematically.**

Good luck! 🚀
