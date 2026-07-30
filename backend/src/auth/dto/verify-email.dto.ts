import { IsString, IsUUID } from 'class-validator';

export class VerifyEmailDto {
  @IsUUID()
  userId!: string;

  @IsString()
  code!: string;
}
