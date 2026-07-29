import { UserResponseDto } from '../dto/user-response.dto';

export class UserMapper {
  static toResponse(user: {
    id: string;
    email: string;
    isEmailVerified: boolean;
    createdAt: Date;
    updatedAt: Date;
  }): UserResponseDto {
    return {
      id: user.id,
      email: user.email,
      isEmailVerified: user.isEmailVerified,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    };
  }

  static toResponseList(
    users: Array<{
      id: string;
      email: string;
      isEmailVerified: boolean;
      createdAt: Date;
      updatedAt: Date;
    }>,
  ): UserResponseDto[] {
    return users.map((user) => this.toResponse(user));
  }
}
