import { Injectable } from '@nestjs/common';
import { eq, desc } from 'drizzle-orm';
import { db } from '../../database/database';
import { conversations } from '../../database/schema';
import { ConversationEntity } from '../entities/conversation.entity';
import { CreateConversationDto } from '../dto/create-conversation.dto';

@Injectable()
export class ConversationsRepository {
  async create(dto: CreateConversationDto): Promise<ConversationEntity> {
    const [conversation] = await db
      .insert(conversations)
      .values({
        participantIds: JSON.stringify(dto.participantIds) as any,
        title: dto.title,
      })
      .returning();

    return this.mapToEntity(conversation);
  }

  async findById(id: string): Promise<ConversationEntity | null> {
    const [conversation] = await db
      .select()
      .from(conversations)
      .where(eq(conversations.id, id))
      .limit(1);

    return conversation ? this.mapToEntity(conversation) : null;
  }

  async findByParticipantId(userId: string, limit: number = 50): Promise<ConversationEntity[]> {
    // This query will need raw SQL since we're querying JSON arrays
    const convos = await db
      .select()
      .from(conversations)
      .where(eq(conversations.isActive, true))
      .orderBy(desc(conversations.lastMessageAt))
      .limit(limit);

    // Filter in application layer (normally you'd use PostgreSQL's JSON operators)
    return convos
      .filter((c) => {
        try {
          // Safe JSON parsing with fallback
          const participantIds = typeof c.participantIds === 'string' 
            ? JSON.parse(c.participantIds) 
            : c.participantIds;
          
          // Handle both array and non-array cases
          if (!Array.isArray(participantIds)) {
            return false;
          }
          
          return participantIds.includes(userId);
        } catch (e) {
          // If JSON parsing fails, skip this conversation
          return false;
        }
      })
      .map(this.mapToEntity);
  }

  async update(
    id: string,
    data: { title?: string; lastMessageAt?: Date },
  ): Promise<ConversationEntity | null> {
    const [updated] = await db
      .update(conversations)
      .set({
        ...data,
        updatedAt: new Date(),
      })
      .where(eq(conversations.id, id))
      .returning();

    return updated ? this.mapToEntity(updated) : null;
  }

  async delete(id: string): Promise<ConversationEntity | null> {
    const [deleted] = await db
      .delete(conversations)
      .where(eq(conversations.id, id))
      .returning();

    return deleted ? this.mapToEntity(deleted) : null;
  }

  private mapToEntity(record: any): ConversationEntity {
    try {
      // Safe JSON parsing with fallback
      let participantIds: string[] = [];
      if (typeof record.participantIds === 'string') {
        participantIds = JSON.parse(record.participantIds);
      } else if (Array.isArray(record.participantIds)) {
        participantIds = record.participantIds;
      }
      
      return {
        id: record.id,
        participantIds,
        title: record.title,
        lastMessageAt: record.lastMessageAt,
        isActive: record.isActive,
        createdAt: record.createdAt,
        updatedAt: record.updatedAt,
      };
    } catch (e) {
      // Fallback on parse error
      return {
        id: record.id,
        participantIds: [],
        title: record.title,
        lastMessageAt: record.lastMessageAt,
        isActive: record.isActive,
        createdAt: record.createdAt,
        updatedAt: record.updatedAt,
      };
    }
  }
}
