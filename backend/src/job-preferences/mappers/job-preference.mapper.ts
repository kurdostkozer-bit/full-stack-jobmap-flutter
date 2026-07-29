import { JobPreferenceEntity } from '../entities/job-preference.entity';
import { JobPreferenceResponseDto } from '../dto/job-preference-response.dto';

export class JobPreferenceMapper {
  static toResponse(entity: JobPreferenceEntity): JobPreferenceResponseDto {
    const dto = new JobPreferenceResponseDto();

    dto.id = entity.id;
    dto.careerProfileId = entity.careerProfileId;
    dto.desiredJobTitles = entity.desiredJobTitles;
    dto.preferredJobCategories = entity.preferredJobCategories;
    dto.workEnvironments = entity.workEnvironments;
    dto.employmentTypes = entity.employmentTypes;
    dto.minimumSalary = entity.minimumSalary;
    dto.maximumSalary = entity.maximumSalary;
    dto.currency = entity.currency;
    dto.preferredCities = entity.preferredCities;
    dto.preferredCountries = entity.preferredCountries;
    dto.openToRelocation = entity.openToRelocation;
    dto.availableImmediately = entity.availableImmediately;
    dto.noticePeriodDays = entity.noticePeriodDays;
    dto.willingToTravel = entity.willingToTravel;
    dto.openToInternationalJobs = entity.openToInternationalJobs;
    dto.createdAt = entity.createdAt;
    dto.updatedAt = entity.updatedAt;

    return dto;
  }
}
