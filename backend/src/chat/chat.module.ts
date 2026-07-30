import { Module } from '@nestjs/common';
import { ChatController } from './controllers/chat.controller';
import { ChatService } from './services/chat.service';
import { MessagesRepository } from './repositories/messages.repository';
import { ConversationsRepository } from './repositories/conversations.repository';

@Module({
  controllers: [ChatController],
  providers: [ChatService, MessagesRepository, ConversationsRepository],
  exports: [ChatService],
})
export class ChatModule {}
