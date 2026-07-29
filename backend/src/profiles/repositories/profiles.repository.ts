import { Injectable } from '@nestjs/common';
import { eq } from 'drizzle-orm';

import { db } from '../../database/database';
import { profiles } from '../../database/schema';
import { UpdateProfileDto } from '../dto/update-profile.dto';

@Injectable()
export class ProfilesRepository {
  async create(userId: string) {
    const [profile] = await db
      .insert(profiles)
      .values({
        userId,
      })
      .returning();

    return profile;
  }

  async update(userId: string, dto: UpdateProfileDto) {
    const [profile] = await db
      .update(profiles)
      .set({
        firstName: dto.firstName,
        lastName: dto.lastName,
        headline: dto.headline,
        bio: dto.bio,
        avatarUrl: dto.avatarUrl,
        country: dto.country,
        city: dto.city,
        dateOfBirth: dto.dateOfBirth ? new Date(dto.dateOfBirth) : undefined,
        updatedAt: new Date(),
      })
      .where(eq(profiles.userId, userId))
      .returning();

    return profile ?? null;
  }

  async findAll() {
    return db.select().from(profiles);
  }

  async findById(id: string) {
    const [profile] = await db
      .select()
      .from(profiles)
      .where(eq(profiles.id, id));

    return profile ?? null;
  }

  async findByUserId(userId: string) {
    const [profile] = await db
      .select()
      .from(profiles)
      .where(eq(profiles.userId, userId));

    return profile ?? null;
  }
}
