import { Module } from '@nestjs/common';
import { RecruitersController } from './controllers/recruiters.controller';
import { RecruitersRepository } from './repositories/recruiters.repository';
import { RecruitersService } from './services/recruiters.service';

@Module({
  controllers: [RecruitersController],
  providers: [RecruitersService, RecruitersRepository],
  exports: [RecruitersService, RecruitersRepository],
})
export class RecruitersModule {}
