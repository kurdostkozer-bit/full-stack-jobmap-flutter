import { Module } from '@nestjs/common';
import { SavedJobsController } from './controllers/saved-jobs.controller';
import { SavedJobsService } from './services/saved-jobs.service';
import { SavedJobsRepository } from './repositories/saved-jobs.repository';
import { CareerProfilesModule } from '../career-profiles/career-profiles.module';

@Module({
  imports: [CareerProfilesModule],
  controllers: [SavedJobsController],
  providers: [SavedJobsService, SavedJobsRepository],
  exports: [SavedJobsService],
})
export class SavedJobsModule {}
