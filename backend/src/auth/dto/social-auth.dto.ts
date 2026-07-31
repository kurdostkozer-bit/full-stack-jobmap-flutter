import { IsString, IsNotEmpty } from 'class-validator';

export class GoogleSocialLoginDto {
  @IsString()
  @IsNotEmpty()
  idToken!: string;
}
