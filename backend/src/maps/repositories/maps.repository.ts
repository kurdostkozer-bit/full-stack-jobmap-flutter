import { Injectable } from '@nestjs/common';
import { eq, like, and, gt, lt, SQL } from 'drizzle-orm';
import { db } from '../../database/database';
import { maps } from '../../database/schema';
import { MapEntity } from '../entities/map.entity';
import { CreateLocationDto } from '../dto/create-location.dto';

@Injectable()
export class MapsRepository {
  async create(dto: CreateLocationDto): Promise<MapEntity> {
    const [location] = await db
      .insert(maps)
      .values({
        latitude: dto.latitude.toString(),
        longitude: dto.longitude.toString(),
        locationName: dto.locationName,
        city: dto.city,
        state: dto.state,
        country: dto.country,
        postalCode: dto.postalCode,
        address: dto.address,
      })
      .returning();

    return this.mapToEntity(location);
  }

  async findById(id: string): Promise<MapEntity | null> {
    const [location] = await db
      .select()
      .from(maps)
      .where(eq(maps.id, id))
      .limit(1);

    return location ? this.mapToEntity(location) : null;
  }

  async findAll(): Promise<MapEntity[]> {
    const locations = await db.select().from(maps);
    return locations.map(this.mapToEntity);
  }

  async searchByLocation(query: string, city?: string, state?: string, limit: number = 50): Promise<MapEntity[]> {
    let conditions: SQL | undefined = like(maps.locationName, `%${query}%`);

    if (city) {
      conditions = and(conditions, like(maps.city, `%${city}%`))!;
    }

    if (state) {
      conditions = and(conditions, like(maps.state, `%${state}%`))!;
    }

    const locations = await db
      .select()
      .from(maps)
      .where(conditions)
      .limit(limit);

    return locations.map(this.mapToEntity);
  }

  async findByGeoRadius(
    latitude: number,
    longitude: number,
    radiusKm: number,
    limit: number = 50,
  ): Promise<MapEntity[]> {
    // Simplified distance calculation using bounding box
    // For production, use PostGIS extension for accurate distance calculation
    const latDelta = radiusKm / 111; // 1 degree ≈ 111 km
    const lonDelta = radiusKm / (111 * Math.cos((latitude * Math.PI) / 180));

    const locations = await db
      .select()
      .from(maps)
      .where(
        and(
          gt(maps.latitude, (latitude - latDelta).toString()),
          lt(maps.latitude, (latitude + latDelta).toString()),
          gt(maps.longitude, (longitude - lonDelta).toString()),
          lt(maps.longitude, (longitude + lonDelta).toString()),
        ),
      )
      .limit(limit);

    return locations.map(this.mapToEntity);
  }

  async findByCity(city: string, limit: number = 50): Promise<MapEntity[]> {
    const locations = await db
      .select()
      .from(maps)
      .where(like(maps.city, `%${city}%`))
      .limit(limit);

    return locations.map(this.mapToEntity);
  }

  async findByCountry(country: string, limit: number = 50): Promise<MapEntity[]> {
    const locations = await db
      .select()
      .from(maps)
      .where(like(maps.country, `%${country}%`))
      .limit(limit);

    return locations.map(this.mapToEntity);
  }

  private mapToEntity(record: any): MapEntity {
    return {
      id: record.id,
      latitude: parseFloat(record.latitude),
      longitude: parseFloat(record.longitude),
      locationName: record.locationName,
      city: record.city,
      state: record.state || '',
      country: record.country,
      postalCode: record.postalCode || '',
      address: record.address,
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    };
  }
}
