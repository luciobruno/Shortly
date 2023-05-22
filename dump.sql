--
-- PostgreSQL database dump
--

-- Dumped from database version 12.14 (Ubuntu 12.14-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.14 (Ubuntu 12.14-0ubuntu0.20.04.1)

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

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    token text NOT NULL,
    "userId" integer,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: shortUrls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."shortUrls" (
    id integer NOT NULL,
    name text NOT NULL,
    url text NOT NULL,
    "userId" integer,
    "visitCount" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: shortUrls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."shortUrls_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shortUrls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."shortUrls_id_seq" OWNED BY public."shortUrls".id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: shortUrls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."shortUrls" ALTER COLUMN id SET DEFAULT nextval('public."shortUrls_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sessions VALUES (1, '91d757c5-a5f5-40e3-a412-946113252425', 1, '2023-05-21 16:42:55.497309');


--
-- Data for Name: shortUrls; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."shortUrls" VALUES (5, 'mT--TPHZHrw2qxT', 'https://www.youtube.com/', 1, 0, '2023-05-22 05:34:35.379082');
INSERT INTO public."shortUrls" VALUES (6, '6IMfu-5B4YesPCb', 'https://www.youtube.com/', 1, 0, '2023-05-22 05:34:36.056509');
INSERT INTO public."shortUrls" VALUES (7, 'Wdqx1ZB2zLBB76b', 'https://www.youtube.com/', 1, 0, '2023-05-22 05:34:36.630284');
INSERT INTO public."shortUrls" VALUES (8, '2VwZWNNIcnnkCmA', 'https://www.youtube.com/', 1, 0, '2023-05-22 05:34:37.182877');
INSERT INTO public."shortUrls" VALUES (9, '-OO8DHzF_H2Pkh3', 'https://www.youtube.com/', 1, 0, '2023-05-22 05:34:37.742302');
INSERT INTO public."shortUrls" VALUES (10, 'OKlm_f92xI-mjVo', 'https://www.youtube.com/', 1, 0, '2023-05-22 05:34:38.247519');
INSERT INTO public."shortUrls" VALUES (11, 'bQIp4_m0O0f22XU', 'https://github.com/', 1, 0, '2023-05-22 05:55:13.338887');
INSERT INTO public."shortUrls" VALUES (12, 'bz-SHvSVyjo-dOd', 'https://github.com/', 1, 0, '2023-05-22 05:55:13.792875');
INSERT INTO public."shortUrls" VALUES (13, 'GLGb1XlG3kr--Nk', 'https://github.com/', 1, 28, '2023-05-22 05:55:14.202778');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES (1, 'João', 'joao@driven.com.br', '$2b$10$W344V17.ANR5GPEA9T4bvuHyJJlT9/J.qaTKbIX5ASzako1jh4WFe', '2023-05-21 16:29:45.068674');


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sessions_id_seq', 1, true);


--
-- Name: shortUrls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."shortUrls_id_seq"', 13, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_token_key UNIQUE (token);


--
-- Name: shortUrls shortUrls_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."shortUrls"
    ADD CONSTRAINT "shortUrls_name_key" UNIQUE (name);


--
-- Name: shortUrls shortUrls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."shortUrls"
    ADD CONSTRAINT "shortUrls_pkey" PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT "sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: shortUrls shortUrls_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."shortUrls"
    ADD CONSTRAINT "shortUrls_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

