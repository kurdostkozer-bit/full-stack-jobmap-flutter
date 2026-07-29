import { Module } from '@nestjs/common';
import { CompanyLocationsController } from './controllers/company-locations.controller';
import { CompanyLocationsRepository } from './repositories/company-locations.repository';
import { CompanyLocationsService } from './services/company-locations.service';

@Module({
  controllers: [CompanyLocationsController],
  providers: [CompanyLocationsService, CompanyLocationsRepository],
  exports: [CompanyLocationsService, CompanyLocationsRepository],
})
export class CompanyLocationsModule {}
