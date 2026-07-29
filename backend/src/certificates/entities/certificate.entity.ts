export class CertificateEntity {
  id!: string;
  careerProfileId!: string;
  name!: string;
  issuer!: string;
  credentialId!: string | null;
  credentialUrl!: string | null;
  issueDate!: Date;
  expiryDate!: Date | null;
  doesNotExpire!: boolean;
  verificationStatus!: 'PENDING' | 'VERIFIED' | 'REJECTED';
  displayOrder!: number;
  createdAt!: Date;
  updatedAt!: Date;
}
