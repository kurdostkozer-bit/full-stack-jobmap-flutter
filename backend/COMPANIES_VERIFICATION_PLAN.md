# Companies Module - Verification Plan

**Module**: Companies (Core Dependency)  
**Priority**: 🔴 Critical (many modules depend on it)  
**Estimated Time**: 8-10 hours  
**Start Date**: Ready to begin  
**Status**: ⏳ Pending - Awaiting execution

---

## Overview

Companies Module handles:
- Company CRUD operations
- Company-Recruiter relationships
- Company-Job relationships
- Authorization (who can manage which company)
- Cascade delete behavior (what happens when company deleted)

This module is **highly interdependent** - deleting a company affects Jobs, Recruiters, Applications, and more.

---

## Critical Focus Areas

### 1. Relationships & Foreign Keys

**Current Schema Understanding**:
- Companies table has `id`, `name`, `slug`, `description`, etc.
- Recruiters reference companies (likely via `company_id` FK)
- Jobs reference companies (via `company_id` FK)
- Applications reference companies (via job → company)

**Tests Required**:
- [ ] Company exists before creating Recruiter
- [ ] Company exists before creating Job
- [ ] Invalid company_id on Recruiter creation → 400/404
- [ ] Invalid company_id on Job creation → 400/404
- [ ] Recruiter shows company details in response
- [ ] Job shows company details in response

### 2. Delete Cascade Behavior

**Critical Question**: What should happen when a Company is deleted?

**Possible Behaviors**:
1. **RESTRICT** - Don't allow deletion if has Recruiters/Jobs
   ```
   DELETE company
   IF (has recruiters OR has jobs) → ERROR
   ```

2. **CASCADE** - Delete everything
   ```
   DELETE company
   → DELETE all recruiters
   → DELETE all jobs
   → DELETE all applications
   → DELETE all saved jobs
   ```

3. **SET NULL** - Keep data but orphan it
   ```
   DELETE company
   → SET recruiters.company_id = NULL
   → SET jobs.company_id = NULL
   ```

**Tests Required**:
- [ ] Attempt to delete company with recruiters
- [ ] Attempt to delete company with jobs
- [ ] Verify actual behavior (error OR cascade OR NULL)
- [ ] If CASCADE: verify recruiter/job data is actually deleted
- [ ] If RESTRICT: verify error message is clear
- [ ] If SET NULL: verify data integrity is maintained

### 3. Authorization & Ownership

**Questions**:
- Who can create a Company?
- Who can update a Company?
- Who can delete a Company?
- Can Recruiter A modify Company created by Recruiter B?
- What's the admin override behavior?

**Tests Required**:
- [ ] Only authorized users can create Company
- [ ] Creator can modify own Company
- [ ] Creator cannot modify others' Companies
- [ ] Admin can modify any Company
- [ ] Unauthenticated user gets 401
- [ ] Unauthorized user gets 403
- [ ] Proper error messages

### 4. Integration Scenarios

**Test Chains** (simulate real workflows):

#### Scenario A: Full Company Lifecycle
```
1. Create Company
2. Create Recruiter for Company
3. Create Job for Recruiter
4. Verify Job shows Company details
5. Update Company name
6. Verify Job reflects new Company name
7. Delete Company
8. Verify what happens to Job (error/cascade/NULL)
```

#### Scenario B: Multiple Recruiters Per Company
```
1. Create Company
2. Create Recruiter A for Company
3. Create Recruiter B for Company
4. Create Job by Recruiter A
5. Create Job by Recruiter B
6. Verify both jobs show same Company
7. Delete Company
8. Verify both jobs handled correctly
```

#### Scenario C: Permission Isolation
```
1. Recruiter A creates Company 1
2. Recruiter B creates Company 2
3. Recruiter A tries to modify Company 2 → 403
4. Admin modifies Company 2 → 200
5. Verify no data leakage between companies
```

---

## Verification Checklist

### 1. Build ✅/❌
- [ ] npm run build: 0 errors
- [ ] TypeScript strict: 0 errors
- [ ] All imports resolve
- [ ] Controllers load

### 2. Database ✅/❌
- [ ] `companies` table exists
- [ ] All columns present (id, name, slug, description, etc.)
- [ ] Foreign keys to users table (created_by, updated_by)
- [ ] Indexes created properly
- [ ] Schema matches DTOs

### 3. Happy Path ✅/❌

#### Create Company
- [ ] POST /api/v1/companies with valid data → 201
- [ ] Company created with correct data
- [ ] Company ID generated (UUID)
- [ ] Timestamps set (createdAt, updatedAt)
- [ ] Response includes created_by user
- [ ] Slug is unique

#### Read Company
- [ ] GET /api/v1/companies/:id → 200
- [ ] All fields returned
- [ ] created_by user details included
- [ ] Recruiter count included (if available)
- [ ] Job count included (if available)

#### Update Company
- [ ] PATCH /api/v1/companies/:id → 200
- [ ] Only specified fields updated
- [ ] updated_by is set correctly
- [ ] Other fields unchanged
- [ ] Cannot update read-only fields

#### Delete Company
- [ ] DELETE /api/v1/companies/:id → 200
- [ ] Company deleted (or marked deleted)
- [ ] Verify cascade/restrict/null behavior

#### List Companies
- [ ] GET /api/v1/companies → 200
- [ ] Returns array of companies
- [ ] Can filter by status
- [ ] Can filter by verification status

### 4. Validation ✅/❌
- [ ] Empty name → 400
- [ ] Empty slug → 400
- [ ] Invalid slug format → 400
- [ ] Duplicate slug → 409
- [ ] Email format validation (if present)
- [ ] Phone format validation (if present)
- [ ] URL format validation (website)
- [ ] Founded year must be reasonable (1800-2026)
- [ ] Missing required fields → 400
- [ ] Invalid enum values (status, verification_status) → 400

### 5. Authorization ✅/❌
- [ ] Create without auth → 401
- [ ] Create with auth → 201
- [ ] Update own company → 200
- [ ] Update others' company → 403
- [ ] Delete own company → 200
- [ ] Delete others' company → 403
- [ ] Admin can update any company → 200
- [ ] Admin can delete any company → 200
- [ ] Non-admin cannot see others' drafts

### 6. Error Handling ✅/❌
- [ ] Non-existent company → 404
- [ ] Invalid UUID → 400/404
- [ ] Duplicate slug → 409 Conflict
- [ ] Missing required fields → 400
- [ ] Cannot delete company with recruiter → Error (verify specific code)
- [ ] Invalid enum value → 400
- [ ] Malformed JSON → 400
- [ ] Authorization errors → 401/403

### 7. Response Contract ✅/❌

**Company Response Format**:
```json
{
  "id": "uuid",
  "name": "string",
  "slug": "string",
  "logo": "url or null",
  "coverImage": "url or null",
  "description": "string or null",
  "industry": "string or null",
  "companySize": "STARTUP|SMALL|MEDIUM|LARGE|ENTERPRISE or null",
  "foundedYear": "number or null",
  "website": "url or null",
  "email": "email or null",
  "phone": "string or null",
  "country": "string or null",
  "city": "string or null",
  "address": "string or null",
  "verificationStatus": "UNVERIFIED|PENDING|VERIFIED|REJECTED",
  "status": "ACTIVE|INACTIVE|SUSPENDED",
  "createdBy": {
    "id": "uuid",
    "email": "string"
  },
  "updatedBy": {
    "id": "uuid",
    "email": "string"
  },
  "recruitersCount": "number or null",
  "jobsCount": "number or null",
  "createdAt": "ISO8601",
  "updatedAt": "ISO8601",
  "deletedAt": "ISO8601 or null"
}
```

- [ ] All fields present (or explicitly documented as optional)
- [ ] Field types correct
- [ ] No extra fields
- [ ] Dates in ISO8601 format
- [ ] Nested objects properly structured
- [ ] No null values where shouldn't be
- [ ] Consistent format across list/detail responses

### 8. Logs ✅/❌
- [ ] Company creation logged
- [ ] Company updates logged
- [ ] Company deletion logged
- [ ] Failed operations logged
- [ ] User actions traceable
- [ ] No sensitive data logged (passwords, secrets)
- [ ] Proper log levels (INFO, WARN, ERROR)

### 9. Performance ✅/❌
- [ ] Create Company < 200ms
- [ ] Get Company < 100ms
- [ ] List (10 items) < 200ms
- [ ] Update Company < 200ms
- [ ] Delete Company < 200ms
- [ ] Filter Companies < 500ms
- [ ] No N+1 queries
- [ ] Database indexes used

### 10. Documentation ✅/❌
- [ ] Endpoint paths documented
- [ ] HTTP methods documented
- [ ] Request/response examples provided
- [ ] Error codes explained
- [ ] Authorization requirements documented
- [ ] Required vs optional fields clear
- [ ] Enum values documented
- [ ] Relationships explained

### 11. Integration ✅/❌

#### Auth Integration
- [ ] Company creation requires authenticated user
- [ ] created_by/updated_by set from authenticated user
- [ ] User cannot see companies they don't have access to
- [ ] Tokens properly validated

#### Jobs Integration
- [ ] Job creation requires valid company_id
- [ ] Job.company returns Company details
- [ ] Deleting Company handles Jobs correctly
- [ ] Job count accurate

#### Recruiters Integration
- [ ] Recruiter creation requires valid company_id
- [ ] Recruiter.company returns Company details
- [ ] Deleting Company handles Recruiters correctly
- [ ] Recruiter count accurate

#### Cascade Delete Verification
- [ ] If Company deleted:
  - [ ] All Recruiters deleted OR error
  - [ ] All Jobs deleted OR error
  - [ ] All Applications deleted OR error
  - [ ] All Saved Jobs deleted OR error
  - [ ] All Notifications deleted OR error
- [ ] No orphaned records left in database
- [ ] Transaction consistency maintained

---

## Critical Test Scenarios

### Scenario 1: Company Deletion with Dependencies
```
1. Create Company
2. Create Recruiter (ties to Company)
3. Create Job (ties to Company)
4. Delete Company
   → Expected: Either error (RESTRICT) or cascade cleanup
   → Verify: No orphaned Recruiters/Jobs
```

### Scenario 2: Authorization Isolation
```
1. User A creates Company A
2. User B creates Company B
3. User A tries to update Company B
   → Expected: 403 Forbidden
4. Admin tries to update Company B
   → Expected: 200 OK
```

### Scenario 3: Slug Uniqueness
```
1. Create Company with slug "tech-startup"
2. Create another Company with same slug
   → Expected: 409 Conflict
3. Update Company with slug that conflicts
   → Expected: 409 Conflict
```

### Scenario 4: Enum Validation
```
1. Create Company with status="ACTIVE" → 201
2. Create Company with status="INVALID" → 400
3. Update Company with verification_status="VERIFIED" → 200
4. Update Company with verification_status="INVALID" → 400
```

---

## Test Execution Plan

### Phase 1: Basic Functionality (2 hours)
1. Build verification
2. Database schema check
3. Happy path (CRUD)
4. Response contract validation

### Phase 2: Validation & Authorization (2 hours)
1. Input validation
2. Authorization checks
3. Ownership verification
4. Role-based access

### Phase 3: Relationships & Cascade (2 hours)
1. Foreign key relationships
2. Cascade delete behavior
3. Orphaned record check
4. Transaction integrity

### Phase 4: Integration Tests (2 hours)
1. Auth integration
2. Jobs integration
3. Recruiters integration
4. Multi-step workflows

### Phase 5: Edge Cases & Performance (2 hours)
1. Edge cases (special characters, very long strings)
2. Performance measurements
3. Database integrity
4. Final sign-off

---

## Success Criteria

✅ **Module is VERIFIED when:**
- [ ] All 11 categories completed
- [ ] Build: 0 errors
- [ ] Database: schema verified, relationships intact
- [ ] Happy Path: 5/5 (CRUD)
- [ ] Validation: 100% coverage (9+ scenarios)
- [ ] Authorization: All roles tested
- [ ] Error Handling: All error codes correct
- [ ] Response Contract: Consistent format
- [ ] Database Integrity: Cascade behavior tested
- [ ] Performance: All ops within targets
- [ ] Integration: Works with Auth, Jobs, Recruiters
- [ ] No data corruption on delete operations
- [ ] Test suite passes 100% on re-run

---

## Files to Create/Modify

### Create:
- `backend/tests/companies_test.py` - Comprehensive test suite (25+ tests)
- `backend/COMPANIES_VERIFICATION_COMPLETED.md` - Results documentation
- `backend/COMPANIES_INTEGRATION_TESTS.md` - Integration test scenarios

### Modify (if needed):
- `backend/src/companies/controllers/companies.controller.ts` - Add guards if missing
- `backend/src/companies/services/companies.service.ts` - Add auth checks
- `backend/src/database/schema/companies.schema.ts` - Verify cascade rules
- `backend/src/companies/repositories/companies.repository.ts` - Verify relationships

---

## Known Risks

1. **Cascade Delete**: If Company delete cascades to Jobs → cascades to Applications, this could delete a lot of data. Must verify this is intentional and documented.

2. **Recruiter Orphaning**: If Recruiter has company_id FK and company is deleted, what happens? RESTRICT (can't delete) or CASCADE (orphan recruiter)?

3. **Authorization Complexity**: Companies might have multiple creators/owners. Verify the permission model is clear.

4. **Slug Conflicts**: Slug might be global (unique across all companies) or per-account. Verify behavior.

---

## Verification Sequence

After Companies is VERIFIED:

1. **Career Profiles** → Similar verification
2. **Integration Testing Phase** (Auth + Jobs + Companies + Career Profiles)
3. **Remaining 8 modules** in dependency order

---

## Notes

**Important**: Unlike Jobs, Companies is likely to have more complex relationships. The cascade delete test is **critical** - this is where real bugs hide. A Company deletion should not silently orphan 100+ Jobs. This must be tested, not assumed.

**Recommended Approach**:
1. Run test that creates Company → Recruiters → Jobs
2. Delete Company
3. Check database directly: are there orphaned jobs? Orphaned recruiters?
4. If yes → we found a data integrity bug
5. If no → cascade worked as designed
6. Either way → we know the behavior is intentional and tested

---

**Status**: 🔴 NOT STARTED  
**Blocker**: None - ready to begin  
**Next**: Begin Companies verification with same systematic approach as Jobs
