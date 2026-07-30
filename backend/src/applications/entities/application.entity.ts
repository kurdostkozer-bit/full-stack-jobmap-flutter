export class ApplicationEntity {
  id: string;
  careerProfileId: string;
  jobId: string;
  status: 'APPLIED' | 'UNDER_REVIEW' | 'SHORTLISTED' | 'REJECTED' | 'WITHDRAWN';
  appliedAt: Date;
  statusUpdatedAt: Date;
  notes?: string;
  createdAt: Date;
  updatedAt: Date;
}
