# Google Sign-In Firebase Configuration Guide

## Current Status
✅ SHA-1 fingerprint obtained  
⏳ Firebase Console needs update  
⏳ google-services.json needs refresh  

---

## Step 1: SHA-1 Fingerprint Details

### Your SHA-1 Fingerprint
```
46:E3:FD:92:30:C0:B1:99:49:D9:D8:46:DB:A1:52:F9:7C:28:65:6F
```

**Debug Keystore Location:**
```
C:\Users\Kurdost94\.android\debug.keystore
```

**Validity:** Saturday, July 22, 2056

---

## Step 2: Update Firebase Console

### Actions
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select project: **jobmap**
3. Click **Project Settings** (gear icon, top-right)
4. Go to **Your apps** tab
5. Find **Android app** labeled "jobmap"
6. Click the app to expand details
7. Scroll to **SHA certificate fingerprints** section
8. Click **Add fingerprint**
9. Paste the SHA-1:
   ```
   46:E3:FD:92:30:C0:B1:99:49:D9:D8:46:DB:A1:52:F9:7C:28:65:6F
   ```
10. Click **Save**

### Expected Result
```
✅ SHA-1 fingerprint added successfully
```

---

## Step 3: Download Updated google-services.json

### Actions
1. In Firebase Console, go to **Your apps** → Select Android app
2. Click **Download google-services.json** button
3. Place the file at:
   ```
   android/app/google-services.json
   ```

### File Location
```
c:\Users\Kurdost94\Desktop\jobMap\android\app\google-services.json
```

### Verify File Content
The file should contain your app's configuration:
```json
{
  "type": "service_account",
  "project_id": "jobmap",
  "private_key_id": "...",
  "private_key": "...",
  "client_email": "...",
  "client_id": "...",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "...": "..."
}
```

---

## Step 4: Build and Test

### Commands
```bash
cd c:\Users\Kurdost94\Desktop\jobMap
flutter clean
flutter pub get
flutter run
```

### What to Monitor

#### When App Starts
```
🚀 API Request: GET /career-profiles/me
🔐 AuthInterceptor: Token attached (length: 256)
```

#### On Successful Response
```
✅ API Response: Status 200
ProfileLoaded state emitted
Profile displays in UI
```

#### If 401 Unauthorized
```
🔐 AuthInterceptor: 401 Unauthorized detected
🔐 AuthInterceptor: Attempting token refresh...
✅ AuthInterceptor: Token refreshed successfully
```

#### If Backend Error
```
❌ API Error: Status 500
Response: {"statusCode": 500, "message": "..."}
```

---

## Testing Checklist

### Google Sign-In Flow
- [ ] Launch app
- [ ] Tap "Sign in with Google" button
- [ ] Select Google account
- [ ] Firebase authentication succeeds
- [ ] JWT token saved to secure storage
- [ ] Profile API called: `GET /career-profiles/me`
- [ ] Profile displays correctly
- [ ] No error messages in UI

### Expected Console Logs
```
✅ Found logs:
  - 🚀 API Request
  - 🔐 AuthInterceptor: Token attached
  - 🌐 ProfileRemoteDataSource: GET /career-profiles/me
  - ✅ API Response
  - ProfileBloc: Profile loaded successfully
```

### Expected App Behavior
```
1. Click "Sign in with Google"
2. Google login dialog appears
3. User selects account
4. Loading spinner shows
5. Profile screen displays with user data
6. No error toast messages
```

---

## Troubleshooting

### Issue: "Sign-In Failed"
**Cause:** SHA-1 not configured  
**Fix:** Add SHA-1 to Firebase Console (Step 2)

### Issue: "HTTP 401 Unauthorized"
**Cause:** JWT token not valid  
**Possible causes:**
- Firebase config mismatch
- google-services.json outdated
- Token not saved properly

**Fix:**
1. Verify google-services.json timestamp is recent
2. Clear app cache: `flutter clean`
3. Run again

### Issue: "HTTP 500 Server Error"
**Cause:** Backend error  
**Fix:**
1. Check backend logs
2. Verify Career Profile endpoint exists
3. Check request/response format

### Issue: "No logs appearing"
**Cause:** LoggingInterceptor not enabled  
**Fix:**
1. Verify `AppConfig.init(Environment.development)` in main.dart
2. Check that `enableLogging = true` in AppConfig

---

## Network Request Flow

### Request
```
GET https://api.kurdwins.com/api/v1/career-profiles/me

Headers:
  Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
  Content-Type: application/json
```

### Response (Success)
```
HTTP 200 OK

{
  "id": "user-123",
  "userId": "firebase-uid",
  "headline": "Full Stack Developer",
  "summary": "Experienced developer...",
  "professionTitle": "Software Engineer",
  "location": "Baghdad, Iraq",
  "createdAt": "2026-07-01T10:00:00Z",
  "updatedAt": "2026-07-30T12:00:00Z"
}
```

### Response (Error)
```
HTTP 500 Internal Server Error

{
  "statusCode": 500,
  "message": "Internal server error",
  "error": "..."
}
```

---

## Files Involved

### Flutter Files
- `lib/main.dart` - App initialization
- `lib/features/auth/presentation/pages/login_page.dart` - Google Sign-In UI
- `lib/features/auth/presentation/bloc/social_auth_bloc.dart` - Google Auth logic
- `lib/features/profile/presentation/pages/profile_screen.dart` - Profile display
- `lib/core/network/interceptors/auth_interceptor.dart` - JWT token handling
- `lib/core/network/interceptors/logging_interceptor.dart` - Request/response logging

### Configuration Files
- `android/app/google-services.json` - Firebase Android config (needs refresh)
- `pubspec.yaml` - Dependencies (firebase_auth, google_sign_in)

### Backend
- `GET /career-profiles/me` - Profile endpoint
- `POST /auth/login` - Email/password auth
- `POST /auth/google-signin` - Google authentication

---

## Success Indicators

### All Systems Working
```
✅ google-services.json configured with correct SHA-1
✅ Google Sign-In button works
✅ Firebase authentication succeeds
✅ JWT token saved to FlutterSecureStorage
✅ GET /career-profiles/me returns 200
✅ Profile data displays in app
✅ All console logs show ✅ (no ❌ errors)
```

### Build Output Example
```
Launching lib\main.dart on SM A155F in debug mode...
Running Gradle task 'assembleDebug'...
✅ BUILD SUCCESSFUL
Installing build\app\outputs\flutter-apk\app-debug.apk...
✅ Installed

🚀 API Request: GET /career-profiles/me
🔐 AuthInterceptor: Token attached (length: 256)
✅ API Response: Status 200
ProfileLoaded state emitted
```

---

## Support

If Sign-In still fails after Firebase configuration:

1. **Check Firebase Console**
   - Is SHA-1 visible in Android app settings?
   - Is google-services.json timestamp recent?

2. **Check Backend**
   - Is `/career-profiles/me` endpoint returning data?
   - Is backend accepting the JWT token?

3. **Check Flutter Logs**
   - Look for `❌` error messages
   - Check response status codes
   - Verify token is being sent

4. **Check Device**
   - Is device running latest Android version?
   - Is Google Play Services installed?

---

**Configuration Date**: July 30, 2026  
**Ready for**: Google Sign-In Testing  
**Deadline**: SHA-1 must be added before testing
