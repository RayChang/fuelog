--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13
-- Dumped by pg_dump version 15.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: brand_code; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.brand_code AS ENUM (
    'CPC',
    'FORMOSA',
    'NPC',
    'TAYA',
    'FUMAO',
    'OTHER'
);


ALTER TYPE public.brand_code OWNER TO admin;

--
-- Name: fuel_type; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.fuel_type AS ENUM (
    'NINETY_TWO',
    'NINETY_FIVE',
    'NINETY_EIGHT',
    'DIESEL'
);


ALTER TYPE public.fuel_type OWNER TO admin;

--
-- Name: fueling_method; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.fueling_method AS ENUM (
    'SELF_SERVICE',
    'ATTENDANT'
);


ALTER TYPE public.fueling_method OWNER TO admin;

--
-- Name: gender; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.gender AS ENUM (
    'MALE',
    'FEMALE',
    'UNDISCLOSED'
);


ALTER TYPE public.gender OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: fuel_prices; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fuel_prices (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    brand public.brand_code NOT NULL,
    fuel_type public.fuel_type NOT NULL,
    price numeric(12,2) NOT NULL,
    effective_date date NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.fuel_prices OWNER TO admin;

--
-- Name: COLUMN fuel_prices.price; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.fuel_prices.price IS 'Must be > 0';


--
-- Name: COLUMN fuel_prices.effective_date; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.fuel_prices.effective_date IS 'Date the price becomes effective';


--
-- Name: fuel_records; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fuel_records (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid NOT NULL,
    vehicle_id uuid NOT NULL,
    user_id uuid NOT NULL,
    gas_station_id uuid NOT NULL,
    fuel_type public.fuel_type NOT NULL,
    price_per_liter numeric(12,2) NOT NULL,
    liters numeric(8,3) NOT NULL,
    fueling_method public.fueling_method NOT NULL,
    mileage integer NOT NULL,
    fueled_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT positive_liters CHECK ((liters > (0)::numeric)),
    CONSTRAINT positive_price CHECK ((price_per_liter > (0)::numeric))
);


ALTER TABLE public.fuel_records OWNER TO admin;

--
-- Name: COLUMN fuel_records.user_id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.fuel_records.user_id IS 'Who performed fueling';


--
-- Name: COLUMN fuel_records.price_per_liter; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.fuel_records.price_per_liter IS 'Must be > 0';


--
-- Name: COLUMN fuel_records.liters; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.fuel_records.liters IS 'Must be > 0';


--
-- Name: COLUMN fuel_records.mileage; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.fuel_records.mileage IS 'Must be >= previous record for this vehicle';


--
-- Name: gas_stations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.gas_stations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    brand public.brand_code NOT NULL,
    name text NOT NULL,
    latitude numeric(10,7) NOT NULL,
    longitude numeric(10,7) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.gas_stations OWNER TO admin;

--
-- Name: tenants; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.tenants (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.tenants OWNER TO admin;

--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid NOT NULL,
    email text NOT NULL,
    email_norm text NOT NULL,
    password_hash text NOT NULL,
    birth_year integer NOT NULL,
    gender public.gender NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.users OWNER TO admin;

--
-- Name: COLUMN users.password_hash; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.users.password_hash IS 'Store password as hash';


--
-- Name: COLUMN users.birth_year; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.users.birth_year IS 'Year only';


--
-- Name: vehicle_brands; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.vehicle_brands (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.vehicle_brands OWNER TO admin;

--
-- Name: vehicle_models; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.vehicle_models (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    brand_id uuid NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.vehicle_models OWNER TO admin;

--
-- Name: vehicle_ownerships; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.vehicle_ownerships (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid NOT NULL,
    vehicle_id uuid NOT NULL,
    user_id uuid NOT NULL,
    is_owner boolean DEFAULT false NOT NULL,
    joined_at timestamp with time zone DEFAULT now() NOT NULL,
    left_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.vehicle_ownerships OWNER TO admin;

--
-- Name: COLUMN vehicle_ownerships.is_owner; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.vehicle_ownerships.is_owner IS 'True if owner, false if user';


--
-- Name: vehicles; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.vehicles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid NOT NULL,
    brand_id uuid NOT NULL,
    model_id uuid NOT NULL,
    year integer NOT NULL,
    displacement integer NOT NULL,
    current_mileage integer NOT NULL,
    owner_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT positive_displacement CHECK ((displacement > 0)),
    CONSTRAINT positive_mileage CHECK ((current_mileage >= 0))
);


ALTER TABLE public.vehicles OWNER TO admin;

--
-- Name: COLUMN vehicles.displacement; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.vehicles.displacement IS 'cc';


--
-- Name: COLUMN vehicles.current_mileage; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.vehicles.current_mileage IS 'km, must be >= last fuel_record.mileage';


--
-- Name: COLUMN vehicles.owner_id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN public.vehicles.owner_id IS 'Current owner (user id)';


--
-- Name: fuel_prices fuel_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fuel_prices
    ADD CONSTRAINT fuel_prices_pkey PRIMARY KEY (id);


--
-- Name: fuel_records fuel_records_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fuel_records
    ADD CONSTRAINT fuel_records_pkey PRIMARY KEY (id);


--
-- Name: gas_stations gas_stations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.gas_stations
    ADD CONSTRAINT gas_stations_pkey PRIMARY KEY (id);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vehicle_brands vehicle_brands_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicle_brands
    ADD CONSTRAINT vehicle_brands_pkey PRIMARY KEY (id);


--
-- Name: vehicle_models vehicle_models_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicle_models
    ADD CONSTRAINT vehicle_models_pkey PRIMARY KEY (id);


--
-- Name: vehicle_ownerships vehicle_ownerships_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicle_ownerships
    ADD CONSTRAINT vehicle_ownerships_pkey PRIMARY KEY (id);


--
-- Name: vehicles vehicles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_pkey PRIMARY KEY (id);


--
-- Name: fuel_prices_brand_fuel_type_effective_date_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX fuel_prices_brand_fuel_type_effective_date_idx ON public.fuel_prices USING btree (brand, fuel_type, effective_date);


--
-- Name: fuel_prices_brand_fuel_type_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fuel_prices_brand_fuel_type_idx ON public.fuel_prices USING btree (brand, fuel_type);


--
-- Name: fuel_prices_effective_date_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fuel_prices_effective_date_idx ON public.fuel_prices USING btree (effective_date);


--
-- Name: fuel_records_tenant_id_user_id_fueled_at_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fuel_records_tenant_id_user_id_fueled_at_idx ON public.fuel_records USING btree (tenant_id, user_id, fueled_at);


--
-- Name: fuel_records_tenant_id_vehicle_id_fueled_at_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fuel_records_tenant_id_vehicle_id_fueled_at_idx ON public.fuel_records USING btree (tenant_id, vehicle_id, fueled_at);


--
-- Name: gas_stations_brand_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX gas_stations_brand_idx ON public.gas_stations USING btree (brand);


--
-- Name: gas_stations_latitude_longitude_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX gas_stations_latitude_longitude_idx ON public.gas_stations USING btree (latitude, longitude);


--
-- Name: gas_stations_name_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX gas_stations_name_idx ON public.gas_stations USING btree (name);


--
-- Name: users_tenant_id_email_norm_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX users_tenant_id_email_norm_idx ON public.users USING btree (tenant_id, email_norm);


--
-- Name: users_tenant_id_id_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX users_tenant_id_id_idx ON public.users USING btree (tenant_id, id);


--
-- Name: users_tenant_id_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_tenant_id_idx ON public.users USING btree (tenant_id);


--
-- Name: vehicle_brands_name_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX vehicle_brands_name_idx ON public.vehicle_brands USING btree (name);


--
-- Name: vehicle_models_brand_id_name_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX vehicle_models_brand_id_name_idx ON public.vehicle_models USING btree (brand_id, name);


--
-- Name: vehicle_ownerships_tenant_id_user_id_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX vehicle_ownerships_tenant_id_user_id_idx ON public.vehicle_ownerships USING btree (tenant_id, user_id);


--
-- Name: vehicle_ownerships_tenant_id_vehicle_id_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX vehicle_ownerships_tenant_id_vehicle_id_idx ON public.vehicle_ownerships USING btree (tenant_id, vehicle_id);


--
-- Name: vehicle_ownerships_tenant_id_vehicle_id_user_id_is_owner_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX vehicle_ownerships_tenant_id_vehicle_id_user_id_is_owner_idx ON public.vehicle_ownerships USING btree (tenant_id, vehicle_id, user_id, is_owner);


--
-- Name: vehicles_tenant_id_brand_id_model_id_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX vehicles_tenant_id_brand_id_model_id_idx ON public.vehicles USING btree (tenant_id, brand_id, model_id);


--
-- Name: vehicles_tenant_id_id_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX vehicles_tenant_id_id_idx ON public.vehicles USING btree (tenant_id, id);


--
-- Name: vehicles_tenant_id_owner_id_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX vehicles_tenant_id_owner_id_idx ON public.vehicles USING btree (tenant_id, owner_id);


--
-- Name: fuel_records fuel_records_gas_station_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fuel_records
    ADD CONSTRAINT fuel_records_gas_station_id_fkey FOREIGN KEY (gas_station_id) REFERENCES public.gas_stations(id) ON DELETE RESTRICT;


--
-- Name: fuel_records fuel_records_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fuel_records
    ADD CONSTRAINT fuel_records_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: fuel_records fuel_records_tenant_id_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fuel_records
    ADD CONSTRAINT fuel_records_tenant_id_user_id_fkey FOREIGN KEY (tenant_id, user_id) REFERENCES public.users(tenant_id, id) ON DELETE RESTRICT;


--
-- Name: fuel_records fuel_records_tenant_id_vehicle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fuel_records
    ADD CONSTRAINT fuel_records_tenant_id_vehicle_id_fkey FOREIGN KEY (tenant_id, vehicle_id) REFERENCES public.vehicles(tenant_id, id) ON DELETE CASCADE;


--
-- Name: users users_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: vehicle_models vehicle_models_brand_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicle_models
    ADD CONSTRAINT vehicle_models_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.vehicle_brands(id) ON DELETE RESTRICT;


--
-- Name: vehicle_ownerships vehicle_ownerships_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicle_ownerships
    ADD CONSTRAINT vehicle_ownerships_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: vehicle_ownerships vehicle_ownerships_tenant_id_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicle_ownerships
    ADD CONSTRAINT vehicle_ownerships_tenant_id_user_id_fkey FOREIGN KEY (tenant_id, user_id) REFERENCES public.users(tenant_id, id) ON DELETE RESTRICT;


--
-- Name: vehicle_ownerships vehicle_ownerships_tenant_id_vehicle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicle_ownerships
    ADD CONSTRAINT vehicle_ownerships_tenant_id_vehicle_id_fkey FOREIGN KEY (tenant_id, vehicle_id) REFERENCES public.vehicles(tenant_id, id) ON DELETE CASCADE;


--
-- Name: vehicles vehicles_brand_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.vehicle_brands(id) ON DELETE RESTRICT;


--
-- Name: vehicles vehicles_model_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_model_id_fkey FOREIGN KEY (model_id) REFERENCES public.vehicle_models(id) ON DELETE RESTRICT;


--
-- Name: vehicles vehicles_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: vehicles vehicles_tenant_id_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_tenant_id_owner_id_fkey FOREIGN KEY (tenant_id, owner_id) REFERENCES public.users(tenant_id, id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

