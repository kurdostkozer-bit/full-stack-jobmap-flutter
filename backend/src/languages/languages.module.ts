import { Module } from '@nestjs/common';

import { LanguagesController } from './controllers/languages.controller';
import { LanguagesRepository } from './repositories/languages.repository';
import { LanguagesService } from './services/languages.service';

@Module({
  controllers: [LanguagesController],
  providers: [LanguagesService, LanguagesRepository],
  exports: [LanguagesService],
})
export class LanguagesModule {}
