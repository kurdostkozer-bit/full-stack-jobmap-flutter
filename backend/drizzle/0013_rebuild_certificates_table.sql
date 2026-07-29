-- Rebuild certificates table with verification support

DROP TABLE IF EXISTS "certificates";

CREATE TYPE "certificate_verification_status" AS ENUM (
  'PENDING',
  'VERIFIED',
  'REJECTED'
);

CREATE TABLE "certificates" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "career_profile_id" uuid NOT NULL,
  "name" varchar(200) NOT NULL,
  "issuer" varchar(200) NOT NULL,
  "credential_id" varchar(200),
  "credential_url" text,
  "issue_date" timestamp with time zone NOT NULL,
  "expiry_date" timestamp with time zone,
  "does_not_expire" boolean NOT NULL DEFAULT false,
  "verification_status" "certificate_verification_status" NOT NULL DEFAULT 'PENDING',
  "display_order" integer NOT NULL DEFAULT 0,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX "certificates_career_profile_id_idx" ON "certificates" ("career_profile_id");
CREATE INDEX "certificates_verification_status_idx" ON "certificates" ("verification_status");
CREATE INDEX "certificates_display_order_idx" ON "certificates" ("display_order");
