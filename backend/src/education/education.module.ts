import { Module } from '@nestjs/common';

import { EducationController } from './controllers/education.controller';
import { EducationRepository } from './repositories/education.repository';
import { EducationService } from './services/education.service';

@Module({
  controllers: [EducationController],
  providers: [EducationService, EducationRepository],
  exports: [EducationService],
})
export class EducationModule {}
