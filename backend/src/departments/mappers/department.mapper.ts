import { DepartmentEntity } from '../entities/department.entity';
import { DepartmentResponseDto } from '../dto/department-response.dto';

export class DepartmentMapper {
  static toResponse(entity: DepartmentEntity): DepartmentResponseDto {
    const dto = new DepartmentResponseDto();
    dto.id = entity.id;
    dto.companyId = entity.companyId;
    dto.name = entity.name;
    dto.slug = entity.slug;
    dto.description = entity.description;
    dto.managerUserId = entity.managerUserId;
    dto.createdBy = entity.createdBy;
    dto.updatedBy = entity.updatedBy;
    dto.createdAt = entity.createdAt;
    dto.updatedAt = entity.updatedAt;
    dto.deletedAt = entity.deletedAt;
    return dto;
  }
}
