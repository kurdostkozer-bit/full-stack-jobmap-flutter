import { Injectable } from '@nestjs/common';
import { and, asc, desc, eq, ilike, SQL } from 'drizzle-orm';

import { db } from '../../database/database';
import { languages } from '../../database/schema';
import { CreateLanguageDto } from '../dto/create-language.dto';
import { LanguageQueryDto } from '../dto/language-query.dto';
import { UpdateLanguageDto } from '../dto/update-language.dto';
import { LanguageEntity } from '../entities/language.entity';

type ProficiencyLevel =
  'NATIVE' | 'FLUENT' | 'ADVANCED' | 'INTERMEDIATE' | 'BASIC';
type SkillLevel = 'EXCELLENT' | 'GOOD' | 'FAIR' | 'POOR';

@Injectable()
export class LanguagesRepository {
  async create(dto: CreateLanguageDto): Promise<LanguageEntity> {
    const [record] = await db
      .insert(languages)
      .values({
        careerProfileId: dto.careerProfileId,
        language: dto.language,
        proficiencyLevel: dto.proficiencyLevel as ProficiencyLevel,
        readingLevel: dto.readingLevel as SkillLevel,
        writingLevel: dto.writingLevel as SkillLevel,
        speakingLevel: dto.speakingLevel as SkillLevel,
        isPrimary: dto.isPrimary ?? false,
      })
      .returning();

    return record;
  }

  async update(
    id: string,
    dto: UpdateLanguageDto,
  ): Promise<LanguageEntity | null> {
    const updateData: Record<string, unknown> = { updatedAt: new Date() };

    if (dto.language !== undefined) updateData.language = dto.language;
    if (dto.proficiencyLevel !== undefined)
      updateData.proficiencyLevel = dto.proficiencyLevel;
    if (dto.readingLevel !== undefined)
      updateData.readingLevel = dto.readingLevel;
    if (dto.writingLevel !== undefined)
      updateData.writingLevel = dto.writingLevel;
    if (dto.speakingLevel !== undefined)
      updateData.speakingLevel = dto.speakingLevel;
    if (dto.isPrimary !== undefined) updateData.isPrimary = dto.isPrimary;

    const [record] = await db
      .update(languages)
      .set(updateData)
      .where(eq(languages.id, id))
      .returning();

    return record ? record : null;
  }

  async findAll(query?: LanguageQueryDto): Promise<LanguageEntity[]> {
    const filters: SQL[] = [];

    if (query?.careerProfileId) {
      filters.push(eq(languages.careerProfileId, query.careerProfileId));
    }

    if (query?.proficiencyLevel) {
      filters.push(
        eq(
          languages.proficiencyLevel,
          query.proficiencyLevel as ProficiencyLevel,
        ),
      );
    }

    if (query?.readingLevel) {
      filters.push(
        eq(languages.readingLevel, query.readingLevel as SkillLevel),
      );
    }

    if (query?.writingLevel) {
      filters.push(
        eq(languages.writingLevel, query.writingLevel as SkillLevel),
      );
    }

    if (query?.speakingLevel) {
      filters.push(
        eq(languages.speakingLevel, query.speakingLevel as SkillLevel),
      );
    }

    if (query?.isPrimary !== undefined) {
      filters.push(eq(languages.isPrimary, query.isPrimary));
    }

    if (query?.search) {
      filters.push(ilike(languages.language, `%${query.search}%`));
    }

    const sortColumn = this.resolveSortColumn(query?.sortBy);
    const orderFn = query?.sortOrder === 'desc' ? desc : asc;

    const page = query?.page ?? 1;
    const limit = query?.limit ?? 20;
    const offset = (page - 1) * limit;

    const baseQuery = db.select().from(languages);
    const filtered =
      filters.length > 0 ? baseQuery.where(and(...filters)) : baseQuery;

    const rows = await filtered
      .orderBy(orderFn(sortColumn))
      .limit(limit)
      .offset(offset);
    return rows;
  }

  async findById(id: string): Promise<LanguageEntity | null> {
    const [record] = await db
      .select()
      .from(languages)
      .where(eq(languages.id, id));

    return record ? record : null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<LanguageEntity[]> {
    const rows = await db
      .select()
      .from(languages)
      .where(eq(languages.careerProfileId, careerProfileId))
      .orderBy(desc(languages.isPrimary), asc(languages.language));

    return rows;
  }

  async remove(id: string): Promise<LanguageEntity | null> {
    const [record] = await db
      .delete(languages)
      .where(eq(languages.id, id))
      .returning();

    return record ? record : null;
  }

  private resolveSortColumn(sortBy?: string) {
    switch (sortBy) {
      case 'language':
        return languages.language;
      case 'proficiencyLevel':
        return languages.proficiencyLevel;
      case 'updatedAt':
        return languages.updatedAt;
      default:
        return languages.createdAt;
    }
  }
}
