-- CreateEnum
CREATE TYPE "public"."brand_code" AS ENUM ('CPC', 'FORMOSA', 'NPC', 'TAYA', 'FUMAO', 'OTHER');

-- CreateEnum
CREATE TYPE "public"."fuel_type" AS ENUM ('NINETY_TWO', 'NINETY_FIVE', 'NINETY_EIGHT', 'DIESEL');

-- CreateEnum
CREATE TYPE "public"."fueling_method" AS ENUM ('SELF_SERVICE', 'ATTENDANT');

-- CreateEnum
CREATE TYPE "public"."gender" AS ENUM ('MALE', 'FEMALE', 'UNDISCLOSED');

-- CreateTable
CREATE TABLE "public"."fuel_prices" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "brand" "public"."brand_code" NOT NULL,
    "fuel_type" "public"."fuel_type" NOT NULL,
    "price" DECIMAL(12,2) NOT NULL,
    "effective_date" DATE NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "fuel_prices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."fuel_records" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenant_id" UUID NOT NULL,
    "vehicle_id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "gas_station_id" UUID NOT NULL,
    "fuel_type" "public"."fuel_type" NOT NULL,
    "price_per_liter" DECIMAL(12,2) NOT NULL,
    "liters" DECIMAL(8,3) NOT NULL,
    "fueling_method" "public"."fueling_method" NOT NULL,
    "mileage" INTEGER NOT NULL,
    "fueled_at" TIMESTAMPTZ(6) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "fuel_records_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."gas_stations" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "brand" "public"."brand_code" NOT NULL,
    "name" TEXT NOT NULL,
    "latitude" DECIMAL(10,7) NOT NULL,
    "longitude" DECIMAL(10,7) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "gas_stations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."tenants" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "tenants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."users" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenant_id" UUID NOT NULL,
    "email" TEXT NOT NULL,
    "email_norm" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "birth_year" INTEGER NOT NULL,
    "gender" "public"."gender" NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."vehicle_brands" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "vehicle_brands_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."vehicle_models" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "brand_id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "vehicle_models_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."vehicle_ownerships" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenant_id" UUID NOT NULL,
    "vehicle_id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "is_owner" BOOLEAN NOT NULL DEFAULT false,
    "joined_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "left_at" TIMESTAMPTZ(6),
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "vehicle_ownerships_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."vehicles" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenant_id" UUID NOT NULL,
    "brand_id" UUID NOT NULL,
    "model_id" UUID NOT NULL,
    "year" INTEGER NOT NULL,
    "displacement" INTEGER NOT NULL,
    "current_mileage" INTEGER NOT NULL,
    "owner_id" UUID NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "vehicles_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "fuel_prices_brand_fuel_type_idx" ON "public"."fuel_prices"("brand", "fuel_type");

-- CreateIndex
CREATE INDEX "fuel_prices_effective_date_idx" ON "public"."fuel_prices"("effective_date");

-- CreateIndex
CREATE UNIQUE INDEX "fuel_prices_brand_fuel_type_effective_date_idx" ON "public"."fuel_prices"("brand", "fuel_type", "effective_date");

-- CreateIndex
CREATE INDEX "fuel_records_tenant_id_user_id_fueled_at_idx" ON "public"."fuel_records"("tenant_id", "user_id", "fueled_at");

-- CreateIndex
CREATE INDEX "fuel_records_tenant_id_vehicle_id_fueled_at_idx" ON "public"."fuel_records"("tenant_id", "vehicle_id", "fueled_at");

-- CreateIndex
CREATE INDEX "gas_stations_brand_idx" ON "public"."gas_stations"("brand");

-- CreateIndex
CREATE INDEX "gas_stations_latitude_longitude_idx" ON "public"."gas_stations"("latitude", "longitude");

-- CreateIndex
CREATE INDEX "gas_stations_name_idx" ON "public"."gas_stations"("name");

-- CreateIndex
CREATE INDEX "users_tenant_id_idx" ON "public"."users"("tenant_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_tenant_id_email_norm_idx" ON "public"."users"("tenant_id", "email_norm");

-- CreateIndex
CREATE UNIQUE INDEX "users_tenant_id_id_idx" ON "public"."users"("tenant_id", "id");

-- CreateIndex
CREATE UNIQUE INDEX "vehicle_brands_name_idx" ON "public"."vehicle_brands"("name");

-- CreateIndex
CREATE UNIQUE INDEX "vehicle_models_brand_id_name_idx" ON "public"."vehicle_models"("brand_id", "name");

-- CreateIndex
CREATE INDEX "vehicle_ownerships_tenant_id_user_id_idx" ON "public"."vehicle_ownerships"("tenant_id", "user_id");

-- CreateIndex
CREATE INDEX "vehicle_ownerships_tenant_id_vehicle_id_idx" ON "public"."vehicle_ownerships"("tenant_id", "vehicle_id");

-- CreateIndex
CREATE UNIQUE INDEX "vehicle_ownerships_tenant_id_vehicle_id_user_id_is_owner_idx" ON "public"."vehicle_ownerships"("tenant_id", "vehicle_id", "user_id", "is_owner");

-- CreateIndex
CREATE INDEX "vehicles_tenant_id_brand_id_model_id_idx" ON "public"."vehicles"("tenant_id", "brand_id", "model_id");

-- CreateIndex
CREATE INDEX "vehicles_tenant_id_owner_id_idx" ON "public"."vehicles"("tenant_id", "owner_id");

-- CreateIndex
CREATE UNIQUE INDEX "vehicles_tenant_id_id_idx" ON "public"."vehicles"("tenant_id", "id");

-- AddForeignKey
ALTER TABLE "public"."fuel_records" ADD CONSTRAINT "fuel_records_gas_station_id_fkey" FOREIGN KEY ("gas_station_id") REFERENCES "public"."gas_stations"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."fuel_records" ADD CONSTRAINT "fuel_records_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."fuel_records" ADD CONSTRAINT "fuel_records_tenant_id_user_id_fkey" FOREIGN KEY ("tenant_id", "user_id") REFERENCES "public"."users"("tenant_id", "id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."fuel_records" ADD CONSTRAINT "fuel_records_tenant_id_vehicle_id_fkey" FOREIGN KEY ("tenant_id", "vehicle_id") REFERENCES "public"."vehicles"("tenant_id", "id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."users" ADD CONSTRAINT "users_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."vehicle_models" ADD CONSTRAINT "vehicle_models_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "public"."vehicle_brands"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."vehicle_ownerships" ADD CONSTRAINT "vehicle_ownerships_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."vehicle_ownerships" ADD CONSTRAINT "vehicle_ownerships_tenant_id_user_id_fkey" FOREIGN KEY ("tenant_id", "user_id") REFERENCES "public"."users"("tenant_id", "id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."vehicle_ownerships" ADD CONSTRAINT "vehicle_ownerships_tenant_id_vehicle_id_fkey" FOREIGN KEY ("tenant_id", "vehicle_id") REFERENCES "public"."vehicles"("tenant_id", "id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."vehicles" ADD CONSTRAINT "vehicles_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "public"."vehicle_brands"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."vehicles" ADD CONSTRAINT "vehicles_model_id_fkey" FOREIGN KEY ("model_id") REFERENCES "public"."vehicle_models"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."vehicles" ADD CONSTRAINT "vehicles_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."vehicles" ADD CONSTRAINT "vehicles_tenant_id_owner_id_fkey" FOREIGN KEY ("tenant_id", "owner_id") REFERENCES "public"."users"("tenant_id", "id") ON DELETE RESTRICT ON UPDATE NO ACTION;
