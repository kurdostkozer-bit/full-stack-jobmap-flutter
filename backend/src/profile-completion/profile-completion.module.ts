import { Module } from '@nestjs/common';

import { ProfileCompletionController } from './controllers/profile-completion.controller';
import { ProfileCompletionService } from './services/profile-completion.service';

@Module({
  controllers: [ProfileCompletionController],
  providers: [ProfileCompletionService],
  exports: [ProfileCompletionService],
})
export class ProfileCompletionModule {}
