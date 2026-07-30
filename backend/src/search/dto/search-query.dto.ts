import { IsString, IsOptional, IsEnum, Min, Max } from 'class-validator';

export enum SearchType {
  ALL = 'ALL',
  JOBS = 'JOBS',
  COMPANIES = 'COMPANIES',
  USERS = 'USERS',
  PROFILES = 'PROFILES',
}

export class SearchQueryDto {
  @IsString()
  query: string;

  @IsOptional()
  @IsEnum(SearchType)
  type?: SearchType;

  @IsOptional()
  @Min(1)
  @Max(100)
  limit?: number;

  @IsOptional()
  @Min(0)
  offset?: number;
}
