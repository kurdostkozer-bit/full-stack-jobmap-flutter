import { ReferralEntity } from '../entities/referral.entity';
import { ReferralResponseDto } from '../dto/referral-response.dto';

export class ReferralMapper {
  static toResponse(entity: ReferralEntity): ReferralResponseDto {
    const dto = new ReferralResponseDto();
    dto.id = entity.id;
    dto.referrerUserId = entity.referrerUserId;
    dto.referredUserId = entity.referredUserId;
    dto.referralCode = entity.referralCode;
    dto.status = entity.status;
    dto.rewardAmount = parseFloat(entity.rewardAmount as unknown as string);
    dto.rewardPaid = entity.rewardPaid;
    dto.rewardPaidAt = entity.rewardPaidAt;
    dto.paymentNote = entity.paymentNote;
    dto.careerProfileCompletedAt = entity.careerProfileCompletedAt;
    dto.createdAt = entity.createdAt;
    dto.updatedAt = entity.updatedAt;
    return dto;
  }
}
