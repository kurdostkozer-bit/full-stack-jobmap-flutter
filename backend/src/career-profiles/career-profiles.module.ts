import { Module } from '@nestjs/common';

import { CareerProfilesController } from './controllers/career-profiles.controller';
import { CareerProfilesRepository } from './repositories/career-profiles.repository';
import { CareerProfilesService } from './services/career-profiles.service';
import { ReferralsModule } from '../referrals/referrals.module';

@Module({
  imports: [ReferralsModule],
  controllers: [CareerProfilesController],
  providers: [CareerProfilesService, CareerProfilesRepository],
  exports: [CareerProfilesService],
})
export class CareerProfilesModule {}
