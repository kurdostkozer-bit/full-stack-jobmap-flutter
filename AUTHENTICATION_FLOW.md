# JobMap Authentication Flow - Google Identity Services

## Overview
JobMap now uses Google Identity Services for authentication with NestJS backend JWT verification. Firebase has been completely removed.

---

## Web Flow (Google One-Tap)

```
1. User opens app
   ↓
2. SocialAuthService._signInWithGIS()
   - Initializes Google Identity Services
   - Shows One-Tap dialog
   ↓
3. User clicks "Sign in with Google"
   ↓
4. Google returns ID Token (JWT)
   ↓
5. SocialAuthBloc receives GoogleIdToken:
   {
     token: "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE2ZjI2OWI0MWZiMDQzNjYwNmI0MDRiZjA2YmI4MGQxN2U1MTJkZGMiLCJ0eXAiOiJKV1QifQ...",
     email: "user@gmail.com",
     name: "John Doe",
     picture: "https://lh3.googleusercontent.com/..."
   }
   ↓
6. AuthRepository.socialLogin() calls:
   POST /auth/social/google
   {
     idToken: "eyJhbGciOiJSUzI1NiI..."
   }
   ↓
7. Backend: GoogleTokenVerifier.verifyIdToken()
   - Uses OAuth2Client.verifyIdToken()
   - Validates signature
   - Checks: iss, aud, exp, email_verified
   ↓
8. Backend: AuthService.googleSocialLogin()
   - Checks if user exists by googleId
   - If not found, checks by email
   - If email exists, links googleId
   - If new user, creates with googleId
   - Generates JWT tokens
   ↓
9. Backend returns:
   {
     accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
     refreshToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
     user: {
       id: "uuid",
       email: "user@gmail.com",
       isEmailVerified: true,
       createdAt: "2024-01-01T00:00:00Z"
     }
   }
   ↓
10. Flutter stores tokens in secure storage
    ↓
11. AuthBloc emits AuthAuthenticated(session)
```

---

## Database Schema

### users table

```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  
  -- Local auth (optional for Google users)
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT,
  
  -- Google auth
  google_id TEXT UNIQUE,
  google_email TEXT,
  
  -- User info
  provider VARCHAR(50) DEFAULT 'local',
  profile_image TEXT,
  
  -- Email verification
  is_email_verified BOOLEAN DEFAULT FALSE,
  
  -- Referral
  referral_code VARCHAR(20) UNIQUE,
  successful_invites INTEGER DEFAULT 0,
  estimated_reward DECIMAL(10, 2) DEFAULT 0,
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for faster lookups
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_google_id ON users(google_id);
CREATE INDEX idx_users_provider ON users(provider);
```

---

## Token Structure

### Access Token (JWT)
```
Header:
{
  "alg": "HS256",
  "typ": "JWT"
}

Payload:
{
  "sub": "user-id-uuid",
  "email": "user@gmail.com",
  "type": "access",
  "iat": 1704067200,
  "exp": 1704068100
}

Secret: JWT_SECRET (from env)
Expiration: 15 minutes
```

### Refresh Token (JWT)
```
Header:
{
  "alg": "HS256",
  "typ": "JWT"
}

Payload:
{
  "sub": "user-id-uuid",
  "email": "user@gmail.com",
  "type": "refresh",
  "iat": 1704067200,
  "exp": 1704672000
}

Secret: JWT_REFRESH_SECRET (from env)
Expiration: 7 days
```

---

## API Endpoints

### POST /auth/social/google
**Request:**
```json
{
  "idToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE2ZjI2OWI0MWZiMDQzNjYwNmI0MDRiZjA2YmI4MGQxN2U1MTJkZGMiLCJ0eXAiOiJKV1QifQ..."
}
```

**Response (200 OK):**
```json
{
  "message": "Google login successful.",
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "user@gmail.com",
    "isEmailVerified": true,
    "createdAt": "2024-01-01T00:00:00.000Z"
  }
}
```

**Errors:**
- 400: Invalid ID token format
- 401: Token verification failed
- 401: Email not verified
- 401: Invalid token issuer/audience/expiration

---

## Google ID Token Structure

```
Header:
{
  "alg": "RS256",
  "kid": "...",
  "typ": "JWT"
}

Payload:
{
  "iss": "https://accounts.google.com",
  "azp": "636597585856-8mut7gqkncb3tkj2vqgbelu9t5tbscq7.apps.googleusercontent.com",
  "aud": "636597585856-8mut7gqkncb3tkj2vqgbelu9t5tbscq7.apps.googleusercontent.com",
  "sub": "107015429841476800000",
  "email": "user@gmail.com",
  "email_verified": true,
  "name": "John Doe",
  "picture": "https://lh3.googleusercontent.com/...",
  "given_name": "John",
  "family_name": "Doe",
  "iat": 1704067200,
  "exp": 1704070800
}

Signature: Signed by Google's private key
Verification: Using Google's public key (fetched from google-auth-library)
```

---

## Security Validations

### Google Token Verification (Backend)

1. ✅ **Signature Verification**
   - Uses OAuth2Client.verifyIdToken()
   - Validates RS256 signature
   - Fetches public key from Google's JWKS endpoint

2. ✅ **Issuer Validation**
   - Must be: `https://accounts.google.com` or `accounts.google.com`

3. ✅ **Audience Validation**
   - Must match: `GOOGLE_CLIENT_ID` from environment

4. ✅ **Expiration Check**
   - Token must not be expired

5. ✅ **Email Verification**
   - `email_verified` must be true

### Request Validation (Backend)

- ✅ Input validation using class-validator
- ✅ Rate limiting (recommended)
- ✅ HTTPS only
- ✅ CORS origin validation

### Token Storage (Frontend)

- ✅ Stored in `flutter_secure_storage`
- ✅ Encrypted at rest
- ✅ Sent only via HTTPS
- ✅ Included in Authorization header: `Bearer {token}`

---

## Account Linking

### Scenario: User has email account, then signs in with Google

```
1. User registered with: user@gmail.com (password)
   Database: email = "user@gmail.com", googleId = NULL

2. User clicks "Sign in with Google" using same email
   Google returns ID Token with: sub = "107015429841476800000"

3. Backend:
   a. Check: findByGoogleId("107015429841476800000") → NULL
   b. Check: findByEmail("user@gmail.com") → Found
   c. Link: UPDATE users SET googleId = "107015429841476800000"
   d. Future Google sign-ins use googleId

4. Result:
   - Same user account
   - Can now sign in with Google OR password
   - `provider` field set to "google" (last used)
```

---

## Logout

```
1. User clicks logout
   ↓
2. Frontend:
   - Clears tokens from secure storage
   - Calls SocialAuthService.signOut() (disables auto-select)
   - Emits SocialSignOutSuccess
   ↓
3. Backend: POST /auth/logout (optional token blacklist)
```

---

## Error Handling

### Invalid Google ID Token

```
POST /auth/social/google
{
  "idToken": "invalid_token"
}

Response (401):
{
  "statusCode": 401,
  "message": "Token verification failed: Invalid signature",
  "error": "Unauthorized"
}
```

### Email Not Verified

```
Response (401):
{
  "statusCode": 401,
  "message": "Email is not verified",
  "error": "Unauthorized"
}
```

### Invalid Audience

```
Response (401):
{
  "statusCode": 401,
  "message": "Invalid token audience",
  "error": "Unauthorized"
}
```

---

## Environment Variables Required

```env
# Google OAuth
GOOGLE_CLIENT_ID=636597585856-8mut7gqkncb3tkj2vqgbelu9t5tbscq7.apps.googleusercontent.com

# JWT Secrets
JWT_SECRET=your_secure_random_secret_key_here
JWT_REFRESH_SECRET=your_secure_random_refresh_secret_key_here

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/jobmap
```

---

## Migration from Firebase

### What was removed:
- ❌ Firebase Auth (firebase_auth)
- ❌ Firebase Core (firebase_core)
- ❌ Google Sign-In adapter for Firebase (google_sign_in via Firebase)
- ❌ FirebaseAuth.instance
- ❌ signInWithCredential()
- ❌ GoogleAuthProvider
- ❌ Firebase User object
- ❌ firebase_options.dart

### What was added:
- ✅ Google Identity Services (google_identity_services_web)
- ✅ Google ID Token verification (google-auth-library)
- ✅ JobMap JWT tokens (NestJS)
- ✅ Database columns for Google auth
- ✅ OAuth2Client token verification
- ✅ User linking logic

### Why:
1. **Simpler**: Eliminate Firebase intermediary
2. **More Control**: Verify tokens directly
3. **Cost**: No Firebase costs
4. **Standards**: Uses OAuth 2.0 standard flow
5. **SSOT**: NestJS backend is single source of truth
