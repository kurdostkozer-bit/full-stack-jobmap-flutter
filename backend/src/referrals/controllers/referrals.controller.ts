import {
  Controller,
  Get,
  Param,
  Patch,
  Body,
  ParseUUIDPipe,
  UseGuards,
} from '@nestjs/common';

import { ReferralsService } from '../services/referrals.service';
import { UserReferralStatsDto } from '../dto/user-referral-stats.dto';
import { AdminReferralStatsDto } from '../dto/admin-referral-stats.dto';
import { MarkReferralPaidDto } from '../dto/mark-referral-paid.dto';

@Controller({ path: 'referrals', version: '1' })
export class ReferralsController {
  constructor(private readonly referralsService: ReferralsService) {}

  @Get('user/:userId')
  async getUserReferralStats(
    @Param('userId', ParseUUIDPipe) userId: string,
  ): Promise<UserReferralStatsDto> {
    return this.referralsService.getUserReferralStats(userId);
  }

  @Get('admin/:referrerId')
  async getAdminReferralStats(
    @Param('referrerId', ParseUUIDPipe) referrerId: string,
  ): Promise<AdminReferralStatsDto> {
    return this.referralsService.getAdminReferralStats(referrerId);
  }

  @Patch('admin/:referralId/pay')
  async markReferralAsPaid(
    @Param('referralId', ParseUUIDPipe) referralId: string,
    @Body() dto: MarkReferralPaidDto,
  ): Promise<UserReferralStatsDto | null> {
    return this.referralsService.markReferralAsPaid(referralId, dto.paymentNote);
  }
}
