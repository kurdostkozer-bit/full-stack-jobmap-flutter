import {
  boolean,
  integer,
  pgTable,
  text,
  timestamp,
  uuid,
} from 'drizzle-orm/pg-core';

export const skills = pgTable('skills', {
  id: uuid('id').defaultRandom().primaryKey(),

  careerProfileId: uuid('career_profile_id').notNull(),

  name: text('name').notNull(),

  category: text('category').notNull(),

  level: text('level').notNull(),

  yearsOfExperience: integer('years_of_experience')
    .notNull()
    .default(0),

  verified: boolean('verified')
    .notNull()
    .default(false),

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
