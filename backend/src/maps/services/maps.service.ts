import { Injectable, NotFoundException } from '@nestjs/common';
import { MapsRepository } from '../repositories/maps.repository';
import { MapResponseDto } from '../dto/map-response.dto';
import { CreateLocationDto } from '../dto/create-location.dto';
import { LocationSearchDto } from '../dto/location-search.dto';
import { GeoFilterDto } from '../dto/geo-filter.dto';
import { MapMapper } from '../mappers/map.mapper';

@Injectable()
export class MapsService {
  constructor(private readonly mapsRepository: MapsRepository) {}

  async createLocation(dto: CreateLocationDto): Promise<MapResponseDto> {
    const location = await this.mapsRepository.create(dto);
    return MapMapper.toResponse(location);
  }

  async findById(id: string): Promise<MapResponseDto> {
    const location = await this.mapsRepository.findById(id);

    if (!location) {
      throw new NotFoundException('Location not found.');
    }

    return MapMapper.toResponse(location);
  }

  async findAll(): Promise<MapResponseDto[]> {
    const locations = await this.mapsRepository.findAll();
    return locations.map(MapMapper.toResponse);
  }

  async searchLocations(dto: LocationSearchDto): Promise<MapResponseDto[]> {
    const locations = await this.mapsRepository.searchByLocation(
      dto.query,
      dto.city,
      dto.state,
      dto.limit || 50,
    );

    return locations.map(MapMapper.toResponse);
  }

  async findByGeoRadius(dto: GeoFilterDto): Promise<MapResponseDto[]> {
    const locations = await this.mapsRepository.findByGeoRadius(
      dto.latitude,
      dto.longitude,
      dto.radiusKm,
      dto.limit || 50,
    );

    return locations.map(MapMapper.toResponse);
  }

  async findByCity(city: string, limit?: number): Promise<MapResponseDto[]> {
    const locations = await this.mapsRepository.findByCity(city, limit || 50);
    return locations.map(MapMapper.toResponse);
  }

  async findByCountry(country: string, limit?: number): Promise<MapResponseDto[]> {
    const locations = await this.mapsRepository.findByCountry(country, limit || 50);
    return locations.map(MapMapper.toResponse);
  }
}
