export class ProfileCompletionResponseDto {
  percentage!: number;
  completedSections!: number;
  totalSections!: number;
  sections!: {
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
  nextSuggestions!: string[];
}
