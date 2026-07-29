import { Injectable } from '@nestjs/common';
import { and, eq, SQL } from 'drizzle-orm';

import { db } from '../../database/database';
import { education } from '../../database/schema';
import { CreateEducationDto } from '../dto/create-education.dto';
import { EducationQueryDto } from '../dto/education-query.dto';
import { UpdateEducationDto } from '../dto/update-education.dto';
import { EducationEntity } from '../entities/education.entity';

@Injectable()
export class EducationRepository {
  async create(dto: CreateEducationDto): Promise<EducationEntity> {
    const [record] = await db
      .insert(education)
      .values({
        careerProfileId: dto.careerProfileId,
        institution: dto.institution,
        college: dto.college,
        degree: dto.degree,
        fieldOfStudy: dto.fieldOfStudy,
        grade: dto.grade,
        gradeType: dto.gradeType,
        country: dto.country,
        city: dto.city,
        description: dto.description,
        startDate: new Date(dto.startDate),
        endDate: dto.endDate ? new Date(dto.endDate) : null,
        isCurrent: dto.isCurrent ?? false,
      })
      .returning();

    return record;
  }

  async update(
    id: string,
    dto: UpdateEducationDto,
  ): Promise<EducationEntity | null> {
    const updateData: Record<string, unknown> = { updatedAt: new Date() };

    if (dto.institution !== undefined) updateData.institution = dto.institution;
    if (dto.college !== undefined) updateData.college = dto.college;
    if (dto.degree !== undefined) updateData.degree = dto.degree;
    if (dto.fieldOfStudy !== undefined)
      updateData.fieldOfStudy = dto.fieldOfStudy;
    if (dto.grade !== undefined) updateData.grade = dto.grade;
    if (dto.gradeType !== undefined) updateData.gradeType = dto.gradeType;
    if (dto.country !== undefined) updateData.country = dto.country;
    if (dto.city !== undefined) updateData.city = dto.city;
    if (dto.description !== undefined) updateData.description = dto.description;
    if (dto.startDate !== undefined)
      updateData.startDate = new Date(dto.startDate);
    if (dto.endDate !== undefined) updateData.endDate = new Date(dto.endDate);
    if (dto.isCurrent !== undefined) updateData.isCurrent = dto.isCurrent;

    const [record] = await db
      .update(education)
      .set(updateData)
      .where(eq(education.id, id))
      .returning();

    return record ?? null;
  }

  async findAll(query?: EducationQueryDto): Promise<EducationEntity[]> {
    const filters: SQL[] = [];

    if (query?.careerProfileId) {
      filters.push(eq(education.careerProfileId, query.careerProfileId));
    }

    if (query?.degree) {
      filters.push(eq(education.degree, query.degree));
    }

    if (query?.fieldOfStudy) {
      filters.push(eq(education.fieldOfStudy, query.fieldOfStudy));
    }

    if (query?.isCurrent !== undefined) {
      filters.push(eq(education.isCurrent, query.isCurrent));
    }

    return filters.length > 0
      ? db
          .select()
          .from(education)
          .where(and(...filters))
      : db.select().from(education);
  }

  async findById(id: string): Promise<EducationEntity | null> {
    const [record] = await db
      .select()
      .from(education)
      .where(eq(education.id, id));

    return record ?? null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<EducationEntity[]> {
    return db
      .select()
      .from(education)
      .where(eq(education.careerProfileId, careerProfileId));
  }

  async remove(id: string): Promise<EducationEntity | null> {
    const [record] = await db
      .delete(education)
      .where(eq(education.id, id))
      .returning();

    return record ?? null;
  }
}
