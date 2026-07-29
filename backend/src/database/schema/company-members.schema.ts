import { pgTable, uuid, pgEnum, timestamp } from 'drizzle-orm/pg-core';
import { users } from './users.schema';
import { companies } from './companies.schema';

export const memberRoleEnum = pgEnum('company_member_role', [
  'OWNER',
  'HR_MANAGER',
  'RECRUITER',
  'HIRING_MANAGER',
  'VIEWER',
]);

export const companyMembers = pgTable('company_members', {
  id: uuid('id').primaryKey().defaultRandom(),
  companyId: uuid('company_id').notNull().references(() => companies.id),
  userId: uuid('user_id').notNull().references(() => users.id),
  role: memberRoleEnum('role').notNull().default('VIEWER'),
  createdBy: uuid('created_by').notNull().references(() => users.id),
  updatedBy: uuid('updated_by').notNull().references(() => users.id),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull(),
  deletedAt: timestamp('deleted_at'),
});
