import { IsUUID } from 'class-validator';

export class CreateSavedJobDto {
  @IsUUID()
  careerProfileId: string;

  @IsUUID()
  jobId: string;
}
