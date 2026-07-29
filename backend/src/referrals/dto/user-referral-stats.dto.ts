export class UserReferralStatsDto {
  referralCode!: string;
  successfulInvites!: number;
  estimatedReward!: number;
  paymentStatus!: 'Pending' | 'Paid';
  recentReferrals!: Array<{
    id: string;
    referredUserEmail?: string;
    status: 'PENDING' | 'REGISTERED' | 'COMPLETED';
    rewardAmount: number;
    rewardPaid: boolean;
    createdAt: Date;
  }>;
}
