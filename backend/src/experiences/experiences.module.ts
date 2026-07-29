import { Module } from '@nestjs/common';

import { ExperiencesController } from './controllers/experiences.controller';
import { ExperiencesRepository } from './repositories/experiences.repository';
import { ExperiencesService } from './services/experiences.service';

@Module({
  controllers: [ExperiencesController],
  providers: [ExperiencesService, ExperiencesRepository],
  exports: [ExperiencesService],
})
export class ExperiencesModule {}
