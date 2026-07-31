import { Injectable } from '@nestjs/common';
import { and, eq, SQLWrapper } from 'drizzle-orm';

import { db } from '../../database/database';
import { careerProfiles } from '../../database/schema';
import { CreateCareerProfileDto } from '../dto/create-career-profile.dto';
import { CareerProfileQueryDto } from '../dto/career-profile-query.dto';
import { UpdateCareerProfileDto } from '../dto/update-career-profile.dto';
import { CareerProfileEntity } from '../entities/career-profile.entity';

@Injectable()
export class CareerProfilesRepository {
  async create(
    userId: string,
    dto: CreateCareerProfileDto,
  ): Promise<CareerProfileEntity> {
    try {
      const [profile] = await db
        .insert(careerProfiles)
        .values({
          userId,
          headline: dto.headline ?? null,
          summary: dto.summary ?? null,
          professionTitle: dto.professionTitle ?? null,
          location: dto.location ?? null,
          preferredJobTitles: dto.preferredJobTitles ?? null,
          preferredIndustries: dto.preferredIndustries ?? null,
          salaryMin: dto.salaryMin ?? null,
          salaryMax: dto.salaryMax ?? null,
          currency: dto.currency ?? 'USD',
          workPreference: dto.workPreference ?? 'any',
          remotePreference: dto.remotePreference ?? 'hybrid',
          relocationPreference: dto.relocationPreference ?? 'open',
          profileStatus: dto.profileStatus ?? 'draft',
          privacyLevel: dto.privacyLevel ?? 'private',
          isPublic: dto.isPublic ?? false,
          resumeUrl: dto.resumeUrl ?? null,
          profileCompletion: 0,
        })
        .returning();

      return profile;
    } catch (error: any) {
      console.error('CareerProfilesRepository.create() - Database error:', {
        code: error.code,
        message: error.message,
        detail: error.detail,
        sqlState: error.sqlState,
      });
      throw error;
    }
  }

  async update(
    id: string,
    dto: UpdateCareerProfileDto,
  ): Promise<CareerProfileEntity | null> {
    const updateData: Partial<CareerProfileEntity> & { updatedAt: Date } = {
      updatedAt: new Date(),
    };

    if (dto.headline !== undefined) updateData.headline = dto.headline;
    if (dto.summary !== undefined) updateData.summary = dto.summary;
    if (dto.professionTitle !== undefined)
      updateData.professionTitle = dto.professionTitle;
    if (dto.location !== undefined) updateData.location = dto.location;
    if (dto.preferredJobTitles !== undefined)
      updateData.preferredJobTitles = dto.preferredJobTitles;
    if (dto.preferredIndustries !== undefined)
      updateData.preferredIndustries = dto.preferredIndustries;
    if (dto.salaryMin !== undefined) updateData.salaryMin = dto.salaryMin;
    if (dto.salaryMax !== undefined) updateData.salaryMax = dto.salaryMax;
    if (dto.currency !== undefined) updateData.currency = dto.currency;
    if (dto.workPreference !== undefined)
      updateData.workPreference = dto.workPreference;
    if (dto.remotePreference !== undefined)
      updateData.remotePreference = dto.remotePreference;
    if (dto.relocationPreference !== undefined)
      updateData.relocationPreference = dto.relocationPreference;
    if (dto.profileStatus !== undefined)
      updateData.profileStatus = dto.profileStatus;
    if (dto.privacyLevel !== undefined)
      updateData.privacyLevel = dto.privacyLevel;
    if (dto.isPublic !== undefined) updateData.isPublic = dto.isPublic;
    if (dto.resumeUrl !== undefined) updateData.resumeUrl = dto.resumeUrl;

    const [profile] = await db
      .update(careerProfiles)
      .set(updateData)
      .where(eq(careerProfiles.id, id))
      .returning();

    return profile ?? null;
  }

  async findAll(query?: CareerProfileQueryDto): Promise<CareerProfileEntity[]> {
    const filters: SQLWrapper[] = [eq(careerProfiles.isDeleted, false)];

    if (query?.profileStatus) {
      filters.push(eq(careerProfiles.profileStatus, query.profileStatus));
    }

    if (query?.privacyLevel) {
      filters.push(eq(careerProfiles.privacyLevel, query.privacyLevel));
    }

    if (query?.userId) {
      filters.push(eq(careerProfiles.userId, query.userId));
    }

    return db
      .select()
      .from(careerProfiles)
      .where(and(...filters));
  }

  async findById(id: string): Promise<CareerProfileEntity | null> {
    const [profile] = await db
      .select()
      .from(careerProfiles)
      .where(
        and(eq(careerProfiles.id, id), eq(careerProfiles.isDeleted, false)),
      );

    return profile ?? null;
  }

  async findByUserId(userId: string): Promise<CareerProfileEntity | null> {
    const [profile] = await db
      .select()
      .from(careerProfiles)
      .where(
        and(
          eq(careerProfiles.userId, userId),
          eq(careerProfiles.isDeleted, false),
        ),
      );

    return profile ?? null;
  }

  async remove(id: string): Promise<CareerProfileEntity | null> {
    const [profile] = await db
      .update(careerProfiles)
      .set({
        isDeleted: true,
        deletedAt: new Date(),
        updatedAt: new Date(),
      })
      .where(eq(careerProfiles.id, id))
      .returning();

    return profile ?? null;
  }
}
