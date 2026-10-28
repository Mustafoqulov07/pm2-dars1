import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsPhoneNumber } from 'class-validator';

export class SendOTPDto {
  @ApiProperty({ example: '+998937145514' })
  @IsPhoneNumber('UZ')
  @IsNotEmpty()
  phone!: string;
}
