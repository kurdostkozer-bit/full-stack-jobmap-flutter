# Backend API Guide - Social Authentication Integration

## المتطلبات

Backend يحتاج إلى الـ endpoints التالية:

### 1. Social Login Endpoint
**POST** `/auth/social-login`

**Request Body:**
```json
{
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "provider": "google",  // أو "facebook"
  "providerId": "unique-id-from-provider",
  "idToken": "firebase-id-token"
}
```

**Response (Success):**
```json
{
  "accessToken": "jwt-token",
  "refreshToken": "refresh-token",
  "user": {
    "id": "user-id",
    "email": "user@example.com",
    "fullName": "John Doe",
    "avatar": null,
    "createdAt": "2024-07-29T00:00:00Z"
  },
  "expiresIn": 3600
}
```

**Response (Error):**
```json
{
  "error": "Invalid token",
  "message": "The provided Firebase token is invalid"
}
```

---

## خطوات التنفيذ على Backend

### 1. التحقق من Firebase Token
```javascript
// Node.js/Express example
const admin = require('firebase-admin');

app.post('/auth/social-login', async (req, res) => {
  try {
    const { email, firstName, lastName, provider, providerId, idToken } = req.body;

    // تحقق من Firebase ID Token
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    
    if (decodedToken.email !== email) {
      return res.status(401).json({ error: 'Token email mismatch' });
    }

    // البحث عن المستخدم أو إنشاء واحد جديد
    let user = await User.findOne({ email });
    
    if (!user) {
      user = await User.create({
        email,
        firstName,
        lastName,
        fullName: `${firstName} ${lastName}`,
        provider,
        providerId,
        isEmailVerified: true, // تم التحقق بواسطة Firebase
      });
    } else {
      // تحديث معلومات المستخدم إذا كانت ناقصة
      if (!user.provider) {
        user.provider = provider;
        user.providerId = providerId;
        await user.save();
      }
    }

    // إنشاء JWT tokens
    const accessToken = jwt.sign(
      { userId: user.id, email: user.email },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    );

    const refreshToken = jwt.sign(
      { userId: user.id },
      process.env.REFRESH_TOKEN_SECRET,
      { expiresIn: '7d' }
    );

    // حفظ Refresh Token
    await RefreshToken.create({
      userId: user.id,
      token: refreshToken,
    });

    res.json({
      accessToken,
      refreshToken,
      user: {
        id: user.id,
        email: user.email,
        fullName: user.fullName,
        avatar: user.avatar,
        createdAt: user.createdAt,
      },
      expiresIn: 3600,
    });
  } catch (error) {
    console.error('Social login error:', error);
    res.status(401).json({
      error: 'Authentication failed',
      message: error.message,
    });
  }
});
```

### 2. Database Schema (Optional)

```javascript
// User model
const userSchema = {
  id: String,
  email: String,
  firstName: String,
  lastName: String,
  fullName: String,
  provider: String, // 'google' | 'facebook' | 'email'
  providerId: String, // unique ID from provider
  password: String, // null for social logins
  avatar: String,
  isEmailVerified: Boolean,
  createdAt: Date,
  updatedAt: Date,
};
```

---

## Flutter Implementation Flow

```
1. User taps "Sign in with Google/Facebook"
2. SocialAuthBloc → GoogleSignInRequested/FacebookSignInRequested
3. SocialAuthService → signInWithGoogle()/signInWithFacebook()
4. Firebase returns UserCredential with idToken
5. SocialAuthBloc sends idToken to Backend via AuthRepository
6. Backend verifies Firebase token and creates/updates user
7. Backend returns accessToken + refreshToken
8. App stores tokens in secure storage
9. User is logged in
```

---

## الـ Endpoints الأخرى المطلوبة

### 3. Logout (Optional Enhancement)
**POST** `/auth/logout`
```json
{
  "userId": "user-id"
}
```

### 4. User Profile Update (After Social Login)
**PUT** `/users/profile`
```json
{
  "firstName": "Updated",
  "lastName": "Name",
  "phone": "123456789",
  "bio": "Bio text"
}
```

---

## ملاحظات أمان

1. ✅ تحقق دائماً من Firebase tokens على Backend
2. ✅ لا تثق بـ client-side tokens
3. ✅ استخدم HTTPS فقط
4. ✅ حافظ على JWT_SECRET آمناً في environment variables
5. ✅ أضف rate limiting على `/auth/social-login`
6. ✅ سجل جميع محاولات تسجيل الدخول الفاشلة

---

## Test URLs (بناءً على البيانات السابقة)

```
Production: https://api.kurdwins.com/auth/social-login
Development: http://localhost:3000/auth/social-login
```
