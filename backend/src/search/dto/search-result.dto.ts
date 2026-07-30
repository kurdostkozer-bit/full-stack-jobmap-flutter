export class SearchResultDto {
  type: 'JOB' | 'COMPANY' | 'USER' | 'PROFILE';
  id: string;
  title: string;
  description?: string;
  imageUrl?: string;
  metadata?: Record<string, any>;
}

export class SearchResponseDto {
  query: string;
  results: SearchResultDto[];
  totalCount: number;
  limit: number;
  offset: number;
}
