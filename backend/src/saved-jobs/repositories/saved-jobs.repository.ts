import { Injectable } from '@nestjs/common';
import { eq, and } from 'drizzle-orm';
import { db } from '../../database/database';
import { savedJobs } from '../../database/schema';
import { SavedJobEntity } from '../entities/saved-job.entity';

@Injectable()
export class SavedJobsRepository {
  async create(careerProfileId: string, jobId: string): Promise<SavedJobEntity> {
    const [saved] = await db
      .insert(savedJobs)
      .values({
        careerProfileId,
        jobId,
      })
      .returning();

    return this.mapToEntity(saved);
  }

  async findById(id: string): Promise<SavedJobEntity | null> {
    const [saved] = await db
      .select()
      .from(savedJobs)
      .where(eq(savedJobs.id, id))
      .limit(1);

    return saved ? this.mapToEntity(saved) : null;
  }

  async findByCareerProfileId(careerProfileId: string): Promise<SavedJobEntity[]> {
    const saved = await db
      .select()
      .from(savedJobs)
      .where(eq(savedJobs.careerProfileId, careerProfileId));

    return saved.map(this.mapToEntity);
  }

  async findByCareerProfileIdAndJobId(
    careerProfileId: string,
    jobId: string,
  ): Promise<SavedJobEntity | null> {
    const [saved] = await db
      .select()
      .from(savedJobs)
      .where(
        and(
          eq(savedJobs.careerProfileId, careerProfileId),
          eq(savedJobs.jobId, jobId),
        ),
      )
      .limit(1);

    return saved ? this.mapToEntity(saved) : null;
  }

  async delete(id: string): Promise<SavedJobEntity | null> {
    const [deleted] = await db
      .delete(savedJobs)
      .where(eq(savedJobs.id, id))
      .returning();

    return deleted ? this.mapToEntity(deleted) : null;
  }

  async deleteByCareerProfileIdAndJobId(
    careerProfileId: string,
    jobId: string,
  ): Promise<void> {
    await db
      .delete(savedJobs)
      .where(
        and(
          eq(savedJobs.careerProfileId, careerProfileId),
          eq(savedJobs.jobId, jobId),
        ),
      );
  }

  private mapToEntity(record: any): SavedJobEntity {
    return {
      id: record.id,
      careerProfileId: record.careerProfileId,
      jobId: record.jobId,
      savedAt: record.savedAt,
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    };
  }
}
