import { boolean, pgTable, text, timestamp, uuid } from 'drizzle-orm/pg-core';

export const profiles = pgTable('profiles', {
  id: uuid('id').defaultRandom().primaryKey(),

  userId: uuid('user_id').notNull().unique(),

  firstName: text('first_name'),

  lastName: text('last_name'),

  headline: text('headline'),

  bio: text('bio'),

  avatarUrl: text('avatar_url'),

  country: text('country'),

  city: text('city'),

  dateOfBirth: timestamp('date_of_birth', {
    withTimezone: true,
  }),

  gender: text('gender'),

  phone: text('phone'),

  isPublic: boolean('is_public').notNull().default(true),

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
