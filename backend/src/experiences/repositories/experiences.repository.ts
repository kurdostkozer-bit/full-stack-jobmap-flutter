import { Injectable } from '@nestjs/common';
import { and, eq, SQL } from 'drizzle-orm';

import { db } from '../../database/database';
import { experiences } from '../../database/schema';
import { CreateExperienceDto } from '../dto/create-experience.dto';
import { ExperienceQueryDto } from '../dto/experience-query.dto';
import { UpdateExperienceDto } from '../dto/update-experience.dto';
import { ExperienceEntity } from '../entities/experience.entity';

@Injectable()
export class ExperiencesRepository {
  async create(dto: CreateExperienceDto): Promise<ExperienceEntity> {
    const [experience] = await db
      .insert(experiences)
      .values({
        careerProfileId: dto.careerProfileId,
        jobTitle: dto.jobTitle,
        companyName: dto.companyName,
        employmentType: dto.employmentType,
        location: dto.location,
        description: dto.description,
        startDate: new Date(dto.startDate),
        endDate: dto.endDate ? new Date(dto.endDate) : null,
        isCurrent: dto.isCurrent ?? false,
        sortOrder: dto.sortOrder ?? 0,
      })
      .returning();

    return experience;
  }

  async update(
    id: string,
    dto: UpdateExperienceDto,
  ): Promise<ExperienceEntity | null> {
    const updateData: Record<string, unknown> = { updatedAt: new Date() };

    if (dto.jobTitle !== undefined) updateData.jobTitle = dto.jobTitle;
    if (dto.companyName !== undefined) updateData.companyName = dto.companyName;
    if (dto.employmentType !== undefined)
      updateData.employmentType = dto.employmentType;
    if (dto.location !== undefined) updateData.location = dto.location;
    if (dto.description !== undefined) updateData.description = dto.description;
    if (dto.startDate !== undefined)
      updateData.startDate = new Date(dto.startDate);
    if (dto.endDate !== undefined) updateData.endDate = new Date(dto.endDate);
    if (dto.isCurrent !== undefined) updateData.isCurrent = dto.isCurrent;
    if (dto.sortOrder !== undefined) updateData.sortOrder = dto.sortOrder;

    const [experience] = await db
      .update(experiences)
      .set(updateData)
      .where(eq(experiences.id, id))
      .returning();

    return experience ?? null;
  }

  async findAll(query?: ExperienceQueryDto): Promise<ExperienceEntity[]> {
    const filters: SQL[] = [];

    if (query?.careerProfileId) {
      filters.push(eq(experiences.careerProfileId, query.careerProfileId));
    }

    if (query?.employmentType) {
      filters.push(eq(experiences.employmentType, query.employmentType));
    }

    if (query?.isCurrent !== undefined) {
      filters.push(eq(experiences.isCurrent, query.isCurrent));
    }

    return filters.length > 0
      ? db
          .select()
          .from(experiences)
          .where(and(...filters))
      : db.select().from(experiences);
  }

  async findById(id: string): Promise<ExperienceEntity | null> {
    const [experience] = await db
      .select()
      .from(experiences)
      .where(eq(experiences.id, id));

    return experience ?? null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<ExperienceEntity[]> {
    return db
      .select()
      .from(experiences)
      .where(eq(experiences.careerProfileId, careerProfileId));
  }

  async remove(id: string): Promise<ExperienceEntity | null> {
    const [experience] = await db
      .delete(experiences)
      .where(eq(experiences.id, id))
      .returning();

    return experience ?? null;
  }
}
