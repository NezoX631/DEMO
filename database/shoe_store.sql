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

SET default_tablespace = '';

SET default_table_access_method = heap;


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


CREATE TABLE public.orders (
    order_number integer NOT NULL,
    order_date date NOT NULL,
    delivery_date date NOT NULL,
    receipt_code integer NOT NULL,
    order_status character varying(30) NOT NULL,
    id_pickup_point integer,
    id_user integer
);


CREATE TABLE public.orders_items (
    order_number integer NOT NULL,
    item_number character varying(30) NOT NULL,
    quantity integer
);


CREATE SEQUENCE public.orders_order_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_number_seq OWNED BY public.orders.order_number;


CREATE TABLE public.pickup_points (
    id integer NOT NULL,
    address character varying(100) NOT NULL
);


CREATE SEQUENCE public.pickup_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pickup_points_id_seq OWNED BY public.pickup_points.id;


CREATE TABLE public.users (
    id integer NOT NULL,
    role character varying(30) NOT NULL,
    full_name character varying(30) NOT NULL,
    login character varying(30) NOT NULL,
    password character varying(30) NOT NULL
);


CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


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

-- DATA INSERTS
INSERT INTO public.users (id, role, full_name, login, password) VALUES (1, 'Администратор', 'Никифорова Весения Николаевна', '94d5ous@gmail.com', 'uzWC67');
INSERT INTO public.users (id, role, full_name, login, password) VALUES (2, 'Администратор', 'Сазонов Руслан Германович', 'uth4iz@mail.com', '2L6KZG');
INSERT INTO public.users (id, role, full_name, login, password) VALUES (3, 'Администратор', 'Одинцов Серафим Артёмович', 'yzls62@outlook.com', 'JlFRCZ');
INSERT INTO public.users (id, role, full_name, login, password) VALUES (4, 'Менеджер', 'Степанов Михаил Артёмович', '1diph5e@tutanota.com', '8ntwUp');
INSERT INTO public.users (id, role, full_name, login, password) VALUES (5, 'Менеджер', 'Ворсин Петр Евгеньевич', 'tjde7c@yahoo.com', 'YOyhfR');
INSERT INTO public.users (id, role, full_name, login, password) VALUES (6, 'Менеджер', 'Старикова Елена Павловна', 'wpmrc3do@tutanota.com', 'RSbvHv');
INSERT INTO public.users (id, role, full_name, login, password) VALUES (7, 'Авторизированный клиент', 'Михайлюк Анна Вячеславовна', '5d4zbu@tutanota.com', 'rwVDh9');
INSERT INTO public.users (id, role, full_name, login, password) VALUES (8, 'Авторизированный клиент', 'Ситдикова Елена Анатольевна', 'ptec8ym@yahoo.com', 'LdNyos');
INSERT INTO public.users (id, role, full_name, login, password) VALUES (9, 'Авторизированный клиент', 'Ворсин Петр Евгеньевич', '1qz4kw@mail.com', 'gynQMT');
INSERT INTO public.users (id, role, full_name, login, password) VALUES (10, 'Авторизированный клиент', 'Старикова Елена Павловна', '4np6se@mail.com', 'AtnDjr');
SELECT setval('public.users_id_seq', 11);
INSERT INTO public.pickup_points (id, address) VALUES (1, '420151, г. Лесной, ул. Вишневая, 32');
INSERT INTO public.pickup_points (id, address) VALUES (2, '125061, г. Лесной, ул. Подгорная, 8');
INSERT INTO public.pickup_points (id, address) VALUES (3, '630370, г. Лесной, ул. Шоссейная, 24');
INSERT INTO public.pickup_points (id, address) VALUES (4, '400562, г. Лесной, ул. Зеленая, 32');
INSERT INTO public.pickup_points (id, address) VALUES (5, '614510, г. Лесной, ул. Маяковского, 47');
INSERT INTO public.pickup_points (id, address) VALUES (6, '410542, г. Лесной, ул. Светлая, 46');
INSERT INTO public.pickup_points (id, address) VALUES (7, '620839, г. Лесной, ул. Цветочная, 8');
INSERT INTO public.pickup_points (id, address) VALUES (8, '443890, г. Лесной, ул. Коммунистическая, 1');
INSERT INTO public.pickup_points (id, address) VALUES (9, '603379, г. Лесной, ул. Спортивная, 46');
INSERT INTO public.pickup_points (id, address) VALUES (10, '603721, г. Лесной, ул. Гоголя, 41');
INSERT INTO public.pickup_points (id, address) VALUES (11, '410172, г. Лесной, ул. Северная, 13');
INSERT INTO public.pickup_points (id, address) VALUES (12, '614611, г. Лесной, ул. Молодежная, 50');
INSERT INTO public.pickup_points (id, address) VALUES (13, '454311, г.Лесной, ул. Новая, 19');
INSERT INTO public.pickup_points (id, address) VALUES (14, '660007, г.Лесной, ул. Октябрьская, 19');
INSERT INTO public.pickup_points (id, address) VALUES (15, '603036, г. Лесной, ул. Садовая, 4');
INSERT INTO public.pickup_points (id, address) VALUES (16, '394060, г.Лесной, ул. Фрунзе, 43');
INSERT INTO public.pickup_points (id, address) VALUES (17, '410661, г. Лесной, ул. Школьная, 50');
INSERT INTO public.pickup_points (id, address) VALUES (18, '625590, г. Лесной, ул. Коммунистическая, 20');
INSERT INTO public.pickup_points (id, address) VALUES (19, '625683, г. Лесной, ул. 8 Марта');
INSERT INTO public.pickup_points (id, address) VALUES (20, '450983, г.Лесной, ул. Комсомольская, 26');
INSERT INTO public.pickup_points (id, address) VALUES (21, '394782, г. Лесной, ул. Чехова, 3');
INSERT INTO public.pickup_points (id, address) VALUES (22, '603002, г. Лесной, ул. Дзержинского, 28');
INSERT INTO public.pickup_points (id, address) VALUES (23, '450558, г. Лесной, ул. Набережная, 30');
INSERT INTO public.pickup_points (id, address) VALUES (24, '344288, г. Лесной, ул. Чехова, 1');
INSERT INTO public.pickup_points (id, address) VALUES (25, '614164, г. Лесной, ул. Степная, 30');
INSERT INTO public.pickup_points (id, address) VALUES (26, '394242, г. Лесной, ул. Коммунистическая, 43');
INSERT INTO public.pickup_points (id, address) VALUES (27, '660540, г. Лесной, ул. Солнечная, 25');
INSERT INTO public.pickup_points (id, address) VALUES (28, '125837, г. Лесной, ул. Шоссейная, 40');
INSERT INTO public.pickup_points (id, address) VALUES (29, '125703, г. Лесной, ул. Партизанская, 49');
INSERT INTO public.pickup_points (id, address) VALUES (30, '625283, г. Лесной, ул. Победы, 46');
INSERT INTO public.pickup_points (id, address) VALUES (31, '614753, г. Лесной, ул. Полевая, 35');
INSERT INTO public.pickup_points (id, address) VALUES (32, '426030, г. Лесной, ул. Маяковского, 44');
INSERT INTO public.pickup_points (id, address) VALUES (33, '450375, г. Лесной ул. Клубная, 44');
INSERT INTO public.pickup_points (id, address) VALUES (34, '625560, г. Лесной, ул. Некрасова, 12');
INSERT INTO public.pickup_points (id, address) VALUES (35, '630201, г. Лесной, ул. Комсомольская, 17');
INSERT INTO public.pickup_points (id, address) VALUES (36, '190949, г. Лесной, ул. Мичурина, 26');
SELECT setval('public.pickup_points_id_seq', 37);
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('А112Т4', 'Ботинки', 'шт.', 4990, 'Kari', 'Kari', 'Женская обувь', 3, 6, 'Женские Ботинки демисезонные kari', '1.jpg');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('F635R4', 'Ботинки', 'шт.', 3244, 'Обувь для вас', 'Marco Tozzi', 'Женская обувь', 2, 13, 'Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый', '2.jpg');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('H782T5', 'Туфли', 'шт.', 4499, 'Kari', 'Kari', 'Мужская обувь', 4, 5, 'Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный', '3.jpg');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('G783F5', 'Ботинки', 'шт.', 5900, 'Kari', 'Рос', 'Мужская обувь', 2, 8, 'Мужские ботинки Рос-Обувь кожаные с натуральным мехом', '4.jpg');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('J384T6', 'Ботинки', 'шт.', 3800, 'Обувь для вас', 'Rieker', 'Мужская обувь', 2, 16, 'B3430/14 Полуботинки мужские Rieker', '5.jpg');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('D572U8', 'Кроссовки', 'шт.', 4100, 'Обувь для вас', 'Рос', 'Мужская обувь', 3, 6, '129615-4 Кроссовки мужские', '6.jpg');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('F572H7', 'Туфли', 'шт.', 2700, 'Kari', 'Marco Tozzi', 'Женская обувь', 2, 14, 'Туфли Marco Tozzi женские летние, размер 39, цвет черный', '7.jpg');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('D329H3', 'Полуботинки', 'шт.', 1890, 'Обувь для вас', 'Alessio Nesca', 'Женская обувь', 4, 4, 'Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый', '8.jpg');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('B320R5', 'Туфли', 'шт.', 4300, 'Kari', 'Rieker', 'Женская обувь', 2, 6, 'Туфли Rieker женские демисезонные, размер 41, цвет коричневый', '9.jpg');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('G432E4', 'Туфли', 'шт.', 2800, 'Kari', 'Kari', 'Женская обувь', 3, 15, 'Туфли kari женские TR-YR-413017, размер 37, цвет: черный', '10.jpg');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('S213E3', 'Полуботинки', 'шт.', 2156, 'Обувь для вас', 'CROSBY', 'Мужская обувь', 3, 6, '407700/01-01 Полуботинки мужские CROSBY', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('E482R4', 'Полуботинки', 'шт.', 1800, 'Kari', 'Kari', 'Женская обувь', 2, 14, 'Полуботинки kari женские MYZ20S-149, размер 41, цвет: черный', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('S634B5', 'Кеды', 'шт.', 5500, 'Обувь для вас', 'CROSBY', 'Мужская обувь', 3, 0, 'Кеды Caprice мужские демисезонные, размер 42, цвет черный', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('K345R4', 'Полуботинки', 'шт.', 2100, 'Обувь для вас', 'CROSBY', 'Мужская обувь', 2, 3, '407700/01-02 Полуботинки мужские CROSBY', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('O754F4', 'Туфли', 'шт.', 5400, 'Обувь для вас', 'Rieker', 'Женская обувь', 4, 18, 'Туфли женские демисезонные Rieker артикул 55073-68/37', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('G531F4', 'Ботинки', 'шт.', 6600, 'Kari', 'Kari', 'Женская обувь', 12, 9, 'Ботинки женские зимние ROMER арт. 893167-01 Черный', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('J542F5', 'Тапочки', 'шт.', 500, 'Kari', 'Kari', 'Мужская обувь', 13, 0, 'Тапочки мужские Арт.70701-55-67син р.41', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('B431R5', 'Ботинки', 'шт.', 2700, 'Обувь для вас', 'Rieker', 'Мужская обувь', 2, 5, 'Мужские кожаные ботинки/мужские ботинки', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('P764G4', 'Туфли', 'шт.', 6800, 'Kari', 'CROSBY', 'Женская обувь', 15, 15, 'Туфли женские, ARGO, размер 38', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('C436G5', 'Ботинки', 'шт.', 10200, 'Kari', 'Alessio Nesca', 'Женская обувь', 15, 9, 'Ботинки женские, ARGO, размер 40', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('F427R5', 'Ботинки', 'шт.', 11800, 'Обувь для вас', 'Rieker', 'Женская обувь', 15, 11, 'Ботинки на молнии с декоративной пряжкой FRAU', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('N457T5', 'Полуботинки', 'шт.', 4600, 'Kari', 'CROSBY', 'Женская обувь', 3, 13, 'Полуботинки Ботинки черные зимние, мех', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('D364R4', 'Туфли', 'шт.', 12400, 'Kari', 'Kari', 'Женская обувь', 16, 5, 'Туфли Luiza Belly женские Kate-lazo черные из натуральной замши', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('S326R5', 'Тапочки', 'шт.', 9900, 'Обувь для вас', 'CROSBY', 'Мужская обувь', 17, 15, 'Мужские кожаные тапочки "Профиль С.Дали"', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('L754R4', 'Полуботинки', 'шт.', 1700, 'Kari', 'Kari', 'Женская обувь', 2, 7, 'Полуботинки kari женские WB2020SS-26, размер 38, цвет: черный', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('M542T5', 'Кроссовки', 'шт.', 2800, 'Обувь для вас', 'Rieker', 'Мужская обувь', 18, 3, 'Кроссовки мужские TOFA', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('D268G5', 'Туфли', 'шт.', 4399, 'Обувь для вас', 'Rieker', 'Женская обувь', 3, 12, 'Туфли Rieker женские демисезонные, размер 36, цвет коричневый', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('T324F5', 'Сапоги', 'шт.', 4699, 'Kari', 'CROSBY', 'Женская обувь', 2, 5, 'Сапоги замша Цвет: синий', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('K358H6', 'Тапочки', 'шт.', 599, 'Kari', 'Rieker', 'Мужская обувь', 20, 2, 'Тапочки мужские син р.41', 'picture.png');
INSERT INTO public.items (item_number, name, unit_measurement, cost, provider, manufacturer, item_category, current_discount, quantity_stock, description, photo) VALUES ('H535R5', 'Ботинки', 'шт.', 2300, 'Обувь для вас', 'Rieker', 'Женская обувь', 2, 7, 'Женские Ботинки демисезонные', 'picture.png');
INSERT INTO public.orders (order_number, order_date, delivery_date, receipt_code, order_status, id_pickup_point, id_user) VALUES (1, '2025-02-27', '2025-04-20', 901, 'Завершен', 1, 4);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (1, 'А112Т4', 2);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (1, 'F635R4', 2);
INSERT INTO public.orders (order_number, order_date, delivery_date, receipt_code, order_status, id_pickup_point, id_user) VALUES (2, '2022-09-28', '2025-04-21', 902, 'Завершен', 11, 1);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (2, 'H782T5', 1);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (2, 'G783F5', 1);
INSERT INTO public.orders (order_number, order_date, delivery_date, receipt_code, order_status, id_pickup_point, id_user) VALUES (3, '2025-03-21', '2025-04-22', 903, 'Завершен', 2, 2);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (3, 'J384T6', 10);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (3, 'D572U8', 10);
INSERT INTO public.orders (order_number, order_date, delivery_date, receipt_code, order_status, id_pickup_point, id_user) VALUES (4, '2025-02-20', '2025-04-23', 904, 'Завершен', 11, 3);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (4, 'F572H7', 5);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (4, 'D329H3', 4);
INSERT INTO public.orders (order_number, order_date, delivery_date, receipt_code, order_status, id_pickup_point, id_user) VALUES (5, '2025-03-17', '2025-04-24', 905, 'Завершен', 2, 4);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (5, 'А112Т4', 2);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (5, 'F635R4', 2);
INSERT INTO public.orders (order_number, order_date, delivery_date, receipt_code, order_status, id_pickup_point, id_user) VALUES (6, '2025-03-01', '2025-04-25', 906, 'Завершен', 15, 1);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (6, 'H782T5', 1);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (6, 'G783F5', 1);
INSERT INTO public.orders (order_number, order_date, delivery_date, receipt_code, order_status, id_pickup_point, id_user) VALUES (7, '2025-02-28', '2025-04-26', 907, 'Завершен', 3, 2);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (7, 'J384T6', 10);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (7, 'D572U8', 10);
INSERT INTO public.orders (order_number, order_date, delivery_date, receipt_code, order_status, id_pickup_point, id_user) VALUES (8, '2025-03-31', '2025-04-27', 908, 'Новый', 19, 3);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (8, 'F572H7', 5);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (8, 'D329H3', 4);
INSERT INTO public.orders (order_number, order_date, delivery_date, receipt_code, order_status, id_pickup_point, id_user) VALUES (9, '2025-04-02', '2025-04-28', 909, 'Новый', 5, 4);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (9, 'B320R5', 5);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (9, 'G432E4', 1);
INSERT INTO public.orders (order_number, order_date, delivery_date, receipt_code, order_status, id_pickup_point, id_user) VALUES (10, '2025-04-03', '2025-04-29', 910, 'Новый', 19, 4);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (10, 'S213E3', 5);
INSERT INTO public.orders_items (order_number, item_number, quantity) VALUES (10, 'E482R4', 5);
SELECT setval('public.orders_order_number_seq', 11);
