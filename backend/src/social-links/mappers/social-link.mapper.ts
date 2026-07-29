import { SocialLinkEntity } from '../entities/social-link.entity';
import { SocialLinkResponseDto } from '../dto/social-link-response.dto';

export class SocialLinkMapper {
  static toResponse(entity: SocialLinkEntity): SocialLinkResponseDto {
    const dto = new SocialLinkResponseDto();

    dto.id = entity.id;
    dto.careerProfileId = entity.careerProfileId;
    dto.platform = entity.platform;
    dto.url = entity.url;
    dto.displayName = entity.displayName;
    dto.visibility = entity.visibility;
    dto.displayOrder = entity.displayOrder;
    dto.createdAt = entity.createdAt;
    dto.updatedAt = entity.updatedAt;

    return dto;
  }
}
