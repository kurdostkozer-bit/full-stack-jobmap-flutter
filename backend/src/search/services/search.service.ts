import { Injectable } from '@nestjs/common';
import { db } from '../../database/database';
import { jobs, companies, careerProfiles } from '../../database/schema';
import { ilike, or } from 'drizzle-orm';
import { SearchQueryDto, SearchType } from '../dto/search-query.dto';
import { SearchResponseDto, SearchResultDto } from '../dto/search-result.dto';

@Injectable()
export class SearchService {
  async search(dto: SearchQueryDto): Promise<SearchResponseDto> {
    const searchQuery = `%${dto.query}%`;
    const limit = dto.limit || 20;
    const offset = dto.offset || 0;
    const type = dto.type || SearchType.ALL;

    const results: SearchResultDto[] = [];

    // Search Jobs
    if (type === SearchType.ALL || type === SearchType.JOBS) {
      const jobResults = await db
        .select({
          id: jobs.id,
          title: jobs.title,
          description: jobs.description,
        })
        .from(jobs)
        .where(
          or(
            ilike(jobs.title, searchQuery),
            ilike(jobs.description, searchQuery),
          ),
        )
        .limit(limit)
        .offset(offset);

      results.push(
        ...jobResults.map((job) => ({
          type: 'JOB' as const,
          id: job.id,
          title: job.title,
          description: job.description || undefined,
        })),
      );
    }

    // Search Companies
    if (type === SearchType.ALL || type === SearchType.COMPANIES) {
      const companyResults = await db
        .select({
          id: companies.id,
          name: companies.name,
          description: companies.description,
          logo: companies.logo,
        })
        .from(companies)
        .where(
          or(
            ilike(companies.name, searchQuery),
            ilike(companies.description, searchQuery),
          ),
        )
        .limit(limit)
        .offset(offset);

      results.push(
        ...companyResults.map((company) => ({
          type: 'COMPANY' as const,
          id: company.id,
          title: company.name,
          description: company.description || undefined,
          imageUrl: company.logo || undefined,
        })),
      );
    }

    // Search Career Profiles (Users)
    if (type === SearchType.ALL || type === SearchType.PROFILES) {
      const profileResults = await db
        .select({
          id: careerProfiles.id,
          headline: careerProfiles.headline,
          summary: careerProfiles.summary,
        })
        .from(careerProfiles)
        .where(
          or(
            ilike(careerProfiles.headline, searchQuery),
            ilike(careerProfiles.summary, searchQuery),
          ),
        )
        .limit(limit)
        .offset(offset);

      results.push(
        ...profileResults.map((profile) => ({
          type: 'PROFILE' as const,
          id: profile.id,
          title: profile.headline || 'Profile',
          description: profile.summary || undefined,
        })),
      );
    }

    return {
      query: dto.query,
      results: results.slice(0, limit),
      totalCount: results.length,
      limit,
      offset,
    };
  }

  async searchJobs(query: string, limit: number = 20): Promise<SearchResultDto[]> {
    const searchQuery = `%${query}%`;

    const results = await db
      .select({
        id: jobs.id,
        title: jobs.title,
        description: jobs.description,
      })
      .from(jobs)
      .where(
        or(
          ilike(jobs.title, searchQuery),
          ilike(jobs.description, searchQuery),
        ),
      )
      .limit(limit);

    return results.map((job) => ({
      type: 'JOB' as const,
      id: job.id,
      title: job.title,
      description: job.description || undefined,
    }));
  }

  async searchCompanies(query: string, limit: number = 20): Promise<SearchResultDto[]> {
    const searchQuery = `%${query}%`;

    const results = await db
      .select({
        id: companies.id,
        name: companies.name,
        description: companies.description,
        logo: companies.logo,
      })
      .from(companies)
      .where(
        or(
          ilike(companies.name, searchQuery),
          ilike(companies.description, searchQuery),
        ),
      )
      .limit(limit);

    return results.map((company) => ({
      type: 'COMPANY' as const,
      id: company.id,
      title: company.name,
      description: company.description || undefined,
      imageUrl: company.logo || undefined,
    }));
  }

  async searchProfiles(query: string, limit: number = 20): Promise<SearchResultDto[]> {
    const searchQuery = `%${query}%`;

    const results = await db
      .select({
        id: careerProfiles.id,
        headline: careerProfiles.headline,
        summary: careerProfiles.summary,
      })
      .from(careerProfiles)
      .where(
        or(
          ilike(careerProfiles.headline, searchQuery),
          ilike(careerProfiles.summary, searchQuery),
        ),
      )
      .limit(limit);

    return results.map((profile) => ({
      type: 'PROFILE' as const,
      id: profile.id,
      title: profile.headline || 'Profile',
      description: profile.summary || undefined,
    }));
  }
}
