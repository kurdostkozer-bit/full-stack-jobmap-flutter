export class ReferralResponseDto {
  id!: string;
  referrerUserId!: string;
  referredUserId!: string;
  referralCode!: string;
  status!: 'PENDING' | 'REGISTERED' | 'COMPLETED';
  rewardAmount!: number;
  rewardPaid!: boolean;
  rewardPaidAt!: Date | null;
  paymentNote!: string | null;
  careerProfileCompletedAt!: Date | null;
  createdAt!: Date;
  updatedAt!: Date;
}
