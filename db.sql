--
-- PostgreSQL database dump
--

-- Dumped from database version 11.11
-- Dumped by pg_dump version 13.1

-- Started on 2021-04-02 15:43:27

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
-- TOC entry 218 (class 1255 OID 7254564)
-- Name: bookinghistory_archive(); Type: FUNCTION; Schema: public; Owner: cmana072
--

CREATE FUNCTION public.bookinghistory_archive() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF (( SELECT COUNT (*) FROM "bookinghistory")
   >500) THEN
   	INSERT INTO "bookinghistory_archive"
   	SELECT * FROM "bookinghistory" B ORDER 
   BY B.date_in ASC FETCH FIRST 500 ROWS ONLY;
   
   DELETE
   FROM "bookinghistory" as B USING
   "bookinghistory_archive" as A
   WHERE B.booking_id = A.booking_id;
END IF;
END;
$$;


ALTER FUNCTION public.bookinghistory_archive() OWNER TO cmana072;

--
-- TOC entry 204 (class 1255 OID 19846)
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: pgsql
--

CREATE FUNCTION public.plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO pgsql;

--
-- TOC entry 217 (class 1255 OID 7255149)
-- Name: verifytotal(); Type: FUNCTION; Schema: public; Owner: cmana072
--

CREATE FUNCTION public.verifytotal() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF ( SELECT COUNT(*) FROM "bookinghistory" AS numOfRows) THEN
	SELECT totalprice from "bookinghistory";
	RAISE NOTICE 'Total amount booked through the system is (%)', numOfRows*totalPrice;
END IF;
END;
$$;


ALTER FUNCTION public.verifytotal() OWNER TO cmana072;

SET default_tablespace = '';

--
-- TOC entry 201 (class 1259 OID 7198734)
-- Name: bookinghistory; Type: TABLE; Schema: public; Owner: cmana072
--

CREATE TABLE public.bookinghistory (
    booking_id integer NOT NULL,
    roomnumber integer NOT NULL,
    customer_id integer NOT NULL,
    date_in date,
    date_out date,
    totalprice double precision
);


ALTER TABLE public.bookinghistory OWNER TO cmana072;

--
-- TOC entry 203 (class 1259 OID 7254553)
-- Name: bookinghistory_archive; Type: TABLE; Schema: public; Owner: cmana072
--

CREATE TABLE public.bookinghistory_archive (
    booking_id integer,
    roomnumber integer,
    customer_id integer,
    date_in date,
    date_out date,
    totalprice double precision
);


ALTER TABLE public.bookinghistory_archive OWNER TO cmana072;

--
-- TOC entry 196 (class 1259 OID 7148222)
-- Name: customer; Type: TABLE; Schema: public; Owner: mtipp046
--

CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    firstname text,
    lastname text,
    address text,
    sinnumber integer NOT NULL,
    dateofregistration date,
    roomtypebooked text,
    numberofoccupants integer,
    phone text
);


ALTER TABLE public.customer OWNER TO mtipp046;

--
-- TOC entry 199 (class 1259 OID 7148687)
-- Name: hotel; Type: TABLE; Schema: public; Owner: mtipp046
--

CREATE TABLE public.hotel (
    hotel_id integer NOT NULL,
    addressofhotel text,
    starcategory integer NOT NULL,
    phonenumbers text,
    numberofrooms integer,
    contactemail text,
    hotelbrandname text,
    city text
);


ALTER TABLE public.hotel OWNER TO mtipp046;

--
-- TOC entry 202 (class 1259 OID 7219065)
-- Name: customerlistview; Type: VIEW; Schema: public; Owner: mtipp046
--

CREATE VIEW public.customerlistview AS
 SELECT customer.customer_id,
    customer.firstname,
    customer.lastname,
    customer.address,
    customer.sinnumber,
    customer.dateofregistration,
    customer.roomtypebooked,
    customer.numberofoccupants,
    hotel.hotel_id,
    hotel.addressofhotel,
    hotel.starcategory,
    hotel.phonenumbers,
    hotel.numberofrooms,
    hotel.contactemail,
    hotel.hotelbrandname
   FROM public.customer,
    public.hotel
  ORDER BY hotel.hotelbrandname;


ALTER TABLE public.customerlistview OWNER TO mtipp046;

--
-- TOC entry 197 (class 1259 OID 7148230)
-- Name: employees; Type: TABLE; Schema: public; Owner: mtipp046
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    firstname text,
    lastname text,
    address text,
    sinnumber integer NOT NULL,
    salary integer,
    role text
);


ALTER TABLE public.employees OWNER TO mtipp046;

--
-- TOC entry 198 (class 1259 OID 7148632)
-- Name: hotel_brand; Type: TABLE; Schema: public; Owner: mtipp046
--

CREATE TABLE public.hotel_brand (
    hotelbrandname character varying(40) DEFAULT ''::character varying NOT NULL,
    centralofficelocation text,
    physicaladdress text,
    emailaddress text,
    phonenumbers text,
    totalnumberofhotels integer
);


ALTER TABLE public.hotel_brand OWNER TO mtipp046;

--
-- TOC entry 200 (class 1259 OID 7148929)
-- Name: room; Type: TABLE; Schema: public; Owner: mtipp046
--

CREATE TABLE public.room (
    roomnumber integer NOT NULL,
    price double precision,
    spec_tv integer,
    spec_fridge integer,
    spec_ac integer,
    viewtype text,
    capacity integer,
    hotel_id integer NOT NULL,
    spec_extendable integer
);


ALTER TABLE public.room OWNER TO mtipp046;

--
-- TOC entry 3321 (class 0 OID 7198734)
-- Dependencies: 201
-- Data for Name: bookinghistory; Type: TABLE DATA; Schema: public; Owner: cmana072
--

COPY public.bookinghistory (booking_id, roomnumber, customer_id, date_in, date_out, totalprice) FROM stdin;
7433	37	1	2021-03-24	2021-03-17	1043
1029	123	1	2021-03-18	2021-03-04	2506
6646	37	1	2021-03-29	2021-03-01	4172
6082	37	1	2021-03-11	2021-03-25	2086
7825	37	1	2021-03-11	2021-03-25	2086
8394	37	1	2021-03-11	2021-03-25	2086
3634	37	1	2021-03-06	2021-03-20	2086
3655	37	1	2021-03-06	2021-03-20	2086
8537	37	1	2021-03-06	2021-03-20	2086
7573	150	1	2021-04-03	2021-04-06	360
4772	150	1	2021-04-03	2021-04-06	360
9289	150	1	2021-04-03	2021-04-06	360
7694	76	1	2021-04-30	2021-05-28	7000
8141	223	1	2021-03-12	2021-03-25	4329
2536	223	1	2021-03-29	2021-04-02	1332
8982	223	1	2021-03-18	2021-04-15	9324
8586	120	1	2021-03-09	2021-03-10	299
4593	150	1	2021-03-03	2021-04-02	3600
123	345	12	2021-10-03	2021-11-03	145
123	345	12	2021-03-10	2021-11-03	145
123	345	12	2021-03-09	2021-11-03	145
123	345	12	2021-03-09	2021-11-03	145
123	345	12	2021-03-09	2021-11-03	145
123	345	12	2021-03-09	2021-11-03	145
\.


--
-- TOC entry 3322 (class 0 OID 7254553)
-- Dependencies: 203
-- Data for Name: bookinghistory_archive; Type: TABLE DATA; Schema: public; Owner: cmana072
--

COPY public.bookinghistory_archive (booking_id, roomnumber, customer_id, date_in, date_out, totalprice) FROM stdin;
\.


--
-- TOC entry 3316 (class 0 OID 7148222)
-- Dependencies: 196
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: mtipp046
--

COPY public.customer (customer_id, firstname, lastname, address, sinnumber, dateofregistration, roomtypebooked, numberofoccupants, phone) FROM stdin;
1	Elise	Cloutier	245 Something Street	542642431	2021-02-03	ocean-view	4	123-987-4356
2	Chethin	Manage	162 Apple Street	361749156	2021-03-09	ocean-view	4	139-929-9999
3	Matt	Tippin	123 Example Drive	123123123	2021-01-01	ocean-view	4	123-456-7890
\.


--
-- TOC entry 3317 (class 0 OID 7148230)
-- Dependencies: 197
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: mtipp046
--

COPY public.employees (employee_id, firstname, lastname, address, sinnumber, salary, role) FROM stdin;
543216789	Bob	Rodgar	22 Main Street	222333444	65000	Customer Service Desk
123456789	Mark	Smith	64 Park Avenue	123321123	80000	Shift Supervisor
998765432	Nancy	Hiscott	89 King Crescent	567897543	95000	Security
\.


--
-- TOC entry 3319 (class 0 OID 7148687)
-- Dependencies: 199
-- Data for Name: hotel; Type: TABLE DATA; Schema: public; Owner: mtipp046
--

COPY public.hotel (hotel_id, addressofhotel, starcategory, phonenumbers, numberofrooms, contactemail, hotelbrandname, city) FROM stdin;
19	24 Grantley Avenue	2	656-559-4231	200	contact@revaloe.com	Rev Aloe	Sudbury
37	882 Pickle Crescent	5	306-555-0923	350	booking@greatlinuxus.com	Great Linuxus	\N
20	41 Southdown Crescent	1	656-559-4231	350	contact@revaloe.com	Rev Aloe	Fredericton
21	42 Walnut Lane	3	879-568-2326	250	reception@lancaster.ca	Lancaster	Toronto
22	5 Archer Street	5	879-568-2326	300	reception@lancaster.ca	Lancaster	Quebec City
23	84 Seaview Boulevard	4	879-568-2326	550	reception@lancaster.ca	Lancaster	Montreal
24	231 Hawthorn Way	2	879-568-2326	50	reception@lancaster.ca	Lancaster	Sudbury
25	25 Market Lane	3	879-568-2326	400	reception@lancaster.ca	Lancaster	Markham
26	3 Spruce Way	3	231-764-2461	333	reception@laviemontreal.com	La Vie Hotels	Hamilton
27	850 Amber Lane	4	231-764-2461	300	reception@laviemontreal.com	La Vie Hotels	Toronto
1	369 Pleasant Parkway	4	456-579-4747	350	contact@xenoxhotels.ca	Xenox	Ottawa
2	42 Overview Avenue	5	879-568-2326	500	reception@lancaster.ca	Lancaster	Ottawa
3	39 Mountain Road	4	456-579-4747	300	contact@xenoxhotels.ca	Xenox	Kingston
4	482 Road Street	2	656-559-4231	250	contact@revaloe.com	Rev Aloe	Ottawa
5	326 Example Road	3	905-979-9999	100	senatorian@gmail.com	Senatorian	Vancouver
6	72 Parkway Street	4	231-764-2461	350	reception@laviemontreal.com	La Vie Hotels	Edmonton
7	898 Street Way	1	456-579-4747	50	contact@xenoxhotels.ca	Xenox	Sudbury
8	898 Street Way	1	456-579-4747	50	contact@xenoxhotels.ca	Xenox	Montreal
9	156 Average Avenue	3	456-579-4747	150	contact@xenoxhotels.ca	Xenox	Quebec City
10	777 Highroller Hills	5	456-579-4747	500	contact@xenoxhotels.ca	Xenox	Toronto
11	5381 Sheep Street	5	905-979-9999	350	senatorian@gmail.com	Senatorian	Vancouver
12	822 Happy Highway	4	905-979-9999	125	senatorian@gmail.com	Senatorian	Quebec City
13	2 Awful Avenue	2	905-979-9999	275	senatorian@gmail.com	Senatorian	Fredericton
14	202 Mediocre Crescent	4	905-979-9999	500	senatorian@gmail.com	Senatorian	Montreal
15	90 Circe Crescent	3	905-979-9999	314	senatorian@gmail.com	Senatorian	Vancouver
16	55 Electric Avenue	5	656-559-4231	300	contact@revaloe.com	Rev Aloe	Ottawa
17	190 Hereford Gardens	4	656-559-4231	250	contact@revaloe.com	Rev Aloe	Montreal
18	2136 Abbots Park	5	656-559-4231	100	contact@revaloe.com	Rev Aloe	Edmonton
28	192 Meadow Boulevard	5	231-764-2461	450	reception@laviemontreal.com	La Vie Hotels	Vancouver
29	68 Lower Lane	2	231-764-2461	250	reception@laviemontreal.com	La Vie Hotels	Regina
30	520 Berry Boulevard	5	231-764-2461	400	reception@laviemontreal.com	La Vie Hotels	Toronto
31	369 Rocky Road	4	456-999-4237	350	booking@greatlinuxus.com	Great Linuxus	Vancouver
32	923 Rocky Road	4	306-555-0158	350	booking@greatlinuxus.com	Great Linuxus	Markham
33	352 Riverside Avenue	4	306-555-0003	350	booking@greatlinuxus.com	Great Linuxus	Hamilton
34	182 Cantelope Way	5	306-555-0146	350	booking@greatlinuxus.com	Great Linuxus	Toronto
35	723 Condor Parkway	4	306-555-0882	350	booking@greatlinuxus.com	Great Linuxus	Montreal
36	931 Gundersway Road	3	306-555-0321	350	booking@greatlinuxus.com	Great Linuxus	Ottawa
\.


--
-- TOC entry 3318 (class 0 OID 7148632)
-- Dependencies: 198
-- Data for Name: hotel_brand; Type: TABLE DATA; Schema: public; Owner: mtipp046
--

COPY public.hotel_brand (hotelbrandname, centralofficelocation, physicaladdress, emailaddress, phonenumbers, totalnumberofhotels) FROM stdin;
Senatorian	Ottawa, Ontario	100 Main St	senatorian@gmail.com	6134358909	4
Lancaster	London, Ontario	52 Lancaster St	reception@lancaster.ca	5194382231	34
Xenox	Toronto, Ontario	132 Bay St	contact@xenoxhotels.ca	6473695713	11
La Vie Hotels	Montreal, Quebec	85 Montreal Ch	reception@laviemontreal.com	5142711524	19
Rev Aloe	Calgary	100 Queen St	contact@revaloe.com	4032638792	15
Great Linuxus	REgina, Saskatchewan	100 King St	booking@greatlinuxus.com	3065465204	6
\.


--
-- TOC entry 3320 (class 0 OID 7148929)
-- Dependencies: 200
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: mtipp046
--

COPY public.room (roomnumber, price, spec_tv, spec_fridge, spec_ac, viewtype, capacity, hotel_id, spec_extendable) FROM stdin;
150	120	1	1	0	street	2	5	\N
120	299	1	0	0	street	2	1	\N
123	179	1	0	0	street	2	5	\N
496	299	1	1	1	lagoon	2	1	\N
392	399	1	1	1	lagoon	4	1	1
12	250	0	1	1	street	4	1	0
53	325	1	1	0	street	3	1	1
93	99	0	0	0	parking-lot	4	3	0
59	499	1	1	1	ocean-view	4	2	1
55	299	0	1	1	street	3	2	0
54	399	1	0	1	ocean-view	2	2	0
76	250	0	0	0	street	1	2	0
2	499	1	1	1	ocean-view	4	2	1
224	333	1	1	1	beach-front	4	3	\N
56	599	1	1	1	street	4	3	1
97	299	0	1	1	street	3	3	0
68	249	1	0	1	street	2	3	0
90	399	1	1	1	parking-lot	4	3	1
42	149	0	0	0	parking-lot	2	4	\N
37	99	1	1	0	other building	2	2	\N
9	399	1	1	1	street	2	5	0
78	399	1	1	1	street	4	4	1
77	599	1	1	1	city-scape	2	4	0
105	199	0	0	0	parking lot	2	4	0
110	299	1	0	1	street	3	4	1
265	599	0	1	0	street	6	4	1
29	249	1	0	1	parking lot	3	5	1
22	499	1	1	1	city-scape	4	5	1
346	300	1	0	1	beach-front	2	2	\N
\.


--
-- TOC entry 3181 (class 2606 OID 7148229)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: mtipp046
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 3183 (class 2606 OID 7148237)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: mtipp046
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3185 (class 2606 OID 7148640)
-- Name: hotel_brand hotel_brand_pkey; Type: CONSTRAINT; Schema: public; Owner: mtipp046
--

ALTER TABLE ONLY public.hotel_brand
    ADD CONSTRAINT hotel_brand_pkey PRIMARY KEY (hotelbrandname);


--
-- TOC entry 3187 (class 2606 OID 7148694)
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: mtipp046
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (hotel_id);


--
-- TOC entry 3189 (class 2606 OID 7148936)
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: mtipp046
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (roomnumber);


--
-- TOC entry 3193 (class 2620 OID 7255534)
-- Name: bookinghistory archivebookinghistory; Type: TRIGGER; Schema: public; Owner: cmana072
--

CREATE TRIGGER archivebookinghistory AFTER INSERT ON public.bookinghistory FOR EACH STATEMENT EXECUTE PROCEDURE public.bookinghistory_archive();


--
-- TOC entry 3192 (class 2620 OID 7255533)
-- Name: bookinghistory totamt; Type: TRIGGER; Schema: public; Owner: cmana072
--

CREATE TRIGGER totamt AFTER INSERT ON public.bookinghistory FOR EACH STATEMENT EXECUTE PROCEDURE public.verifytotal();


--
-- TOC entry 3190 (class 2606 OID 7148695)
-- Name: hotel hotel_brand_exists; Type: FK CONSTRAINT; Schema: public; Owner: mtipp046
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_brand_exists FOREIGN KEY (hotelbrandname) REFERENCES public.hotel_brand(hotelbrandname) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3191 (class 2606 OID 7148937)
-- Name: room hotel_exists; Type: FK CONSTRAINT; Schema: public; Owner: mtipp046
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT hotel_exists FOREIGN KEY (hotel_id) REFERENCES public.hotel(hotel_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3328 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO pgsql;


--
-- TOC entry 3329 (class 0 OID 0)
-- Dependencies: 218
-- Name: FUNCTION bookinghistory_archive(); Type: ACL; Schema: public; Owner: cmana072
--

GRANT ALL ON FUNCTION public.bookinghistory_archive() TO mtipp046 WITH GRANT OPTION;


--
-- TOC entry 3330 (class 0 OID 0)
-- Dependencies: 201
-- Name: TABLE bookinghistory; Type: ACL; Schema: public; Owner: cmana072
--

GRANT ALL ON TABLE public.bookinghistory TO PUBLIC;


--
-- TOC entry 3331 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE bookinghistory_archive; Type: ACL; Schema: public; Owner: cmana072
--

REVOKE ALL ON TABLE public.bookinghistory_archive FROM cmana072;
GRANT ALL ON TABLE public.bookinghistory_archive TO cmana072 WITH GRANT OPTION;
GRANT ALL ON TABLE public.bookinghistory_archive TO mtipp046 WITH GRANT OPTION;
SET SESSION AUTHORIZATION mtipp046;
GRANT ALL ON TABLE public.bookinghistory_archive TO cmana072;
RESET SESSION AUTHORIZATION;
SET SESSION AUTHORIZATION mtipp046;
GRANT ALL ON TABLE public.bookinghistory_archive TO eclou020;
RESET SESSION AUTHORIZATION;
GRANT ALL ON TABLE public.bookinghistory_archive TO eclou020 WITH GRANT OPTION;


--
-- TOC entry 3332 (class 0 OID 0)
-- Dependencies: 196
-- Name: TABLE customer; Type: ACL; Schema: public; Owner: mtipp046
--

GRANT ALL ON TABLE public.customer TO cmana072 WITH GRANT OPTION;
GRANT ALL ON TABLE public.customer TO eclou020 WITH GRANT OPTION;


--
-- TOC entry 3333 (class 0 OID 0)
-- Dependencies: 199
-- Name: TABLE hotel; Type: ACL; Schema: public; Owner: mtipp046
--

GRANT ALL ON TABLE public.hotel TO cmana072 WITH GRANT OPTION;
GRANT ALL ON TABLE public.hotel TO eclou020 WITH GRANT OPTION;


--
-- TOC entry 3334 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE customerlistview; Type: ACL; Schema: public; Owner: mtipp046
--

GRANT ALL ON TABLE public.customerlistview TO cmana072;
GRANT ALL ON TABLE public.customerlistview TO eclou020;


--
-- TOC entry 3335 (class 0 OID 0)
-- Dependencies: 197
-- Name: TABLE employees; Type: ACL; Schema: public; Owner: mtipp046
--

GRANT ALL ON TABLE public.employees TO cmana072 WITH GRANT OPTION;
GRANT ALL ON TABLE public.employees TO eclou020 WITH GRANT OPTION;


--
-- TOC entry 3336 (class 0 OID 0)
-- Dependencies: 198
-- Name: TABLE hotel_brand; Type: ACL; Schema: public; Owner: mtipp046
--

GRANT ALL ON TABLE public.hotel_brand TO cmana072 WITH GRANT OPTION;
GRANT ALL ON TABLE public.hotel_brand TO eclou020 WITH GRANT OPTION;


--
-- TOC entry 3337 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE room; Type: ACL; Schema: public; Owner: mtipp046
--

GRANT ALL ON TABLE public.room TO cmana072 WITH GRANT OPTION;
GRANT ALL ON TABLE public.room TO eclou020 WITH GRANT OPTION;


--
-- TOC entry 1711 (class 826 OID 7255626)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: mtipp046
--

ALTER DEFAULT PRIVILEGES FOR ROLE mtipp046 GRANT ALL ON TABLES  TO eclou020 WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES FOR ROLE mtipp046 GRANT ALL ON TABLES  TO cmana072 WITH GRANT OPTION;


-- Completed on 2021-04-02 15:43:34

--
-- PostgreSQL database dump complete
--

