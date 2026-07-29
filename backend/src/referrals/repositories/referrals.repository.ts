import { Injectable } from '@nestjs/common';
import { and, eq, desc } from 'drizzle-orm';

import { db } from '../../database/database';
import { referrals, users } from '../../database/schema';
import { ReferralEntity } from '../entities/referral.entity';

@Injectable()
export class ReferralsRepository {
  async create(
    referrerUserId: string,
    referredUserId: string,
    referralCode: string,
  ): Promise<ReferralEntity> {
    const [record] = await db
      .insert(referrals)
      .values({
        referrerUserId,
        referredUserId,
        referralCode,
        status: 'PENDING',
        rewardAmount: '0.10',
      })
      .returning();

    return record as unknown as ReferralEntity;
  }

  async findByReferrerUserId(referrerUserId: string): Promise<ReferralEntity[]> {
    const rows = await db
      .select()
      .from(referrals)
      .where(eq(referrals.referrerUserId, referrerUserId))
      .orderBy(desc(referrals.createdAt));

    return rows as unknown as ReferralEntity[];
  }

  async findByReferredUserId(referredUserId: string): Promise<ReferralEntity | null> {
    const [record] = await db
      .select()
      .from(referrals)
      .where(eq(referrals.referredUserId, referredUserId));

    return record ? (record as unknown as ReferralEntity) : null;
  }

  async updateToRegistered(referredUserId: string): Promise<ReferralEntity | null> {
    const [record] = await db
      .update(referrals)
      .set({ status: 'REGISTERED', updatedAt: new Date() })
      .where(eq(referrals.referredUserId, referredUserId))
      .returning();

    return record ? (record as unknown as ReferralEntity) : null;
  }

  async updateToCompleted(
    referredUserId: string,
  ): Promise<ReferralEntity | null> {
    const [record] = await db
      .update(referrals)
      .set({
        status: 'COMPLETED',
        careerProfileCompletedAt: new Date(),
        updatedAt: new Date(),
      })
      .where(eq(referrals.referredUserId, referredUserId))
      .returning();

    return record ? (record as unknown as ReferralEntity) : null;
  }

  async markAsPaid(
    id: string,
    paymentNote?: string,
  ): Promise<ReferralEntity | null> {
    const [record] = await db
      .update(referrals)
      .set({
        rewardPaid: true,
        rewardPaidAt: new Date(),
        paymentNote: paymentNote || null,
        updatedAt: new Date(),
      })
      .where(eq(referrals.id, id))
      .returning();

    return record ? (record as unknown as ReferralEntity) : null;
  }

  async findById(id: string): Promise<ReferralEntity | null> {
    const [record] = await db
      .select()
      .from(referrals)
      .where(eq(referrals.id, id));

    return record ? (record as unknown as ReferralEntity) : null;
  }

  async getUnpaidReferralsForUser(
    referrerUserId: string,
  ): Promise<ReferralEntity[]> {
    const rows = await db
      .select()
      .from(referrals)
      .where(
        and(
          eq(referrals.referrerUserId, referrerUserId),
          eq(referrals.rewardPaid, false),
          eq(referrals.status, 'COMPLETED'),
        ),
      );

    return rows as unknown as ReferralEntity[];
  }

  async getCompletedReferralsForUser(referrerUserId: string): Promise<number> {
    const rows = await db
      .select()
      .from(referrals)
      .where(
        and(
          eq(referrals.referrerUserId, referrerUserId),
          eq(referrals.status, 'COMPLETED'),
        ),
      );

    return rows.length;
  }

  async getTotalRewardForUser(referrerUserId: string): Promise<number> {
    const rows = await db
      .select()
      .from(referrals)
      .where(
        and(
          eq(referrals.referrerUserId, referrerUserId),
          eq(referrals.status, 'COMPLETED'),
        ),
      );

    return rows.reduce((sum, r) => sum + parseFloat(r.rewardAmount as unknown as string), 0);
  }
}
