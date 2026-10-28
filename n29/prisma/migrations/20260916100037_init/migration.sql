/*
  Warnings:

  - Added the required column `hashedRefeshToken` to the `Devices` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Devices" ADD COLUMN     "hashedRefeshToken" TEXT NOT NULL;
