import { Injectable, UnauthorizedException, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { OAuth2Client } from 'google-auth-library';

export interface GoogleTokenPayload {
  iss: string;
  azp: string;
  aud: string;
  sub: string;
  email: string;
  email_verified: boolean;
  name: string;
  picture?: string;
  given_name?: string;
  family_name?: string;
  iat: number;
  exp: number;
}

@Injectable()
export class GoogleTokenVerifier {
  private readonly logger = new Logger(GoogleTokenVerifier.name);
  private readonly oauth2Client: OAuth2Client;

  private static readonly EXPECTED_ISSUERS = [
    'https://accounts.google.com',
    'accounts.google.com',
  ];

  constructor(private readonly configService: ConfigService) {
    const clientId = this.configService.getOrThrow<string>('GOOGLE_CLIENT_ID');
    this.oauth2Client = new OAuth2Client(clientId);
  }

  async verifyIdToken(idToken: string): Promise<GoogleTokenPayload> {
    try {
      const ticket = await this.oauth2Client.verifyIdToken({
        idToken,
        audience: this.configService.getOrThrow<string>('GOOGLE_CLIENT_ID'),
      });

      const payload = ticket.getPayload();

      if (!payload) {
        throw new UnauthorizedException('Invalid token payload');
      }

      if (!payload.iss || !payload.sub || !payload.aud || !payload.email) {
        throw new UnauthorizedException('Invalid token payload');
      }

      const googlePayload: GoogleTokenPayload = {
        iss: payload.iss,
        azp: payload.azp || '',
        aud: payload.aud,
        sub: payload.sub,
        email: payload.email,
        email_verified: payload.email_verified || false,
        name: payload.name || '',
        picture: payload.picture,
        given_name: payload.given_name,
        family_name: payload.family_name,
        iat: payload.iat || 0,
        exp: payload.exp || 0,
      };

      this.validateTokenClaims(googlePayload);

      return googlePayload;
    } catch (error) {
      if (error instanceof UnauthorizedException) {
        throw error;
      }

      this.logger.warn(`Token verification failed: ${error instanceof Error ? error.message : 'Unknown error'}`);
      throw new UnauthorizedException('Invalid Google ID token');
    }
  }

  private validateTokenClaims(payload: GoogleTokenPayload): void {
    if (!GoogleTokenVerifier.EXPECTED_ISSUERS.includes(payload.iss)) {
      this.logger.warn(`Invalid token issuer: ${payload.iss}`);
      throw new UnauthorizedException('Invalid token issuer');
    }

    const now = Math.floor(Date.now() / 1000);
    if (payload.exp < now) {
      this.logger.warn(`Token expired at ${new Date(payload.exp * 1000).toISOString()}`);
      throw new UnauthorizedException('Token has expired');
    }

    if (!payload.email_verified) {
      this.logger.warn(`Email not verified for ${payload.email}`);
      throw new UnauthorizedException('Email is not verified');
    }
  }
}

