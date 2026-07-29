import { Injectable } from '@nestjs/common';

import { UsersRepository } from '../repositories/users.repository';
import { UserMapper } from '../entities/user.mapper';
import { UserResponseDto } from '../dto/user-response.dto';

@Injectable()
export class UsersService {
  constructor(private readonly usersRepository: UsersRepository) {}

  async findAll(): Promise<UserResponseDto[]> {
    const users = await this.usersRepository.findAll();

    return users.map((user) => UserMapper.toResponse(user));
  }

  async findById(id: string): Promise<UserResponseDto | null> {
    const user = await this.usersRepository.findById(id);

    if (!user) {
      return null;
    }

    return UserMapper.toResponse(user);
  }

  async findByEmail(email: string): Promise<UserResponseDto | null> {
    const user = await this.usersRepository.findByEmail(email);

    if (!user) {
      return null;
    }

    return UserMapper.toResponse(user);
  }
}
