export class EducationResponseDto {
  id!: string;

  careerProfileId!: string;

  institution!: string;

  college!: string | null;

  degree!: string;

  fieldOfStudy!: string;

  grade!: string | null;

  gradeType!: string | null;

  country!: string | null;

  city!: string | null;

  description!: string | null;

  startDate!: Date;

  endDate!: Date | null;

  isCurrent!: boolean;

  createdAt!: Date;

  updatedAt!: Date;
}
