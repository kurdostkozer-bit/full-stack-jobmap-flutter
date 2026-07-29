import { Injectable } from '@nestjs/common';
import { db } from '../../database/database';
import { companyMembers } from '../../database/schema';
import { and, eq, isNull, desc } from 'drizzle-orm';
import { CompanyMemberEntity } from '../entities/company-member.entity';
import { CreateCompanyMemberDto } from '../dto/create-company-member.dto';
import { UpdateCompanyMemberDto } from '../dto/update-company-member.dto';
import { CompanyMemberQueryDto } from '../dto/company-member-query.dto';

@Injectable()
export class CompanyMembersRepository {
  async create(dto: CreateCompanyMemberDto, userId: string): Promise<CompanyMemberEntity> {
    const [member] = await db
      .insert(companyMembers)
      .values({
        ...dto,
        createdBy: userId,
        updatedBy: userId,
      })
      .returning();
    return member as unknown as CompanyMemberEntity;
  }

  async findById(id: string): Promise<CompanyMemberEntity | null> {
    const [member] = await db
      .select()
      .from(companyMembers)
      .where(and(eq(companyMembers.id, id), isNull(companyMembers.deletedAt)));
    return member ? (member as unknown as CompanyMemberEntity) : null;
  }

  async findByCompanyId(companyId: string): Promise<CompanyMemberEntity[]> {
    const result = await db
      .select()
      .from(companyMembers)
      .where(
        and(eq(companyMembers.companyId, companyId), isNull(companyMembers.deletedAt))
      )
      .orderBy(desc(companyMembers.createdAt));
    return result as unknown as CompanyMemberEntity[];
  }

  async findByUserId(userId: string): Promise<CompanyMemberEntity[]> {
    const result = await db
      .select()
      .from(companyMembers)
      .where(
        and(eq(companyMembers.userId, userId), isNull(companyMembers.deletedAt))
      )
      .orderBy(desc(companyMembers.createdAt));
    return result as unknown as CompanyMemberEntity[];
  }

  async findAll(query?: CompanyMemberQueryDto): Promise<CompanyMemberEntity[]> {
    const conditions: any[] = [isNull(companyMembers.deletedAt)];

    if (query?.companyId) {
      conditions.push(eq(companyMembers.companyId, query.companyId));
    }

    if (query?.userId) {
      conditions.push(eq(companyMembers.userId, query.userId));
    }

    if (query?.role) {
      conditions.push(eq(companyMembers.role, query.role));
    }

    let dbQuery = db
      .select()
      .from(companyMembers)
      .where(and(...conditions));

    if (query?.skip) {
      dbQuery = dbQuery.offset(query.skip) as any;
    }

    if (query?.take) {
      dbQuery = dbQuery.limit(query.take) as any;
    }

    dbQuery = dbQuery.orderBy(desc(companyMembers.createdAt)) as any;

    const result = await dbQuery;
    return result as unknown as CompanyMemberEntity[];
  }

  async update(
    id: string,
    dto: UpdateCompanyMemberDto,
    userId: string,
  ): Promise<CompanyMemberEntity | null> {
    const [member] = await db
      .update(companyMembers)
      .set({
        ...dto,
        updatedBy: userId,
        updatedAt: new Date(),
      })
      .where(and(eq(companyMembers.id, id), isNull(companyMembers.deletedAt)))
      .returning();
    return member ? (member as unknown as CompanyMemberEntity) : null;
  }

  async softDelete(id: string, userId: string): Promise<CompanyMemberEntity | null> {
    const [member] = await db
      .update(companyMembers)
      .set({
        deletedAt: new Date(),
        updatedBy: userId,
        updatedAt: new Date(),
      })
      .where(and(eq(companyMembers.id, id), isNull(companyMembers.deletedAt)))
      .returning();
    return member ? (member as unknown as CompanyMemberEntity) : null;
  }

  async findByCompanyAndUser(
    companyId: string,
    userId: string,
  ): Promise<CompanyMemberEntity | null> {
    const [member] = await db
      .select()
      .from(companyMembers)
      .where(
        and(
          eq(companyMembers.companyId, companyId),
          eq(companyMembers.userId, userId),
          isNull(companyMembers.deletedAt),
        ),
      );
    return member ? (member as unknown as CompanyMemberEntity) : null;
  }
}
