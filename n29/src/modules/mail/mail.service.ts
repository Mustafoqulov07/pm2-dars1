import { MailerService } from '@nestjs-modules/mailer';
import { BadRequestException, Injectable } from '@nestjs/common';

@Injectable()
export class MailService {
  constructor(private readonly mailerService: MailerService) {}

  async sendMail(
    to: string,
    subject: string = 'N29 salom',
    text: string = 'Guruhdan salom',
  ): Promise<object> {
    try {
      await this.mailerService.sendMail({
        to,
        subject,
        text,
      });
      return { success: true };
    } catch (error) {
      throw new BadRequestException("Gmailga xabar jo'natishda xatolik");
    }
  }
}
