import { IsString, IsOptional, IsNumber, Min, Max } from 'class-validator';

export class LocationSearchDto {
  @IsString()
  query: string;

  @IsOptional()
  @IsString()
  city?: string;

  @IsOptional()
  @IsString()
  state?: string;

  @IsOptional()
  @IsString()
  country?: string;

  @IsOptional()
  @IsNumber()
  @Min(1)
  @Max(100)
  limit?: number;
}
