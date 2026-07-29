import { Injectable } from '@nestjs/common';
import { db } from '../../database/database';
import {
  careerProfiles,
  skills,
  experiences,
  education,
  languages,
  projects,
  certificates,
  socialLinks,
  attachments,
  jobPreferences,
} from '../../database/schema';
import { eq } from 'drizzle-orm';
import { ProfileCompletionEntity } from '../entities/profile-completion.entity';

interface SectionScore {
  name: string;
  weight: number;
  isComplete: boolean;
  suggestion?: string;
}

@Injectable()
export class ProfileCompletionService {
  private readonly sectionWeights: Record<string, SectionScore> = {
    careerProfile: {
      name: 'Career Profile',
      weight: 15,
      isComplete: false,
      suggestion: 'Complete your basic profile information',
    },
    skills: {
      name: 'Skills',
      weight: 10,
      isComplete: false,
      suggestion: 'Add at least one skill',
    },
    experience: {
      name: 'Experience',
      weight: 15,
      isComplete: false,
      suggestion: 'Add your work experience',
    },
    education: {
      name: 'Education',
      weight: 10,
      isComplete: false,
      suggestion: 'Add your education history',
    },
    languages: {
      name: 'Languages',
      weight: 10,
      isComplete: false,
      suggestion: 'Add languages you speak',
    },
    projects: {
      name: 'Projects',
      weight: 10,
      isComplete: false,
      suggestion: 'Add your projects',
    },
    certificates: {
      name: 'Certificates',
      weight: 5,
      isComplete: false,
      suggestion: 'Add your certifications',
    },
    socialLinks: {
      name: 'Social Links',
      weight: 5,
      isComplete: false,
      suggestion: 'Add your portfolio and social links',
    },
    attachments: {
      name: 'Attachments',
      weight: 10,
      isComplete: false,
      suggestion: 'Upload your resume and documents',
    },
    jobPreferences: {
      name: 'Job Preferences',
      weight: 10,
      isComplete: false,
      suggestion: 'Set your job preferences',
    },
  };

  async calculateCompletion(careerProfileId: string): Promise<ProfileCompletionEntity> {
    // Check each section's completion status
    const sections = await this.checkAllSections(careerProfileId);

    // Calculate score
    let totalScore = 0;
    let completedCount = 0;

    for (const [key, section] of Object.entries(this.sectionWeights)) {
      if (sections[key as keyof typeof sections]) {
        totalScore += section.weight;
        completedCount++;
      }
    }

    // Generate suggestions for incomplete sections
    const nextSuggestions: string[] = [];
    for (const [key, section] of Object.entries(this.sectionWeights)) {
      if (!sections[key as keyof typeof sections] && section.suggestion) {
        nextSuggestions.push(section.suggestion);
      }
    }

    const entity = new ProfileCompletionEntity();
    entity.percentage = Math.round(totalScore);
    entity.completedSections = completedCount;
    entity.totalSections = Object.keys(this.sectionWeights).length;
    entity.sections = sections as {
      careerProfile: boolean;
      skills: boolean;
      experience: boolean;
      education: boolean;
      languages: boolean;
      projects: boolean;
      certificates: boolean;
      socialLinks: boolean;
      attachments: boolean;
      jobPreferences: boolean;
    };
    entity.nextSuggestions = nextSuggestions;

    return entity;
  }

  private async checkAllSections(
    careerProfileId: string,
  ): Promise<Record<string, boolean>> {
    return {
      careerProfile: await this.isCareerProfileComplete(careerProfileId),
      skills: await this.hasSkills(careerProfileId),
      experience: await this.hasExperience(careerProfileId),
      education: await this.hasEducation(careerProfileId),
      languages: await this.hasLanguages(careerProfileId),
      projects: await this.hasProjects(careerProfileId),
      certificates: await this.hasCertificates(careerProfileId),
      socialLinks: await this.hasSocialLinks(careerProfileId),
      attachments: await this.hasAttachments(careerProfileId),
      jobPreferences: await this.hasJobPreferences(careerProfileId),
    };
  }

  private async isCareerProfileComplete(careerProfileId: string): Promise<boolean> {
    const [profile] = await db
      .select()
      .from(careerProfiles)
      .where(eq(careerProfiles.id, careerProfileId));

    if (!profile) return false;

    // Check if basic fields are filled
    return !!(
      (profile.headline || profile.summary) &&
      profile.professionTitle
    );
  }

  private async hasSkills(careerProfileId: string): Promise<boolean> {
    const count = await db
      .select()
      .from(skills)
      .where(eq(skills.careerProfileId, careerProfileId));

    return count.length > 0;
  }

  private async hasExperience(careerProfileId: string): Promise<boolean> {
    const count = await db
      .select()
      .from(experiences)
      .where(eq(experiences.careerProfileId, careerProfileId));

    return count.length > 0;
  }

  private async hasEducation(careerProfileId: string): Promise<boolean> {
    const count = await db
      .select()
      .from(education)
      .where(eq(education.careerProfileId, careerProfileId));

    return count.length > 0;
  }

  private async hasLanguages(careerProfileId: string): Promise<boolean> {
    const count = await db
      .select()
      .from(languages)
      .where(eq(languages.careerProfileId, careerProfileId));

    return count.length > 0;
  }

  private async hasProjects(careerProfileId: string): Promise<boolean> {
    const count = await db
      .select()
      .from(projects)
      .where(eq(projects.careerProfileId, careerProfileId));

    return count.length > 0;
  }

  private async hasCertificates(careerProfileId: string): Promise<boolean> {
    const count = await db
      .select()
      .from(certificates)
      .where(eq(certificates.careerProfileId, careerProfileId));

    return count.length > 0;
  }

  private async hasSocialLinks(careerProfileId: string): Promise<boolean> {
    const count = await db
      .select()
      .from(socialLinks)
      .where(eq(socialLinks.careerProfileId, careerProfileId));

    return count.length > 0;
  }

  private async hasAttachments(careerProfileId: string): Promise<boolean> {
    const count = await db
      .select()
      .from(attachments)
      .where(eq(attachments.careerProfileId, careerProfileId));

    return count.length > 0;
  }

  private async hasJobPreferences(careerProfileId: string): Promise<boolean> {
    const [record] = await db
      .select()
      .from(jobPreferences)
      .where(eq(jobPreferences.careerProfileId, careerProfileId));

    return !!record;
  }
}
