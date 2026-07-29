import { Injectable } from '@nestjs/common';
import { db } from '../../database/database';
import { companyLocations } from '../../database/schema';
import { and, eq, isNull, desc } from 'drizzle-orm';
import { CompanyLocationEntity } from '../entities/company-location.entity';
import { CreateCompanyLocationDto } from '../dto/create-company-location.dto';
import { UpdateCompanyLocationDto } from '../dto/update-company-location.dto';
import { CompanyLocationQueryDto } from '../dto/company-location-query.dto';

@Injectable()
export class CompanyLocationsRepository {
  async create(
    dto: CreateCompanyLocationDto,
    userId: string,
  ): Promise<CompanyLocationEntity> {
    const [location] = await db
      .insert(companyLocations)
      .values({
        ...dto,
        createdBy: userId,
        updatedBy: userId,
      })
      .returning();
    return location as unknown as CompanyLocationEntity;
  }

  async findById(id: string): Promise<CompanyLocationEntity | null> {
    const [location] = await db
      .select()
      .from(companyLocations)
      .where(and(eq(companyLocations.id, id), isNull(companyLocations.deletedAt)));
    return location ? (location as unknown as CompanyLocationEntity) : null;
  }

  async findByCompanyId(companyId: string): Promise<CompanyLocationEntity[]> {
    const result = await db
      .select()
      .from(companyLocations)
      .where(
        and(
          eq(companyLocations.companyId, companyId),
          isNull(companyLocations.deletedAt),
        )
      )
      .orderBy(desc(companyLocations.createdAt));
    return result as unknown as CompanyLocationEntity[];
  }

  async findAll(query?: CompanyLocationQueryDto): Promise<CompanyLocationEntity[]> {
    const conditions: any[] = [isNull(companyLocations.deletedAt)];

    if (query?.companyId) {
      conditions.push(eq(companyLocations.companyId, query.companyId));
    }

    if (query?.city) {
      conditions.push(eq(companyLocations.city, query.city));
    }

    if (query?.country) {
      conditions.push(eq(companyLocations.country, query.country));
    }

    if (query?.isHeadquarters !== undefined) {
      conditions.push(eq(companyLocations.isHeadquarters, query.isHeadquarters));
    }

    let dbQuery = db
      .select()
      .from(companyLocations)
      .where(and(...conditions));

    if (query?.skip) {
      dbQuery = dbQuery.offset(query.skip) as any;
    }

    if (query?.take) {
      dbQuery = dbQuery.limit(query.take) as any;
    }

    dbQuery = dbQuery.orderBy(desc(companyLocations.createdAt)) as any;

    const result = await dbQuery;
    return result as unknown as CompanyLocationEntity[];
  }

  async update(
    id: string,
    dto: UpdateCompanyLocationDto,
    userId: string,
  ): Promise<CompanyLocationEntity | null> {
    const [location] = await db
      .update(companyLocations)
      .set({
        ...dto,
        updatedBy: userId,
        updatedAt: new Date(),
      })
      .where(and(eq(companyLocations.id, id), isNull(companyLocations.deletedAt)))
      .returning();
    return location ? (location as unknown as CompanyLocationEntity) : null;
  }

  async softDelete(id: string, userId: string): Promise<CompanyLocationEntity | null> {
    const [location] = await db
      .update(companyLocations)
      .set({
        deletedAt: new Date(),
        updatedBy: userId,
        updatedAt: new Date(),
      })
      .where(and(eq(companyLocations.id, id), isNull(companyLocations.deletedAt)))
      .returning();
    return location ? (location as unknown as CompanyLocationEntity) : null;
  }
}
