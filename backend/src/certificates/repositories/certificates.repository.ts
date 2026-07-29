import { Injectable } from '@nestjs/common';
import { and, asc, desc, eq, ilike, or, SQL } from 'drizzle-orm';

import { db } from '../../database/database';
import { certificates } from '../../database/schema';
import { CreateCertificateDto } from '../dto/create-certificate.dto';
import { CertificateQueryDto } from '../dto/certificate-query.dto';
import { UpdateCertificateDto } from '../dto/update-certificate.dto';
import { CertificateEntity } from '../entities/certificate.entity';

@Injectable()
export class CertificatesRepository {
  async create(dto: CreateCertificateDto): Promise<CertificateEntity> {
    const [record] = await db
      .insert(certificates)
      .values({
        careerProfileId: dto.careerProfileId,
        name: dto.name,
        issuer: dto.issuer,
        credentialId: dto.credentialId ?? null,
        credentialUrl: dto.credentialUrl ?? null,
        issueDate: new Date(dto.issueDate),
        expiryDate: dto.expiryDate ? new Date(dto.expiryDate) : null,
        doesNotExpire: dto.doesNotExpire ?? false,
        displayOrder: dto.displayOrder ?? 0,
      })
      .returning();

    return record;
  }

  async update(
    id: string,
    dto: UpdateCertificateDto,
  ): Promise<CertificateEntity | null> {
    const updateData: Record<string, unknown> = { updatedAt: new Date() };

    if (dto.name !== undefined) updateData.name = dto.name;
    if (dto.issuer !== undefined) updateData.issuer = dto.issuer;
    if (dto.credentialId !== undefined)
      updateData.credentialId = dto.credentialId;
    if (dto.credentialUrl !== undefined)
      updateData.credentialUrl = dto.credentialUrl;
    if (dto.issueDate !== undefined)
      updateData.issueDate = new Date(dto.issueDate);
    if (dto.expiryDate !== undefined)
      updateData.expiryDate = dto.expiryDate ? new Date(dto.expiryDate) : null;
    if (dto.doesNotExpire !== undefined)
      updateData.doesNotExpire = dto.doesNotExpire;
    if (dto.displayOrder !== undefined)
      updateData.displayOrder = dto.displayOrder;

    const [record] = await db
      .update(certificates)
      .set(updateData)
      .where(eq(certificates.id, id))
      .returning();

    return record ? record : null;
  }

  async findAll(query?: CertificateQueryDto): Promise<CertificateEntity[]> {
    const filters: SQL[] = [];

    if (query?.careerProfileId) {
      filters.push(eq(certificates.careerProfileId, query.careerProfileId));
    }

    if (query?.verificationStatus) {
      filters.push(
        eq(certificates.verificationStatus, query.verificationStatus),
      );
    }

    if (query?.doesNotExpire !== undefined) {
      filters.push(eq(certificates.doesNotExpire, query.doesNotExpire));
    }

    if (query?.search) {
      filters.push(
        or(
          ilike(certificates.name, `%${query.search}%`),
          ilike(certificates.issuer, `%${query.search}%`),
        ) as SQL,
      );
    }

    const sortColumn = this.resolveSortColumn(query?.sortBy);
    const orderFn = query?.sortOrder === 'desc' ? desc : asc;

    const page = query?.page ?? 1;
    const limit = query?.limit ?? 20;
    const offset = (page - 1) * limit;

    const baseQuery = db.select().from(certificates);
    const filtered =
      filters.length > 0 ? baseQuery.where(and(...filters)) : baseQuery;

    const rows = await filtered
      .orderBy(orderFn(sortColumn))
      .limit(limit)
      .offset(offset);

    return rows;
  }

  async findById(id: string): Promise<CertificateEntity | null> {
    const [record] = await db
      .select()
      .from(certificates)
      .where(eq(certificates.id, id));

    return record ? record : null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<CertificateEntity[]> {
    const rows = await db
      .select()
      .from(certificates)
      .where(eq(certificates.careerProfileId, careerProfileId))
      .orderBy(asc(certificates.displayOrder), desc(certificates.issueDate));

    return rows;
  }

  async remove(id: string): Promise<CertificateEntity | null> {
    const [record] = await db
      .delete(certificates)
      .where(eq(certificates.id, id))
      .returning();

    return record ? record : null;
  }

  private resolveSortColumn(sortBy?: string) {
    switch (sortBy) {
      case 'name':
        return certificates.name;
      case 'issuer':
        return certificates.issuer;
      case 'issueDate':
        return certificates.issueDate;
      case 'displayOrder':
        return certificates.displayOrder;
      case 'verificationStatus':
        return certificates.verificationStatus;
      case 'updatedAt':
        return certificates.updatedAt;
      default:
        return certificates.createdAt;
    }
  }
}
