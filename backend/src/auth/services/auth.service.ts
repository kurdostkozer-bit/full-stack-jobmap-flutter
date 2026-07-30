import {
  ConflictException,
  Injectable,
  UnauthorizedException,
  BadRequestException,
  NotFoundException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import * as bcrypt from 'bcrypt';

import { LoginDto } from '../dto/login.dto';
import { RegisterDto } from '../dto/register.dto';
import { ChangePasswordDto } from '../dto/change-password.dto';
import { ResetPasswordDto } from '../dto/reset-password.dto';
import { UsersRepository } from '../repositories/users.repository';
import { ProfilesService } from '../../profiles/services/profiles.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
    private readonly usersRepository: UsersRepository,
    private readonly profilesService: ProfilesService,
  ) {}

  /**
   * Register a new user.
   */
  async register(dto: RegisterDto) {
    const existingUser = await this.usersRepository.findByEmail(dto.email);

    if (existingUser) {
      throw new ConflictException('Email is already registered.');
    }

    const passwordHash = await this.hashPassword(dto.password);

    const user = await this.usersRepository.create({
      email: dto.email,
      passwordHash,
    });

    await this.profilesService.create(user.id);

    const accessToken = await this.generateAccessToken(user.id, user.email);
    const refreshToken = await this.generateRefreshToken(user.id, user.email);

    return {
      message: 'Registration completed successfully.',
      accessToken,
      refreshToken,
      user: {
        id: user.id,
        email: user.email,
        isEmailVerified: user.isEmailVerified,
        createdAt: user.createdAt,
      },
    };
  }

  /**
   * Login existing user.
   */
  async login(dto: LoginDto) {
    const user = await this.usersRepository.findByEmail(dto.email);

    if (!user) {
      throw new UnauthorizedException('Invalid email or password.');
    }

    const isValidPassword = await this.verifyPassword(
      dto.password,
      user.passwordHash,
    );

    if (!isValidPassword) {
      throw new UnauthorizedException('Invalid email or password.');
    }

    const accessToken = await this.generateAccessToken(user.id, user.email);
    const refreshToken = await this.generateRefreshToken(user.id, user.email);

    return {
      message: 'Login successful.',
      accessToken,
      refreshToken,
      user: {
        id: user.id,
        email: user.email,
        isEmailVerified: user.isEmailVerified,
        createdAt: user.createdAt,
      },
    };
  }

  /**
   * Refresh access token using refresh token.
   */
  async refreshToken(refreshToken: string) {
    try {
      const payload = await this.jwtService.verifyAsync(refreshToken, {
        secret: this.configService.getOrThrow<string>('JWT_REFRESH_SECRET'),
      });

      const user = await this.usersRepository.findById(payload.sub);

      if (!user) {
        throw new UnauthorizedException('User not found.');
      }

      const newAccessToken = await this.generateAccessToken(user.id, user.email);

      return {
        message: 'Token refreshed successfully.',
        accessToken: newAccessToken,
      };
    } catch (error) {
      throw new UnauthorizedException('Invalid or expired refresh token.');
    }
  }

  /**
   * Change user password.
   */
  async changePassword(userId: string, dto: ChangePasswordDto) {
    const user = await this.usersRepository.findById(userId);

    if (!user) {
      throw new NotFoundException('User not found.');
    }

    const isValidPassword = await this.verifyPassword(
      dto.currentPassword,
      user.passwordHash,
    );

    if (!isValidPassword) {
      throw new UnauthorizedException('Current password is incorrect.');
    }

    if (dto.newPassword === dto.currentPassword) {
      throw new BadRequestException('New password must be different from current password.');
    }

    const newPasswordHash = await this.hashPassword(dto.newPassword);

    await this.usersRepository.updatePasswordHash(userId, newPasswordHash);

    return {
      message: 'Password changed successfully.',
    };
  }

  /**
   * Verify email (stub - would need email service).
   */
  async verifyEmail(userId: string, code: string) {
    // This is a placeholder - implement with actual email verification logic
    const user = await this.usersRepository.findById(userId);

    if (!user) {
      throw new NotFoundException('User not found.');
    }

    if (user.isEmailVerified) {
      throw new BadRequestException('Email is already verified.');
    }

    // In production, validate the code against stored verification codes
    await this.usersRepository.update(userId, {
      isEmailVerified: true,
    });

    return {
      message: 'Email verified successfully.',
    };
  }

  /**
   * Request password reset (stub - would need email service).
   */
  async requestPasswordReset(email: string) {
    const user = await this.usersRepository.findByEmail(email);

    if (!user) {
      // Don't reveal if email exists
      return {
        message: 'If an account exists with this email, you will receive password reset instructions.',
      };
    }

    // In production, generate reset token and send via email
    // For now, just return success message
    return {
      message: 'Password reset instructions have been sent to your email.',
    };
  }

  /**
   * Reset password with token (stub - would need email service).
   */
  async resetPassword(dto: ResetPasswordDto) {
    // In production, validate the reset token and find user
    const user = await this.usersRepository.findByEmail(dto.email);

    if (!user) {
      throw new NotFoundException('User not found.');
    }

    const newPasswordHash = await this.hashPassword(dto.newPassword);

    await this.usersRepository.updatePasswordHash(user.id, newPasswordHash);

    return {
      message: 'Password reset successfully.',
    };
  }

  /**
   * Hash password.
   */
  async hashPassword(password: string): Promise<string> {
    return bcrypt.hash(password, 12);
  }

  /**
   * Verify password.
   */
  async verifyPassword(
    password: string,
    passwordHash: string,
  ): Promise<boolean> {
    return bcrypt.compare(password, passwordHash);
  }

  /**
   * Generate JWT access token.
   */
  async generateAccessToken(userId: string, email: string): Promise<string> {
    return this.jwtService.signAsync(
      {
        sub: userId,
        email,
        type: 'access',
      },
      {
        expiresIn: '15m',
      },
    );
  }

  /**
   * Generate JWT refresh token.
   */
  async generateRefreshToken(userId: string, email: string): Promise<string> {
    return this.jwtService.signAsync(
      {
        sub: userId,
        email,
        type: 'refresh',
      },
      {
        secret: this.configService.getOrThrow<string>('JWT_REFRESH_SECRET'),
        expiresIn: '7d',
      },
    );
  }
}
