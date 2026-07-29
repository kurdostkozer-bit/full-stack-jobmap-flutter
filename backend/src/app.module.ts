import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';

import appConfig from './config/app.config';

import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { ProfilesModule } from './profiles/profiles.module';
import { SkillsModule } from './skills/skills.module';
import { CareerProfilesModule } from './career-profiles/career-profiles.module';
import { ExperiencesModule } from './experiences/experiences.module';
import { EducationModule } from './education/education.module';
import { LanguagesModule } from './languages/languages.module';
import { CertificatesModule } from './certificates/certificates.module';
import { ProjectsModule } from './projects/projects.module';
import { SocialLinksModule } from './social-links/social-links.module';
import { AttachmentsModule } from './attachments/attachments.module';
import { JobPreferencesModule } from './job-preferences/job-preferences.module';
import { ProfileCompletionModule } from './profile-completion/profile-completion.module';
import { ReferralsModule } from './referrals/referrals.module';
import { CompaniesModule } from './companies/companies.module';
import { CompanyMembersModule } from './company-members/company-members.module';
import { RecruitersModule } from './recruiters/recruiters.module';
import { DepartmentsModule } from './departments/departments.module';
import { CompanyLocationsModule } from './company-locations/company-locations.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      load: [appConfig],
    }),

    AuthModule,
    UsersModule,
    ProfilesModule,
    SkillsModule,
    CareerProfilesModule,
    ExperiencesModule,
    EducationModule,
    LanguagesModule,
    CertificatesModule,
    ProjectsModule,
    SocialLinksModule,
    AttachmentsModule,
    JobPreferencesModule,
    ProfileCompletionModule,
    ReferralsModule,
    CompaniesModule,
    CompanyMembersModule,
    RecruitersModule,
    DepartmentsModule,
    CompanyLocationsModule,
  ],
})
export class AppModule {}
