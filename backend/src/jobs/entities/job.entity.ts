export class JobEntity {
  id!: string;

  companyId!: string;

  title!: string;

  slug!: string;

  description!: string;

  requirements!: string | null;

  responsibilities!: string | null;

  employmentType!: string;

  workMode!: string;

  experienceLevel!: string;

  country!: string | null;

  city!: string | null;

  salaryMin!: number | null;

  salaryMax!: number | null;

  currency!: string;

  status!: string;

  expiresAt!: Date | null;

  isActive!: boolean;

  createdAt!: Date;

  updatedAt!: Date;
}
