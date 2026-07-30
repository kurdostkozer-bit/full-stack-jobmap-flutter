import { pgTable, uuid, varchar, text, boolean, jsonb, timestamp, foreignKey, index } from 'drizzle-orm/pg-core';
import { users } from './users.schema';

export const notifications = pgTable(
  'notifications',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    userId: uuid('user_id')
      .notNull()
      .references(() => users.id, { onDelete: 'cascade' }),

    type: varchar('type', {
      length: 50,
      enum: ['JOB_ALERT', 'APPLICATION_UPDATE', 'MESSAGE', 'PROFILE_VIEW', 'SYSTEM'],
    })
      .notNull(),

    title: varchar('title', { length: 255 }).notNull(),

    message: text('message').notNull(),

    data: jsonb('data'),

    isRead: boolean('is_read').default(false).notNull(),

    readAt: timestamp('read_at', { withTimezone: true }),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    userIdx: index('notifications_user_idx').on(table.userId),
    typeIdx: index('notifications_type_idx').on(table.type),
    isReadIdx: index('notifications_is_read_idx').on(table.isRead),
    createdAtIdx: index('notifications_created_at_idx').on(table.createdAt),
  }),
);
