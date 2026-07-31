# Google OAuth و Facebook Setup Guide

## Part 1: إعداد Google OAuth في Firebase Console

### 1. إنشاء Google Cloud Project
1. اذهب إلى [Google Cloud Console](https://console.cloud.google.com/)
2. اضغط على dropdown بجانب "Google Cloud" في الأعلى
3. اضغط "New Project"
4. أدخل اسم المشروع: `jobmap-oauth`
5. اضغط "Create"

### 2. تفعيل Google Sign-In API
1. في Google Cloud Console، اذهب إلى **APIs & Services**
2. اضغط **Enable APIs and Services**
3. ابحث عن: `Google+ API` أو `Google Identity`
4. اضغط **Enable**

### 3. إنشاء OAuth 2.0 Credentials

#### للـ Android:
1. اذهب إلى **Credentials**
2. اضغط **Create Credentials** → **OAuth 2.0 Client ID**
3. اختر **Android**
4. أدخل البيانات:
   - **Package name**: `com.example.jobmap`
   - **SHA-1 certificate fingerprint**: (من `./gradlew signingReport`)
5. اضغط **Create**
6. انسخ `Client ID`

#### للـ iOS:
1. اضغط **Create Credentials** → **OAuth 2.0 Client ID**
2. اختر **iOS**
3. أدخل البيانات:
   - **Bundle ID**: `com.example.jobmap`
4. اضغط **Create**
5. انسخ `Client ID`

#### للـ Web:
1. اضغط **Create Credentials** → **OAuth 2.0 Client ID**
2. اختر **Web application**
3. أدخل البيانات:
   - **Name**: `JobMap Web`
   - **Authorized redirect URIs**: 
     - `http://localhost:3000/callback`
     - `https://api.kurdwins.com/auth/google/callback`
4. اضغط **Create**
5. انسخ `Client ID` و `Client Secret`

### 4. في Firebase Console
1. اذهب إلى [Firebase Console](https://console.firebase.google.com/)
2. اختر مشروع `jobmap`
3. اذهب إلى **Authentication** → **Sign-in method**
4. فعّل **Google**
5. أدخل البيانات:
   - **Web SDK configuration**: انسخ من Google Cloud Console
6. اضغط **Save**

---

## Part 2: إعداد Facebook App

### 1. إنشاء Facebook Developer Account
1. اذهب إلى [Facebook Developers](https://developers.facebook.com/)
2. اضغط **Get Started**
3. سجل حساب Facebook أو قم بتسجيل الدخول

### 2. إنشاء تطبيق جديد
1. في Dashboard، اضغط **My Apps** → **Create App**
2. اختر **Consumer**
3. أدخل بيانات التطبيق:
   - **App Name**: `JobMap`
   - **App Contact Email**: البريد الإلكتروني الخاص بك
   - **App Purpose**: اختر المناسب (مثل: Marketplace, Job Board)
4. اضغط **Create App ID**

### 3. إضافة Facebook Login Product
1. في صفحة التطبيق، اضغط **Add Product**
2. ابحث عن **Facebook Login**
3. اضغط **Set Up**
4. اختر **Flutter** أو **Mobile**

### 4. إعداد Platforms

#### للـ Android:
1. اضغط على **Android** 
2. أدخل:
   - **Package name**: `com.example.jobmap`
   - **Class name**: `com.example.jobmap.MainActivity`
   - **Key Hashes**: (من `cd android && ./gradlew signingReport`)
3. تحميل `google-services.json` (إن طُلب)

#### للـ iOS:
1. اضغط على **iOS**
2. أدخل:
   - **Bundle ID**: `com.example.jobmap`
3. احفظ التغييرات

### 5. الحصول على Facebook App ID و App Secret
1. اذهب إلى **Settings** → **Basic**
2. انسخ:
   - **App ID**
   - **App Secret** (احفظها في مكان آمن!)

### 6. إضافة Facebook Login في Firebase Console
1. اذهب إلى Firebase Console
2. اختر مشروع `jobmap`
3. اذهب إلى **Authentication** → **Sign-in method**
4. فعّل **Facebook**
5. أدخل:
   - **Facebook App ID**
   - **Facebook App Secret**
6. اضغط **Save**

---

## Part 3: الحصول على SHA-1 و Key Hashes

### SHA-1 Fingerprint (لـ Google):
```bash
cd android
./gradlew signingReport
```
ستجد في الـ output:
```
Variant: debug
Config: debug
Store: ~/.android/debug.keystore
...
SHA1: AB:CD:EF:...
```

### Key Hash (لـ Facebook):
```bash
cd android
./gradlew signingReport
```
ثم حول SHA1 إلى Base64:
```bash
echo -n "AB:CD:EF:..." | echo -n "$(cat)" | openssl dgst -sha1 -binary | openssl enc -base64
```

---

## Part 4: تحديث firebase_options.dart

بعد الحصول على جميع البيانات، حدّث `lib/firebase_options.dart`:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ANDROID_API_KEY',
  appId: '1:YOUR_PROJECT_NUMBER:android:YOUR_APP_ID',
  messagingSenderId: 'YOUR_PROJECT_NUMBER',
  projectId: 'your-firebase-project-id',
  storageBucket: 'your-project-id.appspot.com',
);
```

الحصول على هذه البيانات:
1. في Firebase Console → **Project Settings**
2. انسخ بيانات التطبيق (Android/iOS)
3. الصقها في `firebase_options.dart`

---

## التحقق من الإعداد

بعد الانتهاء:
1. ضع `google-services.json` في `android/app/`
2. ضع `GoogleService-Info.plist` في `ios/Runner/`
3. شغّل:
```bash
flutter clean
flutter pub get
flutter run
```

يجب أن تظهر رسائل Firebase بدون أخطاء.
