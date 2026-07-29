import { Module } from '@nestjs/common';

import { JobPreferencesController } from './controllers/job-preferences.controller';
import { JobPreferencesRepository } from './repositories/job-preferences.repository';
import { JobPreferencesService } from './services/job-preferences.service';

@Module({
  controllers: [JobPreferencesController],
  providers: [JobPreferencesService, JobPreferencesRepository],
  exports: [JobPreferencesService],
})
export class JobPreferencesModule {}
