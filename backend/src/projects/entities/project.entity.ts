export class ProjectEntity {
  id!: string;
  careerProfileId!: string;
  title!: string;
  description!: string | null;
  role!: string | null;
  company!: string | null;
  technologies!: string[];
  githubUrl!: string | null;
  liveUrl!: string | null;
  imageUrl!: string | null;
  startDate!: Date | null;
  endDate!: Date | null;
  isCurrent!: boolean;
  displayOrder!: number;
  createdAt!: Date;
  updatedAt!: Date;
}
