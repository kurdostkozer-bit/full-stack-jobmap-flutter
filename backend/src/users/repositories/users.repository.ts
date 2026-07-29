import { Injectable } from '@nestjs/common';
import { eq } from 'drizzle-orm';

import { db } from '../../database/database';
import { users } from '../../database/schema';

@Injectable()
export class UsersRepository {
  async findById(id: string) {
    const result = await db
      .select()
      .from(users)
      .where(eq(users.id, id))
      .limit(1);

    return result[0] ?? null;
  }

  async findByEmail(email: string) {
    const result = await db
      .select()
      .from(users)
      .where(eq(users.email, email))
      .limit(1);

    return result[0] ?? null;
  }

  async findAll() {
    return db.select().from(users);
  }
}
