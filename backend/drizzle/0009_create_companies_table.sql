CREATE TABLE "companies" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "name" text NOT NULL,
  "slug" text NOT NULL UNIQUE,
  "description" text,
  "industry" text,
  "size" text,
  "founded_year" integer,
  "website" text,
  "logo_url" text,
  "cover_url" text,
  "country" text,
  "city" text,
  "address" text,
  "email" text,
  "phone" text,
  "is_verified" boolean NOT NULL DEFAULT false,
  "is_active" boolean NOT NULL DEFAULT true,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX "companies_slug_idx" ON "companies" ("slug");
CREATE INDEX "companies_industry_idx" ON "companies" ("industry");
CREATE INDEX "companies_is_active_idx" ON "companies" ("is_active");
