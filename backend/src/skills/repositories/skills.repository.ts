import { Injectable } from '@nestjs/common';
import { and, eq, SQL } from 'drizzle-orm';

import { db } from '../../database/database';
import { skills } from '../../database/schema';
import { CreateSkillDto } from '../dto/create-skill.dto';
import { SkillQueryDto } from '../dto/skill-query.dto';
import { UpdateSkillDto } from '../dto/update-skill.dto';
import { SkillEntity } from '../entities/skill.entity';

@Injectable()
export class SkillsRepository {
  async create(dto: CreateSkillDto): Promise<SkillEntity> {
    const [skill] = await db
      .insert(skills)
      .values({
        careerProfileId: dto.careerProfileId,
        name: dto.name,
        category: dto.category,
        level: dto.level,
        yearsOfExperience: dto.yearsOfExperience,
        verified: dto.verified ?? false,
      })
      .returning();

    return skill;
  }

  async update(id: string, dto: UpdateSkillDto): Promise<SkillEntity | null> {
    const updateData: Partial<SkillEntity> & { updatedAt: Date } = {
      updatedAt: new Date(),
    };

    if (dto.name !== undefined) {
      updateData.name = dto.name;
    }

    if (dto.category !== undefined) {
      updateData.category = dto.category;
    }

    if (dto.level !== undefined) {
      updateData.level = dto.level;
    }

    if (dto.yearsOfExperience !== undefined) {
      updateData.yearsOfExperience = dto.yearsOfExperience;
    }

    if (dto.verified !== undefined) {
      updateData.verified = dto.verified;
    }

    const [skill] = await db
      .update(skills)
      .set(updateData)
      .where(eq(skills.id, id))
      .returning();

    return skill ?? null;
  }

  async findAll(query?: SkillQueryDto): Promise<SkillEntity[]> {
    const filters: SQL[] = [];

    if (query?.name) {
      filters.push(eq(skills.name, query.name));
    }

    if (query?.category) {
      filters.push(eq(skills.category, query.category));
    }

    if (query?.level) {
      filters.push(eq(skills.level, query.level));
    }

    if (query?.careerProfileId) {
      filters.push(eq(skills.careerProfileId, query.careerProfileId));
    }

    if (filters.length > 0) {
      return db
        .select()
        .from(skills)
        .where(and(...filters));
    }

    return db.select().from(skills);
  }

  async findById(id: string): Promise<SkillEntity | null> {
    const [skill] = await db.select().from(skills).where(eq(skills.id, id));

    return skill ?? null;
  }

  async findByCareerProfileId(careerProfileId: string): Promise<SkillEntity[]> {
    return db
      .select()
      .from(skills)
      .where(eq(skills.careerProfileId, careerProfileId));
  }

  async remove(id: string): Promise<SkillEntity | null> {
    const [skill] = await db
      .delete(skills)
      .where(eq(skills.id, id))
      .returning();

    return skill ?? null;
  }
}
