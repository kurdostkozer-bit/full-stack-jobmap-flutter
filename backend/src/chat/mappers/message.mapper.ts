import { MessageEntity } from '../entities/message.entity';
import { MessageResponseDto } from '../dto/message-response.dto';

export class MessageMapper {
  static toResponse(entity: MessageEntity): MessageResponseDto {
    return {
      id: entity.id,
      conversationId: entity.conversationId,
      senderId: entity.senderId,
      content: entity.content,
      attachmentUrl: entity.attachmentUrl,
      isEdited: entity.isEdited,
      editedAt: entity.editedAt,
      deletedAt: entity.deletedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }
}
