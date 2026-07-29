import { CompanyLocationEntity } from '../entities/company-location.entity';
import { CompanyLocationResponseDto } from '../dto/company-location-response.dto';

export class CompanyLocationMapper {
  static toResponse(entity: CompanyLocationEntity): CompanyLocationResponseDto {
    const dto = new CompanyLocationResponseDto();
    dto.id = entity.id;
    dto.companyId = entity.companyId;
    dto.name = entity.name;
    dto.address = entity.address;
    dto.city = entity.city;
    dto.country = entity.country;
    dto.postalCode = entity.postalCode;
    dto.latitude = entity.latitude;
    dto.longitude = entity.longitude;
    dto.isHeadquarters = entity.isHeadquarters;
    dto.createdBy = entity.createdBy;
    dto.updatedBy = entity.updatedBy;
    dto.createdAt = entity.createdAt;
    dto.updatedAt = entity.updatedAt;
    dto.deletedAt = entity.deletedAt;
    return dto;
  }
}
