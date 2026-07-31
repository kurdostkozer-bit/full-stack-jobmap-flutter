# Firebase → Google Identity Services Migration Checklist

## ✅ Completed Changes

### Frontend (Flutter)

1. **pubspec.yaml** ✓
   - ❌ Removed: `firebase_core`, `firebase_auth`, `google_sign_in`
   - ✅ Added: `google_identity_services_web`

2. **lib/main.dart** ✓
   - Removed Firebase initialization
   - Removed `firebase_options.dart` import

3. **lib/core/services/social_auth_service.dart** ✓
   - Replaced Firebase Auth with Google Identity Services
   - Implements one-tap sign-in for web
   - Returns `GoogleIdToken` with email, name, token, picture

4. **lib/features/auth/presentation/bloc/social_auth_bloc.dart** ✓
   - Updated to use `GoogleIdToken` from service
   - Removed Firebase-specific code

5. **lib/features/auth/data/datasources/auth_remote_data_source_impl.dart** ✓
   - Updated `socialLogin()` to call `/auth/social/google`
   - Sends only `idToken` parameter

6. **lib/firebase_options.dart** ✓
   - Deleted (no longer needed)

### Backend (NestJS)

7. **backend/src/database/schema/users.schema.ts** ✓
   - ✅ Added: `googleId` (unique)
   - ✅ Added: `googleEmail`
   - ✅ Added: `provider` (default: 'local')
   - ✅ Added: `profileImage`
   - Made `passwordHash` optional (for Google users)

8. **backend/src/auth/services/google-token-verifier.ts** ✓
   - ✅ Now uses `google-auth-library` (OAuth2Client)
   - Uses official `verifyIdToken()` method
   - Validates issuer, expiration, email_verified

9. **backend/src/auth/dto/social-auth.dto.ts** ✓
   - New DTO for `/auth/social/google` endpoint

10. **backend/src/auth/controllers/auth.controller.ts** ✓
    - Added `POST /auth/social/google` endpoint

11. **backend/src/auth/services/auth.service.ts** ✓
    - Imported `GoogleTokenVerifier`
    - Implemented `googleSocialLogin()` method
    - Finds/creates users by Google ID
    - Links Google IDs to existing users
    - Returns JWT tokens

12. **backend/src/auth/repositories/users.repository.ts** ✓
    - Added `findByGoogleId()`
    - Added `createFromGoogle()`
    - Updated `linkGoogleId()` with full params

13. **backend/src/auth/auth.module.ts** ✓
    - Registered `GoogleTokenVerifier` provider

---

## ⚠️ Remaining Tasks

### 1. Node Dependencies
Add to `backend/package.json`:
```json
{
  "dependencies": {
    "google-auth-library": "^9.4.2"
  }
}
```

### 2. Environment Variables
Set in `.env`:
```
GOOGLE_CLIENT_ID=636597585856-8mut7gqkncb3tkj2vqgbelu9t5tbscq7.apps.googleusercontent.com
JWT_SECRET=your_secret_key
JWT_REFRESH_SECRET=your_refresh_secret
```

### 3. Database Migration
Create migration for new columns:
```
users.googleId (text, unique)
users.googleEmail (text)
users.provider (varchar, default: 'local')
users.profileImage (text)
passwordHash (nullable)
```

### 4. Flutter Android
In `android/build.gradle` or `android/app/build.gradle`:
- ❌ Remove Firebase dependencies
- ❌ Remove `google-services.json`
- ✅ Keep `google_sign_in` integration if needed for native flow

In `android/app/src/main/AndroidManifest.xml`:
- ❌ Remove Firebase app ID

### 5. Flutter iOS
In `ios/Podfile`:
- ❌ Remove Firebase pods
- ❌ Remove `GoogleService-Info.plist`
- ✅ Keep Google Sign-In if needed for native flow

### 6. Native Flows (Android/iOS)
The Flutter service has placeholder for native flows:
```dart
Future<GoogleIdToken?> _signInWithNativeFlow() async {
  throw UnsupportedError(
    'Native Google Sign-In flow must be implemented for Android/iOS',
  );
}
```

**To implement:**
- Use official Google Sign-In SDK (not Firebase)
- Get Google ID Token directly
- Send to `/auth/social/google` endpoint

### 7. Testing Checklist
- [ ] Test web one-tap sign-in
- [ ] Test Android native sign-in
- [ ] Test iOS native sign-in
- [ ] Test linking Google to existing email accounts
- [ ] Test JWT token generation
- [ ] Test token refresh
- [ ] Test logout
- [ ] Test database queries

### 8. Cleanup
- [ ] Remove Firebase from iOS `Podfile`
- [ ] Remove Firebase from Android `build.gradle`
- [ ] Remove `GoogleService-Info.plist` (iOS)
- [ ] Remove `google-services.json` (Android)
- [ ] Remove Firebase from Xcode project (iOS)
- [ ] Remove Firebase from Android Studio project

---

## 🔒 Security Notes

✅ Verified:
- Google token validation using official library
- JWT signature verification (RS256)
- Token expiration check
- Email verification check
- Audience validation
- Issuer validation

⚠️ Still need:
- Rate limiting on `/auth/social/google`
- Token blacklist for logout (optional)
- CORS configuration for web origins
- HTTPS only in production
