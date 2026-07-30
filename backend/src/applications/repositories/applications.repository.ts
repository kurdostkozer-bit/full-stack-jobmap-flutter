import { Injectable } from '@nestjs/common';
import { eq, and } from 'drizzle-orm';
import { db } from '../../database/database';
import { applications } from '../../database/schema';
import { ApplicationEntity } from '../entities/application.entity';
import { CreateApplicationDto } from '../dto/create-application.dto';

@Injectable()
export class ApplicationsRepository {
  async create(dto: CreateApplicationDto): Promise<ApplicationEntity> {
    const [app] = await db
      .insert(applications)
      .values({
        careerProfileId: dto.careerProfileId,
        jobId: dto.jobId,
        notes: dto.notes,
      })
      .returning();

    return this.mapToEntity(app);
  }

  async findById(id: string): Promise<ApplicationEntity | null> {
    const [app] = await db
      .select()
      .from(applications)
      .where(eq(applications.id, id))
      .limit(1);

    return app ? this.mapToEntity(app) : null;
  }

  async findByCareerProfileId(careerProfileId: string): Promise<ApplicationEntity[]> {
    const apps = await db
      .select()
      .from(applications)
      .where(eq(applications.careerProfileId, careerProfileId));

    return apps.map(this.mapToEntity);
  }

  async findByCareerProfileIdAndJobId(
    careerProfileId: string,
    jobId: string,
  ): Promise<ApplicationEntity | null> {
    const [app] = await db
      .select()
      .from(applications)
      .where(
        and(
          eq(applications.careerProfileId, careerProfileId),
          eq(applications.jobId, jobId),
        ),
      )
      .limit(1);

    return app ? this.mapToEntity(app) : null;
  }

  async updateStatus(
    id: string,
    status: 'APPLIED' | 'UNDER_REVIEW' | 'SHORTLISTED' | 'REJECTED' | 'WITHDRAWN',
    notes?: string,
  ): Promise<ApplicationEntity | null> {
    const [updated] = await db
      .update(applications)
      .set({
        status: status as any,
        notes: notes || undefined,
        statusUpdatedAt: new Date(),
        updatedAt: new Date(),
      })
      .where(eq(applications.id, id))
      .returning();

    return updated ? this.mapToEntity(updated) : null;
  }

  async delete(id: string): Promise<ApplicationEntity | null> {
    const [deleted] = await db
      .delete(applications)
      .where(eq(applications.id, id))
      .returning();

    return deleted ? this.mapToEntity(deleted) : null;
  }

  private mapToEntity(record: any): ApplicationEntity {
    return {
      id: record.id,
      careerProfileId: record.careerProfileId,
      jobId: record.jobId,
      status: record.status,
      appliedAt: record.appliedAt,
      statusUpdatedAt: record.statusUpdatedAt,
      notes: record.notes,
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    };
  }
}
