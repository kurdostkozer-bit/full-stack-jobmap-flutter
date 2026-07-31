import {
  ConflictException,
  Injectable,
  UnauthorizedException,
  BadRequestException,
  NotFoundException,
  Logger,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import * as bcrypt from 'bcrypt';

import { LoginDto } from '../dto/login.dto';
import { RegisterDto } from '../dto/register.dto';
import { ChangePasswordDto } from '../dto/change-password.dto';
import { ResetPasswordDto } from '../dto/reset-password.dto';
import { UsersRepository } from '../repositories/users.repository';
import { GoogleTokenVerifier } from './google-token-verifier';
import { db } from '../../database/database';
import { users } from '../../database/schema';
import { profiles } from '../../database/schema';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);

  constructor(
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
    private readonly usersRepository: UsersRepository,
    private readonly googleTokenVerifier: GoogleTokenVerifier,
  ) {}

  /**
   * Register a new user with profile in a single atomic transaction.
   */
  async register(dto: RegisterDto) {
    const existingUser = await this.usersRepository.findByEmail(dto.email);

    if (existingUser) {
      throw new ConflictException('Email is already registered.');
    }

    const passwordHash = await this.hashPassword(dto.password);

    try {
      const user = await db.transaction(async (tx) => {
        const [newUser] = await tx
          .insert(users)
          .values({
            email: dto.email,
            passwordHash,
            provider: 'local',
          })
          .returning();

        await tx
          .insert(profiles)
          .values({
            userId: newUser.id,
          });

        return newUser;
      });

      this.logger.debug(`User registered: ${user.email}`);

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
    } catch (error) {
      this.logger.error(`Registration failed for ${dto.email}`, error instanceof Error ? error.stack : undefined);
      throw error;
    }
  }

  /**
   * Login existing user.
   */
  async login(dto: LoginDto) {
    const user = await this.usersRepository.findByEmail(dto.email);

    if (!user) {
      this.logger.warn(`Login attempt with non-existent email: ${dto.email}`);
      throw new UnauthorizedException('Invalid email or password.');
    }

    if (!user.passwordHash) {
      this.logger.warn(`Login attempt for Google-only user: ${dto.email}`);
      throw new UnauthorizedException('Invalid email or password.');
    }

    const isValidPassword = await this.verifyPassword(
      dto.password,
      user.passwordHash,
    );

    if (!isValidPassword) {
      this.logger.warn(`Invalid password for user: ${dto.email}`);
      throw new UnauthorizedException('Invalid email or password.');
    }

    this.logger.debug(`User logged in: ${user.email}`);

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

      if (payload.type !== 'refresh') {
        this.logger.warn(`Invalid token type used for refresh: ${payload.type}`);
        throw new UnauthorizedException('Invalid token type');
      }

      const user = await this.usersRepository.findById(payload.sub);

      if (!user) {
        this.logger.warn(`Refresh token for non-existent user: ${payload.sub}`);
        throw new UnauthorizedException('User not found.');
      }

      const newAccessToken = await this.generateAccessToken(user.id, user.email);

      this.logger.debug(`Token refreshed for user: ${user.email}`);

      return {
        message: 'Token refreshed successfully.',
        accessToken: newAccessToken,
      };
    } catch (error) {
      if (error instanceof UnauthorizedException) {
        throw error;
      }
      this.logger.warn(`Token refresh failed: ${error instanceof Error ? error.message : 'Unknown error'}`);
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

    if (!user.passwordHash) {
      throw new BadRequestException('This account does not have a password.');
    }

    const isValidPassword = await this.verifyPassword(
      dto.currentPassword,
      user.passwordHash,
    );

    if (!isValidPassword) {
      this.logger.warn(`Invalid password change attempt for user: ${userId}`);
      throw new UnauthorizedException('Current password is incorrect.');
    }

    if (dto.newPassword === dto.currentPassword) {
      throw new BadRequestException('New password must be different from current password.');
    }

    const newPasswordHash = await this.hashPassword(dto.newPassword);

    await this.usersRepository.updatePasswordHash(userId, newPasswordHash);

    this.logger.debug(`Password changed for user: ${userId}`);

    return {
      message: 'Password changed successfully.',
    };
  }

  /**
   * Verify email (stub - would need email service).
   */
  async verifyEmail(email: string, code: string) {
    // This is a placeholder - implement with actual email verification logic
    const user = await this.usersRepository.findByEmail(email);

    if (!user) {
      throw new NotFoundException('User not found.');
    }

    if (user.isEmailVerified) {
      throw new BadRequestException('Email is already verified.');
    }

    // In production, validate the code against stored verification codes
    await this.usersRepository.update(user.id, {
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
    if (!password || !passwordHash) {
      return false;
    }
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

  /**
   * Google social login with ID token verification.
   */
  async googleSocialLogin(idToken: string) {
    const googlePayload = await this.googleTokenVerifier.verifyIdToken(
      idToken,
    );

    let user = await this.usersRepository.findByGoogleId(googlePayload.sub);

    if (!user) {
      user = await this.usersRepository.findByEmail(googlePayload.email);

      if (user) {
        if (!user.isEmailVerified) {
          this.logger.warn(`Attempted to link Google to unverified email: ${googlePayload.email}`);
          throw new ConflictException('Email must be verified before linking Google account.');
        }

        user = await this.usersRepository.linkGoogleId(
          user.id,
          googlePayload.sub,
          googlePayload.email,
          googlePayload.picture,
        );

        this.logger.debug(`Google account linked to existing user: ${googlePayload.email}`);
      } else {
        try {
          user = await db.transaction(async (tx) => {
            const [newUser] = await tx
              .insert(users)
              .values({
                email: googlePayload.email,
                googleId: googlePayload.sub,
                googleEmail: googlePayload.email,
                profileImage: googlePayload.picture,
                isEmailVerified: true,
                provider: 'google',
              })
              .returning();

            await tx
              .insert(profiles)
              .values({
                userId: newUser.id,
              });

            return newUser;
          });

          this.logger.debug(`New Google user created: ${googlePayload.email}`);
        } catch (error) {
          this.logger.error(`Failed to create Google user: ${googlePayload.email}`, error instanceof Error ? error.stack : undefined);
          throw error;
        }
      }
    }

    const accessToken = await this.generateAccessToken(user.id, user.email);
    const refreshToken = await this.generateRefreshToken(user.id, user.email);

    this.logger.debug(`Google login successful: ${user.email}`);

    return {
      message: 'Google login successful.',
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
}
