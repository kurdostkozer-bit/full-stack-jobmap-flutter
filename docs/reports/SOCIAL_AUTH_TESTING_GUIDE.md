# Social Authentication Testing Guide

## التحضيرات الأولية

### 1. تثبيت Firebase Emulator (اختياري - للتطوير المحلي)
```bash
# تثبيت Firebase CLI
npm install -g firebase-tools

# تسجيل الدخول
firebase login

# بدء Emulator
firebase emulators:start
```

### 2. جهاز اختبار Android

#### الحصول على SHA-1 Fingerprint:
```bash
cd android
./gradlew signingReport
```

**النتيجة:**
```
Variant: debug
Config: debug
Store: ~/.android/debug.keystore
Alias: androiddebugkey
MD5: ...
SHA1: AB:CD:EF:12:34:56:78:90:AB:CD:EF:12:34:56:78:90
SHA256: ...
```

انسخ قيمة **SHA1** وأضفها إلى Firebase Console:
1. Firebase Console → Project Settings
2. اختر التطبيق Android
3. أضف SHA-1 Fingerprint
4. احفظ

---

## اختبارات اليدوية

### Test Case 1: Google Sign-In
**الخطوات:**
1. افتح التطبيق
2. اضغط على "Continue with Google" في LoginScreen
3. اختر حساب Google من القائمة
4. وافق على الأذونات

**النتائج المتوقعة:**
- ✅ يتم تسجيل الدخول بنجاح
- ✅ تظهر رسالة "Logged in successfully!"
- ✅ ينتقل إلى HomeScreen
- ✅ بيانات المستخدم محفوظة في Secure Storage

**في حالة الفشل:**
- ❌ رسالة خطأ "Login failed: ..."
- ❌ البقاء في LoginScreen
- ❌ عدم الحفظ في Secure Storage

---

### Test Case 2: Facebook Sign-In
**الخطوات:**
1. افتح التطبيق
2. اضغط على "Continue with Facebook" في LoginScreen
3. أدخل بيانات حساب Facebook
4. وافق على الأذونات

**النتائج المتوقعة:**
- ✅ يتم تسجيل الدخول بنجاح
- ✅ تظهر رسالة "Logged in successfully!"
- ✅ ينتقل إلى HomeScreen
- ✅ بيانات المستخدم محفوظة

---

### Test Case 3: Google Sign-Up (من RegisterScreen)
**الخطوات:**
1. افتح التطبيق
2. اذهب إلى RegisterScreen
3. اضغط على "Sign up with Google"
4. اختر حساب Google
5. وافق على الأذونات

**النتائج المتوقعة:**
- ✅ حساب جديد إذا لم يكن موجوداً
- ✅ تسجيل دخول فوري بعد الإنشاء
- ✅ انتقال إلى HomeScreen
- ✅ حفظ البيانات

---

### Test Case 4: Facebook Sign-Up
**الخطوات:**
1. افتح التطبيق
2. اذهب إلى RegisterScreen
3. اضغط على "Sign up with Facebook"
4. أدخل بيانات Facebook
5. وافق على الأذونات

**النتائج المتوقعة:**
- ✅ حساب جديد
- ✅ تسجيل دخول فوري
- ✅ انتقال إلى HomeScreen

---

### Test Case 5: Logout
**الخطوات:**
1. سجل دخول عبر Google
2. اذهب إلى Profile/Settings
3. اضغط على Logout

**النتائج المتوقعة:**
- ✅ تم حذف الـ tokens من Secure Storage
- ✅ تم تسجيل الخروج من Firebase
- ✅ تم تسجيل الخروج من Google/Facebook
- ✅ العودة إلى LoginScreen

---

### Test Case 6: Network Error Handling
**الخطوات:**
1. ضع الجهاز في Airplane Mode
2. اضغط على "Continue with Google"
3. حاول تسجيل الدخول

**النتائج المتوقعة:**
- ✅ رسالة خطأ واضحة: "Network error..."
- ✅ إمكانية إعادة المحاولة
- ✅ عدم تعطل التطبيق

---

### Test Case 7: Invalid Token
**الخطوات (يحتاج Mocking):**
1. عدّل Firebase token في SocialAuthService
2. اضغط على "Continue with Google"

**النتائج المتوقعة:**
- ✅ رسالة خطأ: "Invalid token"
- ✅ البقاء في LoginScreen
- ✅ إمكانية إعادة المحاولة

---

## اختبارات الـ Unit Tests

### Test 1: SocialAuthService - Google Sign-In

```dart
test('signInWithGoogle returns UserCredential when successful', () async {
  // Arrange
  final mockGoogleSignIn = MockGoogleSignIn();
  final mockFirebaseAuth = MockFirebaseAuth();
  final service = SocialAuthService(
    googleSignIn: mockGoogleSignIn,
    firebaseAuth: mockFirebaseAuth,
  );

  // Act
  final result = await service.signInWithGoogle();

  // Assert
  expect(result, isNotNull);
  expect(result?.user, isNotNull);
});

test('signInWithGoogle returns null when cancelled', () async {
  // Arrange
  final mockGoogleSignIn = MockGoogleSignIn();
  mockGoogleSignIn.returnNull(); // User cancelled
  
  final service = SocialAuthService(googleSignIn: mockGoogleSignIn);

  // Act
  final result = await service.signInWithGoogle();

  // Assert
  expect(result, isNull);
});
```

### Test 2: SocialAuthBloc - Google Sign-In Event

```dart
void main() {
  group('SocialAuthBloc', () {
    late SocialAuthBloc socialAuthBloc;
    late MockSocialAuthService mockService;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockService = MockSocialAuthService();
      mockRepository = MockAuthRepository();
      socialAuthBloc = SocialAuthBloc(
        socialAuthService: mockService,
        authRepository: mockRepository,
      );
    });

    test('emit SocialAuthLoading then SocialAuthSuccess on Google sign-in',
        () async {
      // Arrange
      when(mockService.signInWithGoogle())
          .thenAnswer((_) async => mockUserCredential);

      // Act
      socialAuthBloc.add(const GoogleSignInRequested());

      // Assert
      expect(
        socialAuthBloc.stream,
        emitsInOrder([
          SocialAuthLoading(),
          SocialAuthSuccess(authSession: mockAuthSession),
        ]),
      );
    });
  });
}
```

---

## اختبارات الـ Integration Tests

### Integration Test 1: Complete Google Login Flow

```dart
void main() {
  group('Google Login Integration Test', () {
    testWidgets('User can login with Google', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const JobMapApp());

      // Act - Navigate to login
      await tester.tap(find.byType(LoginScreen));
      await tester.pumpAndSettle();

      // Act - Tap Google Sign-In
      await tester.tap(find.byKey(const Key('google_signin_button')));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Assert - Check if logged in
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byKey(const Key('user_profile')), findsOneWidget);
    });
  });
}
```

---

## API Testing

### Test Endpoint: POST /auth/social-login

**Using cURL:**
```bash
curl -X POST https://api.kurdwins.com/auth/social-login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "provider": "google",
    "providerId": "google-uid-123",
    "idToken": "firebase-id-token-here"
  }'
```

**Using Postman:**
1. Open Postman
2. Set method to **POST**
3. URL: `https://api.kurdwins.com/auth/social-login`
4. Body (JSON):
```json
{
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "provider": "google",
  "providerId": "unique-provider-id",
  "idToken": "firebase-token"
}
```

**Expected Response:**
```json
{
  "accessToken": "jwt-token",
  "refreshToken": "refresh-token",
  "user": {
    "id": "user-id",
    "email": "user@example.com",
    "fullName": "John Doe",
    "createdAt": "2024-07-29T00:00:00Z"
  },
  "expiresIn": 3600
}
```

---

## اختبار على أجهزة حقيقية

### Android Real Device
```bash
# بناء APK
flutter build apk --release

# تثبيت على جهاز
adb install build/app/outputs/apk/release/app-release.apk

# تشغيل
adb shell am start -n com.example.jobmap/.MainActivity
```

### iOS Real Device
```bash
# بناء IPA
flutter build ios --release

# فتح Xcode وتثبيت من هناك
open ios/Runner.xcworkspace
```

---

## ملاحظات الأمان

- ✅ استخدم Firebase Emulator في التطوير
- ✅ لا تستخدم Firebase credentials الحقيقية في الاختبارات
- ✅ تحقق من صحة الـ tokens على Backend
- ✅ استخدم HTTPS فقط للـ API calls
- ✅ احفظ الـ tokens في Secure Storage فقط

---

## Debugging

### في حالة الفشل:

```dart
// أضف هذا في SocialAuthService للـ debugging
Future<UserCredential?> signInWithGoogle() async {
  try {
    debugPrint('Starting Google Sign-In...');
    final googleUser = await _googleSignIn.signIn();
    debugPrint('Google user: ${googleUser?.email}');
    
    if (googleUser == null) {
      debugPrint('Google sign-in cancelled');
      return null;
    }

    final googleAuth = await googleUser.authentication;
    debugPrint('Got authentication: ${googleAuth.idToken}');

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final result = await _firebaseAuth.signInWithCredential(credential);
    debugPrint('Firebase sign-in successful: ${result.user?.email}');
    return result;
  } catch (e) {
    debugPrint('Google Sign-In error: $e');
    rethrow;
  }
}
```

### Firebase Console Logs
1. Firebase Console → Authentication
2. اختر Tab "Sign-in method"
3. شاهد الـ logs للمحاولات الفاشلة

### Backend Logs
```bash
# في Backend
tail -f logs/auth.log
```

---

## Checklist الاختبار

- [ ] Google Sign-In يعمل على Android
- [ ] Google Sign-In يعمل على iOS
- [ ] Facebook Sign-In يعمل على Android
- [ ] Facebook Sign-In يعمل على iOS
- [ ] Tokens محفوظة بشكل آمن
- [ ] Sign-Out يعمل بشكل صحيح
- [ ] معالجة الأخطاء تعمل بشكل صحيح
- [ ] Backend endpoint يعمل
- [ ] إنشاء حسابات جديدة يعمل
- [ ] تحديث الحسابات الموجودة يعمل
- [ ] Network errors معالجة بشكل صحيح
- [ ] التطبيق لا يتعطل في أي حالة
