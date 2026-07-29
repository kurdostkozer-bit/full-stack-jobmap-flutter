import { Injectable } from '@nestjs/common';
import { db } from '../../database/database';
import { companies } from '../../database/schema';
import { and, eq, ilike, isNull, desc, asc } from 'drizzle-orm';
import { CompanyEntity } from '../entities/company.entity';
import { CreateCompanyDto } from '../dto/create-company.dto';
import { UpdateCompanyDto } from '../dto/update-company.dto';
import { CompanyQueryDto } from '../dto/company-query.dto';

@Injectable()
export class CompaniesRepository {
  async create(dto: CreateCompanyDto, userId: string): Promise<CompanyEntity> {
    const [company] = await db
      .insert(companies)
      .values({
        ...dto,
        createdBy: userId,
        updatedBy: userId,
      })
      .returning();
    return company as unknown as CompanyEntity;
  }

  async findById(id: string): Promise<CompanyEntity | null> {
    const [company] = await db
      .select()
      .from(companies)
      .where(and(eq(companies.id, id), isNull(companies.deletedAt)));
    return company ? (company as unknown as CompanyEntity) : null;
  }

  async findBySlug(slug: string): Promise<CompanyEntity | null> {
    const [company] = await db
      .select()
      .from(companies)
      .where(and(eq(companies.slug, slug), isNull(companies.deletedAt)));
    return company ? (company as unknown as CompanyEntity) : null;
  }

  async findAll(query?: CompanyQueryDto): Promise<CompanyEntity[]> {
    const conditions: any[] = [isNull(companies.deletedAt)];

    if (query?.search) {
      conditions.push(ilike(companies.name, `%${query.search}%`));
    }

    if (query?.industry) {
      conditions.push(eq(companies.industry, query.industry));
    }

    if (query?.companySize) {
      conditions.push(eq(companies.companySize, query.companySize));
    }

    if (query?.status) {
      conditions.push(eq(companies.status, query.status));
    }

    if (query?.verificationStatus) {
      conditions.push(eq(companies.verificationStatus, query.verificationStatus));
    }

    if (query?.country) {
      conditions.push(eq(companies.country, query.country));
    }

    let dbQuery = db
      .select()
      .from(companies)
      .where(and(...conditions));

    // Sorting
    const sortBy = query?.sortBy || 'createdAt';
    const sortOrder = query?.sortOrder || 'DESC';
    const sortColumn =
      sortBy === 'name'
        ? companies.name
        : sortBy === 'foundedYear'
          ? companies.foundedYear
          : companies.createdAt;
    
    dbQuery = dbQuery.orderBy(
      sortOrder === 'DESC' ? desc(sortColumn) : asc(sortColumn)
    ) as any;

    // Pagination
    if (query?.skip) {
      dbQuery = dbQuery.offset(query.skip) as any;
    }
    if (query?.take) {
      dbQuery = dbQuery.limit(query.take) as any;
    }

    const result = await dbQuery;
    return result as unknown as CompanyEntity[];
  }

  async update(id: string, dto: UpdateCompanyDto, userId: string): Promise<CompanyEntity | null> {
    const [company] = await db
      .update(companies)
      .set({
        ...dto,
        updatedBy: userId,
        updatedAt: new Date(),
      })
      .where(and(eq(companies.id, id), isNull(companies.deletedAt)))
      .returning();
    return company ? (company as unknown as CompanyEntity) : null;
  }

  async softDelete(id: string, userId: string): Promise<CompanyEntity | null> {
    const [company] = await db
      .update(companies)
      .set({
        deletedAt: new Date(),
        updatedBy: userId,
        updatedAt: new Date(),
      })
      .where(and(eq(companies.id, id), isNull(companies.deletedAt)))
      .returning();
    return company ? (company as unknown as CompanyEntity) : null;
  }

  async findByCreator(userId: string): Promise<CompanyEntity[]> {
    const result = await db
      .select()
      .from(companies)
      .where(and(eq(companies.createdBy, userId), isNull(companies.deletedAt)))
      .orderBy(desc(companies.createdAt));
    return result as unknown as CompanyEntity[];
  }
}
