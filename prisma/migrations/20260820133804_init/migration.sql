-- CreateEnum
CREATE TYPE "AdminRole" AS ENUM ('SUPERADMIN', 'ADMIN');

-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('PENDING', 'CANCEL', 'DELIVERED');

-- CreateEnum
CREATE TYPE "PaymentType" AS ENUM ('CASH', 'CARD');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'CANCEL', 'PAID');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "phone" TEXT NOT NULL,
    "hashedPassword" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "imageUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "role" "AdminRole"[] DEFAULT ARRAY['ADMIN']::"AdminRole"[],

    CONSTRAINT "admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "saller" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "address" TEXT NOT NULL,
    "brand" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "saller_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "address" TEXT NOT NULL,

    CONSTRAINT "customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "imageUrl" TEXT NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product" (
    "id" SERIAL NOT NULL,
    "sallerId" INTEGER NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "quantity" INTEGER NOT NULL,

    CONSTRAINT "product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "image_of_product" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "imageUrl" TEXT NOT NULL,

    CONSTRAINT "image_of_product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rating" (
    "id" SERIAL NOT NULL,
    "customerId" INTEGER NOT NULL,
    "productId" INTEGER NOT NULL,
    "star" INTEGER[],
    "comment" TEXT NOT NULL,

    CONSTRAINT "rating_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "branch" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,

    CONSTRAINT "branch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order" (
    "id" SERIAL NOT NULL,
    "customerId" INTEGER NOT NULL,
    "branchId" INTEGER NOT NULL,
    "totalPrice" DECIMAL(65,30) NOT NULL,
    "status" "OrderStatus"[],

    CONSTRAINT "order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orderIteam" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "orderId" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,

    CONSTRAINT "orderIteam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payment" (
    "id" SERIAL NOT NULL,
    "orderId" INTEGER NOT NULL,
    "type" "PaymentType"[],
    "status" "PaymentStatus"[],

    CONSTRAINT "payment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_phone_key" ON "users"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "saller_brand_key" ON "saller"("brand");

-- CreateIndex
CREATE UNIQUE INDEX "category_name_key" ON "category"("name");

-- AddForeignKey
ALTER TABLE "admin" ADD CONSTRAINT "admin_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "saller" ADD CONSTRAINT "saller_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer" ADD CONSTRAINT "customer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_sallerId_fkey" FOREIGN KEY ("sallerId") REFERENCES "saller"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "category"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "image_of_product" ADD CONSTRAINT "image_of_product_productId_fkey" FOREIGN KEY ("productId") REFERENCES "product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "rating" ADD CONSTRAINT "rating_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "rating" ADD CONSTRAINT "rating_productId_fkey" FOREIGN KEY ("productId") REFERENCES "product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customer"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_branchId_fkey" FOREIGN KEY ("branchId") REFERENCES "branch"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orderIteam" ADD CONSTRAINT "orderIteam_productId_fkey" FOREIGN KEY ("productId") REFERENCES "product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orderIteam" ADD CONSTRAINT "orderIteam_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment" ADD CONSTRAINT "payment_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "order"("id") ON DELETE CASCADE ON UPDATE CASCADE;
