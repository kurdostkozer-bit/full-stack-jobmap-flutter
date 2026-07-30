import { Injectable } from '@nestjs/common';
import { eq, and, desc } from 'drizzle-orm';
import { db } from '../../database/database';
import { notifications } from '../../database/schema';
import { NotificationEntity } from '../entities/notification.entity';
import { CreateNotificationDto } from '../dto/create-notification.dto';

@Injectable()
export class NotificationsRepository {
  async create(dto: CreateNotificationDto): Promise<NotificationEntity> {
    const [notification] = await db
      .insert(notifications)
      .values({
        userId: dto.userId,
        type: dto.type,
        title: dto.title,
        message: dto.message,
        data: dto.data || null,
      })
      .returning();

    return this.mapToEntity(notification);
  }

  async findById(id: string): Promise<NotificationEntity | null> {
    const [notification] = await db
      .select()
      .from(notifications)
      .where(eq(notifications.id, id))
      .limit(1);

    return notification ? this.mapToEntity(notification) : null;
  }

  async findByUserId(userId: string, limit: number = 50, offset: number = 0): Promise<NotificationEntity[]> {
    const notifs = await db
      .select()
      .from(notifications)
      .where(eq(notifications.userId, userId))
      .orderBy(desc(notifications.createdAt))
      .limit(limit)
      .offset(offset);

    return notifs.map(this.mapToEntity);
  }

  async findUnreadByUserId(userId: string): Promise<NotificationEntity[]> {
    const notifs = await db
      .select()
      .from(notifications)
      .where(
        and(
          eq(notifications.userId, userId),
          eq(notifications.isRead, false),
        ),
      )
      .orderBy(desc(notifications.createdAt));

    return notifs.map(this.mapToEntity);
  }

  async markAsRead(id: string): Promise<NotificationEntity | null> {
    const [updated] = await db
      .update(notifications)
      .set({
        isRead: true,
        readAt: new Date(),
        updatedAt: new Date(),
      })
      .where(eq(notifications.id, id))
      .returning();

    return updated ? this.mapToEntity(updated) : null;
  }

  async markAllAsRead(userId: string): Promise<void> {
    await db
      .update(notifications)
      .set({
        isRead: true,
        readAt: new Date(),
        updatedAt: new Date(),
      })
      .where(
        and(
          eq(notifications.userId, userId),
          eq(notifications.isRead, false),
        ),
      );
  }

  async delete(id: string): Promise<NotificationEntity | null> {
    const [deleted] = await db
      .delete(notifications)
      .where(eq(notifications.id, id))
      .returning();

    return deleted ? this.mapToEntity(deleted) : null;
  }

  async deleteAllByUserId(userId: string): Promise<void> {
    await db.delete(notifications).where(eq(notifications.userId, userId));
  }

  async getUnreadCount(userId: string): Promise<number> {
    const result = await db
      .select({ count: notifications.id })
      .from(notifications)
      .where(
        and(
          eq(notifications.userId, userId),
          eq(notifications.isRead, false),
        ),
      );

    return result.length;
  }

  private mapToEntity(record: any): NotificationEntity {
    return {
      id: record.id,
      userId: record.userId,
      type: record.type,
      title: record.title,
      message: record.message,
      data: record.data,
      isRead: record.isRead,
      readAt: record.readAt,
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    };
  }
}
