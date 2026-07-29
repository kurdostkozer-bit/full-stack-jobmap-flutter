import { CompanyMemberEntity } from '../entities/company-member.entity';
import { CompanyMemberResponseDto } from '../dto/company-member-response.dto';

export class CompanyMemberMapper {
  static toResponse(entity: CompanyMemberEntity): CompanyMemberResponseDto {
    const dto = new CompanyMemberResponseDto();
    dto.id = entity.id;
    dto.companyId = entity.companyId;
    dto.userId = entity.userId;
    dto.role = entity.role;
    dto.createdBy = entity.createdBy;
    dto.updatedBy = entity.updatedBy;
    dto.createdAt = entity.createdAt;
    dto.updatedAt = entity.updatedAt;
    dto.deletedAt = entity.deletedAt;
    return dto;
  }
}
