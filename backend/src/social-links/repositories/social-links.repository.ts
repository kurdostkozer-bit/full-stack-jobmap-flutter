import { Injectable } from '@nestjs/common';
import { and, asc, desc, eq, SQL } from 'drizzle-orm';

import { db } from '../../database/database';
import { socialLinks } from '../../database/schema';
import { CreateSocialLinkDto } from '../dto/create-social-link.dto';
import { SocialLinkQueryDto } from '../dto/social-link-query.dto';
import { UpdateSocialLinkDto } from '../dto/update-social-link.dto';
import { SocialLinkEntity } from '../entities/social-link.entity';

@Injectable()
export class SocialLinksRepository {
  async create(dto: CreateSocialLinkDto): Promise<SocialLinkEntity> {
    const [record] = await db
      .insert(socialLinks)
      .values({
        careerProfileId: dto.careerProfileId,
        platform: dto.platform,
        url: dto.url,
        displayName: dto.displayName ?? null,
        visibility: dto.visibility ?? 'PUBLIC',
        displayOrder: dto.displayOrder ?? 0,
      })
      .returning();

    return record;
  }

  async update(
    id: string,
    dto: UpdateSocialLinkDto,
  ): Promise<SocialLinkEntity | null> {
    const updateData: Record<string, unknown> = { updatedAt: new Date() };

    if (dto.url !== undefined) updateData.url = dto.url;
    if (dto.displayName !== undefined) updateData.displayName = dto.displayName;
    if (dto.visibility !== undefined) updateData.visibility = dto.visibility;
    if (dto.displayOrder !== undefined)
      updateData.displayOrder = dto.displayOrder;

    const [record] = await db
      .update(socialLinks)
      .set(updateData)
      .where(eq(socialLinks.id, id))
      .returning();

    return record ? record : null;
  }

  async findAll(query?: SocialLinkQueryDto): Promise<SocialLinkEntity[]> {
    const filters: SQL[] = [];

    if (query?.careerProfileId) {
      filters.push(eq(socialLinks.careerProfileId, query.careerProfileId));
    }

    if (query?.platform) {
      filters.push(eq(socialLinks.platform, query.platform));
    }

    if (query?.visibility) {
      filters.push(eq(socialLinks.visibility, query.visibility));
    }

    const sortColumn = this.resolveSortColumn(query?.sortBy);
    const orderFn = query?.sortOrder === 'desc' ? desc : asc;

    const page = query?.page ?? 1;
    const limit = query?.limit ?? 20;
    const offset = (page - 1) * limit;

    const baseQuery = db.select().from(socialLinks);
    const filtered =
      filters.length > 0 ? baseQuery.where(and(...filters)) : baseQuery;

    const rows = await filtered
      .orderBy(orderFn(sortColumn))
      .limit(limit)
      .offset(offset);

    return rows;
  }

  async findById(id: string): Promise<SocialLinkEntity | null> {
    const [record] = await db
      .select()
      .from(socialLinks)
      .where(eq(socialLinks.id, id));

    return record ? record : null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<SocialLinkEntity[]> {
    const rows = await db
      .select()
      .from(socialLinks)
      .where(eq(socialLinks.careerProfileId, careerProfileId))
      .orderBy(asc(socialLinks.displayOrder));

    return rows;
  }

  async findByCareerProfileIdAndPlatform(
    careerProfileId: string,
    platform: string,
  ): Promise<SocialLinkEntity | null> {
    const [record] = await db
      .select()
      .from(socialLinks)
      .where(
        and(
          eq(socialLinks.careerProfileId, careerProfileId),
          eq(
            socialLinks.platform,
            platform as
              | 'LINKEDIN'
              | 'GITHUB'
              | 'GITLAB'
              | 'STACKOVERFLOW'
              | 'BEHANCE'
              | 'DRIBBBLE'
              | 'PERSONAL_WEBSITE'
              | 'X'
              | 'FACEBOOK'
              | 'INSTAGRAM'
              | 'YOUTUBE'
              | 'TELEGRAM',
          ),
        ),
      );

    return record ? record : null;
  }

  async remove(id: string): Promise<SocialLinkEntity | null> {
    const [record] = await db
      .delete(socialLinks)
      .where(eq(socialLinks.id, id))
      .returning();

    return record ? record : null;
  }

  private resolveSortColumn(sortBy?: string) {
    switch (sortBy) {
      case 'platform':
        return socialLinks.platform;
      case 'displayOrder':
        return socialLinks.displayOrder;
      case 'visibility':
        return socialLinks.visibility;
      case 'updatedAt':
        return socialLinks.updatedAt;
      default:
        return socialLinks.createdAt;
    }
  }
}
