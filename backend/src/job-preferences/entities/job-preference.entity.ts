export class JobPreferenceEntity {
  id!: string;
  careerProfileId!: string;
  desiredJobTitles!: string[];
  preferredJobCategories!: string[];
  workEnvironments!: ('ON_SITE' | 'REMOTE' | 'HYBRID')[];
  employmentTypes!: ('FULL_TIME' | 'PART_TIME' | 'CONTRACT' | 'INTERNSHIP' | 'FREELANCE' | 'TEMPORARY')[];
  minimumSalary!: number | null;
  maximumSalary!: number | null;
  currency!:
    | 'USD'
    | 'EUR'
    | 'GBP'
    | 'AED'
    | 'SAR'
    | 'KWD'
    | 'QAR'
    | 'OMR'
    | 'BHD'
    | 'JOD'
    | 'EGP'
    | 'IQD'
    | 'LBP';
  preferredCities!: string[];
  preferredCountries!: string[];
  openToRelocation!: boolean;
  availableImmediately!: boolean;
  noticePeriodDays!: number;
  willingToTravel!: boolean;
  openToInternationalJobs!: boolean;
  createdAt!: Date;
  updatedAt!: Date;
}
