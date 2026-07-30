import { Module } from '@nestjs/common';
import { MapsController } from './controllers/maps.controller';
import { MapsService } from './services/maps.service';
import { MapsRepository } from './repositories/maps.repository';

@Module({
  controllers: [MapsController],
  providers: [MapsService, MapsRepository],
  exports: [MapsService],
})
export class MapsModule {}
