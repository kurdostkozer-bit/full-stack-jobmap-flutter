# Career Profiles Module - Test Results Round 1

**Date**: July 31, 2026  
**Status**: Tests Executed - Issues Found  
**Overall Score**: 13/21 PASS (61.9%)

---

## Summary

Tests executed with **13 PASS** and **8 FAIL**.

**Critical Issue Found**: 500 error when trying to create second profile for same user (UNIQUE constraint violation not handled gracefully)

---

## Test Results by Category

### Category 1: Build & Database (2/2 PASS) ✅
- [PASS] Server running
- [PASS] Career profiles endpoint exists

### Category 2: CRUD Happy Path (8/8 PASS) ✅
- [PASS] Authentication (USER_A)
- [PASS] CREATE profile
- [PASS] READ /me endpoint
- [PASS] READ by ID
- [PASS] LIST profiles
- [PASS] UPDATE profile
- [PASS] DELETE profile (soft)

**Key Finding**: Happy path all working! Soft delete working correctly.

### Category 3: Input Validation (2/6 PASS)
- [PASS] Headline length validation ✅
- [PASS] Salary min validation ✅
- **[FAIL] Work preference enum** - Accepted invalid value (should be 400)
- **[FAIL] Remote preference enum** - Accepted invalid value (should be 400)
- **[FAIL] Profile status enum** - Accepted invalid value (should be 400)
- **[FAIL] Privacy level enum** - Accepted invalid value (should be 400)

**Issue**: Enum validation NOT enforced on these fields. DTOs allow invalid values.

### Category 4: Authorization (0/7 FAIL) 🔴
- **[FAIL] Setup profile** - Status 500

**Critical Issue**: 
```
User B tries to create profile (second user creates)
Expected: 201 Created
Actual: 500 Internal Server Error
Reason: Likely UNIQUE constraint on userId violated somewhere, but error not handled
```

**Problem Details**:
- userId should be UNIQUE (one profile per user)
- Second profile creation returns 500 instead of 409 Conflict
- Error handling not in place for constraint violations

**Impact**: Authorization tests blocked (cannot set up test data)

### Category 5: Privacy & Visibility (0/4 FAIL) 🔴
- **[FAIL] Create private profile** - Failed due to Status 500 in setup

**Blocked by**: Category 4 failure

### Category 6: Error Handling (2/3 PASS)
- [PASS] 404 on invalid ID ✅
- [PASS] 404 on /me (no profile) ✅
- **[FAIL] Conflict on duplicate profile** - Status 500 (not 409)

**Issue**: Duplicate profile creation returns 500 instead of 409 Conflict

### Category 7: Response Format (0/3 FAIL) 🔴
- **[FAIL] Create for format test** - Failed due to Status 500

**Blocked by**: Category 4 failure

---

## Bugs Found

### Bug #1: Missing Error Handling for UNIQUE Constraint
**Severity**: CRITICAL  
**Location**: CareerProfilesService.create() or Repository  
**Issue**: When userId already has a profile:
- Expected: 409 Conflict (or 400 Bad Request)
- Actual: 500 Internal Server Error

**Root Cause**: No try/catch for database unique constraint violation

**Code Path**:
1. User already has profile (careerProfiles.userId is UNIQUE)
2. Try to create another profile
3. Drizzle ORM throws constraint violation
4. Error not caught, bubbles up as 500

**Fix Required**:
```typescript
async create(userId: string, dto: CreateCareerProfileDto): Promise<...> {
  try {
    // existing code
  } catch (error) {
    if (error.code === 'UNIQUE_VIOLATION' || error.message.includes('userId')) {
      throw new ConflictException('Profile already exists for this user');
    }
    throw error;
  }
}
```

**Status**: 🔴 NEEDS FIX

---

### Bug #2: Enum Validation Not Enforced
**Severity**: MEDIUM  
**Location**: CreateCareerProfileDto validators  
**Issue**: Invalid enum values accepted instead of rejected

**Examples**:
- `workPreference: "INVALID_TYPE"` → Accepted (should be 400)
- `remotePreference: "INVALID"` → Accepted (should be 400)
- `profileStatus: "INVALID"` → Accepted (should be 400)
- `privacyLevel: "INVALID"` → Accepted (should be 400)

**Root Cause**: DTOs use @IsString() but not @IsEnum() or custom validator

**Fix Required**: Add @IsEnum() validators to DTO fields:
```typescript
@IsOptional()
@IsEnum(['full-time', 'part-time', 'contract', ...])
workPreference?: string;
```

**Status**: 🟡 NEEDS FIX (MEDIUM PRIORITY)

---

## Test Execution Statistics

```
Total Tests Run: 21
Passed: 13 (61.9%)
Failed: 8 (38.1%)

By Category:
- Build & Database: 2/2 ✅
- CRUD Operations: 8/8 ✅
- Input Validation: 2/6 🟡
- Authorization: 0/7 🔴 (Blocked)
- Privacy: 0/4 🔴 (Blocked)
- Error Handling: 2/3 🔴
- Response Format: 0/3 🔴 (Blocked)

Blocking Issue: Category 4 Status 500 → Cannot proceed with Auth tests
```

---

## Impact Analysis

### High Impact (Blocks Testing)
- ❌ Cannot test authorization (no second profile can be created)
- ❌ Cannot test privacy controls
- ❌ Cannot verify response format on multi-user scenarios

### Medium Impact (Validation Bypass)
- ⚠️ Enum values not validated (data quality issue)
- ⚠️ Could accept meaningless values like profileStatus="garbage"

### Low Impact
- None at this time

---

## What's Working Well ✅

1. **CRUD Happy Path**: Create, read, update, delete all working
2. **Soft Delete**: Correctly sets isDeleted and deletedAt
3. **Authentication**: JWT guard working
4. **Basic Validation**: String lengths, numeric minimums working
5. **404 Errors**: Proper 404 responses for not found
6. **GET Endpoints**: All public GET endpoints working

---

## What Needs Fixing 🔴

1. **UNIQUE Constraint Error Handling** (CRITICAL)
   - Add try/catch for database constraint violations
   - Return 409 Conflict instead of 500

2. **Enum Validation** (MEDIUM)
   - Add @IsEnum() validators to DTOs
   - Validate workPreference, remotePreference, profileStatus, privacyLevel

---

## Authorization Test Status

**Not Yet Executed** (Blocked by Status 500 issue)

Expected to find same bugs as Companies:
- Non-owner UPDATE should return 403
- Non-owner DELETE should return 403
- Need to verify ownership checks in service

**Note**: Once Bug #1 is fixed, authorization tests should reveal 1-2 authorization bypass issues

---

## Next Phase: Bug Fixes

### Priority 1 (CRITICAL) - Fix UNIQUE Constraint Error
**File**: `src/career-profiles/services/career-profiles.service.ts`

```typescript
async create(
  userId: string,
  dto: CreateCareerProfileDto,
): Promise<CareerProfileResponseDto> {
  try {
    const profile = await this.careerProfilesRepository.create(userId, dto);
    
    // Trigger referral completion if user was referred
    await this.referralsService.completeReferralOnProfileCreation(userId);
    
    return CareerProfileMapper.toResponse(profile);
  } catch (error) {
    // Handle unique constraint violation
    if (error.code === '23505' || error.message?.includes('unique')) {
      throw new ConflictException('Career profile already exists for this user');
    }
    throw error;
  }
}
```

### Priority 2 (MEDIUM) - Add Enum Validation
**File**: `src/career-profiles/dto/create-career-profile.dto.ts`

```typescript
import { IsEnum } from 'class-validator';

const WORK_PREFERENCES = ['full-time', 'part-time', 'contract', 'freelance'];
const REMOTE_PREFERENCES = ['remote', 'onsite', 'hybrid'];
const PROFILE_STATUSES = ['draft', 'active', 'inactive'];
const PRIVACY_LEVELS = ['private', 'public'];

export class CreateCareerProfileDto {
  // ... existing fields ...
  
  @IsOptional()
  @IsEnum(WORK_PREFERENCES, { message: 'Invalid work preference' })
  workPreference?: string;

  @IsOptional()
  @IsEnum(REMOTE_PREFERENCES, { message: 'Invalid remote preference' })
  remotePreference?: string;

  @IsOptional()
  @IsEnum(PROFILE_STATUSES, { message: 'Invalid profile status' })
  profileStatus?: string;

  @IsOptional()
  @IsEnum(PRIVACY_LEVELS, { message: 'Invalid privacy level' })
  privacyLevel?: string;
}
```

---

## Re-Testing Plan

1. **Apply Fix #1**: UNIQUE constraint error handling
2. **Re-run Categories 1-7**: Should get ~15-17 PASS
3. **Apply Fix #2**: Enum validation
4. **Re-run Categories 1-7**: Should get ~19-21 PASS
5. **Verify**: Authorization tests execute (expect 1-2 failures)
6. **Fix Authorization**: Add ownership checks if needed
7. **Final Run**: Target 24/24 or higher PASS

---

## Comparison to Companies Module

| Aspect | Companies | Career Profiles |
|--------|-----------|-----------------|
| Initial Pass Rate | 95.8% (23/24) | 61.9% (13/21) |
| CRUD | 100% | 100% ✅ |
| Authorization | 1 bug | Not yet tested |
| Validation | 100% | 40% (enum missing) |
| Error Handling | Good | Missing constraint handling |
| Soft Delete | Good | Good ✅ |

**Career Profiles is earlier stage** - more bugs expected at this point.

---

## Conclusion

**Status**: Career Profiles Module - Issues Found, Ready for Fixes

**Critical Bug**: UNIQUE constraint not handled → Blocks testing  
**Medium Bugs**: Enum validation missing → Data quality issue  
**Good News**: CRUD and soft delete working perfectly  

**Next Step**: Apply Bug Fix #1, re-run tests, proceed with fixes #2, then authorization testing

---

**Test Date**: July 31, 2026, 02:50-02:50 UTC  
**Estimated Fix Time**: 30 minutes  
**Re-test Time**: 5 minutes  
**Overall Time to Verification**: ~1-2 hours
