import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { ApplicationsRepository } from '../repositories/applications.repository';
import { ApplicationResponseDto } from '../dto/application-response.dto';
import { CreateApplicationDto } from '../dto/create-application.dto';
import { UpdateApplicationStatusDto } from '../dto/update-application-status.dto';
import { ApplicationMapper } from '../mappers/application.mapper';

@Injectable()
export class ApplicationsService {
  constructor(private readonly applicationsRepository: ApplicationsRepository) {}

  async applyToJob(dto: CreateApplicationDto): Promise<ApplicationResponseDto> {
    // Check if already applied
    const existing = await this.applicationsRepository.findByCareerProfileIdAndJobId(
      dto.careerProfileId,
      dto.jobId,
    );

    if (existing) {
      throw new ConflictException('Already applied to this job.');
    }

    const application = await this.applicationsRepository.create(dto);
    return ApplicationMapper.toResponse(application);
  }

  async getApplications(careerProfileId: string): Promise<ApplicationResponseDto[]> {
    const applications = await this.applicationsRepository.findByCareerProfileId(
      careerProfileId,
    );
    return applications.map(ApplicationMapper.toResponse);
  }

  async getApplication(id: string): Promise<ApplicationResponseDto> {
    const application = await this.applicationsRepository.findById(id);

    if (!application) {
      throw new NotFoundException('Application not found.');
    }

    return ApplicationMapper.toResponse(application);
  }

  async updateApplicationStatus(
    id: string,
    dto: UpdateApplicationStatusDto,
  ): Promise<ApplicationResponseDto> {
    const updated = await this.applicationsRepository.updateStatus(
      id,
      dto.status,
      dto.notes,
    );

    if (!updated) {
      throw new NotFoundException('Application not found.');
    }

    return ApplicationMapper.toResponse(updated);
  }

  async withdrawApplication(id: string): Promise<ApplicationResponseDto> {
    const updated = await this.applicationsRepository.updateStatus(id, 'WITHDRAWN');

    if (!updated) {
      throw new NotFoundException('Application not found.');
    }

    return ApplicationMapper.toResponse(updated);
  }

  async deleteApplication(id: string): Promise<void> {
    const deleted = await this.applicationsRepository.delete(id);

    if (!deleted) {
      throw new NotFoundException('Application not found.');
    }
  }
}
