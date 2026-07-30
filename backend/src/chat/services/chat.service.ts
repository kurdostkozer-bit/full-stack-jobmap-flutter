import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { MessagesRepository } from '../repositories/messages.repository';
import { ConversationsRepository } from '../repositories/conversations.repository';
import { MessageResponseDto } from '../dto/message-response.dto';
import { ConversationResponseDto } from '../dto/conversation-response.dto';
import { CreateMessageDto } from '../dto/create-message.dto';
import { CreateConversationDto } from '../dto/create-conversation.dto';
import { MessageMapper } from '../mappers/message.mapper';
import { ConversationMapper } from '../mappers/conversation.mapper';

@Injectable()
export class ChatService {
  constructor(
    private readonly messagesRepository: MessagesRepository,
    private readonly conversationsRepository: ConversationsRepository,
  ) {}

  async createConversation(dto: CreateConversationDto): Promise<ConversationResponseDto> {
    if (dto.participantIds.length < 2) {
      throw new BadRequestException('Conversation must have at least 2 participants.');
    }

    const conversation = await this.conversationsRepository.create(dto);
    return ConversationMapper.toResponse(conversation);
  }

  async getConversations(userId: string, limit?: number): Promise<ConversationResponseDto[]> {
    const conversations = await this.conversationsRepository.findByParticipantId(
      userId,
      limit || 50,
    );
    return conversations.map(ConversationMapper.toResponse);
  }

  async getConversation(id: string): Promise<ConversationResponseDto> {
    const conversation = await this.conversationsRepository.findById(id);

    if (!conversation) {
      throw new NotFoundException('Conversation not found.');
    }

    return ConversationMapper.toResponse(conversation);
  }

  async sendMessage(dto: CreateMessageDto): Promise<MessageResponseDto> {
    const conversation = await this.conversationsRepository.findById(dto.conversationId);

    if (!conversation) {
      throw new NotFoundException('Conversation not found.');
    }

    // Verify sender is part of conversation
    if (!conversation.participantIds.includes(dto.senderId)) {
      throw new BadRequestException('Sender is not a participant in this conversation.');
    }

    const message = await this.messagesRepository.create(dto);

    // Update conversation's last message time
    await this.conversationsRepository.update(dto.conversationId, {
      lastMessageAt: new Date(),
    });

    return MessageMapper.toResponse(message);
  }

  async getMessages(
    conversationId: string,
    limit?: number,
    offset?: number,
  ): Promise<MessageResponseDto[]> {
    const messages = await this.messagesRepository.findByConversationId(
      conversationId,
      limit || 50,
      offset || 0,
    );
    return messages.map(MessageMapper.toResponse);
  }

  async getMessage(id: string): Promise<MessageResponseDto> {
    const message = await this.messagesRepository.findById(id);

    if (!message) {
      throw new NotFoundException('Message not found.');
    }

    return MessageMapper.toResponse(message);
  }

  async editMessage(id: string, content: string): Promise<MessageResponseDto> {
    const message = await this.messagesRepository.update(id, content);

    if (!message) {
      throw new NotFoundException('Message not found.');
    }

    return MessageMapper.toResponse(message);
  }

  async deleteMessage(id: string): Promise<void> {
    const deleted = await this.messagesRepository.softDelete(id);

    if (!deleted) {
      throw new NotFoundException('Message not found.');
    }
  }

  async deleteConversation(id: string): Promise<void> {
    const deleted = await this.conversationsRepository.delete(id);

    if (!deleted) {
      throw new NotFoundException('Conversation not found.');
    }
  }
}
