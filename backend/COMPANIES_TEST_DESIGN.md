# Companies Module - Test Design (Phase 1)

**Date**: July 31, 2026  
**Status**: Test case list (NOT code yet)  
**Based On**: COMPANIES_DISCOVERY_REPORT.md findings

---

## Test Categories & Cases

### Category 1: Build & Database

**1.1 - Build Verification**
- [ ] npm run build: 0 errors
- [ ] TypeScript strict: 0 errors
- [ ] All imports resolve
- [ ] Controllers load

**1.2 - Database Schema**
- [ ] `companies` table exists
- [ ] All columns present (id, name, slug, description, etc.)
- [ ] Correct column types (uuid, varchar, text, enum, timestamp)
- [ ] Soft delete column exists (deletedAt)
- [ ] `createdBy` FK to users exists
- [ ] `updatedBy` FK to users exists
- [ ] `slug` has UNIQUE constraint
- [ ] Indexes created on key columns

---

### Category 2: CRUD - Happy Path

**2.1 - CREATE Company**
- [ ] POST /api/v1/companies with valid data → 201 Created
- [ ] Company created with correct data
- [ ] Response includes all fields (id, name, slug, createdBy, createdAt, etc.)
- [ ] Company ID is UUID
- [ ] createdBy is set to authenticated user's ID
- [ ] updatedBy is set to authenticated user's ID
- [ ] Timestamps are ISO8601 format
- [ ] Slug is lowercase/valid format

**2.2 - READ Company by ID**
- [ ] GET /api/v1/companies/:id → 200 OK
- [ ] Returns correct company data
- [ ] All required fields present
- [ ] deletedAt is null (for active company)
- [ ] Response format consistent

**2.3 - READ Company by Slug**
- [ ] GET /api/v1/companies/by-slug/:slug → 200 OK
- [ ] Returns correct company
- [ ] Same fields as get-by-id

**2.4 - LIST Companies**
- [ ] GET /api/v1/companies → 200 OK
- [ ] Returns array of companies
- [ ] Includes pagination/sorting if implemented
- [ ] Only active companies (deletedAt IS NULL)
- [ ] Can filter by status, industry, companySize

**2.5 - UPDATE Company**
- [ ] PATCH /api/v1/companies/:id → 200 OK
- [ ] Only specified fields updated
- [ ] Other fields unchanged
- [ ] updatedBy set to current user
- [ ] updatedAt changed
- [ ] Slug cannot be empty
- [ ] Name cannot be empty

**2.6 - DELETE Company (Soft Delete)**
- [ ] DELETE /api/v1/companies/:id → 200 OK
- [ ] Company NOT hard deleted (still in DB)
- [ ] deletedAt is set to current timestamp
- [ ] updatedBy set to current user
- [ ] Company no longer appears in GET requests
- [ ] Can potentially restore (if API supports it)

---

### Category 3: Validation

**3.1 - Required Fields**
- [ ] Create without name → 400 Bad Request
- [ ] Create without slug → 400 Bad Request
- [ ] Create with empty name → 400 Bad Request
- [ ] Create with empty slug → 400 Bad Request

**3.2 - Slug Validation**
- [ ] Slug with special characters → 400 Bad Request
- [ ] Slug with spaces → 400 Bad Request
- [ ] Slug with uppercase → May auto-lowercase or 400

**3.3 - Uniqueness Constraints**
- [ ] Create company with slug="acme" → 201
- [ ] Create another with slug="acme" → 409 Conflict
- [ ] Update company B slug to "acme" (already taken) → 409 Conflict

**3.4 - Email Validation**
- [ ] Email: "invalid" → 400 Bad Request
- [ ] Email: "test@example.com" → 201 OK
- [ ] Email: empty string → Valid (optional field)

**3.5 - Website/URL Validation**
- [ ] Website: "invalid-url" → 400 Bad Request
- [ ] Website: "https://example.com" → 201 OK
- [ ] Logo URL validation (if URLs validated)
- [ ] CoverImage URL validation (if URLs validated)

**3.6 - Enum Validation**
- [ ] companySize: "STARTUP" → 201 OK
- [ ] companySize: "INVALID" → 400 Bad Request
- [ ] status: "ACTIVE" → 201 OK
- [ ] status: "INVALID" → 400 Bad Request
- [ ] verificationStatus: "UNVERIFIED" → 201 OK
- [ ] verificationStatus: "INVALID" → 400 Bad Request

**3.7 - Founded Year Validation**
- [ ] foundedYear: 1799 → 400 Bad Request (before 1800)
- [ ] foundedYear: 1800 → 201 OK
- [ ] foundedYear: 2027 → 400 Bad Request (future)
- [ ] foundedYear: 2026 → 201 OK (current year)

**3.8 - String Length Validation**
- [ ] name: very long string (1000+ chars) → 400 Bad Request (or truncate)
- [ ] name: 255 chars max, 256+ → 400 Bad Request (or truncate)
- [ ] slug: 255 chars max, 256+ → 400 Bad Request (or truncate)

---

### Category 4: Authorization (CRITICAL - Will Expose Bugs!)

**4.1 - Authentication Required**
- [ ] POST /companies without token → 401 Unauthorized
- [ ] PATCH /companies/:id without token → 401 Unauthorized
- [ ] DELETE /companies/:id without token → 401 Unauthorized
- [ ] GET /companies without token → 200 OK (public)
- [ ] GET /companies/:id without token → 200 OK (public)

**4.2 - Owner Can Update Own Company** ✅
- [ ] User A creates Company 1
- [ ] User A: PATCH /companies/1 → 200 OK
- [ ] Company updated successfully

**4.3 - Non-Owner Cannot Update** 🔴 [WILL FAIL - Not Implemented]
- [ ] User A creates Company 1
- [ ] User B: PATCH /companies/1 → 403 Forbidden
- [ ] Company NOT updated
- [ ] Error message clear: "Unauthorized" or "Cannot modify"

**4.4 - Owner Can Delete Own Company** ✅
- [ ] User A creates Company 1
- [ ] User A: DELETE /companies/1 → 200 OK
- [ ] Company soft-deleted (deletedAt set)

**4.5 - Non-Owner Cannot Delete** 🔴 [WILL FAIL - Not Implemented]
- [ ] User A creates Company 1
- [ ] User B: DELETE /companies/1 → 403 Forbidden
- [ ] Company NOT deleted
- [ ] Error message clear

**4.6 - Admin Can Override** ❓ [Unknown - May not be implemented]
- [ ] Admin user created
- [ ] Admin: PATCH /companies/:id (someone else's) → 200 OK or 403?
- [ ] Admin: DELETE /companies/:id (someone else's) → 200 OK or 403?
- [ ] Behavior depends on design (not yet specified)

**4.7 - Ownership is Based on createdBy**
- [ ] Company.createdBy === User.id → Can modify/delete
- [ ] Company.createdBy !== User.id → Cannot modify/delete (unless admin)

---

### Category 5: Error Handling

**5.1 - Not Found Errors**
- [ ] GET /companies/00000000-0000-0000-0000-000000000000 → 404 Not Found
- [ ] GET /companies/by-slug/nonexistent → 404 Not Found
- [ ] PATCH /companies/nonexistent → 404 Not Found
- [ ] DELETE /companies/nonexistent → 404 Not Found

**5.2 - Invalid Input Errors**
- [ ] POST with invalid JSON → 400 Bad Request
- [ ] POST with invalid UUID in reference → 400 Bad Request
- [ ] PATCH with invalid UUID in parameter → 400 Bad Request

**5.3 - Conflict Errors**
- [ ] POST with duplicate slug → 409 Conflict
- [ ] PATCH to duplicate slug → 409 Conflict
- [ ] Error message includes reason ("slug already exists")

**5.4 - Forbidden Errors**
- [ ] Non-owner UPDATE → 403 Forbidden
- [ ] Non-owner DELETE → 403 Forbidden
- [ ] Error message clear: "Cannot modify" or "Unauthorized"

---

### Category 6: Response Contract

**6.1 - Create Response Format**
```json
{
  "id": "uuid",
  "name": "string",
  "slug": "string",
  "logo": "url or null",
  "coverImage": "url or null",
  "description": "string or null",
  "industry": "string or null",
  "companySize": "enum or null",
  "foundedYear": "number or null",
  "website": "url or null",
  "email": "email or null",
  "phone": "string or null",
  "country": "string or null",
  "city": "string or null",
  "address": "string or null",
  "verificationStatus": "enum",
  "status": "enum",
  "createdBy": "uuid",
  "updatedBy": "uuid",
  "createdAt": "ISO8601",
  "updatedAt": "ISO8601",
  "deletedAt": "ISO8601 or null"
}
```

- [ ] All required fields present
- [ ] No extra fields
- [ ] Field types correct
- [ ] Dates in ISO8601 format
- [ ] Null fields properly null (not missing)
- [ ] Consistent format across list/detail/update responses

**6.2 - List Response Format**
- [ ] Returns array of companies
- [ ] Each item matches single company response format
- [ ] Only non-deleted companies (deletedAt IS NULL)
- [ ] Pagination metadata if pagination implemented

**6.3 - Field Presence Rules**
- [ ] createdBy: Always present (UUID)
- [ ] updatedBy: Always present (UUID)
- [ ] deletedAt: Null for active, timestamp for deleted
- [ ] Optional fields: Null or omitted (consistent behavior)

---

### Category 7: Database Integrity & Foreign Keys

**7.1 - createdBy Foreign Key**
- [ ] Company created with valid user_id → 201 OK
- [ ] Company created with invalid user_id → 400/500 (FK violation)
- [ ] createdBy value matches authenticated user

**7.2 - updatedBy Foreign Key**
- [ ] Company updated, updatedBy set to current user
- [ ] updatedBy value matches authenticated user
- [ ] Cannot manually set updatedBy to different user

**7.3 - Related Data Isolation**
- [ ] Company A and Company B are isolated
- [ ] Recruiters of Company A ≠ Recruiters of Company B
- [ ] Jobs of Company A ≠ Jobs of Company B
- [ ] Creating recruiter for Company A doesn't affect Company B

---

### Category 8: Soft Delete Behavior (Critical!)

**8.1 - Soft Delete Mechanics**
- [ ] DELETE /companies/:id → Sets deletedAt
- [ ] Database query: SELECT * FROM companies → Does NOT include deleted
- [ ] Database query with WHERE deletedAt IS NULL → Only active companies
- [ ] Hard delete NOT possible via API (no permanent deletion)

**8.2 - Orphaned Records**
- [ ] Company A has 50 Jobs
- [ ] DELETE /companies/A → Soft delete
- [ ] Jobs still in database with company_id = A
- [ ] GET /jobs?company_id=A → What happens?
  - [ ] Option 1: Returns jobs (company deleted but jobs remain)
  - [ ] Option 2: Returns empty (jobs are logical children)
  - [ ] Option 3: Error (cannot query deleted company's jobs)
- [ ] Behavior must be defined and tested

**8.3 - Restore Functionality (if available)**
- [ ] Can company be restored after soft delete?
- [ ] If yes: Restore endpoint, behavior verification
- [ ] If no: Permanent after deletion (logical)

**8.4 - Deleted Company Visibility**
- [ ] GET /companies/:id (deleted company) → 404 Not Found
- [ ] GET /companies/by-slug/:slug (deleted company) → 404 Not Found
- [ ] LIST /companies → Does NOT include deleted
- [ ] Only admin/owner should see deleted? (if applicable)

---

### Category 9: Relationships & Integration

**9.1 - Recruiter Relationship**
- [ ] Recruiter has company_id FK → companies.id
- [ ] Create recruiter with valid company_id → 201 OK
- [ ] Create recruiter with invalid company_id → 400/404 Not Found
- [ ] Recruiter.company_id points to valid company
- [ ] Soft delete company: Recruiters remain (orphaned)
- [ ] Query recruiters for company works

**9.2 - Job Relationship**
- [ ] Job has company_id FK → companies.id
- [ ] Create job with valid company_id → 201 OK
- [ ] Create job with invalid company_id → 400/404 Not Found
- [ ] Job.company_id points to valid company
- [ ] Soft delete company: Jobs remain (orphaned)
- [ ] Query jobs for company works

**9.3 - Multi-Company Workflow**
- [ ] Create Company A
- [ ] Create Company B
- [ ] Create recruiter for Company A
- [ ] Create recruiter for Company B
- [ ] Verify they're separate (no data mixing)
- [ ] Delete Company A (soft delete)
- [ ] Verify Company B unaffected

**9.4 - Auth Integration**
- [ ] Company created by User A
- [ ] User A's token works for modification
- [ ] User B's token doesn't work (403)
- [ ] Token validation working correctly

**9.5 - Company Members Integration**
- [ ] Can create CompanyMembers for this company
- [ ] CompanyMembers.company_id FK works
- [ ] Delete company: CompanyMembers orphaned or deleted?

---

### Category 10: Performance

**10.1 - Operation Timing**
- [ ] Create company < 200ms
- [ ] Get company < 100ms
- [ ] List companies (10 items) < 200ms
- [ ] Update company < 200ms
- [ ] Delete company (soft) < 200ms
- [ ] Search/filter < 500ms

**10.2 - Query Optimization**
- [ ] No N+1 queries
- [ ] Database indexes used (createdBy, status, slug)
- [ ] Efficient filtering

---

### Category 11: Documentation & API

**11.1 - Endpoint Documentation**
- [ ] POST /companies: Documented with request/response
- [ ] GET /companies: List endpoint documented
- [ ] GET /companies/:id: Get by ID documented
- [ ] GET /companies/by-slug/:slug: Get by slug documented
- [ ] PATCH /companies/:id: Update documented
- [ ] DELETE /companies/:id: Delete documented

**11.2 - Authorization Documentation**
- [ ] Auth requirement documented
- [ ] Ownership rules documented
- [ ] Error codes documented (401, 403, 404, 409)
- [ ] Field descriptions documented

---

## Test Execution Strategy

### Phase 1A: Basic Functionality (2 hours)
**Expected**: All pass ✅
- Build verification
- Database schema
- CRUD happy path
- Response contracts

### Phase 1B: Validation (1 hour)
**Expected**: All pass ✅
- Required fields
- Email/URL formats
- Enum values
- Uniqueness constraints

### Phase 1C: Authorization (1 hour)
**Expected**: Tests will FAIL 🔴
- Non-owner update → Will pass (BUG!)
- Non-owner delete → Will pass (BUG!)
- These expose the security issues

### Phase 1D: Error Handling (1 hour)
**Expected**: Mostly pass ✅
- 404 errors
- 409 conflict
- 400 bad request
- 403 forbidden (will fail for non-owner cases)

### Phase 1E: Database Integrity (1 hour)
**Expected**: Mostly pass ✅
- FK constraints
- Soft delete mechanics
- Orphaned records

### Phase 1F: Integration (1 hour)
**Expected**: Mostly pass ✅
- Recruiter FK
- Job FK
- Multi-company workflows
- Auth integration

---

## Expected Test Results

### Baseline Expectation

```
WILL PASS (Expected ✅):
  ✅ Build verification
  ✅ Database schema
  ✅ CRUD happy path (create, read, update, delete)
  ✅ GET operations (public endpoints)
  ✅ Validation (required fields, formats)
  ✅ Uniqueness (slug conflict detection)
  ✅ 404 Not Found errors
  ✅ 409 Conflict errors
  ✅ FK constraints (recruiters, jobs)
  ✅ Response formats

WILL FAIL (Expected to uncover bugs 🔴):
  🔴 Non-owner UPDATE (should be 403, will be 200)
  🔴 Non-owner DELETE (should be 403, will be 200)
  🔴 Soft delete orphaning (behavior undefined)
  🔴 Slug update uniqueness check (can update to taken slug)

UNKNOWN (Need clarification):
  ❓ Admin override behavior
  ❓ Recruiter permissions (can recruiter modify company?)
  ❓ Deleted company restoration
  ❓ CompanyMembers cascade behavior
```

---

## Test Data Requirements

**User Accounts Needed**:
- User A (will create companies)
- User B (will try unauthorized access)
- Admin user (if admin override tested)

**Test Companies**:
- Company A (created by User A)
- Company B (created by User B)
- Company C (for relationship testing)

**Related Data**:
- Recruiters (5-10 for testing)
- Jobs (5-10 for testing)
- CompanyMembers (for isolation testing)

---

## Test Tools

**Framework**: Python + requests library (same as Auth/Jobs)

**Execution Method**:
1. Test discovery
2. Setup: Create users, authenticate
3. Execute: Run all test cases
4. Results: Document pass/fail
5. Fix: Address failures
6. Re-run: Verify fixes

---

## Risk Mitigation

### High Risk: Authorization Bypass
- **Risk**: Non-owner can modify/delete company
- **Mitigation**: Tests 4.3 and 4.5 will catch this
- **Fix**: Add ownership check in service

### Medium Risk: Orphaned Data
- **Risk**: Soft delete leaves orphaned records
- **Mitigation**: Tests 8.2, 8.4 will clarify behavior
- **Action**: Document intended behavior

### Medium Risk: Slug Update Bug
- **Risk**: Can update to existing slug
- **Mitigation**: Test 3.3 second part will catch
- **Fix**: Add slug uniqueness check in update

---

## Completion Criteria

✅ **Companies Module is VERIFIED when:**
- [ ] All build tests pass (0 errors)
- [ ] All database tests pass (schema correct)
- [ ] All CRUD tests pass (4/4)
- [ ] All validation tests pass (8/8)
- [ ] All authorization tests pass (7/7) ← Most critical
- [ ] All error tests pass (5/5)
- [ ] All response tests pass (3/3)
- [ ] All FK integrity tests pass (5/5)
- [ ] All soft delete tests pass (4/4)
- [ ] All integration tests pass (5/5)
- [ ] All performance tests pass (6/6)
- [ ] Found issues documented
- [ ] Issues fixed and re-tested
- [ ] Test suite 100% repeatable

---

**Test Design Status**: COMPLETE  
**Ready for Phase 2**: YES  
**Next Step**: Write `companies_test.py` with all test cases above

---

**Date Created**: July 31, 2026  
**Based On**: COMPANIES_DISCOVERY_REPORT.md  
**Total Test Cases**: ~80-100  
**Estimated Execution Time**: ~30-40 minutes  
**Expected Bugs to Expose**: 3-5
