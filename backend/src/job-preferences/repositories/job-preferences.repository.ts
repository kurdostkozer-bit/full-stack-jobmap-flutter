import { Injectable } from '@nestjs/common';
import { eq } from 'drizzle-orm';

import { db } from '../../database/database';
import { jobPreferences } from '../../database/schema';
import { CreateJobPreferenceDto } from '../dto/create-job-preference.dto';
import { UpdateJobPreferenceDto } from '../dto/update-job-preference.dto';
import { JobPreferenceEntity } from '../entities/job-preference.entity';

@Injectable()
export class JobPreferencesRepository {
  async create(dto: CreateJobPreferenceDto): Promise<JobPreferenceEntity> {
    const [record] = await db
      .insert(jobPreferences)
      .values({
        careerProfileId: dto.careerProfileId,
        desiredJobTitles: dto.desiredJobTitles ?? [],
        preferredJobCategories: dto.preferredJobCategories ?? [],
        workEnvironments: dto.workEnvironments ?? [],
        employmentTypes: dto.employmentTypes ?? [],
        minimumSalary: dto.minimumSalary ?? null,
        maximumSalary: dto.maximumSalary ?? null,
        currency: dto.currency ?? 'USD',
        preferredCities: dto.preferredCities ?? [],
        preferredCountries: dto.preferredCountries ?? [],
        openToRelocation: dto.openToRelocation ?? false,
        availableImmediately: dto.availableImmediately ?? false,
        noticePeriodDays: dto.noticePeriodDays ?? 0,
        willingToTravel: dto.willingToTravel ?? false,
        openToInternationalJobs: dto.openToInternationalJobs ?? false,
      })
      .returning();

    return record as unknown as JobPreferenceEntity;
  }

  async update(
    careerProfileId: string,
    dto: UpdateJobPreferenceDto,
  ): Promise<JobPreferenceEntity | null> {
    const updateData: Record<string, unknown> = { updatedAt: new Date() };

    if (dto.desiredJobTitles !== undefined) updateData.desiredJobTitles = dto.desiredJobTitles;
    if (dto.preferredJobCategories !== undefined)
      updateData.preferredJobCategories = dto.preferredJobCategories;
    if (dto.workEnvironments !== undefined) updateData.workEnvironments = dto.workEnvironments;
    if (dto.employmentTypes !== undefined) updateData.employmentTypes = dto.employmentTypes;
    if (dto.minimumSalary !== undefined) updateData.minimumSalary = dto.minimumSalary;
    if (dto.maximumSalary !== undefined) updateData.maximumSalary = dto.maximumSalary;
    if (dto.currency !== undefined) updateData.currency = dto.currency;
    if (dto.preferredCities !== undefined) updateData.preferredCities = dto.preferredCities;
    if (dto.preferredCountries !== undefined)
      updateData.preferredCountries = dto.preferredCountries;
    if (dto.openToRelocation !== undefined) updateData.openToRelocation = dto.openToRelocation;
    if (dto.availableImmediately !== undefined)
      updateData.availableImmediately = dto.availableImmediately;
    if (dto.noticePeriodDays !== undefined) updateData.noticePeriodDays = dto.noticePeriodDays;
    if (dto.willingToTravel !== undefined) updateData.willingToTravel = dto.willingToTravel;
    if (dto.openToInternationalJobs !== undefined)
      updateData.openToInternationalJobs = dto.openToInternationalJobs;

    const [record] = await db
      .update(jobPreferences)
      .set(updateData)
      .where(eq(jobPreferences.careerProfileId, careerProfileId))
      .returning();

    return record ? (record as unknown as JobPreferenceEntity) : null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<JobPreferenceEntity | null> {
    const [record] = await db
      .select()
      .from(jobPreferences)
      .where(eq(jobPreferences.careerProfileId, careerProfileId));

    return record ? (record as unknown as JobPreferenceEntity) : null;
  }

  async findById(id: string): Promise<JobPreferenceEntity | null> {
    const [record] = await db
      .select()
      .from(jobPreferences)
      .where(eq(jobPreferences.id, id));

    return record ? (record as unknown as JobPreferenceEntity) : null;
  }

  async remove(careerProfileId: string): Promise<JobPreferenceEntity | null> {
    const [record] = await db
      .delete(jobPreferences)
      .where(eq(jobPreferences.careerProfileId, careerProfileId))
      .returning();

    return record ? (record as unknown as JobPreferenceEntity) : null;
  }
}
