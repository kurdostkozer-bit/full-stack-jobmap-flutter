# Career Profiles Module - Discovery Report

**Date**: July 31, 2026  
**Phase**: 0 - Discovery (Architecture Analysis Only)  
**Status**: Complete Analysis  

---

## Executive Summary

The Career Profiles module manages user career information, preferences, and professional data. It's a **user-owned resource** with **soft-delete semantics** and **public/private visibility control**.

**Architecture Quality**: ✅ GOOD  
**Security Model**: ⚠️ NEEDS VERIFICATION (Similar to Companies)  
**Complexity**: MEDIUM  
**Estimated Bugs**: 2-3

---

## Architecture Review

### Ownership Model
```
Career Profile belongs to: User (1:1 relationship)
- userId: UUID (NOT NULL, UNIQUE) 
- One profile per user maximum
- User owns their profile exclusively
```

**Ownership Enforcement**:
- ✅ Controller uses `GET /me` pattern (current user context)
- ✅ Service passes `userId` to repository
- ❓ UPDATE/DELETE operations: Need to verify ownership is checked

### Foreign Keys

| Column | References | Delete Strategy | Status |
|--------|------------|-----------------|--------|
| userId | users.id | (None - not explicit) | Implicit |
| (Related from Applications) | jobs | CASCADE | ✅ Defined |
| (Related from SavedJobs) | jobs | CASCADE | ✅ Defined |

**Incoming FKs**:
- `applications.careerProfileId` → CASCADE delete
- `saved_jobs.careerProfileId` → CASCADE delete

**Implication**: If profile is deleted, all related applications and saved jobs are deleted

---

### Delete Strategy
```
DELETE /career-profiles/me
  → Sets isDeleted = true
  → Sets deletedAt = NOW()
  → Cascades to Applications (DELETE)
  → Cascades to SavedJobs (DELETE)
```

**Type**: SOFT DELETE with CASCADE  
**Issue**: Cascading to related records (Applications, SavedJobs) might not be ideal

---

### Security Model

**Current Implementation**:
- ✅ Authentication: `@UseGuards(JwtAuthGuard)` on POST/PATCH/DELETE
- ✅ Routing: `/me` endpoints for authenticated user's own profile
- ⚠️ Authorization: Need to verify ownership checks in service

**Endpoints**:

| Endpoint | Auth | Ownership Check | Risk |
|----------|------|-----------------|------|
| GET /career-profiles | None | N/A | Low |
| GET /career-profiles/me | JWT | ✅ Current user | Low |
| GET /career-profiles/:id | None | N/A | Low |
| POST /career-profiles/me | JWT | ✅ Current user | Low |
| PATCH /career-profiles/me | JWT | ⚠️ NEEDS CHECK | Medium |
| DELETE /career-profiles/me | JWT | ⚠️ NEEDS CHECK | Medium |

**Problem Identified** (Same as Companies):
- PATCH and DELETE use `findByUserId()` first
- But if ownership check is missing in UPDATE method, could be vulnerability
- Need to verify `careerProfilesService.update()` checks ownership

---

### Data Visibility & Privacy

**Privacy Levels**: 
- `private` (default) - Not visible to public
- Other values (public, etc.) - May be visible

**Public Flag**:
- `isPublic: boolean` - Controls search visibility
- **Concern**: How is this enforced in LIST queries?

**Question**: Are private profiles filtered in GET /career-profiles list?

---

## Database Schema Analysis

### Columns (20 total)

| Column | Type | Nullable | Default | Notes |
|--------|------|----------|---------|-------|
| id | UUID | No | Random | Primary Key |
| userId | UUID | No | - | UNIQUE - One profile per user |
| headline | Text | Yes | NULL | Professional headline |
| summary | Text | Yes | NULL | Professional summary |
| professionTitle | Text | Yes | NULL | Current/target title |
| location | Text | Yes | NULL | Geographic location |
| preferredJobTitles | Text | Yes | NULL | Target job titles |
| preferredIndustries | Text | Yes | NULL | Target industries |
| salaryMin | Integer | Yes | NULL | Min salary expectation |
| salaryMax | Integer | Yes | NULL | Max salary expectation |
| currency | Text | No | USD | Salary currency |
| workPreference | Text | No | any | Work type (full-time, part-time, etc.) |
| remotePreference | Text | No | hybrid | Remote preference |
| relocationPreference | Text | No | open | Willing to relocate |
| profileStatus | Text | No | draft | draft, active, inactive |
| privacyLevel | Text | No | private | private, public, etc. |
| profileCompletion | Integer | No | 0 | Completion percentage (0-100) |
| isPublic | Boolean | No | false | Searchable/visible |
| isDeleted | Boolean | No | false | Soft delete flag |
| deletedAt | Timestamp | Yes | NULL | When deleted |
| createdAt | Timestamp | No | NOW | Created timestamp |
| updatedAt | Timestamp | No | NOW | Updated timestamp |

### Indexes (3)
- `career_profiles_user_id_idx` on userId
- `career_profiles_status_idx` on profileStatus
- `career_profiles_privacy_idx` on privacyLevel

**Analysis**: Good indexing on frequently queried columns

---

## CRUD Operations

### CREATE
```
POST /career-profiles/me
  Body: CreateCareerProfileDto (all optional)
  Returns: CareerProfileResponseDto
  Auth: JWT required
```

**What Happens**:
1. Controller receives JWT user ID
2. Service calls `create(userId, dto)`
3. Repository inserts new record with userId
4. Referral system triggered (for referral bonuses)

**Validation**: String lengths, integer minimums checked via DTO validators

### READ
```
GET /career-profiles                 # List all public
GET /career-profiles/:id             # Get specific profile
GET /career-profiles/me              # Get current user's profile (JWT required)
```

**Query Filtering**:
- profileStatus
- privacyLevel
- userId
- isDeleted filter (always)

### UPDATE
```
PATCH /career-profiles/me
  Body: UpdateCareerProfileDto (partial)
  Returns: CareerProfileResponseDto
  Auth: JWT required
```

**Current Flow**:
1. Find profile by userId (`findByUserId()`)
2. If not found → 404
3. Call `update(profile.id, dto)` 
4. ⚠️ **ISSUE**: Service doesn't re-verify ownership!

### DELETE
```
DELETE /career-profiles/me
  Returns: CareerProfileResponseDto
  Auth: JWT required
```

**Delete Behavior**:
1. Find profile by userId
2. Set `isDeleted = true`
3. Set `deletedAt = NOW()`
4. **Cascades**: Deletes Applications and SavedJobs

---

## Relationships

### One-to-One: User ↔ CareerProfile
- Profile.userId → User.id
- One profile per user (UNIQUE constraint)
- User deletion likely cascades to profile

### One-to-Many: CareerProfile ← Applications
- Applications.careerProfileId → CareerProfile.id
- DELETE profile → CASCADE delete applications
- ⚠️ **Impact**: User loses all their job applications when profile deleted!

### One-to-Many: CareerProfile ← SavedJobs
- SavedJobs.careerProfileId → CareerProfile.id
- DELETE profile → CASCADE delete saved jobs
- ⚠️ **Impact**: User loses all saved jobs when profile deleted!

---

## Potential Issues Found (During Discovery)

### Issue #1: Cascade Delete Side Effects ⚠️
**Severity**: MEDIUM  
**Description**: Deleting a career profile cascades to delete:
- All applications (job applications disappear)
- All saved jobs (bookmarks disappear)

**Question**: Is this intentional?
- Option A: Keep as-is (clean slate)
- Option B: Use SET NULL (keep applications orphaned)
- Option C: Use RESTRICT (prevent deletion if has applications)

**Recommendation**: Test to understand intended behavior

---

### Issue #2: Authorization Bypass Risk (Like Companies) ⚠️
**Severity**: HIGH (if present)  
**Description**: Similar to Companies module, UPDATE might allow:
- User B to update User A's profile
- User B to delete User A's profile

**Reason**: Service.update() doesn't verify ownership before updating

**Code Location**: `careerProfilesService.update(id, dto)`
- Takes profile ID (not userId)
- No ownership verification visible
- Could allow cross-user updates

**Mitigation**: Need to add ownership check like in Companies fix

---

### Issue #3: Privacy Control Enforcement ❓
**Severity**: LOW-MEDIUM  
**Description**: Fields like `isPublic` and `privacyLevel` control visibility:
- `isPublic: false` → Should not appear in search
- `privacyLevel: private` → Should not be listed

**Question**: Is this enforced in queries?
- findAll() filters by privacyLevel
- But does LIST endpoint apply both privacy AND isPublic checks?

**Risk**: Private profiles might be visible via direct ID access

---

### Issue #4: No Unique Constraint on Salary Range ❓
**Severity**: LOW  
**Description**: salaryMin and salaryMax are independent integers
- Could have salaryMin > salaryMax
- No validation in DTO

**Validation Missing**: Should check salaryMin <= salaryMax

---

## Related Modules

### Depends On:
- ✅ **Auth Module** - JWT authentication
- ✅ **Users Module** - User ID references
- ✅ **Referrals Service** - Triggered on profile creation

### Depended On By:
- **Applications Module** - careerProfileId foreign key (CASCADE)
- **SavedJobs Module** - careerProfileId foreign key (CASCADE)
- **Search Module** - Query/filter career profiles
- **Recruiters Module** - May view career profiles

---

## Test Design Implications

### High-Risk Areas (Priority Testing)
1. **Authorization**: Verify only owner can UPDATE/DELETE
2. **Cascade Delete**: Confirm behavior with Applications and SavedJobs
3. **Privacy Control**: Ensure private profiles not visible
4. **Salary Validation**: Check min ≤ max

### Straightforward Areas
1. **CRUD Happy Path**: Standard create, read, update, delete
2. **Validation**: DTO validators work correctly
3. **404 Handling**: Non-existent profiles return 404
4. **Response Format**: All fields returned correctly

---

## Ownership Model Verification Checklist

### Ownership Tracking
- [x] userId stored in profile (1:1 relationship)
- [x] userId is UNIQUE (one profile per user)
- [x] Controller routes use req.user.id context

### Ownership Enforcement
- [x] GET /me uses findByUserId(userId)
- [x] POST /me uses userId from JWT
- [ ] ⚠️ PATCH /me: Need to verify ownership check in service.update()
- [ ] ⚠️ DELETE /me: Need to verify ownership check in service.remove()

### Cascade Handling
- [ ] Need to test: Do applications delete when profile deleted?
- [ ] Need to test: Do saved jobs delete when profile deleted?
- [ ] Need to document: Is this intentional?

---

## Next Steps: Test Design Phase

Based on this discovery, testing should cover:

### Test Categories (Planned)
1. **Build & Database** (2 tests)
2. **CRUD Operations** (8-10 tests)
3. **Validation** (5-7 tests) - Including salary range
4. **Authorization** (5-7 tests) - **CRITICAL** - Expect to find bugs
5. **Privacy Control** (3-5 tests)
6. **Error Handling** (2-3 tests)
7. **Response Format** (2-3 tests)
8. **Relationships** (3-5 tests) - Applications & SavedJobs cascade
9. **Soft Delete Behavior** (2-3 tests)

**Total Estimated Tests**: 30-40

### Expected Test Results
- **PASS**: ~28 tests (happy path, validation)
- **FAIL**: ~2-3 tests (authorization bypass, cascade delete questions)
- **Fix Required**: 1-2 bugs (probably authorization-related)

---

## Security Assessment

| Area | Status | Risk |
|------|--------|------|
| Authentication | ✅ JWT Guard present | Low |
| Authorization | ⚠️ Likely has bypass | Medium-High |
| Input Validation | ✅ DTOs with validators | Low |
| SQL Injection | ✅ Drizzle ORM | Low |
| Data Exposure | ⚠️ Privacy controls unclear | Low-Medium |
| Cascade Delete | ⚠️ Side effects unclear | Low-Medium |

**Overall Risk**: MEDIUM (Same as Companies before fix)

---

## Files to Review in Test Phase

```
Service Layer:        careerProfilesService.update()
                     careerProfilesService.remove()
                     
Repository Layer:     careerProfilesRepository.update()
                     careerProfilesRepository.remove()
                     
Controller Layer:     All endpoints for guard presence
                     Authorization implicit in routing
                     
Database:            careerProfiles table structure
                     Cascade delete definitions
```

---

## Architecture Insights

### What's Good ✅
- Clean separation of concerns (Controller → Service → Repository)
- Soft delete with timestamps
- Proper pagination/filtering
- DTO validation in place
- Uses 1:1 userId relationship (good ownership model)

### What Needs Attention ⚠️
- Authorization checks not visible in service (likely bug)
- Cascade delete behavior needs documentation
- Privacy controls need verification
- Salary range validation missing

### What's Risky ❌
- No explicit authorization check visible before UPDATE/DELETE
- Cascading deletes may surprise users (lose applications)

---

## Conclusion

**Career Profiles Module Status**: READY FOR TEST DESIGN

**Architecture Quality**: ✅ GOOD overall structure  
**Security Posture**: ⚠️ Medium risk (likely similar authorization issue as Companies)  
**Expected Bugs**: 2-3 (authorization bypass + cascade behavior questions)  
**Readiness**: Ready to proceed to Test Design phase

**Next Action**: Create comprehensive test case list (~35-40 tests)

---

**Discovery Complete**: July 31, 2026, ~40 minutes analysis  
**Files Analyzed**: 6 (Controller, Service, Repository, DTOs, Schema, Module)  
**Issues Found**: 4 (1 HIGH, 1-2 MEDIUM, 1-2 LOW)  
**Risk Level**: MEDIUM (Manageable, similar to Companies)
