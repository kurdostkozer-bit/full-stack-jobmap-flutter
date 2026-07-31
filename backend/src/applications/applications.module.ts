import { Module } from '@nestjs/common';
import { ApplicationsController } from './controllers/applications.controller';
import { ApplicationsService } from './services/applications.service';
import { ApplicationsRepository } from './repositories/applications.repository';
import { CareerProfilesModule } from '../career-profiles/career-profiles.module';

@Module({
  imports: [CareerProfilesModule],
  controllers: [ApplicationsController],
  providers: [ApplicationsService, ApplicationsRepository],
  exports: [ApplicationsService],
})
export class ApplicationsModule {}
