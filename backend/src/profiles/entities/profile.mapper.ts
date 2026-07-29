import { ProfileResponseDto } from '../dto/profile-response.dto';

export class ProfileMapper {
  static toResponse(profile: any): ProfileResponseDto {
    return {
      id: profile.id,
      userId: profile.userId,

      firstName: profile.firstName,
      lastName: profile.lastName,
      headline: profile.headline,
      bio: profile.bio,

      avatarUrl: profile.avatarUrl,

      country: profile.country,
      city: profile.city,

      dateOfBirth: profile.dateOfBirth,
      gender: profile.gender,
      phone: profile.phone,

      isPublic: profile.isPublic,

      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    };
  }
}
