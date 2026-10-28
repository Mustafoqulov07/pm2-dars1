import { Module } from '@nestjs/common';
import { PrismaModule } from './config/database/prisma.module';
import { AuthModule } from './modules/auth/auth.module';
import { RedisModule } from './config/redis/redis.module';
import { OtpModule } from './modules/otp/otp.module';
import { MailModule } from './modules/mail/mail.module';
import { AdminModule } from './modules/admin/admin.module';

@Module({
  imports: [
    PrismaModule,
    RedisModule,
    OtpModule,
    AuthModule,
    MailModule,
    AdminModule,
  ],
})
export class AppModule {}
