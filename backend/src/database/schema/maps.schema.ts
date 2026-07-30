import { pgTable, uuid, numeric, varchar, text, timestamp, index } from 'drizzle-orm/pg-core';

export const maps = pgTable('maps', {
  id: uuid('id').defaultRandom().primaryKey(),

  latitude: numeric('latitude', { precision: 10, scale: 8 }).notNull(),

  longitude: numeric('longitude', { precision: 11, scale: 8 }).notNull(),

  locationName: varchar('location_name', { length: 255 }).notNull(),

  city: varchar('city', { length: 100 }).notNull(),

  state: varchar('state', { length: 100 }),

  country: varchar('country', { length: 100 }).notNull(),

  postalCode: varchar('postal_code', { length: 20 }),

  address: text('address').notNull(),

  createdAt: timestamp('created_at', { withTimezone: true })
    .defaultNow()
    .notNull(),

  updatedAt: timestamp('updated_at', { withTimezone: true })
    .defaultNow()
    .notNull(),
}, (table) => ({
  latitudeIdx: index('maps_latitude_idx').on(table.latitude),
  longitudeIdx: index('maps_longitude_idx').on(table.longitude),
  cityIdx: index('maps_city_idx').on(table.city),
  countryIdx: index('maps_country_idx').on(table.country),
}));
