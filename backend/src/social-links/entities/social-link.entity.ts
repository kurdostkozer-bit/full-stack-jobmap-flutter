export class SocialLinkEntity {
  id!: string;
  careerProfileId!: string;
  platform!:
    | 'LINKEDIN'
    | 'GITHUB'
    | 'GITLAB'
    | 'STACKOVERFLOW'
    | 'BEHANCE'
    | 'DRIBBBLE'
    | 'PERSONAL_WEBSITE'
    | 'X'
    | 'FACEBOOK'
    | 'INSTAGRAM'
    | 'YOUTUBE'
    | 'TELEGRAM';
  url!: string;
  displayName!: string | null;
  visibility!: 'PUBLIC' | 'PRIVATE';
  displayOrder!: number;
  createdAt!: Date;
  updatedAt!: Date;
}
