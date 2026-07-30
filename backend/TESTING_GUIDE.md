# Backend Testing Guide

## Phase 2: Verification & Testing

هذا الملف يحتوي على دليل اختبار الـ Backend APIs بطريقة احترافية وقابلة للتكرار.

---

## المرحلة الأولى: إعداد بيئة الاختبار

### 1. تشغيل السيرفر

```bash
cd backend
npm run start:dev
```

**النتيجة المتوقعة:**
```
🚀 JobMap API running at http://localhost:3000/api/v1
```

### 2. التأكد من اتصال قاعدة البيانات

قاعدة البيانات يجب أن تكون جاهزة:

```bash
# تحقق من .env
DATABASE_URL=postgres://user:pass@localhost:5432/jobmap
```

### 3. تجهيز أدوات الاختبار

اختر إحدى الطريقتين:

**الخيار 1: استخدام Postman**
```
1. افتح Postman
2. استورد: backend/postman/JobMap-Auth-Tests.postman_collection.json
3. عين متغيرات البيئة:
   - base_url: http://localhost:3000
   - access_token: (ستُملأ بعد Login)
   - refresh_token: (ستُملأ بعد Login)
```

**الخيار 2: استخدام REST Client Extension (VS Code)**
```
1. ثبت: REST Client Extension
2. افتح: backend/tests/auth.http
3. اضغط "Send Request" على كل اختبار
```

---

## المرحلة الثانية: اختبار Auth Module

### الخطوة 1: HAPPY PATH - المسار السعيد

#### 1.1 Register - إنشاء مستخدم جديد

**Request:**
```bash
POST http://localhost:3000/v1/auth/register
Content-Type: application/json

{
  "email": "testuser@example.com",
  "password": "TestPassword123!"
}
```

**النتيجة المتوقعة:**
```
✅ Status: 201 Created
✅ Response يحتوي على:
   - message: "Registration completed successfully."
   - accessToken: "eyJ..."
   - refreshToken: "eyJ..."
   - user: { id, email, isEmailVerified, createdAt }
```

**التحقق من Database:**
```sql
SELECT * FROM users WHERE email = 'testuser@example.com';
-- تأكد: password مشفر بـ bcrypt (يبدأ بـ $2b$)
-- تأكد: isEmailVerified = false (افتراضي)
```

#### 1.2 Login - تسجيل الدخول

**Request:**
```bash
POST http://localhost:3000/v1/auth/login
Content-Type: application/json

{
  "email": "testuser@example.com",
  "password": "TestPassword123!"
}
```

**النتيجة المتوقعة:**
```
✅ Status: 200 OK
✅ Response يحتوي على accessToken و refreshToken
✅ احفظ الـ tokens للخطوات التالية
```

#### 1.3 Get Me - الحصول على معلومات المستخدم الحالي

**Request:**
```bash
GET http://localhost:3000/v1/auth/me
Authorization: Bearer {accessToken}
```

**النتيجة المتوقعة:**
```
✅ Status: 200 OK
✅ Response يحتوي على:
   {
     "user": {
       "id": "...",
       "email": "testuser@example.com"
     }
   }
```

#### 1.4 Refresh Token - تحديث الـ Token

**Request:**
```bash
POST http://localhost:3000/v1/auth/refresh-token
Content-Type: application/json

{
  "refreshToken": "{refreshToken}"
}
```

**النتيجة المتوقعة:**
```
✅ Status: 200 OK
✅ Response يحتوي على accessToken جديد
```

#### 1.5 Change Password - تغيير كلمة المرور

**Request:**
```bash
PATCH http://localhost:3000/v1/auth/change-password
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "currentPassword": "TestPassword123!",
  "newPassword": "NewPassword789!",
  "confirmPassword": "NewPassword789!"
}
```

**النتيجة المتوقعة:**
```
✅ Status: 200 OK
✅ message: "Password changed successfully."
✅ تحقق: الدخول بـ كلمة المرور الجديدة يعمل
```

**التحقق من Database:**
```sql
SELECT password_hash FROM users WHERE email = 'testuser@example.com';
-- تأكد: كلمة المرور مختلفة عن السابق
```

#### 1.6 Logout - تسجيل الخروج

**Request:**
```bash
POST http://localhost:3000/v1/auth/logout
Authorization: Bearer {accessToken}
```

**النتيجة المتوقعة:**
```
✅ Status: 200 OK
✅ message: "Logged out successfully."
```

---

### الخطوة 2: VALIDATION - اختبار البيانات غير الصحيحة

#### 2.1 Invalid Email Format

**Request:**
```bash
POST http://localhost:3000/v1/auth/register
{
  "email": "invalid-email",
  "password": "TestPassword123!"
}
```

**النتيجة المتوقعة:**
```
❌ Status: 400 Bad Request
❌ error: "Email must be a valid email"
```

#### 2.2 Password Too Short

**Request:**
```bash
POST http://localhost:3000/v1/auth/register
{
  "email": "newuser@example.com",
  "password": "short"
}
```

**النتيجة المتوقعة:**
```
❌ Status: 400 Bad Request
❌ error: "Password must be at least 8 characters"
```

#### 2.3 Empty Password

**Request:**
```bash
POST http://localhost:3000/v1/auth/register
{
  "email": "newuser2@example.com",
  "password": ""
}
```

**النتيجة المتوقعة:**
```
❌ Status: 400 Bad Request
```

#### 2.4 Missing Required Field

**Request:**
```bash
POST http://localhost:3000/v1/auth/register
{
  "password": "TestPassword123!"
}
```

**النتيجة المتوقعة:**
```
❌ Status: 400 Bad Request
❌ error: "email should not be empty"
```

#### 2.5 Duplicate Email

**Request:**
```bash
POST http://localhost:3000/v1/auth/register
{
  "email": "testuser@example.com",
  "password": "AnotherPassword123!"
}
```

**النتيجة المتوقعة:**
```
❌ Status: 409 Conflict
❌ message: "Email is already registered."
```

#### 2.6 Wrong Password

**Request:**
```bash
POST http://localhost:3000/v1/auth/login
{
  "email": "testuser@example.com",
  "password": "WrongPassword123!"
}
```

**النتيجة المتوقعة:**
```
❌ Status: 401 Unauthorized
❌ message: "Invalid email or password."
```

#### 2.7 User Not Found

**Request:**
```bash
POST http://localhost:3000/v1/auth/login
{
  "email": "nonexistent@example.com",
  "password": "TestPassword123!"
}
```

**النتيجة المتوقعة:**
```
❌ Status: 401 Unauthorized
❌ message: "Invalid email or password."
```

---

### الخطوة 3: AUTHORIZATION - اختبار الصلاحيات

#### 3.1 Protected Endpoint - بدون Token

**Request:**
```bash
GET http://localhost:3000/v1/auth/me
```

**النتيجة المتوقعة:**
```
❌ Status: 401 Unauthorized
❌ message: "Unauthorized"
```

#### 3.2 Protected Endpoint - Invalid Token

**Request:**
```bash
GET http://localhost:3000/v1/auth/me
Authorization: Bearer invalid.token.here
```

**النتيجة المتوقعة:**
```
❌ Status: 401 Unauthorized
```

#### 3.3 Change Password - بدون Token

**Request:**
```bash
PATCH http://localhost:3000/v1/auth/change-password
{
  "currentPassword": "TestPassword123!",
  "newPassword": "NewPassword789!",
  "confirmPassword": "NewPassword789!"
}
```

**النتيجة المتوقعة:**
```
❌ Status: 401 Unauthorized
```

#### 3.4 Change Password - Wrong Current Password

**Request:**
```bash
PATCH http://localhost:3000/v1/auth/change-password
Authorization: Bearer {accessToken}
{
  "currentPassword": "WrongPassword123!",
  "newPassword": "NewPassword789!",
  "confirmPassword": "NewPassword789!"
}
```

**النتيجة المتوقعة:**
```
❌ Status: 401 Unauthorized
❌ message: "Current password is incorrect."
```

---

### الخطوة 4: DATABASE - التحقق من قاعدة البيانات

```sql
-- 1. التحقق من User تم إنشاؤه
SELECT id, email, is_email_verified, created_at FROM users 
WHERE email = 'testuser@example.com';

-- 2. التحقق من Password مشفر
SELECT password_hash FROM users 
WHERE email = 'testuser@example.com';
-- يجب أن يبدأ بـ $2b$ (bcrypt hash)

-- 3. التحقق من عدد Users
SELECT COUNT(*) FROM users;
```

---

## النتيجة النهائية

### Auth Module Status

عندما تنجح جميع الاختبارات أعلاه:

```
✅ Auth Module = VERIFIED

Tests Passed:
  ✔ Register (Happy Path)
  ✔ Login (Happy Path)
  ✔ Get Me (Happy Path)
  ✔ Refresh Token (Happy Path)
  ✔ Change Password (Happy Path)
  ✔ Logout (Happy Path)
  ✔ Invalid Email Validation
  ✔ Password Too Short Validation
  ✔ Empty Password Validation
  ✔ Missing Field Validation
  ✔ Duplicate Email Validation
  ✔ Wrong Password Error
  ✔ User Not Found Error
  ✔ No Token Authorization
  ✔ Invalid Token Authorization
  ✔ Wrong Current Password
  ✔ Database Integrity

Response Format: ✅ Consistent
Error Codes: ✅ Correct
Authorization: ✅ Working
Database: ✅ Intact
```

---

## أدوات مفيدة

### Postman Variables Script

في Postman، بعد Login، استخدم هذا الـ script في Tests tab:

```javascript
if (pm.response.code === 200 || pm.response.code === 201) {
    var jsonData = pm.response.json();
    if (jsonData.accessToken) {
        pm.environment.set("access_token", jsonData.accessToken);
    }
    if (jsonData.refreshToken) {
        pm.environment.set("refresh_token", jsonData.refreshToken);
    }
}
```

### Database Testing Queries

```sql
-- احذر من الاختبارات
DELETE FROM users WHERE email LIKE '%@example.com';
```

---

## الخطوة التالية

بعد ✅ **Auth Module = VERIFIED**

ننتقل إلى:

```
🔄 Jobs Module Testing
```

---

*آخر تحديث: July 31, 2026*  
*Status: In Progress*
