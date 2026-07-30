import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Param,
  Body,
  UseGuards,
  Query,
  ParseUUIDPipe,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { ChatService } from '../services/chat.service';
import { MessageResponseDto } from '../dto/message-response.dto';
import { ConversationResponseDto } from '../dto/conversation-response.dto';
import { CreateMessageDto } from '../dto/create-message.dto';
import { CreateConversationDto } from '../dto/create-conversation.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

@Controller({ path: 'chat', version: '1' })
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

  @UseGuards(JwtAuthGuard)
  @Post('conversations')
  async createConversation(
    @Body() dto: CreateConversationDto,
  ): Promise<ConversationResponseDto> {
    return this.chatService.createConversation(dto);
  }

  @UseGuards(JwtAuthGuard)
  @Get('conversations/user/:userId')
  async getConversations(
    @Param('userId', ParseUUIDPipe) userId: string,
    @Query('limit') limit?: string,
  ): Promise<ConversationResponseDto[]> {
    return this.chatService.getConversations(userId, limit ? parseInt(limit) : undefined);
  }

  @UseGuards(JwtAuthGuard)
  @Get('conversations/:id')
  async getConversation(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<ConversationResponseDto> {
    return this.chatService.getConversation(id);
  }

  @UseGuards(JwtAuthGuard)
  @Delete('conversations/:id')
  @HttpCode(HttpStatus.NO_CONTENT)
  async deleteConversation(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<void> {
    return this.chatService.deleteConversation(id);
  }

  @UseGuards(JwtAuthGuard)
  @Post('messages')
  async sendMessage(@Body() dto: CreateMessageDto): Promise<MessageResponseDto> {
    return this.chatService.sendMessage(dto);
  }

  @UseGuards(JwtAuthGuard)
  @Get('messages/conversation/:conversationId')
  async getMessages(
    @Param('conversationId', ParseUUIDPipe) conversationId: string,
    @Query('limit') limit?: string,
    @Query('offset') offset?: string,
  ): Promise<MessageResponseDto[]> {
    return this.chatService.getMessages(
      conversationId,
      limit ? parseInt(limit) : undefined,
      offset ? parseInt(offset) : undefined,
    );
  }

  @UseGuards(JwtAuthGuard)
  @Get('messages/:id')
  async getMessage(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<MessageResponseDto> {
    return this.chatService.getMessage(id);
  }

  @UseGuards(JwtAuthGuard)
  @Patch('messages/:id')
  async editMessage(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() body: { content: string },
  ): Promise<MessageResponseDto> {
    return this.chatService.editMessage(id, body.content);
  }

  @UseGuards(JwtAuthGuard)
  @Delete('messages/:id')
  @HttpCode(HttpStatus.NO_CONTENT)
  async deleteMessage(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<void> {
    return this.chatService.deleteMessage(id);
  }
}
