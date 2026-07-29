import { Injectable } from '@nestjs/common';
import { db } from '../../database/database';
import { departments } from '../../database/schema';
import { and, eq, isNull, desc, ilike } from 'drizzle-orm';
import { DepartmentEntity } from '../entities/department.entity';
import { CreateDepartmentDto } from '../dto/create-department.dto';
import { UpdateDepartmentDto } from '../dto/update-department.dto';
import { DepartmentQueryDto } from '../dto/department-query.dto';

@Injectable()
export class DepartmentsRepository {
  async create(dto: CreateDepartmentDto, userId: string): Promise<DepartmentEntity> {
    const [department] = await db
      .insert(departments)
      .values({
        ...dto,
        createdBy: userId,
        updatedBy: userId,
      })
      .returning();
    return department as unknown as DepartmentEntity;
  }

  async findById(id: string): Promise<DepartmentEntity | null> {
    const [department] = await db
      .select()
      .from(departments)
      .where(and(eq(departments.id, id), isNull(departments.deletedAt)));
    return department ? (department as unknown as DepartmentEntity) : null;
  }

  async findByCompanyId(companyId: string): Promise<DepartmentEntity[]> {
    const result = await db
      .select()
      .from(departments)
      .where(
        and(eq(departments.companyId, companyId), isNull(departments.deletedAt))
      )
      .orderBy(desc(departments.createdAt));
    return result as unknown as DepartmentEntity[];
  }

  async findAll(query?: DepartmentQueryDto): Promise<DepartmentEntity[]> {
    const conditions: any[] = [isNull(departments.deletedAt)];

    if (query?.companyId) {
      conditions.push(eq(departments.companyId, query.companyId));
    }

    if (query?.search) {
      conditions.push(ilike(departments.name, `%${query.search}%`));
    }

    let dbQuery = db
      .select()
      .from(departments)
      .where(and(...conditions));

    if (query?.skip) {
      dbQuery = dbQuery.offset(query.skip) as any;
    }

    if (query?.take) {
      dbQuery = dbQuery.limit(query.take) as any;
    }

    dbQuery = dbQuery.orderBy(desc(departments.createdAt)) as any;

    const result = await dbQuery;
    return result as unknown as DepartmentEntity[];
  }

  async update(
    id: string,
    dto: UpdateDepartmentDto,
    userId: string,
  ): Promise<DepartmentEntity | null> {
    const [department] = await db
      .update(departments)
      .set({
        ...dto,
        updatedBy: userId,
        updatedAt: new Date(),
      })
      .where(and(eq(departments.id, id), isNull(departments.deletedAt)))
      .returning();
    return department ? (department as unknown as DepartmentEntity) : null;
  }

  async softDelete(id: string, userId: string): Promise<DepartmentEntity | null> {
    const [department] = await db
      .update(departments)
      .set({
        deletedAt: new Date(),
        updatedBy: userId,
        updatedAt: new Date(),
      })
      .where(and(eq(departments.id, id), isNull(departments.deletedAt)))
      .returning();
    return department ? (department as unknown as DepartmentEntity) : null;
  }
}
