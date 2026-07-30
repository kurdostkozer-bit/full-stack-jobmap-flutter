import { ConversationEntity } from '../entities/conversation.entity';
import { ConversationResponseDto } from '../dto/conversation-response.dto';

export class ConversationMapper {
  static toResponse(entity: ConversationEntity): ConversationResponseDto {
    return {
      id: entity.id,
      participantIds: entity.participantIds,
      title: entity.title,
      lastMessageAt: entity.lastMessageAt,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }
}
