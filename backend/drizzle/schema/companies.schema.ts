import {
  boolean,
  index,
  integer,
  pgTable,
  text,
  timestamp,
  uuid,
} from 'drizzle-orm/pg-core';

export const companies = pgTable(
  'companies',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    name: text('name').notNull(),

    slug: text('slug').notNull().unique(),

    description: text('description'),

    industry: text('industry'),

    size: text('size'),

    foundedYear: integer('founded_year'),

    website: text('website'),

    logoUrl: text('logo_url'),

    coverUrl: text('cover_url'),

    country: text('country'),

    city: text('city'),

    address: text('address'),

    email: text('email'),

    phone: text('phone'),

    isVerified: boolean('is_verified').notNull().default(false),

    isActive: boolean('is_active').notNull().default(true),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    slugIdx: index('companies_slug_idx').on(table.slug),
    industryIdx: index('companies_industry_idx').on(table.industry),
    isActiveIdx: index('companies_is_active_idx').on(table.isActive),
  }),
);
