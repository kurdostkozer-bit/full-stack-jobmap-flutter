import { Controller, Get, Param, ParseUUIDPipe } from '@nestjs/common';

import { ProfileCompletionResponseDto } from '../dto/profile-completion-response.dto';
import { ProfileCompletionService } from '../services/profile-completion.service';

@Controller({ path: 'profile-completion', version: '1' })
export class ProfileCompletionController {
  constructor(private readonly profileCompletionService: ProfileCompletionService) {}

  @Get('career-profile/:careerProfileId')
  async getProfileCompletion(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<ProfileCompletionResponseDto> {
    const entity = await this.profileCompletionService.calculateCompletion(careerProfileId);

    const dto = new ProfileCompletionResponseDto();
    dto.percentage = entity.percentage;
    dto.completedSections = entity.completedSections;
    dto.totalSections = entity.totalSections;
    dto.sections = entity.sections;
    dto.nextSuggestions = entity.nextSuggestions;

    return dto;
  }
}
