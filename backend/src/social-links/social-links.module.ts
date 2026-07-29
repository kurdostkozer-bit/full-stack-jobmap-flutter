import { Module } from '@nestjs/common';

import { SocialLinksController } from './controllers/social-links.controller';
import { SocialLinksRepository } from './repositories/social-links.repository';
import { SocialLinksService } from './services/social-links.service';

@Module({
  controllers: [SocialLinksController],
  providers: [SocialLinksService, SocialLinksRepository],
  exports: [SocialLinksService],
})
export class SocialLinksModule {}
