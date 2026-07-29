import { Module } from '@nestjs/common';

import { ReferralsRepository } from './repositories/referrals.repository';
import { ReferralsService } from './services/referrals.service';
import { ReferralsController } from './controllers/referrals.controller';

@Module({
  providers: [ReferralsRepository, ReferralsService],
  controllers: [ReferralsController],
  exports: [ReferralsService, ReferralsRepository],
})
export class ReferralsModule {}
