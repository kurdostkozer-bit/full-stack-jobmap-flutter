import { JobEntity } from '../entities/job.entity';
import { JobResponseDto } from '../dto/job-response.dto';

export class JobMapper {
  static toResponse(job: JobEntity): JobResponseDto {
    return {
      id: job.id,
      companyId: job.companyId,
      title: job.title,
      slug: job.slug,
      description: job.description,
      requirements: job.requirements,
      responsibilities: job.responsibilities,
      employmentType: job.employmentType,
      workMode: job.workMode,
      experienceLevel: job.experienceLevel,
      country: job.country,
      city: job.city,
      salaryMin: job.salaryMin,
      salaryMax: job.salaryMax,
      currency: job.currency,
      status: job.status,
      expiresAt: job.expiresAt,
      isActive: job.isActive,
      createdAt: job.createdAt,
      updatedAt: job.updatedAt,
    };
  }
}
