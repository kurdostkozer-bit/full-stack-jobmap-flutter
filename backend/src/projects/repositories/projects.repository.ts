import { Injectable } from '@nestjs/common';
import { and, asc, desc, eq, ilike, or, SQL } from 'drizzle-orm';

import { db } from '../../database/database';
import { projects } from '../../database/schema';
import { CreateProjectDto } from '../dto/create-project.dto';
import { ProjectQueryDto } from '../dto/project-query.dto';
import { UpdateProjectDto } from '../dto/update-project.dto';
import { ProjectEntity } from '../entities/project.entity';

@Injectable()
export class ProjectsRepository {
  async create(dto: CreateProjectDto): Promise<ProjectEntity> {
    const [record] = await db
      .insert(projects)
      .values({
        careerProfileId: dto.careerProfileId,
        title: dto.title,
        description: dto.description,
        role: dto.role,
        company: dto.company,
        technologies: dto.technologies ?? [],
        githubUrl: dto.githubUrl,
        liveUrl: dto.liveUrl,
        imageUrl: dto.imageUrl,
        startDate: dto.startDate ? new Date(dto.startDate) : null,
        endDate: dto.endDate ? new Date(dto.endDate) : null,
        isCurrent: dto.isCurrent ?? false,
        displayOrder: dto.displayOrder ?? 0,
      })
      .returning();

    return record as unknown as ProjectEntity;
  }

  async update(
    id: string,
    dto: UpdateProjectDto,
  ): Promise<ProjectEntity | null> {
    const updateData: Record<string, unknown> = { updatedAt: new Date() };

    if (dto.title !== undefined) updateData.title = dto.title;
    if (dto.description !== undefined) updateData.description = dto.description;
    if (dto.role !== undefined) updateData.role = dto.role;
    if (dto.company !== undefined) updateData.company = dto.company;
    if (dto.technologies !== undefined)
      updateData.technologies = dto.technologies;
    if (dto.githubUrl !== undefined) updateData.githubUrl = dto.githubUrl;
    if (dto.liveUrl !== undefined) updateData.liveUrl = dto.liveUrl;
    if (dto.imageUrl !== undefined) updateData.imageUrl = dto.imageUrl;
    if (dto.startDate !== undefined)
      updateData.startDate = new Date(dto.startDate);
    if (dto.endDate !== undefined) updateData.endDate = new Date(dto.endDate);
    if (dto.isCurrent !== undefined) updateData.isCurrent = dto.isCurrent;
    if (dto.displayOrder !== undefined)
      updateData.displayOrder = dto.displayOrder;

    const [record] = await db
      .update(projects)
      .set(updateData)
      .where(eq(projects.id, id))
      .returning();

    return record ? (record as unknown as ProjectEntity) : null;
  }

  async findAll(query?: ProjectQueryDto): Promise<ProjectEntity[]> {
    const filters: SQL[] = [];

    if (query?.careerProfileId) {
      filters.push(eq(projects.careerProfileId, query.careerProfileId));
    }

    if (query?.company) {
      filters.push(ilike(projects.company, `%${query.company}%`));
    }

    if (query?.isCurrent !== undefined) {
      filters.push(eq(projects.isCurrent, query.isCurrent));
    }

    if (query?.search) {
      filters.push(
        or(
          ilike(projects.title, `%${query.search}%`),
          ilike(projects.description, `%${query.search}%`),
          ilike(projects.role, `%${query.search}%`),
        ) as SQL,
      );
    }

    const sortColumn = this.resolveSortColumn(query?.sortBy);
    const orderFn = query?.sortOrder === 'desc' ? desc : asc;

    const page = query?.page ?? 1;
    const limit = query?.limit ?? 20;
    const offset = (page - 1) * limit;

    const baseQuery = db.select().from(projects);
    const filtered =
      filters.length > 0 ? baseQuery.where(and(...filters)) : baseQuery;

    const rows = await filtered
      .orderBy(orderFn(sortColumn))
      .limit(limit)
      .offset(offset);
    return rows as unknown as ProjectEntity[];
  }

  async findById(id: string): Promise<ProjectEntity | null> {
    const [record] = await db
      .select()
      .from(projects)
      .where(eq(projects.id, id));

    return record ? (record as unknown as ProjectEntity) : null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<ProjectEntity[]> {
    const rows = await db
      .select()
      .from(projects)
      .where(eq(projects.careerProfileId, careerProfileId))
      .orderBy(asc(projects.displayOrder), desc(projects.isCurrent));

    return rows as unknown as ProjectEntity[];
  }

  async remove(id: string): Promise<ProjectEntity | null> {
    const [record] = await db
      .delete(projects)
      .where(eq(projects.id, id))
      .returning();

    return record ? (record as unknown as ProjectEntity) : null;
  }

  private resolveSortColumn(sortBy?: string) {
    switch (sortBy) {
      case 'title':
        return projects.title;
      case 'company':
        return projects.company;
      case 'startDate':
        return projects.startDate;
      case 'displayOrder':
        return projects.displayOrder;
      case 'updatedAt':
        return projects.updatedAt;
      default:
        return projects.createdAt;
    }
  }
}
