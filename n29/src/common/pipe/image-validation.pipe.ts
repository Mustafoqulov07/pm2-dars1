import { BadRequestException, Injectable, PipeTransform } from '@nestjs/common';
import sharp from 'sharp';
import { extname } from 'path';

@Injectable()
export class ImageValidationPipe implements PipeTransform<
  Express.Multer.File | undefined
> {
  private readonly allowExtensions = [
    '.jpeg',
    '.jpg',
    '.png',
    '.webp',
    '.heic',
  ];

  private readonly allowMimeTypes = [
    'image/jpeg',
    'image/jpg',
    'image/png',
    'image/webp',
    'image/heic',
  ];

  private readonly maxFileSize = 10 * 1024 * 1024;

  async transform(file: Express.Multer.File | undefined) {
    if (!file) {
      return file;
    }

    if (file.size > this.maxFileSize) {
      throw new BadRequestException('Fayl hajmi 10 MB dan oshmasin');
    }
    const extension = extname(file.originalname).toLowerCase();
    if (!this.allowExtensions.includes(extension)) {
      throw new BadRequestException('Faqat rasm fayllarini yuboring');
    }
    if (!this.allowMimeTypes.includes(file.mimetype)) {
      throw new BadRequestException('Fayl turi notogri');
    }

    try {
      const optimizeBuffer = await sharp(file.buffer)
        .rotate()
        .resize({
          width: 1600,
          height: 1600,
          fit: 'inside',
          withoutEnlargement: true,
        })
        .webp({
          quality: 80,
        })
        .toBuffer();

      file.buffer = optimizeBuffer;
      file.size = optimizeBuffer.length;
      file.mimetype = 'image/webp';
      file.originalname = `${Date.now()}.webp`;
      return file;
    } catch (error) {
      throw new BadRequestException(
        'Yuborilgan fayl haqiqiy rasm emas yoki buzulgan',
      );
    }
  }
}
