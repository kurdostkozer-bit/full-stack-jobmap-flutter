# Setup Instructions - Google Identity Services Migration

## Prerequisites

- Node.js 18+
- Flutter 3.12+
- PostgreSQL 14+
- Android Studio (for Android development)
- Xcode (for iOS development)

---

## Backend Setup

### 1. Install Dependencies

```bash
cd backend
npm install
npm install google-auth-library@^9.4.2  # Official Google Auth Library
```

### 2. Create .env File

```bash
cp .env.example .env
```

Then edit `.env` with your values:

```env
DATABASE_URL=postgresql://jobmap:password@localhost:5432/jobmap
GOOGLE_CLIENT_ID=636597585856-8mut7gqkncb3tkj2vqgbelu9t5tbscq7.apps.googleusercontent.com
JWT_SECRET=$(openssl rand -hex 32)
JWT_REFRESH_SECRET=$(openssl rand -hex 32)
```

### 3. Generate JWT Secrets

```bash
# Generate a secure random string for JWT_SECRET
openssl rand -hex 32

# Generate a secure random string for JWT_REFRESH_SECRET
openssl rand -hex 32
```

Copy the outputs to your `.env` file.

### 4. Database Setup

Create database:
```bash
createdb jobmap
```

Run migrations (assuming you have migration files):
```bash
npm run migrate
# or
npx drizzle-kit migrate
```

### 5. Verify Backend

```bash
npm run dev
```

Test the Google OAuth endpoint:
```bash
curl -X POST http://localhost:3000/auth/social/google \
  -H "Content-Type: application/json" \
  -d '{"idToken": "test_token"}'

# Expected: 401 Unauthorized (invalid token)
# This is correct - token validation failed as expected
```

---

## Frontend Setup (Flutter)

### 1. Update pubspec.yaml

Verify these dependencies are present:

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_identity_services_web: ^0.2.0
  dio: ^5.9.0
  flutter_secure_storage: ^10.3.1
  # ... other dependencies
```

Run:
```bash
flutter pub get
```

### 2. Configure Google OAuth for Web

Edit `web/index.html`:

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>JobMap</title>
  
  <!-- Google Identity Services -->
  <script src="https://accounts.google.com/gsi/client" async defer></script>
  
  <link rel="manifest" href="manifest.json">
</head>
<body>
  <!-- ... rest of body -->
  <script src="main.dart.js" type="application/javascript"></script>
</body>
</html>
```

### 3. Configure Google OAuth for Android

Edit `android/build.gradle`:

```gradle
// Remove Firebase references if present
// repositories {
//   google()
//   mavenCentral()
//   maven { url "https://maven.google.com" }
// }

dependencies {
  // Remove firebase_core, firebase_auth
  
  // Keep for native Google Sign-In (optional)
  implementation 'com.google.android.gms:play-services-auth:20.7.0'
}
```

Edit `android/app/build.gradle`:

```gradle
// Remove:
// apply plugin: 'com.google.gms.google-services'

dependencies {
  // Remove: implementation 'com.google.firebase:firebase-auth'
  // Remove: implementation 'com.google.firebase:firebase-core'
}
```

Delete `android/app/google-services.json` if it exists.

### 4. Configure Google OAuth for iOS

Edit `ios/Podfile`:

```ruby
# Remove Firebase pods:
# pod 'Firebase/Core'
# pod 'Firebase/Auth'

# Keep for native Google Sign-In (optional)
pod 'GoogleSignIn', '~> 7.0'
```

Run:
```bash
cd ios
pod install
cd ..
```

Delete `ios/Runner/GoogleService-Info.plist` if it exists.

### 5. Environment Configuration

Create `lib/core/config/google_config.dart`:

```dart
class GoogleConfig {
  static const String clientId = 
    '636597585856-8mut7gqkncb3tkj2vqgbelu9t5tbscq7.apps.googleusercontent.com';
  
  static const String backendUrl = 'http://localhost:3000';
}
```

### 6. Test Web

```bash
flutter run -d chrome
```

You should see:
1. App loads
2. Google One-Tap dialog appears in corner
3. Click "Sign in with Google"
4. Redirects to backend for token verification
5. Login completes

---

## Configuration for Different Environments

### Development

`lib/core/config/app_config.dart`:

```dart
class AppConfig {
  static late String apiUrl;
  static late String googleClientId;
  static late bool enableLogging;

  static void init(Environment env) {
    switch (env) {
      case Environment.development:
        apiUrl = 'http://localhost:3000';
        googleClientId = '636597585856-8mut7gqkncb3tkj2vqgbelu9t5tbscq7.apps.googleusercontent.com';
        enableLogging = true;
        break;
      case Environment.production:
        apiUrl = 'https://api.jobmap.com';
        googleClientId = 'YOUR_PRODUCTION_CLIENT_ID';
        enableLogging = false;
        break;
    }
  }
}
```

---

## Testing Checklist

### Backend Tests

```bash
# Test Google token verification
npm run test -- auth.service.spec.ts

# Test endpoints
npm run test -- auth.controller.spec.ts
```

### Frontend Tests

```bash
# Run widget tests
flutter test

# Run integration tests
flutter test integration_test/
```

### Manual Testing

#### Web (Chrome)

1. [ ] Open http://localhost:3000
2. [ ] Google One-Tap appears
3. [ ] Click "Sign in with Google"
4. [ ] Select Google account
5. [ ] Redirected back to app
6. [ ] Login successful
7. [ ] Access token stored in secure storage
8. [ ] Can access protected routes

#### Android

1. [ ] Build APK: `flutter build apk`
2. [ ] Install: `flutter install`
3. [ ] Open app
4. [ ] Click "Sign in with Google"
5. [ ] Select account
6. [ ] Completes sign-in
7. [ ] Access token stored

#### iOS

1. [ ] Build IPA: `flutter build ios`
2. [ ] Install via Xcode
3. [ ] Open app
4. [ ] Click "Sign in with Google"
5. [ ] Select account
6. [ ] Completes sign-in
7. [ ] Access token stored

---

## Database Migration

### Create Migration File

```bash
npx drizzle-kit generate
```

Add new users table schema with:
- `google_id` (TEXT, UNIQUE)
- `google_email` (TEXT)
- `provider` (VARCHAR, DEFAULT 'local')
- `profile_image` (TEXT)
- `password_hash` (NULLABLE for Google users)

### Run Migration

```bash
npm run migrate
# or
npx drizzle-kit migrate
```

---

## Troubleshooting

### "Invalid Client ID"

- Verify `GOOGLE_CLIENT_ID` in `.env`
- Match with Google Cloud Console project
- Check for typos

### "Token verification failed"

- Ensure Google ID Token is valid
- Check `GOOGLE_CLIENT_ID` in backend
- Verify token not expired
- Check email_verified is true

### "Email is not verified"

- Google account's email must be verified
- Use a Google account with verified email

### "User not created"

- Check database connection
- Verify users table exists with new columns
- Check logs for SQL errors

### Web One-Tap not appearing

- Verify Google Identity Services script loaded
- Check browser console for errors
- Ensure `google_identity_services_web` installed
- Check Google Client ID is correct

### iOS build fails

- Run `cd ios && pod install && cd ..`
- Clean Xcode build: `flutter clean`
- Rebuild: `flutter build ios`

### Android build fails

- Remove `google-services.json`
- Remove Firebase dependencies
- Rebuild: `flutter build apk`

---

## Production Deployment

### Backend

1. Set production environment variables
2. Use secure JWT secrets (generate new ones)
3. Enable rate limiting
4. Configure CORS for your domain
5. Use HTTPS only
6. Deploy to server (AWS, DigitalOcean, etc.)

```bash
# Example with environment
NODE_ENV=production npm run start
```

### Frontend

1. Update API URL to production backend
2. Update Google Client ID to production credential
3. Build release APK/IPA
4. Deploy to app stores

```bash
# Build release APK
flutter build apk --release

# Build release IPA
flutter build ios --release
```

### Database

1. Backup production database
2. Run migrations
3. Verify new columns
4. Monitor for errors

---

## Support

For issues or questions:
1. Check error logs
2. Review AUTHENTICATION_FLOW.md
3. Check MIGRATION_CHECKLIST.md
4. Review backend and frontend configurations
