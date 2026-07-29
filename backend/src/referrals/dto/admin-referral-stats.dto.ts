export class AdminReferralStatsDto {
  userId!: string;
  userEmail!: string;
  referralCode!: string;
  successfulInvites!: number;
  estimatedReward!: number;
  paymentStatus!: 'Pending' | 'Paid';
  lastPaymentDate!: Date | null;
  referrals!: Array<{
    id: string;
    referredUserEmail: string;
    status: 'PENDING' | 'REGISTERED' | 'COMPLETED';
    rewardAmount: number;
    rewardPaid: boolean;
    rewardPaidAt: Date | null;
    paymentNote: string | null;
    careerProfileCompletedAt: Date | null;
    createdAt: Date;
  }>;
}
