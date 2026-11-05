SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE DATABASE shoe_shop;
\c shoe_shop

CREATE TABLE public.items (
    item_number character varying(30) NOT NULL,
    name character varying(30) NOT NULL,
    unit_measurement character varying(30) NOT NULL,
    cost integer NOT NULL,
    provider character varying(30) NOT NULL,
    manufacturer character varying(30) NOT NULL,
    item_category character varying(30) NOT NULL,
    current_discount integer NOT NULL,
    quantity_stock integer NOT NULL,
    description character varying(100) NOT NULL,
    photo character varying(30) DEFAULT 'picture.png'
);


ALTER TABLE public.items OWNER TO postgres;


CREATE TABLE public.orders (
    order_number integer NOT NULL,
    order_date date NOT NULL,
    delivery_date date NOT NULL,
    receipt_code integer NOT NULL,
    order_status character varying(30) NOT NULL,
    id_pickup_point integer,
    id_user integer
);


ALTER TABLE public.orders OWNER TO postgres;


CREATE TABLE public.orders_items (
    order_number integer NOT NULL,
    item_number character varying(30) NOT NULL,
    quantity integer
);


ALTER TABLE public.orders_items OWNER TO postgres;


CREATE SEQUENCE public.orders_order_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_number_seq OWNER TO postgres;


ALTER SEQUENCE public.orders_order_number_seq OWNED BY public.orders.order_number;


CREATE TABLE public.pickup_points (
    id integer NOT NULL,
    address character varying(100) NOT NULL
);


ALTER TABLE public.pickup_points OWNER TO postgres;


CREATE SEQUENCE public.pickup_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pickup_points_id_seq OWNER TO postgres;


ALTER SEQUENCE public.pickup_points_id_seq OWNED BY public.pickup_points.id;


CREATE TABLE public.users (
    id integer NOT NULL,
    role character varying(30) NOT NULL,
    full_name character varying(30) NOT NULL,
    login character varying(30) NOT NULL,
    password character varying(30) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;


CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;


ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


ALTER TABLE ONLY public.orders ALTER COLUMN order_number SET DEFAULT nextval('public.orders_order_number_seq'::regclass);


ALTER TABLE ONLY public.pickup_points ALTER COLUMN id SET DEFAULT nextval('public.pickup_points_id_seq'::regclass);


ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_number);


ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_pkey PRIMARY KEY (order_number, item_number);


ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_number);


ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_id_pickup_point_fkey FOREIGN KEY (id_pickup_point) REFERENCES public.pickup_points(id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_item_number_fkey FOREIGN KEY (item_number) REFERENCES public.items(item_number) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_order_number_fkey FOREIGN KEY (order_number) REFERENCES public.orders(order_number) ON UPDATE CASCADE ON DELETE CASCADE;