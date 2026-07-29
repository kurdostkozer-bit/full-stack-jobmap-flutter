export class CareerProfileEntity {
  id!: string;

  userId!: string;

  headline!: string | null;

  summary!: string | null;

  professionTitle!: string | null;

  location!: string | null;

  preferredJobTitles!: string | null;

  preferredIndustries!: string | null;

  salaryMin!: number | null;

  salaryMax!: number | null;

  currency!: string;

  workPreference!: string;

  remotePreference!: string;

  relocationPreference!: string;

  profileStatus!: string;

  privacyLevel!: string;

  profileCompletion!: number;

  resumeUrl!: string | null;

  isPublic!: boolean;

  isDeleted!: boolean;

  deletedAt!: Date | null;

  createdAt!: Date;

  updatedAt!: Date;
}
