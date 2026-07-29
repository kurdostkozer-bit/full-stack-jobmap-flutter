export class ExperienceResponseDto {
  id!: string;

  careerProfileId!: string;

  jobTitle!: string;

  companyName!: string;

  employmentType!: string;

  location!: string | null;

  description!: string | null;

  startDate!: Date;

  endDate!: Date | null;

  isCurrent!: boolean;

  sortOrder!: number;

  createdAt!: Date;

  updatedAt!: Date;
}
