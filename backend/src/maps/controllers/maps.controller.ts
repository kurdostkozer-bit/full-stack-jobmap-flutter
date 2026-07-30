import {
  Controller,
  Get,
  Post,
  Param,
  Body,
  Query,
  ParseUUIDPipe,
} from '@nestjs/common';
import { MapsService } from '../services/maps.service';
import { MapResponseDto } from '../dto/map-response.dto';
import { CreateLocationDto } from '../dto/create-location.dto';
import { LocationSearchDto } from '../dto/location-search.dto';
import { GeoFilterDto } from '../dto/geo-filter.dto';

@Controller({ path: 'maps', version: '1' })
export class MapsController {
  constructor(private readonly mapsService: MapsService) {}

  @Post('locations')
  async createLocation(@Body() dto: CreateLocationDto): Promise<MapResponseDto> {
    return this.mapsService.createLocation(dto);
  }

  @Get('locations')
  async findAll(): Promise<MapResponseDto[]> {
    return this.mapsService.findAll();
  }

  @Get('locations/:id')
  async findById(@Param('id', ParseUUIDPipe) id: string): Promise<MapResponseDto> {
    return this.mapsService.findById(id);
  }

  @Get('search')
  async searchLocations(@Query() dto: LocationSearchDto): Promise<MapResponseDto[]> {
    return this.mapsService.searchLocations(dto);
  }

  @Post('geo-filter')
  async findByGeoRadius(@Body() dto: GeoFilterDto): Promise<MapResponseDto[]> {
    return this.mapsService.findByGeoRadius(dto);
  }

  @Get('by-city/:city')
  async findByCity(
    @Param('city') city: string,
    @Query('limit') limit?: string,
  ): Promise<MapResponseDto[]> {
    return this.mapsService.findByCity(city, limit ? parseInt(limit) : undefined);
  }

  @Get('by-country/:country')
  async findByCountry(
    @Param('country') country: string,
    @Query('limit') limit?: string,
  ): Promise<MapResponseDto[]> {
    return this.mapsService.findByCountry(country, limit ? parseInt(limit) : undefined);
  }
}
