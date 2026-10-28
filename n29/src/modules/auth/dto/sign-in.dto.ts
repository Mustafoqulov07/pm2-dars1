import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsPhoneNumber, IsString } from 'class-validator';

export class SignInDto {
  @ApiProperty({ example: '+998937145514' })
  @IsPhoneNumber('UZ')
  @IsNotEmpty()
  phone!: string;

  @ApiProperty({ example: 'Superadmin1!' })
  @IsString()
  @IsNotEmpty()
  password!: string;
}
