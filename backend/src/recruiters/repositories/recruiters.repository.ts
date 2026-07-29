import { Injectable } from '@nestjs/common';
import { db } from '../../database/database';
import { recruiters } from '../../database/schema';
import { and, eq, isNull, desc } from 'drizzle-orm';
import { RecruiterEntity } from '../entities/recruiter.entity';
import { CreateRecruiterDto } from '../dto/create-recruiter.dto';
import { UpdateRecruiterDto } from '../dto/update-recruiter.dto';
import { RecruiterQueryDto } from '../dto/recruiter-query.dto';

@Injectable()
export class RecruitersRepository {
  async create(dto: CreateRecruiterDto, userId: string): Promise<RecruiterEntity> {
    const [recruiter] = await db
      .insert(recruiters)
      .values({
        ...dto,
        createdBy: userId,
        updatedBy: userId,
      })
      .returning();
    return recruiter as unknown as RecruiterEntity;
  }

  async findById(id: string): Promise<RecruiterEntity | null> {
    const [recruiter] = await db
      .select()
      .from(recruiters)
      .where(and(eq(recruiters.id, id), isNull(recruiters.deletedAt)));
    return recruiter ? (recruiter as unknown as RecruiterEntity) : null;
  }

  async findByCompanyId(companyId: string): Promise<RecruiterEntity[]> {
    const result = await db
      .select()
      .from(recruiters)
      .where(
        and(eq(recruiters.companyId, companyId), isNull(recruiters.deletedAt))
      )
      .orderBy(desc(recruiters.createdAt));
    return result as unknown as RecruiterEntity[];
  }

  async findByUserId(userId: string): Promise<RecruiterEntity[]> {
    const result = await db
      .select()
      .from(recruiters)
      .where(
        and(eq(recruiters.userId, userId), isNull(recruiters.deletedAt))
      )
      .orderBy(desc(recruiters.createdAt));
    return result as unknown as RecruiterEntity[];
  }

  async findAll(query?: RecruiterQueryDto): Promise<RecruiterEntity[]> {
    const conditions: any[] = [isNull(recruiters.deletedAt)];

    if (query?.companyId) {
      conditions.push(eq(recruiters.companyId, query.companyId));
    }

    if (query?.userId) {
      conditions.push(eq(recruiters.userId, query.userId));
    }

    let dbQuery = db
      .select()
      .from(recruiters)
      .where(and(...conditions));

    if (query?.skip) {
      dbQuery = dbQuery.offset(query.skip) as any;
    }

    if (query?.take) {
      dbQuery = dbQuery.limit(query.take) as any;
    }

    dbQuery = dbQuery.orderBy(desc(recruiters.createdAt)) as any;

    const result = await dbQuery;
    return result as unknown as RecruiterEntity[];
  }

  async update(
    id: string,
    dto: UpdateRecruiterDto,
    userId: string,
  ): Promise<RecruiterEntity | null> {
    const [recruiter] = await db
      .update(recruiters)
      .set({
        ...dto,
        updatedBy: userId,
        updatedAt: new Date(),
      })
      .where(and(eq(recruiters.id, id), isNull(recruiters.deletedAt)))
      .returning();
    return recruiter ? (recruiter as unknown as RecruiterEntity) : null;
  }

  async softDelete(id: string, userId: string): Promise<RecruiterEntity | null> {
    const [recruiter] = await db
      .update(recruiters)
      .set({
        deletedAt: new Date(),
        updatedBy: userId,
        updatedAt: new Date(),
      })
      .where(and(eq(recruiters.id, id), isNull(recruiters.deletedAt)))
      .returning();
    return recruiter ? (recruiter as unknown as RecruiterEntity) : null;
  }

  async findByCompanyAndUser(
    companyId: string,
    userId: string,
  ): Promise<RecruiterEntity | null> {
    const [recruiter] = await db
      .select()
      .from(recruiters)
      .where(
        and(
          eq(recruiters.companyId, companyId),
          eq(recruiters.userId, userId),
          isNull(recruiters.deletedAt),
        ),
      );
    return recruiter ? (recruiter as unknown as RecruiterEntity) : null;
  }
}
