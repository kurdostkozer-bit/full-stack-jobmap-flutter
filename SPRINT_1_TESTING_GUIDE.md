# Sprint 1 - Comprehensive Testing Guide

**Date**: July 29, 2026  
**Phase**: Testing & Verification  
**Status**: Ready to execute  

---

## 📋 Task 12: Manual Testing - All CRUD Operations

### Prerequisites
- Backend running (local or staging)
- Flutter app running on device/emulator
- Valid user account logged in
- Internet connection active

---

## 🧪 Education Feature Testing

### Test 1: Load Education List (GET)
**Steps**:
1. Navigate to `/education` (or tap Education from menu)
2. Wait for data to load

**Expected Result**:
- ✅ Screen shows loading spinner initially
- ✅ List displays after data loads (if any education exists)
- ✅ Each item shows: School name, Degree, Field of Study
- ✅ Empty state shown if no records exist

**Verification**:
- [ ] Data matches backend database
- [ ] Correct number of items displayed
- [ ] No crashes or errors

---

### Test 2: Create Education (POST)
**Steps**:
1. Tap "+" or "إضافة تعليم" button
2. Fill form:
   - School: "جامعة بغداد"
   - Degree: "بكالوريوس"
   - Field of Study: "هندسة البرمجيات"
   - Start Date: Pick date
   - End Date: Pick date
   - Currently Studying: Leave unchecked
   - Description: "تخصص في تطوير البرمجيات"
3. Tap "إضافة" button

**Expected Result**:
- ✅ Dialog closes
- ✅ Success message: "تم إضافة التعليم بنجاح"
- ✅ New item appears in list
- ✅ Item shows correct data

**Verification**:
- [ ] Check backend database - record exists
- [ ] All fields saved correctly
- [ ] Display order is correct
- [ ] createdAt and updatedAt timestamps set

---

### Test 3: Update Education (PATCH)
**Steps**:
1. Long-press or tap menu on an education item
2. Select "تعديل"
3. Change School name to "جامعة بغداد - الفرع الثاني"
4. Change Degree to "ماجستير"
5. Tap "تحديث"

**Expected Result**:
- ✅ Dialog closes
- ✅ Success message: "تم تحديث التعليم بنجاح"
- ✅ List item updates with new data

**Verification**:
- [ ] Check backend - record updated
- [ ] updatedAt timestamp changed
- [ ] Old data replaced completely
- [ ] No duplicate records

---

### Test 4: Delete Education (DELETE)
**Steps**:
1. Tap menu on an education item
2. Select "حذف"
3. Confirmation dialog appears
4. Tap "حذف" to confirm

**Expected Result**:
- ✅ Item disappears from list
- ✅ Success message: "تم حذف التعليم بنجاح"

**Verification**:
- [ ] Item removed from UI immediately
- [ ] Check backend - record marked as soft deleted (deletedAt set)
- [ ] Item not in list on refresh
- [ ] No duplicate deletions

---

## 🧪 Languages Feature Testing

### Test 5: Load Languages (GET)
**Steps**:
1. Navigate to `/languages`

**Expected Result**:
- ✅ List displays with all languages
- ✅ Shows language name and proficiency level
- ✅ Empty state if no languages

---

### Test 6: Create Language (POST)
**Steps**:
1. Tap "+"
2. Fill:
   - Name: "العربية"
   - Proficiency: Select "طلاقة"
3. Tap "إضافة"

**Expected Result**:
- ✅ Language added to list
- ✅ Success message shown
- ✅ Proficiency displayed correctly

---

### Test 7: Update Language (PATCH)
**Steps**:
1. Tap menu on language
2. Select "تعديل"
3. Change proficiency to "متقدم"
4. Tap "تحديث"

**Expected Result**:
- ✅ Language updated
- ✅ Proficiency level changed in list

---

### Test 8: Delete Language (DELETE)
**Steps**:
1. Tap menu on language
2. Select "حذف"
3. Confirm

**Expected Result**:
- ✅ Language removed from list

---

## 🧪 Projects Feature Testing

### Test 9: Load Projects (GET)
**Steps**:
1. Navigate to `/projects`

**Expected Result**:
- ✅ List shows all projects
- ✅ Each shows: Title, Role, Technologies as chips

---

### Test 10: Create Project (POST)
**Steps**:
1. Tap "+"
2. Fill:
   - Title: "تطبيق JobMap"
   - Role: "Full Stack Developer"
   - Add Technologies:
     - Type "Flutter" → tap "أضف"
     - Type "NestJS" → tap "أضف"
     - Type "PostgreSQL" → tap "أضف"
   - Image URL: "https://..."
   - Start Date: 2024-01-01
   - End Date: leave empty (or pick date)
   - Currently: Check "مشروع حالي"
3. Tap "إضافة"

**Expected Result**:
- ✅ Project added to list
- ✅ Technologies display as chips
- ✅ Success message shown

---

### Test 11: Update Project (PATCH)
**Steps**:
1. Tap menu on project
2. Select "تعديل"
3. Change title and technologies
4. Tap "تحديث"

**Expected Result**:
- ✅ Project updated
- ✅ Technologies refreshed in UI

---

### Test 12: Delete Project (DELETE)
**Steps**:
1. Tap menu on project
2. Select "حذف"
3. Confirm

**Expected Result**:
- ✅ Project removed from list

---

## 🧪 Certificates Feature Testing

### Test 13: Load Certificates (GET)
**Steps**:
1. Navigate to `/certificates`

**Expected Result**:
- ✅ List shows certificates
- ✅ Status badge shown (موثق/مرفوض/قيد الانتظار)

---

### Test 14: Create Certificate (POST)
**Steps**:
1. Tap "+"
2. Fill:
   - Name: "AWS Solutions Architect"
   - Issuer: "Amazon Web Services"
   - Credential ID: "AWS-12345"
   - Credential URL: "https://aws.amazon.com/..."
   - Issue Date: 2024-06-15
   - Doesn't Expire: Check it
   - Expiry Date: (disabled because doesNotExpire checked)
3. Tap "إضافة"

**Expected Result**:
- ✅ Certificate added to list
- ✅ Status badge shown as "قيد الانتظار"
- ✅ Issue date displayed

---

### Test 15: Update Certificate (PATCH)
**Steps**:
1. Tap menu on certificate
2. Select "تعديل"
3. Change issue date or other field
4. Tap "تحديث"

**Expected Result**:
- ✅ Certificate updated

---

### Test 16: Delete Certificate (DELETE)
**Steps**:
1. Tap menu on certificate
2. Select "حذف"
3. Confirm

**Expected Result**:
- ✅ Certificate removed from list

---

## 💾 Test 17: Caching Verification

### Offline Access Test
**Steps**:
1. Load any feature (Education/Languages/Projects/Certificates)
2. Wait for data to load
3. Turn OFF internet/WiFi (airplane mode)
4. Kill the app (remove from recent apps)
5. Reopen app
6. Navigate back to same feature

**Expected Result**:
- ✅ Previous data still visible (cached)
- ✅ No error messages
- ✅ Can view cached data offline

**Verification**:
- [ ] Cache working for all 4 features
- [ ] Cached data is accurate
- [ ] No stale data shown

---

## ⚠️ Test 18: Error Handling

### Network Error Scenario
**Steps**:
1. Enable airplane mode
2. Try to create/update/delete an item
3. Disable airplane mode and retry

**Expected Result**:
- ✅ Error message displayed: "خطأ: [error details]"
- ✅ After enabling internet, operation succeeds on retry

### Server Error Scenario (if backend allows testing)
**Steps**:
1. Stop backend server temporarily
2. Try to load a feature
3. Restart backend

**Expected Result**:
- ✅ Loading spinner shows
- ✅ Error message after timeout: "خطأ: Failed to load..."
- ✅ "إعادة المحاولة" button visible
- ✅ Succeeds after backend restarted

---

## ✅ Test 19: Validation

### Required Fields Validation
**Steps**:
1. Open Add dialog
2. Leave required fields empty
3. Tap "إضافة"

**Expected Result**:
- ✅ Toast/SnackBar: "يرجى ملء جميع الحقول المطلوبة"
- ✅ Dialog stays open
- ✅ No API call made

### Invalid URL Validation (Projects/Certificates)
**Steps**:
1. Fill form with invalid image URL or credential URL
2. Submit

**Expected Result**:
- ✅ Form accepts and submits (URL validation on backend)
- OR ✅ Error message if frontend validates

---

---

## 📊 Task 13: Dark Mode & Responsiveness Testing

### Screen Size Testing

#### Small Screen (4 inches - iPhone SE)
**Test Case**: All screens should be readable and functional
- [ ] Education: List visible, no horizontal scroll
- [ ] Languages: Dropdown selectable on small screen
- [ ] Projects: Technology chips wrap properly
- [ ] Certificates: Status badge fits on small screen
- [ ] Dialogs: Fit within viewport
- [ ] No text overflow

#### Medium Screen (5.5 inches - default)
**Test Case**: Standard testing
- [ ] All screens look good
- [ ] Spacing proportional
- [ ] Buttons clickable

#### Large Screen (6.5 inches - iPhone 14 Pro Max)
**Test Case**: Layout doesn't break
- [ ] Content doesn't stretch too much
- [ ] Padding appropriate
- [ ] List items properly sized

#### Tablet (10 inches)
**Test Case**: Layout adapts gracefully
- [ ] Content centered if needed
- [ ] Proper use of space
- [ ] No single-column limitation if possible

---

### Dark Mode Testing

#### Light Mode
- [ ] All text readable (sufficient contrast)
- [ ] Icons visible
- [ ] Chips/badges colors appropriate
- [ ] Dialogs styled correctly
- [ ] AppBar color appropriate

#### Dark Mode
- [ ] Enable dark mode in system settings
- [ ] All screens adapt:
  - [ ] Education: Text color light, background dark
  - [ ] Languages: Dropdown readable
  - [ ] Projects: Chips visible in dark theme
  - [ ] Certificates: Status badges readable
- [ ] No contrast issues
- [ ] Smooth transition between themes

---

### Rotation Testing

#### Portrait → Landscape
**Steps**:
1. Load feature in portrait
2. Rotate device to landscape
3. Observe layout

**Expected Result**:
- [ ] List adjusts to landscape
- [ ] No data loss
- [ ] Readable and functional

#### Landscape → Portrait
**Steps**:
1. Load in landscape
2. Rotate back to portrait

**Expected Result**:
- [ ] Layout returns to normal
- [ ] No crashes

---

---

## 🏁 Task 14: Sprint 1 Complete Checklist

### Code Quality
- [ ] `flutter analyze` runs without critical errors
  ```bash
  cd /path/to/jobMap
  flutter analyze
  ```
  Expected: 0 critical issues

### Build Verification
- [ ] `flutter build apk --release` succeeds (optional but recommended)
  ```bash
  flutter build apk --release
  ```

### Feature Completeness
- [ ] ✅ Education feature: 100% (10 files + screen)
- [ ] ✅ Languages feature: 100% (10 files + screen)
- [ ] ✅ Projects feature: 100% (10 files + screen)
- [ ] ✅ Certificates feature: 100% (10 files + screen)

### Testing Completion
- [ ] ✅ All CRUD operations tested (Task 12)
- [ ] ✅ Caching verified offline works
- [ ] ✅ Error handling verified
- [ ] ✅ Dark mode tested
- [ ] ✅ Responsiveness tested on multiple screen sizes
- [ ] ✅ Rotation tested

### Architecture Verification
- [ ] Clean Architecture pattern consistent across all 4 features
- [ ] Service Locator registrations correct (28 total)
- [ ] Routes configured properly (4 routes)
- [ ] BLoC pattern used consistently
- [ ] No direct API calls from UI

### No Crashes Verification
- [ ] App starts without crashes
- [ ] All 4 features load without crashes
- [ ] CRUD operations complete without crashes
- [ ] Offline mode works without crashes
- [ ] Rotation doesn't cause crashes

### User Experience
- [ ] Arabic UI text is correct and readable
- [ ] Loading states clear (spinner shown)
- [ ] Error messages helpful and in Arabic
- [ ] Success messages shown after actions
- [ ] Forms are intuitive
- [ ] Date pickers work properly
- [ ] Dropdowns work properly

### Database
- [ ] All records persist to backend
- [ ] Caching works locally
- [ ] Soft delete implemented (records not actually deleted)
- [ ] displayOrder field working
- [ ] timestamps (createdAt, updatedAt) correct

---

## 📝 Test Execution Report Template

Copy this after testing:

```
# Sprint 1 Test Report

## Date: _________
## Tester: _________

### Overall Status: _________ (PASS/FAIL)

### Education Feature
- Load (GET): [ ] PASS [ ] FAIL
- Create (POST): [ ] PASS [ ] FAIL
- Update (PATCH): [ ] PASS [ ] FAIL
- Delete (DELETE): [ ] PASS [ ] FAIL

### Languages Feature
- Load (GET): [ ] PASS [ ] FAIL
- Create (POST): [ ] PASS [ ] FAIL
- Update (PATCH): [ ] PASS [ ] FAIL
- Delete (DELETE): [ ] PASS [ ] FAIL

### Projects Feature
- Load (GET): [ ] PASS [ ] FAIL
- Create (POST): [ ] PASS [ ] FAIL
- Update (PATCH): [ ] PASS [ ] FAIL
- Delete (DELETE): [ ] PASS [ ] FAIL

### Certificates Feature
- Load (GET): [ ] PASS [ ] FAIL
- Create (POST): [ ] PASS [ ] FAIL
- Update (PATCH): [ ] PASS [ ] FAIL
- Delete (DELETE): [ ] PASS [ ] FAIL

### Caching: [ ] PASS [ ] FAIL
### Error Handling: [ ] PASS [ ] FAIL
### Dark Mode: [ ] PASS [ ] FAIL
### Responsiveness: [ ] PASS [ ] FAIL

### Issues Found:
(List any bugs or issues)

### Notes:
(Any additional observations)
```

---

## 🎯 Exit Criteria for Sprint 1

✅ Sprint 1 is complete when:
1. All tests pass (Tasks 12-14)
2. Zero crashes during manual testing
3. All CRUD operations verified
4. Dark mode verified
5. Responsive design verified
6. No lint errors
7. User can complete full career profile workflow

---

## 🚀 Next Steps (Sprint 2)

Once Sprint 1 is complete and all tests pass:
- Build Dashboard (Sprint 2)
- Connect to real user data
- Show profile completion %
- Display recommended jobs

---

**Testing Status**: READY TO EXECUTE
**Confidence Level**: HIGH (90%+)
**Expected Result**: PASS ALL TESTS
