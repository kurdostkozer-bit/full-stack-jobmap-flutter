# JobMap - هيكل المشروع الكامل

## نظرة عامة

JobMap هو تطبيق Flutter + NestJS لتطابق الوظائف والمتقدمين. يستخدم معمارية نظيفة مع الفصل الواضح بين الطبقات.

---

## المعمارية العامة

```
┌─────────────────────────────────────────────────────────────┐
│                    الطبقة الظاهرة (UI)                      │
│              Presentation Layer (Flutter)                   │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│              طبقة المنطق العملي (BLoC)                      │
│             Application Layer (BLoC/Cubit)                  │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                   طبقة التجريد (Repository)                │
│               Domain Layer (Entities/Contracts)            │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│              طبقة الوصول للبيانات (API/DB)                 │
│        Infrastructure Layer (DataSources/API Client)        │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│              Backend NestJS + PostgreSQL                     │
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 هيكل المشروع

```
jobMap/
├── 📂 lib/                                    # كود Flutter
│   ├── main.dart                             # نقطة الدخول الرئيسية
│   ├── app.dart                              # إعداد التطبيق الرئيسي
│   │
│   ├── 📂 core/                              # الأساسيات المشتركة
│   │   ├── 📂 bloc/                         # BLoCs المشتركة
│   │   ├── 📂 config/                       # الإعدادات العامة
│   │   ├── 📂 constants/                    # الثوابت والقيم الثابتة
│   │   ├── 📂 di/                           # Dependency Injection
│   │   ├── 📂 extensions/                   # توسيعات (Extensions)
│   │   ├── 📂 infrastructure/               # تكوين البنية التحتية
│   │   ├── 📂 navigation/                   # إدارة التنقل
│   │   ├── 📂 network/                      # API Client و HTTP
│   │   ├── 📂 router/                       # المسارات والتوجيه
│   │   ├── 📂 services/                     # الخدمات المشتركة
│   │   │   ├── social_auth_service.dart    # خدمة Google Identity Services
│   │   │   └── ...
│   │   ├── 📂 theme/                        # التصميم والألوان
│   │   └── 📂 widgets/                      # الـ Widgets المشتركة
│   │
│   ├── 📂 design_system/                     # نظام التصميم
│   │   ├── 📂 components/                   # الـ UI Components
│   │   ├── 📂 colors/                       # نظام الألوان
│   │   └── 📂 typography/                   # الخطوط والـ Typography
│   │
│   └── 📂 features/                          # ميزات التطبيق
│       ├── 📂 auth/                         # ✅ المصادقة
│       │   ├── 📂 presentation/             # الشاشات والـ UI
│       │   │   ├── 📂 bloc/                # BLoCs
│       │   │   ├── 📂 pages/               # الصفحات
│       │   │   └── 📂 widgets/             # Widgets خاصة
│       │   ├── 📂 domain/                  # القواعد والـ Entities
│       │   │   ├── 📂 entities/            # Auth entities
│       │   │   ├── 📂 repositories/        # Interfaces
│       │   │   └── 📂 usecases/            # Business logic
│       │   └── 📂 data/                    # الوصول للبيانات
│       │       ├── 📂 datasources/         # Remote و Local
│       │       ├── 📂 models/              # Data models
│       │       └── 📂 repositories/        # Repository implementations
│       │
│       ├── 📂 onboarding/                  # الإعداد الأول
│       ├── 📂 splash/                      # شاشة البداية
│       ├── 📂 home/                        # الصفحة الرئيسية
│       ├── 📂 profile/                     # الملف الشخصي
│       ├── 📂 profile_completion/          # إكمال الملف الشخصي
│       │
│       ├── 📂 career_profile/              # الملف الوظيفي
│       ├── 📂 education/                   # المؤهلات التعليمية
│       ├── 📂 experience/                  # الخبرة العملية
│       ├── 📂 certificates/                # الشهادات
│       ├── 📂 skills/                      # المهارات
│       ├── 📂 languages/                   # اللغات
│       ├── 📂 projects/                    # المشاريع
│       ├── 📂 social_links/                # الروابط الاجتماعية
│       ├── 📂 attachments/                 # الملفات المرفقة
│       │
│       ├── 📂 jobs/                        # الوظائف
│       ├── 📂 job_preferences/             # تفضيلات الوظائف
│       ├── 📂 saved_jobs/                  # الوظائف المحفوظة
│       │
│       ├── 📂 companies/                   # الشركات
│       ├── 📂 map/                         # الخريطة
│       └── 📂 search/                      # البحث
│
├── 📂 backend/                               # كود NestJS
│   ├── 📂 src/
│   │   ├── main.ts                         # نقطة الدخول
│   │   ├── app.module.ts                   # Module الرئيسي
│   │   │
│   │   ├── 📂 auth/                        # ✅ وحدة المصادقة
│   │   │   ├── 📂 controllers/             # API endpoints
│   │   │   ├── 📂 services/                # Business logic
│   │   │   │   ├── auth.service.ts        # خدمة المصادقة الرئيسية
│   │   │   │   └── google-token-verifier.ts # التحقق من Google ID Token
│   │   │   ├── 📂 guards/                  # JWT و Auth guards
│   │   │   ├── 📂 strategies/              # Passport strategies
│   │   │   ├── 📂 dto/                     # Data Transfer Objects
│   │   │   ├── 📂 repositories/            # Data access
│   │   │   └── auth.module.ts             # Module config
│   │   │
│   │   ├── 📂 users/                       # وحدة المستخدمين
│   │   │   ├── 📂 controllers/
│   │   │   ├── 📂 services/
│   │   │   ├── 📂 repositories/
│   │   │   ├── 📂 dto/
│   │   │   └── users.module.ts
│   │   │
│   │   ├── 📂 profiles/                    # وحدة الملفات الشخصية
│   │   │   ├── 📂 controllers/
│   │   │   ├── 📂 services/
│   │   │   ├── 📂 repositories/
│   │   │   └── profiles.module.ts
│   │   │
│   │   ├── 📂 career-profiles/             # الملفات الوظيفية
│   │   ├── 📂 education/                   # المؤهلات
│   │   ├── 📂 experiences/                 # الخبرات
│   │   ├── 📂 certificates/                # الشهادات
│   │   ├── 📂 skills/                      # المهارات
│   │   ├── 📂 languages/                   # اللغات
│   │   ├── 📂 projects/                    # المشاريع
│   │   ├── 📂 social-links/                # الروابط الاجتماعية
│   │   ├── 📂 attachments/                 # الملفات المرفقة
│   │   │
│   │   ├── 📂 jobs/                        # الوظائف
│   │   ├── 📂 companies/                   # الشركات
│   │   ├── 📂 job-preferences/             # تفضيلات الوظائف
│   │   ├── 📂 saved-jobs/                  # الوظائف المحفوظة
│   │   ├── 📂 company-locations/           # مواقع الشركات
│   │   ├── 📂 company-members/             # أعضاء الشركة
│   │   ├── 📂 departments/                 # الأقسام
│   │   ├── 📂 recruiters/                  # المجندون
│   │   │
│   │   ├── 📂 search/                      # محرك البحث
│   │   ├── 📂 notifications/               # الإشعارات
│   │   ├── 📂 chat/                        # الدردشة
│   │   ├── 📂 referrals/                   # نظام الإحالات
│   │   ├── 📂 applications/                # طلبات التقديم
│   │   ├── 📂 maps/                        # الخرائط
│   │   │
│   │   ├── 📂 database/                    # قاعدة البيانات
│   │   │   ├── schema.ts                   # Drizzle schema
│   │   │   ├── database.ts                 # DB config
│   │   │   └── migrations/                 # SQL migrations
│   │   │
│   │   ├── 📂 config/                      # الإعدادات
│   │   │   └── environment.ts              # متغيرات البيئة
│   │   │
│   │   ├── 📂 common/                      # Utilities مشتركة
│   │   │   ├── 📂 decorators/              # Custom decorators
│   │   │   ├── 📂 filters/                 # Exception filters
│   │   │   ├── 📂 interceptors/            # HTTP interceptors
│   │   │   ├── 📂 pipes/                   # Validation pipes
│   │   │   └── 📂 guards/                  # Guards عامة
│   │   │
│   │   └── 📂 modules/                     # إعدادات Module
│   │
│   ├── 📂 migrations/                       # قاعدة البيانات
│   ├── 📂 drizzle/                          # Drizzle ORM config
│   ├── 📂 dist/                             # Output المترجم
│   ├── 📂 test/                             # Unit tests
│   ├── 📂 tests/                            # Integration tests
│   ├── 📂 postman/                          # Postman collections
│   │
│   ├── .env                                 # متغيرات البيئة
│   ├── .env.example                         # مثال الإعدادات
│   ├── package.json                         # Dependencies
│   ├── pnpm-lock.yaml                       # Lock file
│   ├── tsconfig.json                        # TypeScript config
│   ├── nest-cli.json                        # NestJS config
│   ├── drizzle.config.ts                    # Drizzle config
│   └── README.md
│
├── 📂 android/                               # مجلد Android
├── 📂 ios/                                   # مجلد iOS
├── 📂 web/                                   # مجلد Web
├── 📂 macos/                                 # مجلد macOS
├── 📂 linux/                                 # مجلد Linux
├── 📂 windows/                               # مجلد Windows
│
├── 📂 assets/                                # الصور والموارد
├── 📂 build/                                 # Build output
├── 📂 test/                                  # Flutter tests
│
├── pubspec.yaml                              # Flutter dependencies
├── analysis_options.yaml                     # Linter config
├── firebase.json                             # Firebase config
├── ARCHITECTURE.md                           # وثائق المعمارية
├── PROJECT_ROADMAP.md                        # الخارطة الطريقية
├── QUICK_START.md                            # البدء السريع
├── README.md                                 # الملخص العام
└── .gitignore                                # Git ignore rules
```

---

## 🔐 معمارية المصادقة

```
lib/features/auth/
├── presentation/
│   ├── bloc/
│   │   ├── social_auth_bloc.dart           # BLoC للمصادقة الاجتماعية
│   │   ├── social_auth_event.dart
│   │   └── social_auth_state.dart
│   ├── pages/
│   │   └── login_page.dart
│   └── widgets/
│       └── ...
├── domain/
│   ├── entities/
│   │   └── auth_session.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       ├── login_usecase.dart
│       └── logout_usecase.dart
└── data/
    ├── datasources/
    │   ├── auth_remote_data_source.dart
    │   └── auth_remote_data_source_impl.dart
    ├── models/
    │   └── auth_session_model.dart
    └── repositories/
        └── auth_repository_impl.dart

core/services/
├── social_auth_service.dart                # Google Identity Services
└── ...
```

### تدفق المصادقة

```
1. Flutter UI
    │
2. social_auth_bloc.dart (GoogleSignInRequested event)
    │
3. social_auth_service.dart (Google Identity Services)
    │
4. Google ID Token
    │
5. AuthRemoteDataSourceImpl
    │
6. POST /auth/social/google { idToken }
    │
7. NestJS Backend
    ├─ GoogleTokenVerifier.verifyIdToken()
    ├─ Validate: issuer, audience, expiration, email_verified
    └─ Extract: email, name, picture, sub
    │
8. AuthService.googleSocialLogin()
    ├─ Find or Create User
    └─ db.transaction() for atomicity
    │
9. Generate JobMap JWT
    │
10. Return AuthSession
    │
11. Save to Local Storage
    │
12. Emit SocialAuthSuccess
```

---

## 🗄️ قاعدة البيانات

### الجداول الرئيسية

```
users
├── id (UUID)
├── email (UNIQUE)
├── passwordHash (nullable for Google users)
├── googleId (nullable, UNIQUE)
├── googleEmail (nullable)
├── profileImage (nullable)
├── isEmailVerified
├── provider ('local' | 'google')
├── createdAt
└── updatedAt

profiles
├── id (UUID)
├── userId (FOREIGN KEY → users.id)
├── firstName (nullable)
├── lastName (nullable)
├── bio (nullable)
├── profilePicture (nullable)
├── phone (nullable)
├── location (nullable)
└── updatedAt

career_profiles
├── id
├── userId (FOREIGN KEY)
├── title
├── summary
└── ...

education
├── id
├── userId (FOREIGN KEY)
├── school
├── degree
└── ...

experience
├── id
├── userId (FOREIGN KEY)
├── company
├── position
└── ...

... (والمزيد من الجداول)
```

---

## 🔌 API Endpoints الرئيسية

### Authentication
```
POST   /auth/register                # تسجيل جديد
POST   /auth/login                   # تسجيل دخول
POST   /auth/social/google           # تسجيل دخول Google
POST   /auth/refresh-token           # تجديد التوكن
POST   /auth/logout                  # تسجيل خروج
POST   /auth/verify-email            # التحقق من البريد
POST   /auth/request-password-reset  # طلب إعادة تعيين
POST   /auth/reset-password          # إعادة تعيين كلمة السر
PATCH  /auth/change-password         # تغيير كلمة السر
GET    /auth/me                      # بيانات المستخدم الحالي
```

### User Profile
```
GET    /profiles/{id}
PATCH  /profiles/{id}
```

### Career Profile
```
POST   /career-profiles
GET    /career-profiles/{id}
PATCH  /career-profiles/{id}
```

### Education
```
POST   /education
GET    /education/{id}
PATCH  /education/{id}
DELETE /education/{id}
```

### Jobs
```
GET    /jobs
GET    /jobs/{id}
POST   /jobs
PATCH  /jobs/{id}
DELETE /jobs/{id}
```

### Companies
```
GET    /companies
GET    /companies/{id}
POST   /companies
```

... (والمزيد من الـ Endpoints)

---

## 📦 المكتبات الرئيسية

### Flutter
```yaml
flutter_bloc: ^8.0.0          # State management
get_it: ^7.0.0               # Dependency injection
retrofit: ^4.0.0             # HTTP client
dio: ^5.0.0                  # HTTP library
google_identity_services_web # Google Sign-In Web
google_sign_in: ^6.0.0       # Google Sign-In Native
hive: ^2.0.0                 # Local storage
equatable: ^2.0.0            # Value equality
cached_network_image: ^3.0.0 # Image caching
```

### NestJS
```json
"@nestjs/core": "^10.0.0"
"@nestjs/common": "^10.0.0"
"@nestjs/jwt": "^12.0.0"
"@nestjs/passport": "^10.0.0"
"@nestjs/config": "^3.0.0"
"postgres": "^15.0.0"
"drizzle-orm": "^0.28.0"
"drizzle-kit": "^0.19.0"
"bcrypt": "^5.1.0"
"google-auth-library": "^9.0.0"
"class-validator": "^0.14.0"
"class-transformer": "^0.5.0"
```

---

## 🚀 التدفق الأساسي للتطبيق

### 1. البدء (Splash Screen)
```
splash_page.dart
  ├─ Check if user is authenticated
  ├─ If yes: Navigate to Home
  └─ If no: Navigate to Login
```

### 2. تسجيل الدخول (Auth)
```
login_page.dart
  ├─ User clicks "Sign in with Google"
  ├─ social_auth_bloc.dart emits GoogleSignInRequested
  ├─ social_auth_service.dart calls Google Identity Services
  ├─ Flutter sends idToken to /auth/social/google
  ├─ Backend verifies token and creates/finds user
  ├─ Backend returns JobMap JWT
  └─ Save JWT to local storage
```

### 3. الصفحة الرئيسية (Home)
```
home_page.dart
  ├─ Display user info
  ├─ Fetch jobs list
  ├─ Fetch saved jobs
  └─ Navigation to other features
```

### 4. ملء الملف الشخصي (Profile Completion)
```
profile_completion_page.dart
  ├─ Career profile
  ├─ Education
  ├─ Experience
  ├─ Skills
  ├─ Languages
  ├─ Certificates
  ├─ Projects
  └─ Social links
```

### 5. البحث عن الوظائف (Jobs)
```
jobs_page.dart
  ├─ Search jobs
  ├─ Filter by preferences
  ├─ Save jobs
  └─ Apply to jobs
```

---

## 🔐 أمان المشروع

### Backend
- ✅ JWT Authentication مع NestJS
- ✅ Google ID Token Verification
- ✅ CORS configured
- ✅ Rate limiting
- ✅ Input validation with class-validator
- ✅ bcrypt for password hashing
- ✅ Environment variables for secrets
- ✅ Database transactions for atomicity

### Frontend
- ✅ Secure local token storage
- ✅ JWT token validation
- ✅ Refresh token mechanism
- ✅ Google Identity Services (no Firebase Auth)
- ✅ HTTPS only
- ✅ No hardcoded secrets

---

## 📊 حالة المشروع

| المكون | الحالة |
|-------|--------|
| المصادقة (Auth) | ✅ مكتمل |
| ملف المستخدم (Profile) | ✅ مكتمل |
| الملف الوظيفي (Career) | ✅ مكتمل |
| المؤهلات (Education) | ✅ مكتمل |
| الخبرة (Experience) | ✅ مكتمل |
| المهارات (Skills) | ✅ مكتمل |
| اللغات (Languages) | ✅ مكتمل |
| الشهادات (Certificates) | ✅ مكتمل |
| المشاريع (Projects) | ✅ مكتمل |
| الروابط الاجتماعية | ✅ مكتمل |
| الوظائف (Jobs) | ✅ مكتمل |
| الشركات (Companies) | ✅ مكتمل |
| تفضيلات الوظائف | ✅ مكتمل |
| البحث (Search) | 🟡 جاري |
| الدردشة (Chat) | 🟡 جاري |
| الإشعارات (Notifications) | 🟡 جاري |

---

## 🛠️ الأدوات والخدمات

### Development
- VS Code
- Android Studio / Xcode
- Git / GitHub
- Postman

### Backend
- NestJS Framework
- PostgreSQL Database
- Drizzle ORM
- JWT Authentication
- Google OAuth 2.0

### Frontend
- Flutter
- BLoC Pattern
- Retrofit HTTP Client
- Hive Local Storage
- Google Identity Services

### DevOps
- Docker (للـ Backend)
- Environment variables (.env)
- Database migrations
- Build scripts

---

## 📚 المراجع والتوثيق

داخل المشروع ستجد:
- `ARCHITECTURE.md` - توثيق المعمارية
- `API_QUICK_REFERENCE.md` - مرجع سريع للـ API
- `BACKEND_INTEGRATION_GUIDE.md` - دليل التكامل
- `SOCIAL_AUTH_IMPLEMENTATION_SUMMARY.md` - ملخص المصادقة
- `QUICK_START.md` - البدء السريع
- `TESTING_GUIDE.md` - دليل الاختبار

---

## 🚀 البدء السريع

### Frontend (Flutter)
```bash
cd jobMap
flutter pub get
flutter run -d chrome  # Web
flutter run -d emulator  # Android
flutter run  # iOS
```

### Backend (NestJS)
```bash
cd backend
npm install  # أو pnpm install
npm run dev  # تشغيل في وضع التطوير
npm run build  # بناء الإنتاج
```

---

**آخر تحديث:** يوليو 2026
**الحالة:** جاهز للإنتاج ✅
