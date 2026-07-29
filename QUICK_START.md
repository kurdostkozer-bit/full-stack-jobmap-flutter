# JobMap - Quick Start Guide

**For**: Developers joining the project or continuing the work.

---

## In 5 Minutes

### Setup
```bash
# Clone repo (if not already)
git clone <repo-url>
cd jobMap

# Install dependencies
flutter clean
flutter pub get

# Verify no lint issues
flutter analyze  # Should show zero errors
```

### Run App
```bash
# Start backend first
cd backend
npm run start:dev
# Wait for "Listening on port 3000"

# In new terminal, run Flutter app
cd ../jobMap
flutter run
# App opens, shows SplashScreen, auto-login (if token valid) or Welcome
```

### Test Auth
```bash
# In 3rd terminal
flutter test

# All tests should pass (30+)
```

---

## Architecture at a Glance

### Clean Architecture Pattern
```
lib/
├── core/
│   ├── config/         # Environment setup (dev/staging/prod)
│   ├── network/        # API client, interceptors, exceptions
│   ├── di/             # Dependency injection (GetIt)
│   ├── router/         # Navigation (GoRouter)
│   └── extensions/     # Utility extensions
│
├── features/
│   ├── auth/           # Authentication feature
│   │   ├── data/       # API calls, models, repository impl
│   │   ├── domain/     # Entities, abstract repository, usecases
│   │   └── presentation/ # UI screens, BLoC
│   │
│   ├── profile/        # Career profile (same structure)
│   └── home/           # Home/dashboard (same structure)
│
└── design_system/      # Reusable UI components & tokens
    ├── colors/         # AppColors (light/dark themes)
    ├── typography/     # AppTypography (text styles)
    ├── spacing/        # AppSpacing (margins/padding)
    ├── components/     # Buttons, inputs, cards, etc.
    └── theme/          # Material Design 3 theme
```

### Data Flow
```
User Action (UI)
    ↓
BLoC Event
    ↓
UseCase
    ↓
Repository
    ↓
RemoteDataSource / LocalDataSource
    ↓
API / Storage
    ↓
Response
    ↓
BLoC State
    ↓
UI Updated
```

---

## Key Files

| File | Purpose |
|------|---------|
| `lib/core/config/app_config.dart` | Environment URLs (dev/staging/prod) |
| `lib/core/network/api_client.dart` | HTTP client (get/post/put/patch/delete) |
| `lib/core/network/interceptors/auth_interceptor.dart` | Auto-inject tokens, handle 401 |
| `lib/core/di/service_locator.dart` | Setup all dependencies |
| `lib/features/auth/presentation/bloc/auth_bloc.dart` | Auth state management |
| `lib/features/auth/data/datasources/auth_remote_datasource.dart` | API calls |
| `lib/features/auth/data/datasources/auth_local_datasource.dart` | Token storage |
| `test/fixtures/auth_fixtures.dart` | Test data |

---

## Common Tasks

### Add New API Endpoint

1. **Add to RemoteDataSource**:
```dart
// lib/features/skills/data/datasources/skills_remote_datasource.dart
Future<List<Skill>> getSkills(String profileId) async {
  return await apiClient.get(
    '/profile/skills',
    fromJson: (json) => SkillResponse.fromJson(json).skills,
  );
}
```

2. **Add to Repository**:
```dart
// lib/features/skills/data/repositories/skills_repository_impl.dart
@override
Future<List<Skill>> getSkills(String profileId) {
  return remoteDataSource.getSkills(profileId);
}
```

3. **Add UseCase**:
```dart
// lib/features/skills/domain/usecases/get_skills_usecase.dart
class GetSkillsUseCase {
  final SkillsRepository repository;
  
  Future<List<Skill>> call(String profileId) {
    return repository.getSkills(profileId);
  }
}
```

4. **Add BLoC Event/State**:
```dart
// lib/features/skills/presentation/bloc/skills_event.dart
class GetSkillsEvent extends SkillsEvent {
  final String profileId;
  const GetSkillsEvent(this.profileId);
}

// lib/features/skills/presentation/bloc/skills_state.dart
class SkillsLoaded extends SkillsState {
  final List<Skill> skills;
  const SkillsLoaded(this.skills);
}
```

5. **Handle in BLoC**:
```dart
// lib/features/skills/presentation/bloc/skills_bloc.dart
on<GetSkillsEvent>((event, emit) async {
  emit(const SkillsLoading());
  try {
    final skills = await getSkillsUseCase(event.profileId);
    emit(SkillsLoaded(skills));
  } on ApiException catch (e) {
    emit(SkillsError(e.message));
  }
});
```

6. **Use in UI**:
```dart
// lib/features/skills/presentation/screens/skills_screen.dart
BlocBuilder<SkillsBloc, SkillsState>(
  builder: (context, state) {
    if (state is SkillsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is SkillsLoaded) {
      return ListView.builder(
        itemCount: state.skills.length,
        itemBuilder: (context, index) {
          return Text(state.skills[index].name);
        },
      );
    } else if (state is SkillsError) {
      return Center(child: Text('Error: ${state.message}'));
    }
    return const SizedBox.shrink();
  },
);
```

---

### Create New Feature

1. **Create folder structure**:
```bash
mkdir -p lib/features/new_feature/{data,domain,presentation}
mkdir -p lib/features/new_feature/data/{datasources,models,repositories}
mkdir -p lib/features/new_feature/domain/{entities,repositories,usecases}
mkdir -p lib/features/new_feature/presentation/{bloc,screens,widgets}
```

2. **Create models** (data layer)
3. **Create entities** (domain layer) - if different from models
4. **Create repository interface** (domain layer)
5. **Create repository implementation** (data layer)
6. **Create datasource** (data layer)
7. **Create usecases** (domain layer)
8. **Create BLoC** (presentation layer)
9. **Create screens** (presentation layer)
10. **Register in ServiceLocator** (core/di/service_locator.dart)

---

### Fix API Error

**Error**: `Connection refused` or `404 Not Found`

**Solution**:
1. Check backend is running: `curl http://localhost:3000/api/v1/health`
2. Check endpoint exists in backend
3. Check URL format in datasource
4. Check request body format in model

**Error**: `401 Unauthorized`

**Solution**:
1. Login first to get token
2. Token should be auto-injected in headers
3. Check `auth_token` exists in secure storage
4. Check AuthInterceptor is registered

**Error**: `Timeout`

**Solution**:
1. Check internet connection
2. Check backend is responding (slow?)
3. Increase timeout in DioProvider (currently 30s)

---

### Run Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/features/auth/presentation/bloc/auth_bloc_test.dart

# With coverage
flutter test --coverage
lcov --list coverage/lcov.info

# Watch mode (re-run on file change)
flutter test --watch
```

---

### Debug Network Issues

**Enable detailed logging**:

1. Ensure `enableLogging: true` in `AppConfig` (dev environment)
2. Check console output for all requests/responses
3. Use DevTools Network tab:
   ```bash
   flutter pub global run devtools
   # Open http://localhost:9100
   # Select app → Network tab
   ```

**Check token**:
```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
final token = await storage.read(key: 'auth_token');
print('Token: $token');
```

**Verify API endpoint**:
```bash
# Test login endpoint
curl -X POST http://localhost:3000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

---

## Documentation

**Must Read**:
- `BACKEND_INTEGRATION_GUIDE.md` - How backend works and integrates
- `TESTING_GUIDE.md` - How to test everything
- `API_INTEGRATION_CHECKLIST.md` - Track progress

**Reference**:
- `QUALITY_CHECKLIST.md` - QA verification checklist
- `SPRINT_SUMMARY.md` - What was completed last sprint
- `README.md` - Project overview (if exists)

---

## Before Committing Code

1. **Format code**:
   ```bash
   dart format lib/ test/
   ```

2. **Run linter**:
   ```bash
   flutter analyze
   # Should show zero errors
   ```

3. **Run tests**:
   ```bash
   flutter test
   # All tests should pass
   ```

4. **Verify app runs**:
   ```bash
   flutter run
   # No crashes on startup
   ```

5. **Check git diff**:
   ```bash
   git diff
   # Review changes look correct
   ```

6. **Commit with message**:
   ```bash
   git add .
   git commit -m "feat: Add login endpoint integration"
   ```

---

## Useful Commands

```bash
# Clear all cache
flutter clean
flutter pub get

# Check for issues
flutter analyze
dart format lib/ test/

# Run app
flutter run -v  # verbose output

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# DevTools
flutter pub global run devtools

# Get dependencies
flutter pub get
flutter pub upgrade

# Generate code (if using build_runner)
flutter pub run build_runner build

# Run specific test
flutter test test/features/auth/

# Check device
flutter devices

# Run on specific device
flutter run -d <device-id>
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| App won't start | `flutter clean && flutter pub get` |
| Tests fail | Check backend running, check fixtures |
| Network error | Check backend URL in AppConfig |
| 401 error | Login first, check token in secure storage |
| Lint errors | `flutter analyze`, fix issues |
| Slow app | Check DevTools Memory tab, look for leaks |
| Can't install apk | `flutter clean`, rebuild |

---

## Next Steps

1. **Verify backend running**: `curl http://localhost:3000/api/v1/health`
2. **Run app**: `flutter run`
3. **Test login flow**: Follow TESTING_GUIDE.md
4. **Report issues**: Update API_INTEGRATION_CHECKLIST.md
5. **Build Career Profile screens**: Use template from auth feature

---

## Questions?

- Check documentation files first
- Review similar implementations in code
- Check test files for usage examples
- Ask team lead or previous developer

---

**Happy coding!** 🚀
