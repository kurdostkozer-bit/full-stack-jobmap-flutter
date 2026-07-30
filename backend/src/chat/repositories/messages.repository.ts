import { Injectable } from '@nestjs/common';
import { eq, desc, isNull } from 'drizzle-orm';
import { db } from '../../database/database';
import { messages } from '../../database/schema';
import { MessageEntity } from '../entities/message.entity';
import { CreateMessageDto } from '../dto/create-message.dto';

@Injectable()
export class MessagesRepository {
  async create(dto: CreateMessageDto): Promise<MessageEntity> {
    const [message] = await db
      .insert(messages)
      .values({
        conversationId: dto.conversationId,
        senderId: dto.senderId,
        content: dto.content,
        attachmentUrl: dto.attachmentUrl,
      })
      .returning();

    return this.mapToEntity(message);
  }

  async findById(id: string): Promise<MessageEntity | null> {
    const [message] = await db
      .select()
      .from(messages)
      .where(eq(messages.id, id))
      .limit(1);

    return message ? this.mapToEntity(message) : null;
  }

  async findByConversationId(
    conversationId: string,
    limit: number = 50,
    offset: number = 0,
  ): Promise<MessageEntity[]> {
    const msgs = await db
      .select()
      .from(messages)
      .where(
        eq(messages.conversationId, conversationId),
      )
      .orderBy(desc(messages.createdAt))
      .limit(limit)
      .offset(offset);

    return msgs.map(this.mapToEntity);
  }

  async update(
    id: string,
    content: string,
  ): Promise<MessageEntity | null> {
    const [updated] = await db
      .update(messages)
      .set({
        content,
        isEdited: true,
        editedAt: new Date(),
        updatedAt: new Date(),
      })
      .where(eq(messages.id, id))
      .returning();

    return updated ? this.mapToEntity(updated) : null;
  }

  async softDelete(id: string): Promise<MessageEntity | null> {
    const [deleted] = await db
      .update(messages)
      .set({
        deletedAt: new Date(),
        updatedAt: new Date(),
      })
      .where(eq(messages.id, id))
      .returning();

    return deleted ? this.mapToEntity(deleted) : null;
  }

  async delete(id: string): Promise<MessageEntity | null> {
    const [deleted] = await db
      .delete(messages)
      .where(eq(messages.id, id))
      .returning();

    return deleted ? this.mapToEntity(deleted) : null;
  }

  private mapToEntity(record: any): MessageEntity {
    return {
      id: record.id,
      conversationId: record.conversationId,
      senderId: record.senderId,
      content: record.content,
      attachmentUrl: record.attachmentUrl,
      isEdited: record.isEdited,
      editedAt: record.editedAt,
      deletedAt: record.deletedAt,
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    };
  }
}
