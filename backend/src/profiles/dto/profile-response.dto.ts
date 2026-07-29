export class ProfileResponseDto {
  id!: string;

  userId!: string;

  firstName!: string | null;

  lastName!: string | null;

  headline!: string | null;

  bio!: string | null;

  avatarUrl!: string | null;

  country!: string | null;

  city!: string | null;

  dateOfBirth!: Date | null;

  gender!: string | null;

  phone!: string | null;

  isPublic!: boolean;

  createdAt!: Date;

  updatedAt!: Date;
}
