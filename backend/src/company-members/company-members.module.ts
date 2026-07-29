import { Module } from '@nestjs/common';
import { CompanyMembersController } from './controllers/company-members.controller';
import { CompanyMembersRepository } from './repositories/company-members.repository';
import { CompanyMembersService } from './services/company-members.service';

@Module({
  controllers: [CompanyMembersController],
  providers: [CompanyMembersService, CompanyMembersRepository],
  exports: [CompanyMembersService, CompanyMembersRepository],
})
export class CompanyMembersModule {}
