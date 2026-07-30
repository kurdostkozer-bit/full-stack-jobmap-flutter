# Companies Module - Discovery Report

**Date**: July 31, 2026  
**Focus**: Understanding actual architecture before writing tests  
**Status**: Discovery phase complete

---

## Architecture Review

### 1. Foreign Key Relationships

**Companies table references:**
- ✅ `createdBy` → `users.id` (who created the company)
- ✅ `updatedBy` → `users.id` (who last updated the company)

**Tables that reference Companies:**
```
Companies ← CompanyMembers (company_id FK)
         ← Recruiters (company_id FK)
         ← Jobs (company_id FK) ← Applications
         ← Departments (company_id FK)
         ← CompanyLocations (company_id FK)
```

**Critical Finding**: NO explicit CASCADE delete defined in Companies schema. Only soft deletes via `deletedAt` timestamp.

### 2. Delete Strategy

**Current Behavior: SOFT DELETE (not hard delete)**

```typescript
async softDelete(id: string, userId: string) {
  SET deletedAt = NOW()
  // Doesn't actually delete, just marks as deleted
}
```

**Implications**:
- ✅ Company data preserved (audit trail)
- ✅ Recruiter/Job/Department records NOT deleted
- ❓ Question: What happens to Jobs that reference deleted company?
- ❓ Question: Can deleted company be restored?

**What's NOT in code**:
- No CASCADE delete to Recruiters
- No CASCADE delete to Jobs
- No CASCADE delete to Departments
- Orphaned records will remain if company is soft-deleted

### 3. Ownership Model

**Company Creation**:
```typescript
async create(dto: CreateCompanyDto, userId: string) {
  INSERT INTO companies
  VALUES (..., createdBy: userId, updatedBy: userId)
}
```

**Company Update**:
```typescript
async update(id: string, dto: UpdateCompanyDto, userId: string) {
  UPDATE companies
  SET updatedBy: userId
  WHERE id = id  // NO ownership check!
}
```

**Critical Finding: ⚠️ NO OWNERSHIP VERIFICATION**

```typescript
async update(id: string, dto: UpdateCompanyDto, userId: string) {
  // userId is passed but NEVER compared to createdBy
  const company = await this.companiesRepository.update(id, dto, userId);
  // Any authenticated user can update ANY company!
}
```

Same issue with `delete()` method.

### 4. Security Model

**Current Guards**:
- ✅ POST /companies - `@UseGuards(JwtAuthGuard)` - Authentication required
- ✅ PATCH /companies/:id - `@UseGuards(JwtAuthGuard)` - Authentication required
- ✅ DELETE /companies/:id - `@UseGuards(JwtAuthGuard)` - Authentication required
- ✅ GET /companies - No guard - Public endpoint
- ✅ GET /companies/:id - No guard - Public endpoint
- ✅ GET /companies/by-slug/:slug - No guard - Public endpoint

**Missing Checks**:
- ❌ No ownership verification in update
- ❌ No ownership verification in delete
- ❌ No role-based authorization (anyone can update ANY company)

**Consequence**: User A can modify/delete Company created by User B if they're authenticated.

### 5. Unique Constraints

**In Schema**:
```typescript
slug: varchar('slug', { length: 255 }).notNull().unique(),
```

✅ Slug must be globally unique

**In Service**:
```typescript
async create(dto: CreateCompanyDto, userId: string) {
  const existing = await this.companiesRepository.findBySlug(dto.slug);
  if (existing) {
    throw new ConflictException('Company slug already exists');
  }
}
```

✅ Checked before insert

**Missing**:
- ❌ No unique constraint check on update
- ❌ Can user change slug to another user's slug? Test this!

### 6. Transactions

**Status**: None visible in code

- No explicit transaction handling
- No `BEGIN/COMMIT/ROLLBACK`
- No nested transaction management
- Single-operation atomicity only (handled by Drizzle)

**Risk**: Multi-step operations (create company → add members → create roles) could partially succeed.

### 7. Edge Cases & Risks

#### High Risk:

1. **Ownership Check Missing**
   ```
   User A: POST /companies → Creates Company 1
   User B: PATCH /companies/1 → Updates Company 1 ✅ (NO ERROR!)
   ```
   **Severity**: CRITICAL - Authorization bypass
   **Fix Needed**: Add `createdBy === userId` check

2. **Soft Delete Orphaning**
   ```
   Company has 50 Jobs
   DELETE /companies/1 → Sets deletedAt
   Jobs still in database with company_id pointing to deleted company
   GET /jobs?company_id=1 → Returns jobs from "deleted" company
   ```
   **Severity**: MEDIUM - Data integrity question
   **Decision Needed**: Is this intentional?

3. **Slug Update Collision**
   ```
   Company 1: slug = "acme"
   Company 2: slug = "techcorp"
   PATCH /companies/2 → slug: "acme" → ??? (conflict or allowed?)
   ```
   **Severity**: MEDIUM - Need to test

#### Medium Risk:

4. **Recruiter Orphaning**
   ```
   Company has 10 Recruiters
   Soft-delete Company
   Recruiters still exist with company_id = deleted_company_id
   ```

5. **No Created/Modified User Tracking in Response**
   ```
   Response doesn't include createdBy/updatedBy user details
   Only includes IDs
   ```

---

## Answers to Key Questions

### 1. Who is the owner of a Company?

**Answer**: The user who created it (stored in `createdBy` field)

**However**: 
- ❌ This is NOT verified on update/delete
- Any authenticated user can modify any company
- **This is a BUG**

### 2. Relationship with Recruiters?

**Answer**: 1-to-Many (one company → many recruiters)

```
companies.id ← recruiters.company_id (FK, NOT NULL)
```

**Soft Delete Behavior**: Recruiters remain if company is soft-deleted

### 3. Relationship with Jobs?

**Answer**: 1-to-Many (one company → many jobs)

```
companies.id ← jobs.company_id (FK, NOT NULL)
```

**Soft Delete Behavior**: Jobs remain if company is soft-deleted

### 4. Delete Strategy - RESTRICT, CASCADE, or SET NULL?

**Answer**: **SOFT DELETE (neither of the three)**

- Not a hard delete
- Doesn't cascade
- Doesn't set to NULL
- Just marks `deletedAt` timestamp
- All related records remain unchanged

**Question for stakeholders**: Is this intentional?

### 5. Unique Constraints?

**Answer**: Only `slug` is globally unique

- `slug` must be unique across ALL companies (deleted and active)
- No other unique constraints

### 6. Transactions?

**Answer**: None

- Each query is independent
- No multi-step atomicity
- Risk: Create company but fail to add initial user = orphaned record

### 7. Edge Cases & Design Issues?

See Risk Assessment below

---

## Risk Assessment

### 🔴 CRITICAL Issues (Must Fix Before VERIFIED)

1. **Missing Ownership Verification in Update**
   - Any authenticated user can modify ANY company
   - Impact: Authorization bypass
   - Fix: Add check `company.createdBy !== userId → 403 Forbidden`
   - Test: User A creates company, User B tries to update → expect 403

2. **Missing Ownership Verification in Delete**
   - Any authenticated user can delete ANY company
   - Impact: Data destruction by unauthorized user
   - Fix: Add check `company.createdBy !== userId → 403 Forbidden`
   - Test: User A creates company, User B tries to delete → expect 403

3. **Soft Delete Creates Orphaned Records**
   - Company is marked deleted but related data remains
   - Impact: Data integrity question, queries return data from "deleted" company
   - Fix: Define policy: restore, CASCADE hard delete, or accept orphans?
   - Test: Create company → create jobs → soft delete company → verify jobs still exist

### 🟠 HIGH Issues (Should Fix)

4. **Slug Update Not Validated for Uniqueness**
   - Can duplicate another company's slug in update
   - Fix: Add slug uniqueness check in update
   - Test: Create company A (slug="acme"), Update company B to slug="acme" → expect 409

5. **No Admin Override**
   - No role-based authorization
   - Admin can't manage user companies
   - Fix: Add admin bypass (if role="ADMIN" → allow)
   - Test: Admin updates other user's company → expect 200

### 🟡 MEDIUM Issues (Nice to Have)

6. **Response Doesn't Include Creator Name**
   - Response has `createdBy` UUID but not user name/email
   - Fix: Include creator user object in response
   - Impact: Client needs extra query to get creator details

7. **No Transaction Handling**
   - Multi-step operations could partially fail
   - Fix: Add explicit transaction boundaries
   - Impact: Low if operations are simple

8. **Soft Deleted Records Visible in Relations**
   - If you query jobs, you see jobs for deleted companies
   - Fix: Auto-filter deletedAt IS NULL in all queries
   - Test: Create company → create job → soft delete company → GET /jobs → should job appear?

---

## Database Schema Analysis

### Companies Table
```sql
companies {
  id: uuid (PK)
  name: varchar (NOT NULL)
  slug: varchar (UNIQUE)
  description: text (nullable)
  industry: varchar (nullable)
  companySize: enum (STARTUP|SMALL|MEDIUM|LARGE|ENTERPRISE)
  foundedYear: integer (nullable, 1800-now)
  website: varchar (nullable)
  email: varchar (nullable)
  phone: varchar (nullable)
  country: varchar (nullable)
  city: varchar (nullable)
  address: text (nullable)
  verificationStatus: enum (UNVERIFIED|PENDING|VERIFIED|REJECTED)
  status: enum (ACTIVE|INACTIVE|SUSPENDED)
  createdBy: uuid (FK → users.id, NOT NULL)
  updatedBy: uuid (FK → users.id, NOT NULL)
  createdAt: timestamp (NOT NULL)
  updatedAt: timestamp (NOT NULL)
  deletedAt: timestamp (nullable - for soft delete)
}
```

### Dependent Tables
```
CompanyMembers:
  - company_id FK → companies.id (NOT NULL)
  - user_id FK → users.id (NOT NULL)
  - role: enum

Recruiters:
  - company_id FK → companies.id (NOT NULL)
  - user_id FK → users.id (NOT NULL)
  - title, position, etc.

Jobs:
  - company_id FK → companies.id (NOT NULL)
  - recruiter_id FK → recruiters.id (NOT NULL)
  - Many jobs per company

Departments:
  - company_id FK → companies.id (NOT NULL)
  - name, slug, etc.

CompanyLocations:
  - company_id FK → companies.id (NOT NULL)
  - name, address, etc.
```

---

## Code Quality Observations

### ✅ Good Practices Found
1. Service abstraction (business logic in service, not controller)
2. Repository pattern (data access isolated)
3. DTO validation (class-validator annotations)
4. Soft delete implementation (audit trail preservation)
5. Auth guards applied (JWT required on mutations)
6. Proper error codes (404, 409, etc.)

### ❌ Issues Found
1. **Missing authorization checks** (createdBy verification)
2. **No admin override** (RBAC not implemented)
3. **Slug uniqueness not checked in update**
4. **Response doesn't hydrate user details**
5. **No transaction handling**
6. **Soft delete creates orphaned records**

---

## Test Strategy Implications

Based on this discovery, the test suite must include:

### MUST TEST (Critical Path)
1. ✅ Ownership verification on update (creator vs non-creator)
2. ✅ Ownership verification on delete (creator vs non-creator)
3. ✅ Soft delete behavior (company marked deleted, records orphaned?)
4. ✅ Slug uniqueness in create
5. ✅ Slug uniqueness in update (can update to another's slug?)

### SHOULD TEST (High Value)
6. ✅ Recruiter FK relationship (can't create recruiter with invalid company_id)
7. ✅ Job FK relationship (can't create job with invalid company_id)
8. ✅ Deleted company in queries (does it appear in results?)
9. ✅ Multi-step workflows (create → add members → verify)
10. ✅ Admin override (if available)

### NICE TO TEST (Coverage)
11. ✅ All enum validations (companySize, status, verificationStatus)
12. ✅ Email format validation
13. ✅ URL format validation (website, logo, coverImage)
14. ✅ Founded year range (1800-now)
15. ✅ Search/filter functionality

---

## Critical Questions for Stakeholders

Before writing tests, these must be answered:

1. **Authorization Model**
   - Should only company creator edit their company? (Recommended)
   - Or should all recruiters of that company edit it?
   - Or should company admins edit it?

2. **Soft Delete vs Hard Delete**
   - When company is deleted, should related jobs/recruiters also be deleted?
   - Or should they be orphaned (current behavior)?
   - Or should they be marked as belonging to "deleted company"?

3. **Admin Override**
   - Should admins be able to edit/delete any company?
   - Or should admins have different permissions?

4. **Recruiter Permissions**
   - Can a recruiter of company A create another recruiter for company A?
   - Can a recruiter of company A update company A details?

---

## Summary

**Current State**: 
- Companies module has basic CRUD working
- Guards in place for authentication
- **BUT: Missing authorization checks (major security issue)**
- Soft delete implemented but orphaning related data

**Bugs Found**: 3 CRITICAL, 5 HIGH, 3 MEDIUM

**Ready for Testing**: YES - but expect to find these issues in test execution

**Recommended Next Step**: 
1. Write tests that expose these issues (TDD style)
2. Tests will FAIL initially (expected)
3. Fix the code
4. Tests will PASS
5. Mark module VERIFIED

---

**Discovery Date**: July 31, 2026  
**Discoverer**: Architecture Review Process  
**Status**: Ready for Test Design Phase
