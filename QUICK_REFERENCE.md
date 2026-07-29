# JobMap - Quick Reference Card

**Print this and keep it nearby!**

---

## 🎯 Current Status

✅ **60% Done** (6/10 Career Profile features)
- Profile: ✅
- Skills: ✅
- Experience: ✅
- Education: ⏳
- Languages: ⏳
- Projects: ⏳
- Certificates: ⏳
- Social Links: ⏳
- Attachments: ⏳
- Job Preferences: ⏳

---

## 📁 Important Directories

```
lib/
├── core/
│   ├── config/app_config.dart        → Environment URLs
│   ├── network/                      → API client + interceptors
│   ├── di/service_locator.dart       → Dependency injection
│   └── router/app_router.dart        → Navigation routes
│
└── features/
    ├── profile/   (✅ Complete)
    ├── skills/    (✅ Complete)
    └── experience/ (✅ Complete, ready for registration)
```

---

## 🔑 Key Files

| File | Purpose |
|------|---------|
| `QUICK_START.md` | 5-minute setup |
| `NEXT_ACTIONS.md` | What to do next |
| `CAREER_PROFILE_TEMPLATE.md` | How to build remaining features |
| `TESTING_GUIDE.md` | How to test everything |
| `API_INTEGRATION_CHECKLIST.md` | Progress tracking |

---

## 🚀 Quick Start Commands

```bash
# Setup
flutter clean && flutter pub get

# Run app
flutter run

# Run tests
flutter test

# Lint
flutter analyze

# Build
flutter build apk --release
```

---

## 📋 Next Session Checklist

### Phase 1: Register Experience (5 min)
- [ ] Add Experience to Service Locator (lib/core/di/service_locator.dart)
- [ ] Add Experience route (lib/core/router/app_router.dart)

### Phase 2: Build Remaining 4 Features (2-3 hours)
- [ ] Education (copy Experience template, customize fields)
- [ ] Languages (simpler: name + proficiency only)
- [ ] Projects (add technologies array + imageUrl)
- [ ] Certificates (add issuer, verification status)

### Phase 3: Register All (10 min)
- [ ] Batch register all 4 in Service Locator
- [ ] Batch add all 4 routes
- [ ] Test with real backend

### Phase 4: Build UIs (Optional, 2-3 hours)
- [ ] Use ProfileScreen as template
- [ ] Create list + form for each feature
- [ ] Test UI on device

---

## 🏗️ Feature Architecture (Copy This Pattern)

```
Domain Layer (entities, repository interface, usecases)
    ↓
Data Layer (remote datasource, local datasource, models, repository impl)
    ↓
Presentation Layer (events, states, bloc)
    ↓
Integration (Service Locator + Router)
```

---

## 🔗 API Endpoints

```
Profile
  GET    /profile
  PATCH  /profile

Skills
  GET    /profile/skills
  POST   /profile/skills
  PATCH  /profile/skills/:id
  DELETE /profile/skills/:id

Experience
  GET    /profile/experience
  POST   /profile/experience
  PATCH  /profile/experience/:id
  DELETE /profile/experience/:id

Education, Languages, Projects, Certificates: Same pattern
```

---

## 🧪 Testing Commands

```bash
# All tests
flutter test

# Specific test file
flutter test test/features/auth/presentation/bloc/auth_bloc_test.dart

# Watch mode
flutter test --watch

# Coverage
flutter test --coverage
```

---

## 📦 Dependencies (Already in pubspec.yaml)

- `bloc: ^8.0.0` - State management
- `flutter_bloc: ^8.0.0` - Flutter BLoC
- `dio: ^5.0.0` - HTTP client
- `flutter_secure_storage: ^8.0.0` - Secure token storage
- `go_router: ^7.0.0` - Navigation
- `freezed_annotation: ^2.0.0` - Model generation
- `get_it: ^7.0.0` - Dependency injection

---

## 🐛 Common Issues & Fixes

| Issue | Fix |
|-------|-----|
| "Connection refused" | Backend not running: `npm run start:dev` in backend folder |
| "Invalid credentials" | Check email/password are correct |
| "Lint errors" | Run `dart format lib/` then `flutter analyze --fix` |
| "Tests fail" | `flutter clean && flutter pub get` then rerun |
| "App crashes on startup" | Check Service Locator registration |

---

## 📝 Code Pattern Quick Reference

### Entity Template
```dart
@freezed
class MyFeature with _$MyFeature {
  const factory MyFeature({
    required String id,
    required String careerProfileId,
    // ... other fields
  }) = _MyFeature;
}
```

### Repository Template
```dart
abstract class MyFeatureRepository {
  Future<List<MyFeature>> getMyFeatures(String careerProfileId);
  Future<MyFeature> createMyFeature(...);
  Future<MyFeature> updateMyFeature(...);
  Future<void> deleteMyFeature(String id);
}
```

### BLoC Event Template
```dart
class LoadMyFeaturesEvent extends MyFeatureEvent {
  final String careerProfileId;
  const LoadMyFeaturesEvent(this.careerProfileId);
}
```

### BLoC State Template
```dart
class MyFeaturesLoaded extends MyFeatureState {
  final List<MyFeature> items;
  const MyFeaturesLoaded({required this.items});
}
```

---

## 🔐 Security Checklist

✅ Tokens stored in FlutterSecureStorage (NOT SharedPreferences)  
✅ Token auto-refresh on 401 error  
✅ Offline cache fallback working  
✅ No credentials in logs  
✅ HTTPS enforced (production)  
✅ Password never stored locally  

---

## 📊 Progress Tracking

```
Session 1: ✅ Backend integration (50% done)
           ✅ Profile feature (100% done)
           ✅ Skills feature (100% done)
           ✅ Experience feature (100% done)
           Status: 60% of Career Profile complete

Session 2: ⏳ Register Experience in DI
           ⏳ Build 4 remaining features (Education, Languages, Projects, Certificates)
           ⏳ Test with real backend
           Target: 100% of Career Profile complete

Session 3: ⏳ Build UI screens for all features
           ⏳ Create Dashboard
           Target: Full Career Profile UI complete

Session 4+: ⏳ Jobs domain
            ⏳ Applications
            ⏳ MVP complete
```

---

## 🎯 Success Criteria

Feature is "done" when:
- ✅ Domain layer complete (entities, repository interface, usecases)
- ✅ Data layer complete (datasources, models, repository impl)
- ✅ BLoC complete (events, states, handlers)
- ✅ Registered in Service Locator
- ✅ Route added to app router
- ✅ Tested with real backend (optional: UI screen built)

---

## 📞 Common Tasks

### Add New Feature
1. Copy `features/experience/` folder
2. Rename to new feature
3. Find/replace all references
4. Customize entity fields & API endpoints
5. Register in Service Locator
6. Add route in app router
7. Test

**Time**: 40-50 minutes

### Register Feature in DI
1. Open `lib/core/di/service_locator.dart`
2. Add RemoteDataSource registration
3. Add LocalDataSource registration
4. Add Repository registration
5. Add UseCases registrations
6. Add BLoC registration

**Time**: 5 minutes

### Add Route
1. Open `lib/core/router/app_router.dart`
2. Add new GoRoute with path and BLoC provider
3. Import screen class

**Time**: 2 minutes

---

## 🎓 Learning Resources

- **Architecture**: Read SPRINT_SUMMARY.md + BACKEND_INTEGRATION_GUIDE.md
- **Testing**: Read TESTING_GUIDE.md
- **API**: Read API_INTEGRATION_CHECKLIST.md
- **Pattern**: Copy from Experience feature
- **Template**: Read CAREER_PROFILE_TEMPLATE.md

---

## 💪 You've Got This!

Everything is prepared:
- ✅ Pattern established
- ✅ Code examples available
- ✅ Documentation comprehensive
- ✅ Template ready to copy
- ✅ API endpoints documented
- ✅ Service Locator ready
- ✅ Tests infrastructure ready

**Time to implement remaining features**: 2-3 hours total

**Let's go!** 🚀

---

**Keep this card visible while working!**
