import { Injectable } from '@nestjs/common';
import { and, eq, SQL } from 'drizzle-orm';

import { db } from '../../database/database';
import { jobs } from '../../database/schema';
import { CreateJobDto } from '../dto/create-job.dto';
import { JobQueryDto } from '../dto/job-query.dto';
import { UpdateJobDto } from '../dto/update-job.dto';
import { JobEntity } from '../entities/job.entity';

@Injectable()
export class JobsRepository {
  async create(dto: CreateJobDto): Promise<JobEntity> {
    const [record] = await db
      .insert(jobs)
      .values({
        companyId: dto.companyId,
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

  async update(id: string, dto: UpdateJobDto): Promise<JobEntity | null> {
    const updateData: Record<string, unknown> = { updatedAt: new Date() };

    if (dto.title !== undefined) updateData.title = dto.title;
    if (dto.slug !== undefined) updateData.slug = dto.slug;
    if (dto.description !== undefined) updateData.description = dto.description;
    if (dto.requirements !== undefined)
      updateData.requirements = dto.requirements;
    if (dto.responsibilities !== undefined)
      updateData.responsibilities = dto.responsibilities;
    if (dto.employmentType !== undefined)
      updateData.employmentType = dto.employmentType;
    if (dto.workMode !== undefined) updateData.workMode = dto.workMode;
    if (dto.experienceLevel !== undefined)
      updateData.experienceLevel = dto.experienceLevel;
    if (dto.country !== undefined) updateData.country = dto.country;
    if (dto.city !== undefined) updateData.city = dto.city;
    if (dto.salaryMin !== undefined) updateData.salaryMin = dto.salaryMin;
    if (dto.salaryMax !== undefined) updateData.salaryMax = dto.salaryMax;
    if (dto.currency !== undefined) updateData.currency = dto.currency;
    if (dto.status !== undefined) updateData.status = dto.status;
    if (dto.expiresAt !== undefined)
      updateData.expiresAt = new Date(dto.expiresAt);
    if (dto.isActive !== undefined) updateData.isActive = dto.isActive;

    const [record] = await db
      .update(jobs)
      .set(updateData)
      .where(eq(jobs.id, id))
      .returning();

    return record ?? null;
  }

  async findAll(query?: JobQueryDto): Promise<JobEntity[]> {
    const filters: SQL[] = [];

    if (query?.companyId) filters.push(eq(jobs.companyId, query.companyId));
    if (query?.employmentType)
      filters.push(eq(jobs.employmentType, query.employmentType));
    if (query?.workMode) filters.push(eq(jobs.workMode, query.workMode));
    if (query?.experienceLevel)
      filters.push(eq(jobs.experienceLevel, query.experienceLevel));
    if (query?.country) filters.push(eq(jobs.country, query.country));
    if (query?.status) filters.push(eq(jobs.status, query.status));
    if (query?.isActive !== undefined)
      filters.push(eq(jobs.isActive, query.isActive));

    return filters.length > 0
      ? db
          .select()
          .from(jobs)
          .where(and(...filters))
      : db.select().from(jobs);
  }

  async findById(id: string): Promise<JobEntity | null> {
    const [record] = await db.select().from(jobs).where(eq(jobs.id, id));
    return record ?? null;
  }

  async findBySlug(slug: string): Promise<JobEntity | null> {
    const [record] = await db.select().from(jobs).where(eq(jobs.slug, slug));
    return record ?? null;
  }

  async findByCompanyId(companyId: string): Promise<JobEntity[]> {
    return db.select().from(jobs).where(eq(jobs.companyId, companyId));
  }

  async remove(id: string): Promise<JobEntity | null> {
    const [record] = await db.delete(jobs).where(eq(jobs.id, id)).returning();
    return record ?? null;
  }
}
