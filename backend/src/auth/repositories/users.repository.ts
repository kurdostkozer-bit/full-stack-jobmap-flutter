import { Injectable } from '@nestjs/common';
import { eq } from 'drizzle-orm';

import { db } from '../../database/database';
import { users } from '../../database/schema';

@Injectable()
export class UsersRepository {
  async findByEmail(email: string) {
    const result = await db
      .select()
      .from(users)
      .where(eq(users.email, email))
      .limit(1);

    return result[0] ?? null;
  }

  async findById(id: string) {
    const result = await db
      .select()
      .from(users)
      .where(eq(users.id, id))
      .limit(1);

    return result[0] ?? null;
  }

  async findByGoogleId(googleId: string) {
    const result = await db
      .select()
      .from(users)
      .where(eq(users.googleId, googleId))
      .limit(1);

    return result[0] ?? null;
  }

  async create(data: { email: string; passwordHash: string }) {
    const [user] = await db
      .insert(users)
      .values({
        email: data.email,
        passwordHash: data.passwordHash,
        provider: 'local',
      })
      .returning();

    return user;
  }

  async createFromGoogle(data: {
    email: string;
    googleId: string;
    googleEmail: string;
    fullName: string;
    profileImage?: string;
  }) {
    const [user] = await db
      .insert(users)
      .values({
        email: data.email,
        googleId: data.googleId,
        googleEmail: data.googleEmail,
        profileImage: data.profileImage,
        isEmailVerified: true,
        provider: 'google',
      })
      .returning();

    return user;
  }

  async linkGoogleId(
    userId: string,
    googleId: string,
    googleEmail: string,
    profileImage?: string,
  ) {
    const [user] = await db
      .update(users)
      .set({
        googleId,
        googleEmail,
        profileImage,
        provider: 'google',
        updatedAt: new Date(),
      })
      .where(eq(users.id, userId))
      .returning();

    return user;
  }

  async update(id: string, data: Partial<{ isEmailVerified: boolean }>) {
    const [user] = await db
      .update(users)
      .set({
        ...data,
        updatedAt: new Date(),
      })
      .where(eq(users.id, id))
      .returning();

    return user;
  }

  async updatePasswordHash(id: string, passwordHash: string) {
    const [user] = await db
      .update(users)
      .set({
        passwordHash,
        updatedAt: new Date(),
      })
      .where(eq(users.id, id))
      .returning();

    return user;
  }
}
