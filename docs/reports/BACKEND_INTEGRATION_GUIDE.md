# Backend Integration Guide - JobMap

**Objective**: Connect Flutter app to NestJS backend API completely.

**Timeline**: 1-2 sprints

---

## Phase 1: Setup & Configuration ✓

### 1.1 Environment Configuration
- [x] Development environment at `http://localhost:3000/api/v1`
- [x] Staging environment at `https://staging-api.jobmap.app/api/v1`
- [x] Production environment at `https://api.jobmap.app/api/v1`
- [ ] App Config: Update baseUrl if backend runs on different port

**Action**: Update `lib/core/config/app_config.dart` if needed.

### 1.2 Network Layer
- [x] ApiClient created with Dio
- [x] DioProvider with interceptors
- [x] Auth interceptor for token injection
- [x] Error handling (ApiException)
- [ ] Logging interceptor (optional, for debugging)

**Status**: Ready to use

---

## Phase 2: Auth API Integration

### 2.1 Login Flow

**Endpoint**: `POST /auth/login`

**Request**:
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response**:
```json
{
  "token": "jwt-token-here",
  "refreshToken": "refresh-token-here",
  "user": {
    "id": "user-id",
    "email": "user@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "profileImage": null,
    "bio": null,
    "emailVerified": true,
    "createdAt": "2024-01-15T10:30:00Z"
  }
}
```

**Implementation Status**: ✓ Remote datasource ready
- [x] LoginRequest model
- [x] AuthResponse model
- [x] UserResponse model
- [x] API endpoint call implemented

**Testing**:
```bash
# 1. Start backend server
cd backend
npm run start:dev

# 2. In Flutter, test login
# See TESTING_GUIDE.md - Auth Section
```

### 2.2 Register Flow

**Endpoint**: `POST /auth/register`

**Request**:
```json
{
  "email": "newuser@example.com",
  "password": "SecurePass123!",
  "firstName": "Jane",
  "lastName": "Doe"
}
```

**Response**:
```json
{
  "token": "jwt-token",
  "refreshToken": "refresh-token",
  "user": { /* user object */ }
}
```

**Implementation Status**: ✓ Ready

### 2.3 Email Verification

**Endpoint**: `POST /auth/verify-email`

**Request**:
```json
{
  "email": "user@example.com",
  "code": "123456"
}
```

**Response**: `204 No Content` or `200 OK`

**Implementation Status**: ✓ Ready

### 2.4 Get Current User

**Endpoint**: `GET /auth/me`

**Headers**: `Authorization: Bearer <token>`

**Response**:
```json
{
  "id": "user-id",
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "profileImage": null,
  "bio": null,
  "emailVerified": true,
  "createdAt": "2024-01-15T10:30:00Z"
}
```

**Implementation Status**: ✓ Ready

### 2.5 Token Refresh

**Endpoint**: `POST /auth/refresh-token`

**Request**:
```json
{
  "refreshToken": "refresh-token-here"
}
```

**Response**:
```json
{
  "token": "new-jwt-token",
  "refreshToken": "new-refresh-token"
}
```

**Implementation Status**: ✓ Remote datasource ready

**TODO**: Implement auto-refresh on 401 in AuthInterceptor

### 2.6 Logout

**Endpoint**: `POST /auth/logout`

**Headers**: `Authorization: Bearer <token>`

**Response**: `204 No Content`

**Implementation Status**: ✓ Ready

### 2.7 Forgot Password

**Endpoint**: `POST /auth/forgot-password`

**Request**:
```json
{
  "email": "user@example.com"
}
```

**Response**: `200 OK` with message

**Implementation Status**: ✓ Ready

### 2.8 Reset Password

**Endpoint**: `POST /auth/reset-password`

**Request**:
```json
{
  "email": "user@example.com",
  "code": "reset-code",
  "newPassword": "NewPassword123!"
}
```

**Response**: `200 OK`

**Implementation Status**: ✓ Ready

---

## Phase 3: Auto-Login & SplashScreen

### 3.1 SplashScreen Logic

**Flow**:
```
App Starts
    ↓
AppWidget initializes
    ↓
setupServiceLocator() called
    ↓
AuthBloc.add(CheckAuthEvent())
    ↓
hasValidToken() → FlutterSecureStorage check
    ↓
If token exists: auto-login
    If token expired: refresh_token attempt
    If no token: show Welcome
    ↓
Navigate to appropriate screen
```

**Implementation Status**: ⏳ Needs implementation

**File**: `lib/features/auth/presentation/screens/splash_screen.dart`

**Code**:
```dart
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.read<AuthBloc>().add(const CheckAuthEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/home');
        } else if (state is AuthUnauthenticated) {
          context.go('/welcome');
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or app icon
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading...'),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Phase 4: Career Profile API Integration

### 4.1 APIs Already Available

**GET /profile/skills** - List skills
**POST /profile/skills** - Create skill
**PATCH /profile/skills/:id** - Update skill
**DELETE /profile/skills/:id** - Delete skill

**Same for**: experience, education, languages, projects, certificates

### 4.2 Integration Steps

1. **Create remote datasource** for each feature
2. **Create repository** for each feature
3. **Create usecases** for each feature
4. **Create BLoC** for each feature
5. **Create screens** with form/list UI
6. **Connect to API**

**Example** (Skills):

```dart
// Remote DataSource
class SkillsRemoteDataSource {
  Future<List<Skill>> getSkills(String profileId);
  Future<Skill> createSkill(CreateSkillRequest request);
  Future<Skill> updateSkill(String skillId, UpdateSkillRequest request);
  Future<void> deleteSkill(String skillId);
}

// Repository
class SkillsRepository {
  Future<List<Skill>> getSkills(String profileId);
  // ... other methods
}

// BLoC Events
class GetSkillsEvent extends SkillsEvent;
class CreateSkillEvent extends SkillsEvent;
class UpdateSkillEvent extends SkillsEvent;
class DeleteSkillEvent extends SkillsEvent;

// BLoC States
class SkillsLoaded extends SkillsState;
class SkillsError extends SkillsState;
```

---

## Phase 5: Error Handling

### 5.1 Implemented Exceptions

```dart
NetworkException         // No internet
TimeoutException        // Request timeout
UnauthorizedException   // 401
ForbiddenException      // 403
NotFoundException       // 404
ValidationException     // 400/422
ServerException         // 500+
UnknownException        // Other
```

### 5.2 User-Facing Error Messages

**Map to user-friendly messages**:

```dart
if (exception is NetworkException) {
  return 'No internet connection. Please check your connection.';
} else if (exception is TimeoutException) {
  return 'Request took too long. Please try again.';
} else if (exception is UnauthorizedException) {
  return 'Your session expired. Please login again.';
} else if (exception is ValidationException) {
  return exception.message; // From server
} else if (exception is ServerException) {
  return 'Server error. Please try again later.';
}
```

### 5.3 Retry Logic

**Implement retry for network errors**:

```dart
Future<T> _retryApiCall<T>(
  Future<T> Function() call, {
  int maxRetries = 3,
  Duration delay = const Duration(seconds: 1),
}) async {
  int attempts = 0;
  while (true) {
    try {
      return await call();
    } catch (e) {
      attempts++;
      if (attempts >= maxRetries || e is! NetworkException) {
        rethrow;
      }
      await Future.delayed(delay);
    }
  }
}
```

---

## Phase 6: Token Management

### 6.1 Token Storage (✓ Done)

```dart
FlutterSecureStorage keys:
- auth_token         → JWT token
- refresh_token      → Refresh token
- auth_response      → Full response JSON
- user_profile       → Cached user
```

### 6.2 Token Refresh (TODO)

**When 401 is received**:

```dart
// In AuthInterceptor.onError()
if (err.response?.statusCode == 401) {
  try {
    final refreshToken = await secureStorage.read(key: 'refresh_token');
    if (refreshToken != null) {
      // Call refresh endpoint
      final newTokens = await refreshTokenAPI(refreshToken);
      // Save new tokens
      await secureStorage.write(key: 'auth_token', value: newTokens.token);
      // Retry original request with new token
      return handler.resolve(await _retry(err.requestOptions));
    } else {
      // No refresh token, clear and logout
      await secureStorage.delete(key: 'auth_token');
    }
  } catch (e) {
    // Refresh failed, logout
  }
}
```

### 6.3 Auto-Login

**On app startup**:
1. Check if token exists in secure storage
2. If yes, decode and check expiration
3. If expired, attempt refresh
4. If still valid, proceed to Home
5. If no token or refresh failed, show Welcome

---

## Phase 7: Testing Integration

### 7.1 Manual Testing Checklist

- [ ] **Login**: Email + password → Success/Error
- [ ] **Register**: New email + password → Verification screen
- [ ] **Verify Email**: Code from email → Success
- [ ] **Auto-Login**: Kill app → Open app → Auto-login (if token valid)
- [ ] **Token Refresh**: Make request after token expires → Auto-refresh → Request succeeds
- [ ] **Logout**: Tap logout → Clear storage → Show Welcome
- [ ] **Offline**: Kill internet → Show error + retry option
- [ ] **Timeout**: Long delay → Show timeout error after 30s
- [ ] **Server Error**: 500 error → Show user-friendly message

### 7.2 Automated Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Run specific test
flutter test test/features/auth/
```

### 7.3 Network Debugging

**Check Dio requests in console**:

```
POST http://localhost:3000/api/v1/auth/login
Headers: {Authorization: Bearer ..., Content-Type: application/json}
Body: {email: ..., password: ...}
Response: 200 OK
```

**Enable logging**:
```dart
// In AppConfig development environment
enableLogging: true // Logs all requests/responses
```

---

## Phase 8: Career Profile Screens

### 8.1 Structure

```
lib/features/profile/
├── data/
│   ├── datasources/
│   │   ├── profile_remote_datasource.dart
│   │   └── profile_local_datasource.dart
│   ├── models/
│   │   └── profile_models.dart
│   └── repositories/
│       └── profile_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── profile_entities.dart
│   ├── repositories/
│   │   └── profile_repository.dart
│   └── usecases/
│       └── profile_usecases.dart
└── presentation/
    ├── bloc/
    │   ├── profile_bloc.dart
    │   ├── profile_event.dart
    │   └── profile_state.dart
    └── screens/
        ├── profile_overview_screen.dart
        ├── personal_info_screen.dart
        ├── skills_screen.dart
        ├── experience_screen.dart
        └── ...
```

### 8.2 API Endpoints

```
GET    /profile                  → Get full profile
POST   /profile                  → Update profile
GET    /profile/skills           → List skills
POST   /profile/skills           → Create skill
PATCH  /profile/skills/:id       → Update skill
DELETE /profile/skills/:id       → Delete skill

GET    /profile/experience       → List experience
POST   /profile/experience       → Create experience
PATCH  /profile/experience/:id   → Update experience
DELETE /profile/experience/:id   → Delete experience

... (same for education, languages, projects, certificates)
```

---

## Checklist

### Backend Integration Complete When:

- [ ] Login works with real API
- [ ] Register works with real API
- [ ] Email verification works
- [ ] Auto-login on app start works
- [ ] Token refresh works (on 401)
- [ ] Logout clears tokens
- [ ] Error messages shown (not crashes)
- [ ] Forgot password works
- [ ] Reset password works
- [ ] GET /me returns user data
- [ ] All unit tests pass
- [ ] No console errors/warnings
- [ ] SplashScreen → Auto-login → Home flow works
- [ ] Can logout and login again

### Career Profile Integration:

- [ ] All CRUD endpoints connected
- [ ] List screens load data from API
- [ ] Create/Edit forms submit to API
- [ ] Delete operations work
- [ ] Error handling for each operation
- [ ] Loading states shown
- [ ] Empty states handled

---

## Next Steps

1. **Verify Backend is running** at `http://localhost:3000/api/v1`
2. **Update AppConfig if needed**
3. **Run flutter pub get**
4. **Test login endpoint** manually (use Postman/Thunder Client)
5. **Run QUALITY_CHECKLIST.md auth section**
6. **Fix any issues**
7. **Build Career Profile screens**
8. **Build Dashboard**
9. **Test full flow**: Register → Verify → Login → Profile → Logout → Login again

---

## Commands

```bash
# Build backend
cd backend
npm install
npm run build
npm run start:dev

# Flutter tests
cd ..
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run

# Real device
flutter run -d <device-id>

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

---

## Support

**Issues?**

1. Check backend is running: `curl http://localhost:3000/api/v1/health`
2. Check network tab in DevTools
3. Check Dio logging output
4. Run `flutter clean && flutter pub get`
5. Check Firebase (if used)
6. Restart emulator/device
