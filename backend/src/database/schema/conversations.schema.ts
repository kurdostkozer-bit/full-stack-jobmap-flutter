import { pgTable, uuid, text, timestamp, boolean, jsonb, foreignKey, index } from 'drizzle-orm/pg-core';
import { users } from './users.schema';

export const conversations = pgTable(
  'conversations',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    participantIds: jsonb('participant_ids').notNull(), // Array of UUIDs

    title: text('title'),

    lastMessageAt: timestamp('last_message_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    isActive: boolean('is_active').default(true).notNull(),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    lastMessageAtIdx: index('conversations_last_message_at_idx').on(table.lastMessageAt),
    isActiveIdx: index('conversations_is_active_idx').on(table.isActive),
  }),
);
