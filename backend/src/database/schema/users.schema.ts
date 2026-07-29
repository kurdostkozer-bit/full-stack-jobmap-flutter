import { boolean, pgTable, text, timestamp, uuid, varchar, integer, decimal, index, foreignKey } from 'drizzle-orm/pg-core';

export const users = pgTable('users', {
  id: uuid('id').defaultRandom().primaryKey(),

  email: text('email').notNull().unique(),

  passwordHash: text('password_hash').notNull(),

  isEmailVerified: boolean('is_email_verified').notNull().default(false),

  referralCode: varchar('referral_code', { length: 20 }).unique(),

  successfulInvites: integer('successful_invites').notNull().default(0),

  estimatedReward: decimal('estimated_reward', { precision: 10, scale: 2 }).notNull().default('0'),

  createdAt: timestamp('created_at', {
    withTimezone: true,
  })
    .defaultNow()
    .notNull(),

  updatedAt: timestamp('updated_at', {
    withTimezone: true,
  })
    .defaultNow()
    .notNull(),
});
