import { CareerProfileEntity } from '../entities/career-profile.entity';
import { CareerProfileResponseDto } from '../dto/career-profile-response.dto';

export class CareerProfileMapper {
  static toResponse(profile: CareerProfileEntity): CareerProfileResponseDto {
    return {
      id: profile.id,
      userId: profile.userId,
      headline: profile.headline,
      summary: profile.summary,
      professionTitle: profile.professionTitle,
      location: profile.location,
      preferredJobTitles: profile.preferredJobTitles,
      preferredIndustries: profile.preferredIndustries,
      salaryMin: profile.salaryMin,
      salaryMax: profile.salaryMax,
      currency: profile.currency,
      workPreference: profile.workPreference,
      remotePreference: profile.remotePreference,
      relocationPreference: profile.relocationPreference,
      profileStatus: profile.profileStatus,
      privacyLevel: profile.privacyLevel,
      profileCompletion: profile.profileCompletion,
      resumeUrl: profile.resumeUrl,
      isPublic: profile.isPublic,
      isDeleted: profile.isDeleted,
      deletedAt: profile.deletedAt,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    };
  }
}
