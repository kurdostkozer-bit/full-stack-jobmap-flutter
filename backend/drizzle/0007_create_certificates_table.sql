CREATE TABLE "certificates" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "career_profile_id" uuid NOT NULL,
  "name" text NOT NULL,
  "issuer" text NOT NULL,
  "credential_id" text,
  "credential_url" text,
  "issue_date" timestamp with time zone NOT NULL,
  "expiry_date" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX "certificates_career_profile_id_idx" ON "certificates" ("career_profile_id");
