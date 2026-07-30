import {
  Controller,
  Get,
  Query,
} from '@nestjs/common';
import { SearchService } from '../services/search.service';
import { SearchQueryDto } from '../dto/search-query.dto';
import { SearchResultDto, SearchResponseDto } from '../dto/search-result.dto';

@Controller({ path: 'search', version: '1' })
export class SearchController {
  constructor(private readonly searchService: SearchService) {}

  @Get()
  async search(@Query() dto: SearchQueryDto): Promise<SearchResponseDto> {
    return this.searchService.search(dto);
  }

  @Get('jobs')
  async searchJobs(
    @Query('query') query: string,
    @Query('limit') limit?: string,
  ): Promise<SearchResultDto[]> {
    return this.searchService.searchJobs(query, limit ? parseInt(limit) : 20);
  }

  @Get('companies')
  async searchCompanies(
    @Query('query') query: string,
    @Query('limit') limit?: string,
  ): Promise<SearchResultDto[]> {
    return this.searchService.searchCompanies(query, limit ? parseInt(limit) : 20);
  }

  @Get('profiles')
  async searchProfiles(
    @Query('query') query: string,
    @Query('limit') limit?: string,
  ): Promise<SearchResultDto[]> {
    return this.searchService.searchProfiles(query, limit ? parseInt(limit) : 20);
  }
}
