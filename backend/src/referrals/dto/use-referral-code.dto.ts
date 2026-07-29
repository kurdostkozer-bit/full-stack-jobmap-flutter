import { IsString, MaxLength, MinLength } from 'class-validator';

export class UseReferralCodeDto {
  @IsString()
  @MinLength(1)
  @MaxLength(20)
  referralCode!: string;
}
