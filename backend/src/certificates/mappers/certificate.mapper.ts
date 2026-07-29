import { CertificateEntity } from '../entities/certificate.entity';
import { CertificateResponseDto } from '../dto/certificate-response.dto';

export class CertificateMapper {
  static toResponse(entity: CertificateEntity): CertificateResponseDto {
    const dto = new CertificateResponseDto();

    dto.id = entity.id;
    dto.careerProfileId = entity.careerProfileId;
    dto.name = entity.name;
    dto.issuer = entity.issuer;
    dto.credentialId = entity.credentialId;
    dto.credentialUrl = entity.credentialUrl;
    dto.issueDate = entity.issueDate;
    dto.expiryDate = entity.expiryDate;
    dto.doesNotExpire = entity.doesNotExpire;
    dto.verificationStatus = entity.verificationStatus;
    dto.displayOrder = entity.displayOrder;
    dto.createdAt = entity.createdAt;
    dto.updatedAt = entity.updatedAt;

    return dto;
  }
}
