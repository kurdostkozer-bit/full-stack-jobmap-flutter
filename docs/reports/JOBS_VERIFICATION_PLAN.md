# Jobs Module - Verification Plan

**Module**: Jobs (Core Business Logic)  
**Priority**: 🔴 Critical (depends on Auth ✅)  
**Estimated Time**: 6-9 hours  
**Start Date**: Ready to begin  
**Status**: ⏳ Pending - Awaiting execution

---

## Overview

The Jobs Module is the core business logic of jobMap. It handles:
- Job creation and management
- Search and discovery
- Filtering and pagination
- Recruiter authorization
- Job application tracking

---

## Verification Checklist

### 1. Build ✅/❌
```
Requirements:
- [ ] Rebuild without errors
- [ ] TypeScript strict: 0 errors
- [ ] All imports resolve
- [ ] Controllers load properly
```

**Test Command**:
```bash
npm run build
```

---

### 2. Database ✅/❌

```sql
-- Verify schema
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public' AND table_name LIKE 'job%';

-- Verify columns
\d jobs
\d job_skills
```

**Checks Required**:
- [ ] `jobs` table exists
- [ ] `job_skills` junction table exists
- [ ] All columns present
- [ ] Foreign keys to companies
- [ ] Foreign keys to recruiters
- [ ] Constraints enforced
- [ ] Migrations applied

---

### 3. Happy Path Tests ✅/❌

#### 3.1 Create Job
```bash
POST /api/v1/jobs
Authorization: Bearer [recruiter-token]

Body:
{
  "title": "Senior Developer",
  "description": "5+ years experience",
  "salary_min": 50000,
  "salary_max": 80000,
  "job_type": "FULL_TIME",
  "experience_level": "SENIOR",
  "location": "Beirut, Lebanon",
  "company_id": "uuid",
  "skills": ["JavaScript", "React", "Node.js"]
}

Expected: 201 Created + job object with ID
```

**Tests to Pass**:
- [ ] Job created (201)
- [ ] Job ID generated (UUID)
- [ ] Skills associated
- [ ] Recruiter linked
- [ ] Company linked
- [ ] Created timestamp set
- [ ] All required fields present

---

#### 3.2 Read Job
```bash
GET /api/v1/jobs/:id
Authorization: NOT required (public)

Expected: 200 OK + complete job data
```

**Tests to Pass**:
- [ ] Existing job returns 200
- [ ] All fields returned
- [ ] Skills populated
- [ ] Company data included
- [ ] Recruiter data included (basic)
- [ ] Application count included
- [ ] Save count included

---

#### 3.3 Update Job
```bash
PATCH /api/v1/jobs/:id
Authorization: Bearer [recruiter-token]

Body: Any fields to update

Expected: 200 OK + updated job
```

**Tests to Pass**:
- [ ] Recruiter can update own job (200)
- [ ] Job updated (200)
- [ ] Updated timestamp changed
- [ ] Only specified fields updated
- [ ] Other fields unchanged
- [ ] Cannot update immutable fields

---

#### 3.4 Delete Job
```bash
DELETE /api/v1/jobs/:id
Authorization: Bearer [recruiter-token]

Expected: 200/204 OK
```

**Tests to Pass**:
- [ ] Recruiter can delete own job
- [ ] Job soft-deleted or hard-deleted
- [ ] Archived correctly
- [ ] Applications handled properly
- [ ] Saved jobs handled properly

---

### 4. Validation Tests ✅/❌

```
[ ] Empty title → 400
[ ] Empty description → 400
[ ] Invalid job_type → 400
[ ] Salary range: max < min → 400
[ ] Invalid location format → 400
[ ] Missing company_id → 400
[ ] Invalid UUID → 400
[ ] Empty skills array → 400
[ ] Skill not found → 400/404
[ ] Duplicate skills → 400
[ ] Title too short (< 5 chars) → 400
[ ] Title too long (> 100 chars) → 400
[ ] Description too short → 400
[ ] Salary out of range → 400
```

**Expected**: Each validation returns 400 with clear message

---

### 5. Authorization Tests ✅/❌

#### 5.1 Create Job
```
[ ] Non-recruiter cannot create → 403/401
[ ] Recruiter can create own job → 201
[ ] Recruiter cannot create for other company → 403
[ ] Admin can create for any company → 201
```

#### 5.2 Update Job
```
[ ] Recruiter can update own job → 200
[ ] Recruiter cannot update others' job → 403
[ ] Non-recruiter cannot update → 403
[ ] Admin can update any job → 200
```

#### 5.3 Delete Job
```
[ ] Recruiter can delete own job → 200
[ ] Recruiter cannot delete others' job → 403
[ ] Non-recruiter cannot delete → 403
[ ] Admin can delete any job → 200
```

#### 5.4 View Job
```
[ ] Any user can view any job (public) → 200
[ ] Not authenticated still can view → 200
```

---

### 6. Search Tests ✅/❌

#### 6.1 Keyword Search
```bash
GET /api/v1/jobs?search=developer
```

**Tests**:
- [ ] Search in title works
- [ ] Search in description works
- [ ] Case-insensitive search
- [ ] Partial word match works
- [ ] Multiple keywords (AND/OR logic)
- [ ] Empty search returns all
- [ ] Returns correct results

#### 6.2 Slug Search
```bash
GET /api/v1/jobs/slug/senior-developer-at-company
```

**Tests**:
- [ ] URL slug exists
- [ ] Slug is unique per company
- [ ] Returns correct job
- [ ] Invalid slug → 404

#### 6.3 Company Search
```bash
GET /api/v1/jobs?company_name=Google
```

**Tests**:
- [ ] Search by company name works
- [ ] Multiple jobs per company
- [ ] Case-insensitive

---

### 7. Filter Tests ✅/❌

#### 7.1 City Filter
```bash
GET /api/v1/jobs?city=Beirut
```

**Tests**:
- [ ] Single city filter works
- [ ] Multiple cities (OR)
- [ ] Case-insensitive

#### 7.2 Province Filter
```bash
GET /api/v1/jobs?province=Mount_Lebanon
```

**Tests**:
- [ ] Single province works
- [ ] Multiple provinces

#### 7.3 Job Type Filter
```bash
GET /api/v1/jobs?job_type=FULL_TIME,PART_TIME
```

**Tests**:
- [ ] Single type works
- [ ] Multiple types work
- [ ] Invalid type rejected

#### 7.4 Experience Level Filter
```bash
GET /api/v1/jobs?experience=SENIOR
```

**Tests**:
- [ ] Level filter works
- [ ] Multiple levels work

#### 7.5 Salary Filter
```bash
GET /api/v1/jobs?salary_min=40000&salary_max=100000
```

**Tests**:
- [ ] Salary range filter works
- [ ] Min only
- [ ] Max only
- [ ] Both min and max
- [ ] Invalid ranges handled

#### 7.6 Skills Filter
```bash
GET /api/v1/jobs?skills=JavaScript,React
```

**Tests**:
- [ ] Skills filter works (AND/OR)
- [ ] Partial skill matches
- [ ] Case-insensitive

#### 7.7 Combined Filters
```bash
GET /api/v1/jobs?city=Beirut&job_type=FULL_TIME&skills=JavaScript&salary_min=50000
```

**Tests**:
- [ ] Multiple filters work together
- [ ] Correct intersection/union logic
- [ ] Performance acceptable

---

### 8. Pagination Tests ✅/❌

```bash
GET /api/v1/jobs?page=1&limit=10
GET /api/v1/jobs?page=2&limit=20
GET /api/v1/jobs?page=100&limit=10  # Beyond total
```

**Tests**:
- [ ] Default pagination works
- [ ] Custom page and limit work
- [ ] Out of range page handled (empty or 404)
- [ ] Limit respected (max limit enforced)
- [ ] Response includes total count
- [ ] Response includes current page
- [ ] Response includes has_next_page
- [ ] Response includes has_prev_page

---

### 9. Sorting Tests ✅/❌

```bash
GET /api/v1/jobs?sort=created_at:desc
GET /api/v1/jobs?sort=salary:asc
GET /api/v1/jobs?sort=relevance:desc
```

**Tests**:
- [ ] Sort by created_at ascending
- [ ] Sort by created_at descending
- [ ] Sort by salary ascending
- [ ] Sort by salary descending
- [ ] Sort by relevance (search)
- [ ] Sort by updated_at
- [ ] Sort by experience level
- [ ] Invalid sort field handled

---

### 10. Error Handling ✅/❌

```
[ ] Job not found → 404
[ ] Invalid UUID → 400/404
[ ] Missing required fields → 400
[ ] Invalid data types → 400
[ ] Unauthorized → 401
[ ] Forbidden → 403
[ ] Conflict (duplicate) → 409
[ ] Server error handled → 5xx
[ ] Clear error messages
```

---

### 11. Response Contract ✅/❌

**Job Response Format**:
```json
{
  "id": "uuid",
  "title": "string",
  "slug": "string",
  "description": "string",
  "salary_min": number,
  "salary_max": number,
  "job_type": "FULL_TIME|PART_TIME|CONTRACT",
  "experience_level": "JUNIOR|MID|SENIOR",
  "location": {
    "city": "string",
    "province": "string",
    "country": "string"
  },
  "company": {
    "id": "uuid",
    "name": "string",
    "logo_url": "string"
  },
  "recruiter": {
    "id": "uuid",
    "name": "string"
  },
  "skills": [
    {
      "id": "uuid",
      "name": "string"
    }
  ],
  "application_count": number,
  "save_count": number,
  "created_at": "ISO8601",
  "updated_at": "ISO8601"
}
```

**Tests**:
- [ ] All fields present
- [ ] Field types correct
- [ ] No extra fields
- [ ] Dates in ISO8601 format
- [ ] Nested objects properly structured
- [ ] Arrays properly formatted
- [ ] No null values where shouldn't be

---

### 12. Database Integrity ✅/❌

```sql
-- Test foreign keys
INSERT INTO jobs (company_id) VALUES ('invalid-uuid');  -- Should fail

-- Test relationships
SELECT j.id, c.name 
FROM jobs j 
JOIN companies c ON j.company_id = c.id;

-- Test cascade delete
DELETE FROM companies WHERE id = 'xyz';
SELECT COUNT(*) FROM jobs WHERE company_id = 'xyz';  -- Should be 0
```

**Tests**:
- [ ] Foreign key to companies enforced
- [ ] Foreign key to recruiters enforced
- [ ] Cannot create job with invalid company
- [ ] Cannot create job with invalid recruiter
- [ ] Cascade delete works (company delete removes jobs)
- [ ] Cascade delete handles job_skills properly
- [ ] Job-Skills junction integrity maintained

---

### 13. Performance - Jobs ✅/❌

| Operation | Target | Status |
|-----------|--------|--------|
| Create Job | < 200ms | |
| Get Job | < 100ms | |
| List (10 items) | < 200ms | |
| Search (keyword) | < 500ms | |
| Filter + Pagination | < 500ms | |
| Complex query | < 1000ms | |

**Tests**:
- [ ] All operations within target
- [ ] No N+1 queries
- [ ] Database indexes used
- [ ] No memory leaks

---

### 14. Edge Cases ✅/❌

```
[ ] Job title with special characters
[ ] Job description with HTML/markdown
[ ] Location with diacritics (Tripoli vs Trablus)
[ ] Salary with decimals
[ ] Empty skills array on retrieval
[ ] Job with no applications
[ ] Job with thousands of applications
[ ] Very long description (10000+ chars)
[ ] Skills not in database
[ ] Duplicate create requests (idempotency)
[ ] Update non-existent job
[ ] Delete already-deleted job
[ ] Archive already-archived job
```

---

### 15. Logging & Monitoring ✅/❌

- [ ] Job creation logged
- [ ] Job updates logged
- [ ] Job deletion logged
- [ ] Failed operations logged
- [ ] Performance metrics logged
- [ ] No sensitive data logged
- [ ] User actions traceable

---

### 16. Documentation ✅/❌

- [ ] Jobs endpoint documented
- [ ] Request/response examples
- [ ] Error codes explained
- [ ] Authorization requirements clear
- [ ] Filters explained
- [ ] Sorting options documented
- [ ] Search syntax documented
- [ ] Database schema documented

---

## Test Execution Plan

### Phase 1: Basic Tests (2 hours)
1. Build verification
2. Database schema check
3. Happy path (CRUD)

### Phase 2: Validation & Authorization (2 hours)
1. All validation scenarios
2. Authorization checks
3. Guard verification

### Phase 3: Search & Filters (2 hours)
1. Search functionality
2. All filter combinations
3. Pagination & sorting

### Phase 4: Edge Cases & Performance (1 hour)
1. Edge case testing
2. Performance measurements
3. Database integrity checks

### Phase 5: Documentation (1 hour)
1. Documentation review
2. Test coverage verification
3. Final sign-off

---

## Success Criteria

✅ **Module is VERIFIED when:**
- [ ] All 16 categories completed
- [ ] Build: 0 errors
- [ ] Database: schema verified
- [ ] Happy Path: 4/4 (CRUD)
- [ ] Validation: 100% coverage
- [ ] Authorization: proper checks
- [ ] Search: keyword, slug, company working
- [ ] Filters: all combinations working
- [ ] Pagination: correct implementation
- [ ] Sorting: all options working
- [ ] Error Handling: proper codes
- [ ] Response Contract: consistent format
- [ ] Database Integrity: constraints enforced
- [ ] Performance: within targets
- [ ] Edge Cases: handled properly
- [ ] Documentation: complete

---

## Files to Create/Modify

```
Create:
  - backend/tests/jobs-test.ps1
  - backend/tests/jobs-search-filter.ps1
  - backend/tests/jobs-pagination.ps1
  - backend/JOBS_VERIFICATION.md
  - backend/postman/JobMap-Jobs-Tests.postman_collection.json

Modify (if needed):
  - backend/src/jobs/controllers/jobs.controller.ts
  - backend/src/jobs/services/jobs.service.ts
  - backend/src/jobs/repositories/jobs.repository.ts
```

---

## Next Steps After Jobs

1. ✅ Auth - VERIFIED
2. ⏳ Jobs - IN PROGRESS
3. ⏳ Companies - PENDING
4. ⏳ Career Profiles - PENDING
5. ⏳ Applications - PENDING
6. ⏳ Saved Jobs - PENDING
7. ⏳ Notifications - PENDING
8. ⏳ Chat - PENDING
9. ⏳ Search - PENDING
10. ⏳ Maps - PENDING
11. ⏳ Attachments - PENDING
12. ⏳ Social Links - PENDING

---

## Integration Testing (Post Phase)

After completing Auth + Jobs + Companies (3 modules):
- Implement GitHub Actions CI/CD
- Run all tests on every push
- Block merges if tests fail
- Generate coverage reports

---

**Ready to begin Jobs verification**


---

## UPDATED: Adding Category 17 - Integration Tests

After review, the Jobs Module verification now includes:

### 17. Integration ✅/❌

**Jobs Module integrations with**:
- Auth (authenticated requests)
- Companies (foreign key, cascade delete)
- Career Profiles (job applications)
- Recruiters (job creator)

**Integration Tests Required**:

#### 17.1 Auth Integration
```
[ ] Create job without token → 401
[ ] Create job with valid token → 201
[ ] Update job without auth → 401
[ ] Delete job without auth → 401
[ ] Get job (no auth required) → 200
```

#### 17.2 Companies Integration
```
[ ] Create job with valid company → 201
[ ] Create job with invalid company → 400/404
[ ] Delete company → Jobs handled correctly
  [ ] Cascade delete or soft delete
  [ ] No orphaned jobs
```

#### 17.3 Career Profiles Integration
```
[ ] User applies to job → Application created
[ ] Job application count increases
[ ] Saved job functionality works
```

#### 17.4 Dependent Modules Still Work
```
[ ] Auth still passes all tests
[ ] No breaking changes introduced
[ ] Cross-module queries work
```

---

## Updated Success Criteria

✅ **Module is VERIFIED when:**
- [ ] All 17 categories completed (including Integration)
- [ ] Build: 0 errors
- [ ] Database: schema verified
- [ ] Happy Path: 4/4 (CRUD)
- [ ] Validation: 100% coverage
- [ ] Authorization: proper checks
- [ ] Search: working
- [ ] Filters: all combinations
- [ ] Pagination: correct
- [ ] Sorting: all options
- [ ] Error Handling: proper codes
- [ ] Response Contract: consistent format
- [ ] Database Integrity: constraints enforced
- [ ] Performance: within targets
- [ ] Edge Cases: handled
- [ ] Documentation: complete
- [ ] **Integration: Works with Auth, Companies, Career Profiles ✅**
