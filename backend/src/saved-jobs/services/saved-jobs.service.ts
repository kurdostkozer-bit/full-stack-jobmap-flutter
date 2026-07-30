import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { SavedJobsRepository } from '../repositories/saved-jobs.repository';
import { SavedJobResponseDto } from '../dto/saved-job-response.dto';
import { SavedJobMapper } from '../mappers/saved-job.mapper';

@Injectable()
export class SavedJobsService {
  constructor(private readonly savedJobsRepository: SavedJobsRepository) {}

  async saveJob(careerProfileId: string, jobId: string): Promise<SavedJobResponseDto> {
    // Check if already saved
    const existing = await this.savedJobsRepository.findByCareerProfileIdAndJobId(
      careerProfileId,
      jobId,
    );

    if (existing) {
      throw new ConflictException('Job is already saved.');
    }

    const savedJob = await this.savedJobsRepository.create(careerProfileId, jobId);
    return SavedJobMapper.toResponse(savedJob);
  }

  async unsaveJob(careerProfileId: string, jobId: string): Promise<void> {
    await this.savedJobsRepository.deleteByCareerProfileIdAndJobId(
      careerProfileId,
      jobId,
    );
  }

  async getSavedJobs(careerProfileId: string): Promise<SavedJobResponseDto[]> {
    const savedJobs = await this.savedJobsRepository.findByCareerProfileId(
      careerProfileId,
    );
    return savedJobs.map(SavedJobMapper.toResponse);
  }

  async isSaved(careerProfileId: string, jobId: string): Promise<boolean> {
    const saved = await this.savedJobsRepository.findByCareerProfileIdAndJobId(
      careerProfileId,
      jobId,
    );
    return !!saved;
  }

  async deleteSavedJob(id: string): Promise<SavedJobResponseDto> {
    const deleted = await this.savedJobsRepository.delete(id);

    if (!deleted) {
      throw new NotFoundException('Saved job not found.');
    }

    return SavedJobMapper.toResponse(deleted);
  }
}
