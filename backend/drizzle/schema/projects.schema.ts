import {
  boolean,
  index,
  integer,
  jsonb,
  pgTable,
  text,
  timestamp,
  uuid,
  varchar,
} from 'drizzle-orm/pg-core';

export const projects = pgTable(
  'projects',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    careerProfileId: uuid('career_profile_id').notNull(),

    title: varchar('title', { length: 200 }).notNull(),

    description: text('description'),

    role: varchar('role', { length: 150 }),

    company: varchar('company', { length: 200 }),

    technologies: jsonb('technologies').$type<string[]>().default([]),

    githubUrl: text('github_url'),

    liveUrl: text('live_url'),

    imageUrl: text('image_url'),

    startDate: timestamp('start_date', { withTimezone: true }),

    endDate: timestamp('end_date', { withTimezone: true }),

    isCurrent: boolean('is_current').notNull().default(false),

    displayOrder: integer('display_order').notNull().default(0),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    careerProfileIdIdx: index('projects_career_profile_id_idx').on(
      table.careerProfileId,
    ),
    displayOrderIdx: index('projects_display_order_idx').on(table.displayOrder),
    isCurrentIdx: index('projects_is_current_idx').on(table.isCurrent),
  }),
);
