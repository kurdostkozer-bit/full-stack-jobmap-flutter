# Career Profile Feature Template

**Status**: 5/10 Career Profile features implemented

## Completed Features ✅
1. Profile (Get/Update basic info)
2. Skills (Get/Create/Update/Delete with list)

## Pattern to Replicate

Each Career Profile feature follows this exact structure:

```
features/[feature_name]/
├── domain/
│   ├── entities/
│   │   └── [feature]_entities.dart           # Freezed models
│   ├── repositories/
│   │   └── [feature]_repository.dart         # Abstract interface
│   └── usecases/
│       └── [feature]_usecases.dart           # GetX, CreateX, UpdateX, DeleteX
│
├── data/
│   ├── datasources/
│   │   ├── [feature]_remote_datasource.dart  # API calls
│   │   └── [feature]_local_datasource.dart   # Local cache
│   ├── models/
│   │   └── [feature]_models.dart             # Response/Request models
│   └── repositories/
│       └── [feature]_repository_impl.dart    # Repository implementation
│
└── presentation/
    ├── bloc/
    │   ├── [feature]_event.dart              # Events: Load, Create, Update, Delete, Refresh
    │   ├── [feature]_state.dart              # States: Initial, Loading, Loaded, Creating, Created, Error
    │   └── [feature]_bloc.dart               # BLoC handlers
    └── screens/
        └── [feature]_screen.dart             # List + CRUD UI
```

---

## Remaining Features to Implement

### #6. Experience (Job History)

**API Endpoints**:
```
GET    /profile/experience
POST   /profile/experience
PATCH  /profile/experience/:id
DELETE /profile/experience/:id
```

**Entity Fields**:
```dart
String id
String careerProfileId
String jobTitle          (required)
String companyName       (required)
String? companyWebsite
String location          (required)
DateTime startDate       (required)
DateTime? endDate
bool isCurrent           (required)
String? description
int displayOrder
DateTime createdAt
DateTime updatedAt
```

**BLoC Events**: LoadExperienceEvent, CreateExperienceEvent, UpdateExperienceEvent, DeleteExperienceEvent, RefreshExperienceEvent

**Key Points**:
- Sort by `startDate DESC` (newest first)
- When `isCurrent=true`, endDate can be null
- Display date range as "Jan 2020 - Present" if isCurrent

---

### #7. Education (School History)

**API Endpoints**:
```
GET    /profile/education
POST   /profile/education
PATCH  /profile/education/:id
DELETE /profile/education/:id
```

**Entity Fields**:
```dart
String id
String careerProfileId
String schoolName        (required)
String fieldOfStudy      (required)
String degreeType        (required: Bachelor, Master, PhD, etc.)
DateTime? startDate
DateTime? endDate
String? grade
String? description
int displayOrder
DateTime createdAt
DateTime updatedAt
```

**Key Points**:
- Date range optional (students might not remember exact dates)
- Display as "Jan 2018 - May 2022" or just "2022" if only year provided
- Filter by degreeType if needed

---

### #8. Languages (Known Languages)

**API Endpoints**:
```
GET    /profile/languages
POST   /profile/languages
PATCH  /profile/languages/:id
DELETE /profile/languages/:id
```

**Entity Fields**:
```dart
String id
String careerProfileId
String name              (required: English, Spanish, French, etc.)
String proficiency       (required: Native, Fluent, Intermediate, Basic)
int displayOrder
DateTime createdAt
DateTime updatedAt
```

**Key Points**:
- Proficiency is enum (not numeric like Skills)
- No description needed
- Simple list display with language name + proficiency level

---

### #9. Projects (Portfolio Projects)

**API Endpoints**:
```
GET    /profile/projects
POST   /profile/projects
PATCH  /profile/projects/:id
DELETE /profile/projects/:id
```

**Entity Fields**:
```dart
String id
String careerProfileId
String title             (required)
String? description
List<String>? technologies  (e.g., ["Flutter", "Dart", "Firebase"])
String? projectUrl
String? imageUrl
String role              (required: Lead, Contributor, etc.)
DateTime startDate       (required)
DateTime? endDate
bool isCurrent           (required)
int displayOrder
DateTime createdAt
DateTime updatedAt
```

**Key Points**:
- technologies stored as array in database
- Can have image thumbnail
- Can be linked to external URL
- Sort by `startDate DESC` and `displayOrder ASC`

---

### #10. Certificates (Achievements/Certifications)

**API Endpoints**:
```
GET    /profile/certificates
POST   /profile/certificates
PATCH  /profile/certificates/:id
DELETE /profile/certificates/:id
```

**Entity Fields**:
```dart
String id
String careerProfileId
String name              (required: e.g., "AWS Solutions Architect")
String issuer            (required: e.g., "Amazon Web Services")
String? credentialId     (e.g., "AWS-12345")
String? credentialUrl    (e.g., "https://aws.amazon.com/verification/12345")
DateTime issueDate       (required)
DateTime? expiryDate
bool doesNotExpire       (required: if true, expiryDate can be null)
String verificationStatus  (enum: PENDING, VERIFIED, REJECTED)
int displayOrder
DateTime createdAt
DateTime updatedAt
```

**Key Points**:
- Can have credential ID for verification
- Can link to credential URL (often provided by issuer)
- expiryDate optional if `doesNotExpire=true`
- Display: "Issued Jan 2023" or "Issued Jan 2023 - Expires Dec 2024"
- Filter by verificationStatus (VERIFIED, PENDING, REJECTED)

---

## Implementation Strategy

### Option A: Sequential (Thorough)
Build one feature at a time:
1. Write all files for Experience
2. Register in Service Locator
3. Add route
4. Test
5. Repeat for Education, Languages, etc.

**Time**: ~30 minutes per feature

### Option B: Bulk (Fast)
1. Create all 5 features' domain/data layers
2. Create all 5 features' BLoCs
3. Register all in Service Locator at once
4. Add all routes at once
5. Build UI screens one by one

**Time**: ~2 hours total

### Option C: Template + Generation (Fastest)
Use code generation or copy-paste from Skills template for all 5 features, then customize:
- Copy Skills folder → Experience folder
- Find/Replace all instances of "Skill" → "Experience"
- Adjust entity fields
- Adjust API endpoints
- Adjust field names in forms

**Time**: ~1 hour total

---

## Quick Checklist for Each Feature

For each new feature (Experience, Education, Languages, Projects, Certificates):

### Domain Layer
- [ ] `[feature]_entities.dart` - Freezed model with all fields
- [ ] `[feature]_repository.dart` - Abstract interface (CRUD methods)
- [ ] `[feature]_usecases.dart` - Get, Create, Update, Delete, GetCached usecases

### Data Layer
- [ ] `[feature]_remote_datasource.dart` - API endpoints (GET, POST, PATCH, DELETE)
- [ ] `[feature]_local_datasource.dart` - Cache with key pattern `[feature]_[careerProfileId]`
- [ ] `[feature]_models.dart` - Response/Request models with toDomain() extension
- [ ] `[feature]_repository_impl.dart` - Remote with fallback to cache

### Presentation Layer
- [ ] `[feature]_event.dart` - Load, Create, Update, Delete, Refresh events
- [ ] `[feature]_state.dart` - Initial, Loading, Loaded, Creating, Created, Updating, Updated, Deleting, Deleted, Error states
- [ ] `[feature]_bloc.dart` - Event handlers with error handling

### Integration
- [ ] Register datasources in `service_locator.dart`
- [ ] Register repository in `service_locator.dart`
- [ ] Register usecases in `service_locator.dart`
- [ ] Register BLoC in `service_locator.dart`
- [ ] Add route in `app_router.dart` (if building UI screen)

---

## Service Locator Registration Template

```dart
// [Feature] Remote DataSource
sl.registerLazySingleton<[Feature]RemoteDataSource>(
  () => [Feature]RemoteDataSourceImpl(apiClient: sl<ApiClient>()),
);

// [Feature] Local DataSource
sl.registerLazySingleton<[Feature]LocalDataSource>(
  () => [Feature]LocalDataSourceImpl(secureStorage: sl<FlutterSecureStorage>()),
);

// [Feature] Repository
sl.registerLazySingleton<[Feature]Repository>(
  () => [Feature]RepositoryImpl(
    remoteDataSource: sl<[Feature]RemoteDataSource>(),
    localDataSource: sl<[Feature]LocalDataSource>(),
  ),
);

// [Feature] UseCases
sl.registerLazySingleton<Get[Feature]UseCase>(
  () => Get[Feature]UseCase(repository: sl<[Feature]Repository>()),
);

sl.registerLazySingleton<Create[Feature]UseCase>(
  () => Create[Feature]UseCase(repository: sl<[Feature]Repository>()),
);

sl.registerLazySingleton<Update[Feature]UseCase>(
  () => Update[Feature]UseCase(repository: sl<[Feature]Repository>()),
);

sl.registerLazySingleton<Delete[Feature]UseCase>(
  () => Delete[Feature]UseCase(repository: sl<[Feature]Repository>()),
);

// [Feature] BLoC
sl.registerLazySingleton<[Feature]Bloc>(
  () => [Feature]Bloc(
    get[Feature]UseCase: sl<Get[Feature]UseCase>(),
    create[Feature]UseCase: sl<Create[Feature]UseCase>(),
    update[Feature]UseCase: sl<Update[Feature]UseCase>(),
    delete[Feature]UseCase: sl<Delete[Feature]UseCase>(),
  ),
);
```

---

## Router Registration Template

```dart
GoRoute(
  path: '[Feature]Screen.routeName',
  builder: (context, state) => BlocProvider(
    create: (context) => sl<[Feature]Bloc>(),
    child: const [Feature]Screen(),
  ),
),
```

---

## Next Steps

1. **Complete remaining 5 features** following this template
2. **Register all in Service Locator** (bulk)
3. **Create UI screens** for list + CRUD forms
4. **Test with real backend** to ensure API endpoints work
5. **Build Dashboard** to show profile completion %
6. **Proceed to Jobs domain** once Profile is complete

---

## Estimated Time

- **Domain/Data layers for 5 features**: ~1-2 hours
- **BLoCs for 5 features**: ~1 hour
- **Service Locator + Routing**: ~15 minutes
- **UI Screens for 5 features**: ~2-3 hours
- **Testing**: ~1 hour

**Total**: ~5-7 hours to complete all Career Profile features

Once complete, you'll have a fully functional Career Profile module with:
- 7 features (Profile, Skills, Experience, Education, Languages, Projects, Certificates)
- Full CRUD operations
- Caching + network error handling
- BLoC state management
- Ready for Dashboard integration

---

## Tips for Faster Implementation

1. **Use IDE search & replace** - Copy Skills folder, rename everything
2. **Batch register** - Add all to Service Locator at once
3. **Skip UI for now** - Domain/Data done, UI screens later
4. **Reuse components** - TextFields, buttons, dialogs already exist in design system
5. **Test incrementally** - Test 1-2 features, then scale up

---

**Status**: Template complete, ready to implement remaining 5 features
