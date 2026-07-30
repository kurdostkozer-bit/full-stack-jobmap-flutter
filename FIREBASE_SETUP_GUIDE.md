# Firebase Setup Guide للـ Social Authentication

## الخطوات المطلوبة

### 1. إنشاء Firebase Project
1. اذهب إلى [Firebase Console](https://console.firebase.google.com/)
2. اضغط على "Create a new project"
3. أدخل اسم المشروع: `jobmap`
4. متابعة الخطوات

### 2. إضافة تطبيق Android
1. في Firebase Console، اضغط على أيقونة Android
2. أدخل معلومات التطبيق:
   - **Package name**: `com.example.jobmap`
   - **App nickname**: `JobMap Android`
   - **SHA-1 certificate fingerprint**: (الخطوة التالية)

### 3. الحصول على SHA-1 Fingerprint
في terminal، شغل:
```bash
cd android
./gradlew signingReport
```

انسخ قيمة `SHA1` وألصقها في Firebase Console.

### 4. تحميل google-services.json
1. بعد إضافة التطبيق، سيتم تحميل ملف `google-services.json`
2. ضع الملف في: `android/app/google-services.json`

### 5. إضافة تطبيق iOS
1. اضغط على أيقونة iOS في Firebase Console
2. أدخل معلومات التطبيق:
   - **Bundle ID**: `com.example.jobmap`
   - **App nickname**: `JobMap iOS`

### 6. تحميل GoogleService-Info.plist
1. بعد إضافة التطبيق، سيتم تحميل ملف `GoogleService-Info.plist`
2. ضع الملف في: `ios/Runner/GoogleService-Info.plist`

### 7. تفعيل Google Sign-In
1. في Firebase Console، اذهب إلى **Authentication**
2. اختر **Sign-in method**
3. فعّل **Google** و **Facebook**

### 8. إضافة Firebase Dependencies (تم بالفعل)
- firebase_core ✓
- firebase_auth ✓
- google_sign_in ✓
- flutter_facebook_auth ✓

## التحقق
بعد الانتهاء من جميع الخطوات، شغّل:
```bash
flutter run
```

يجب أن يكون التطبيق يعمل بدون أخطاء Firebase.
