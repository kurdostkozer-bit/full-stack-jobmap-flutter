import {
  pgEnum,
  pgTable,
  uuid,
  varchar,
  decimal,
  timestamp,
  text,
  boolean,
  index,
  foreignKey,
} from 'drizzle-orm/pg-core';

export const referralStatusEnum = pgEnum('referral_status', [
  'PENDING',
  'REGISTERED',
  'COMPLETED',
]);

export const referrals = pgTable(
  'referrals',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    referrerUserId: uuid('referrer_user_id').notNull(),

    referredUserId: uuid('referred_user_id').notNull(),

    referralCode: varchar('referral_code', { length: 20 }).notNull(),

    status: referralStatusEnum('status').notNull().default('PENDING'),

    rewardAmount: decimal('reward_amount', { precision: 10, scale: 2 }).notNull().default('0.10'),

    rewardPaid: boolean('reward_paid').notNull().default(false),

    rewardPaidAt: timestamp('reward_paid_at', { withTimezone: true }),

    paymentNote: text('payment_note'),

    careerProfileCompletedAt: timestamp('career_profile_completed_at', { withTimezone: true }),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    referrerUserIdIdx: index('referrals_referrer_user_id_idx').on(table.referrerUserId),
    referredUserIdIdx: index('referrals_referred_user_id_idx').on(table.referredUserId),
    statusIdx: index('referrals_status_idx').on(table.status),
    rewardPaidIdx: index('referrals_reward_paid_idx').on(table.rewardPaid),
  }),
);
