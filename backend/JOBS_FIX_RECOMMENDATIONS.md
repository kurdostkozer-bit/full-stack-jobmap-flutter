# Jobs Module - Fix Recommendations

**Issue Found**: No authorization guards on Jobs endpoints  
**Severity**: 🔴 CRITICAL  
**Test Status**: 2/21 FAILED (Authorization tests)

---

## Summary

Jobs Module endpoints allow:
- ✅ Creating jobs **without authentication**
- ✅ Updating jobs **without ownership verification**
- ✅ Deleting jobs **without permission checks**

This is a **security vulnerability** and blocks VERIFIED status.

---

## Required Fixes

### Fix #1: Add Recruiter Association to Jobs

**Why**: Need to track who created each job for authorization

**Changes**:

#### 1.1 Database Schema

File: `backend/src/database/schema/jobs.schema.ts`

```typescript
// BEFORE:
import {
  boolean,
  index,
  integer,
  pgTable,
  text,
  timestamp,
  uuid,
} from 'drizzle-orm/pg-core';

export const jobs = pgTable('jobs', {
  id: uuid('id').defaultRandom().primaryKey(),
  companyId: uuid('company_id').notNull(),
  title: text('title').notNull(),
  // ... rest of fields
});

// AFTER:
import {
  boolean,
  index,
  integer,
  pgTable,
  text,
  timestamp,
  uuid,
  foreignKey,  // <- ADD
} from 'drizzle-orm/pg-core';
import { recruiters } from './recruiters.schema';  // <- ADD

export const jobs = pgTable(
  'jobs',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    companyId: uuid('company_id').notNull(),
    recruiterId: uuid('recruiter_id').notNull(),  // <- ADD THIS
    title: text('title').notNull(),
    slug: text('slug').notNull().unique(),
    description: text('description').notNull(),
    requirements: text('requirements'),
    responsibilities: text('responsibilities'),
    employmentType: text('employment_type').notNull(),
    workMode: text('work_mode').notNull().default('onsite'),
    experienceLevel: text('experience_level').notNull(),
    country: text('country'),
    city: text('city'),
    salaryMin: integer('salary_min'),
    salaryMax: integer('salary_max'),
    currency: text('currency').notNull().default('USD'),
    status: text('status').notNull().default('draft'),
    expiresAt: timestamp('expires_at', { withTimezone: true }),
    isActive: boolean('is_active').notNull().default(true),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    companyIdIdx: index('jobs_company_id_idx').on(table.companyId),
    recruiterIdIdx: index('jobs_recruiter_id_idx').on(table.recruiterId), // <- ADD
    slugIdx: index('jobs_slug_idx').on(table.slug),
    statusIdx: index('jobs_status_idx').on(table.status),
    employmentTypeIdx: index('jobs_employment_type_idx').on(table.employmentType),
    isActiveIdx: index('jobs_is_active_idx').on(table.isActive),
    // <- ADD FK
    recruiterFk: foreignKey({
      columns: [table.recruiterId],
      foreignColumns: [recruiters.id],
    }),
  }),
);
```

#### 1.2 Entity

File: `backend/src/jobs/entities/job.entity.ts`

```typescript
// ADD:
export class JobEntity {
  id!: string;
  companyId!: string;
  recruiterId!: string;  // <- ADD THIS
  title!: string;
  slug!: string;
  // ... rest of fields
}
```

#### 1.3 DTO - Create

File: `backend/src/jobs/dto/create-job.dto.ts`

```typescript
// BEFORE:
export class CreateJobDto {
  @IsUUID()
  companyId!: string;
  // ...
}

// AFTER:
export class CreateJobDto {
  // REMOVE @IsUUID() companyId!: string;
  // recruiterId will be extracted from authenticated user
  
  @IsString()
  @MaxLength(200)
  title!: string;
  // ... rest of fields (unchanged)
}
```

#### 1.4 Repository

File: `backend/src/jobs/repositories/jobs.repository.ts`

```typescript
// UPDATE create method:
async create(dto: CreateJobDto, recruiterId: string): Promise<JobEntity> {
  const [record] = await db
    .insert(jobs)
    .values({
      companyId: dto.companyId,
      recruiterId: recruiterId,  // <- ADD: from auth
      title: dto.title,
      slug: dto.slug,
      description: dto.description,
      requirements: dto.requirements,
      responsibilities: dto.responsibilities,
      employmentType: dto.employmentType,
      workMode: dto.workMode ?? 'onsite',
      experienceLevel: dto.experienceLevel,
      country: dto.country,
      city: dto.city,
      salaryMin: dto.salaryMin,
      salaryMax: dto.salaryMax,
      currency: dto.currency ?? 'USD',
      status: dto.status ?? 'draft',
      expiresAt: dto.expiresAt ? new Date(dto.expiresAt) : null,
      isActive: dto.isActive ?? true,
    })
    .returning();

  return record;
}
```

---

### Fix #2: Add Auth Guards & Authorization Checks

**Why**: Prevent unauthorized access to write operations

**File**: `backend/src/jobs/controllers/jobs.controller.ts`

```typescript
import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  Query,
  UseGuards,  // <- ADD
  ForbiddenException,  // <- ADD
  Request,  // <- ADD
} from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';  // <- ADD

import { CreateJobDto } from '../dto/create-job.dto';
import { JobQueryDto } from '../dto/job-query.dto';
import { JobResponseDto } from '../dto/job-response.dto';
import { UpdateJobDto } from '../dto/update-job.dto';
import { JobsService } from '../services/jobs.service';

@Controller({
  path: 'jobs',
  version: '1',
})
export class JobsController {
  constructor(private readonly jobsService: JobsService) {}

  // PUBLIC ENDPOINTS (no auth required)
  
  @Get()
  async findAll(@Query() query: JobQueryDto): Promise<JobResponseDto[]> {
    return this.jobsService.findAll(query);
  }

  @Get('slug/:slug')
  async findBySlug(@Param('slug') slug: string): Promise<JobResponseDto> {
    const record = await this.jobsService.findBySlug(slug);

    if (!record) {
      throw new NotFoundException('Job not found.');
    }

    return record;
  }

  @Get('company/:companyId')
  async findByCompanyId(
    @Param('companyId', ParseUUIDPipe) companyId: string,
  ): Promise<JobResponseDto[]> {
    return this.jobsService.findByCompanyId(companyId);
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<JobResponseDto> {
    const record = await this.jobsService.findById(id);

    if (!record) {
      throw new NotFoundException('Job not found.');
    }

    return record;
  }

  // PROTECTED ENDPOINTS (auth required)

  @Post()
  @UseGuards(JwtAuthGuard)  // <- ADD: Require authentication
  async create(
    @Body() dto: CreateJobDto,
    @Request() req,  // <- ADD: Get user from token
  ): Promise<JobResponseDto> {
    // Check if user is RECRUITER or ADMIN
    if (!['RECRUITER', 'ADMIN'].includes(req.user.role)) {
      throw new ForbiddenException(
        'Only recruiters can create jobs',
      );
    }

    // Pass recruiterId to service
    return this.jobsService.create(dto, req.user.id);
  }

  @Patch(':id')
  @UseGuards(JwtAuthGuard)  // <- ADD: Require authentication
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateJobDto,
    @Request() req,  // <- ADD: Get user from token
  ): Promise<JobResponseDto> {
    // Get the job to check ownership
    const job = await this.jobsService.findById(id);

    if (!job) {
      throw new NotFoundException('Job not found.');
    }

    // Check if user owns the job or is admin
    if (job.recruiterId !== req.user.id && req.user.role !== 'ADMIN') {
      throw new ForbiddenException(
        'You can only modify your own jobs',
      );
    }

    return this.jobsService.update(id, dto);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)  // <- ADD: Require authentication
  async remove(
    @Param('id', ParseUUIDPipe) id: string,
    @Request() req,  // <- ADD: Get user from token
  ): Promise<JobResponseDto> {
    // Get the job to check ownership
    const job = await this.jobsService.findById(id);

    if (!job) {
      throw new NotFoundException('Job not found.');
    }

    // Check if user owns the job or is admin
    if (job.recruiterId !== req.user.id && req.user.role !== 'ADMIN') {
      throw new ForbiddenException(
        'You can only delete your own jobs',
      );
    }

    return this.jobsService.remove(id);
  }
}
```

---

### Fix #3: Update Service & Response

**File**: `backend/src/jobs/services/jobs.service.ts`

```typescript
// UPDATE create method signature:
async create(dto: CreateJobDto, recruiterId: string): Promise<JobResponseDto> {
  const existing = await this.jobsRepository.findBySlug(dto.slug);

  if (existing) {
    throw new ConflictException('Job slug already exists.');
  }

  const record = await this.jobsRepository.create(dto, recruiterId);
  return JobMapper.toResponse(record);
}
```

**File**: `backend/src/jobs/dto/job-response.dto.ts`

```typescript
// ADD:
export class JobResponseDto {
  id!: string;
  companyId!: string;
  recruiterId!: string;  // <- ADD THIS
  title!: string;
  slug!: string;
  // ... rest of fields
}
```

---

## Implementation Steps

### Step 1: Create Migration
```bash
# Run this to create the migration
npm run drizzle:generate

# This should create a migration adding:
# - recruiter_id column to jobs table
# - FK constraint to recruiters table
# - Index on recruiter_id
```

### Step 2: Update Files
1. Update `jobs.schema.ts` - add recruiterId + FK
2. Update `job.entity.ts` - add recruiterId
3. Update `create-job.dto.ts` - remove companyId requirement
4. Update `job-response.dto.ts` - add recruiterId
5. Update `jobs.repository.ts` - pass recruiterId to create
6. Update `jobs.service.ts` - update create method signature
7. **Update `jobs.controller.ts`** - add guards and authorization checks

### Step 3: Apply Migration
```bash
npm run drizzle:migrate
```

### Step 4: Rebuild & Test
```bash
npm run build
npm run start:dev

# Then run tests
python backend/tests/jobs_test.py
```

---

## Verification

After fixes, these tests should pass:

```
[PASS] Cannot create job without auth (401/403)
[PASS] User cannot modify recruiter's job (401/403)
[PASS] Recruiter can create own job (201)
[PASS] Recruiter can modify own job (200)
[PASS] Recruiter cannot modify other's job (403)
```

---

## Security Checklist

After implementation:

- [ ] Auth guard on POST /jobs
- [ ] Auth guard on PATCH /jobs/:id
- [ ] Auth guard on DELETE /jobs/:id
- [ ] Role check: Only RECRUITER/ADMIN can create
- [ ] Ownership check: Can only modify own jobs
- [ ] Admin override: ADMIN can modify any job
- [ ] Database constraint: FK on recruiter_id
- [ ] Test: 401 on missing token
- [ ] Test: 403 on wrong role
- [ ] Test: 403 on wrong owner
- [ ] Database: Migration creates recruiter_id column

---

## Estimated Time

- Implementation: 45 minutes
- Testing: 30 minutes
- Debugging: 30 minutes
- **Total: ~2 hours**

---

## Questions?

If implementation is unclear:
1. Check `backend/src/auth/guards/jwt-auth.guard.ts` for guard structure
2. Check `backend/src/auth/controllers/auth.controller.ts` for example usage
3. Review Companies module for similar patterns
