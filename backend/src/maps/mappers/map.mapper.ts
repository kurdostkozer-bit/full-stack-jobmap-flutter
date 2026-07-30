import { MapEntity } from '../entities/map.entity';
import { MapResponseDto } from '../dto/map-response.dto';

export class MapMapper {
  static toResponse(entity: MapEntity): MapResponseDto {
    return {
      id: entity.id,
      latitude: entity.latitude,
      longitude: entity.longitude,
      locationName: entity.locationName,
      city: entity.city,
      state: entity.state,
      country: entity.country,
      postalCode: entity.postalCode,
      address: entity.address,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }
}
