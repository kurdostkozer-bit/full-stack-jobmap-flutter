# JobMap Project Index

**Status**: Stabilization Sprint - Backend Integration Infrastructure Ready

**Last Updated**: July 29, 2026

---

## 📚 Documentation Structure

### Getting Started
1. **[QUICK_START.md](QUICK_START.md)** - Start here!
   - 5-minute setup
   - Common tasks
   - Troubleshooting

2. **[SPRINT_SUMMARY.md](SPRINT_SUMMARY.md)** - What's been done
   - Architecture overview
   - Current status
   - Next actions

### Integration & Development
3. **[BACKEND_INTEGRATION_GUIDE.md](BACKEND_INTEGRATION_GUIDE.md)** - How to integrate
   - Phase-by-phase approach
   - API endpoints (30+)
   - Error handling
   - Career Profile structure

4. **[TESTING_GUIDE.md](TESTING_GUIDE.md)** - How to test everything
   - 10 test categories
   - 100+ test scenarios
   - Manual testing steps
   - Network error simulation

### Progress Tracking
5. **[API_INTEGRATION_CHECKLIST.md](API_INTEGRATION_CHECKLIST.md)** - Track progress
   - Auth endpoints (8 total)
   - Career Profile endpoints (30+ total)
   - Completion status

6. **[QUALITY_CHECKLIST.md](QUALITY_CHECKLIST.md)** - QA verification
   - Authentication
   - Network
   - UI/UX
   - Security
   - Performance

---

## 🏗️ Project Structure

```
jobMap/
├── lib/
│   ├── core/                    # Infrastructure layer
│   │   ├── config/              # Environment config (dev/staging/prod)
│   │   ├── network/             # API client, interceptors, exceptions
│   │   ├── di/                  # Dependency injection
│   │   ├── router/              # GoRouter navigation
│   │   ├── extensions/          # Utility extensions
│   │   └── infrastructure/      # Services (cache, offline, etc.)
│   │
│   ├── design_system/           # Reusable UI components
│   │   ├── colors/              # Theme colors
│   │   ├── typography/          # Text styles
│   │   ├── spacing/             # Layout spacing
│   │   ├── components/          # Buttons, inputs, cards, etc.
│   │   └── extensions/          # BuildContext, String, DateTime extensions
│   │
│   └── features/                # Feature modules
│       ├── auth/                # ✅ Authentication (DONE)
│       │   ├── data/            # Datasources, models, repository impl
│       │   ├── domain/          # Entities, abstract repository, usecases
│       │   └── presentation/    # Screens, BLoC
│       │
│       ├── profile/             # 🏗️ Career Profile (IN PROGRESS)
│       │   └── presentation/screens/ (PersonalInfoScreen, ProfileOverviewScreen)
│       │
│       └── home/                # ⏳ Dashboard (PLANNED)
│
├── test/
│   ├── fixtures/                # Test data
│   ├── features/                # Feature tests
│   └── design_system/           # Component tests
│
└── Documentation
    ├── QUICK_START.md           # ← Start here!
    ├── SPRINT_SUMMARY.md        # What's done this sprint
    ├── BACKEND_INTEGRATION_GUIDE.md
    ├── TESTING_GUIDE.md
    ├── API_INTEGRATION_CHECKLIST.md
    ├── QUALITY_CHECKLIST.md
    └── INDEX.md (this file)
```

---

## 🎯 Current Phase

### Stabilization Sprint - Backend Integration Infrastructure

**What's Complete** ✅:
- Auth system architecture (domain/data/presentation)
- All auth datasources (remote + local)
- All auth screens (Splash, Welcome, Login, Register, etc.)
- Enhanced AuthInterceptor with token refresh
- SplashScreen with auto-login
- Comprehensive documentation
- 30+ test cases
- Career Profile screen stubs

**What's Next** 🔄:
1. Verify backend API running
2. Run integration tests
3. Build Career Profile data layer
4. Build Career Profile screens
5. Create Dashboard with real data

**Not Started** ⏳:
- Jobs domain
- Applications domain
- Saved jobs feature
- Notifications
- Matching/Recommendation engine

---

## 🔌 Key Integrations

### Network Layer
- **Dio**: HTTP client with interceptors
- **FlutterSecureStorage**: Secure token storage
- **GoRouter**: Navigation

### State Management
- **BLoC**: State management pattern
- **GetIt**: Dependency injection

### Design
- **Material Design 3**: Modern UI
- **Freezed**: Model generation
- **Equatable**: Value comparison

---

## 📋 Important Files

| File | Purpose | Status |
|------|---------|--------|
| `lib/core/config/app_config.dart` | Environment URLs | ✅ Complete |
| `lib/core/network/dio_provider.dart` | Dio configuration | ✅ Enhanced |
| `lib/core/network/interceptors/auth_interceptor.dart` | Token handling | ✅ Enhanced |
| `lib/core/di/service_locator.dart` | Dependency injection | ✅ Complete |
| `lib/features/auth/presentation/screens/splash_screen.dart` | Auto-login | ✅ New |
| `test/fixtures/auth_fixtures.dart` | Test data | ✅ New |
| `test/features/auth/*/` | Auth tests | ✅ New (30+ cases) |

---

## 🧪 Testing Overview

### Test Files Created
- `test/fixtures/auth_fixtures.dart` - Reusable test data
- `test/features/auth/presentation/bloc/auth_bloc_test.dart` - BLoC tests
- `test/features/auth/data/repositories/auth_repository_impl_test.dart` - Repository tests
- `test/design_system/components/buttons_test.dart` - Component tests

### Test Coverage
- **Unit Tests**: 30+ tests
- **Integration Tests**: Ready to run (need backend)
- **Manual Tests**: 100+ scenarios in TESTING_GUIDE.md

### Run Tests
```bash
flutter test                    # All tests
flutter test --coverage         # With coverage report
flutter test path/to/test.dart  # Specific test
```

---

## 🚀 Quick Commands

```bash
# Setup
flutter clean && flutter pub get

# Run app
flutter run

# Test
flutter test

# Lint
flutter analyze

# Build
flutter build apk --release

# DevTools
flutter pub global run devtools
```

---

## 🎓 Learning Path

### For New Developers

1. **Read**: QUICK_START.md (5 min)
2. **Read**: SPRINT_SUMMARY.md (10 min)
3. **Run**: App locally (`flutter run`) (5 min)
4. **Read**: BACKEND_INTEGRATION_GUIDE.md (15 min)
5. **Review**: Key files (auth datasources, repository, BLoC)
6. **Read**: TESTING_GUIDE.md (10 min)
7. **Run**: Tests (`flutter test`) (5 min)
8. **Start**: Contributing!

**Total**: ~1 hour to understand project

### For Continuing Development

1. Check [API_INTEGRATION_CHECKLIST.md](API_INTEGRATION_CHECKLIST.md) for progress
2. Pick next task from BACKEND_INTEGRATION_GUIDE.md
3. Follow Clean Architecture pattern from existing features
4. Add tests before UI
5. Update checklist when done

---

## 📊 Progress Dashboard

### Backend Integration (Phase 1)
```
Auth Endpoints:        ████████░ 80% (Infrastructure ready, testing needed)
Career Profile:        ░░░░░░░░░  0% (Structure planned)
Dashboard:             ░░░░░░░░░  0% (Planned)
Testing:              ██████░░░ 60% (Unit tests done, integration ready)
Documentation:        █████████ 90% (Comprehensive guides created)
```

### Timeline
- **This Sprint**: Infrastructure & Documentation ✅
- **Next Sprint**: Auth Testing & Career Profile Backend
- **Sprint 3**: Career Profile UI & Dashboard
- **Sprint 4**: Jobs Domain
- **Sprint 5+**: Advanced Features

---

## 📞 Support

### Getting Help

1. **Check documentation first**
   - QUICK_START.md
   - BACKEND_INTEGRATION_GUIDE.md
   - TESTING_GUIDE.md

2. **Review existing code**
   - Auth feature (complete example)
   - Design System components
   - Test files (usage examples)

3. **Debug tips**
   - Enable logging in AppConfig (dev mode)
   - Use Flutter DevTools
   - Check backend logs
   - Verify API endpoints with curl

---

## ✅ Pre-Implementation Checklist

Before starting a new feature:

- [ ] Read BACKEND_INTEGRATION_GUIDE.md phase for feature
- [ ] Check API_INTEGRATION_CHECKLIST.md for status
- [ ] Review similar feature implementation (e.g., auth for profile)
- [ ] Follow Clean Architecture (domain/data/presentation)
- [ ] Write tests first (TDD)
- [ ] Test with real backend
- [ ] Update checklist when done

---

## 🎯 Success Criteria

### Auth Integration ✅
- [x] All endpoints documented
- [x] Datasources implemented
- [x] Interceptor handles tokens
- [x] Auto-login works
- [ ] All scenarios tested

### Career Profile 🏗️
- [ ] All endpoints documented
- [ ] DataSources implemented
- [ ] Screens created
- [ ] Forms validated
- [ ] All scenarios tested

### Dashboard ⏳
- [ ] Real data from API
- [ ] Profile completion %
- [ ] Recommended jobs
- [ ] Application stats

---

## 📅 Next Meetings/Actions

**Immediate**:
1. Verify backend running
2. Run integration tests
3. Document any issues

**This Week**:
1. Fix any integration issues
2. Start Career Profile backend layer
3. Update TESTING_GUIDE.md with results

**Next Week**:
1. Career Profile screens
2. Dashboard skeleton
3. Real data integration

---

## 📖 Related Documentation

**Backend** (if in same repo):
- Backend README
- API documentation
- Database schema

**Team Standards** (if exists):
- Code style guide
- Git workflow
- PR guidelines
- Architecture decisions

---

## Version History

| Date | Sprint | Status | Changes |
|------|--------|--------|---------|
| 2024-07-29 | Stabilization Sprint | In Progress | Infrastructure complete, docs created |
| TBD | Sprint 2 | Planned | Auth testing, Career Profile backend |
| TBD | Sprint 3 | Planned | Career Profile UI, Dashboard |
| TBD | Sprint 4 | Planned | Jobs domain |

---

## Key Decision Points

| Decision | Chosen | Why |
|----------|--------|-----|
| Architecture | Clean Architecture | Scalable, testable, maintainable |
| State Management | BLoC | Consistent with team pattern |
| Token Storage | FlutterSecureStorage | Secure, not SharedPreferences |
| API Client | Dio | Interceptors, modern, popular |
| Package Manager | pub | Flutter default |
| Design | Material Design 3 | Modern, accessible |

---

## Resources & Tools

**Essential**:
- Flutter SDK
- VS Code or Android Studio
- Git

**Optional**:
- Postman / Thunder Client (API testing)
- DevTools (Flutter debugging)
- Network proxy (for testing errors)

**Documentation**:
- Flutter docs: https://flutter.dev
- Clean Architecture: https://resocoder.com
- BLoC: https://bloclibrary.dev

---

## End of Index

**Next**: Read [QUICK_START.md](QUICK_START.md) to begin!

For questions or updates, see team lead or previous developer.

Good luck! 🚀
