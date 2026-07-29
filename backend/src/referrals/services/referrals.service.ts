import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { db } from '../../database/database';
import { users } from '../../database/schema';
import { eq } from 'drizzle-orm';

import { ReferralsRepository } from '../repositories/referrals.repository';
import { ReferralMapper } from '../mappers/referral.mapper';
import { UserReferralStatsDto } from '../dto/user-referral-stats.dto';
import { AdminReferralStatsDto } from '../dto/admin-referral-stats.dto';

@Injectable()
export class ReferralsService {
  constructor(private readonly referralsRepository: ReferralsRepository) {}

  async generateReferralCode(): Promise<string> {
    let code: string;
    let exists = true;
    while (exists) {
      code = Math.random().toString(36).substring(2, 10).toUpperCase();
      const [user] = await db
        .select()
        .from(users)
        .where(eq(users.referralCode, code));
      exists = !!user;
    }
    return code!;
  }

  async getUserReferralStats(userId: string): Promise<UserReferralStatsDto> {
    const [user] = await db
      .select()
      .from(users)
      .where(eq(users.id, userId));

    if (!user) throw new NotFoundException('User not found');

    const referrals = await this.referralsRepository.findByReferrerUserId(userId);
    const successfulCount = await this.referralsRepository.getCompletedReferralsForUser(userId);
    const totalReward = await this.referralsRepository.getTotalRewardForUser(userId);

    const dto = new UserReferralStatsDto();
    dto.referralCode = user.referralCode || '';
    dto.successfulInvites = successfulCount;
    dto.estimatedReward = totalReward;
    dto.paymentStatus = totalReward > 0 ? 'Pending' : 'Paid';
    dto.recentReferrals = referrals.slice(0, 5).map((r) => ({
      id: r.id,
      status: r.status,
      rewardAmount: parseFloat(r.rewardAmount as unknown as string),
      rewardPaid: r.rewardPaid,
      createdAt: r.createdAt,
    }));

    return dto;
  }

  async getAdminReferralStats(referrerId: string): Promise<AdminReferralStatsDto> {
    const [user] = await db
      .select()
      .from(users)
      .where(eq(users.id, referrerId));

    if (!user) throw new NotFoundException('User not found');

    const referrals = await this.referralsRepository.findByReferrerUserId(referrerId);
    const successfulCount = await this.referralsRepository.getCompletedReferralsForUser(referrerId);
    const totalReward = await this.referralsRepository.getTotalRewardForUser(referrerId);

    const lastPaidDate = referrals.find((r) => r.rewardPaid)?.rewardPaidAt || null;

    const dto = new AdminReferralStatsDto();
    dto.userId = user.id;
    dto.userEmail = user.email;
    dto.referralCode = user.referralCode || '';
    dto.successfulInvites = successfulCount;
    dto.estimatedReward = totalReward;
    dto.paymentStatus = totalReward > 0 ? 'Pending' : 'Paid';
    dto.lastPaymentDate = lastPaidDate;
    dto.referrals = referrals.map((r) => ({
      id: r.id,
      referredUserEmail: '', // Will be populated in controller if needed
      status: r.status,
      rewardAmount: parseFloat(r.rewardAmount as unknown as string),
      rewardPaid: r.rewardPaid,
      rewardPaidAt: r.rewardPaidAt,
      paymentNote: r.paymentNote,
      careerProfileCompletedAt: r.careerProfileCompletedAt,
      createdAt: r.createdAt,
    }));

    return dto;
  }

  async markReferralAsPaid(
    referralId: string,
    paymentNote?: string,
  ): Promise<UserReferralStatsDto | null> {
    const referral = await this.referralsRepository.markAsPaid(referralId, paymentNote);
    if (!referral) return null;

    return this.getUserReferralStats(referral.referrerUserId);
  }

  async completeReferralOnProfileCreation(userId: string): Promise<void> {
    try {
      // Find referral for this user (if they were referred)
      const referral = await this.referralsRepository.findByReferredUserId(userId);
      if (!referral) return; // User was not referred, nothing to do

      // Mark referral as completed
      await this.referralsRepository.updateToCompleted(userId);

      // Update referrer's successful invites and estimated reward
      const [referrer] = await db
        .select()
        .from(users)
        .where(eq(users.id, referral.referrerUserId));

      if (referrer) {
        const newSuccessfulInvites = (referrer.successfulInvites || 0) + 1;
        const currentReward = parseFloat((referrer.estimatedReward || '0') as unknown as string);
        const newReward = (currentReward + 0.1).toFixed(2);

        await db
          .update(users)
          .set({
            successfulInvites: newSuccessfulInvites,
            estimatedReward: newReward,
            updatedAt: new Date(),
          })
          .where(eq(users.id, referral.referrerUserId));
      }
    } catch (error) {
      // Silently fail if referral logic fails - don't block profile creation
      console.error('Error processing referral on career profile creation:', error);
    }
  }
}
