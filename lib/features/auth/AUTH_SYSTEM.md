# JobMap Authentication System

## Overview

JobMap uses a **clean architecture** with email/password authentication. No Firebase. All authentication is managed through a NestJS backend that issues JWT tokens.

**Architecture Layers:**
- Domain (entities, repositories, use cases)
- Data (models, datasources, repository implementation)
- Presentation (BLoC, UI)
- Infrastructure (network, storage, interceptors)

---

## Authentication Flow

### 1. Registration Flow

```
User Input → RegisterEvent 
  ↓
AuthBloc._onRegister() 
  ↓
RegisterUseCase.call()
  ↓
AuthRepository.register()
  ↓
AuthRemoteDataSourceImpl.register()
  ↓
ApiClient.post('/auth/register', {fullName, email, password, phone?})
  ↓
Backend: Hash password, create user, send verification email
  ↓
AuthSessionModel returned (accessToken, refreshToken, user, expiresAt)
  ↓
AuthLocalDataSourceImpl.saveAuthSession()
  ↓
Save tokens in FlutterSecureStorage
  ↓
Emit EmailVerificationNeeded state
```

**API Endpoint:** `POST /auth/register`

**Payload:**
```json
{
  "fullName": "John Doe",
  "email": "john@example.com",
  "password": "SecurePass123!",
  "phone": "+1234567890"
}
```

**Response:**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
  "expiresIn": 3600,
  "user": {
    "id": "uuid",
    "email": "john@example.com",
    "fullName": "John Doe",
    "phone": "+1234567890",
    "emailVerified": false
  }
}
```

---

### 2. Email Verification Flow

```
User Input (verification code) → VerifyEmailEvent
  ↓
AuthBloc._onVerifyEmail()
  ↓
VerifyEmailUseCase.call()
  ↓
AuthRepository.verifyEmail()
  ↓
AuthRemoteDataSourceImpl.verifyEmail()
  ↓
ApiClient.post('/auth/verify-email', {email, code})
  ↓
Backend: Validate code, mark email as verified
  ↓
Emit AuthSuccess state
```

**API Endpoint:** `POST /auth/verify-email`

**Payload:**
```json
{
  "email": "john@example.com",
  "code": "123456"
}
```

---

### 3. Login Flow

```
User Input → LoginEvent(email, password)
  ↓
AuthBloc._onLogin()
  ↓
LoginUseCase.call()
  ↓
AuthRepository.login()
  ↓
AuthRemoteDataSourceImpl.login()
  ↓
ApiClient.post('/auth/login', {email, password})
  ↓
Backend: Verify credentials, generate JWT tokens
  ↓
AuthSessionModel returned
  ↓
AuthLocalDataSourceImpl.saveAuthSession()
  ↓
Save tokens in FlutterSecureStorage
  ↓
Emit AuthAuthenticated state with session
```

**API Endpoint:** `POST /auth/login`

**Payload:**
```json
{
  "email": "john@example.com",
  "password": "SecurePass123!"
}
```

**Response:**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
  "expiresIn": 3600,
  "user": {
    "id": "uuid",
    "email": "john@example.com",
    "fullName": "John Doe",
    "phone": "+1234567890",
    "emailVerified": true
  }
}
```

---

### 4. Token Refresh Flow

```
AuthInterceptor detects 401 Unauthorized response
  ↓
Check if refreshToken exists in storage
  ↓
RefreshSessionEvent triggered
  ↓
AuthBloc._onRefreshSession()
  ↓
RefreshSessionUseCase.call()
  ↓
AuthRepository.refreshSession()
  ↓
AuthRemoteDataSourceImpl.refreshSession()
  ↓
ApiClient.post('/auth/refresh-token', {refreshToken})
  ↓
Backend: Verify refreshToken, generate new accessToken
  ↓
New AuthSessionModel returned
  ↓
AuthLocalDataSourceImpl.saveAuthSession()
  ↓
Update tokens in FlutterSecureStorage
  ↓
Retry original failed request with new accessToken
```

**API Endpoint:** `POST /auth/refresh-token`

**Payload:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIs..."
}
```

**Response:**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
  "expiresIn": 3600
}
```

---

### 5. Logout Flow

```
User taps logout → LogoutEvent
  ↓
AuthBloc._onLogout()
  ↓
LogoutUseCase.call()
  ↓
AuthRepository.logout()
  ↓
AuthRemoteDataSourceImpl.logout()
  ↓
ApiClient.post('/auth/logout', {})
  ↓
Backend: Invalidate refreshToken
  ↓
AuthLocalDataSourceImpl.clearAuth()
  ↓
Delete tokens from FlutterSecureStorage
  ↓
Emit AuthUnauthenticated state
  ↓
Navigate to login screen
```

**API Endpoint:** `POST /auth/logout`

---

### 6. Password Reset Flow

```
User enters email → ForgotPasswordEvent
  ↓
AuthBloc._onForgotPassword()
  ↓
ForgotPasswordUseCase.call()
  ↓
AuthRepository.forgotPassword()
  ↓
AuthRemoteDataSourceImpl.forgotPassword()
  ↓
ApiClient.post('/auth/request-password-reset', {email})
  ↓
Backend: Generate reset code, send email
  ↓
Emit PasswordResetSent state
  ↓
User receives code in email
  ↓
User enters code + new password → ResetPasswordEvent
  ↓
AuthBloc._onResetPassword()
  ↓
ResetPasswordUseCase.call()
  ↓
AuthRepository.resetPassword()
  ↓
AuthRemoteDataSourceImpl.resetPassword()
  ↓
ApiClient.post('/auth/reset-password', {email, code, newPassword})
  ↓
Backend: Validate code, hash new password, update user
  ↓
Emit AuthSuccess state
```

**API Endpoint 1:** `POST /auth/request-password-reset`

**Payload:**
```json
{
  "email": "john@example.com"
}
```

**API Endpoint 2:** `POST /auth/reset-password`

**Payload:**
```json
{
  "email": "john@example.com",
  "code": "123456",
  "newPassword": "NewSecurePass456!"
}
```

---

## Architecture Layers

### Domain Layer

**Entities:**
- `AuthSession` - Contains user, accessToken, refreshToken, expiresAt
- `User` - User profile data (id, email, fullName, phone, emailVerified)

**Repository (Abstract):**
```dart
abstract class AuthRepository {
  Future<AuthSession> register({...});
  Future<void> verifyEmail({...});
  Future<AuthSession> login({...});
  Future<void> logout();
  Future<void> forgotPassword({...});
  Future<void> resetPassword({...});
  Future<AuthSession> refreshSession({...});
  Future<bool> isAuthenticated();
  Future<AuthSession?> getCurrentSession();
}
```

**Use Cases (9 total):**
1. `RegisterUseCase` - Create new account
2. `VerifyEmailUseCase` - Verify email with code
3. `LoginUseCase` - Authenticate with email/password
4. `LogoutUseCase` - End session
5. `ForgotPasswordUseCase` - Request password reset code
6. `ResetPasswordUseCase` - Reset password with code
7. `CheckAuthUseCase` - Check if currently authenticated
8. `GetCurrentSessionUseCase` - Retrieve current session
9. `RefreshSessionUseCase` - Refresh expired accessToken

---

### Data Layer

**Models:**
- `AuthSessionModel` - Serializable version of AuthSession
- `UserModel` - Serializable version of User

**Data Sources:**

**AuthRemoteDataSource (API calls):**
```dart
abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({...});
  Future<AuthSessionModel> register({...});
  Future<void> verifyEmail({...});
  Future<void> forgotPassword({...});
  Future<void> resetPassword({...});
  Future<AuthSessionModel> refreshSession(...);
  Future<void> logout();
}
```

**AuthLocalDataSource (Secure storage):**
```dart
abstract class AuthLocalDataSource {
  Future<void> saveAuthSession(AuthSessionModel session);
  Future<AuthSessionModel?> getAuthSession();
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<void> clearAuth();
  Future<bool> hasValidToken();
}
```

**Repository Implementation:**
- Orchestrates between remote and local data sources
- Saves session to local storage after successful login/register
- Clears storage on logout

---

### Presentation Layer

**BLoC (AuthBloc):**

**Events (9 total):**
1. `CheckAuthEvent` - Check current auth state
2. `RegisterEvent` - Register new user
3. `VerifyEmailEvent` - Verify email
4. `LoginEvent` - Login with credentials
5. `LogoutEvent` - Logout
6. `ForgotPasswordEvent` - Request password reset
7. `ResetPasswordEvent` - Reset password
8. `RefreshSessionEvent` - Refresh token

**States (7 total):**
1. `AuthInitial` - Initial state
2. `AuthLoading` - Loading state
3. `AuthAuthenticated` - User logged in
4. `AuthUnauthenticated` - User logged out
5. `EmailVerificationNeeded` - Waiting for email verification
6. `PasswordResetSent` - Password reset code sent
7. `AuthError` - Error occurred
8. `AuthSuccess` - Operation successful

---

### Infrastructure Layer

**AuthInterceptor:**
- Attaches accessToken to every request header: `Authorization: Bearer {token}`
- Detects 401 responses
- Automatically refreshes token using refreshToken
- Retries original request with new token
- Clears storage if refresh fails

**ApiClient:**
- HTTP client using Dio
- Handles errors and converts to ApiException
- Supports interceptors for auth and logging

---

## Token Management

### Access Token
- **Purpose:** Authenticate API requests
- **Lifetime:** 1 hour (typically)
- **Storage:** FlutterSecureStorage
- **Usage:** Added to every request as `Authorization: Bearer {token}`
- **Expiry Handling:** AuthInterceptor detects 401 and refreshes

### Refresh Token
- **Purpose:** Generate new access tokens without user re-login
- **Lifetime:** 30 days (typically)
- **Storage:** FlutterSecureStorage
- **Usage:** Sent to `/auth/refresh-token` endpoint to get new accessToken
- **Rotation:** Backend should rotate refresh token on each refresh

---

## Security

### Password Requirements
- Minimum 8 characters
- At least 1 uppercase letter
- At least 1 lowercase letter
- At least 1 number
- Validated by `EmailAuthService`

### Token Storage
- Tokens stored in `FlutterSecureStorage` (platform-level encryption)
- Never stored in SharedPreferences or plain text
- Cleared on logout or token refresh failure

### API Security
- All auth endpoints use HTTPS (on https://jobmap.kurdwins.com)
- Tokens validated server-side
- Refresh tokens should be HTTP-only cookies (recommended for web)

---

## Error Handling

**ApiException Hierarchy:**
- `UnauthorizedException` - 401 (invalid credentials, expired token)
- `ForbiddenException` - 403 (insufficient permissions)
- `NotFoundException` - 404 (resource not found)
- `ConflictException` - 409 (duplicate email, etc.)
- `ValidationException` - 422 (validation errors)
- `ServerException` - 500+ (server errors)

**BLoC Error Handling:**
- All operations wrapped in try-catch
- ApiExceptions extracted and displayed in UI
- Generic catch-all for unexpected errors

---

## Dependency Injection

**Service Locator Setup:**

```dart
// Data Sources
sl.registerLazySingleton<AuthRemoteDataSource>(
  () => AuthRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
);

sl.registerLazySingleton<AuthLocalDataSource>(
  () => AuthLocalDataSourceImpl(secureStorage: sl<FlutterSecureStorage>()),
);

// Repository
sl.registerLazySingleton<AuthRepository>(
  () => AuthRepositoryImpl(
    remoteDataSource: sl<AuthRemoteDataSource>(),
    localDataSource: sl<AuthLocalDataSource>(),
  ),
);

// Use Cases
sl.registerLazySingleton<LoginUseCase>(
  () => LoginUseCase(repository: sl<AuthRepository>()),
);
// ... (8 more use cases)

// BLoC
sl.registerLazySingleton<AuthBloc>(
  () => AuthBloc(
    registerUseCase: sl<RegisterUseCase>(),
    verifyEmailUseCase: sl<VerifyEmailUseCase>(),
    loginUseCase: sl<LoginUseCase>(),
    logoutUseCase: sl<LogoutUseCase>(),
    forgotPasswordUseCase: sl<ForgotPasswordUseCase>(),
    resetPasswordUseCase: sl<ResetPasswordUseCase>(),
    checkAuthUseCase: sl<CheckAuthUseCase>(),
    getCurrentSessionUseCase: sl<GetCurrentSessionUseCase>(),
    refreshSessionUseCase: sl<RefreshSessionUseCase>(),
  ),
);

// Email Auth Service
sl.registerLazySingleton<EmailAuthService>(
  () => EmailAuthService(),
);

// Social Auth BLoC (email/password only now)
sl.registerLazySingleton<SocialAuthBloc>(
  () => SocialAuthBloc(
    emailAuthService: sl<EmailAuthService>(),
    authRepository: sl<AuthRepository>(),
  ),
);
```

---

## Usage in UI

### Login Screen
```dart
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    if (state is AuthLoading) {
      return const CircularProgressIndicator();
    }
    
    if (state is AuthAuthenticated) {
      // Navigate to home
    }
    
    if (state is AuthError) {
      // Show error message
    }
    
    return LoginForm();
  },
)
```

### Check Authentication on App Start
```dart
@override
void initState() {
  super.initState();
  context.read<AuthBloc>().add(const CheckAuthEvent());
}
```

### Logout
```dart
context.read<AuthBloc>().add(const LogoutEvent());
```

---

## File Structure

```
lib/features/auth/
├── domain/
│   ├── entities/
│   │   ├── auth_session.dart
│   │   └── user.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       └── auth_usecases.dart
├── data/
│   ├── datasources/
│   │   ├── auth_local_datasource.dart
│   │   └── auth_remote_data_source.dart
│   ├── models/
│   │   ├── auth_session_model.dart
│   │   └── user_model.dart
│   └── repositories/
│       └── auth_repository_impl.dart
├── presentation/
│   ├── bloc/
│   │   ├── auth_bloc.dart
│   │   ├── auth_event.dart
│   │   ├── auth_state.dart
│   │   ├── social_auth_bloc.dart
│   │   ├── social_auth_event.dart
│   │   └── social_auth_state.dart
│   ├── pages/
│   │   └── login_page.dart
│   └── screens/
│       ├── login_screen.dart
│       ├── register_screen.dart
│       ├── splash_screen.dart
│       └── welcome_screen.dart
├── AUTH_SYSTEM.md (this file)
└── README.md
```

---

## Backend Integration

### Required Endpoints

All endpoints on `https://jobmap.kurdwins.com/api`

1. `POST /auth/register` - Create new account
2. `POST /auth/login` - Login with credentials
3. `POST /auth/verify-email` - Verify email address
4. `POST /auth/request-password-reset` - Request password reset code
5. `POST /auth/reset-password` - Reset password
6. `POST /auth/refresh-token` - Refresh access token
7. `POST /auth/logout` - Logout and invalidate session

### Expected Response Format

**Success Response:**
```json
{
  "accessToken": "string",
  "refreshToken": "string",
  "expiresIn": 3600,
  "user": {
    "id": "string",
    "email": "string",
    "fullName": "string",
    "phone": "string",
    "emailVerified": boolean
  }
}
```

**Error Response:**
```json
{
  "statusCode": 400,
  "message": "Validation failed",
  "error": "BadRequest",
  "errors": [
    {
      "field": "email",
      "message": "Email must be valid"
    }
  ]
}
```

---

## Migration from Firebase

✅ **Removed:**
- firebase_auth package
- firebase_core package
- google_sign_in package
- google_identity_services_web package
- FirebaseAuth initialization
- GoogleSignIn flow
- Firebase credential handling

✅ **Kept:**
- Email/password authentication
- Secure token storage
- Token refresh mechanism
- Clean architecture

✅ **Added:**
- EmailAuthService for validation
- Direct JWT token management
- NestJS backend integration
- SocialAuthBloc for email auth

---

## Next Steps

1. Test all auth flows in development
2. Verify backend endpoints match expected formats
3. Test token refresh on 401 errors
4. Test logout clears all tokens
5. Test offline behavior (should use cached session)
6. Monitor auth events and errors in analytics
7. Deploy to https://jobmap.kurdwins.com

---

**Last Updated:** January 2026
**Status:** Production Ready
**Authentication Type:** Email/Password + JWT
**Backend:** NestJS with PostgreSQL + Drizzle
