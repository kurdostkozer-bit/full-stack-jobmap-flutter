CREATE TYPE "public"."attachment_type" AS ENUM('RESUME', 'COVER_LETTER', 'CERTIFICATE', 'PORTFOLIO', 'OTHER');--> statement-breakpoint
CREATE TYPE "public"."storage_provider" AS ENUM('LOCAL', 'S3', 'R2', 'AZURE', 'GCS');--> statement-breakpoint
CREATE TYPE "public"."certificate_verification_status" AS ENUM('PENDING', 'VERIFIED', 'REJECTED');--> statement-breakpoint
CREATE TYPE "public"."company_size" AS ENUM('STARTUP', 'SMALL', 'MEDIUM', 'LARGE', 'ENTERPRISE');--> statement-breakpoint
CREATE TYPE "public"."company_status" AS ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED');--> statement-breakpoint
CREATE TYPE "public"."company_verification_status" AS ENUM('UNVERIFIED', 'PENDING', 'VERIFIED', 'REJECTED');--> statement-breakpoint
CREATE TYPE "public"."company_member_role" AS ENUM('OWNER', 'HR_MANAGER', 'RECRUITER', 'HIRING_MANAGER', 'VIEWER');--> statement-breakpoint
CREATE TYPE "public"."language_proficiency_level" AS ENUM('NATIVE', 'FLUENT', 'ADVANCED', 'INTERMEDIATE', 'BASIC');--> statement-breakpoint
CREATE TYPE "public"."language_skill_level" AS ENUM('EXCELLENT', 'GOOD', 'FAIR', 'POOR');--> statement-breakpoint
CREATE TYPE "public"."social_link_platform" AS ENUM('LINKEDIN', 'GITHUB', 'GITLAB', 'STACKOVERFLOW', 'BEHANCE', 'DRIBBBLE', 'PERSONAL_WEBSITE', 'X', 'FACEBOOK', 'INSTAGRAM', 'YOUTUBE', 'TELEGRAM');--> statement-breakpoint
CREATE TYPE "public"."social_link_visibility" AS ENUM('PUBLIC', 'PRIVATE');--> statement-breakpoint
CREATE TYPE "public"."currency" AS ENUM('USD', 'EUR', 'GBP', 'AED', 'SAR', 'KWD', 'QAR', 'OMR', 'BHD', 'JOD', 'EGP', 'IQD', 'LBP');--> statement-breakpoint
CREATE TYPE "public"."employment_type" AS ENUM('FULL_TIME', 'PART_TIME', 'CONTRACT', 'INTERNSHIP', 'FREELANCE', 'TEMPORARY');--> statement-breakpoint
CREATE TYPE "public"."work_environment" AS ENUM('ON_SITE', 'REMOTE', 'HYBRID');--> statement-breakpoint
CREATE TYPE "public"."referral_status" AS ENUM('PENDING', 'REGISTERED', 'COMPLETED');--> statement-breakpoint
CREATE TABLE "applications" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"career_profile_id" uuid NOT NULL,
	"job_id" uuid NOT NULL,
	"status" varchar(20) DEFAULT 'APPLIED' NOT NULL,
	"applied_at" timestamp with time zone DEFAULT now() NOT NULL,
	"status_updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	"notes" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "unique_application" UNIQUE("career_profile_id","job_id")
);
--> statement-breakpoint
CREATE TABLE "attachments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"career_profile_id" uuid NOT NULL,
	"type" "attachment_type" NOT NULL,
	"original_file_name" varchar(255) NOT NULL,
	"stored_file_name" varchar(255) NOT NULL,
	"mime_type" varchar(100) NOT NULL,
	"file_size" integer NOT NULL,
	"storage_provider" "storage_provider" DEFAULT 'LOCAL' NOT NULL,
	"storage_path" text NOT NULL,
	"file_url" text NOT NULL,
	"is_default" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "career_profiles" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"headline" text,
	"summary" text,
	"profession_title" text,
	"location" text,
	"preferred_job_titles" text,
	"preferred_industries" text,
	"salary_min" integer,
	"salary_max" integer,
	"currency" text DEFAULT 'USD' NOT NULL,
	"work_preference" text DEFAULT 'any' NOT NULL,
	"remote_preference" text DEFAULT 'hybrid' NOT NULL,
	"relocation_preference" text DEFAULT 'open' NOT NULL,
	"profile_status" text DEFAULT 'draft' NOT NULL,
	"privacy_level" text DEFAULT 'private' NOT NULL,
	"profile_completion" integer DEFAULT 0 NOT NULL,
	"resume_url" text,
	"is_public" boolean DEFAULT false NOT NULL,
	"is_deleted" boolean DEFAULT false NOT NULL,
	"deleted_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "career_profiles_user_id_unique" UNIQUE("user_id")
);
--> statement-breakpoint
CREATE TABLE "certificates" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"career_profile_id" uuid NOT NULL,
	"name" varchar(200) NOT NULL,
	"issuer" varchar(200) NOT NULL,
	"credential_id" varchar(200),
	"credential_url" text,
	"issue_date" timestamp with time zone NOT NULL,
	"expiry_date" timestamp with time zone,
	"does_not_expire" boolean DEFAULT false NOT NULL,
	"verification_status" "certificate_verification_status" DEFAULT 'PENDING' NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "companies" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar(255) NOT NULL,
	"slug" varchar(255) NOT NULL,
	"logo" varchar(500),
	"cover_image" varchar(500),
	"description" text,
	"industry" varchar(100),
	"company_size" "company_size",
	"founded_year" integer,
	"website" varchar(500),
	"email" varchar(255),
	"phone" varchar(20),
	"country" varchar(100),
	"city" varchar(100),
	"address" text,
	"verification_status" "company_verification_status" DEFAULT 'UNVERIFIED',
	"status" "company_status" DEFAULT 'ACTIVE',
	"created_by" uuid NOT NULL,
	"updated_by" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"deleted_at" timestamp,
	CONSTRAINT "companies_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "company_locations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"company_id" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"address" text NOT NULL,
	"city" varchar(100) NOT NULL,
	"country" varchar(100) NOT NULL,
	"postal_code" varchar(20),
	"latitude" varchar(20),
	"longitude" varchar(20),
	"is_headquarters" boolean DEFAULT false,
	"created_by" uuid NOT NULL,
	"updated_by" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"deleted_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "company_members" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"company_id" uuid NOT NULL,
	"user_id" uuid NOT NULL,
	"role" "company_member_role" DEFAULT 'VIEWER' NOT NULL,
	"created_by" uuid NOT NULL,
	"updated_by" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"deleted_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "conversations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"participant_ids" jsonb NOT NULL,
	"title" text,
	"last_message_at" timestamp with time zone DEFAULT now() NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "departments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"company_id" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"slug" varchar(255) NOT NULL,
	"description" text,
	"manager_user_id" uuid,
	"created_by" uuid NOT NULL,
	"updated_by" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"deleted_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "education" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"career_profile_id" uuid NOT NULL,
	"institution" text NOT NULL,
	"college" text,
	"degree" text NOT NULL,
	"field_of_study" text NOT NULL,
	"grade" text,
	"grade_type" text,
	"country" text,
	"city" text,
	"description" text,
	"start_date" timestamp with time zone NOT NULL,
	"end_date" timestamp with time zone,
	"is_current" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "experiences" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"career_profile_id" uuid NOT NULL,
	"job_title" text NOT NULL,
	"company_name" text NOT NULL,
	"employment_type" text NOT NULL,
	"location" text,
	"description" text,
	"start_date" timestamp with time zone NOT NULL,
	"end_date" timestamp with time zone,
	"is_current" boolean DEFAULT false NOT NULL,
	"sort_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "skills" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"career_profile_id" uuid NOT NULL,
	"name" text NOT NULL,
	"category" text NOT NULL,
	"level" text NOT NULL,
	"years_of_experience" integer DEFAULT 0 NOT NULL,
	"verified" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "languages" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"career_profile_id" uuid NOT NULL,
	"language" varchar(100) NOT NULL,
	"proficiency_level" "language_proficiency_level" NOT NULL,
	"reading_level" "language_skill_level" NOT NULL,
	"writing_level" "language_skill_level" NOT NULL,
	"speaking_level" "language_skill_level" NOT NULL,
	"is_primary" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "projects" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"career_profile_id" uuid NOT NULL,
	"title" varchar(200) NOT NULL,
	"description" text,
	"role" varchar(150),
	"company" varchar(200),
	"technologies" jsonb DEFAULT '[]'::jsonb,
	"github_url" text,
	"live_url" text,
	"image_url" text,
	"start_date" timestamp with time zone,
	"end_date" timestamp with time zone,
	"is_current" boolean DEFAULT false NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "social_links" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"career_profile_id" uuid NOT NULL,
	"platform" "social_link_platform" NOT NULL,
	"url" text NOT NULL,
	"display_name" varchar(100),
	"visibility" "social_link_visibility" DEFAULT 'PUBLIC' NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "job_preferences" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"career_profile_id" uuid NOT NULL,
	"desired_job_titles" jsonb DEFAULT '[]'::jsonb,
	"preferred_job_categories" jsonb DEFAULT '[]'::jsonb,
	"work_environments" jsonb DEFAULT '[]'::jsonb,
	"employment_types" jsonb DEFAULT '[]'::jsonb,
	"minimum_salary" integer,
	"maximum_salary" integer,
	"currency" "currency" DEFAULT 'USD',
	"preferred_cities" jsonb DEFAULT '[]'::jsonb,
	"preferred_countries" jsonb DEFAULT '[]'::jsonb,
	"open_to_relocation" boolean DEFAULT false NOT NULL,
	"available_immediately" boolean DEFAULT false NOT NULL,
	"notice_period_days" integer DEFAULT 0,
	"willing_to_travel" boolean DEFAULT false NOT NULL,
	"open_to_international_jobs" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "job_preferences_career_profile_id_unique" UNIQUE("career_profile_id")
);
--> statement-breakpoint
CREATE TABLE "referrals" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"referrer_user_id" uuid NOT NULL,
	"referred_user_id" uuid NOT NULL,
	"referral_code" varchar(20) NOT NULL,
	"status" "referral_status" DEFAULT 'PENDING' NOT NULL,
	"reward_amount" numeric(10, 2) DEFAULT '0.10' NOT NULL,
	"reward_paid" boolean DEFAULT false NOT NULL,
	"reward_paid_at" timestamp with time zone,
	"payment_note" text,
	"career_profile_completed_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "recruiters" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"company_id" uuid NOT NULL,
	"user_id" uuid NOT NULL,
	"title" varchar(255),
	"phone" varchar(20),
	"bio" text,
	"created_by" uuid NOT NULL,
	"updated_by" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"deleted_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "jobs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"company_id" uuid NOT NULL,
	"title" text NOT NULL,
	"slug" text NOT NULL,
	"description" text NOT NULL,
	"requirements" text,
	"responsibilities" text,
	"employment_type" text NOT NULL,
	"work_mode" text DEFAULT 'onsite' NOT NULL,
	"experience_level" text NOT NULL,
	"country" text,
	"city" text,
	"salary_min" integer,
	"salary_max" integer,
	"currency" text DEFAULT 'USD' NOT NULL,
	"status" text DEFAULT 'draft' NOT NULL,
	"expires_at" timestamp with time zone,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "jobs_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "maps" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"latitude" numeric(10, 8) NOT NULL,
	"longitude" numeric(11, 8) NOT NULL,
	"location_name" varchar(255) NOT NULL,
	"city" varchar(100) NOT NULL,
	"state" varchar(100),
	"country" varchar(100) NOT NULL,
	"postal_code" varchar(20),
	"address" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "saved_jobs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"career_profile_id" uuid NOT NULL,
	"job_id" uuid NOT NULL,
	"saved_at" timestamp with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "unique_saved_job" UNIQUE("career_profile_id","job_id")
);
--> statement-breakpoint
CREATE TABLE "notifications" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"type" varchar(50) NOT NULL,
	"title" varchar(255) NOT NULL,
	"message" text NOT NULL,
	"data" jsonb,
	"is_read" boolean DEFAULT false NOT NULL,
	"read_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "messages" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"conversation_id" uuid NOT NULL,
	"sender_id" uuid NOT NULL,
	"content" text NOT NULL,
	"attachment_url" text,
	"is_edited" boolean DEFAULT false NOT NULL,
	"edited_at" timestamp with time zone,
	"deleted_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "referral_code" varchar(20);--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "successful_invites" integer DEFAULT 0 NOT NULL;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "estimated_reward" numeric(10, 2) DEFAULT '0' NOT NULL;--> statement-breakpoint
ALTER TABLE "applications" ADD CONSTRAINT "applications_career_profile_id_career_profiles_id_fk" FOREIGN KEY ("career_profile_id") REFERENCES "public"."career_profiles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "applications" ADD CONSTRAINT "applications_job_id_jobs_id_fk" FOREIGN KEY ("job_id") REFERENCES "public"."jobs"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "companies" ADD CONSTRAINT "companies_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "companies" ADD CONSTRAINT "companies_updated_by_users_id_fk" FOREIGN KEY ("updated_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "company_locations" ADD CONSTRAINT "company_locations_company_id_companies_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "company_locations" ADD CONSTRAINT "company_locations_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "company_locations" ADD CONSTRAINT "company_locations_updated_by_users_id_fk" FOREIGN KEY ("updated_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "company_members" ADD CONSTRAINT "company_members_company_id_companies_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "company_members" ADD CONSTRAINT "company_members_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "company_members" ADD CONSTRAINT "company_members_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "company_members" ADD CONSTRAINT "company_members_updated_by_users_id_fk" FOREIGN KEY ("updated_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "departments" ADD CONSTRAINT "departments_company_id_companies_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "departments" ADD CONSTRAINT "departments_manager_user_id_users_id_fk" FOREIGN KEY ("manager_user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "departments" ADD CONSTRAINT "departments_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "departments" ADD CONSTRAINT "departments_updated_by_users_id_fk" FOREIGN KEY ("updated_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "recruiters" ADD CONSTRAINT "recruiters_company_id_companies_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "recruiters" ADD CONSTRAINT "recruiters_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "recruiters" ADD CONSTRAINT "recruiters_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "recruiters" ADD CONSTRAINT "recruiters_updated_by_users_id_fk" FOREIGN KEY ("updated_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "saved_jobs" ADD CONSTRAINT "saved_jobs_career_profile_id_career_profiles_id_fk" FOREIGN KEY ("career_profile_id") REFERENCES "public"."career_profiles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "saved_jobs" ADD CONSTRAINT "saved_jobs_job_id_jobs_id_fk" FOREIGN KEY ("job_id") REFERENCES "public"."jobs"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "messages" ADD CONSTRAINT "messages_conversation_id_conversations_id_fk" FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "messages" ADD CONSTRAINT "messages_sender_id_users_id_fk" FOREIGN KEY ("sender_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "applications_career_profile_idx" ON "applications" USING btree ("career_profile_id");--> statement-breakpoint
CREATE INDEX "applications_job_idx" ON "applications" USING btree ("job_id");--> statement-breakpoint
CREATE INDEX "applications_status_idx" ON "applications" USING btree ("status");--> statement-breakpoint
CREATE INDEX "attachments_career_profile_id_idx" ON "attachments" USING btree ("career_profile_id");--> statement-breakpoint
CREATE INDEX "attachments_type_idx" ON "attachments" USING btree ("type");--> statement-breakpoint
CREATE INDEX "attachments_storage_provider_idx" ON "attachments" USING btree ("storage_provider");--> statement-breakpoint
CREATE INDEX "attachments_is_default_idx" ON "attachments" USING btree ("is_default");--> statement-breakpoint
CREATE INDEX "career_profiles_user_id_idx" ON "career_profiles" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "career_profiles_status_idx" ON "career_profiles" USING btree ("profile_status");--> statement-breakpoint
CREATE INDEX "career_profiles_privacy_idx" ON "career_profiles" USING btree ("privacy_level");--> statement-breakpoint
CREATE INDEX "certificates_career_profile_id_idx" ON "certificates" USING btree ("career_profile_id");--> statement-breakpoint
CREATE INDEX "certificates_verification_status_idx" ON "certificates" USING btree ("verification_status");--> statement-breakpoint
CREATE INDEX "certificates_display_order_idx" ON "certificates" USING btree ("display_order");--> statement-breakpoint
CREATE INDEX "conversations_last_message_at_idx" ON "conversations" USING btree ("last_message_at");--> statement-breakpoint
CREATE INDEX "conversations_is_active_idx" ON "conversations" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "education_career_profile_id_idx" ON "education" USING btree ("career_profile_id");--> statement-breakpoint
CREATE INDEX "education_is_current_idx" ON "education" USING btree ("is_current");--> statement-breakpoint
CREATE INDEX "experiences_career_profile_id_idx" ON "experiences" USING btree ("career_profile_id");--> statement-breakpoint
CREATE INDEX "experiences_is_current_idx" ON "experiences" USING btree ("is_current");--> statement-breakpoint
CREATE INDEX "languages_career_profile_id_idx" ON "languages" USING btree ("career_profile_id");--> statement-breakpoint
CREATE INDEX "languages_proficiency_level_idx" ON "languages" USING btree ("proficiency_level");--> statement-breakpoint
CREATE INDEX "projects_career_profile_id_idx" ON "projects" USING btree ("career_profile_id");--> statement-breakpoint
CREATE INDEX "projects_display_order_idx" ON "projects" USING btree ("display_order");--> statement-breakpoint
CREATE INDEX "projects_is_current_idx" ON "projects" USING btree ("is_current");--> statement-breakpoint
CREATE INDEX "social_links_career_profile_id_idx" ON "social_links" USING btree ("career_profile_id");--> statement-breakpoint
CREATE INDEX "social_links_platform_idx" ON "social_links" USING btree ("platform");--> statement-breakpoint
CREATE INDEX "social_links_visibility_idx" ON "social_links" USING btree ("visibility");--> statement-breakpoint
CREATE INDEX "social_links_display_order_idx" ON "social_links" USING btree ("display_order");--> statement-breakpoint
CREATE INDEX "job_preferences_career_profile_id_idx" ON "job_preferences" USING btree ("career_profile_id");--> statement-breakpoint
CREATE INDEX "referrals_referrer_user_id_idx" ON "referrals" USING btree ("referrer_user_id");--> statement-breakpoint
CREATE INDEX "referrals_referred_user_id_idx" ON "referrals" USING btree ("referred_user_id");--> statement-breakpoint
CREATE INDEX "referrals_status_idx" ON "referrals" USING btree ("status");--> statement-breakpoint
CREATE INDEX "referrals_reward_paid_idx" ON "referrals" USING btree ("reward_paid");--> statement-breakpoint
CREATE INDEX "jobs_company_id_idx" ON "jobs" USING btree ("company_id");--> statement-breakpoint
CREATE INDEX "jobs_slug_idx" ON "jobs" USING btree ("slug");--> statement-breakpoint
CREATE INDEX "jobs_status_idx" ON "jobs" USING btree ("status");--> statement-breakpoint
CREATE INDEX "jobs_employment_type_idx" ON "jobs" USING btree ("employment_type");--> statement-breakpoint
CREATE INDEX "jobs_is_active_idx" ON "jobs" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "maps_latitude_idx" ON "maps" USING btree ("latitude");--> statement-breakpoint
CREATE INDEX "maps_longitude_idx" ON "maps" USING btree ("longitude");--> statement-breakpoint
CREATE INDEX "maps_city_idx" ON "maps" USING btree ("city");--> statement-breakpoint
CREATE INDEX "maps_country_idx" ON "maps" USING btree ("country");--> statement-breakpoint
CREATE INDEX "saved_jobs_career_profile_idx" ON "saved_jobs" USING btree ("career_profile_id");--> statement-breakpoint
CREATE INDEX "saved_jobs_job_idx" ON "saved_jobs" USING btree ("job_id");--> statement-breakpoint
CREATE INDEX "notifications_user_idx" ON "notifications" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "notifications_type_idx" ON "notifications" USING btree ("type");--> statement-breakpoint
CREATE INDEX "notifications_is_read_idx" ON "notifications" USING btree ("is_read");--> statement-breakpoint
CREATE INDEX "notifications_created_at_idx" ON "notifications" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "messages_conversation_idx" ON "messages" USING btree ("conversation_id");--> statement-breakpoint
CREATE INDEX "messages_sender_idx" ON "messages" USING btree ("sender_id");--> statement-breakpoint
CREATE INDEX "messages_created_at_idx" ON "messages" USING btree ("created_at");--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_referral_code_unique" UNIQUE("referral_code");