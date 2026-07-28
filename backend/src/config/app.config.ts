import { registerAs } from '@nestjs/config';

export default registerAs('app', () => ({
  name: 'JobMap API',
  env: process.env.NODE_ENV ?? 'development',
  port: Number(process.env.PORT ?? 3000),
}));