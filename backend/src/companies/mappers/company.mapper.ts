import { CompanyEntity } from '../entities/company.entity';
import { CompanyResponseDto } from '../dto/company-response.dto';

export class CompanyMapper {
  static toResponse(entity: CompanyEntity): CompanyResponseDto {
    const dto = new CompanyResponseDto();
    dto.id = entity.id;
    dto.name = entity.name;
    dto.slug = entity.slug;
    dto.logo = entity.logo;
    dto.coverImage = entity.coverImage;
    dto.description = entity.description;
    dto.industry = entity.industry;
    dto.companySize = entity.companySize;
    dto.foundedYear = entity.foundedYear;
    dto.website = entity.website;
    dto.email = entity.email;
    dto.phone = entity.phone;
    dto.country = entity.country;
    dto.city = entity.city;
    dto.address = entity.address;
    dto.verificationStatus = entity.verificationStatus;
    dto.status = entity.status;
    dto.createdBy = entity.createdBy;
    dto.updatedBy = entity.updatedBy;
    dto.createdAt = entity.createdAt;
    dto.updatedAt = entity.updatedAt;
    dto.deletedAt = entity.deletedAt;
    return dto;
  }
}
