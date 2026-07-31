# Career Profiles Module - Test Design

**Date**: July 31, 2026  
**Status**: Test case design (NO CODE YET)  
**Based On**: CAREER_PROFILES_DISCOVERY_REPORT.md  

---

## Test Coverage Strategy

**Total Planned Tests**: 35-40  
**Categories**: 9 major areas  
**Expected Bugs**: 2-3  
**Focus**: Authorization (high risk), Cascade delete behavior  

---

## Test Categories & Cases

### Category 1: Build & Database (2 tests)

**1.1 - Server running**
- [ ] Health endpoint responds
- [ ] API reachable

**1.2 - Database schema**
- [ ] careerProfiles table exists
- [ ] All 20 columns present with correct types
- [ ] Indexes created (userId, profileStatus, privacyLevel)
- [ ] UNIQUE constraint on userId
- [ ] Soft delete column (isDeleted) exists

---

### Category 2: CRUD Operations (8 tests)

**2.1 - CREATE profile**
- [ ] POST /career-profiles/me with valid data → 201 Created
- [ ] Profile created with correct userId
- [ ] All fields returned in response
- [ ] profileStatus defaults to 'draft'
- [ ] privacyLevel defaults to 'private'
- [ ] isPublic defaults to false

**2.2 - READ by ID**
- [ ] GET /career-profiles/:id → 200 OK
- [ ] Returns correct profile
- [ ] All required fields present

**2.3 - READ current user's profile**
- [ ] GET /career-profiles/me (with JWT) → 200 OK
- [ ] Returns authenticated user's profile
- [ ] Only returns if user is owner

**2.4 - LIST profiles**
- [ ] GET /career-profiles → 200 OK
- [ ] Returns array of profiles
- [ ] Only non-deleted profiles (isDeleted = false)
- [ ] Privacy filtering applied (if private, excluded)

**2.5 - UPDATE profile**
- [ ] PATCH /career-profiles/me with valid data → 200 OK
- [ ] Only specified fields updated
- [ ] Other fields unchanged
- [ ] updatedAt timestamp changed

**2.6 - DELETE profile (soft)**
- [ ] DELETE /career-profiles/me → 200 OK
- [ ] Profile NOT hard deleted (still in DB)
- [ ] isDeleted set to true
- [ ] deletedAt timestamp set
- [ ] Profile no longer appears in LIST

**2.7 - Cascade delete to Applications**
- [ ] Create profile
- [ ] Create application for that profile
- [ ] DELETE profile
- [ ] Application should also be deleted (CASCADE)

**2.8 - Cascade delete to SavedJobs**
- [ ] Create profile
- [ ] Create saved job for that profile
- [ ] DELETE profile
- [ ] Saved job should also be deleted (CASCADE)

---

### Category 3: Input Validation (6 tests)

**3.1 - String length limits**
- [ ] headline: max 160 chars ✓, 161 chars ✗
- [ ] summary: max 2000 chars ✓, 2001 chars ✗
- [ ] professionTitle: max 150 chars
- [ ] location: max 150 chars
- [ ] preferredJobTitles: max 500 chars
- [ ] preferredIndustries: max 500 chars
- [ ] resumeUrl: max 500 chars

**3.2 - Salary range validation**
- [ ] salaryMin: 0 ✓, -1 ✗
- [ ] salaryMax: 0 ✓, -1 ✗
- [ ] ⚠️ **Need to test**: Can salaryMin > salaryMax? (Should be 400 Bad Request)

**3.3 - Currency format**
- [ ] currency: max 10 chars
- [ ] currency: Valid values (USD, EUR, etc.)

**3.4 - Work preference enums**
- [ ] workPreference: Valid values (full-time, part-time, contract, etc.)
- [ ] workPreference: Invalid value → 400 Bad Request

**3.5 - Remote preference enums**
- [ ] remotePreference: Valid values (remote, onsite, hybrid, etc.)
- [ ] remotePreference: Invalid value → 400 Bad Request

**3.6 - Status and privacy enums**
- [ ] profileStatus: Valid (draft, active, inactive, etc.)
- [ ] privacyLevel: Valid (private, public, etc.)
- [ ] Invalid values → 400 Bad Request

---

### Category 4: Authorization (7 tests) **CRITICAL**

**4.1 - Authentication required**
- [ ] POST /career-profiles/me without token → 401 Unauthorized
- [ ] PATCH /career-profiles/me without token → 401 Unauthorized
- [ ] DELETE /career-profiles/me without token → 401 Unauthorized
- [ ] GET /career-profiles without token → 200 OK (public list)
- [ ] GET /career-profiles/:id without token → 200 OK (public access)

**4.2 - Owner can READ own profile**
- [ ] User A's token: GET /career-profiles/me → 200 OK
- [ ] Returns User A's profile

**4.3 - Non-owner cannot READ via /me endpoint**
- [ ] User B's token: GET /career-profiles/me
- [ ] Should return User B's profile, NOT User A's
- [ ] ✅ Routing naturally prevents this (good design)

**4.4 - Owner can UPDATE own profile** ✅
- [ ] User A creates profile
- [ ] User A: PATCH /career-profiles/me → 200 OK
- [ ] Profile updated

**4.5 - Non-owner CANNOT UPDATE** 🔴 [WILL LIKELY FAIL - BUG]
- [ ] User A creates profile
- [ ] User B gets profile ID
- [ ] User B: PATCH /career-profiles/:id with new data
- [ ] Expected: 403 Forbidden (not owner)
- [ ] Actual: Likely 200 OK (authorization bypass) ← **BUG**

**4.6 - Owner can DELETE own profile** ✅
- [ ] User A: DELETE /career-profiles/me → 200 OK
- [ ] Profile soft deleted

**4.7 - Non-owner CANNOT DELETE** 🔴 [WILL LIKELY FAIL - BUG]
- [ ] User A creates profile
- [ ] User B gets profile ID
- [ ] User B: DELETE /career-profiles/:id
- [ ] Expected: 403 Forbidden
- [ ] Actual: Likely 200 OK (authorization bypass) ← **BUG**

---

### Category 5: Privacy & Visibility Control (4 tests)

**5.1 - Private profile visibility**
- [ ] Create profile with privacyLevel: 'private'
- [ ] CREATE: Other users should NOT see in GET /career-profiles
- [ ] Expected: Filtered out from list
- [ ] GET /career-profiles/:id: Should 404 or return empty?

**5.2 - Public profile visibility**
- [ ] Create profile with privacyLevel: 'public'
- [ ] Other users SHOULD see in GET /career-profiles
- [ ] GET /career-profiles/:id: Should return profile

**5.3 - isPublic flag**
- [ ] Create with isPublic: false
- [ ] Should NOT appear in search
- [ ] CREATE with isPublic: true
- [ ] Should appear in search

**5.4 - Combined privacy check**
- [ ] If privacyLevel: 'private' AND isPublic: false
- [ ] Definitely not visible
- [ ] If privacyLevel: 'public' AND isPublic: true
- [ ] Definitely visible
- [ ] Mixed states: Clarify logic

---

### Category 6: Error Handling (3 tests)

**6.1 - Not found errors**
- [ ] GET /career-profiles/:id (non-existent) → 404 Not Found
- [ ] GET /career-profiles/me (no profile created yet) → 404 Not Found
- [ ] PATCH /career-profiles/me (no profile) → 404 Not Found
- [ ] DELETE /career-profiles/me (no profile) → 404 Not Found

**6.2 - Invalid input errors**
- [ ] POST with invalid JSON → 400 Bad Request
- [ ] POST with extra unknown fields → 400 or 200? (Depends on implementation)
- [ ] POST with invalid UUID reference → 400 Bad Request

**6.3 - Conflict errors**
- [ ] POST /career-profiles/me twice by same user → 409 Conflict (userId unique)
- [ ] Error message indicates reason

---

### Category 7: Response Format & Contract (3 tests)

**7.1 - Response fields**
- [ ] All required fields present in response
  - id, userId, headline, summary, professionTitle
  - location, preferredJobTitles, preferredIndustries
  - salaryMin, salaryMax, currency
  - workPreference, remotePreference, relocationPreference
  - profileStatus, privacyLevel, profileCompletion
  - isPublic, resumeUrl
  - createdAt, updatedAt, deletedAt, isDeleted

**7.2 - Response format validation**
- [ ] id: Valid UUID
- [ ] userId: Valid UUID
- [ ] Timestamps: ISO8601 format
- [ ] Numbers: Integer (salary)
- [ ] Booleans: true/false
- [ ] Strings: Correct type
- [ ] Null values: Properly null (not missing)

**7.3 - Consistency across endpoints**
- [ ] List response format matches single-item format
- [ ] Update response has updated fields
- [ ] Delete response shows deleted state

---

### Category 8: Relationships & Referrals (4 tests)

**8.1 - User relationship**
- [ ] Profile has valid userId FK
- [ ] userId links to valid user
- [ ] One profile per user (UNIQUE constraint enforced)

**8.2 - Applications relationship**
- [ ] Applications can reference careerProfileId
- [ ] Applications FK is valid
- [ ] Applications count correct

**8.3 - SavedJobs relationship**
- [ ] SavedJobs can reference careerProfileId
- [ ] SavedJobs FK is valid
- [ ] SavedJobs count correct

**8.4 - Referral trigger**
- [ ] Create profile for new user
- [ ] Check if referral system notified (if applicable)
- [ ] Bonus credited (if configured)

---

### Category 9: Soft Delete & State Management (3 tests)

**9.1 - Soft delete mechanics**
- [ ] DELETE sets isDeleted = true
- [ ] Database query: SELECT * should not include deleted
- [ ] Direct query with WHERE isDeleted IS FALSE: Excludes deleted
- [ ] updatedAt changes on delete

**9.2 - Cascade behavior verification**
- [ ] Delete profile → Check Applications table
  - [ ] If CASCADE: Applications also deleted
  - [ ] If SET NULL: careerProfileId becomes NULL
  - [ ] If RESTRICT: Delete fails (error)
- [ ] Delete profile → Check SavedJobs table
  - [ ] Same cascade behavior verification

**9.3 - Restore functionality**
- [ ] Can deleted profile be restored? (If API supports it)
- [ ] If yes: Test restore endpoint
- [ ] If no: Document as permanent (logical)

---

## Test Data Requirements

**User Accounts**:
- User A (will create profiles)
- User B (will try unauthorized access)
- User C (for multi-user tests)

**Test Profiles**:
- Profile A (owned by User A, private)
- Profile B (owned by User A, public)
- Profile C (owned by User B, private)

**Related Data**:
- Applications (5-10)
- SavedJobs (5-10)

---

## Expected Test Results

### Baseline Expectation

```
WILL PASS (Expected ✅):
  ✅ Build verification
  ✅ Database schema
  ✅ CRUD happy path (create, read, update, delete)
  ✅ GET operations (public endpoints)
  ✅ Validation (string lengths, enums)
  ✅ 404 Not Found errors
  ✅ Response formats
  ✅ Cascade delete (if working correctly)
  ✅ User relationships

WILL LIKELY FAIL (Expected to uncover bugs 🔴):
  🔴 Non-owner UPDATE (should be 403, will be 200)
  🔴 Non-owner DELETE (should be 403, will be 200)
  🔴 Privacy filter enforcement (public/private visibility)
  🔴 Cascade delete verification (need to clarify if working)

UNCERTAIN (Need clarification):
  ❓ Salary range validation (salaryMin > salaryMax)
  ❓ Direct ID access to private profiles (404 or return?)
  ❓ Cascade delete intended behavior
  ❓ Profile creation when already exists (409 or replace?)
```

---

## Test Categories Priority

**Priority 1 - CRITICAL** (Execute first):
- Build & Database
- Authorization (likely has bugs)
- CRUD happy path

**Priority 2 - HIGH** (Execute next):
- Validation
- Error Handling
- Relationships & Cascade delete

**Priority 3 - MEDIUM** (Execute after):
- Privacy & Visibility
- Response format
- Soft delete state

---

## Execution Plan

### Test Session 1 (Priority 1)
- Build & Database (2 tests)
- CRUD Operations (8 tests)
- Authorization (7 tests)
- **Expected**: 2-3 authorization bugs found

### Test Session 2 (Fixes & Priority 2)
- Apply fixes to authorization
- Re-test authorization (should pass)
- Validation (6 tests)
- Relationships (4 tests)
- Cascade delete behavior (3 tests)

### Test Session 3 (Remaining)
- Privacy & Visibility (4 tests)
- Error Handling (3 tests)
- Response Format (3 tests)
- Final verification

**Total Estimated Time**: 6-8 hours spread across 2-3 sessions

---

## Success Criteria

✅ **Career Profiles Module is VERIFIED when:**
- [ ] All 35-40 tests pass (100%)
- [ ] No authorization bypass issues
- [ ] Cascade delete behavior understood & correct
- [ ] Privacy controls enforced
- [ ] No data integrity issues
- [ ] All found bugs documented & fixed

---

**Test Design Status**: COMPLETE  
**Ready for Phase 3**: YES (Test Implementation)  
**Next Step**: Write `career_profiles_test.py` with all test cases above

---

**Date Created**: July 31, 2026  
**Based On**: CAREER_PROFILES_DISCOVERY_REPORT.md  
**Total Test Cases**: 35-40  
**Estimated Execution Time**: ~40-50 minutes (first run)  
**Expected Bugs to Expose**: 2-3 (authorization + cascade clarification)
