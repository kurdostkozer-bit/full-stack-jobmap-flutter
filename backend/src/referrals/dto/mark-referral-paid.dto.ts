import { IsBoolean, IsOptional, IsString, MaxLength } from 'class-validator';

export class MarkReferralPaidDto {
  @IsBoolean()
  rewardPaid!: boolean;

  @IsOptional()
  @IsString()
  @MaxLength(500)
  paymentNote?: string;
}
