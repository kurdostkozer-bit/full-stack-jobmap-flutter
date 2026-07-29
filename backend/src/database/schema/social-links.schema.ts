import {
  index,
  integer,
  pgEnum,
  pgTable,
  text,
  timestamp,
  uuid,
  varchar,
} from 'drizzle-orm/pg-core';

export const socialLinkPlatformEnum = pgEnum('social_link_platform', [
  'LINKEDIN',
  'GITHUB',
  'GITLAB',
  'STACKOVERFLOW',
  'BEHANCE',
  'DRIBBBLE',
  'PERSONAL_WEBSITE',
  'X',
  'FACEBOOK',
  'INSTAGRAM',
  'YOUTUBE',
  'TELEGRAM',
]);

export const socialLinkVisibilityEnum = pgEnum('social_link_visibility', [
  'PUBLIC',
  'PRIVATE',
]);

export const socialLinks = pgTable(
  'social_links',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    careerProfileId: uuid('career_profile_id').notNull(),

    platform: socialLinkPlatformEnum('platform').notNull(),

    url: text('url').notNull(),

    displayName: varchar('display_name', { length: 100 }),

    visibility: socialLinkVisibilityEnum('visibility')
      .notNull()
      .default('PUBLIC'),

    displayOrder: integer('display_order').notNull().default(0),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    careerProfileIdIdx: index('social_links_career_profile_id_idx').on(
      table.careerProfileId,
    ),
    platformIdx: index('social_links_platform_idx').on(table.platform),
    visibilityIdx: index('social_links_visibility_idx').on(table.visibility),
    displayOrderIdx: index('social_links_display_order_idx').on(
      table.displayOrder,
    ),
  }),
);
