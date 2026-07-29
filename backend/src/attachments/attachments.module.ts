import { Module } from '@nestjs/common';

import { AttachmentsController } from './controllers/attachments.controller';
import { AttachmentsRepository } from './repositories/attachments.repository';
import { AttachmentsService } from './services/attachments.service';
import { LocalStorageProvider } from './storage/local.storage.provider';

@Module({
  controllers: [AttachmentsController],
  providers: [AttachmentsService, AttachmentsRepository, LocalStorageProvider],
  exports: [AttachmentsService],
})
export class AttachmentsModule {}
