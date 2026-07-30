import { IsUUID, IsOptional, IsString } from 'class-validator';

export class CreateApplicationDto {
  @IsUUID()
  careerProfileId: string;

  @IsUUID()
  jobId: string;

  @IsOptional()
  @IsString()
  notes?: string;
}
