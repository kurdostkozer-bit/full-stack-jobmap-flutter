import { Injectable } from '@nestjs/common';
import { eq } from 'drizzle-orm';

import { db } from '../../database/database';
import { profiles } from '../../database/schema';

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

  async findByUserId(userId: string) {
    const result = await db
      .select()
      .from(profiles)
      .where(eq(profiles.userId, userId))
      .limit(1);

    return result[0] ?? null;
  }

  async findById(id: string) {
    const result = await db
      .select()
      .from(profiles)
      .where(eq(profiles.id, id))
      .limit(1);

    return result[0] ?? null;
  }

  async update(userId: string, data: any) {
    const [profile] = await db
      .update(profiles)
      .set({
        ...data,
        updatedAt: new Date(),
      })
      .where(eq(profiles.userId, userId))
      .returning();

    return profile;
  }
}
