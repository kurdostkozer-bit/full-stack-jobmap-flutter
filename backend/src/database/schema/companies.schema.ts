import { pgTable, text, varchar, integer, timestamp, uuid, pgEnum } from 'drizzle-orm/pg-core';
import { users } from './users.schema';

export const verificationStatusEnum = pgEnum('company_verification_status', [
  'UNVERIFIED',
  'PENDING',
  'VERIFIED',
  'REJECTED',
]);

export const companySizeEnum = pgEnum('company_size', [
  'STARTUP',
  'SMALL',
  'MEDIUM',
  'LARGE',
  'ENTERPRISE',
]);

export const companyStatusEnum = pgEnum('company_status', [
  'ACTIVE',
  'INACTIVE',
  'SUSPENDED',
]);

export const companies = pgTable('companies', {
  id: uuid('id').primaryKey().defaultRandom(),
  name: varchar('name', { length: 255 }).notNull(),
  slug: varchar('slug', { length: 255 }).notNull().unique(),
  logo: varchar('logo', { length: 500 }),
  coverImage: varchar('cover_image', { length: 500 }),
  description: text('description'),
  industry: varchar('industry', { length: 100 }),
  companySize: companySizeEnum('company_size'),
  foundedYear: integer('founded_year'),
  website: varchar('website', { length: 500 }),
  email: varchar('email', { length: 255 }),
  phone: varchar('phone', { length: 20 }),
  country: varchar('country', { length: 100 }),
  city: varchar('city', { length: 100 }),
  address: text('address'),
  verificationStatus: verificationStatusEnum('verification_status').default('UNVERIFIED'),
  status: companyStatusEnum('status').default('ACTIVE'),
  createdBy: uuid('created_by').notNull().references(() => users.id),
  updatedBy: uuid('updated_by').notNull().references(() => users.id),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull(),
  deletedAt: timestamp('deleted_at'),
});
