--
-- PostgreSQL database dump
--

-- Dumped from database version 10.17 (Ubuntu 10.17-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.17 (Ubuntu 10.17-0ubuntu0.18.04.1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username text NOT NULL,
    email character varying(254),
    create_time timestamp with time zone,
    update_time timestamp with time zone,
    admin_type text NOT NULL,
    problem_permission text NOT NULL,
    is_verified boolean NOT NULL,
    is_active boolean NOT NULL,
    is_staff boolean NOT NULL,
    profile_pic character varying(100),
    first_name character varying(100),
    last_name character varying(100)
);


ALTER TABLE public.accounts_user OWNER TO postgres;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_groups_id_seq OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_groups_id_seq OWNED BY public.accounts_user_groups.id;


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_id_seq OWNER TO postgres;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts_user.id;


--
-- Name: accounts_user_solved_problem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_solved_problem (
    id integer NOT NULL,
    user_id integer NOT NULL,
    problem_id integer NOT NULL
);


ALTER TABLE public.accounts_user_solved_problem OWNER TO postgres;

--
-- Name: accounts_user_solved_problem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_solved_problem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_solved_problem_id_seq OWNER TO postgres;

--
-- Name: accounts_user_solved_problem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_solved_problem_id_seq OWNED BY public.accounts_user_solved_problem.id;


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_user_permissions_id_seq OWNED BY public.accounts_user_user_permissions.id;


--
-- Name: announcement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.announcement (
    id integer NOT NULL,
    title character varying(255),
    content text,
    creation_time timestamp with time zone NOT NULL,
    author_id integer,
    is_visible boolean
);


ALTER TABLE public.announcement OWNER TO postgres;

--
-- Name: announcement_announcement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.announcement_announcement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.announcement_announcement_id_seq OWNER TO postgres;

--
-- Name: announcement_announcement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.announcement_announcement_id_seq OWNED BY public.announcement.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO postgres;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_q_ormq; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_q_ormq (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    payload text NOT NULL,
    lock timestamp with time zone
);


ALTER TABLE public.django_q_ormq OWNER TO postgres;

--
-- Name: django_q_ormq_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_q_ormq_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_q_ormq_id_seq OWNER TO postgres;

--
-- Name: django_q_ormq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_q_ormq_id_seq OWNED BY public.django_q_ormq.id;


--
-- Name: django_q_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_q_schedule (
    id integer NOT NULL,
    func character varying(256) NOT NULL,
    hook character varying(256),
    args text,
    kwargs text,
    schedule_type character varying(1) NOT NULL,
    repeats integer NOT NULL,
    next_run timestamp with time zone,
    task character varying(100),
    name character varying(100),
    minutes smallint,
    cron character varying(100),
    CONSTRAINT django_q_schedule_minutes_check CHECK ((minutes >= 0))
);


ALTER TABLE public.django_q_schedule OWNER TO postgres;

--
-- Name: django_q_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_q_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_q_schedule_id_seq OWNER TO postgres;

--
-- Name: django_q_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_q_schedule_id_seq OWNED BY public.django_q_schedule.id;


--
-- Name: django_q_task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_q_task (
    name character varying(100) NOT NULL,
    func character varying(256) NOT NULL,
    hook character varying(256),
    args text,
    kwargs text,
    result text,
    started timestamp with time zone NOT NULL,
    stopped timestamp with time zone NOT NULL,
    success boolean NOT NULL,
    id character varying(32) NOT NULL,
    "group" character varying(100),
    attempt_count integer NOT NULL
);


ALTER TABLE public.django_q_task OWNER TO postgres;

--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: judge_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.judge_server (
    id integer NOT NULL,
    hostname character varying(256),
    socketaddress character varying(40) NOT NULL,
    token character varying(32) NOT NULL,
    is_disabled boolean NOT NULL,
    last_heartbeat timestamp with time zone,
    added_time timestamp with time zone NOT NULL,
    max_pending_tasks integer NOT NULL,
    pending_tasks integer NOT NULL
);


ALTER TABLE public.judge_server OWNER TO postgres;

--
-- Name: judge_server_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.judge_server_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.judge_server_id_seq OWNER TO postgres;

--
-- Name: judge_server_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.judge_server_id_seq OWNED BY public.judge_server.id;


--
-- Name: problem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.problem (
    id integer NOT NULL,
    display_id text NOT NULL,
    created timestamp with time zone NOT NULL,
    visible boolean,
    title text NOT NULL,
    statement text NOT NULL,
    difficulty character varying(50) NOT NULL,
    source text,
    sample_test jsonb,
    testset_dir text,
    testset_count integer NOT NULL,
    time_limit integer NOT NULL,
    memory_limit integer NOT NULL,
    total_submission bigint NOT NULL,
    correct_submission bigint NOT NULL,
    statistic_info jsonb NOT NULL,
    author_id integer,
    CONSTRAINT problem_testset_count_check CHECK ((testset_count >= 0))
);


ALTER TABLE public.problem OWNER TO postgres;

--
-- Name: problem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.problem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problem_id_seq OWNER TO postgres;

--
-- Name: problem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.problem_id_seq OWNED BY public.problem.id;


--
-- Name: problem_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.problem_tags (
    id integer NOT NULL,
    problem_id integer NOT NULL,
    problemtag_id integer NOT NULL
);


ALTER TABLE public.problem_tags OWNER TO postgres;

--
-- Name: problem_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.problem_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problem_tags_id_seq OWNER TO postgres;

--
-- Name: problem_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.problem_tags_id_seq OWNED BY public.problem_tags.id;


--
-- Name: problemtag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.problemtag (
    id integer NOT NULL,
    tag_name text NOT NULL
);


ALTER TABLE public.problemtag OWNER TO postgres;

--
-- Name: problemtag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.problemtag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problemtag_id_seq OWNER TO postgres;

--
-- Name: problemtag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.problemtag_id_seq OWNED BY public.problemtag.id;


--
-- Name: submission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.submission (
    id integer NOT NULL,
    submit_time timestamp with time zone NOT NULL,
    content text,
    language character varying(50) NOT NULL,
    verdict character varying(20) NOT NULL,
    output jsonb NOT NULL,
    author_id integer,
    problem_id integer
);


ALTER TABLE public.submission OWNER TO postgres;

--
-- Name: submission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.submission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submission_id_seq OWNER TO postgres;

--
-- Name: submission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.submission_id_seq OWNED BY public.submission.id;


--
-- Name: accounts_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_id_seq'::regclass);


--
-- Name: accounts_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_groups_id_seq'::regclass);


--
-- Name: accounts_user_solved_problem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_solved_problem ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_solved_problem_id_seq'::regclass);


--
-- Name: accounts_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_user_permissions_id_seq'::regclass);


--
-- Name: announcement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.announcement ALTER COLUMN id SET DEFAULT nextval('public.announcement_announcement_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_q_ormq id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_q_ormq ALTER COLUMN id SET DEFAULT nextval('public.django_q_ormq_id_seq'::regclass);


--
-- Name: django_q_schedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_q_schedule ALTER COLUMN id SET DEFAULT nextval('public.django_q_schedule_id_seq'::regclass);


--
-- Name: judge_server id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.judge_server ALTER COLUMN id SET DEFAULT nextval('public.judge_server_id_seq'::regclass);


--
-- Name: problem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem ALTER COLUMN id SET DEFAULT nextval('public.problem_id_seq'::regclass);


--
-- Name: problem_tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags ALTER COLUMN id SET DEFAULT nextval('public.problem_tags_id_seq'::regclass);


--
-- Name: problemtag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problemtag ALTER COLUMN id SET DEFAULT nextval('public.problemtag_id_seq'::regclass);


--
-- Name: submission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission ALTER COLUMN id SET DEFAULT nextval('public.submission_id_seq'::regclass);


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, email, create_time, update_time, admin_type, problem_permission, is_verified, is_active, is_staff, profile_pic, first_name, last_name) FROM stdin;
11	pbkdf2_sha256$260000$mor4Btd1NUXpN2B16G3Zq9$l9I9314ie40hGJgUzccLdzg3ZHYF0QqgP7wT0Ye3SNk=	\N	f	qhuy4919	qhuy4919@gmail.com	2021-05-15 03:33:03.679712+00	2021-05-15 03:33:03.679734+00	Regular User	None	f	t	f	profile1.png	\N	\N
12	pbkdf2_sha256$260000$0rwHAaF4qXMqkuWEEbbdrX$aQTqCNhvwoHoWOoksDkK+wA1wGwwNphXta5czJKJ0uU=	\N	f	qhuy4499	qhuy4919@gmail.com	2021-05-15 03:33:51.630054+00	2021-05-15 03:33:51.630075+00	Regular User	None	f	t	f	profile1.png	\N	\N
13	pbkdf2_sha256$260000$XXUwKxYJLdQhEXHJh380Hc$D6WCkXJ05vktC7drYFCghiidKLRh5YH8OFkksxGG0io=	2021-05-15 03:38:55.312591+00	f	hiuhiu	qhuy4919@gmail.com	2021-05-15 03:38:10.203694+00	2021-05-15 03:38:10.203717+00	Regular User	None	f	t	f	profile1.png	\N	\N
14	pbkdf2_sha256$260000$X1UOgRAGDifmvpJJUR7yhS$lN1XH0kMdonQViNQ6B8cy+sJHhcTkeBNKv7ZchRU9k8=	2021-05-15 03:41:12.480458+00	f	user4919	hehehe@email.com	2021-05-15 03:39:51.095745+00	2021-05-15 03:39:51.095766+00	Regular User	None	f	t	f	profile1.png	\N	\N
18	pbkdf2_sha256$260000$HLCSDF9USYzschXGsAiVEH$kFqN+9VXWMkAvdBX0ZQiIJC2A037vvU+LWwX7u73Bnk=	\N	f	user1234	quanghuy4919@gmail.com	2021-05-16 10:08:22.173006+00	2021-05-16 10:08:22.173029+00	Regular User	None	f	t	f	profile1.png	\N	\N
19	pbkdf2_sha256$260000$6dYtIMJgqIWidfbSQ1XDNd$tXGCe28TxiyVvxKfjNKejjB1FKYy248V3g3W802ajpk=	\N	f	qhuy123	quanghuy4919@gmail.com	2021-05-18 11:15:42.315652+00	2021-05-18 11:15:42.315673+00	Regular User	None	f	t	f	profile1.png	\N	\N
15	pbkdf2_sha256$260000$owfW0wVfPMMLyfDP9SLxpV$5PxIXJzuVnLzM7U1u39eNz4eIFVoaDGOEttfL53r2c8=	2021-06-11 06:34:26.254155+00	f	user0409	hiuhiu@gmail.com	2021-05-15 03:42:17.837832+00	2021-05-15 03:42:17.837853+00	Regular User	None	f	t	f	profile1.png	\N	\N
32	pbkdf2_sha256$260000$w3p63YhfQFgS1zYOBP73vK$GnzaPyecK6HG1lJpjZIN0F650vmRWI0RpfYecJFeyes=	2021-06-11 11:14:06.711538+00	f	toilaphuc	phuc@gmail.com	2021-06-11 11:13:51.849223+00	2021-06-11 11:13:51.849242+00	Regular User	None	f	t	f	avatar/__default__.png	\N	\N
31	pbkdf2_sha256$260000$4TOcgj94dvhh3cTndgf3Bd$uqhGUijUfZufkJxjEK8orOYuCVLMMq5Nb+s4w8N0slU=	2021-06-11 12:47:34.178066+00	f	nvat	nvatuan2000@gmail.com	2021-06-11 08:45:25.798549+00	2021-06-11 12:47:52.373716+00	Regular User	None	f	t	f	avatar/31.png	\N	\N
7	pbkdf2_sha256$260000$H8s1S8ZWhAIxnvDZGoqaVX$DubrmhzEqR0LgiYWMHNXas3ngPBObwYNjgMZ6X+xdVw=	2021-05-09 14:56:16.33737+00	f	user0006	user0006@g.com	2021-05-09 14:56:07.383223+00	2021-06-09 08:37:54.772182+00	Regular User	None	f	t	f	profile1.png	\N	\N
28	pbkdf2_sha256$260000$uIebnwNwzWSBPC7CwuCYrZ$lVmb+yy6wTWioHk+vmMiQMY952/DFmbicMxgpT+PXRI=	\N	f	admin3	admin3@email.com	2021-06-09 09:46:10.698916+00	2021-06-09 09:46:59.705587+00	Super Admin	All	f	t	f	avatar/__default__.png	\N	\N
10	pbkdf2_sha256$260000$He0mCtsosisSA7NobomaZp$EYXdo8KTB/I1HATeRaGjAPOHJrycgGxo4C4nwic9hcU=	2021-05-09 15:01:48.11962+00	f	qhuy	123@gmail.com	2021-05-09 15:01:34.44116+00	2021-06-09 10:03:14.263989+00	Admin	None	f	t	t	profile1.png	\N	\N
26	pbkdf2_sha256$260000$9FNjT3sThbmz7TTxXpoqzl$dV9QlI1vnCTpA55bu5LSuqeW1lyRYCPA3XOHdNYqAvw=	\N	f	qhuy11	quanghuy4919@gmail.com	2021-05-18 14:04:36.132797+00	2021-06-09 10:04:04.485464+00	Admin	None	f	t	t	profile1.png	\N	\N
16	pbkdf2_sha256$260000$275i4bzRghLRKLWuZ2PCLC$XrsOu+Sta4pOPHerVqy7J1OzkFsgbZFC+yKNAZcz07Q=	2021-05-16 10:01:16.654908+00	f	hiu4919	blablabla@bla.com	2021-05-16 10:00:48.346331+00	2021-06-09 10:04:19.423161+00	Admin	None	f	t	t	profile1.png	\N	\N
17	pbkdf2_sha256$260000$VaOQ5yTOiiFWtxpaW2F3X2$O2Xo/axPLdbNQkRD3kknOBU1zWYO3H31TuzUiIAtzO8=	\N	f	abcxyz	dsfsdf@gmail.com	2021-05-16 10:05:46.01972+00	2021-06-10 09:30:15.257885+00	Admin	None	f	t	t	profile1.png	\N	\N
1	pbkdf2_sha256$260000$eqWXg6pzOll8I4tyT3PN1D$AbBIK0zPuoSgBOslheiUGWPH/Xy+5lGlClmftd4nXvs=	2021-06-14 08:49:48.867645+00	f	user0001	user0001@mail.com	2021-05-08 22:42:57.134632+00	2021-06-09 09:44:18.817278+00	Regular User	None	f	t	f	avatar/1.txt	\N	\N
30	pbkdf2_sha256$260000$tBDpXra2tgBxmMdwCxDvj3$DwNztsca008DTzmpM8xYcn5SYFFIQWrzZR5Ry5ti418=	2021-06-11 08:45:10.827494+00	f	fake	fake@gmail.com	2021-06-11 08:45:02.207508+00	2021-06-11 08:45:02.207527+00	Regular User	None	f	t	f	avatar/__default__.png	\N	\N
29	pbkdf2_sha256$260000$mBdvuOX0dcWznRpjpteYDe$GVKQdYoqoz+m15sxea6mSE7kbJYhjHDJZ4w/7JymczA=	2021-07-07 05:59:04.033897+00	f	admin	admin@doj.com	2021-06-10 07:53:16.59748+00	2021-06-15 04:15:53.540521+00	Super Admin	All	f	t	f	avatar/29_9X2tSI1.png	hic	hu
34	pbkdf2_sha256$260000$uMPjYJr8vQnTVAPgz1wA4e$ncuR5bu/B06w0zGTAdusIUXvtOkP76sflHAGcz00OQw=	2021-06-12 13:13:22.204514+00	f	asdfasdf	asdfasdf@a.com	2021-06-12 13:10:39.330654+00	2021-06-12 13:10:39.33067+00	Regular User	None	f	t	f	avatar/__default__.png	\N	\N
33	pbkdf2_sha256$260000$uj4c4cnMKq9igXbZcRjkVx$12JIDWyIYaIWRLAuxknuqZWFeFt/EsAJdykI/Mbn4ic=	2021-06-12 11:24:29.687206+00	f	viet	2000viet@gmail.com	2021-06-12 11:22:44.019312+00	2021-06-12 11:22:44.019327+00	Regular User	None	f	t	f	avatar/__default__.png	\N	\N
27	pbkdf2_sha256$260000$caN7Y2ajI1BixB5aCuGdlh$xPeGET00p9K0v+hjoP+d6KcbinH22BgqVwL3szmwHcI=	2021-06-14 09:49:36.779193+00	f	admin2	admin2@email.com	2021-06-09 09:46:06.238566+00	2021-06-09 09:46:53.237242+00	Super Admin	All	f	t	f	avatar/__default__.png	\N	\N
35	pbkdf2_sha256$260000$0A38hfCu1I220qW9Sfwtjf$9Mqc58b96dPBtlmmouu18DB44CCWbdInh/354iTEEW8=	\N	f	abc123	abc@gmail.com	2021-06-15 01:58:43.580095+00	2021-06-15 01:58:43.580112+00	Regular User	None	f	t	f	avatar/__default__.png	\N	\N
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_solved_problem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_solved_problem (id, user_id, problem_id) FROM stdin;
7	29	1
8	29	6
11	31	6
12	32	6
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: announcement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.announcement (id, title, content, creation_time, author_id, is_visible) FROM stdin;
38	Thông báo 4 	hiu	2021-06-13 15:04:10.037367+00	29	f
36	Thông báo 2	123456789	2021-06-13 14:44:24.641483+00	29	t
34	Hello anh Phúc	adlkfjasldfjalfjalsd;fja;dsfjlasdfjlafjadl;fjadlfjaljfladjslfjsd	2021-06-10 10:08:01.964849+00	29	t
37	thông báo 3	aa\n	2021-06-13 15:03:59.969108+00	29	t
39	Long Long Post	Truyện cười số 1:\n\nChuyện Luật Sư:\nMột ông luật sư vừa mở cửa chiếc xe BMW bước xuống đường thì bổng đâu có một xe khác phóng nhanh qua và quạt mất cái cửa xe của chiếc BMW . Khi cảnh sát đến hiện trường thì thấy ông ta đang nhảy nhỏm có vẻ tức giận lắm, thấy vị cảnh sát ông ta gằn giọng phàn nàn:\n\n– Ông xem, chúng làm thiệt hại nặng nề cho cái xe BMW mới của tôi đến thế này này.\n\nVị cảnh sát quan sát hiện trường rồi nói:\n\n– Bọn luật sư các ông chỉ coi vật chất là trên hết! Ông chỉ quan tâm đến cái xe BMW mắc dịch này mà chẳng biết rằng cái cánh tay trái của ông cũng đã bị quật rụng mất tiêu rồi!\n\nÔng luật sư kinh hoảng khi nhìn thấy cánh tay mình đã cụt mất, và kêu toáng lên:\n\n– Tôi phải tìm nó ngay. Tôi đeo cái đồng hồ Rolex ở cổ tay đó , mau mau tìm giùm tôi đi, mau lên mau lên!!!\n\nTruyện cười số 2:\n\nKhông phải chuyện nhỏ\nBạn tù hỏi nhau:\n\n– Tại sao anh phải vào đây?\n\n– Tôi bỏ vợ…\n\n– Thế thôi sao? Chuyện nhỏ mà!\n\n– … từ trên lầu ba xuống.\n\nTruyện cười số 3:\n\nTrắc nghiệm tâm lý\nChồng bàn với vợ:\n\n– Anh đặt lên bàn ba thứ để xem con mình sẽ lấythứ gì. Nếu nó lấy tờ 100 USD, tương lai nó sẽ là nhà tài chính.Nếu lấy cây viết, nó sẽ là nhà văn, còn nếu cầm quyển kinh thì nósẽ làm linh mục.\n\nLát sau, cậu con vào phòng vớ cả ba thứ rồi chạyra ngoài. Trong khi vợ còn đần mặt trước tình huống bất ngờ, chồng lẩm bẩm:\n\n– Phương án thứ tư…\n\nVợ sốt ruột hỏi:\n\n– Là sao hở anh?\n\n– Là ăn cướp chứ còn sao nữa!\n\nTruyện cười số 4:\n\nCon vật kỳ lạ\nMột cô gái tóc vàng xinh đẹp dáo để đi về quê thăm bà con. Bên vệ đường cô nhìn thấy một con vật rất kỳ lạ, nên thắc mắc hỏi một nông dân đứng gần đó:\n\n– Xin bác giải thích cho cháu biết vì sao con bò này không có sừng ạ?\n\nÔng ta ngước đầu lên nhìn sững vào cô ta một lúc rồi từ từ giải thích:\n\n– Thưa bà, có những con vật có sức mạnh phi thường hay dùng cái sừng của mình để gây tai hoạ. Do đó chúng tôi phải đối phó với chúng bằng cách dùng cưa cắt cho ngắn bớt. Sau đó nhểu lên đó vài giọt axit cho cặp sừng không bao giờ mọc được nữa. Còn trường hợp con bò này không có sừng, bởi vì nó là… con ngựa ạ!\n\nTruyện cười số 5:\n\nBố kẻ bị nạn\nMột vụ tai nạn giao thông vừa xảy ra ngoài phố. Mọi người tò mò chen lấn vòng trong vòng ngoài để xem. Một anh línhđến chậm không tài nào vào xem được. Tức quá, anh ta liền hét toáng lên:\n\n– Tôi là bố kẻ bị nạn đây!\n\nMọi người kinh ngạc quay lại nhìn và vội vã giãn ra cho anh ta vào. “Kẻ bị nạn” là một… chú chó vừa bị xe cán chết.\n\nTruyện cười số 6:\n\nThua 3-1 nhưng còn lãi 7 đồng\nMột gã trẻ tuổi gặp một ông già. Đang huênh hoang muốn khoe trình độ mình hơn người, gã bèn rủ:\n\n– Tôi với ông so kiến thức bằng cách đố nhau nhé!\n\nÔng già đắn đo, gã bèn đặt thêm điều kiện:\n\n– Nếu thắng ông được 10 đồng, nếu thua ông chỉ mất 1 đồng thôi!\n\n– Nhất trí, anh đố trước đi.\n\n– Thế tay nào lên vũ trụ đầu tiên?\n\nÔng già không trả lời, lẳng lặng rút tờ 1 đồngtrả cho gã trẻ tuổi. Được thể, hắn hỏi tiếp:\n\n– Thế ai phát minh ra định luật bảo toàn khối lượng?\n\nChịu. Lại 1 tờ nữa.\n\n– Thôi, anh đố nhiều rồi. Để tôi đố anh 1 câu được không?\n\n– Đồng ý!\n\n– Con gì lên đồi bằng 2 chân, còn xuống đồi bằng 3 chân?\n\nSau một hồi lâu suy nghĩ, gã thanh niên quyết định rút tờ 10 đồng ra, đưa cho đối thủ và hỏi lại:\n\n– Không biết! Thế con gì đấy hả ông?\n\nÔng già lẳng lặng rút tiếp tờ 1 đồng đưa cho gã trẻ.\n\nTruyện cười số 7:\n\nTrượt chân\nChuyện kể rằng: Có một hồ nước thiêng ở Canada. Ai muốn ước gì cứ nói lời ước của mình rồi nhảy xuống hồ tắm là được toại nguyện. Thế là mọi người từ khắp nơi trên thế giới kéo nhau đến rất đông. Người thì ước thành gấu trắng, người thì muốn thành đại bàng và có người còn ước thành hoa anh đào nữa. Có một anh đến bên hồ, hấp tấp thế nào lại trượt chân, vội thốt lên “Oh,SHIT!” và … rơi tõm xuống hồ.\n\nTruyện cười số 8:\n\nBí mật khủng khiếp\n– Bí mật khủng khiếp đây! Đã có năm mươi nạn nhân! Mua báo không ông?\n\nKhách qua đường mua một tờ, xem lướt qua:\n\n– Này, thằng nhóc kia, làm gì có bí mật với nạnnhân nào?\n\n– Đó chính là bí mật khủng khiếp mà ông là nạn nhân.\n\n– !?\n\n– Báo đây! Bí mật khủng khiếp, đã có năm mươi mốt nạn nhân… Báo đây…\n\nTruyện cười số 9:\n\nBước chuẩn bị gay cấn\nCó một bà đỡ khá lành nghề nhưng hay mất bình tĩnh. Người ta gọi bà đến đỡ một ca đẻ con so, tới với hòm dụng cụ trong tay, bà nói với người chồng:\n\n– Mời anh ra ngoài, cần gì tôi sẽ gọi.\n\nSản phụ đã bắt đầu la hét. Khoảng 10 phút sau, bà thò đầu ra cửa và nói:\n\n– Anh có kìm không?\n\n– Hả?! Anh chồng tròn mắt hỏi.\n\n– Vâng, kìm, nhanh lên! Không hả hở gì hết, tôi biết việc tôi phải làm.\n\nCó kìm rồi, khoảng 5 phút sau, bà lại xuất hiện ở cửa:\n\n– Anh có cái cờ lê to không?\n\n– Cờ lê à? Lạy chúa, điều gì đã xảy ra với vợtôi?\n\n– À… không sao, nhưng tôi cần một cái cờlê.\n\nNgười chồng bâng khuâng ngắm cái cờ lê rồi miễn cưỡng đưa nó cho bà ta. Cửa khép lại, tiếng kim loại va chạm nhau xủng xoảng, két… két. Anh chồng ở ngoài nghiến chặt răng, mặt tái dại, chân tay run bần bật. Được một lát, thở hổn hển, mặt nhễ nhại mồ hôi, bà thò đầu ra cửa quát:\n\n– Hãy nghe đây, tìm ngay một cái búa tạ, nếu chậm thì không kịp mất!\n\nĐến nước này, anh chồng không chịu nổi nữa, xô cửa xông vào, trước mắt anh là nền nhà ngổn ngang kìm, búa… và hòm dụng cụ chưa mở được.\n\nTruyện cười số 10:\n\nCó giỏi cũng không thắng được!\nNgày tận thế, thiên đàng và địa ngục tranh chấp lãnh thổ trên mặt đất. Bên bàn đàm phán, Satan – đại diện địa ngục- đề nghị sẽ có một trận đá bóng để giải quyết vấn đề này. Trợ lýcủa Satan nói nhỏ:\n\n– Như thế sẽ rất bất lợi cho chúng ta, bởi tất cả các cầu thủ giỏi đã lên thiên đàng.\n\n– Đừng lo, ngươi không nhớ là tất cả các trọng tài đều đã xuống địa ngục sao?	2021-06-14 08:47:32.5879+00	27	t
35	Test announcement	Yêu Tổ quốc, yêu đồng bào\n\nHọc tập tốt, lao động tốt\n\nĐoàn kết tốt, kỷ luật tốt\n\nGiữ gìn vệ sinh thật tốt,\n\nKhiêm tốn, thật thà, dũng cảm	2021-06-13 08:42:17.661054+00	29	f
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add Token	6	add_token
22	Can change Token	6	change_token
23	Can delete Token	6	delete_token
24	Can view Token	6	view_token
25	Can add token	7	add_tokenproxy
26	Can change token	7	change_tokenproxy
27	Can delete token	7	delete_tokenproxy
28	Can view token	7	view_tokenproxy
29	Can add user	8	add_user
30	Can change user	8	change_user
31	Can delete user	8	delete_user
32	Can view user	8	view_user
33	Can add announcement	9	add_announcement
34	Can change announcement	9	change_announcement
35	Can delete announcement	9	delete_announcement
36	Can view announcement	9	view_announcement
37	Can add submission	10	add_submission
38	Can change submission	10	change_submission
39	Can delete submission	10	delete_submission
40	Can view submission	10	view_submission
41	Can add problem tag	11	add_problemtag
42	Can change problem tag	11	change_problemtag
43	Can delete problem tag	11	delete_problemtag
44	Can view problem tag	11	view_problemtag
45	Can add problem	12	add_problem
46	Can change problem	12	change_problem
47	Can delete problem	12	delete_problem
48	Can view problem	12	view_problem
49	Can add Scheduled task	13	add_schedule
50	Can change Scheduled task	13	change_schedule
51	Can delete Scheduled task	13	delete_schedule
52	Can view Scheduled task	13	view_schedule
53	Can add task	14	add_task
54	Can change task	14	change_task
55	Can delete task	14	delete_task
56	Can view task	14	view_task
57	Can add Failed task	15	add_failure
58	Can change Failed task	15	change_failure
59	Can delete Failed task	15	delete_failure
60	Can view Failed task	15	view_failure
61	Can add Successful task	16	add_success
62	Can change Successful task	16	change_success
63	Can delete Successful task	16	delete_success
64	Can view Successful task	16	view_success
65	Can add Queued task	17	add_ormq
66	Can change Queued task	17	change_ormq
67	Can delete Queued task	17	delete_ormq
68	Can view Queued task	17	view_ormq
69	Can add judge server	18	add_judgeserver
70	Can change judge server	18	change_judgeserver
71	Can delete judge server	18	delete_judgeserver
72	Can view judge server	18	view_judgeserver
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
4c846ed81f33e75aab0ef089f161d7ba5cf5b768	2021-05-08 22:44:35.21564+00	1
55ee2bf7eaca2c1efed6600eeadc599e63ba9eb9	2021-06-12 11:24:29.69299+00	33
41f9054c7e29265588a24a454080d34c8df7fe1e	2021-05-09 14:56:16.352404+00	7
6097d0b4476720d84085f3ebcc3f279120e803c7	2021-05-09 15:01:48.128764+00	10
5e308418697d69a78dc92348874a3e670debcc46	2021-05-15 03:38:55.318555+00	13
f9fcc3130bba54e71db69f17ba58b8860897a591	2021-05-15 03:41:12.485966+00	14
d7bcbf16c6d6cd4b20e070783583a3e4c3165066	2021-05-16 10:01:16.661931+00	16
201add30543bb2e502338bda84ec736524303744	2021-06-14 09:45:36.211111+00	27
04e6f91414716a1977dd9c261177b5abc0cd597b	2021-07-07 05:59:04.03983+00	29
a3d7d76877e9e374b588139fc388ed9d8de9eb8d	2021-06-11 08:45:10.834613+00	30
88d147318d44fb091dec73359d13b63b340fb480	2021-06-11 11:14:06.718611+00	32
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	authtoken	token
7	authtoken	tokenproxy
8	accounts	user
9	announcement	announcement
10	submission	submission
11	problem	problemtag
12	problem	problem
13	django_q	schedule
14	django_q	task
15	django_q	failure
16	django_q	success
17	django_q	ormq
18	judgeserver	judgeserver
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-05-08 22:20:57.047652+00
2	contenttypes	0002_remove_content_type_name	2021-05-08 22:20:57.061541+00
3	auth	0001_initial	2021-05-08 22:20:57.153129+00
4	auth	0002_alter_permission_name_max_length	2021-05-08 22:20:57.161734+00
5	auth	0003_alter_user_email_max_length	2021-05-08 22:20:57.170406+00
6	auth	0004_alter_user_username_opts	2021-05-08 22:20:57.17965+00
7	auth	0005_alter_user_last_login_null	2021-05-08 22:20:57.188221+00
8	auth	0006_require_contenttypes_0002	2021-05-08 22:20:57.19298+00
9	auth	0007_alter_validators_add_error_messages	2021-05-08 22:20:57.202855+00
10	auth	0008_alter_user_username_max_length	2021-05-08 22:20:57.213125+00
11	auth	0009_alter_user_last_name_max_length	2021-05-08 22:20:57.223537+00
12	auth	0010_alter_group_name_max_length	2021-05-08 22:20:57.234976+00
13	auth	0011_update_proxy_permissions	2021-05-08 22:20:57.246726+00
14	auth	0012_alter_user_first_name_max_length	2021-05-08 22:20:57.255974+00
15	accounts	0001_initial	2021-05-08 22:20:57.354553+00
16	admin	0001_initial	2021-05-08 22:20:57.400218+00
17	admin	0002_logentry_remove_auto_add	2021-05-08 22:20:57.412046+00
18	admin	0003_logentry_add_action_flag_choices	2021-05-08 22:20:57.423952+00
19	announcement	0001_initial	2021-05-08 22:20:57.462442+00
20	authtoken	0001_initial	2021-05-08 22:20:57.496466+00
21	authtoken	0002_auto_20160226_1747	2021-05-08 22:20:57.531272+00
22	authtoken	0003_tokenproxy	2021-05-08 22:20:57.537422+00
23	problem	0001_initial	2021-05-08 22:20:57.633854+00
24	sessions	0001_initial	2021-05-08 22:20:57.668966+00
25	submission	0001_initial	2021-05-08 22:20:57.716424+00
26	django_q	0001_initial	2021-05-10 10:47:23.621868+00
27	django_q	0002_auto_20150630_1624	2021-05-10 10:47:23.633133+00
28	django_q	0003_auto_20150708_1326	2021-05-10 10:47:23.66735+00
29	django_q	0004_auto_20150710_1043	2021-05-10 10:47:23.677297+00
30	django_q	0005_auto_20150718_1506	2021-05-10 10:47:23.687789+00
31	django_q	0006_auto_20150805_1817	2021-05-10 10:47:23.697786+00
32	django_q	0007_ormq	2021-05-10 10:47:23.71996+00
33	django_q	0008_auto_20160224_1026	2021-05-10 10:47:23.728285+00
34	django_q	0009_auto_20171009_0915	2021-05-10 10:47:23.752582+00
35	django_q	0010_auto_20200610_0856	2021-05-10 10:47:23.767395+00
36	django_q	0011_auto_20200628_1055	2021-05-10 10:47:23.778417+00
37	django_q	0012_auto_20200702_1608	2021-05-10 10:47:23.78501+00
38	django_q	0013_task_attempt_count	2021-05-10 10:47:23.824361+00
39	accounts	0002_user_profile_pic	2021-05-19 16:55:12.745097+00
40	accounts	0003_auto_20210516_1755	2021-05-19 16:55:12.778899+00
41	judgeserver	0001_initial	2021-05-19 16:55:12.803579+00
42	judgeserver	0002_auto_20210519_1009	2021-05-19 16:55:12.810255+00
43	judgeserver	0003_auto_20210519_2054	2021-05-19 16:55:12.831216+00
44	submission	0002_auto_20210519_2054	2021-05-19 16:55:12.85044+00
45	accounts	0004_user_solved_problem	2021-05-21 13:48:31.540516+00
46	accounts	0005_auto_20210521_1038	2021-05-21 13:48:31.559615+00
47	accounts	0006_auto_20210521_1940	2021-05-21 13:48:31.578614+00
48	accounts	0007_alter_user_profile_pic	2021-05-21 13:48:31.595107+00
49	announcement	0002_auto_20210521_1940	2021-05-21 13:48:31.622633+00
50	submission	0003_auto_20210520_2211	2021-05-21 13:48:31.640103+00
51	accounts	0008_auto_20210605_1530	2021-06-10 07:34:52.94629+00
52	accounts	0008_alter_user_profile_pic	2021-06-10 07:34:52.96475+00
53	accounts	0009_merge_20210610_1219	2021-06-10 07:34:52.969178+00
54	accounts	0010_auto_20210610_1219	2021-06-10 07:34:52.986227+00
55	accounts	0011_auto_20210610_1232	2021-06-10 07:34:53.001601+00
56	accounts	0012_auto_20210610_1234	2021-06-10 07:34:53.018812+00
57	accounts	0013_auto_20210610_1237	2021-06-10 07:34:53.036325+00
58	accounts	0014_alter_user_profile_pic	2021-06-10 07:34:53.052709+00
59	accounts	0015_auto_20210610_2342	2021-06-13 08:58:19.456396+00
60	accounts	0016_auto_20210610_2343	2021-06-13 08:58:19.470099+00
61	accounts	0017_auto_20210610_2344	2021-06-13 08:58:19.485444+00
62	accounts	0018_alter_user_profile_pic	2021-06-13 08:58:19.498666+00
63	submission	0004_auto_20210613_0858	2021-06-13 08:58:19.715051+00
64	accounts	0019_alter_user_profile_pic	2021-06-13 09:00:27.183157+00
65	submission	0005_auto_20210613_0900	2021-06-13 09:00:27.221652+00
66	accounts	0020_alter_user_profile_pic	2021-06-13 09:27:34.182494+00
67	accounts	0021_alter_user_profile_pic	2021-06-13 09:27:40.951075+00
68	accounts	0022_alter_user_profile_pic	2021-06-13 09:34:12.002143+00
69	problem	0002_rename_tagname_problemtag_tag_name	2021-06-13 09:34:12.022184+00
70	accounts	0023_alter_user_profile_pic	2021-06-15 13:23:52.231266+00
71	accounts	0024_auto_20210615_0153	2021-06-15 13:23:52.246419+00
72	accounts	0025_auto_20210615_0153	2021-06-15 13:23:52.261828+00
73	announcement	0003_announcement_is_visible	2021-06-15 13:23:52.45572+00
74	accounts	0026_auto_20210615_1834	2021-06-30 12:27:46.285444+00
75	accounts	0027_auto_20210615_1835	2021-06-30 12:27:46.299657+00
76	problem	0003_auto_20210615_1835	2021-06-30 12:27:46.313637+00
77	accounts	0026_alter_user_profile_pic	2021-07-03 07:45:33.317784+00
78	accounts	0028_merge_20210630_1513	2021-07-03 07:45:33.33448+00
\.


--
-- Data for Name: django_q_ormq; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_q_ormq (id, key, payload, lock) FROM stdin;
\.


--
-- Data for Name: django_q_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_q_schedule (id, func, hook, args, kwargs, schedule_type, repeats, next_run, task, name, minutes, cron) FROM stdin;
\.


--
-- Data for Name: django_q_task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_q_task (name, func, hook, args, kwargs, result, started, stopped, success, id, "group", attempt_count) FROM stdin;
alpha-california-moon-harry	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f216e5e55b0>>	\N	gAUpLg==	gAV9lC4=	gAWVjhYAAAAAAABYhxYAAEVycm9yIHdoaWxlIGZldGNoaW5nIHNlcnZlciBBUEkgdmVyc2lvbjogKCdDb25uZWN0aW9uIGFib3J0ZWQuJywgUGVybWlzc2lvbkVycm9yKDEzLCAnUGVybWlzc2lvbiBkZW5pZWQnKSkgOiBUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiL3Vzci9saWIvcHl0aG9uMy9kaXN0LXBhY2thZ2VzL3VybGxpYjMvY29ubmVjdGlvbnBvb2wucHkiLCBsaW5lIDU5OCwgaW4gdXJsb3BlbgogICAgaHR0cGxpYl9yZXNwb25zZSA9IHNlbGYuX21ha2VfcmVxdWVzdChjb25uLCBtZXRob2QsIHVybCwKICBGaWxlICIvdXNyL2xpYi9weXRob24zL2Rpc3QtcGFja2FnZXMvdXJsbGliMy9jb25uZWN0aW9ucG9vbC5weSIsIGxpbmUgMzU3LCBpbiBfbWFrZV9yZXF1ZXN0CiAgICBjb25uLnJlcXVlc3QobWV0aG9kLCB1cmwsICoqaHR0cGxpYl9yZXF1ZXN0X2t3KQogIEZpbGUgIi91c3IvbGliL3B5dGhvbjMuOC9odHRwL2NsaWVudC5weSIsIGxpbmUgMTI1MiwgaW4gcmVxdWVzdAogICAgc2VsZi5fc2VuZF9yZXF1ZXN0KG1ldGhvZCwgdXJsLCBib2R5LCBoZWFkZXJzLCBlbmNvZGVfY2h1bmtlZCkKICBGaWxlICIvdXNyL2xpYi9weXRob24zLjgvaHR0cC9jbGllbnQucHkiLCBsaW5lIDEyOTgsIGluIF9zZW5kX3JlcXVlc3QKICAgIHNlbGYuZW5kaGVhZGVycyhib2R5LCBlbmNvZGVfY2h1bmtlZD1lbmNvZGVfY2h1bmtlZCkKICBGaWxlICIvdXNyL2xpYi9weXRob24zLjgvaHR0cC9jbGllbnQucHkiLCBsaW5lIDEyNDcsIGluIGVuZGhlYWRlcnMKICAgIHNlbGYuX3NlbmRfb3V0cHV0KG1lc3NhZ2VfYm9keSwgZW5jb2RlX2NodW5rZWQ9ZW5jb2RlX2NodW5rZWQpCiAgRmlsZSAiL3Vzci9saWIvcHl0aG9uMy44L2h0dHAvY2xpZW50LnB5IiwgbGluZSAxMDA3LCBpbiBfc2VuZF9vdXRwdXQKICAgIHNlbGYuc2VuZChtc2cpCiAgRmlsZSAiL3Vzci9saWIvcHl0aG9uMy44L2h0dHAvY2xpZW50LnB5IiwgbGluZSA5NDcsIGluIHNlbmQKICAgIHNlbGYuY29ubmVjdCgpCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvLmxvY2FsL2xpYi9weXRob24zLjgvc2l0ZS1wYWNrYWdlcy9kb2NrZXIvdHJhbnNwb3J0L3VuaXhjb25uLnB5IiwgbGluZSA0MywgaW4gY29ubmVjdAogICAgc29jay5jb25uZWN0KHNlbGYudW5peF9zb2NrZXQpClBlcm1pc3Npb25FcnJvcjogW0Vycm5vIDEzXSBQZXJtaXNzaW9uIGRlbmllZAoKRHVyaW5nIGhhbmRsaW5nIG9mIHRoZSBhYm92ZSBleGNlcHRpb24sIGFub3RoZXIgZXhjZXB0aW9uIG9jY3VycmVkOgoKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi91c3IvbGliL3B5dGhvbjMvZGlzdC1wYWNrYWdlcy9yZXF1ZXN0cy9hZGFwdGVycy5weSIsIGxpbmUgNDMwLCBpbiBzZW5kCiAgICByZXNwID0gY29ubi51cmxvcGVuKAogIEZpbGUgIi91c3IvbGliL3B5dGhvbjMvZGlzdC1wYWNrYWdlcy91cmxsaWIzL2Nvbm5lY3Rpb25wb29sLnB5IiwgbGluZSA2MzgsIGluIHVybG9wZW4KICAgIHJldHJpZXMgPSByZXRyaWVzLmluY3JlbWVudChtZXRob2QsIHVybCwgZXJyb3I9ZSwgX3Bvb2w9c2VsZiwKICBGaWxlICIvdXNyL2xpYi9weXRob24zL2Rpc3QtcGFja2FnZXMvdXJsbGliMy91dGlsL3JldHJ5LnB5IiwgbGluZSAzNjcsIGluIGluY3JlbWVudAogICAgcmFpc2Ugc2l4LnJlcmFpc2UodHlwZShlcnJvciksIGVycm9yLCBfc3RhY2t0cmFjZSkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL3NpeC5weSIsIGxpbmUgNzE4LCBpbiByZXJhaXNlCiAgICByYWlzZSB2YWx1ZS53aXRoX3RyYWNlYmFjayh0YikKICBGaWxlICIvdXNyL2xpYi9weXRob24zL2Rpc3QtcGFja2FnZXMvdXJsbGliMy9jb25uZWN0aW9ucG9vbC5weSIsIGxpbmUgNTk4LCBpbiB1cmxvcGVuCiAgICBodHRwbGliX3Jlc3BvbnNlID0gc2VsZi5fbWFrZV9yZXF1ZXN0KGNvbm4sIG1ldGhvZCwgdXJsLAogIEZpbGUgIi91c3IvbGliL3B5dGhvbjMvZGlzdC1wYWNrYWdlcy91cmxsaWIzL2Nvbm5lY3Rpb25wb29sLnB5IiwgbGluZSAzNTcsIGluIF9tYWtlX3JlcXVlc3QKICAgIGNvbm4ucmVxdWVzdChtZXRob2QsIHVybCwgKipodHRwbGliX3JlcXVlc3Rfa3cpCiAgRmlsZSAiL3Vzci9saWIvcHl0aG9uMy44L2h0dHAvY2xpZW50LnB5IiwgbGluZSAxMjUyLCBpbiByZXF1ZXN0CiAgICBzZWxmLl9zZW5kX3JlcXVlc3QobWV0aG9kLCB1cmwsIGJvZHksIGhlYWRlcnMsIGVuY29kZV9jaHVua2VkKQogIEZpbGUgIi91c3IvbGliL3B5dGhvbjMuOC9odHRwL2NsaWVudC5weSIsIGxpbmUgMTI5OCwgaW4gX3NlbmRfcmVxdWVzdAogICAgc2VsZi5lbmRoZWFkZXJzKGJvZHksIGVuY29kZV9jaHVua2VkPWVuY29kZV9jaHVua2VkKQogIEZpbGUgIi91c3IvbGliL3B5dGhvbjMuOC9odHRwL2NsaWVudC5weSIsIGxpbmUgMTI0NywgaW4gZW5kaGVhZGVycwogICAgc2VsZi5fc2VuZF9vdXRwdXQobWVzc2FnZV9ib2R5LCBlbmNvZGVfY2h1bmtlZD1lbmNvZGVfY2h1bmtlZCkKICBGaWxlICIvdXNyL2xpYi9weXRob24zLjgvaHR0cC9jbGllbnQucHkiLCBsaW5lIDEwMDcsIGluIF9zZW5kX291dHB1dAogICAgc2VsZi5zZW5kKG1zZykKICBGaWxlICIvdXNyL2xpYi9weXRob24zLjgvaHR0cC9jbGllbnQucHkiLCBsaW5lIDk0NywgaW4gc2VuZAogICAgc2VsZi5jb25uZWN0KCkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RvY2tlci90cmFuc3BvcnQvdW5peGNvbm4ucHkiLCBsaW5lIDQzLCBpbiBjb25uZWN0CiAgICBzb2NrLmNvbm5lY3Qoc2VsZi51bml4X3NvY2tldCkKdXJsbGliMy5leGNlcHRpb25zLlByb3RvY29sRXJyb3I6ICgnQ29ubmVjdGlvbiBhYm9ydGVkLicsIFBlcm1pc3Npb25FcnJvcigxMywgJ1Blcm1pc3Npb24gZGVuaWVkJykpCgpEdXJpbmcgaGFuZGxpbmcgb2YgdGhlIGFib3ZlIGV4Y2VwdGlvbiwgYW5vdGhlciBleGNlcHRpb24gb2NjdXJyZWQ6CgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvLmxvY2FsL2xpYi9weXRob24zLjgvc2l0ZS1wYWNrYWdlcy9kb2NrZXIvYXBpL2NsaWVudC5weSIsIGxpbmUgMjE0LCBpbiBfcmV0cmlldmVfc2VydmVyX3ZlcnNpb24KICAgIHJldHVybiBzZWxmLnZlcnNpb24oYXBpX3ZlcnNpb249RmFsc2UpWyJBcGlWZXJzaW9uIl0KICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RvY2tlci9hcGkvZGFlbW9uLnB5IiwgbGluZSAxODEsIGluIHZlcnNpb24KICAgIHJldHVybiBzZWxmLl9yZXN1bHQoc2VsZi5fZ2V0KHVybCksIGpzb249VHJ1ZSkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RvY2tlci91dGlscy9kZWNvcmF0b3JzLnB5IiwgbGluZSA0NiwgaW4gaW5uZXIKICAgIHJldHVybiBmKHNlbGYsICphcmdzLCAqKmt3YXJncykKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RvY2tlci9hcGkvY2xpZW50LnB5IiwgbGluZSAyMzcsIGluIF9nZXQKICAgIHJldHVybiBzZWxmLmdldCh1cmwsICoqc2VsZi5fc2V0X3JlcXVlc3RfdGltZW91dChrd2FyZ3MpKQogIEZpbGUgIi91c3IvbGliL3B5dGhvbjMvZGlzdC1wYWNrYWdlcy9yZXF1ZXN0cy9zZXNzaW9ucy5weSIsIGxpbmUgNTMzLCBpbiBnZXQKICAgIHJldHVybiBzZWxmLnJlcXVlc3QoJ0dFVCcsIHVybCwgKiprd2FyZ3MpCiAgRmlsZSAiL3Vzci9saWIvcHl0aG9uMy9kaXN0LXBhY2thZ2VzL3JlcXVlc3RzL3Nlc3Npb25zLnB5IiwgbGluZSA1MjAsIGluIHJlcXVlc3QKICAgIHJlc3AgPSBzZWxmLnNlbmQocHJlcCwgKipzZW5kX2t3YXJncykKICBGaWxlICIvdXNyL2xpYi9weXRob24zL2Rpc3QtcGFja2FnZXMvcmVxdWVzdHMvc2Vzc2lvbnMucHkiLCBsaW5lIDYzMCwgaW4gc2VuZAogICAgciA9IGFkYXB0ZXIuc2VuZChyZXF1ZXN0LCAqKmt3YXJncykKICBGaWxlICIvdXNyL2xpYi9weXRob24zL2Rpc3QtcGFja2FnZXMvcmVxdWVzdHMvYWRhcHRlcnMucHkiLCBsaW5lIDQ5MCwgaW4gc2VuZAogICAgcmFpc2UgQ29ubmVjdGlvbkVycm9yKGVyciwgcmVxdWVzdD1yZXF1ZXN0KQpyZXF1ZXN0cy5leGNlcHRpb25zLkNvbm5lY3Rpb25FcnJvcjogKCdDb25uZWN0aW9uIGFib3J0ZWQuJywgUGVybWlzc2lvbkVycm9yKDEzLCAnUGVybWlzc2lvbiBkZW5pZWQnKSkKCkR1cmluZyBoYW5kbGluZyBvZiB0aGUgYWJvdmUgZXhjZXB0aW9uLCBhbm90aGVyIGV4Y2VwdGlvbiBvY2N1cnJlZDoKClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RqYW5nb19xL2NsdXN0ZXIucHkiLCBsaW5lIDQzNiwgaW4gd29ya2VyCiAgICByZXMgPSBmKCp0YXNrWyJhcmdzIl0sICoqdGFza1sia3dhcmdzIl0pCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vdmlld3MvcHVibGljLnB5IiwgbGluZSAzNywgaW4ganVkZ2VfYW5kX3VwZGF0ZQogICAganVkZ2VfcmVzdWx0ID0gc2VuZF9zdWJtaXNzaW9uX211bHRpX3Rlc3Qoc3JjLCBsYW5nLCBpbnB1dHMsIGFuc3dlcnMpCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vdmlld3MvY29kZXJ1bm5lci5weSIsIGxpbmUgMzAsIGluIHNlbmRfc3VibWlzc2lvbl9tdWx0aV90ZXN0CiAgICBqcmVwb3J0ID0ganVkZ2UoCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vdmlld3MvZG9ja2VyanVkZ2UvbWFpbi5weSIsIGxpbmUgODEsIGluIGp1ZGdlCiAgICBjbGllbnQgPSBjbGllbnQgb3IgZG9ja2VyLmZyb21fZW52KHZlcnNpb249ImF1dG8iKQogIEZpbGUgIi9ob21lL252YXR1YW4yMDAwLy5sb2NhbC9saWIvcHl0aG9uMy44L3NpdGUtcGFja2FnZXMvZG9ja2VyL2NsaWVudC5weSIsIGxpbmUgOTYsIGluIGZyb21fZW52CiAgICByZXR1cm4gY2xzKAogIEZpbGUgIi9ob21lL252YXR1YW4yMDAwLy5sb2NhbC9saWIvcHl0aG9uMy44L3NpdGUtcGFja2FnZXMvZG9ja2VyL2NsaWVudC5weSIsIGxpbmUgNDUsIGluIF9faW5pdF9fCiAgICBzZWxmLmFwaSA9IEFQSUNsaWVudCgqYXJncywgKiprd2FyZ3MpCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvLmxvY2FsL2xpYi9weXRob24zLjgvc2l0ZS1wYWNrYWdlcy9kb2NrZXIvYXBpL2NsaWVudC5weSIsIGxpbmUgMTk3LCBpbiBfX2luaXRfXwogICAgc2VsZi5fdmVyc2lvbiA9IHNlbGYuX3JldHJpZXZlX3NlcnZlcl92ZXJzaW9uKCkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RvY2tlci9hcGkvY2xpZW50LnB5IiwgbGluZSAyMjEsIGluIF9yZXRyaWV2ZV9zZXJ2ZXJfdmVyc2lvbgogICAgcmFpc2UgRG9ja2VyRXhjZXB0aW9uKApkb2NrZXIuZXJyb3JzLkRvY2tlckV4Y2VwdGlvbjogRXJyb3Igd2hpbGUgZmV0Y2hpbmcgc2VydmVyIEFQSSB2ZXJzaW9uOiAoJ0Nvbm5lY3Rpb24gYWJvcnRlZC4nLCBQZXJtaXNzaW9uRXJyb3IoMTMsICdQZXJtaXNzaW9uIGRlbmllZCcpKQqULg==	2021-05-10 11:28:39.734252+00	2021-05-10 11:28:39.816773+00	f	b9ec2574909943548199ba31dc3d01ba	\N	1
minnesota-seven-idaho-jersey	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb917220>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-10 11:30:39.465814+00	2021-05-10 11:30:41.589235+00	t	9161205b407643b7a5764cfeba09bc66	\N	1
papa-stream-uniform-nine	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab340>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-10 11:31:28.932632+00	2021-05-10 11:31:31.251849+00	t	24403df290e14aeeb0bcb952fcca46eb	\N	1
stairway-echo-football-batman	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb917fa0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-10 11:31:47.201269+00	2021-05-10 11:31:49.218384+00	t	c13b331a2fba4ce0850b985defefbfad	\N	1
item-crazy-idaho-fish	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab3a0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-10 11:35:35.862061+00	2021-05-10 11:35:36.673188+00	t	4658295fe0c54941938e176b119329ed	\N	1
hamper-hot-finch-six	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb917220>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-10 11:36:05.199531+00	2021-05-10 11:36:09.705657+00	t	37f5ca50cbff4a20a9c9d9fcf15f9dfb	\N	1
alaska-finch-jupiter-mockingbird	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab220>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-10 11:37:28.002227+00	2021-05-10 11:37:28.018624+00	t	2857fe8274304445aba16b0f439e014c	\N	1
butter-mars-hotel-october	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb917fa0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-10 11:37:43.568733+00	2021-05-10 11:37:45.462619+00	t	6373575a709b432c99c9656a5d7b50d7	\N	1
california-happy-hotel-hydrogen	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab8e0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-15 10:03:45.402932+00	2021-05-15 10:03:46.394796+00	t	9a8702019e4842cdb513a45d61b80fb6	\N	1
november-early-edward-illinois	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb917220>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-15 10:24:32.198291+00	2021-05-15 10:24:33.14298+00	t	f4570a3607a04adbb2fbd8aba7853777	\N	1
ten-equal-utah-avocado	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab250>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-15 10:28:00.909109+00	2021-05-15 10:28:01.869655+00	t	516bfb1b89de485fbbd744c1152fe9dc	\N	1
island-mirror-sierra-california	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb917fa0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-15 10:42:49.656691+00	2021-05-15 10:42:50.68063+00	t	3dd91f9c31fe4300bcd8e544e89ab9d5	\N	1
seven-florida-music-hawaii	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab370>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-15 10:47:01.102636+00	2021-05-15 10:47:03.007+00	t	8b2bd0b2081447118120e0d72ba3db08	\N	1
earth-green-robert-rugby	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb917220>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-15 11:09:52.525221+00	2021-05-15 11:09:53.576264+00	t	38b0a71832be419bae22cafc78480f82	\N	1
coffee-minnesota-hawaii-may	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab0a0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-15 18:27:44.009158+00	2021-05-15 18:27:44.957096+00	t	701a86cbae9e4df690c18882ebef2ead	\N	1
maryland-summer-carpet-sodium	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab250>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-16 08:54:02.185621+00	2021-05-16 08:54:03.169886+00	t	aa166851adab4f9fb1ba85ac9204d982	\N	1
steak-don-bravo-tennis	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab3a0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-16 08:54:09.336002+00	2021-05-16 08:54:10.331006+00	t	2a3e4686ed4941d1ae47d320a4579eb1	\N	1
sink-cardinal-lake-bluebird	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab760>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-16 08:55:14.679107+00	2021-05-16 08:55:15.639879+00	t	4da1c4ef5c5b4364b681cd8f792f0649	\N	1
alabama-cola-delaware-july	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab280>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-16 08:55:20.337949+00	2021-05-16 08:55:21.275946+00	t	5e085502ef354fbd8bc7572a543bb6b4	\N	1
pluto-tennessee-beer-washington	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab250>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-16 08:55:47.511238+00	2021-05-16 08:55:48.48092+00	t	9315facd30134eb69ff0027ecc034c72	\N	1
montana-georgia-vermont-four	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab3a0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-16 08:55:54.953113+00	2021-05-16 08:55:56.01906+00	t	1a37e55a3ab7419fbbf68120f9bfdad0	\N	1
twelve-uncle-uniform-bluebird	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab040>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-16 08:57:44.744852+00	2021-05-16 08:57:45.688398+00	t	c7c2b0571f254a9586c83d9480b42f02	\N	1
angel-nine-california-single	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab0a0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-16 08:59:10.284275+00	2021-05-16 08:59:11.24154+00	t	b2cea6dfb99144f7bed6f187132819e4	\N	1
william-leopard-skylark-magnesium	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab250>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-16 10:48:03.738301+00	2021-05-16 10:48:05.385455+00	t	4b1ecc6c45464932872480e9a852b9c3	\N	1
colorado-delta-gee-butter	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab3a0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-18 11:33:02.372164+00	2021-05-18 11:33:04.192508+00	t	4f004e2b03e24093924bca419baf765f	\N	1
wisconsin-kentucky-football-enemy	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab040>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 05:54:15.070611+00	2021-05-19 05:54:15.998005+00	t	ac26c4b6789943d28cd5a5b74c6beff7	\N	1
gee-tennis-west-texas	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab0a0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 05:58:24.822503+00	2021-05-19 05:58:25.839762+00	t	8581db8d595a47989ff4da4351d9a0f5	\N	1
carpet-saturn-mike-yellow	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab250>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 06:09:47.592762+00	2021-05-19 06:09:48.576746+00	t	661df3aa66324bdfb10de0d6f70e0c08	\N	1
pluto-nineteen-queen-mobile	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab3a0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 06:10:09.624951+00	2021-05-19 06:10:10.74608+00	t	40ad8ad629314cc89bc8c124993fa881	\N	1
artist-two-indigo-carpet	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8ab040>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 06:11:10.629362+00	2021-05-19 06:11:11.604287+00	t	75360f4603ca406dbe2f07f275619aac	\N	1
london-eighteen-ceiling-uranus	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb877eb0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 06:12:00.993709+00	2021-05-19 06:12:01.013389+00	t	5c58d5ad8cb04e4e81a5e2e219d14161	\N	1
grey-september-beryllium-sierra	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb877a60>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 06:12:54.88801+00	2021-05-19 06:12:55.964325+00	t	727d752dfa41463c8ba7063fd28a039e	\N	1
cup-burger-fifteen-oven	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb877f40>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 14:08:39.888813+00	2021-05-19 14:08:40.88046+00	t	c74db3174b344e2d9f53df50d6a2f429	\N	1
beryllium-thirteen-fillet-quiet	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb8776d0>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 14:10:06.652539+00	2021-05-19 14:10:08.619264+00	t	b03a70efd5af4eeaad06f51a445b08a0	\N	1
xray-bakerloo-mockingbird-ten	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb877490>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 14:10:34.600729+00	2021-05-19 14:10:36.448984+00	t	32f8dbeac0134a88b400381c566026ca	\N	1
king-chicken-summer-uniform	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb877a60>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 14:11:54.958438+00	2021-05-19 14:11:56.673853+00	t	cd608f50a27d44bd9aa6db3148dc5c2f	\N	1
magnesium-florida-muppet-football	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb877310>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 14:25:57.142121+00	2021-05-19 14:25:59.058657+00	t	b3de0ee302964d9387bb00a943c9db1a	\N	1
friend-venus-coffee-sierra	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb877220>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 14:31:15.717794+00	2021-05-19 14:31:17.644383+00	t	1d190256e98845cfb50258c81b767fd7	\N	1
florida-victor-august-bacon	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb877490>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 14:41:07.447333+00	2021-05-19 14:41:08.38832+00	t	14ac85774767418cbbdb83ee9a717d86	\N	1
yellow-uncle-indigo-lithium	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb917f70>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 14:41:40.021087+00	2021-05-19 14:41:40.92536+00	t	c0aee1725a65439989d30739d345678a	\N	1
undress-sink-cardinal-saturn	<bound method JudgeSubmissionTask.judge_and_update of <submission.views.public.JudgeSubmissionTask object at 0x7f24cb877310>>	\N	gAUpLg==	gAV9lC4=	gAWILg==	2021-05-19 14:48:11.115947+00	2021-05-19 14:48:12.098055+00	t	d4155473721d44ecac12a43ab4d6e042	\N	1
early-purple-oklahoma-connecticut	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5d51b6eeb0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5d51b6eeb0>>	gAUpLg==	gAV9lC4=	gAWVRwQAAAAAAABYQAQAAGNvZGUgPSAxMDExICh1bmV4cGVjdGVkIGVycm9yKSwgbm8gcmVhc29uIDogVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi9ob21lL252YXR1YW4yMDAwLy5sb2NhbC9saWIvcHl0aG9uMy44L3NpdGUtcGFja2FnZXMvZGphbmdvX3EvY2x1c3Rlci5weSIsIGxpbmUgNDM2LCBpbiB3b3JrZXIKICAgIHJlcyA9IGYoKnRhc2tbImFyZ3MiXSwgKip0YXNrWyJrd2FyZ3MiXSkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC9kb2ovUEJMX0RPbmxpbmVKdWRnZS9kb25saW5lanVkZ2Uvc3VibWlzc2lvbi92aWV3cy9wdWJsaWMucHkiLCBsaW5lIDEwMywgaW4gbWFpbgogICAgYXN5bmNpby5nZXRfZXZlbnRfbG9vcCgpLnJ1bl91bnRpbF9jb21wbGV0ZShzZWxmLnNlbmRfYW5kX3JlY2VpdmUoKSkKICBGaWxlICIvdXNyL2xpYi9weXRob24zLjgvYXN5bmNpby9iYXNlX2V2ZW50cy5weSIsIGxpbmUgNjE2LCBpbiBydW5fdW50aWxfY29tcGxldGUKICAgIHJldHVybiBmdXR1cmUucmVzdWx0KCkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC9kb2ovUEJMX0RPbmxpbmVKdWRnZS9kb25saW5lanVkZ2Uvc3VibWlzc2lvbi92aWV3cy9wdWJsaWMucHkiLCBsaW5lIDQ2LCBpbiBzZW5kX2FuZF9yZWNlaXZlCiAgICBqdWRnZV9yZXN1bHRzLCBjb21waWxlX3Jlc3VsdCA9IChsb2Fkcyhhd2FpdCB3ZWJzb2NrZXQucmVjdigpKSkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL3dlYnNvY2tldHMvbGVnYWN5L3Byb3RvY29sLnB5IiwgbGluZSA0MjEsIGluIHJlY3YKICAgIGF3YWl0IHNlbGYuZW5zdXJlX29wZW4oKQogIEZpbGUgIi9ob21lL252YXR1YW4yMDAwLy5sb2NhbC9saWIvcHl0aG9uMy44L3NpdGUtcGFja2FnZXMvd2Vic29ja2V0cy9sZWdhY3kvcHJvdG9jb2wucHkiLCBsaW5lIDcyNiwgaW4gZW5zdXJlX29wZW4KICAgIHJhaXNlIHNlbGYuY29ubmVjdGlvbl9jbG9zZWRfZXhjKCkKd2Vic29ja2V0cy5leGNlcHRpb25zLkNvbm5lY3Rpb25DbG9zZWRFcnJvcjogY29kZSA9IDEwMTEgKHVuZXhwZWN0ZWQgZXJyb3IpLCBubyByZWFzb24KlC4=	2021-05-19 17:30:44.38128+00	2021-05-19 17:30:44.462838+00	f	3cfe3cc886e24696b5645022179d76d0	\N	1
pennsylvania-carbon-lemon-fruit	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f44afcb2eb0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f44afcb2eb0>>	gAUpLg==	gAV9lC4=	gAWVRwQAAAAAAABYQAQAAGNvZGUgPSAxMDExICh1bmV4cGVjdGVkIGVycm9yKSwgbm8gcmVhc29uIDogVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi9ob21lL252YXR1YW4yMDAwLy5sb2NhbC9saWIvcHl0aG9uMy44L3NpdGUtcGFja2FnZXMvZGphbmdvX3EvY2x1c3Rlci5weSIsIGxpbmUgNDM2LCBpbiB3b3JrZXIKICAgIHJlcyA9IGYoKnRhc2tbImFyZ3MiXSwgKip0YXNrWyJrd2FyZ3MiXSkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC9kb2ovUEJMX0RPbmxpbmVKdWRnZS9kb25saW5lanVkZ2Uvc3VibWlzc2lvbi92aWV3cy9wdWJsaWMucHkiLCBsaW5lIDEwMywgaW4gbWFpbgogICAgYXN5bmNpby5nZXRfZXZlbnRfbG9vcCgpLnJ1bl91bnRpbF9jb21wbGV0ZShzZWxmLnNlbmRfYW5kX3JlY2VpdmUoKSkKICBGaWxlICIvdXNyL2xpYi9weXRob24zLjgvYXN5bmNpby9iYXNlX2V2ZW50cy5weSIsIGxpbmUgNjE2LCBpbiBydW5fdW50aWxfY29tcGxldGUKICAgIHJldHVybiBmdXR1cmUucmVzdWx0KCkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC9kb2ovUEJMX0RPbmxpbmVKdWRnZS9kb25saW5lanVkZ2Uvc3VibWlzc2lvbi92aWV3cy9wdWJsaWMucHkiLCBsaW5lIDQ2LCBpbiBzZW5kX2FuZF9yZWNlaXZlCiAgICBqdWRnZV9yZXN1bHRzLCBjb21waWxlX3Jlc3VsdCA9IChsb2Fkcyhhd2FpdCB3ZWJzb2NrZXQucmVjdigpKSkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL3dlYnNvY2tldHMvbGVnYWN5L3Byb3RvY29sLnB5IiwgbGluZSA0MjEsIGluIHJlY3YKICAgIGF3YWl0IHNlbGYuZW5zdXJlX29wZW4oKQogIEZpbGUgIi9ob21lL252YXR1YW4yMDAwLy5sb2NhbC9saWIvcHl0aG9uMy44L3NpdGUtcGFja2FnZXMvd2Vic29ja2V0cy9sZWdhY3kvcHJvdG9jb2wucHkiLCBsaW5lIDcyNiwgaW4gZW5zdXJlX29wZW4KICAgIHJhaXNlIHNlbGYuY29ubmVjdGlvbl9jbG9zZWRfZXhjKCkKd2Vic29ja2V0cy5leGNlcHRpb25zLkNvbm5lY3Rpb25DbG9zZWRFcnJvcjogY29kZSA9IDEwMTEgKHVuZXhwZWN0ZWQgZXJyb3IpLCBubyByZWFzb24KlC4=	2021-05-19 17:31:28.651558+00	2021-05-19 17:31:28.728703+00	f	466cdc58bae84805b38187c20876ebc4	\N	1
violet-kansas-colorado-undress	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f44afcb9d60>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f44afcb9d60>>	gAUpLg==	gAV9lC4=	\N	2021-05-19 17:38:03.8701+00	2021-05-19 17:38:59.798014+00	t	97c368d375ad4ef993b9c7c7f6b540e5	\N	1
seven-september-hydrogen-lake	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f44afcb2eb0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f44afcb2eb0>>	gAUpLg==	gAV9lC4=	\N	2021-05-19 17:43:36.129922+00	2021-05-19 17:43:37.513984+00	t	4b80efe677bc4842b648f866e83d03a3	\N	1
lamp-aspen-alabama-bravo	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f44afc60eb0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f44afc60eb0>>	gAUpLg==	gAV9lC4=	\N	2021-05-19 17:44:25.893938+00	2021-05-19 17:44:27.46092+00	t	4f66376846d241d99c1e5ad940055d02	\N	1
jig-yellow-snake-purple	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f44afcb2eb0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f44afcb2eb0>>	gAUpLg==	gAV9lC4=	\N	2021-05-19 17:44:42.347036+00	2021-05-19 17:44:44.964483+00	t	82fc9f8b3a054c8eb25dcbef6c3cb85c	\N	1
comet-sierra-floor-east	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f44afc60fd0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f44afc60fd0>>	gAUpLg==	gAV9lC4=	\N	2021-05-20 18:07:54.181101+00	2021-05-20 18:07:55.134608+00	t	22387647703e40cb8c1a904f7c38fb87	\N	1
robert-xray-west-seven	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f56c109eb80>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f56c109eb80>>	gAUpLg==	gAV9lC4=	\N	2021-05-21 13:54:44.758519+00	2021-05-21 13:54:46.536605+00	t	0e558564646a48bdac1f77368385ea2e	\N	1
shade-mississippi-leopard-grey	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f56c8142070>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f56c8142070>>	gAUpLg==	gAV9lC4=	\N	2021-05-21 13:55:29.453587+00	2021-05-21 13:55:31.452722+00	t	37835020ca424e4b9ca9ffb2a1a66c3c	\N	1
pennsylvania-mango-michigan-kansas	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd0fcd0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd0fcd0>>	gAUpLg==	gAV9lC4=	\N	2021-06-02 04:04:39.297059+00	2021-06-02 04:04:41.825147+00	t	59482e9168c34069bd9b12bd6d6b1f76	\N	1
utah-pip-wisconsin-network	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd2c340>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd2c340>>	gAUpLg==	gAV9lC4=	gAWVRwQAAAAAAABYQAQAAGNvZGUgPSAxMDExICh1bmV4cGVjdGVkIGVycm9yKSwgbm8gcmVhc29uIDogVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi9ob21lL252YXR1YW4yMDAwLy5sb2NhbC9saWIvcHl0aG9uMy44L3NpdGUtcGFja2FnZXMvZGphbmdvX3EvY2x1c3Rlci5weSIsIGxpbmUgNDM2LCBpbiB3b3JrZXIKICAgIHJlcyA9IGYoKnRhc2tbImFyZ3MiXSwgKip0YXNrWyJrd2FyZ3MiXSkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC9kb2ovUEJMX0RPbmxpbmVKdWRnZS9kb25saW5lanVkZ2Uvc3VibWlzc2lvbi92aWV3cy9wdWJsaWMucHkiLCBsaW5lIDEwNCwgaW4gbWFpbgogICAgYXN5bmNpby5nZXRfZXZlbnRfbG9vcCgpLnJ1bl91bnRpbF9jb21wbGV0ZShzZWxmLnNlbmRfYW5kX3JlY2VpdmUoKSkKICBGaWxlICIvdXNyL2xpYi9weXRob24zLjgvYXN5bmNpby9iYXNlX2V2ZW50cy5weSIsIGxpbmUgNjE2LCBpbiBydW5fdW50aWxfY29tcGxldGUKICAgIHJldHVybiBmdXR1cmUucmVzdWx0KCkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC9kb2ovUEJMX0RPbmxpbmVKdWRnZS9kb25saW5lanVkZ2Uvc3VibWlzc2lvbi92aWV3cy9wdWJsaWMucHkiLCBsaW5lIDQ3LCBpbiBzZW5kX2FuZF9yZWNlaXZlCiAgICBqdWRnZV9yZXN1bHRzLCBjb21waWxlX3Jlc3VsdCA9IChsb2Fkcyhhd2FpdCB3ZWJzb2NrZXQucmVjdigpKSkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL3dlYnNvY2tldHMvbGVnYWN5L3Byb3RvY29sLnB5IiwgbGluZSA0MjEsIGluIHJlY3YKICAgIGF3YWl0IHNlbGYuZW5zdXJlX29wZW4oKQogIEZpbGUgIi9ob21lL252YXR1YW4yMDAwLy5sb2NhbC9saWIvcHl0aG9uMy44L3NpdGUtcGFja2FnZXMvd2Vic29ja2V0cy9sZWdhY3kvcHJvdG9jb2wucHkiLCBsaW5lIDcyNiwgaW4gZW5zdXJlX29wZW4KICAgIHJhaXNlIHNlbGYuY29ubmVjdGlvbl9jbG9zZWRfZXhjKCkKd2Vic29ja2V0cy5leGNlcHRpb25zLkNvbm5lY3Rpb25DbG9zZWRFcnJvcjogY29kZSA9IDEwMTEgKHVuZXhwZWN0ZWQgZXJyb3IpLCBubyByZWFzb24KlC4=	2021-06-02 04:05:04.421616+00	2021-06-02 04:05:04.526079+00	f	90ae9f48514648f09ef18e199c017a7e	\N	1
may-violet-seven-beryllium	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd2c160>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd2c160>>	gAUpLg==	gAV9lC4=	\N	2021-06-02 04:07:22.183734+00	2021-06-02 04:07:28.817835+00	t	2f5822d2499d417aa8fc73e59c46b778	\N	1
pennsylvania-lithium-mars-chicken	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd0fcd0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd0fcd0>>	gAUpLg==	gAV9lC4=	\N	2021-06-04 09:05:08.119418+00	2021-06-04 09:05:09.800973+00	t	ce1dfe83b2a4422fa19047f234fcc927	\N	1
asparagus-cup-indigo-eleven	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd0fc70>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd0fc70>>	gAUpLg==	gAV9lC4=	\N	2021-06-08 15:29:39.336613+00	2021-06-08 15:29:41.084326+00	t	d268ca7bc46340c992b792d333b5c17a	\N	1
tennessee-crazy-hot-triple	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd0fcd0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd0fcd0>>	gAUpLg==	gAV9lC4=	\N	2021-06-10 03:56:50.730506+00	2021-06-10 03:56:51.680573+00	t	347cc75493c84a3caa516ecb09a06028	\N	1
autumn-dakota-tango-west	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd41fd0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f66bdd41fd0>>	gAUpLg==	gAV9lC4=	\N	2021-06-10 03:58:33.527124+00	2021-06-10 03:58:35.54261+00	t	f2d0e7cb3e384e679f79437c127b71ea	\N	1
stairway-lamp-mountain-pennsylvania	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba550>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba550>>	gAUpLg==	gAV9lC4=	\N	2021-06-10 07:40:58.794476+00	2021-06-10 07:41:00.580901+00	t	e1bcae2019544c779aca498dc347674d	\N	1
sierra-solar-batman-venus	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca6d0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca6d0>>	gAUpLg==	gAV9lC4=	\N	2021-06-10 07:42:56.183829+00	2021-06-10 07:42:59.470106+00	t	7946ca3040b64c74b3dc9ce19324ca96	\N	1
utah-colorado-high-alabama	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba6d0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba6d0>>	gAUpLg==	gAV9lC4=	\N	2021-06-10 08:50:20.929598+00	2021-06-10 08:50:21.594387+00	t	bb61e0d326444c04b10db65754efb208	\N	1
ceiling-ack-spaghetti-undress	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba670>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba670>>	gAUpLg==	gAV9lC4=	\N	2021-06-10 08:56:21.68594+00	2021-06-10 08:56:23.263303+00	t	d746ac1955bc40a9b22828623fbac6a5	\N	1
monkey-yellow-mountain-virginia	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bbadc0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bbadc0>>	gAUpLg==	gAV9lC4=	\N	2021-06-10 08:57:03.591328+00	2021-06-10 08:57:05.282642+00	t	3d06268c224b4bdf99eaff182c84ca92	\N	1
red-july-virginia-mississippi	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba670>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba670>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 03:52:12.213111+00	2021-06-11 03:52:14.86168+00	t	d787c72f0da6498f965f2e17f4f1058d	\N	1
fish-montana-bakerloo-white	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba6d0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba6d0>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 06:07:32.705154+00	2021-06-11 06:07:34.994433+00	t	69bcb526e99044afb0992f176a6a17e3	\N	1
kilo-texas-lemon-north	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca700>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca700>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 06:07:40.677317+00	2021-06-11 06:07:42.076152+00	t	86a31f4b88cf4ad0b90b13d63b28a825	\N	1
eighteen-ack-beer-virginia	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bbadc0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bbadc0>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 06:29:22.083489+00	2021-06-11 06:29:23.486332+00	t	0e6e227e7afe42c68f01f36eb0bd7c81	\N	1
wisconsin-eight-carbon-vegan	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca760>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca760>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 08:35:31.136495+00	2021-06-11 08:35:32.684247+00	t	35dc35244d1040268f3f43ec5015943b	\N	1
eleven-don-iowa-floor	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba280>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba280>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 08:36:36.270843+00	2021-06-11 08:36:37.829538+00	t	bcacb4998aa6475f8f6c27a2c202d25b	\N	1
winner-beer-mobile-freddie	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca760>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca760>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 08:46:02.793433+00	2021-06-11 08:46:03.905329+00	t	a3fb3c92e87c49cea8edf73d8257ae34	\N	1
blossom-delaware-carolina-uniform	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bbadc0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bbadc0>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 08:46:28.46707+00	2021-06-11 08:46:30.221529+00	t	4ecfdc4aea3144aebd0646dc7a0bbd2b	\N	1
cup-mockingbird-three-triple	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca610>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca610>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 11:16:01.498412+00	2021-06-11 11:16:03.150994+00	t	c0daa793fcb64d97bafaf8678df9d144	\N	1
nineteen-speaker-wyoming-early	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba6d0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bba6d0>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 11:23:32.172417+00	2021-06-11 11:23:32.931299+00	t	1c01a627e3224a5aa4b6d63ef5b4cfb8	\N	1
blue-equal-nebraska-burger	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca760>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca760>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 12:56:29.650061+00	2021-06-11 12:56:30.858231+00	t	518ea96ef77d4389851cc7c983ec5d2e	\N	1
lion-echo-mike-stairway	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bbadc0>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bbadc0>>	gAUpLg==	gAV9lC4=	\N	2021-06-11 12:56:32.603149+00	2021-06-11 12:56:33.874532+00	t	6156fdb0919349728a7fdea1398e395d	\N	1
oscar-alabama-carolina-mexico	<bound method JudgeSubmissionTask.main of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca610>>	<bound method JudgeSubmissionTask.hook of <submission.views.public.JudgeSubmissionTask object at 0x7f5379bca610>>	gAUpLg==	gAV9lC4=	\N	2021-06-12 13:13:47.373132+00	2021-06-12 13:13:48.77509+00	t	7f278b7b2b05446bab2536993e48c03e	\N	1
yellow-uncle-lion-carbon	<bound method JudgeSubmissionTask.main of <submission.models.JudgeSubmissionTask object at 0x7ff20a1819a0>>	<bound method JudgeSubmissionTask.hook of <submission.models.JudgeSubmissionTask object at 0x7ff20a1819a0>>	gAUpLg==	gAV9lC4=	gAWVkAIAAAAAAABYiQIAAG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZCA6IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RqYW5nb19xL2NsdXN0ZXIucHkiLCBsaW5lIDQzNiwgaW4gd29ya2VyCiAgICByZXMgPSBmKCp0YXNrWyJhcmdzIl0sICoqdGFza1sia3dhcmdzIl0pCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNjUsIGluIG1haW4KICAgIHNlbGYuanNlcnZlciA9IEp1ZGdlU3VibWlzc2lvblRhc2suYXNzaWduX2p1ZGdlX3NlcnZlcigpCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNDgsIGluIGFzc2lnbl9qdWRnZV9zZXJ2ZXIKICAgIGNhbmRpZGF0ZXMgPSBbY2FuZCBmb3IgY2FuZCBpbiBKdWRnZVNlcnZlci5vYmplY3RzLmFsbCgpIGlmIGNhbmQuc3RhdHVzKCkgPT0gSnVkZ2VTZXJ2ZXJTdGF0dXMuTk9STUFMXQpOYW1lRXJyb3I6IG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZAqULg==	2021-06-18 06:39:56.894387+00	2021-06-18 06:39:56.934297+00	f	89b7eb283d9a480abf1ea17ab0394fd9	\N	1
johnny-video-lima-whiskey	<bound method JudgeSubmissionTask.main of <submission.models.JudgeSubmissionTask object at 0x7ff20a181550>>	<bound method JudgeSubmissionTask.hook of <submission.models.JudgeSubmissionTask object at 0x7ff20a181550>>	gAUpLg==	gAV9lC4=	gAWVkAIAAAAAAABYiQIAAG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZCA6IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RqYW5nb19xL2NsdXN0ZXIucHkiLCBsaW5lIDQzNiwgaW4gd29ya2VyCiAgICByZXMgPSBmKCp0YXNrWyJhcmdzIl0sICoqdGFza1sia3dhcmdzIl0pCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNjUsIGluIG1haW4KICAgIHNlbGYuanNlcnZlciA9IEp1ZGdlU3VibWlzc2lvblRhc2suYXNzaWduX2p1ZGdlX3NlcnZlcigpCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNDgsIGluIGFzc2lnbl9qdWRnZV9zZXJ2ZXIKICAgIGNhbmRpZGF0ZXMgPSBbY2FuZCBmb3IgY2FuZCBpbiBKdWRnZVNlcnZlci5vYmplY3RzLmFsbCgpIGlmIGNhbmQuc3RhdHVzKCkgPT0gSnVkZ2VTZXJ2ZXJTdGF0dXMuTk9STUFMXQpOYW1lRXJyb3I6IG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZAqULg==	2021-06-18 06:41:50.948675+00	2021-06-18 06:41:50.983151+00	f	d4fbf8bc183542818d6ea238305f8e12	\N	1
idaho-six-emma-double	<bound method JudgeSubmissionTask.main of <submission.models.JudgeSubmissionTask object at 0x7fc89c475a60>>	<bound method JudgeSubmissionTask.hook of <submission.models.JudgeSubmissionTask object at 0x7fc89c475a60>>	gAUpLg==	gAV9lC4=	gAWVkAIAAAAAAABYiQIAAG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZCA6IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RqYW5nb19xL2NsdXN0ZXIucHkiLCBsaW5lIDQzNiwgaW4gd29ya2VyCiAgICByZXMgPSBmKCp0YXNrWyJhcmdzIl0sICoqdGFza1sia3dhcmdzIl0pCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNjUsIGluIG1haW4KICAgIHNlbGYuanNlcnZlciA9IEp1ZGdlU3VibWlzc2lvblRhc2suYXNzaWduX2p1ZGdlX3NlcnZlcigpCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNDgsIGluIGFzc2lnbl9qdWRnZV9zZXJ2ZXIKICAgIGNhbmRpZGF0ZXMgPSBbY2FuZCBmb3IgY2FuZCBpbiBKdWRnZVNlcnZlci5vYmplY3RzLmFsbCgpIGlmIGNhbmQuc3RhdHVzKCkgPT0gSnVkZ2VTZXJ2ZXJTdGF0dXMuTk9STUFMXQpOYW1lRXJyb3I6IG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZAqULg==	2021-06-18 06:42:02.77187+00	2021-06-18 06:42:02.812619+00	f	cbee317552f7412c9784614c56a620e5	\N	1
zulu-freddie-north-connecticut	<bound method JudgeSubmissionTask.main of <submission.models.JudgeSubmissionTask object at 0x7fc89c494070>>	<bound method JudgeSubmissionTask.hook of <submission.models.JudgeSubmissionTask object at 0x7fc89c494070>>	gAUpLg==	gAV9lC4=	gAWV+gEAAAAAAABY8wEAAG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZCA6IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RqYW5nb19xL2NsdXN0ZXIucHkiLCBsaW5lIDQzNiwgaW4gd29ya2VyCiAgICByZXMgPSBmKCp0YXNrWyJhcmdzIl0sICoqdGFza1sia3dhcmdzIl0pCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNjUsIGluIG1haW4KICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC9kb2ovUEJMX0RPbmxpbmVKdWRnZS9kb25saW5lanVkZ2Uvc3VibWlzc2lvbi9tb2RlbHMucHkiLCBsaW5lIDE0OCwgaW4gYXNzaWduX2p1ZGdlX3NlcnZlcgogICAgQHN0YXRpY21ldGhvZApOYW1lRXJyb3I6IG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZAqULg==	2021-06-18 06:42:33.028227+00	2021-06-18 06:42:33.066844+00	f	e54cabfd76724209b0cc71939e523fdf	\N	1
london-steak-twelve-autumn	<bound method JudgeSubmissionTask.main of <submission.models.JudgeSubmissionTask object at 0x7fc89c475a00>>	<bound method JudgeSubmissionTask.hook of <submission.models.JudgeSubmissionTask object at 0x7fc89c475a00>>	gAUpLg==	gAV9lC4=	gAWV+gEAAAAAAABY8wEAAG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZCA6IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RqYW5nb19xL2NsdXN0ZXIucHkiLCBsaW5lIDQzNiwgaW4gd29ya2VyCiAgICByZXMgPSBmKCp0YXNrWyJhcmdzIl0sICoqdGFza1sia3dhcmdzIl0pCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNjUsIGluIG1haW4KICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC9kb2ovUEJMX0RPbmxpbmVKdWRnZS9kb25saW5lanVkZ2Uvc3VibWlzc2lvbi9tb2RlbHMucHkiLCBsaW5lIDE0OCwgaW4gYXNzaWduX2p1ZGdlX3NlcnZlcgogICAgQHN0YXRpY21ldGhvZApOYW1lRXJyb3I6IG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZAqULg==	2021-06-18 06:43:56.626956+00	2021-06-18 06:43:56.648127+00	f	ae615be8d72d4e60bc4ed2c23437dad7	\N	1
cardinal-alpha-floor-golf	<bound method JudgeSubmissionTask.main of <submission.models.JudgeSubmissionTask object at 0x7fc89c47ceb0>>	<bound method JudgeSubmissionTask.hook of <submission.models.JudgeSubmissionTask object at 0x7fc89c47ceb0>>	gAUpLg==	gAV9lC4=	gAWV+gEAAAAAAABY8wEAAG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZCA6IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RqYW5nb19xL2NsdXN0ZXIucHkiLCBsaW5lIDQzNiwgaW4gd29ya2VyCiAgICByZXMgPSBmKCp0YXNrWyJhcmdzIl0sICoqdGFza1sia3dhcmdzIl0pCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNjUsIGluIG1haW4KICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC9kb2ovUEJMX0RPbmxpbmVKdWRnZS9kb25saW5lanVkZ2Uvc3VibWlzc2lvbi9tb2RlbHMucHkiLCBsaW5lIDE0OCwgaW4gYXNzaWduX2p1ZGdlX3NlcnZlcgogICAgQHN0YXRpY21ldGhvZApOYW1lRXJyb3I6IG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZAqULg==	2021-06-18 06:44:36.409103+00	2021-06-18 06:44:36.431813+00	f	31ab05bf6b0b4622bf0b12efe380fbcd	\N	1
minnesota-nineteen-queen-chicken	<bound method JudgeSubmissionTask.main of <submission.models.JudgeSubmissionTask object at 0x7f1b171a09a0>>	<bound method JudgeSubmissionTask.hook of <submission.models.JudgeSubmissionTask object at 0x7f1b171a09a0>>	gAUpLg==	gAV9lC4=	gAWVtQEAAAAAAABYrgEAAG5hbWUgJ2FzeW5jaW8nIGlzIG5vdCBkZWZpbmVkIDogVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi9ob21lL252YXR1YW4yMDAwLy5sb2NhbC9saWIvcHl0aG9uMy44L3NpdGUtcGFja2FnZXMvZGphbmdvX3EvY2x1c3Rlci5weSIsIGxpbmUgNDM2LCBpbiB3b3JrZXIKICAgIHJlcyA9IGYoKnRhc2tbImFyZ3MiXSwgKip0YXNrWyJrd2FyZ3MiXSkKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC9kb2ovUEJMX0RPbmxpbmVKdWRnZS9kb25saW5lanVkZ2Uvc3VibWlzc2lvbi9tb2RlbHMucHkiLCBsaW5lIDE4MSwgaW4gbWFpbgogICAgYXN5bmNpby5nZXRfZXZlbnRfbG9vcCgpLnJ1bl91bnRpbF9jb21wbGV0ZShzZWxmLnNlbmRfYW5kX3JlY2VpdmUoKSkKTmFtZUVycm9yOiBuYW1lICdhc3luY2lvJyBpcyBub3QgZGVmaW5lZAqULg==	2021-06-18 06:45:00.198877+00	2021-06-18 06:45:00.253765+00	f	07c6a1eb15e84928ad180704b81f5edf	\N	1
speaker-leopard-charlie-solar	<bound method JudgeSubmissionTask.main of <submission.models.JudgeSubmissionTask object at 0x7f111483ca60>>	<bound method JudgeSubmissionTask.hook of <submission.models.JudgeSubmissionTask object at 0x7f111483ca60>>	gAUpLg==	gAV9lC4=	gAWVkAIAAAAAAABYiQIAAG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZCA6IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RqYW5nb19xL2NsdXN0ZXIucHkiLCBsaW5lIDQzNiwgaW4gd29ya2VyCiAgICByZXMgPSBmKCp0YXNrWyJhcmdzIl0sICoqdGFza1sia3dhcmdzIl0pCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNjgsIGluIG1haW4KICAgIHNlbGYuanNlcnZlciA9IEp1ZGdlU3VibWlzc2lvblRhc2suYXNzaWduX2p1ZGdlX3NlcnZlcigpCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNTEsIGluIGFzc2lnbl9qdWRnZV9zZXJ2ZXIKICAgIGNhbmRpZGF0ZXMgPSBbY2FuZCBmb3IgY2FuZCBpbiBKdWRnZVNlcnZlci5vYmplY3RzLmFsbCgpIGlmIGNhbmQuc3RhdHVzKCkgPT0gSnVkZ2VTZXJ2ZXJTdGF0dXMuTk9STUFMXQpOYW1lRXJyb3I6IG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZAqULg==	2021-06-18 06:45:59.31797+00	2021-06-18 06:45:59.353331+00	f	a718fa94821e48acacb687b88e5d8a97	\N	1
minnesota-jersey-wisconsin-berlin	<bound method JudgeSubmissionTask.main of <submission.models.JudgeSubmissionTask object at 0x7f8ba6ea9a60>>	<bound method JudgeSubmissionTask.hook of <submission.models.JudgeSubmissionTask object at 0x7f8ba6ea9a60>>	gAUpLg==	gAV9lC4=	gAWVkAIAAAAAAABYiQIAAG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZCA6IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RqYW5nb19xL2NsdXN0ZXIucHkiLCBsaW5lIDQzNiwgaW4gd29ya2VyCiAgICByZXMgPSBmKCp0YXNrWyJhcmdzIl0sICoqdGFza1sia3dhcmdzIl0pCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNjUsIGluIG1haW4KICAgIHNlbGYuanNlcnZlciA9IEp1ZGdlU3VibWlzc2lvblRhc2suYXNzaWduX2p1ZGdlX3NlcnZlcigpCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNDgsIGluIGFzc2lnbl9qdWRnZV9zZXJ2ZXIKICAgIGNhbmRpZGF0ZXMgPSBbY2FuZCBmb3IgY2FuZCBpbiBKdWRnZVNlcnZlci5vYmplY3RzLmFsbCgpIGlmIGNhbmQuc3RhdHVzKCkgPT0gSnVkZ2VTZXJ2ZXJTdGF0dXMuTk9STUFMXQpOYW1lRXJyb3I6IG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZAqULg==	2021-06-18 06:46:46.630802+00	2021-06-18 06:46:46.668397+00	f	08e82f444e8e45ecafc28114d54175f5	\N	1
seventeen-blossom-quiet-oregon	<bound method JudgeSubmissionTask.main of <submission.models.JudgeSubmissionTask object at 0x7f8ba6ec8070>>	<bound method JudgeSubmissionTask.hook of <submission.models.JudgeSubmissionTask object at 0x7f8ba6ec8070>>	gAUpLg==	gAV9lC4=	gAWV/AEAAAAAAABY9QEAAG5hbWUgJ0p1ZGdlU2VydmVyJyBpcyBub3QgZGVmaW5lZCA6IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvaG9tZS9udmF0dWFuMjAwMC8ubG9jYWwvbGliL3B5dGhvbjMuOC9zaXRlLXBhY2thZ2VzL2RqYW5nb19xL2NsdXN0ZXIucHkiLCBsaW5lIDQzNiwgaW4gd29ya2VyCiAgICByZXMgPSBmKCp0YXNrWyJhcmdzIl0sICoqdGFza1sia3dhcmdzIl0pCiAgRmlsZSAiL2hvbWUvbnZhdHVhbjIwMDAvZG9qL1BCTF9ET25saW5lSnVkZ2UvZG9ubGluZWp1ZGdlL3N1Ym1pc3Npb24vbW9kZWxzLnB5IiwgbGluZSAxNjUsIGluIG1haW4KICAgIHNlbGYuc3ViLnNhdmUoKQogIEZpbGUgIi9ob21lL252YXR1YW4yMDAwL2Rvai9QQkxfRE9ubGluZUp1ZGdlL2RvbmxpbmVqdWRnZS9zdWJtaXNzaW9uL21vZGVscy5weSIsIGxpbmUgMTQ4LCBpbiBhc3NpZ25fanVkZ2Vfc2VydmVyCk5hbWVFcnJvcjogbmFtZSAnSnVkZ2VTZXJ2ZXInIGlzIG5vdCBkZWZpbmVkCpQu	2021-06-18 06:49:07.454674+00	2021-06-18 06:49:07.488945+00	f	1040f5669e474c82aa58db9ed72a86dc	\N	1
social-georgia-artist-lake	<bound method JudgeSubmissionTask.main of <submission.views.api.JudgeSubmissionTask object at 0x7fc5c0883a60>>	<bound method JudgeSubmissionTask.hook of <submission.views.api.JudgeSubmissionTask object at 0x7fc5c0883a60>>	gAUpLg==	gAV9lC4=	\N	2021-06-18 06:52:47.661809+00	2021-06-18 06:52:49.409307+00	t	c1c18e42f6c9472ba75e1eed7cbbea58	\N	1
pluto-july-island-india	<bound method JudgeSubmissionTask.main of <submission.views.api.JudgeSubmissionTask object at 0x7fc5c791c370>>	<bound method JudgeSubmissionTask.hook of <submission.views.api.JudgeSubmissionTask object at 0x7fc5c791c370>>	gAUpLg==	gAV9lC4=	\N	2021-07-03 09:47:52.061318+00	2021-07-03 09:48:04.126883+00	t	2fe4bfc5a75f48dd82faf8e710e347d7	\N	1
venus-batman-friend-speaker	<bound method JudgeSubmissionTask.main of <submission.views.api.JudgeSubmissionTask object at 0x7fc5c0883a60>>	<bound method JudgeSubmissionTask.hook of <submission.views.api.JudgeSubmissionTask object at 0x7fc5c0883a60>>	gAUpLg==	gAV9lC4=	\N	2021-07-03 09:49:22.271032+00	2021-07-03 09:49:34.321214+00	t	ecfcca31ec6f4bdaa5563a99462dce74	\N	1
cat-carbon-sink-network	<bound method JudgeSubmissionTask.main of <submission.views.api.JudgeSubmissionTask object at 0x7fc5c791c370>>	<bound method JudgeSubmissionTask.hook of <submission.views.api.JudgeSubmissionTask object at 0x7fc5c791c370>>	gAUpLg==	gAV9lC4=	\N	2021-07-03 09:51:06.907936+00	2021-07-03 09:51:18.961157+00	t	38ab85358dd04d0fa28c12fbc2f94def	\N	1
triple-six-oranges-sierra	<bound method JudgeSubmissionTask.main of <submission.views.api.JudgeSubmissionTask object at 0x7fc5c088baf0>>	<bound method JudgeSubmissionTask.hook of <submission.views.api.JudgeSubmissionTask object at 0x7fc5c088baf0>>	gAUpLg==	gAV9lC4=	\N	2021-07-03 10:13:45.433351+00	2021-07-03 10:13:57.489156+00	t	67aa022eb8c94ff6ad85810fedc7927d	\N	1
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
kas9cinb0bq6utqf2g7p7ihfwm20fc9f	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj4RJ:zSmXyY8mS9WaiorKZQWj83cfkFFSCFaYtLdevwL2GAM	2021-06-01 18:27:33.855868+00
abm2dt7es1nrufjhsxrb2xjkjgo4y0yn	.eJxVjDsOwjAQBe_iGlm2N_5R0nMGa9cfHEC2FCcV4u4QKQW0b2beiwXc1hq2kZcwJ3Zmkp1-N8L4yG0H6Y7t1nnsbV1m4rvCDzr4taf8vBzu30HFUb-1d2ByIsxxkmSV9lpYDVBAQdQCJy-L8YXQGWOdpKSVpJjQWLBORyvY-wPTGzdN:1lfVkw:SsDRzcYEPru_LUrQmTXfOEMcRnhlhCl-XiTZeleF6gw	2021-05-22 22:49:06.288+00
9uxfeqftj52n31romnuvumssojjji51j	.eJxVjDsOwjAQBe_iGlm2N_5R0nMGa9cfHEC2FCcV4u4QKQW0b2beiwXc1hq2kZcwJ3Zmkp1-N8L4yG0H6Y7t1nnsbV1m4rvCDzr4taf8vBzu30HFUb-1d2ByIsxxkmSV9lpYDVBAQdQCJy-L8YXQGWOdpKSVpJjQWLBORyvY-wPTGzdN:1lffZ3:_l0I-5dwKq-nBv__28P89flGGguiVh903noRyu2zeYE	2021-05-23 09:17:29.022079+00
l50qc1hukpxonr7r2pez7lyq5mf9ujcg	.eJxVjEEOwiAQRe_C2hBwGKAu3fcMzcBMpGogKe3KeHdt0oVu_3vvv9RE21qmrcsyzawuyqrT75YoP6TugO9Ub03nVtdlTnpX9EG7HhvL83q4fweFevnWTsjkZISJ0HL2DI4csAVKxkCMgZGcH1yC6GMICCECBBRzRhgYnXp_AOx1Nwo:1lfiJB:4tfb7pRnpYygWE4LHxOPKpLV0_18J3WQme_1ZzSS4a4	2021-05-23 12:13:17.442961+00
x3qi236n4lty76o2ew15p8uds55d1lpn	.eJxVjDsOwjAQBe_iGlm2N_5R0nMGa9cfHEC2FCcV4u4QKQW0b2beiwXc1hq2kZcwJ3Zmkp1-N8L4yG0H6Y7t1nnsbV1m4rvCDzr4taf8vBzu30HFUb-1d2ByIsxxkmSV9lpYDVBAQdQCJy-L8YXQGWOdpKSVpJjQWLBORyvY-wPTGzdN:1lfk57:opiM9i9iBhbyP7XIPXfDJ4_g7PFnta3765vEDm9IBns	2021-05-23 14:06:53.552087+00
dnwrpp1402ovrisuilah8m3qnw5gxdbo	.eJxVjEsOwjAMBe-SNYqS1E1iluw5Q-XYLi2gVOpnhbg7VOoCtm9m3st0tK1Dty06d6OYs_HOnH7HQvzQuhO5U71Nlqe6zmOxu2IPutjrJPq8HO7fwUDL8K17BEqoOfTQqGu1YMlAsU0QC-QUOQaPiIklgrCIZwXMPjWBuXfRmfcH_h03yA:1lfkwG:Dd8gLHwfof6NIYx8w5rWdv2V35Mt0YUPRn_gr8OvXKY	2021-05-23 15:01:48.158868+00
iuymzo66f3i8axuec0yoqm78uxpo2399	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lfkyt:q-QnAF-xp4c1Ca0IBtGgmO1-x52LWWLwZfFBqyp9_iU	2021-05-23 15:04:31.86919+00
ahxtgg05oztcojt896ohrzkkcw6ivxfm	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lfl0M:8ZM4L08oQ9PhZ69xsgX8l60BaTTaTyRyOmbySKEseqk	2021-05-23 15:06:02.879751+00
w34zqoatfjr69wp34tff572fj32psy6z	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lfljs:BvatPLQQjryOf81fS1_VhHtTtDVkneVQ61e-J_ITaew	2021-05-23 15:53:04.47485+00
a4ena150swlis1not84fm62iqjlg8a3f	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh61f:wZFgRA_6M6YPfAAT9tigO6ozuO852TpkKYKmbYfNjdo	2021-05-27 07:44:55.508318+00
9w2t8t52neizl4vuzxc85s86xpwp7qis	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh65f:TJKRE75hy5wRFtFc28D3BxKktMLA_3sRffuddMydEAE	2021-05-27 07:49:03.715081+00
5uztg4ky2igkldrerxzyuotug2ibj8u3	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh6EY:oHdgqNbAK3HDoYfzvE6OdhRfXbGzi-IgPFBGcNReosI	2021-05-27 07:58:14.225964+00
wpqk33wh57vmbivvkyyjnetojqqig3bt	e30:1lh6GV:WF7T8RzMtmzBpJ3oH2jXxJbEiOaOeep3dXIXKlxw9GE	2021-05-27 08:00:15.482053+00
1cxx0kbhhbkmsb3o5ac3kmdatft0rz20	e30:1lh6Ge:UXzC3uFgO_zC1Q3dVh3NydFVILz5rvuspQrFl9pcapE	2021-05-27 08:00:24.737027+00
22g45mnqr6h3iu917ea40bky2oac1v1v	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh6Gu:cutgUVTOVgRWFTN1eyDbaRDHCTEaVR364FIK9RF3dkA	2021-05-27 08:00:40.599637+00
wojg7lo4srnplenbp4sez29s6dr7hii1	e30:1lhDCn:-cU9qJG93LShBRGtVOQ3AEXGV6FuVNg2-ft6fQwMzHA	2021-05-27 15:24:53.773024+00
k3uo3dfn4ue7ehjt453c2tetq8jnzim3	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh6Nh:05lsfLCaRcvS4Um1jnKGjs4McYwgDk68uRNSu1I4KGg	2021-05-27 08:07:41.105907+00
crx7dj11zisiwpo14oq64drdphmy0ao2	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh6O4:zOrL6UsDUoL4RQ-peEDclcG70jAVXGM4wvxOMwLN0TE	2021-05-27 08:08:04.666769+00
e1vb9wlg7ky8pixnxlqq7lrkp1sv47uv	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh6O6:NB45o2aYh8nZxlthdldR2zCzRXSBjyPRZxMW7mm4dPs	2021-05-27 08:08:06.072065+00
2rc6tt84edvj1i7x30y8teqlor0y4jy1	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh6OQ:dSorT-tuhzjr9ktp8IKnkf5m1-1OG6WhD3cezWGwzOk	2021-05-27 08:08:26.795901+00
ir55fru8q5cn73duf9ak4zwkq16yufho	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh6Ot:cQZ7GSkknbVdBqfy0JK9SdlPHLtoWj6QJqQUOjHSolA	2021-05-27 08:08:55.429632+00
qntggivvzjrna5n3yb9dx3y4n4p5piof	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh7ct:X-lKHFyn65pKstGXi84As9RqchTHI-1QNcS4C7rECx4	2021-05-27 09:27:27.410604+00
i6oisli039cb73mcimpm5o7v7sntgbh1	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh8FA:1WoCwXooecEIbuPnjwlvPApe5VcIE7wvsPinjChOyUY	2021-05-27 10:07:00.476985+00
r3xieywcidktty2v6067vhxfkw64wmhz	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh8G9:srVg2Jf8avogZkGm0I7rQyWNa9vDR1NShEZzg7KUzDg	2021-05-27 10:08:01.82286+00
5wy9q7daae77pybsqcpvgpfu50jiqapq	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh8GM:3NRCWQIbi4bCIadaMPQx5j_le-TEH4k-SDZ6tbRSne0	2021-05-27 10:08:14.940107+00
etowf2bxma79w73qmjecwimi5b9ry2af	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh8IN:oMX6v5D7tVLOCyPnohIM0e7TBZEC2orK530qOAdvq10	2021-05-27 10:10:19.658917+00
vmnh1lomloqmctnmz0ukmbm2lwmwf06v	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh8Yo:9rDhh-sG599dtKx1WL_6-DKD5lIy_McNrv-Ia8mzmdQ	2021-05-27 10:27:18.224553+00
bpd3kkpin0se4xk2nua92z3z9aov02ht	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh8Z1:gAMYvFBpCqJzI5uUm6r0T29I3LVGtGXNIRwbAwvB5nA	2021-05-27 10:27:31.988569+00
4bqsquto1lnu5r0ljwp5jwwv3y2co6hk	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCfO:74wru56p48INDZGf_PqDS9VQhMGxUOJg6-SY65dkEA0	2021-05-27 14:50:22.818918+00
d6q169erh04ippulc7cem6z95uufd0mp	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh8ZX:XSnb7I2MeLdDkmSOBrJ2x-1oVMXLli_dkwSZpkHyM_k	2021-05-27 10:28:03.546888+00
9j4vgiy3auk724fw5nes1gs7emy4zit8	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCfy:Vd8Oh3XbbO7uNQui4RAUGJ1_YDH88cSilsU2Ae5RERk	2021-05-27 14:50:58.030347+00
4m7yiaswgi8cuagozafulxckye4ypi8v	.eJxVjDsOwjAQBe_iGlm2N_5R0nMGa9cfHEC2FCcV4u4QKQW0b2beiwXc1hq2kZcwJ3Zmkp1-N8L4yG0H6Y7t1nnsbV1m4rvCDzr4taf8vBzu30HFUb-1d2ByIsxxkmSV9lpYDVBAQdQCJy-L8YXQGWOdpKSVpJjQWLBORyvY-wPTGzdN:1lh8aN:Y29SP2xtbv7QsuN6GMkBDul-2JRHhTWw2oUOc_N0V-k	2021-05-27 10:28:55.940278+00
rlgi7ujfw84yyfulajaye91h6p6zrjwf	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCg1:B9qWoSV4T4miwDtQ9dzvtf5jWaCQWlwlt9r2p0HMa-o	2021-05-27 14:51:01.485234+00
ump1cxc9evy9bzftclwkmv9u2kt4kxgp	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh8ad:Hhw7SYbkpfij-nIlqn8pQjTVzozEZStELMDEK3l9uhU	2021-05-27 10:29:11.168088+00
ogwpk50qdnaq04worzh71ej0ouscw7hq	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCgG:iE75uT2vmu4H6aQ2UrNRzg0KbA9LK9nE76MB3l1eauU	2021-05-27 14:51:16.705786+00
dxxigpqnl6uucp8lovzg0crgn9xy6iei	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh8b6:FFB0DOYZfvGsrMySpX5VG_d3B7wP_d7mGqSqA3CP-Hs	2021-05-27 10:29:40.777941+00
q0bhqftmzirfeicqfqh0ayxd9e25z75n	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCgc:6vi5BFXiaNXKbPvrx5IGtauLlrL8a_ttQW6jMXfvDwM	2021-05-27 14:51:38.005804+00
97ghmm5a3foozaiup0zw99fwvs55kxme	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh8di:Wrzj0ubX9jqy5uMYnTJqyFwqRP1l76ctF6xdcZ1MSR4	2021-05-27 10:32:22.973059+00
crohn2qzndd27whhsxymbc1ixe8r296j	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhChM:ycrsICXzSe1q3GHdRxGnXzk_UqkqHYv7UAKmPZRJn1Y	2021-05-27 14:52:24.701837+00
wscuba9fmm2rf7tl0wflolutuc9f8wgj	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh8e0:pDcZffImT_IodqRlDaDDMawFZTs5YQwnmG9fXKHsFkw	2021-05-27 10:32:40.794547+00
fh58e14zimaeawrwrf44bd8xvqsjnpcu	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh90V:4U8r6SVz5yftCgIMTynGixjiOWkOWtPZVrutw-5UafI	2021-05-27 10:55:55.031878+00
mkdht5xbl5u6nivsfz3gd0ziu7qw8ecr	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh90i:yF36la9HY5ey-Bx8fku0Z_m2xFqhYZF-yGyUxwogqiQ	2021-05-27 10:56:08.794786+00
dd3f9jbdtkim10cc8zlu44v14i62fg9k	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh910:bAMM61F731JOt2gu0wGkja8ZmGhmGOXDCqTx59WNO0Q	2021-05-27 10:56:26.942481+00
zosevimnvtlwkj6xuh2353guhglpq16v	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh91I:ftjt8Sar9IBxjzom8lLpcAn255oV9RxnpLGIqZPy9H4	2021-05-27 10:56:44.241044+00
bup7thyh9ck5jspa0hfq6r46k97pq39n	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lh962:RkO23MpbRtSWSfWPTVv9ViTN2gYRlhhDDpSjnzeVww4	2021-05-27 11:01:38.571351+00
beevqkfnbqrr7s97hs42mtpwjsjp21wc	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhAgW:c9rmjoxaf_q4YCz0grjIVRj5eNAvA4Yo3oA4gsfqJpc	2021-05-27 12:43:24.212085+00
0l6zigtr3ztme7oodgx3nmmous2fvc0l	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhAgn:mfzzKl2sLdyGkyis2IOQKA26GfXjB4DccZbeNgacNNc	2021-05-27 12:43:41.761213+00
uvk5fy6j3wv9321nouw64zp4pxgfnnan	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhB1L:oEqa8eHigySsDOzsk6QVOWBnjpFyO2BcT92qAVtZRPc	2021-05-27 13:04:55.071821+00
k7y20avp96yo88fuqmrlcv559ozav94n	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhB42:II_cXPoijbMQFIiMpHg6DfeIyOZE_SlVeyFtqGndprI	2021-05-27 13:07:42.654201+00
4o0m011ny0dwh1fr2tuoglhigcaoj633	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCci:yazLDnx2yJGRbbUqLCUjbGHFxNK8dAnuNkkEhV4zPYI	2021-05-27 14:47:36.468788+00
gkbmhde74uj2gvhhdut29invtzbgfqa9	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCdq:9v1xiRn_xcJyJ5k4VPRaq83zklHNESc1F3eaMZ3zMp0	2021-05-27 14:48:46.582037+00
txoes46v7oz2h47kwatzkqeh5a14nt4z	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCe7:W9iNGn3S4EVCwUk0nu2vH5VKV6pvx8hOcGF7K48AbnA	2021-05-27 14:49:03.130666+00
ol57dx0yo4v3dlc06rimf27667i6iz07	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCeZ:x98YeS9v-cSNqVpF9O3b7_Lps_yEqwT-CIdUYzePeGE	2021-05-27 14:49:31.578249+00
bbooqdvytql8ej2tuarkygdzq3ya3f9a	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCha:N_-DEoTOy7F3UWj0xEwrflBV17lkkX6qUtus72D6RXM	2021-05-27 14:52:38.432739+00
k8yey3ek1wcmo2boip2xkknlhqdp5k69	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU0q:gvXLbaMccVNUQEyDEcKydRSUIQFlpF4Fo1px8Tqbz7I	2021-05-28 09:21:40.029865+00
2336rfek07ju9psrfavu1lzpvbzn46au	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lho3K:3Hk0__I72VeSTdrgsGPULPXlw89ZVfjqby5ENVVsW3s	2021-05-29 06:45:34.823191+00
1xvb627b4pta8l83ghrvfl3wyrxf56g6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUie:lXuLQghcZhUZSbkU8CFAumzOzoHdb5HLPmaWDKujk1I	2021-05-28 10:06:56.36279+00
0yyr2g0nihivny9bkv2p786hcp71ilda	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrXv3:lB1H2y6wN8S7DdQXyxCPgzBuNWGn3m5xyB8lS4OUSPY	2021-06-25 03:33:17.355643+00
hzb5wsieg76ymyd3hz7btm4jlt32yghb	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhYfL:kmo_bj8GKMgu07XPKxY2FA6iC8LL5KhS24yCKJMOqiQ	2021-05-28 14:19:47.487058+00
qg7rf1pe1eb019hpshh3uox42n3rm993	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhyue:Q4Bx2CZrVlefKaIsQs0Url5ySgzlM0gcug-IMTtBz0k	2021-05-29 18:21:20.354392+00
fms0mqbhz0qjqcyzr42as0s9upussy2r	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj4RS:QD3P0A-le53HgEBUYU767GSvX68oV3XPeBWmCmtZpng	2021-06-01 18:27:42.651311+00
hn0371r9y125abf33y9e7t4bpi2f6d47	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH6V:xSUef6BGoLAx0yOzefJ1ahiCPdpJCKVv70NZD-ya-xw	2021-05-30 13:46:47.405031+00
o6nv0zsz96qgc5bc92c10f22it9f6wdh	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lpVyb:OiM9NRtUkM788PiQE6ElDvUfYfp2hWWLqSQoeAEu_7g	2021-06-19 13:04:33.421589+00
16p9x4wdlbdz9d6l77d43r5ab6uw1zn4	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj4PJ:TAhcfioKxv8eX4AIja0oLEMPNjRVJlAAdNrA28I526g	2021-06-01 18:25:29.996828+00
nmp1cismszozsjkn4dihdhskknrqphfx	.eJxVjDsOwyAQBe9CHSG8wGJSpvcZ0PILTiKQjF1FuXtsyUXSvpl5b-ZoW4vbelrcHNmVgWWX39FTeKZ6kPigem88tLous-eHwk_a-dRiet1O9--gUC97nbzVqAdPGUFFyMLbUSQwoDHlgEGMcTBSGhVQ7pomg4osopUaTBbAPl8AIDcm:1lrHDl:TLwiQw_2PML686bC8xGtja-eAHX9anxRvXtAo5DyTMc	2021-06-24 09:43:29.19855+00
w1q1zfeciydsafsrmeir7sj0clmdp3ez	.eJxVjEEOwiAQRe_C2hBgLHRcuvcMZIBBqgaS0q6Md7dNutDtf-_9t_C0LsWvnWc_JXERoMTpdwwUn1x3kh5U703GVpd5CnJX5EG7vLXEr-vh_h0U6mWrjWULCrM2DpFJc3YGjRrODNFBhDSGrAMTDVbnGJUmUA71iCnjJjnx-QL4sDff:1lrcms:smDG3_d-AifERxmL0rzZjqrPtKHGRlr4Awt4VTR08w0	2021-06-25 08:45:10.845233+00
e13sg9kcskbam4j7nb6uowzehpfso6s2	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1m0e3r:lj8bKUyHYqke_Z19mRSs31_xqxUCpPG4j3tukebndrs	2021-07-20 05:55:59.776763+00
jgp6nrpw2foqwfgpuzrmitf6i47nu2tk	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhChb:GmQF-qMQWTGCph_d476jMW6r8rrK9AnwhoF3gURiZbw	2021-05-27 14:52:39.712598+00
w6vy9z3zu5vzpndz9aspulg77yxp0czj	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU29:nTAv9L7z8r3VynVPKiQgT_JzP-xqOKT01G9Q8ciTpyA	2021-05-28 09:23:01.298252+00
xfvls6q94l1ibega558tkyf2qpen79xe	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1lho3g:wrsY3ZKzdbplHhCA9Thun0MzmVSTUiLvJS0U1zQ1-OY	2021-05-29 06:45:56.488963+00
xhkxgqtrgeeglg0r6in113e1lrg0cbdo	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUxq:e80wT1O-dJm_x0yELr7emPl2969ZL2tLQr1UE2bTUUw	2021-05-28 10:22:38.317615+00
yqqmvqdg0spn8pbuifobenrn6im0o11b	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj4Rx:rBabF1CM3PZiRD-cLolL61BwY_CtWiWMFfdyn30ystk	2021-06-01 18:28:13.198341+00
c4l0ka3hmygjns2l77pgih66rjvzbrf2	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhYfi:Wmhn7qiFMcSbLNTJQ8JK3qTuZzSbEI7ZlJSVD30-IeM	2021-05-28 14:20:10.847499+00
veoivneke7qh8mn2lucemx8axf0potay	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhyvi:_SDj08e_zWZxSbryJWow7khXrz1Z5C8jop9Wvgph79A	2021-05-29 18:22:26.525741+00
xzu7fdaiqxz0u7gmjxco2qpmugwnvfe3	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrXwW:e2gigRNv83-TrnNddwa3cE-ODxaxmQixVJvJYBlFmgs	2021-06-25 03:34:48.669902+00
0ni3fm3ybv43tvv9u9zdi90ezad5mazo	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH6X:v55lEzAsD4d9zgBxyb32g92kRfr3Ae0RZywsMuBmx00	2021-05-30 13:46:49.960754+00
pccvw0t2xwh3czkuilgikc2hy3ghk7lp	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lpW7J:MdIS6xTsfrd__DD_ijlKFXogYOITk9ZS_VF6HuxLaa8	2021-06-19 13:13:33.509797+00
ydewpoyx2gq7h4602y2mpczzkl0t1jtx	.eJxVjDsOwyAQBe9CHSG8wGJSpvcZ0PILTiKQjF1FuXtsyUXSvpl5b-ZoW4vbelrcHNmVgWWX39FTeKZ6kPigem88tLous-eHwk_a-dRiet1O9--gUC97nbzVqAdPGUFFyMLbUSQwoDHlgEGMcTBSGhVQ7pomg4osopUaTBbAPl8AIDcm:1lrHHy:qZy2rJiy_y9rjU0k6pn1p3h3kMd03_Awv3VV7H_GzVY	2021-06-24 09:47:50.592533+00
th6vjqec6n5xzwv9cn809pded4e59q2n	.eJxVjDsOwjAQBe_iGllavFk7lPScwdr1BweQLcVJFXF3iJQC2jczb1Oe16X4tafZT1FdlAF1-h2FwzPVncQH13vTodVlnkTvij5o17cW0-t6uH8HhXv51mxzRAGxROASEGcTMqZwpiGLYwc5sgwOEAEtWiCXYh7JEJCY0aJ6fwAb4zfp:1lrcnE:Dug2a1HaoynJFfBmHRah4BtNJU7kzn4s-q_sjVVVsms	2021-06-25 08:45:32.525401+00
gsntaxfc63sz2n8lzaxeyo72tmynzbi5	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1m10aO:qyYIJjEdzp2_djd4rdcYpUXp8e8S-p14gyksuZJRs8A	2021-07-21 05:59:04.050872+00
inkixiquwt8dc6o44k25yhiijl2o0l6b	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhChz:BiXbZKhndJS49zNH4Z7RuuXif6GkMvtCv-lZr7kXlug	2021-05-27 14:53:03.575197+00
65eli1icdfuotn46d30673cf96kzzzgr	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU2Y:dot2OtcJuOKhsb7kFqAdYnn7vLBOpEr2Zs2wQSlfVVg	2021-05-28 09:23:26.181492+00
ws0791vavzhbfxvsdefifw4tbqbapv57	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lho40:lnYHZxnEor_8_JISt_vToT7J612oiwzzxFlFf8CZZ2A	2021-05-29 06:46:16.253782+00
k95isyth51u6o0j3jd6ilxenhopsugyv	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUzV:fYJetazxDJrWY3Zu9wCdp61XTqJU0NWzP7Xy3Hq3iYY	2021-05-28 10:24:21.535246+00
84x9mjpgkebbhlxkxifkj4vxd4mnl2vs	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj4SL:d_s73Jp0tw4jBbmN8B6H-fbIX8ru51Gb6T8tV5x9xJw	2021-06-01 18:28:37.319003+00
19lb24ca12kf7v1wcumlmpw8e34h8ypa	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhZuU:uUNtTkgS4S5tDiMbQrCvfpCowhtEoP7fEIO3WE9CrTo	2021-05-28 15:39:30.727619+00
ez0h4pajjkxa39e4ovq774dd89pryg9u	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhywc:o9WmXj9soF3ar4bjuX8EFndLjOhLvX8ZXA9e7x9Gi44	2021-05-29 18:23:22.14291+00
28ke4l08bmlkjynbq893acpwwtoo0v7j	.eJxVjEEOwiAQRe_C2hAKAxSX7j0DmRlAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xSuIsdBCn35GQH7ntJN2x3WbJc1uXieSuyIN2eZ1Tfl4O9--gYq_fmgcYlUtJAevCjgICeO3ZKzZZaabBsAGbDBFYz8E4ZamwRyY0Y0Hx_gAJ_TiA:1lrY2C:r_8pjCWCFD_04xucWjVC61kpIZB5fspk-hZve6_BfEc	2021-06-25 03:40:40.544046+00
gm5zti4snau6ppgv8s72zaphze2iiit9	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH6b:IJC6RMBMo3FQClIQKSB8PqHnEss13pCpYQCG5BaNqMM	2021-05-30 13:46:53.51471+00
lcbfcd723cl7c6cfkuc2p8n4jb5henz0	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lq6G3:3RhTmr9l18D8hqWo2A63B61oAOdNGCacFDuWREPnbJU	2021-06-21 03:48:59.248868+00
kt6ge7e6fy7itxuekqgafp5l0me45xwr	.eJxVjDsOwyAQBe9CHSG8wGJSpvcZ0PILTiKQjF1FuXtsyUXSvpl5b-ZoW4vbelrcHNmVgWWX39FTeKZ6kPigem88tLous-eHwk_a-dRiet1O9--gUC97nbzVqAdPGUFFyMLbUSQwoDHlgEGMcTBSGhVQ7pomg4osopUaTBbAPl8AIDcm:1lrHQB:gO7QZfg6G9V5Q5COqAuDgL5YoW3WlIYLJGd9Q7ujdkY	2021-06-24 09:56:19.011959+00
mbfhdam93nmju9uf6ef4q70s2g4exdvi	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrdAF:lwK6jqZyqRXZUT5bIntHTCvWN38ZHb7cyiSUfFnpDe4	2021-06-25 09:09:19.647835+00
okfviynbpaisadmhniihasjhnwsz76ug	.eJxVjEEOwiAQAP_C2RC7UGA9evcNhIVFqgaS0p6MfzckPeh1ZjJv4cO-Fb93Xv2SxEWAFadfSCE-uQ6THqHem4ytbutCciTysF3eWuLX9Wj_BiX0Mr7J6YRaGcoUVVI4YZ5cBEsUwIDSFsHlGbPhbBFnrcMZTCaMyA40i88XA3o31Q:1lsjA0:8gwRGMjY2CQ-Izxbu__rvqa6cnmcDu864ZV7v4cNLn0	2021-06-28 09:45:36.220792+00
w22qg04x50luke7ad14lp0jh644z6m1m	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCiC:VaI-CPlPo7BJmBH1lqmMAvfMBvw9BjvkgB7eWKkLQ3Y	2021-05-27 14:53:16.573047+00
2zdxt78btidjo08zx7y7aufvb0jzhb57	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU2u:Gfeq8VM7Q6URY6zIQ3PcZTGvHGOX-iTCxIidJf9WdqM	2021-05-28 09:23:48.583891+00
9whcucixkcr42ovu6sbzdk9tigaz7unf	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lho4D:oLLknsvFRRFsqgn8qBcNmEGf6l2It-SoDExRSA6XirM	2021-05-29 06:46:29.475885+00
00xhqqffh9r1hcw69t12yldhu1qiaua6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhV2x:DcGerH1Bv3TBbgjkBg85aBYN-eY9OFAez1qwA3SkxKM	2021-05-28 10:27:55.435129+00
jqcx585vzf8303w5sqrm4c3qt1xjxuog	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj4Sf:79a5ccO_tR3tNSPgSo08u9JRGo6hRnQyLkNODG6ZKEA	2021-06-01 18:28:57.654962+00
b0kdhbkfamhxhxmyh4bgnz18agspsg14	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhZvJ:It8RoLe3CFuDK9bdzTR4plGFo1JA1V19AUaQQI7wH_4	2021-05-28 15:40:21.801894+00
38ytuncmscmqzpccq03nr3cy2ve6rpcy	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhyxr:0aTQyH1FR8uZZkoYKUGu-G8GPE_2XrN--QPuHoMrEfA	2021-05-29 18:24:39.83725+00
z5tu9fb1fu77jkkmkpf0ugeg0konvn2e	.eJxVjMsOwiAQRf-FtSEw4TUu3fsNZCiDVA0kpV0Z_12bdKHbe865LxFpW2vcBi9xzuIsAMXpd0w0PbjtJN-p3bqceluXOcldkQcd8tozPy-H-3dQadRvXbAYdlqRByTHmlTKyKiyJ60sQWDywRSwPgTrUgBPCZRDawGMcSDeHwgKNyQ:1lrY3a:Cq9eefm9CvvNG25JKvitrOwmHp8tbhE2_O2ftbPdg_Q	2021-06-25 03:42:06.538279+00
x3bszuidzu4mu4839sph7y3roczsf48e	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH6k:uA1T5eddQIG0Id7lr8NEovzq-wPK8bI7R3ga1xbj0L0	2021-05-30 13:47:02.729372+00
yyw47ld93d6f63r1wlndnwyanby4ynvm	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lq72h:tHfnoIjxk4KuTxVdhOjjkHnOz8cOwImIjfxkKuyZ6O8	2021-06-21 04:39:15.658412+00
awzy8m2yx55egfxcrr6hd0q0jzra93t9	.eJxVjDsOwyAQBe9CHSG8wGJSpvcZ0PILTiKQjF1FuXtsyUXSvpl5b-ZoW4vbelrcHNmVgWWX39FTeKZ6kPigem88tLous-eHwk_a-dRiet1O9--gUC97nbzVqAdPGUFFyMLbUSQwoDHlgEGMcTBSGhVQ7pomg4osopUaTBbAPl8AIDcm:1lrHRB:dRV9xtOqlcpMkE47dy_Hisu7hgbq4RutHntmSH651n8	2021-06-24 09:57:21.845095+00
p23iws4uokdzxg3hn826pr1gjwif3fzf	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrdAQ:1ArEK4aja-0UJbrJZiEgvkRXVOkDd9HuRtz4FrnstgU	2021-06-25 09:09:30.659646+00
tfbnwatjxdlh7vqpsbhukwkomq74km2n	.eJxVjEEOwiAQAP_C2RC7UGA9evcNhIVFqgaS0p6MfzckPeh1ZjJv4cO-Fb93Xv2SxEWAFadfSCE-uQ6THqHem4ytbutCciTysF3eWuLX9Wj_BiX0Mr7J6YRaGcoUVVI4YZ5cBEsUwIDSFsHlGbPhbBFnrcMZTCaMyA40i88XA3o31Q:1lsjDs:HePxbVa7JIQMdyWJbwi7WqUG3lKS2RPRSkIxmbq14Ic	2021-06-28 09:49:36.806636+00
h5jelsazzp9pfrpm8ei5rowchizwtiv6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCiP:5Ghx8ks661neBmqP5cBaTPXAchMb_Ehtm9TjhLtOeJA	2021-05-27 14:53:29.328094+00
g0l8njvubnvidg8synbs6zqgblvg7iy2	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU40:XMLnm3QmBw50M7AoKoUWbsqf7t1WZB8q1gDxGo02cnw	2021-05-28 09:24:56.827638+00
soeqd0bn0bahqcriuoyvjscfn4nq5fu9	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1lho4N:KLoIfu1x_T-uEckc0uHO7ogZwGmDDUH7R2_jaBc-2nk	2021-05-29 06:46:39.769957+00
85tvxnv0rmeciqffih9dyi2gaw157m1h	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhVHB:5dcKWVfcY8s6E8rBcSv91l0FKMuEMMckSqBP4YPkIfk	2021-05-28 10:42:37.593402+00
m0xpjyn6hce4notaj3zpk0s8p3ot2g9c	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj4TX:vrBrEYdow9FInsEli9AP6zLi6Nx0BDSgTlm00VmOSBw	2021-06-01 18:29:51.56803+00
9eveb5bmingx8b7u5cyhyt52y65p5i31	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhkX9:spSozrqQcbbwym0buwqSryr9EL8_Ah0T_b4cZqaagd0	2021-05-29 03:00:07.357892+00
rr4mp0mpqh7zjqtyj9ax2jt1c4r38voz	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhyyT:YpUfMjNp2ezfh2Vx6A8tAbCFOhRcacuLcSZFuy1A6cQ	2021-05-29 18:25:17.578035+00
nugko6aos4wcwnlpvb2s1cmda7964j1n	.eJxVjMsOwiAQRf-FtSEw4TUu3fsNZCiDVA0kpV0Z_12bdKHbe865LxFpW2vcBi9xzuIsAMXpd0w0PbjtJN-p3bqceluXOcldkQcd8tozPy-H-3dQadRvXbAYdlqRByTHmlTKyKiyJ60sQWDywRSwPgTrUgBPCZRDawGMcSDeHwgKNyQ:1lrYCs:-h1W4sMcu3e2k4vWNFm1cwe__sORp_n7-G8ObFYtAS0	2021-06-25 03:51:42.551099+00
t4gjj6434l9ly0g0nckout9dj4ct50cm	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH6l:B9pKWLwlQLzdSEcVnU8TlaVgClH7SbZvQ5xQFucnDU4	2021-05-30 13:47:03.322659+00
at5m3k4j7kqm5t5acfpepwsm82vr0k30	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrdJB:TBXYy8-BxtTEgFTUGYpzlZdPU6HyE9Jg3Y_kxxljrX0	2021-06-25 09:18:33.559264+00
r0r0vgu1s59tzihuw2v0mbzo4cxlbpn4	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lq7D4:6b99Uqq6cUJhx-LIQNFxkvC1OvZfJnYi1AOF1wzToTU	2021-06-21 04:49:58.818572+00
285tkd38y4gnjziwt6el91z2hrnpyddv	.eJxVjDsOwyAQBe9CHSG8wGJSpvcZ0PILTiKQjF1FuXtsyUXSvpl5b-ZoW4vbelrcHNmVgWWX39FTeKZ6kPigem88tLous-eHwk_a-dRiet1O9--gUC97nbzVqAdPGUFFyMLbUSQwoDHlgEGMcTBSGhVQ7pomg4osopUaTBbAPl8AIDcm:1lrHZ4:VbKbqLxHaGmRGHxNK4SHG9WtqIy_tbzZZv7xTCyChfk	2021-06-24 10:05:30.404047+00
pqht0e6rrnk6y1yxyb3ooook27t7gffs	.eJxVjMsOwiAQRf-FtSFAmQFcuvcbyPCSqoGktCvjv2uTLnR7zzn3xTxta_XbyIufEzsz5djpdwwUH7ntJN2p3TqPva3LHPiu8IMOfu0pPy-H-3dQadRvrWEKUyIHBGiLBVVQoonCBplVlnpKoFFohVFnhQpskcUkQlGcRI2GvT_qkjb4:1lsyRn:yPEAI6vLa8JBM5KoRJChxxM__lSPpDyf8h9lCAnm1ac	2021-06-29 02:04:59.031995+00
wkjanrjlqg84wctsd1b0sf00wyd5v4gx	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCiX:6d9Nj0VcTG9gbPR_tAfOX4ZBvsvn6DkrXLK6bGtnIXQ	2021-05-27 14:53:37.847889+00
dgpvzfrhasfubt59wdqewjqjuzeey2c6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU4b:5bJ8yif6ZzdNnHjyZV-TmFOghwbNX_W5b3X-HwJC98o	2021-05-28 09:25:33.520236+00
6hs8iqwvazpu10c4ld7eti0ko4fnudn8	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhoPc:IJuEnuHsztr_M-a6gC1BIVZktk9_d2Gd_KRP_oX-p4E	2021-05-29 07:08:36.315003+00
45wb32zm1owlc86nf98rc37w2092d7xz	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhVML:H35cgFERtgLSMikYMjceqx2U5QloFjEvW7vx9TYB5Qg	2021-05-28 10:47:57.918446+00
dhdfzxzunp0jwnl956pzbp8u0h7b8p72	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj4US:VN1V8PdEAFcqfnU5L_Wek5bd_kL4wRyfQSD5ynJK9qc	2021-06-01 18:30:48.561723+00
28iyng7v68spp20xxap39d9fhlpfkat0	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhz07:b9mjVRx9LUKWNRguN19ELntc6GGy_1TPAIDT_O1ybic	2021-05-29 18:26:59.445837+00
juexy9kl4ud0b6kva56r5gj12rs8o8rn	.eJxVjMsOwiAQRf-FtSE8B-rSvd9AhgGkaiAp7cr479qkC93ec859sYDbWsM28hLmxM5MTez0O0akR247SXdst86pt3WZI98VftDBrz3l5-Vw_w4qjvqtnRc-WpmlUZ5K0QAKlY_aOCxxskQEBGiEFUmVDN4hZeOk1BCdNUKz9wcA4jeo:1lrYMv:YHu9yK5UYuvjiCiuXaFuNh1NCKThmJOP7kpBwV-DmCo	2021-06-25 04:02:05.575127+00
9cg1hil99q0tyusi06wsd94p6gt69n6c	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH70:ha9-pmJs6MZSdY0GHm4pVEZaXIomeJXq5bzwSkhi0xc	2021-05-30 13:47:18.819413+00
5xvl7cwpg79eer37v4pyhwdh6zlmyo2z	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1loIFs:H0RYU732Aakvm5rmEwaLJNq1u9emVkpAvCX2SQybQ_E	2021-06-16 04:13:20.457483+00
lbtvcwklwbcott3b41csux5n2t1pcz9k	.eJxVjMEOwiAQRP-FsyELRQoevfsNZFkWqRqalPZk_Hdp0oPOaTLzZt4i4LaWsDVewpTERQxanH7DiPTkujfpgfU-S5rrukxR7og82iZvc-LX9WD_Dgq20teewVOOcbCj8tp5C9zd2WhPWiVyZBzkaCAnVCpDx7sQ0Crn88gsPl_y4jeh:1lrf70:afQOlG0xiPq_BoVlVQRvQvUD9GuxgnMOeery5N958dI	2021-06-25 11:14:06.731839+00
t98xubes2345jrvyt3omcvwp07rb6u6i	.eJxVjDsOwyAQBe9CHSG8wGJSpvcZ0PILTiKQjF1FuXtsyUXSvpl5b-ZoW4vbelrcHNmVgWWX39FTeKZ6kPigem88tLous-eHwk_a-dRiet1O9--gUC97nbzVqAdPGUFFyMLbUSQwoDHlgEGMcTBSGhVQ7pomg4osopUaTBbAPl8AIDcm:1lrIQG:oxmqm50CBAbA7ZtbI3OWoV4Gms5-Zx6CUFFoPKJdaF4	2021-06-24 11:00:28.079394+00
fowigkawwp1ogme0krc508u5wy7pzmro	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lt0VD:UCn3VquuCE559QALngAqnpFHBc66xkim3tCoVcui0Pc	2021-06-29 04:16:39.119384+00
6ppsaossughuk89uxd0mu9ue851kbbty	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCis:gPeRayXnYGTtuEixknBOsaOpw1KbCoeMlaH0eNMCN7E	2021-05-27 14:53:58.358206+00
6xjn71nwrdawfzyrw93uhrhzi4dzhsk3	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU5B:ATKKhEVLSKGZ4_B1z8hy6zY2Gv3-zEOhRo1L--6eL30	2021-05-28 09:26:09.380502+00
qjjjg4deq7dmnqnvpa6wb3oullllzcky	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1lhoPr:uramAuWEkI7wxlYgazHfl0WdTPkhu-Wi9N1Xy4FcB_E	2021-05-29 07:08:51.777445+00
45ge3onn0r39q84me54ssrvrkkhxp65t	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhVNK:lIWgrLiWJHepZ98gQBFDQbJLLKUGVHvuD4Qv3rpRy94	2021-05-28 10:48:58.938545+00
e8w9qvkkagnz4l67hzlfnr0l7pdy3v0z	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ljCPD:8LEPwdJuYZDiu-iRwvJNtLLEs0NlkPz62dqa7mYflSU	2021-06-02 02:57:55.75532+00
gh2b13ryg4pzktq9noliyetra7j08zir	.eJxVjDkOwjAUBe_iGlk2XvKhpOcM0V9sHEC2FCcV4u4QKQW0b2beS424LmVce5rHSdRZWacOvyMhP1LdiNyx3prmVpd5Ir0peqddX5uk52V3_w4K9vKtIXIWb7InpghWjtaLw3AyOYA4w2AHT8FwTuRcyMCeDRuJkGBAgqzeHxTZOJU:1lhl8h:jB3TWvoBUrBKV9lImMa0LLrMzEkkmsS1xtlhONe5tJA	2021-05-29 03:38:55.330792+00
e0icdi4lb9rwef7g5xtmsyax174turk6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhz0g:f1qyHhPS34arGVso9GUOF-X8XZjQ9QeQUkDJ5hVi-Dk	2021-05-29 18:27:34.269119+00
69gij3ufcywgiw9g8msdh615tj9l86xr	.eJxVjMsOwiAQRf-FtSE8B-rSvd9AhgGkaiAp7cr479qkC93ec859sYDbWsM28hLmxM5MTez0O0akR247SXdst86pt3WZI98VftDBrz3l5-Vw_w4qjvqtnRc-WpmlUZ5K0QAKlY_aOCxxskQEBGiEFUmVDN4hZeOk1BCdNUKz9wcA4jeo:1lrYOK:nv2btBcAqBJTyaKaQK5e4PV_XahjLBRpJ36bUx-jbls	2021-06-25 04:03:32.082622+00
k0tgh3yx82e7g8sbcul5t31agmg00cbc	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH7E:86JvLelMOc1K0dYdkLxwtwBKkXjIKA4hzP64SVZVP9o	2021-05-30 13:47:32.58498+00
r2tykblq9b2cbenmxl7nh0xhr18pg16u	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrgX5:4t0z0VDilfVIEcGZrwLugU44pv-exaoGoQvmZtmZ3nQ	2021-06-25 12:45:07.063567+00
mzzqyb9azrzf18iqm01ukhu3eytw5mr9	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lq962:Fk-v4NL6Kt9YxoDhQyWao8zh3uqq8ODuU4VRSraTDKM	2021-06-21 06:50:50.607962+00
edaz2iqjuh1su5x58irluns1s5jjzl9k	.eJxVjDsOwyAQBe9CHSG8wGJSpvcZ0PILTiKQjF1FuXtsyUXSvpl5b-ZoW4vbelrcHNmVgWWX39FTeKZ6kPigem88tLous-eHwk_a-dRiet1O9--gUC97nbzVqAdPGUFFyMLbUSQwoDHlgEGMcTBSGhVQ7pomg4osopUaTBbAPl8AIDcm:1lrIRC:SrHxocS67N4eYN8_o0tIPKqGY_JYM27-dIDwfmqrL-Q	2021-06-24 11:01:26.970319+00
o6do9oust2lqhbeitlbi32byly3j2c0l	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lt7H2:-6J_L4KndblM5vPmh0y1341IMcsmsHbz4eJ5wlv-wfs	2021-06-29 11:30:28.273274+00
8kz6qioz556cdrh8fub6cifa1tkn5sx9	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCjI:6fGnPv-iLxMeD66zb8jQHxzVLojN2ixrI64jjjttVdI	2021-05-27 14:54:24.369078+00
rulua8lcxhjvsrbnhq2cljhemsguxeq1	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU5r:Op743FtFp45MMetdGiLPD-_RmD-Fh6IzksnWIFodYh8	2021-05-28 09:26:51.516554+00
9pe47gby1cwgej9zjbj5xhno2as7nju1	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhobY:angij-3G_j61eCwfDjtpabJqnHZXU-yrU0G7B13CS4c	2021-05-29 07:20:56.37677+00
qt9iiwdx3yysqw22a9if2jwzq8rhg8z7	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhVNc:D3TDy75ZyHaBLm5yjjDBqHtboIJunbv2OMwx-X33h80	2021-05-28 10:49:16.780993+00
tla9oiz2a91uu0bym551xa58o839juys	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ljF9i:0FCUabcctlMDYJN2bET8v_BLBFdYbJRhvwKoutmNScM	2021-06-02 05:54:06.500908+00
q6cbksrenspzuh3nplptur2x38u7dhvh	.eJxVjEEOwiAQRe_C2pAWhgFcuvcMzTAwUjVtUtqV8e7apAvd_vfef6mBtrUOWyvLMGZ1Vj2o0--YiB9l2km-03SbNc_TuoxJ74o-aNPXOZfn5XD_Diq1-q0xYhAAysQxu2icsFgpIKWLfYBEXjBYMN56RuPRuihUmLscEDn16v0BFXk4Wg:1lhlAu:EsaGkeqJHimx7IRpEYkJb-oQ14NYLB0u8tp7WLoifjg	2021-05-29 03:41:12.494542+00
sagrssizvopihfu4nmxpl6c32tnv6j4d	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhz4s:VD2w_vJevD6jYuqop3KSPrs-nAgsg9f2__DbrGX_Y_s	2021-05-29 18:31:54.730364+00
8fs28wzcnsch2jd2w5f1jrgsgi3fh92o	.eJxVjMsOwiAQRf-FtSE8B-rSvd9AhgGkaiAp7cr479qkC93ec859sYDbWsM28hLmxM5MTez0O0akR247SXdst86pt3WZI98VftDBrz3l5-Vw_w4qjvqtnRc-WpmlUZ5K0QAKlY_aOCxxskQEBGiEFUmVDN4hZeOk1BCdNUKz9wcA4jeo:1lrYRA:cxuT--nZB--HgZ9lQ2ZPxsMEX9Ku8dOgKtXLIcejh7s	2021-06-25 04:06:28.099944+00
86uwfirvd12cj40lvt9unvkpioc93e28	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH7X:2x_nyLFnufXyFRzS_0wGgIDF3P2CtnIyftA1vQrwrFc	2021-05-30 13:47:51.080397+00
om6u9lkay0cy8tlcm3leizcjog8orfcn	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1loJXh:SWDVGfpDpG6zI3v-i6-yepGoeyoy4mOyxhYwqNgLpGo	2021-06-16 05:35:49.42091+00
qc7g5dp21cjb21sku8pu092laudhhsam	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lq9P9:G7chQTDsye8yZ73ZsQm2FrMDK70iOgco3QMm2-Ne6yY	2021-06-21 07:10:35.467464+00
qsih15dxfgc4xt2j0dyqjqjti4tb5742	.eJxVjDsOwjAQBe_iGllavFk7lPScwdr1BweQLcVJFXF3iJQC2jczb1Oe16X4tafZT1FdlAF1-h2FwzPVncQH13vTodVlnkTvij5o17cW0-t6uH8HhXv51mxzRAGxROASEGcTMqZwpiGLYwc5sgwOEAEtWiCXYh7JEJCY0aJ6fwAb4zfp:1lrgZS:X87KG0Cuix9pC88Tw0HpltivQ-pM_qx-oqqRVhi9Fjw	2021-06-25 12:47:34.205551+00
4itr052bbum1s1i2j2csyielol506zli	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1ltAYu:_WxN1PCx3EwhJxZn7AUNIMZaRjy-eBUBXE61HuWkArk	2021-06-29 15:01:08.442016+00
itt8yrta8ppezr3c6woks9f73kc3wv0a	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCji:Fbehhhv8SxK4rHLFMpI-ON60Xm24dw5GDJ93_ctViuo	2021-05-27 14:54:50.856031+00
1o2kxn02fg11nl0zv1n0srn770v2thhi	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU68:AQfyPZ6NRGxCBb6MiS4WQ9snFk_2lrqzfBkGs4X8vmE	2021-05-28 09:27:08.894462+00
dxlttxr7whiu04nz96focmbxcxuwxk1m	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhobh:ZG83zjkW1F_Wz4GRAUbTPk2dG0lfQ_JNQ58-MrdbuPw	2021-05-29 07:21:05.801194+00
a3hynh5saphw74ds2ps6y2nds8nfc4lv	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhVNm:jbRKaqocbtL3I5U1yYor0g-jyy7Oo3zh4sAhwff8vBU	2021-05-28 10:49:26.976587+00
bbfwrbe3p4zc9kmyncrgqt5ydqu4v60y	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ljMs5:V9Bqk5QIIouk9OARs5Xnb8akJNkEDLHRhOxxr2xJpFc	2021-06-02 14:08:25.318245+00
ohqr8fvw0023z0o90x2d1e3il4eij2ru	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1lhlCj:nt7z-E_kLC7u-KMqM50e5dnmXOd35dnoXeAmG9XlNY8	2021-05-29 03:43:05.303619+00
g0sgloleaf8ga6r4ete0egpljos37pnp	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhz5B:1UjWgSLNoWtDQS723fgjMLtw8KJgcrcdU9MvqPuFx_4	2021-05-29 18:32:13.768338+00
dtmme6kj900bspgztwjik0xcc1mlfxta	.eJxVjDkOwjAUBe_iGlleEsehpM8Zor8ZB5AtZakQdyeRUkD7Zua91QjbmsdtkXmcWF2V69Xld0Sgp5SD8APKvWqqZZ0n1IeiT7roobK8bqf7d5BhyXuN0HD05ND7QOg5UEptY0VcsJ1HaCOYFHtiw4lQdpEInLFWQgIynfp8ATqbOZk:1lrYWE:CsBsXyQOgxGYHPBk7jL1uQXyShsLwOgHdgUGG1JcVmM	2021-06-25 04:11:42.045931+00
27sxa8i0omim5gw3iv2c9nao3ha8dpmi	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH7Z:eWQDgd5jfEOqAqHY3JZaa4Drf50-mN7MPMlgjisGNDE	2021-05-30 13:47:53.698289+00
j5f314yrcsw4o7psdjjariy501vwms88	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrghs:KN87BudUBa-H5UF2HER4jxP2p-1EfIz6SzQqFf4sC4o	2021-06-25 12:56:16.169326+00
8wz4e78ajkgfby8z9c7ml1y9xb8vqby6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lq9PJ:VaKw66qbtv2vquu4glFRD5Pa5TMZQo4geEh_vN1BRd4	2021-06-21 07:10:45.789077+00
qu1qg3837svpmtb6zpd3zhsfe0aaevh3	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrIUM:Jn-uCckqJXHmaf-FNuwJSFiPkf3hF_nd1Bf6yrLo_UM	2021-06-24 11:04:42.640502+00
tzzxvhmj26jntkqxga5l4xf78z74k0j1	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1ltAYz:j5xOS-8g7TM4CQcLPVF4ZI8lER8oLOi0tWiezjYsyOY	2021-06-29 15:01:13.737328+00
g460vqiwhdhjtq2lhw6419ypvmgrasr4	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCk0:OtMobZVFrewywjbrNWm_klQXPM45R2BbKBiM30D_2ic	2021-05-27 14:55:08.046233+00
whdcilmks3p52j6q9lt6ls3wprulo15k	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU6j:DcKOdUyrwBIdYDz92AlYlN5CSgmtpJCEcR3VEdzPgaE	2021-05-28 09:27:45.233052+00
2su7355x3mg0upy473x8ghvb3p2weeuy	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhocd:wQQOi1km2D9cH3pnujvbCEMJFsa4rOL-prvZbVUwJb8	2021-05-29 07:22:03.234648+00
875bj1tla749u6i139f7rufvwduywusv	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXd7:nAZbU9vAUS_T8EsNhynuZiHznrMeufd_AHvKS5gPlss	2021-05-28 13:13:25.631572+00
47sl18mfbwl1qxh11dj8e6s5cubjq03f	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ljNdC:g1ymOuanss0b19L4mx2NGc4F5Tc_7X9lHQ8tn_MUb_o	2021-06-02 14:57:06.578209+00
yundpxjim0qixwp885j6n7e94lms3yur	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhlVW:jl0XiltHcKwPalgyt1lYbQ_m8-ZtIDWHkLGDEDkFqTg	2021-05-29 04:02:30.577472+00
jqrgx8qohicxksruuhyyumkshsayl2n3	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhz5i:H_qVlKwoXnU1VnaoXtvsmDvLiGl7OAlyBr2HwVzH9eg	2021-05-29 18:32:46.025595+00
hh91i10v0w2x7jcty5c7fuqby6ln65js	.eJxVjEEOwiAQRe_C2hBaQMCle89AhpmpVA0kpV0Z726bdNFu_3vvf0WEZc5xaTzFkcRN9EFcjmMCfHPZCL2gPKvEWuZpTHJT5E6bfFTiz313TwcZWl5rYNVZj56QPQXbg8Ng_ODY0uATOMLOKGMBjXLIOmi9EmRWV83oFIvfHy0dOQc:1lrYaq:kmWY4sMTLh3TdFFwMChfdm1tT0v02cjQWB2Dsh1e_IA	2021-06-25 04:16:28.456111+00
quc107iuvg7nhn8e7ai7ag7s1yusyd9y	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH7b:YXvAB6VwRNPp00F_KJYJW6TYHfWq0W_JYKaw1XtNbZA	2021-05-30 13:47:55.725342+00
1kbo05j7fa1clyw7e213hwf2yki4ggbi	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1loeRz:QUY4c8qJecx4WjiBKTukdlyTzL-K0IwvXm1_rCNxmzI	2021-06-17 03:55:19.754168+00
wsfft65ll4g3jxrxus2k5hwpfzbiidu3	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lq9Pd:hGEbxb3Vrr-uixwLL5CyAqtaSrhRBHC9ivPWPTWSXZk	2021-06-21 07:11:05.012923+00
jkc79j9n0kzblhkm9dq86dr2cmqaloe9	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrilO:VL_CYsYlUdeumhX3iBZ0P4JJlw4HGduB2oXO9uKrEQc	2021-06-25 15:08:02.051948+00
65o2uzrztca52gr2g31liw5op94k6jbv	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrIbb:257dI80C7fMz4-DVNFU3F9oxfK5uUCtUpFPdtSWTLmM	2021-06-24 11:12:11.980498+00
ggxtfd4i7d0m65ucv3nc741anx0xxvne	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1ltAZH:1wVrsVhHKpkWnpcdLzpLB2kMy3AmTWsZv33ZuXxF6bE	2021-06-29 15:01:31.513912+00
0ryiatq7javm2fptqedtrs4zifse53r9	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCkD:7ladxKDzVpvGKZD7WbksaPzIKNfh7OZilOle9muiCnI	2021-05-27 14:55:21.486259+00
va75wd9f1cgbci7y6hgrlo7ei16zjojz	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU7V:TlB-t_Nrh2RGm0Fiv6At6-kpMt5oWuVbc1729-1Wv84	2021-05-28 09:28:33.393199+00
nv5bmyii4w30tjmfhbr6sgxjag48cf0b	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhod7:CwA0EVvj-fW77SBkPMTNCvtiho8v3sL9_PzTnqkKdeE	2021-05-29 07:22:33.175927+00
6dzj6xspffeksoaje795vf12xikc8llz	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXis:zdaoZdFOLjClfpeocq9oFi5HNKQ25SmWBZnBrtkRdok	2021-05-28 13:19:22.213317+00
z8z4g62zd0z64iymhgokaoqc7o89a9j7	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ljiPe:AwNtkfcRFkwa4CMTxgO9RHFlvkfAFmItUd2YRoD8N4U	2021-06-03 13:08:30.297957+00
zuyjj8izaq3pusqebnthbahejcmkzza6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhlWP:Nc_e9OJV9X137TC00O2_lMTSg2Fqj94KJI5AhQkkiUk	2021-05-29 04:03:25.849221+00
tsw20y4fmnabj0p4m9yci0iqs8r4k554	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhz6O:KflzBb1MGzYbb5Hog05FjIe9TuVR-ulgdg9xGKNjg24	2021-05-29 18:33:28.667685+00
uw5a8g7siw4erf0gioo33jt8irz3q6da	.eJxVjEEOwiAQRe_C2hBaQMCle89AhpmpVA0kpV0Z726bdNFu_3vvf0WEZc5xaTzFkcRN9EFcjmMCfHPZCL2gPKvEWuZpTHJT5E6bfFTiz313TwcZWl5rYNVZj56QPQXbg8Ng_ODY0uATOMLOKGMBjXLIOmi9EmRWV83oFIvfHy0dOQc:1lrYi5:nhZQsL_sCBkVMAH8eH1MDZ9ByHzj0GOE1kl5IVdyzhU	2021-06-25 04:23:57.027109+00
cxqw6p93jymh2mapo5q9a01swakhdo7z	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH7n:r1ZOm0eKgElMyataGyn_WhkYeiGBODr8t8wyVU9gD9k	2021-05-30 13:48:07.000842+00
1d4rfh53dfxhqgclkyos6dsglv43lbgy	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1loeSJ:GphTYwc-oV76KyiMvZFH86Uejb-G9xvKWeP5gG_E1lM	2021-06-17 03:55:39.488044+00
lu12p0wv1hdh0zdvqh3jr14sfmp0lsa7	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lq9SA:CsklXuEkq6SSIJ_sXP9KRRkwvqeZoAexZGW2Zb1iDUA	2021-06-21 07:13:42.756552+00
8lu6cvc762cdtkmtm23aw93jfqdya2r8	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lriqD:Uw0EGGMpdTElOqD-85ho0Ni-v9FUOHfH4fuBnGQ9OYU	2021-06-25 15:13:01.560015+00
ou8irssagq57nsvhex6o7tueivue7tox	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrJO5:awaLeHW73_K0DEY8CIl9NQQlc9MfOR5qrSKgXbsSLfQ	2021-06-24 12:02:17.896542+00
y0qp3436hhd1vc5ymov5vtjb62p27n2y	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1ltAZg:zy3HdiZ3AyolofC_gi7DUePmyS6-Kw36C3acR7GH9u4	2021-06-29 15:01:56.074854+00
w4hruwh2u6zx3s5pr6om1t2b23rtzysq	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCkN:iOS45ud0iiwSoD09eoMlBWWTdAThqCmvvV7wgqT4c18	2021-05-27 14:55:31.210475+00
qawk0kweuima00aqw3jd8fhnmz38vna6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhU8k:yKLfQohhin0BH_vEKCwZeAuqgtSZQ00e5zRJs_iltrM	2021-05-28 09:29:50.598237+00
4k28aqn4lzh7d0h1es5lm2atytwdftnp	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhodJ:Qp1Hao7ycBJzmyVJqMB2t87spT-7la0XLwRx6BbGoqw	2021-05-29 07:22:45.799632+00
x5vzquii57gdh7r74qh51edf5yr51dec	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXoW:Dtf3XEPJFe8ziXvGh3AADz7x7rW5PH9jx6EPxVM6WY8	2021-05-28 13:25:12.892092+00
yda64zz28slnx9vxvcff5lx4iynm2upr	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1ljiSx:UJ-dNS2Qwz-UXxlVvtfcuaAAmyuQf-yFF0cfQv28lYQ	2021-06-03 13:11:55.935532+00
ku8gb12tdea4cip76pwlolnq5r8nh2xr	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhlXH:GuJJvKfGRFCPIAgFnv4No5WzaD7Ut-VBT--K-uzkImQ	2021-05-29 04:04:19.183183+00
4w0oui2q462abdgv9hgrd8x7q3qwhukl	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhz78:IChfbQsT0QmGyJ-FpiAaRdWmhLolPDq3hXap1VabZjY	2021-05-29 18:34:14.10632+00
uj5p9vn3bj39kj7mks3w5k54s6ldoenc	.eJxVjEEOwiAQRe_C2hBaQMCle89AhpmpVA0kpV0Z726bdNFu_3vvf0WEZc5xaTzFkcRN9EFcjmMCfHPZCL2gPKvEWuZpTHJT5E6bfFTiz313TwcZWl5rYNVZj56QPQXbg8Ng_ODY0uATOMLOKGMBjXLIOmi9EmRWV83oFIvfHy0dOQc:1lrYjU:g-8SRc7TLO8ujR7JXG6EZdY-AkFD4xGnXKfWWGG3WPA	2021-06-25 04:25:24.408711+00
4bboiskblu2wwby69g7sgpfp691pekxk	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH8J:c1qLN6p4VzJTNDQ73_gHIjkqQpujnvRnvmeaYk9ojL0	2021-05-30 13:48:39.104242+00
fedd6pwiare6bzif0d44trs4msrg3ot8	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1loeVt:g4cu4m0AC44HJCgFY09e8Ll0N55aFzX1xBVaaBRSzLM	2021-06-17 03:59:21.312424+00
umuj3z9rkwsus6qhqi1yle03g2w83jox	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lq9XJ:ePWrUwzfJb9olNuM95PA0nPAL31yewzo_-KtQ8V5jPU	2021-06-21 07:19:01.402208+00
6geew1n5scmwy67i7ne1ezamyreyyojd	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrzel:zMWWPTtlZUOWLLgAD2bGvo3Uj5ppsgc6t9_0woEmR_I	2021-06-26 09:10:19.723514+00
2oq2fdzxb80yaxizj9rere6veup4an3b	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrJpX:bKxjvKF5bHlHjvPu6UPjGt-c6EnOhIRSn5vE5qWNsx0	2021-06-24 12:30:39.106627+00
7em4gfcqkp38nms2510rmtxuvixbit9v	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCkX:GDl91mbYVmZQsICwRCxZWUnDgm_KkN-jcLd6mWrJA5g	2021-05-27 14:55:41.39624+00
0pxz7nj093n55iy4qifmcsfqnaw14lwa	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUAJ:EvMeshJZfqGD623tqeBZLLRY3eq2cMX3_8h4mgPXJ5o	2021-05-28 09:31:27.50941+00
hper3fh4ahlaeabwz3gkhol8kjbnsbk6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhofP:HZ75kJgnVqv7PgTfFFfd-EN7itwJVcFROGRsJYhXETI	2021-05-29 07:24:55.063491+00
7jashob5rumnnktdn4fqkqg82q8gjo2m	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXqj:NEgp9P3l4ObXKbxMwRU8rwv7YBG8zZCtsxsGE9EWKEk	2021-05-28 13:27:29.785923+00
nqy04pryn34csfkh5sxexi7z2024z77l	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ljiVl:YR3dEkN9UTZ0QXNE76R45abS92XmI5Wxa7yAAXXbP-Y	2021-06-03 13:14:49.675673+00
jipntu8xh6p6mp70bik4igmsq2o1ynp0	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhlYa:JwHW4kPibAIbl6deQelC9OGZKdyuj99GOKO1N4U9wNQ	2021-05-29 04:05:40.850697+00
6lpgo55kjuekevaqldwxipl19qfr122c	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhz7t:v787fiexTPvMxEB-1QGu-6dzw7u3xrEkeCtOTS7X0EA	2021-05-29 18:35:01.811053+00
xlq2o41375bhomzc303ixztf39nxekcy	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrZ7J:Mg6C2cl8yN4pTRvUmIVy0Y0hGKeDnmTzGvH5p0Q7APo	2021-06-25 04:50:01.599484+00
taz184fgv4q1l4u11t54rf891y8njp5q	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH96:iGW_MSJi1rZ6wSFw6hu8RtBSWvWhsyZJnkqwVKvzM4I	2021-05-30 13:49:28.572885+00
828ufv8rj76hjcbx8ry7i72m9kkps4l6	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1lof1Q:Q4Yz4aVwT7wrVstEJJfg1kSMQkAVWSSjWnWOwEXViNc	2021-06-17 04:31:56.519797+00
fj6nd891mdfju2vr9tdy75rcgisau2xh	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lq9gs:EtLd85gF-eVuAlaQhNggKESAAkabddmfed-3FSTIYyA	2021-06-21 07:28:54.775643+00
wudfifnvbk4n4yw3opb35cmzc8afmsa2	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1ls1R0:FObPG-zlLk-AK7cKcDPx9edYNESok-6lUn6DrQZYQOE	2021-06-26 11:04:14.308289+00
hkdq8yx0na908a2azogf7aw5ym1x73hy	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrJr2:2Zygh4S8ysrsH25qdlc4XyAgdt8AQ1NFL7MO1e6HnKM	2021-06-24 12:32:12.838648+00
ovnlrss440rwyqleg9bhxb036le896vk	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1ltAbH:hEqU-j-aihV6kCEk8QfevKH5woPt2-d-HmdhfPJhdRY	2021-06-29 15:03:35.528595+00
6uw9n7hgkhq8ht6nf95odf20a2dzukwg	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCki:DJ_Ch62lm1YfSkbHzCNJC-v0b7LmIdSRMq7fRi20QH8	2021-05-27 14:55:52.755836+00
zfmysqenukkcm8q3cd3p4abbefmh12e9	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUBr:fb_n2YcAKIAHQ67RTnflLhTiJfKk4kbrYq6ksXG225k	2021-05-28 09:33:03.915058+00
1fm7396g9jmhjgivj0nrktto65k079ep	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhpT2:2pUha6xaRxZQ3QQRyAPbPgTIUXcw533okPDYXbqz2Q0	2021-05-29 08:16:12.634679+00
rr8onoczz2y8k6jwc22dy299wykkpznc	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXr6:AJ_hCNOPKD8jLaGG-e0dx-0L5doPqvY8A3ePI_VoKyg	2021-05-28 13:27:52.287923+00
py3hvx753elpo80yyy7cfggekdktrpvf	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ljn59:MfkPf_3C-SpH_7ld3yA40tElHnId_1IvzaogPxOSwwQ	2021-06-03 18:07:39.811538+00
xiudq68sxg0vazwixqne0jm7yz93wcea	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhlZr:PdsezFFZ3sbyLVq5sIDmMlCjbG7muHUAV8SVkrUuKnA	2021-05-29 04:06:59.318487+00
x28e1i6k8pfyj4z54md8dr1torbf3u3x	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhz8N:ECrhLy-KUZHR2G52NLurjnAy1RzkYv3Hd2f4NyIgYII	2021-05-29 18:35:31.047482+00
g6q8v0zj744nk8jz53s5gqj7k2e3aaz7	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrZ8V:-hVodMIuEiXvCzSQHGhGu9PLHoLAeEtYkvlZxWfjUro	2021-06-25 04:51:15.383913+00
kakkgjjyr71sb0cz0pgksexr3q0s6k3m	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH9n:TKDjkKPl06oMzcmvm6ElJD27zg69Pql3jb-oCoJJOK8	2021-05-30 13:50:11.764347+00
d6nlwn7zuujla2oszjfqfdbh7vjyqgb4	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lofLH:kksrvc7T9C8pDOzc6DcyAmPLsOcD95RxhZl1gY6kYvM	2021-06-17 04:52:27.213003+00
xs2kqg1nu6x6xoxv48gr201338pf8q2s	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lqE5O:Y5vPN0ZnmkLTeK23rWFF_VXw2j6ABqsoD96w1EBIUQE	2021-06-21 12:10:30.497763+00
sq4u951mdwmsx5d0yp5np561huqcry7p	.eJxVjDsOwjAQBe_iGln-rWNT0ucM1q4_OIAcKU4qxN2RpRTQvpl5bxbw2Gs4et7CktiVac0uvyNhfOY2SHpgu688rm3fFuJD4SftfF5Tft1O9--gYq-jLt6hhKSENUY6h5bQWPIZvAfSMXmaohQgNRXnjYigACZdhDCYVFHs8wX53jd4:1ls1j8:IlG6-95cq_thCLxFudxbypQDhibS-kLY2yM3Ux-7krA	2021-06-26 11:22:58.423611+00
svxscas3zuin37jnh8n83e2gj2pt4kyd	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1ltAdA:iYpyYj2sIgwC3t95yOPtMeA-OF8kiD4wsOKTwfeu2Y4	2021-06-29 15:05:32.27813+00
hecgnpqix1jswfmfaf6z0b3zksath7q8	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCmP:LMetJahc67dB3FNYDH-y0cZqmVCBTZfh5vGsshPu2N0	2021-05-27 14:57:37.95606+00
9q3wsvttemo184t7j6x9ookfgs9eirmn	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUCD:AbV3Gr1LkLxulL3PrfIGwIvo3cP06vXf2keCdYNHWk8	2021-05-28 09:33:25.024617+00
xs02ygf15pgycccehvs1s75rtx5ddldk	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhpbb:qcOR8sDDyeDXJu_cujgNrR_-khcIzniPiJk9_FCw5SY	2021-05-29 08:25:03.340102+00
hrflvhgdp084qqxw1gs2j1y2t2vfsg1a	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXrT:C8aZwfsi8yZDtKuLMWCdbq3u_9CvLEJ1SwhGZNU8yIc	2021-05-28 13:28:15.481069+00
krt7ize1gqy7cb8kz1tz0zncrptzc2aw	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ljnB7:v0TjP8fTBCFhEmy4CM84nJye7-c9a1K_5_9_wj1FSW8	2021-06-03 18:13:49.736528+00
bwathtj08uk5rntdpjn76ot2deb9fd6n	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhlc7:UjvrkBWzgprounen6tMbNHo3oJPBysSGIT1tHCRP_9g	2021-05-29 04:09:19.136914+00
pkrpj8i0yqwadfs17yq2kk41oad1wfzu	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhz8j:HkvXuIWnMtyoRl-Xrcm7auQUFB_xGhQ6uCOBe7urO_k	2021-05-29 18:35:53.910691+00
jocbhdaz5j7pjo9wgpcqx4zd0d31v21z	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrZAD:BE7Eb6G3ovHndCQOj-gHlvbtj6eSR665FaYS8o_gW44	2021-06-25 04:53:01.294865+00
uog8thsnqnuc7wodhssi2988w6afcol3	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liHAA:mV7_2eUbHlIWk8QQylupdFEXwwEBF4LTSkfXCtIu-dM	2021-05-30 13:50:34.293483+00
9btpy2rc2rblqyovsgqjpqxki6j52lux	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lp1K5:zQlh6tmGqPKOvefltuDH7WJ9_Xrl7OsQ0UaLj_CQ_a0	2021-06-18 04:20:41.647071+00
k2cv2d4ildi9w3f9pdkdtnpoziq4x7rh	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lqY3o:bhjSqieVtSE9xSJGvyGrTelWSXbVy5kdOM0ch0CXr8M	2021-06-22 09:30:12.315667+00
fvesv72gaidyasv5uk34s5rpoflbko0o	.eJxVjDsOwjAQBe_iGln-rWNT0ucM1q4_OIAcKU4qxN2RpRTQvpl5bxbw2Gs4et7CktiVac0uvyNhfOY2SHpgu688rm3fFuJD4SftfF5Tft1O9--gYq-jLt6hhKSENUY6h5bQWPIZvAfSMXmaohQgNRXnjYigACZdhDCYVFHs8wX53jd4:1ls1kb:JMl_QlkbwCrTW11ntJUi_jz5Uk9NqrocGg5bw_7WYDk	2021-06-26 11:24:29.705482+00
j1uujzxld9jems1qh83uyp8fdok3enw1	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrJrq:SW9DF6qZFkDNXZ2sZvq-edmQWa9daDkz5Wq2nDWxUqs	2021-06-24 12:33:02.12802+00
kjzakwbb8wt6lg9kep24mh9xevgtrgo0	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1ltAdq:ImWBUxOd-ig2menmN26lnDZjN6N7OYMi4Zhph2Rk-Vg	2021-06-29 15:06:14.101047+00
uzrdbipfnro1e81cgptiwb61ckmo9jvv	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCmV:Ay-t9mYBSyA-wDcsLLS7BTYem2dyrAh5xPzC5TJk2X0	2021-05-27 14:57:43.268425+00
9r1u50pgf5b83sny6phxz1dfbwofwfcm	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUFX:1bLVD0e-P-ias47fiR4cUTHcgm5Zta9LHnSJRawyWBs	2021-05-28 09:36:51.886427+00
kd2etqy6gd42na40n0djpr2okrdswfdg	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhq2U:i_XnaenxCZLI32PpcXRt1C3GC_ABggq20G58l54uRss	2021-05-29 08:52:50.150111+00
pttvn8ub7623qrflmvqh9ro0pkkjvlrt	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXrb:IDk_Kovd0ZYsdrXmgVJw7fU0_svua8T-mcta5so7-xs	2021-05-28 13:28:23.000601+00
outpi3ukoywwhdzgb4asiz5mojy2e7wo	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1ljnGX:v86jj0zB-c-uXN6FIFaMqZUOpCCLb438IBbwGdToK_s	2021-06-03 18:19:25.148631+00
rxpgt6d53a0sarvf2tjnmtqzwlppwjy3	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhlfF:_vGbMHBV2aLBk4DSZxBOh-0p5vr7fngF-WbYp7vtM9U	2021-05-29 04:12:33.082003+00
j07h0448mo4dhu3udnhigpg2gt9m3kqz	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhz90:p7Xgiczu8BHlWZT7cnFEH0_jtzO2fqdsOAFZ0yegCs0	2021-05-29 18:36:10.122929+00
qmu9po1pa9kbjp0l19tv8saiz9w4z0pv	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrZGK:ysWAhxA5_uVZK4hs_mlrgTfVSSLVfJgVjEvKyDP8fEw	2021-06-25 04:59:20.635435+00
oopsi0dfz00gslt78mhmtuoqhxp93gb5	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liHBS:IkqTA9ecTp8kIoRJHcvfHsMmmb9HMoTTYOrQXW395uo	2021-05-30 13:51:54.480889+00
u7fps5vsktx47r70ubjjiw7augu84u6w	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lp1bF:fk0Zp279RROa8ViC_9eZ8X9ppSves0fsExYoX7j5ZXo	2021-06-18 04:38:25.2439+00
i7hmdywrrvz18c49rl0nqm9jbj1scdb3	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lqZbM:J4D1wi4U7BwS_iPl-Xj-dUQGWBfywUg7vnmVxdfXGjM	2021-06-22 11:08:56.562783+00
fn6qcjip8a4fomc4hrmbo1fsry3jygns	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1ls3NK:qz9F9Ao98KuTGY5q9XIq9Kw6S__MhfitQUSVufNcsl0	2021-06-26 13:08:34.862089+00
45izibp9akqo3isngygo6dw6kvtn0t2z	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrJtz:vI98P0UrIAedqVJ932kr7D643ew_iPMXpj4R1LbcML4	2021-06-24 12:35:15.928454+00
vcb8sp8aaafltcsez3hzei4v9kzpesac	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1ltSNN:CdgtEdRV_ZLGCxoM9cgAA_ImEtahYV5fjxAdcIhvfWU	2021-06-30 10:02:25.341445+00
ha6ohw180f8o2fbbjs4jz68nz4r32uun	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCnG:Vstch-R_UWfvz78V_Zhm7fb8zG2m99o0bIZL-xwwmgI	2021-05-27 14:58:30.319874+00
n76ehctifyrlcs3cyf31tzqocn49e2vz	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUG1:54EDqxH_9DQ6ws15rQYyoYZ7cu7fF9iFuJyAR7uV4HU	2021-05-28 09:37:21.916009+00
xrx2zbdn3asanq2klka0db3zbzoief4m	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhq2r:UEpD3TFgurSUWArXCkKki2Gg27ihvgus-r-pjUwqRRo	2021-05-29 08:53:13.514296+00
722ru14kg52bkumxyrra32jqvfsbeanq	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXrn:PR4nl0bw6dn7BGjcTo9C6Z0qIAXKyAFHUZ6Ogu_ZBx4	2021-05-28 13:28:35.611193+00
9own4v81i2kbo5hme4fu6pwjregjbccx	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ljnGx:m5p9HD7jfWkTxANYFKPbIdXD1Ait6JRzYjGal8HW8x0	2021-06-03 18:19:51.707748+00
mvi3g55uvpv8kqpnsec8z2qrmpes5688	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhn9M:zmn9l3pLJLHCtlAXLAz7KDAfpRB2aLTTBKKm4jxrSkE	2021-05-29 05:47:44.463505+00
xi7cmvx8w60t1dlfgormbrd5mw3ecr4v	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhzCV:Iflizn0UdKKwx4Z9Dr1PgtzsgCKKRX3Fxayvo1r1USc	2021-05-29 18:39:47.697218+00
kbz4eiitwl7mobjsaqbw8u6uvlpi373a	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrZY8:zeRG0QAGfBTqGg7m_FEnylJw28iWwYfb-nFQKWa5N6Q	2021-06-25 05:17:44.351434+00
ez8gc261i62vkojcow3b9w6y627tbwml	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liHC4:pIcbzqG-bzwSku_yECq4RNXU_l9IPHaWko2_d1Vf-DU	2021-05-30 13:52:32.52287+00
c4kfi7rrlecc1ojzoucnu5alnciuttz4	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lp1cc:z1evK7w6wg5YqjkgVc_CQ7kgVdeEBYURXcXgiyd2hJo	2021-06-18 04:39:50.231268+00
qywmop3qlclizgl12fue0aw6xwegdu3b	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1lqdHd:iK5jpJpwWrLyiEC2SsY78Dzp_LU_-9ZfvuNdqpdCTao	2021-06-22 15:04:49.507836+00
gb3n4zz5h6elj8osg18nunmycd1bfk4w	.eJxVjEEOwiAQRe_C2pChQCku3fcMZBgGqRqalHZlvLtt0oVu33v_v0XAbS1ha7yEKYmr0EZcfmFEenI9THpgvc-S5rouU5RHIk_b5Dgnft3O9u-gYCv7moBNznZgVJYtdNhp9Mmxi2x6MFb7TKgUDB7Y7jw511OOjFaR9kDi8wUbLziV:1ls3Ry:vo-vC3e9ScC4a9LnQehvIHqH3Pv9xvR3PgW-kXEKvlg	2021-06-26 13:13:22.218786+00
q013evvlgb3qt515ajdlu7dgyj4int4q	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrKPd:1iWGchD7PH1m-kgab9K1wAGZtwkNG4JctZ52n5de_cI	2021-06-24 13:07:57.759774+00
bz5zgiuhzxr46pd7o5lx1i3m2ftuy4gr	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1ltSU8:Z-peDqzaeJ84R50C063DfpLE_a6slNGzw1ffrnALm0o	2021-06-30 10:09:24.827636+00
g5mcstbvouy3qvwj8tg6tu2sohsfi097	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhCte:o4iJsuAoedD_m7fMUl-b-hFPnxt788KNfzeRMQZxuSU	2021-05-27 15:05:06.248309+00
3yxyarkchvyfmxldarourqka5ylwlokc	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUH5:hd3vadd9FNka2Tiv523S4UfnmrFC0ln_BI8e94NHNOY	2021-05-28 09:38:27.864331+00
ye7gcgratvtvuab7b9fcaf0a4ej9exkj	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhqnw:WNUHH_a5sMw523epeIUVh_t1kS8SPux5oHNm4lTzFHI	2021-05-29 09:41:52.7481+00
apd6h6u4yav68goz0u3rru01zw61u30g	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXsU:j4ytzManeCHMntdmbCBayJ_SK8qg7GYXGO1DI0xw7TA	2021-05-28 13:29:18.320267+00
bmnla9qmhiigfhdgf6wvxbnb04kn4hbv	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ljnW4:05ugP9UP1-QG0-8m1caL3PxNWixltjTpK0ahE_LX9iw	2021-06-03 18:35:28.707716+00
1wrgclwfd1ajfccnmni8ne8p9o411vuv	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhnRL:WyGLYXedS5XTKqzaFqI7wQh-OL-CLYJGBiujLELoDSg	2021-05-29 06:06:19.689191+00
nsxfglmd5buamps6nm82d88vbjfc8jlw	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1li7Ns:XWji-XUQwX9gRQ1SZbiRqUydqhfGMSuVRivQqdv5sAs	2021-05-30 03:24:04.979768+00
h4tjxer3o6vah7rg8kygzypx9ro3kahh	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liHFc:aiYDZ5b5ElmP-qMy2XVuzdIdPJ55BqwruLwj-nP6UFU	2021-05-30 13:56:12.827396+00
rx361kkaxr4onbcoonjpvtbc230tx59d	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lp1kH:etdzUf9MmH9iB31ilJ4jBuJ9SrXu6TNRBTkQcOfEJII	2021-06-18 04:47:45.273365+00
buso23yb980q9en5k2omkwr8keqmbgze	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lqdhV:h4qBvehGuXrnXpz4TDhOfmwR4EdQMXEtyq6c9Cj-P4A	2021-06-22 15:31:33.06538+00
379vrvx2vachc9cz99xhwg9h5aolehqb	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1ls3Ui:-UQU0TOtypPWwReyTJAy2P020eo7xrc8hVFtqzoOXlc	2021-06-26 13:16:12.366583+00
2q9hossjrfboupv01aicn584oe4h3n0o	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrM4r:iqW68d0BjWpzDnPQ7ZyXYKexmAGw8LF0Dwj0UOURQko	2021-06-24 14:54:37.413707+00
szrg785oi2goixfg6z01c2l8sl7ch0zc	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1luCks:d97RnbAf5nIYqXWxcB2CElSorz0GB1sDeCuuxjw__Gw	2021-07-02 11:33:46.870789+00
7lafr9q7dkylu31fewz0u934s9zidhjd	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDCv:h9u7IR2e3UTBgK5Z8msjVOdOZ-S-V7fIv1zwT1O_QTw	2021-05-27 15:25:01.478317+00
rlzedtfx4kb2c0j73wlwbch5jmi9f9si	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUHY:FFkSA6L1b5zuz8w-yZal5PNzMJi0XAX4Or29MT_DS4I	2021-05-28 09:38:56.036856+00
w6j5pbn3efz6qkrhawwrvi5ppw1158z0	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhqwr:tcp9Z9XXcJAzqu577tH4LHL41UXlCIyqaNkHCwbUD94	2021-05-29 09:51:05.397477+00
cbckrystslxehgmc3tzaceod2bypm868	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXsf:b0qxyHkd7lT3Nhx4l44Yk1pDx_8kGy0WzCKaOFIv_dA	2021-05-28 13:29:29.605719+00
yuaxh7w3kwzpturecr4onxwgeqvofgnj	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ljng1:wE1sBfLBMZv918jltmIkdKUkOEhx6qncmJ1QZkUFocA	2021-06-03 18:45:45.945096+00
wkn2siu0x4zvgweytlwng56mv1ag4gaq	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1li8tb:-VY_Y7mE6MJOmzKpyHSJ8pdGXdpO6D1d5FYTjK5OduM	2021-05-30 05:00:55.71806+00
nhm8g6d3t0rdcawfdp9wqou4k9tjn5hs	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1lraKA:_rEQhHMlk2g0ZpATHbXR5gOJ0gWhCHgbG24F95GfDRc	2021-06-25 06:07:22.503285+00
hy5uf7506ifyilgwk4umvfo2zu69xaj2	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liHH0:EfYIDMIqCSztARf_b_6_k3rMUeZl50EuXRNoDvvatbo	2021-05-30 13:57:38.869908+00
nqb7x304628xs8ei8loy9ggg723i3b5f	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lsIZi:lrTfDBVKd4W-tQzxfjb85FSMltbR4HVlObuFDWrQ4EI	2021-06-27 05:22:22.789082+00
u6qovrjylzaupjijo93p6vhxaj2z0cga	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lquGl:SgdZqwTyP-CpMeQOnJOWUWfBsvMGPZQ4aUxCjQQd8S4	2021-06-23 09:13:03.661242+00
f67qt5kuk0aa16mjv04e4lsx6qwqd13y	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrM7l:E0cR_t54Lw2uozJ8xxybVaCsAsyZu4BvJTQrjDAJXUk	2021-06-24 14:57:37.217435+00
o0m2muwi0207mnsiq19xjrdhcb44e4jy	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lyDvb:kKO7tf52w-AnscDi_lJv-7tbpSI89C7TWuM0_a5ZiL4	2021-07-13 13:37:27.181395+00
0co5rpvcel725lylt1v1wj54vpuclm16	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDEB:OTZEDTKJElp--FFJmPiqXh5Y01o-9yplLfUd-4lFuN8	2021-05-27 15:26:19.129999+00
968224umq64lp736iwfe359geqvdzf9h	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUJD:atnnjOGwsPmRJbeA1bSO458og2vveeQDKmLx9n8gRWk	2021-05-28 09:40:39.127007+00
51vos2s4e71d3ifenas3fl2jy85ubr8g	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhqxJ:-UxEoqOuHVqCc2_lILrAxSWO17IUnvFF8f5Kc5cgpgQ	2021-05-29 09:51:33.264207+00
m2aifovkxf855l8bp4xjl0ahb700s24c	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXsq:A9cXt8FWRzk1OkE2N3uW0WgRnb54WRrI50n78G3wDn0	2021-05-28 13:29:40.588028+00
uibdxg60hq668cj81cz2unr9z647mxb8	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1ljwV0:biBduXE3csyFtqFrEbjiWZAJQRrbL7Cqy5aAPlRP6EE	2021-06-04 04:10:58.347566+00
kkbvjpzr08jpzj0612cy1xrkdkd5uqc4	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1li8tu:3GHGQNTQAezPqQ_kcJLKq-Q_zSpiladLpBs4L43snrM	2021-05-30 05:01:14.156821+00
bj2dy031qd9vw7g28opacmmy7rb8zysi	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lraKc:End1L5Xb80fd9zvUrqylMEpAof649KkAzdKbMNxFoo0	2021-06-25 06:07:50.833737+00
03rsfi3wmgvwvjyzpw24f2vynkarfv3y	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liHHb:8VPdXTaVzFEPIDAxp_Uac90ytvv0D6VHDJi0C4ReAOw	2021-05-30 13:58:15.583805+00
29fwzhrbb97xirlamxwp7jtr47cyb3iz	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lp53g:rzzE7o8frJwSwn9ShiC2Qhi3yjczAOojwQrrbfjEkvM	2021-06-18 08:20:00.966249+00
g8aztj5ckynu94xmqkeqau3hfdqfig4h	.eJxVjDsOwjAQBe_iGlm215-Fkj5nsNY_HEC2FCcV4u4QKQW0b2bei3na1uq3kRc_J3ZhyE6_W6D4yG0H6U7t1nnsbV3mwHeFH3Twqaf8vB7u30GlUb91RpQOVCworEZwJlmEKEhLrcAUyOfoQKRsNTiB0ihNqViQImipiIi9P7H7Nqo:1lquid:4Hz1jJC4A12xcDw3VAe0L4uFViV4hswwZ2eGEJKG3hA	2021-06-23 09:41:51.251529+00
20fvaabewosgi6u4q64ycly3dc1ndtke	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lsLWF:VXsUxJW7kJk2FpOAbGZ_yPmSPpcoPqCcLmDVIALoP1s	2021-06-27 08:30:59.331419+00
4529ynnurz3oxy3x666v6bguvzsrury2	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrMgF:gFqzWSEQsYADAe8sJcf1Z52pjswaj63v876kLjAUrBM	2021-06-24 15:33:15.910073+00
leeq24pt4b3lu65480tupkh3rttftoqz	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lyEW2:49wdur5zehuEzjN4lA_A2The-3hzo3Bvxu3gemPfR2s	2021-07-13 14:15:06.71543+00
bbvgxdfr0elpigfla572ghpwxrjx8xj9	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDF0:KjMrnSRmmTDbmSv3kLxaZB7suVQMOsFv9OAWo504D6U	2021-05-27 15:27:10.249758+00
9jf8tudtnf1anv8k34y140yxt3p4sh5d	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUKM:h2BeYWra_AWyhfcGB-fhQL833ERIrJLSwBk6QepuNQs	2021-05-28 09:41:50.574002+00
jcx48kigs2onk2o4uloconz95wxp8u4o	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhqxR:vmDiYr17gx5BcdfmBQ36kolcPFUjrVEw5y7Dp_Thwxs	2021-05-29 09:51:41.360983+00
bv2mzk3ozeh3hdtuhs80dgvo0tx5dg96	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXsy:yJIlWYVqBGRiP6XcQp6oUYxu4GWgnTLb9ZM601GRafM	2021-05-28 13:29:48.630532+00
dxvizsn65csg5q4v5buk7ogromk4ws4l	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lkQkm:QywkoCqTku7I333hQTEADBoihYpDx3ByAwwEyroqNV8	2021-06-05 12:29:16.859022+00
qaj9ac9nhgow66v2uq1lswyb3wx2x1el	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liAF2:8lVPORz00ylwcKEiftnIEushAxP4bQZsaag5-ooCzKE	2021-05-30 06:27:08.77291+00
1h8zvpzw1a2sqmdry6re3q6478p36rf3	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lraNl:d6nrZIjwPzJfxgsAu7m4XrBuPBQYhK8wP4_VvY5yByA	2021-06-25 06:11:05.606119+00
4bgra0ntxo6uexwq1fhvhr623ecbj0zc	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liHK2:9Omaa9qsFsUixJIEqEsiPbfK74rAf1yRfUFPAB9-ZbY	2021-05-30 14:00:46.136617+00
fbj94cjwfg7f7b03l7hjblcrlx78394d	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lp58I:ZbauGWvsPjLQiY_bWEhCKd3bymIxK_aMlt3ODExKLFw	2021-06-18 08:24:46.021917+00
82i55vmaad5wyiolszqbz9kb7hx3ms6u	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lyEeZ:DtsBtb3lYr1cWdtAWQCO7j873G1Ms_Ur0IBTCX0m0wQ	2021-07-13 14:23:55.334074+00
zc8enkjcvlaioluajlwe5k1bdjehvskv	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDFz:TODQYqA-3o6UGVpuF98CBRpDQgfbBsol9lt0tERis80	2021-05-27 15:28:11.552066+00
zuy4rskmrrolnxgh3eixwzqzgtwp4agv	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhULQ:2rB_6A5_bRYRsSwG6Ky2huJ88cSoSnOWk50fr9vQSTE	2021-05-28 09:42:56.466412+00
mdq8ebwb5vkuc840tk6wtluje7xabts6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhr8H:gPUA4PSG5cYLoByiZi6LvUbyXoCFNqpxdL-kiXVk52M	2021-05-29 10:02:53.162326+00
ya2b62vb4wjh0f2ucturu6lbakg6k2mr	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhXtT:72PTm4zgF4zQ8Dwb4gtTKyj2AAXBtdCNuQ2Gr7urM6k	2021-05-28 13:30:19.014381+00
j8jzwz6y33knojs77s6fovdwbifc55a8	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1lkhse:muMi9xQms8KTDx56BY5lHZyY8Z-37FTRq-7gj6KeTms	2021-06-06 06:46:32.236963+00
0sgd4253wj031k0kdy4icwlp0wyszazh	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lho2F:yBmKyLRJc77CjLFUq_h7hREMw3u9Qf-Pv0XtrUTQyUM	2021-05-29 06:44:27.290235+00
up7pg2yak4tnswfpn4cxhkgibf1lw9zg	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liARs:FdkRvkRiUwQQoyKigVrW2bdWr2trIjWY098hbEQpAHs	2021-05-30 06:40:24.527904+00
ew6rqtk7o13fux5jt6tdaf5be4ym0dsc	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1lraiM:ba3dpGNKYTa3RqgwM_IlDqnGDdHHOoarsQ1a2CgnuxI	2021-06-25 06:32:22.400501+00
jd5g417lhqe9xvxopb6uvvcgqt5khdzx	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liHOc:_iVH6GRkcGyFAUxbULeBUAfCFrsZc9bKbbzlv2XUETU	2021-05-30 14:05:30.498172+00
5pwcuv187b8k5lwmksbbzt729qds2zty	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lp5AB:nhpWouRYj2sTPb9xeV0NqB9TMhlZuWM8FkaTwt3Cci0	2021-06-18 08:26:43.846998+00
g83d8e6m4dwl4mttzl3c3k60nowep8br	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lsMEj:-_JIJpufUeNrWJ7Id2nhkwDm1MxhEaSr2nSmnTIIoBY	2021-06-27 09:16:57.491073+00
cnszpjn6l0qklv7qf9da1zckqxiz1ivv	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrXqO:o6MKd4lknTJ3z93Km641kjD1SroCvgNWCt-mGyTz1so	2021-06-25 03:28:28.484669+00
zfxueoasae64aqaa03qzdly61o92ow7i	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lyY6k:_MVVhuwQi3s_Yq8T92cjBX09WLsCwkovOMTmLnNqNXs	2021-07-14 11:10:18.154134+00
wekj6jaqjxthb5yhqricmw89c3thi24a	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDGh:bqfMq-1YK4WjINwMG6Q-qMiROZcPXWPj-XI9vur0_sY	2021-05-27 15:28:55.197731+00
oxz4yb7noh67c43bobd3zd7xu74ef7ja	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUM1:G6Y7Eh3mlPAjh0YnZezcb68l_ivVVFGfKqsnNK8auKY	2021-05-28 09:43:33.226983+00
8ugnpg40s0tzu859f0hnwa9qx0rcr4tl	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhrHt:q1BGOR3LecKQ_icsbTOU_25pIg8NHy3MD_KDgccIJxY	2021-05-29 10:12:49.661115+00
7tpm5z73an2jqq66u4xm7x7dnlbbo8hj	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhY0R:sT3aTtCmabMOdU_caGmb8gEbSSb0C20aLJUh49juxHg	2021-05-28 13:37:31.377685+00
gtvgm1lf1bztz91ly6r27p69tv9yc3ql	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lksnx:LmFooD6lK55Ds5ltYyrscglPDzBRbe8OzRZ_xZfhRkQ	2021-06-06 18:26:25.653943+00
yj9mldbs55r47g9h2s3loackodrivrfl	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liAga:Yp0rAZQ7NZE8eYRPrLc509Tb8dWOYKxyd_UDEwOhVBU	2021-05-30 06:55:36.313424+00
c28y4ra9dv8d9zqvz5m3eb3bdwur0cke	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrak1:pvhq-1D9wYkHc3YPpBpaHOEIeP19n1qMBhCDvZaLK4Q	2021-06-25 06:34:05.908995+00
fd9oeq0rftfopj1sajjauibwzamcrvax	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liHPY:ok6iBQC1PZjWRFkCfPraE02qe5b_878pQB66ZDAymAk	2021-05-30 14:06:28.361757+00
sh6b1odwvtsulg2zkacmc37nnzi0ivg9	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lp5FD:yEX_fRUsjjxGzrg3_SnQW8zbHf3CvQLsgdPv23Wcot4	2021-06-18 08:31:55.400256+00
h6sc18045dtqrsg6o53e0fhfluj7aagp	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lsMa1:3YRpa3GnHXMQZ9WrNsmCMgd66xbM9porAPgHqs6FFEw	2021-06-27 09:38:57.106881+00
jms4zay9p9rix1vth1epbuhtkava4nt7	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrXqs:IzSpj_IY_DOuDq8WZ3vwHBXFuYtaDsXnDu3qnDR0cBg	2021-06-25 03:28:58.377366+00
ov2d4s3mfnrqrjfx40o4577oxzizdm1b	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lyZHD:P24Dh1Mj7BR3cjriSntrG6ARmX6dtVKaSZBc0rZF1ZY	2021-07-14 12:25:11.394608+00
c1yxp41efqg3dntqwigbgtoyxjkn1ze4	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDHi:zrdXAglHwb_LXCmm77DLX2_x6w_6vQOrTL842glxriY	2021-05-27 15:29:58.531468+00
1mzta19tjdq2ap5nvft63svmslzuc1o5	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUMs:ks64HxVvMAFmyWjT3ZB-q3HT19XgGvQ7yMTC_5prTJc	2021-05-28 09:44:26.792956+00
skjf1tzkicero6mrw8uxru90w74md9gn	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhrN5:lxAOVtzyXjk3l0Z77RX7Avv34TEgeHkTXrKSJZTmc6c	2021-05-29 10:18:11.282329+00
5q8k23casc7d194ehtaa35mv6pt0t500	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhY7J:AmzWY-gvzvE6VK7zB-pTiGNGnFSjMQZGQiVCZIQnwCg	2021-05-28 13:44:37.734124+00
a8u3qxghjru5wqmhroj43688qkc4yknm	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1ll39b:L4kqnvNINY3H6m4LkHlejmY3fFsVaNGgxSP4qKT9PoY	2021-06-07 05:29:27.125669+00
b1kp4hzbaxc0tbgrlkvwe3mrtgtd7zbp	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liCVb:hbHPqqR564XLxaWyeCssjlB1Ozt_hzvVozwe7bhl-n0	2021-05-30 08:52:23.746769+00
e0brja1nm85if01sspsgg0gtvebfqid2	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1lrakM:RL8Kuk2bQk2uI06X2Gs8mnW6w5cPZEH52Wquu77tIZ4	2021-06-25 06:34:26.272703+00
05mg1qla1bv2wuy3kpgckmbk9shvb2fk	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liHPs:DIMTk5aESYiy7gYslU7o_a75uudggTRPrBqZh2BjWAc	2021-05-30 14:06:48.852811+00
12ep5urx3cyw5hj392fvfizagu64n50p	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lp5Gi:6aVckvH9Lu7nfWxV8LONIBi-HxeWSDT0pcFhBHrQXqM	2021-06-18 08:33:28.267702+00
eqp6tyyygayqtnmqp7lyylijzx7b296p	.eJxVjMsOwiAQRf-FtSGUNy7d-w1kYAapGkhKuzL-uzbpQrf3nHNfLMK21rgNWuKM7MxkYKffMUF-UNsJ3qHdOs-9rcuc-K7wgw5-7UjPy-H-HVQY9VsTJkMqZ601KihGTYWklgasIxsEuOCFByOzIwFKFAmIVhcTvAoTELH3Bx66OG0:1lsQqI:1V4HSYqMdoZMlyYiDTW4etm9W_0zyXUfL8lkSL91wlE	2021-06-27 14:12:02.906543+00
99d9ng8l4wjg85bg308p2avv38pp1mky	.eJxVjEEOwiAQRe_C2hA6MAVcuvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEW4MXpd4yUHtx2ku_UbrNMc1uXKcpdkQft8jpnfl4O9--gUq_fWpsBrE1x8NpQNMoTIMLIWJIvhrJzyToFaMyIWfGYi4MEGgGYYkEW7w_q9Tet:1lrXsE:StAfHf7GbD-6lyDFhuSKyo_qNhvb_-Xd6RlkddPWRQg	2021-06-25 03:30:22.774804+00
l0lo37dhwomsyn4r1mddbgj9p1t4mkrf	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lzY80:jqjys7s_noQsCWOrdpP1h1LeLdV3hojj2o3FeKNqJJ8	2021-07-17 05:23:44.968597+00
lul8ko2g06tfcvwo1kyrowx45dkpsnai	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDZN:ec7JA2C_DTKgQ8BVG_IMnZkuGNuFH-hdCZx589hW5j0	2021-05-27 15:48:13.56243+00
9e0a0sh2l541fjex6p7l9d9qvd9p3n3c	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUNc:AYNbxPtfoEkyI1HpQ5TdI0gEVycITzV6wx6oy1lAfkw	2021-05-28 09:45:12.856748+00
7rkhljbha78lpn0ttx3puvw3cenburgs	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhrRy:eYXHoR99krTl9LNfbW2l1zP2BcogTj8xFmpUEgNRiGs	2021-05-29 10:23:14.874059+00
r5cbe6274fce5xd5spkt2cfk7rex2vay	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhYIf:i7P5pNGvK-5KReOJumYwrrDfD4MB5r6n7V1V-L1qKJs	2021-05-28 13:56:21.271961+00
8e6oqj38s5iq4j3aqp70tro23xh8bpw0	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lp5HG:fTs_OHGXMay5iUBE0t45YHLipHVK3n9WAr8yilg7dKc	2021-06-18 08:34:02.663164+00
upnr7v0djo1tln8bv7cxck05albmkikc	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liCyJ:H7YU9neSV4QHb2fmUpwYNPaAhTO1w3BkFDazSOvjRgQ	2021-05-30 09:22:03.023762+00
3b3pmfyduvk6hzni6nztvjjoqvrloyfb	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lral7:2tp4_dWrnQDTJPf6PzfUUSdapVy03lfWJbF--8OXPkc	2021-06-25 06:35:13.296367+00
noc9fdzuhxdqfoadn7p25ynsabqtoh3x	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liHRG:aC-tFhiJWxw5qfrggonwO-bPGnP42D8ezBrosd8rCB0	2021-05-30 14:08:14.210128+00
0huyzh40h0qowko219nn8bqacdlmileu	.eJxVjMsOwiAQRf-FtSE4vF267zeQgQGpGkhKuzL-uzbpQrf3nHNfLOC21rCNvISZ2IU5dvrdIqZHbjugO7Zb56m3dZkj3xV-0MGnTvl5Pdy_g4qjfmsrBHgvopPeeCOzVilqARaSonjWjqRNBnNGiwYUQSkFCHW0qD2I4tj7A8QbN64:1lrBNT:Ja0QD0r1lPEOTh6e45OHR5m0OyDzSekYDeB8_PjAYiE	2021-06-24 03:29:07.311569+00
wsdjk681jy78h2aq7t7xpi6zwrbhvg8z	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lzams:Gotd0J4ihNShAZPrbQhF6FTNZndhFfVYad5Bymg6czs	2021-07-17 08:14:06.475135+00
7b7kfp4k7195pc7c8w5oca0rgsu221nr	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDfZ:FMUJ7tWFzcG7UiEx9vLW7HZpEnbE2Q4WqXifdTqzVR8	2021-05-27 15:54:37.430325+00
hgjbz7sbszpaagu1o8qeo3lw0cztyfii	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUOS:yZHxmqvi-15CXzpL4RntehTWuKx_3JeFnBwEsVyE8Eg	2021-05-28 09:46:04.840791+00
h6pukzvueklrccf3rgaupohpf3a86svc	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhrSR:9aaWiA0KL10ysGr_XvrA5wj_q1DLFPwf836QLu-pn8Y	2021-05-29 10:23:43.71097+00
kelbmtidz8y055keykceqwz6532uihda	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhYL8:VGnEJ9U_Z66I-Z-EaUHHfk1E-5IKC0igkEcY2bR7NnI	2021-05-28 13:58:54.453505+00
oxlv5rxpc9w8rhs34j1ql5gk4ag0gd96	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lp5J9:MIkWaqemG_LLoXfHpZSIUf7L4zGh1NtsGytm6YngiI0	2021-06-18 08:35:59.121047+00
cu21v7gfvnq4e3ulnmrmk4esa3vsuiik	.eJxVjEEOwiAQRe_C2hAoA4JL9z0DGZhBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4kbgI7cTpd0yYH9x2Qndst1nmua3LlOSuyIN2Oc7Ez-vh_h1U7PVbg8qQXE4UFIDhQtoP3gdSKYC37IpCfQaLxZEpxhY7sIFMHhiCDVqJ9wcGFDe4:1liDaG:P9qYQM79w3SQJLVHSmyWr8W98O6GZjaWxnHb3kHDinU	2021-05-30 10:01:16.673813+00
m8q7ais8on32ee2w43fzgacqy6vzpkpq	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrb9Z:eiXGTkAOoZff7Tcga-ISR77MbOUVkIuxD9BEjQa8jcA	2021-06-25 07:00:29.826899+00
5kpvqsr9ys8s7d6y709v2h5e6uas46ho	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lixa9:7GlqGdm1LPpX0Krg-MlcHmmgADC10HFX77SyFOeKe2A	2021-06-01 11:08:13.616035+00
wasnrj62r6xyb1loy0qyy688yz4o7lgm	.eJxVjMsOwiAQRf-FtSE4vF267zeQgQGpGkhKuzL-uzbpQrf3nHNfLOC21rCNvISZ2IU5dvrdIqZHbjugO7Zb56m3dZkj3xV-0MGnTvl5Pdy_g4qjfmsrBHgvopPeeCOzVilqARaSonjWjqRNBnNGiwYUQSkFCHW0qD2I4tj7A8QbN64:1lrBWq:wITvEtmTWG59OVQT2F4slrF_-GA94jhTvFTt7YYYOTw	2021-06-24 03:38:48.543265+00
bxunykdavqq4dvv2sh6njk8dv8je93yx	.eJxVjEEOwiAQRe_C2pAKDDAu3fcMZBhAqoYmpV0Z765NutDtf-_9lwi0rTVsPS9hSuIiFIrT7xiJH7ntJN2p3WbJc1uXKcpdkQftcpxTfl4P9--gUq_f2mJRpE2BAi4aJkNKefBs2TsuBhJq589oNUMyaIeMjnRGhZmBzVDE-wMDajfV:1lsQxQ:ye9fV1c28JsfI9Hun5DSKnMngUP3pS7ktEGN0Q6SH3s	2021-06-27 14:19:24.156332+00
t0glrmwua355exe58bkcj6q6ibw4sfjc	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lzbQM:zjd06ErlgzExJuOMUDsdM6nz-RNeNDPpjetm-EWl8BU	2021-07-17 08:54:54.152465+00
w6rkcwcqhborhjpqp3ohsv0n3ssgxnso	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDgm:ttBF3lpq5Ao3Rq-Q4PKKrJamCkHatAamH3UIsTp1jtI	2021-05-27 15:55:52.175532+00
yziw2cj6u8nbyycp7dne0qx8stkfftzo	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUOq:19ByxPRYfjqfrpGB5RJOpol43O6wMW1_1mZTCydF2e0	2021-05-28 09:46:28.930474+00
d4a2rckllio38nwj3djzvlde5rkvku3y	.eJxVjDsOwjAQBe_iGlnxl0BJnzNYu-tdHECOFCcV4u4kUgpo38y8t0qwLiWtjec0ZnVVJqjT74hAT647yQ-o90nTVJd5RL0r-qBND1Pm1-1w_w4KtLLVJNB5OtvQ-xAso3ORnHEXIQYjMZNHtAaRSXLvI0sH6IU3B8SwC-rzBSfDOW4:1lp5kS:kZxhRItISce0UA5YEnR_0-SZX0W1N4QzX972745owtk	2021-06-18 09:04:12.062321+00
757ixdkhp3y2mxrzr64jrvop3j9u2j4r	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhYLW:MU4Z6RyInbzN-OLIY2YASdYBLqQgUVU4sXpudsAkp44	2021-05-28 13:59:18.258717+00
0u2w0pfz7ymc9m45x61cjfjdopz30ons	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrb9Z:eiXGTkAOoZff7Tcga-ISR77MbOUVkIuxD9BEjQa8jcA	2021-06-25 07:00:29.885661+00
8ct481u65pf9vcamx32evp2ibbijvcuw	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liEFb:anboO0KO_XsOPZ6EZQlmgXDqXD04EPUqxE-Gjz5psHk	2021-05-30 10:43:59.193574+00
kbeydyspfn0pmlk784xjidfo5kceragf	.eJxVjEEOwiAQRe_C2hAYSgGX7j0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnEWoMTpdyRMj9x2wndst1mmua3LRHJX5EG7vM6cn5fD_Tuo2Ou3LjYoMKNySTujEVPS5MmpDBSAMns2Hnx2VptBWQzgx8IDFjJgQmEW7w_2rjf9:1lixii:v9N_z5hgk2EDGh7vIOeKsHFEOpUuRgcKN-S6zemOJeo	2021-06-01 11:17:04.141516+00
5z5ysl8htzy4zdlzj7aeb1d32z039xtt	.eJxVjEEOwiAQRe_C2pAKDDAu3fcMZBhAqoYmpV0Z765NutDtf-_9lwi0rTVsPS9hSuIiFIrT7xiJH7ntJN2p3WbJc1uXKcpdkQftcpxTfl4P9--gUq_f2mJRpE2BAi4aJkNKefBs2TsuBhJq589oNUMyaIeMjnRGhZmBzVDE-wMDajfV:1lsR6s:7YDf934Mgf404fzBKNOxGnPCAatpw6xTyExXfNUSdQo	2021-06-27 14:29:10.801478+00
1k0zhjxj3a2yb0xqugpu4yum0c05cxuv	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lzcAi:qNC7espznZVJYDPQQ_3PEU0w0mHxO-VNGy88M92yA7c	2021-07-17 09:42:48.848939+00
a14xtf3bi3aowbv36ljtlmyzungl28hh	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDhZ:SB_zk0XnpZPW4dBd19q_xzAKM0eK6b8rmHqUvCcxJBs	2021-05-27 15:56:41.262877+00
4mew3yiiut1bu1075nos16i7v2uuxwxw	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUPq:nWvxmxXjKEge3fXxHEFvgc6wo6669k4Lb2v72LfjJHo	2021-05-28 09:47:30.926459+00
pkct0lju1xvx4qa52v3woum171h2ladk	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lpV5U:F7dtp12aKcAyMFVHD34zYvEwdImsHsjomXBOv7uqylE	2021-06-19 12:07:36.354191+00
ffa9917x7xwaqp7215hmzqiujfb5y7tm	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhYLd:8X99eY0h6C92OoZ15iD4Lt7ORDDvEWX6-bAY7315kTk	2021-05-28 13:59:25.193406+00
w72f2li5yxounlk6008jqa65if3gffbn	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrb9a:pg_hwLy6vfzkI61gGTRUPP1K8lfqQ7Rtmw_utm2eX6w	2021-06-25 07:00:30.181158+00
y13apvgob6zorlge4lizaupvuxif733c	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH1A:nkGbIGwT_AXoY-SbnZu-AeCVoTWTJ3D3ZIGHXnVT5os	2021-05-30 13:41:16.192306+00
jxs6qt0lhqbj9szl9pjkqmlags1fw5nv	.eJxVjDsOwjAQBe_iGln-BduU9DmDtfbu4gBypDipEHeHSCmgfTPzXiLBtta0dVrShOIijBOn3zFDeVDbCd6h3WZZ5rYuU5a7Ig_a5TgjPa-H-3dQoddvTQToctCFfWST2XJE5TwFp8HYwUNmOBfNMFjtnSuoogrRcialODKK9wc0Rjj7:1lixno:4Avn4tLpFGTlLIaW61k6A8IDzI7xM4FZwkURAwq-vT4	2021-06-01 11:22:20.42091+00
9q2g00sa7umi83ea7bl9buwlzaxu1xf4	.eJxVjMsOwiAQRf-FtSFAmQFcuvcbyPCSqoGktCvjv2uTLnR7zzn3xTxta_XbyIufEzsz5djpdwwUH7ntJN2p3TqPva3LHPiu8IMOfu0pPy-H-3dQadRvrWEKUyIHBGiLBVVQoonCBplVlnpKoFFohVFnhQpskcUkQlGcRI2GvT_qkjb4:1lsR9w:BO_UIaR_NqTYJzkPuN7dg_MLCs5RFhxGhk3Bb84r6_E	2021-06-27 14:32:20.456896+00
5xg29hfubkvbxtca8wnk945x8rr0ojrl	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lzcEV:G7W16WbtAoW-qg7E1AeLFNdIet-4U_0dOkSjCR19kq0	2021-07-17 09:46:43.457885+00
uzjy56ri1d10c040joxd7jd3a4ixba3l	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDn8:AELXJ88ti6Lg52pp9JRDsIMZFnJOmMg4fsUU1W0lDv0	2021-05-27 16:02:26.253023+00
hadi3t1uw7v7bg60tuekqsovjxuhfssh	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUQW:gOraQQbHdtakYvssCQXsAlhPODS78GAC_k5AMEbU7C4	2021-05-28 09:48:12.365061+00
ve2a9bguv9olh032tihkl34z5mrkxlod	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhrxE:h66Bw7B53ctksxVNgItTvYlPAVW7ONeFGU3q-0hCcYA	2021-05-29 10:55:32.501191+00
fdprdc5fezolo18zml2qisuqkrjg1bfq	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhYXG:0OYTSzsMzIxbbW9cGRko4qhCcbpAQQxjws88-qlCLtY	2021-05-28 14:11:26.1941+00
6j9sf9hlrnh6p2hjk8wti980db3pt7le	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lpVDK:L9F5uCMvYbemQ8FzaJ-KUra08KEs0eNcuZ3jPhmGQQA	2021-06-19 12:15:42.042584+00
nccydo0zipquddrjr5v0qssrqtbrt9yc	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH28:YYdFx2WGxct6n3K3P3_JGi_bpJ9W2hEyf-CKLW2JK1o	2021-05-30 13:42:16.514811+00
h7b7kj7572y712ng1v254qx167k9dr5n	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrbzI:mgkeRMmh2LBA5X7S77pBpTYKPx1Zs_R_tJhcOK_xkHo	2021-06-25 07:53:56.035845+00
9f2zwyccrvjzdqkzk7k6iasf0j2i2piu	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj0Ir:kalpNLaGBwbdsW4AsAGKaZGcAwvSqNMj9IrnwMnTOW4	2021-06-01 14:02:33.778674+00
ye0din0ezmyilojaed4o89nqprqn3dce	.eJxVjMsOwiAQRf-FtSFAmQFcuvcbyPCSqoGktCvjv2uTLnR7zzn3xTxta_XbyIufEzsz5djpdwwUH7ntJN2p3TqPva3LHPiu8IMOfu0pPy-H-3dQadRvrWEKUyIHBGiLBVVQoonCBplVlnpKoFFohVFnhQpskcUkQlGcRI2GvT_qkjb4:1lsRL2:rTfwwBzm8fhnORUqMcQOidD9KIW0hQi4g2de3lgaKrg	2021-06-27 14:43:48.923895+00
xvkaeh3xgugzyn2p3wcz80b9x3vrgjdy	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lzcf8:kPQpkfdiZcmhqGeyHuPobRU5ShQlt14hdJj8BB8Nxho	2021-07-17 10:14:14.991421+00
j4e15m4n86zbajfnmuxwn1roh6rtizvf	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDoW:FIQbQbDpXjX6LO-jyIClMRnudG8pRBmwoJoyoh70y6E	2021-05-27 16:03:52.88815+00
3zmmqo1huw4v4g49wu8f6a4hr8gvqnbq	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUaN:hzpXDnGIZX35E0kEYHl1GIwZ9ZkmF_WZFfzq2-4hGP0	2021-05-28 09:58:23.100321+00
orfnux1oz2buijzlgrh116wq7i3wmi8m	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhyqt:2EffrTFP3CBZ1R4twxKTuG0DSgVy1NzLFJPsGnawDG4	2021-05-29 18:17:27.895733+00
8y2qco66syfbqj9b5ft9z37pu7p066ni	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhYbF:ed4Xi0WF_5O3NOLviQi9OOiIo5A578DDsxZIFdIpEKc	2021-05-28 14:15:33.358652+00
hanjkilewb8mykpjr9gyvechut8i51pd	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lpVIf:y7e91c1lr8M91FAW77y1t8ZcbYq5fu_ZOGpZkNGP_Xg	2021-06-19 12:21:13.484743+00
thx2z14y88se9ylhwobixxyqpkzcrh38	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH2m:td8MlCQ7qfDz_MX-6oIRS1fa1mMk0BfOvVXibyKORGc	2021-05-30 13:42:56.784907+00
pb27zdq8aj7v0sm3gu4tia8fppv8j042	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrcWd:yP3RkPE8bOHdiQKkAJ7wiXaknZ496JN1-U31ZOaWrO0	2021-06-25 08:28:23.594644+00
x2hbb2z1dx8hbo5nbc9wo5h8u9c3k4sw	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj0Lh:Pa6GtH4BsmceNfM9kefF2Eo3qkUukNSJAxNs4hgNTA0	2021-06-01 14:05:29.116837+00
1s3r89f5crtw5jot1cn08f4c76cyiqxb	.eJxVjMsOwiAQRf-FtSFAmQFcuvcbyPCSqoGktCvjv2uTLnR7zzn3xTxta_XbyIufEzsz5djpdwwUH7ntJN2p3TqPva3LHPiu8IMOfu0pPy-H-3dQadRvrWEKUyIHBGiLBVVQoonCBplVlnpKoFFohVFnhQpskcUkQlGcRI2GvT_qkjb4:1lshV4:RLl36CBXBxt79H6tkrWFzQvfEg0msFFB2wVxAUTSu28	2021-06-28 07:59:14.080938+00
vnzj8acqchwbfzpv0459m8w1urjstn83	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lzcvp:Jcl1WmLkcLLoGhEXDa06YglClKIF8QSeaLA5ZvEeLao	2021-07-17 10:31:29.998005+00
8i5bqpr3zep10fhro1bruwqwok3gjjpz	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDoh:yDmxGRtpUh06yexIm1GPRQBKiPc7Ser528M2q-D_RAc	2021-05-27 16:04:03.839408+00
g4y9xfnwkyhakcbjavpohd0lu4rfhahw	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUev:mTjXSCT6XBZr59biEwYbYYHeszWMyLYZyRwQpERukCA	2021-05-28 10:03:05.57863+00
g0d3um7k6rt7jemyda6rigedljaorswc	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhyr5:G9MsugK4YBkgHH3ZcrXRaUST7unqeQps2_go5690y08	2021-05-29 18:17:39.098071+00
0l2pwhoqyo0vi5yhj4fzbuoqa7lgsac9	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhYc2:05HERzQ9vYo6b41URSj0ognIYK3GydK8ik-btlSm24A	2021-05-28 14:16:22.901631+00
lzxqian9ea4u4dt0pwj57hmr64a2o2be	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lpVMY:Kj8eeI4GAaO0itoKgYyMD6A4h5cU0kxMlyedBF3vOss	2021-06-19 12:25:14.172138+00
ms5itl8dyw3oq22b1obyb7s85qph5m93	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH2w:r8GVkWuwpshkAWf7CU7K-8T-Lzb6EdPD-mHqzr9xsVs	2021-05-30 13:43:06.208822+00
80wpzmpjzzbj4nss6583dc8kjf9iduta	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrcZx:RHTIWrAtpAcNrPVI67YbXz_VvrFB8ejwdbqK1H_zIhw	2021-06-25 08:31:49.103557+00
kc4gyxcmro4offxy6u00tx0fwh5qrzgn	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj0VR:cyGo82BB7pOhM04UbRHxum4r23tB0uulh3-zWa8RBT4	2021-06-01 14:15:33.637915+00
6iirrg87vmkoo5sunfrb68hihhxqp1sk	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lzcxX:fjdh7SWc4IxjoB8f2wcjrMv4oOiusbPUqP33ulgoWTc	2021-07-17 10:33:15.517748+00
y8xw5h8tw5thlrtq8be4urxuvw4xcnq4	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhDp4:v4CMzJJLMkQoksahbN-7KQ9GmsHBBh0N_7OUq_rS3mQ	2021-05-27 16:04:26.260432+00
xpoup1kndzg6nqfztjd7dgp3c7jqkl5u	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUhO:e3kOUclAbCjF-rCM_KAbZBvMkUrGV0aSvwkQb3WC1rU	2021-05-28 10:05:38.244825+00
elo826lx3hovo5gew8alxjsk38ixviiq	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhyrq:jLDecR9R4wie7aJ7dkUTnZKapw4Y18w7YXlNMwyobgw	2021-05-29 18:18:26.799565+00
aazqh42igrqrugcxax1xif1h1pxt6y8a	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhYdU:eM_j8wILgQyHi_cUgWcMlOTRvkCtQjaGVv5i2UDz2BM	2021-05-28 14:17:52.361246+00
hri0q5hut9mxmmykrhtt0w3o9aqxra34	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lpVVC:PuGWPy5axNbV2yWK7Sjs4ektdRm7uMU0_G3jaEt9S_U	2021-06-19 12:34:10.984166+00
j24841fd87sk5sl60mlhk7xsgehmyoif	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH3a:-Cx6txvrl5qudrOeia-xc_ukNOrnE0Giw258b5Guydo	2021-05-30 13:43:46.01329+00
svc3c289q1fl7ro3gyh5w58yqt1etkcw	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrceK:i6H2puf411jeOW44D23iLnKsOGBu3k6hIUP9HajvyMg	2021-06-25 08:36:20.082697+00
zaxx6fem3bl51wzj3x28pf0xz44ygq7z	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj0Vb:911zfadoOM0sFNfYxOxTMB1lvwLGxL5BTKYL9JgT5yo	2021-06-01 14:15:43.841944+00
4dzlv2syzdrcbvcamghc1quicdnap9j3	.eJxVjDsOwyAQBe9CHSG8wGJSpvcZ0PILTiKQjF1FuXtsyUXSvpl5b-ZoW4vbelrcHNmVgWWX39FTeKZ6kPigem88tLous-eHwk_a-dRiet1O9--gUC97nbzVqAdPGUFFyMLbUSQwoDHlgEGMcTBSGhVQ7pomg4osopUaTBbAPl8AIDcm:1lrGjV:TMzHBMrmlqv2lNYxvbTK9fTxoGmdjzjNiRNZRSZmxRE	2021-06-24 09:12:13.251635+00
pemkezjig0copuyrgi82d8nv2ykzimym	.eJxVjEEOwiAQAP_C2RC7UGA9evcNhIVFqgaS0p6MfzckPeh1ZjJv4cO-Fb93Xv2SxEWAFadfSCE-uQ6THqHem4ytbutCciTysF3eWuLX9Wj_BiX0Mr7J6YRaGcoUVVI4YZ5cBEsUwIDSFsHlGbPhbBFnrcMZTCaMyA40i88XA3o31Q:1lsiFU:L4EZkjdBX64JkHUd9LzYqXiUvJ8kJWQgRYMI8dYRODk	2021-06-28 08:47:12.794844+00
livtybhpxu2243qibvaynnwsecndxtfn	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1lzzTz:rmClsbN2qglKmZf9q488bFTUIrslC9blVxN6SD1wqaA	2021-07-18 10:36:15.768275+00
6hrc2p1yqlj7z8icpdvijub99huhow8l	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhEAR:reswLFqmgarZdlwCHUBuM7YUU3FA585ZOxJlc5VQ8sY	2021-05-27 16:26:31.650709+00
wj7uu79dacua8b1129evq0f4ps1or0o6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhEBK:MHnFnAWKptue9v-VX3JgIkx_Up9ExR6QEBWV6GNBu1o	2021-05-27 16:27:26.078914+00
e7yd16yb8lycmruwv7vjlsfl5b1egb3k	e30:1lsiHx:erylZ3b6Rxs0YlwEDjTf72cgZsvounS65NzWf08GGDY	2021-06-28 08:49:45.113381+00
4iwkb3zbwsg5x9br37lskpa8nk4ra40a	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhEBM:7cxfY2Lpq5bcFywDbLg_4wHeWK7tbcfM8IYc1rWb5CM	2021-05-27 16:27:28.253549+00
xpka1rt0e6l3l0w3mwlaxxu808rof5kz	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhEEZ:vYqHUNDHzlFfIplGxMoVVb1qfLeFm_xnjsABQYJYHYU	2021-05-27 16:30:47.682996+00
d0tx6rp84in4595klunli66i3nxh3i4c	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhO1T:T04xK1bUsBfHAbKYNiTj3sNrEIXCgCPi_JmkD9uxHt4	2021-05-28 02:57:55.92861+00
s8s43xy1lkx0yye8cfsl2urmh4w9rv8a	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhO3v:Agt1OaZG-PD9aVvKAIiqBsODJpAldmFmSEi3JN4iEc4	2021-05-28 03:00:27.022776+00
wrqwv7onlj2bd40y2lcaprxmdkgkc17j	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhO5E:WRJ2a3mmrbMYq6uHYk8BsWMY3apAe7nFcfB4mHNo_FQ	2021-05-28 03:01:48.066377+00
3m7iz5q7fpbs3f2skwa8uzhdhhi9hg2e	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhO7d:i0fT5pa0sU3pZk_r-s2mWqVJn919sIeU5wTwBARGY2w	2021-05-28 03:04:17.999327+00
hf9tdp4cvu0uc0ugelrulvsah03vp7bi	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhOAL:idtdIntMu1ZdmhCxWDz869JAI4k_yiZuMAs5aOQehGQ	2021-05-28 03:07:05.239325+00
auhvhh0nyiqqooy4pk8p9c4idyor40v1	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhODq:7oFEUxFzlgTycDG6NKmUL-AMtO1poCLtm0XQZ6qxl6M	2021-05-28 03:10:42.564004+00
hyqma0vymp7op521h6ptr3re4ge71amc	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhOEU:tOzwFzutYE8wRTkZVNJ1wa6SmmMgaMapbK_GesNMLLg	2021-05-28 03:11:22.574207+00
x6lsk6mu1n8kb6q2bihs0blbc9wxfpk7	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhOI8:k2n73v3gMbo_Sd-EyGPKfkuNOiK4y2kwEcmvYeQPtXc	2021-05-28 03:15:08.285814+00
thaijvxs7hgodccv8da7gfxbu16yxurj	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhOII:IBqlah-GHn-EzPgfQhqktlLLV5HWzw51V0PKBy1gwu8	2021-05-28 03:15:18.658951+00
8w606ohrxq2xscmb334ntpvjmcd3i8j6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhOIU:FTJCluwPssVfC5ERSuGPriRHDrmB-JBTlgqs4EQ2Hfc	2021-05-28 03:15:30.874484+00
3ezyhc7744tlfsjne8jwcrico2ni83uj	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhOJJ:n7klOHEEhvqqyNLVjUPoCgiG5Q5UD2m_Ky0042lcGkg	2021-05-28 03:16:21.146093+00
aswrel7vev93z85eoaeegl28a8q66cy9	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhOKU:O8Uye6cdqfP1-QhYKIpDLCx6Y2o2NE8hNjtFzaqlINs	2021-05-28 03:17:34.949937+00
2icww8h29drfcz1149wwv6t973sltbaq	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhONl:1uwWZgz7Y9zl1Rm_IxiWNN7HmhQjxld0bJO1Ru-0hiI	2021-05-28 03:20:57.756081+00
vm8te78byye5k53ylvjwi9pnfn6l2api	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhOOn:y58tDF163HNvdf8hbUbddpzOH6cNDWlEv96cZ2Qk1ag	2021-05-28 03:22:01.381576+00
mrj8arvdh70u6mjw6k3ewti0ib6bcu58	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhP5t:5SzKPadVWPdCg-MJw50fbSlUGYmceXwUYVTXOJx8wK8	2021-05-28 04:06:33.764421+00
ycl6kaa3sle1rs6i7wk4gnbxiqz8awu3	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTMk:834rZ-bjecGGv0xl4KUly5n-3uVMdZdYl_4L9qdm_VU	2021-05-28 08:40:14.068993+00
mb41tapleo1oaqh59kt7p0i6gz6shm0l	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTO2:PlopnM3V9xtgi58epNq0mBGR95JwnojsBcFlK35zuhw	2021-05-28 08:41:34.190378+00
w547js2uw1ccyciijq5rbvhqr6js7gh7	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTOx:6oRrBdjtpfNmxe9KwxMO03scCpkZUpgqH-il5Tk8Z-E	2021-05-28 08:42:31.628281+00
pb61vlq48ba85zbongzkitbl7jqoje7r	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTS4:XWIZOBqTAI9UNVxUS2xc1ASQO_KgS1VmP_a3BxXg4EM	2021-05-28 08:45:44.893213+00
1haigaexibcwnwmhxluncwdrga1lmft2	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTTr:nqBpyGZHaiCJEkgD7YuwNjOy4FsKhS3suUqO_iU6h-E	2021-05-28 08:47:35.918504+00
smw8sjui64a3mey9igjoo00rqtxo61v6	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTTu:3JiSq5VnJPs4o6hsuJlVxHg_2Txz0SedASTtxJQKuzw	2021-05-28 08:47:38.016158+00
2v7dm053qni7qvpb6j7jymfn5gglzy0a	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTU6:j4N7QCb5jdy_qOMHF0hjKgg3YLzr1kkoK9N73gN2ny4	2021-05-28 08:47:50.153015+00
u7btl3apzznfunw6vekh9wxojpcipw7n	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhUhx:Iv35MDsXtsK6Zf46Nw_oMoWKV7uljThNSUi03SPkMqI	2021-05-28 10:06:13.023506+00
8ud5umw3r4kn082ee31arinf8aloznuy	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTUA:hEKFpoohwmrkIGWrKufGeYHCTwFTx5f0XYbgl8tVClY	2021-05-28 08:47:54.781215+00
7gqskwn7jxddt4uzwrwermavw76lkp6e	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhYdq:B-EBtuH6mQIdAiB6TvPWUP2hkDO7j_OL8YHFU8FKcs4	2021-05-28 14:18:14.376891+00
c1rwl9abmq319yond8bu5xt5pvmw7089	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTVs:0chgatKP9YlR7L7BU5ae4Q0tjemCcHrv7BcsMphUpbg	2021-05-28 08:49:40.237168+00
jp95rhe6fbhfnvd7s9q4e8vvz4sd7y7p	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhytR:EWcVeP7dY5YVgqlnkXZLojHPId3g3C2Hjha6gSGZh4Y	2021-05-29 18:20:05.5211+00
b6t5evm65a44helck7k8tw3d93ownyrj	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTWK:vowjpqBYmHV5OdJ9YHlFvbDS1fLYx-Ni6haTVEKY7pg	2021-05-28 08:50:08.918889+00
kuiwvs2jeg21w68gy3e7rtdgs45ubgbl	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1liH4L:z0QqVcFTwk7PtjCfU9JOf1y06piy4cZXiP2By4dK4Ss	2021-05-30 13:44:33.296745+00
wiwppk0vnjqcji4xukhncdzatdb2f45r	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTWQ:XaW-O_fTpVK7pS5ukRnMyEycv7gaRqW73rzoUB7sBA8	2021-05-28 08:50:14.271146+00
8xif6fkfb9vx746wgugniuy56iomq3zf	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lj4Dg:L7VuePb3i6LOHZbwH8se5qMu0hAU4EHlGdJdMKt_B1o	2021-06-01 18:13:28.464258+00
z7ep5r5pffb6sr88jgm69lvzrd3kwxym	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTX4:MzYnmlrF2byV3Fdkf7SK0QGAkkB5VnWtOCoUEf-jxGk	2021-05-28 08:50:54.281408+00
4zo8g4gy0ubnft60tbjwnez6hykj9omv	.eJxVjMsOwiAURP-FtSGAvK5L934DuVxAqgaS0q6M_26bdKGZ3Zwz82YB16WGdeQ5TIldmAJ2-i0j0jO3naQHtnvn1NsyT5HvCj_o4Lee8ut6uH8HFUfd1hG8Tg4pCguZkldaCIkKCTxmt4VAWpLlbIwF0IWyA0BhXFK2GOfZ5wscvzgv:1lrcmn:vAN-OL_mLE4-T3ShsANkRzCnW4hGTZxCcY5akkTIG08	2021-06-25 08:45:05.510437+00
02x7kw1cigpc5zr5juusphpidoxfv3j1	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTb2:kBIWOiAykDc8lfm9GX_swE3UmgCfZs72qZfQ5vvoGHw	2021-05-28 08:55:00.480936+00
2odpfm2sd9mg2olc1kfdho7z4owpsu9i	.eJxVjDsOwyAQBe9CHSG8wGJSpvcZ0PILTiKQjF1FuXtsyUXSvpl5b-ZoW4vbelrcHNmVgWWX39FTeKZ6kPigem88tLous-eHwk_a-dRiet1O9--gUC97nbzVqAdPGUFFyMLbUSQwoDHlgEGMcTBSGhVQ7pomg4osopUaTBbAPl8AIDcm:1lrGwn:wMA9v2_7OLZK0FXq93G7nPjSO_V1-XLBebXqTQki1vw	2021-06-24 09:25:57.164703+00
pohe6okpxqjo7comhq5n4x9xom2r4zcf	.eJxVjMsOwiAURP-FtSGXN7h0328gPG6laiAp7cr479KkC91NzpyZN_Fh34rfO65-yeRKLLn8shjSE-tR5Eeo90ZTq9u6RHoo9Gw7nVrG1-10_w5K6GWshY7cIXczZAZaKCMZOi1F0jInbZVyIZsRgHEO4AY2CYDPaJSykkvy-QKzRTYx:1lhTui:nh8rsL_MJAm8xkxWJdLwlVz-dwcHWZKaFsoQjGDSNXs	2021-05-28 09:15:20.979392+00
tjte6ye9li02hybw7w40zv9c9uj9hi9t	e30:1lsiI0:EQYQzoVvhQ9LmaxDWalQn846EkA4dsXM__8j6SGx8oQ	2021-06-28 08:49:48.863971+00
09goeh4czuw7ehhcrw0nmrklkxyo9aiz	.eJxVjDsOwjAQBe_iGlnsOv5R0nMGa71ekwBypHwqxN2RpRTQvpl5b5Vo38a0r7KkqaiLwqhOv2MmfkrrpDyo3WfNc9uWKeuu6IOu-jYXeV0P9-9gpHXsNQeyprIAB28yGGtDZBwiBOPqIME6kEiIEVBMAef9GSgMDDUjo1OfL_xNN1I:1m00ed:WoB1ztrGsUAV5gQyMSTdbpUKMlBlcjc5kJVf5ZnT1c4	2021-07-18 11:51:19.241725+00
\.


--
-- Data for Name: judge_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.judge_server (id, hostname, socketaddress, token, is_disabled, last_heartbeat, added_time, max_pending_tasks, pending_tasks) FROM stdin;
1	Localhost - Dockerjudge 1	127.0.0.1:7001	3ueZB4qwf1OhB57ZKddfFAERf7vjQTit	f	2021-07-03 09:29:49.440016+00	2021-05-19 17:20:11.812581+00	8	0
\.


--
-- Data for Name: problem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problem (id, display_id, created, visible, title, statement, difficulty, source, sample_test, testset_dir, testset_count, time_limit, memory_limit, total_submission, correct_submission, statistic_info, author_id) FROM stdin;
10	hiu	2021-06-11 08:11:34.245095+00	f	first problem with a Phúc	hahahahahahahahahahhaha\nInput\nhahahahahahahahahahhahahahahahahahahahahahhahahahahahahahahahahahhahahahahahahahahahahahhaha\nOutput\nhahahahahahahahahahhahahahahahahahahahahahhahahahahahahahahahahahhaha	Hard	\N	[{"input": "111", "output": "2222"}, {"input": "333", "output": "555"}]	hiu	0	200	256	0	0	{"Accepted": 0, "System Error": 0, "Wrong Answer": 0, "Compile Error": 0, "Runtime Error": 2, "Time Limit Exceeded": 0, "Memory Limit Exceeded": 0}	29
1	Disp 1	2021-05-08 23:05:03.277537+00	t	First problem	Statement abc\nInput\nin\nOutput\nout	Easy	\N	[{"input": "1", "output": "2"}, {"input": "3", "output": "1"}]	Disp 1	0	1234	234	0	0	{"Skipped": 1, "Accepted": 1, "System Error": 0, "Wrong Answer": 0, "Compile Error": 0, "Runtime Error": 1, "Time Limit Exceeded": 0, "Memory Limit Exceeded": 0}	\N
9	222	2021-06-11 07:05:36.527015+00	t	sfdf	sdfs\nInput\nsdfsdf\nOutput\ndfdsf	Hard	\N	[{"input": "2", "output": "3"}]	222	0	1000	256	0	0	{"Accepted": 0, "System Error": 0, "Wrong Answer": 0, "Compile Error": 0, "Runtime Error": 0, "Time Limit Exceeded": 0, "Memory Limit Exceeded": 0}	29
7	012	2021-06-10 09:44:27.166847+00	t	Phuc	123\nInput\n456\nOutput\nasdsa	Easy	\N	[{"input": "4", "output": "6"}]	012	0	1001	257	0	0	{"Accepted": 0, "System Error": 0, "Wrong Answer": 1, "Compile Error": 0, "Runtime Error": 0, "Time Limit Exceeded": 0, "Memory Limit Exceeded": 0}	29
13	NEWPROB	2021-06-13 09:42:24.820147+00	t	New Problem	ALo	Easy	\N	{}	NEWPROB	0	1000	256	0	0	{"Accepted": 0, "System Error": 0, "Wrong Answer": 0, "Compile Error": 0, "Runtime Error": 0, "Time Limit Exceeded": 0, "Memory Limit Exceeded": 0}	29
6	Sort list	2021-06-10 08:55:20.221999+00	t	Sort list a	Sort sort\nInput\nin\nOutput\nout	Easy	\N	[{"input": "5", "output": "4"}, {"input": "10000", "output": "9999"}, {"input": "1", "output": "0"}]	Sort list	0	1000	256	0	0	{"Skipped": 1, "Accepted": 5, "System Error": 10, "Wrong Answer": 2, "Compile Error": 0, "Runtime Error": 4, "Compilation Error": 1, "Time Limit Exceeded": 0, "Memory Limit Exceeded": 0}	29
8	1234	2021-06-10 09:58:11.389022+00	t	Aloha	Một nhà khoa học tánh tình hay đa nghi, nên ông ta chế tạo ra robot phát hiện nói dối. Ngày chế tạo thành công, ông đem ra thử con trai. Cậu con trai vừa đi học về ông ta đem robot ra hỏi:\n- Sao con đi học về trễ vậy?\n- Con qua nhà bạn mượn sách về học.\n- Robot phát hiện nói dối, đánh cho cậu con trai một cái.\nInput\nÔng bố cười: Đó con thấy chưa, nói dối là phải chịu phạt. Lúc bằng tuổi con bố không dám nói dối ông nội nửa lời.\n- Ngay lập tức, robot đạp ông ta một cái bay vô tường.\nOutput\nNgười vợ thấy cậu con trai bị đánh đòn đau bèn nói: Sao anh làm thế với con, dù sao nó cũng là con anh!\n- Robot nắm đầu bà vợ, đánh túi bụi.	Medium	\N	[{"input": "6\\n2 3", "output": "9"}, {"input": "5", "output": "81"}]	1234	0	1001	346	0	0	{"Skipped": 2, "Accepted": 0, "System Error": 0, "Wrong Answer": 0, "Compile Error": 0, "Runtime Error": 0, "Time Limit Exceeded": 0, "Memory Limit Exceeded": 0}	29
11	Disp 69	2021-06-13 09:18:33.742419+00	f	Test Math Jax	Inside a MathJax block element, one might use both Latex inline math, such\n          as \\\\(x\\\\) or \\(\\\\frac{25x}{10} = 2^{10}\\\\), but then also switch\n          to Latex display math, like\n          \\\\[\\\\sum_{n = 100}^{1000}\\\\left(\\\\frac{10\\\\sqrt{n}}{n}\\\\right)\\\\]\n          ... and then continue with inline math.\nInput\nOne might also use the MathJax component as an inline element on a single portion of a text, such as \\\\(5x * 10 \\\\approx 42\\\\ whichever suits you.\nOutput\nYou don't have to worry about nesting components inside a MathJax component, the math will be found and converted ($10 / 3 \\\\approx 3.33$)	Hard	\N	[{"input": "1", "output": "2"}, {"input": "3", "output": "4"}, {"input": "5", "output": "6"}]	Disp 69	0	1000	256	0	0	{"Accepted": 0, "System Error": 0, "Wrong Answer": 0, "Compile Error": 0, "Runtime Error": 0, "Time Limit Exceeded": 0, "Memory Limit Exceeded": 0}	29
\.


--
-- Data for Name: problem_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problem_tags (id, problem_id, problemtag_id) FROM stdin;
116	1	5
117	1	6
120	8	5
121	8	6
122	9	5
123	9	6
64	7	5
65	7	6
124	10	5
125	10	6
128	13	8
129	13	9
74	6	5
75	6	6
144	11	5
145	11	6
\.


--
-- Data for Name: problemtag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problemtag (id, tag_name) FROM stdin;
1	test
2	first
3	second
4	aa
5	1
6	2
7	asdf
8	new
9	problem
\.


--
-- Data for Name: submission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.submission (id, submit_time, content, language, verdict, output, author_id, problem_id) FROM stdin;
6	2021-05-09 14:07:25.735858+00	print('123')	Python3	New	{}	1	1
68	2021-06-10 08:50:20.919119+00	print('123')	Python3	Accepted	{"test": [], "time": 0, "memory": 0, "sample_test": [], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	29	1
76	2021-06-11 08:36:36.265318+00	print(int(input())-1)	Python3	Accepted	{"test": [], "time": 0.01, "memory": 1584, "sample_test": [{"stderr": "", "stdout": "4\\n", "test_id": 0, "verdict": "Accepted", "cpu time": "0.01", "memory used": "0"}, {"stderr": "", "stdout": "9999\\n", "test_id": 1, "verdict": "Accepted", "cpu time": "0.01", "memory used": "1584"}, {"stderr": "", "stdout": "0\\n", "test_id": 2, "verdict": "Accepted", "cpu time": "0.01", "memory used": "0"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	29	6
75	2021-06-11 08:35:31.123485+00	sdfdsfafadfs	Python3	Runtime Error	{"test": [], "time": 0, "memory": 15652, "sample_test": [{"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    sdfdsfafadfs\\nNameError: name 'sdfdsfafadfs' is not defined\\n", "stdout": null, "test_id": 0, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "0"}, {"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    sdfdsfafadfs\\nNameError: name 'sdfdsfafadfs' is not defined\\n", "stdout": null, "test_id": 1, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "15652"}, {"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    sdfdsfafadfs\\nNameError: name 'sdfdsfafadfs' is not defined\\n", "stdout": null, "test_id": 2, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "0"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	29	6
69	2021-06-10 08:56:21.675239+00	n=int(input())\narr=list(range(n))\nprint(arr[-1])\n	Python3	Accepted	{"test": [], "time": 0, "memory": 15520, "sample_test": [{"stderr": "", "stdout": "4\\n", "test_id": 0, "verdict": "Accepted", "cpu time": "0.00", "memory used": "15520"}, {"stderr": "", "stdout": "9999\\n", "test_id": 1, "verdict": "Accepted", "cpu time": "0.00", "memory used": "15520"}, {"stderr": "", "stdout": "0\\n", "test_id": 2, "verdict": "Accepted", "cpu time": "0.00", "memory used": "0"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	29	6
77	2021-06-11 08:46:02.787742+00	print("hello mike fend")	Python3	Wrong Answer	{"test": [], "time": 0, "memory": 16056, "sample_test": [{"stderr": "", "stdout": "hello mike fend\\n", "test_id": 0, "verdict": "Wrong Answer", "cpu time": "0.00", "memory used": "16056"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	30	7
70	2021-06-10 08:57:03.585354+00	n=int(input())\narr=list(range(n))\nprint(arr[-1])\n	PyPy3	Accepted	{"test": [], "time": 0.03, "memory": 97060, "sample_test": [{"stderr": "", "stdout": "4\\n", "test_id": 0, "verdict": "Accepted", "cpu time": "0.01", "memory used": "69284"}, {"stderr": "", "stdout": "9999\\n", "test_id": 1, "verdict": "Accepted", "cpu time": "0.03", "memory used": "97060"}, {"stderr": "", "stdout": "0\\n", "test_id": 2, "verdict": "Accepted", "cpu time": "0.00", "memory used": "0"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	29	6
71	2021-06-11 03:52:12.186295+00	sdsdsd	Python3	Runtime Error	{"test": [], "time": 0.01, "memory": 16312, "sample_test": [{"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    sdsdsd\\nNameError: name 'sdsdsd' is not defined\\n", "stdout": null, "test_id": 0, "verdict": "Runtime Error", "cpu time": "0.01", "memory used": "0"}, {"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    sdsdsd\\nNameError: name 'sdsdsd' is not defined\\n", "stdout": null, "test_id": 1, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "16312"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	29	1
72	2021-06-11 06:07:32.698649+00	asdfadfaf	Python3	Runtime Error	{"test": [], "time": 0.01, "memory": 16312, "sample_test": [{"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    asdfadfaf\\nNameError: name 'asdfadfaf' is not defined\\n", "stdout": null, "test_id": 0, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "16312"}, {"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    asdfadfaf\\nNameError: name 'asdfadfaf' is not defined\\n", "stdout": null, "test_id": 1, "verdict": "Runtime Error", "cpu time": "0.01", "memory used": "0"}, {"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    asdfadfaf\\nNameError: name 'asdfadfaf' is not defined\\n", "stdout": null, "test_id": 2, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "16056"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	15	6
73	2021-06-11 06:07:40.672308+00	adfsa32343242344234	Python3	Runtime Error	{"test": [], "time": 0.01, "memory": 16056, "sample_test": [{"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    adfsa32343242344234\\nNameError: name 'adfsa32343242344234' is not defined\\n", "stdout": null, "test_id": 0, "verdict": "Runtime Error", "cpu time": "0.01", "memory used": "0"}, {"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    adfsa32343242344234\\nNameError: name 'adfsa32343242344234' is not defined\\n", "stdout": null, "test_id": 1, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "0"}, {"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    adfsa32343242344234\\nNameError: name 'adfsa32343242344234' is not defined\\n", "stdout": null, "test_id": 2, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "16056"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	15	6
74	2021-06-11 06:29:22.076869+00	dsfsdfsdfsdfs	Python3	Runtime Error	{"test": [], "time": 0, "memory": 16056, "sample_test": [{"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    dsfsdfsdfsdfs\\nNameError: name 'dsfsdfsdfsdfs' is not defined\\n", "stdout": null, "test_id": 0, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "0"}, {"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    dsfsdfsdfsdfs\\nNameError: name 'dsfsdfsdfsdfs' is not defined\\n", "stdout": null, "test_id": 1, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "16056"}, {"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    dsfsdfsdfsdfs\\nNameError: name 'dsfsdfsdfsdfs' is not defined\\n", "stdout": null, "test_id": 2, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "0"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	29	6
78	2021-06-11 08:46:28.461752+00	#include <stdio.h>\nint main() {\n int x;\n  scanf("%d", &x);\n  printf("%d\\n", x-1);\n  }	C	Accepted	{"test": [], "time": 0, "memory": 0, "sample_test": [{"stderr": "", "stdout": "4\\n", "test_id": 0, "verdict": "Accepted", "cpu time": "0.00", "memory used": "0"}, {"stderr": "", "stdout": "9999\\n", "test_id": 1, "verdict": "Accepted", "cpu time": "0.00", "memory used": "0"}, {"stderr": "", "stdout": "0\\n", "test_id": 2, "verdict": "Accepted", "cpu time": "0.00", "memory used": "0"}], "compile_message": ""}	31	6
82	2021-06-11 12:56:32.598221+00	afkhaskdfhasdlfjlkjf;ljdf	Python3	Runtime Error	{"test": [], "time": 0.01, "memory": 16056, "sample_test": [{"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    afkhaskdfhasdlfjlkjf;ljdf\\nNameError: name 'afkhaskdfhasdlfjlkjf' is not defined\\n", "stdout": null, "test_id": 0, "verdict": "Runtime Error", "cpu time": "0.01", "memory used": "0"}, {"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    afkhaskdfhasdlfjlkjf;ljdf\\nNameError: name 'afkhaskdfhasdlfjlkjf' is not defined\\n", "stdout": null, "test_id": 1, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "16056"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	29	10
79	2021-06-11 11:16:01.486678+00	print(int(input())-1)	Python3	Accepted	{"test": [], "time": 0.01, "memory": 0, "sample_test": [{"stderr": "", "stdout": "4\\n", "test_id": 0, "verdict": "Accepted", "cpu time": "0.01", "memory used": "0"}, {"stderr": "", "stdout": "9999\\n", "test_id": 1, "verdict": "Accepted", "cpu time": "0.00", "memory used": "0"}, {"stderr": "", "stdout": "0\\n", "test_id": 2, "verdict": "Accepted", "cpu time": "0.00", "memory used": "0"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	32	6
90	2021-06-18 06:44:36.398431+00	print(0)	Python3	System Error	{}	27	6
80	2021-06-11 11:23:32.164984+00	#include<iostream>\n#include<string.h>\ntypedef long long ll;\nint StringToNum(char c)\n{\n    return c - '0';\n}\nvoid nhap(char *c[], ll n)\n{\n    for(ll i = 0 ; i < n ; i++)\n    {\n        c[i] = new char[100];\n        scanf("%s", c[i]);\n    }   \n}\nint check_nguyen(char c[])\n{\n    for(int i = 0 ; i < strlen(c); i++)\n    {\n        if(c[i] == '.') return 0;\n    }\n    return 1;\n}\nint check_nt(ll n)\n{\n    if(n < 2) return 0;\n    if(n == 2) return 1;\n    else \n    {\n        for(ll i = 2; i*i <= n ; i++)\n        {\n            if(n%i == 0) return 0;\n        }\n        return 1;\n    }\n}\nvoid so_nt(char c[])\n{\n    ll num = 0;\n    if(check_nguyen(c))\n    {\n        for(ll i = strlen(c)-1, count =1 ; i >= 0; i--, count *= 10)\n    {\n\n        num += StringToNum(c[i])*count;\n    }\n    if(check_nt(num)) printf("%lld ", num);\n    }\n}\nint main()\n{\n    char *c[1000];\n    ll n;\n    scanf("%lld", &n);\n    nhap(c,n);\n    for(int i = 0 ; i < n ; i++)\n    {\n        so_nt(c[i]);\n    }\n}	C	Compilation Error	{"test": [], "time": 0, "memory": 0, "sample_test": [{"stderr": null, "stdout": null, "test_id": 0, "verdict": "Compilation Error", "cpu time": 0.0, "memory used": 0}, {"stderr": null, "stdout": null, "test_id": 1, "verdict": "Compilation Error", "cpu time": 0.0, "memory used": 0}, {"stderr": null, "stdout": null, "test_id": 2, "verdict": "Compilation Error", "cpu time": 0.0, "memory used": 0}], "compile_message": "a.c:1:9: fatal error: iostream: No such file or directory\\n    1 | #include<iostream>\\n      |         ^~~~~~~~~~\\ncompilation terminated.\\n"}	29	6
83	2021-06-12 13:13:47.362502+00	n = int(input())\nprint(n)\n	Python3	Wrong Answer	{"test": [], "time": 0.01, "memory": 0, "sample_test": [{"stderr": "", "stdout": "5\\n", "test_id": 0, "verdict": "Wrong Answer", "cpu time": "0.01", "memory used": "0"}, {"stderr": "", "stdout": "10000\\n", "test_id": 1, "verdict": "Wrong Answer", "cpu time": "0.00", "memory used": "0"}, {"stderr": "", "stdout": "1\\n", "test_id": 2, "verdict": "Wrong Answer", "cpu time": "0.01", "memory used": "0"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	34	6
81	2021-06-11 12:56:29.639285+00	afkhaskdfhasdlfjlkjf;ljdf	Python3	Runtime Error	{"test": [], "time": 0.01, "memory": 16312, "sample_test": [{"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    afkhaskdfhasdlfjlkjf;ljdf\\nNameError: name 'afkhaskdfhasdlfjlkjf' is not defined\\n", "stdout": null, "test_id": 0, "verdict": "Runtime Error", "cpu time": "0.01", "memory used": "0"}, {"stderr": "Traceback (most recent call last):\\n  File \\"__init__.py\\", line 1, in <module>\\n    afkhaskdfhasdlfjlkjf;ljdf\\nNameError: name 'afkhaskdfhasdlfjlkjf' is not defined\\n", "stdout": null, "test_id": 1, "verdict": "Runtime Error", "cpu time": "0.00", "memory used": "16312"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	29	10
84	2021-06-18 06:32:14.872568+00	n = int(input())\nprint(n)\n	Python3	New	{}	27	6
85	2021-06-18 06:39:56.822083+00	print(0)\n	Python3	System Error	{}	27	6
96	2021-07-03 09:47:52.04951+00	print("Hello")	Python3	Skipped	{}	29	8
86	2021-06-18 06:41:50.937266+00	print(0)	Python3	System Error	{}	27	6
91	2021-06-18 06:45:00.188984+00	print(0)	Python3	System Error	{}	27	6
87	2021-06-18 06:42:02.766453+00	print(0)	Python3	System Error	{}	27	6
88	2021-06-18 06:42:33.017235+00	print(0)	Python3	System Error	{}	27	6
95	2021-06-18 06:52:47.650561+00	print(0)	Python3	Wrong Answer	{"test": [], "time": 0.01, "memory": 0, "sample_test": [{"stderr": "", "stdout": "0\\n", "test_id": 0, "verdict": "Wrong Answer", "cpu time": "0.00", "memory used": "0"}, {"stderr": "", "stdout": "0\\n", "test_id": 1, "verdict": "Wrong Answer", "cpu time": "0.00", "memory used": "0"}, {"stderr": "", "stdout": "0\\n", "test_id": 2, "verdict": "Accepted", "cpu time": "0.01", "memory used": "0"}], "compile_message": "Listing '.'...\\nCompiling './__init__.py'...\\n"}	27	6
89	2021-06-18 06:43:56.614892+00	print(0)	Python3	System Error	{}	27	6
92	2021-06-18 06:45:59.30571+00	print(0)	Python3	System Error	{}	27	6
93	2021-06-18 06:46:46.619113+00	print(0)	Python3	System Error	{}	27	6
94	2021-06-18 06:49:07.4431+00	print(0)	Python3	System Error	{}	27	6
97	2021-07-03 09:49:22.26602+00	print("Hello")	Python3	Skipped	{}	29	1
98	2021-07-03 09:51:06.902194+00	print(int(input()-1)	Python3	Skipped	{}	29	6
99	2021-07-03 10:13:45.426533+00	print("hello")	Python3	Skipped	{}	29	8
\.


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 35, true);


--
-- Name: accounts_user_solved_problem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_solved_problem_id_seq', 12, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: announcement_announcement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.announcement_announcement_id_seq', 39, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 72, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 18, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 78, true);


--
-- Name: django_q_ormq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_q_ormq_id_seq', 1, false);


--
-- Name: django_q_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_q_schedule_id_seq', 1, false);


--
-- Name: judge_server_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.judge_server_id_seq', 1, true);


--
-- Name: problem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.problem_id_seq', 13, true);


--
-- Name: problem_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.problem_tags_id_seq', 145, true);


--
-- Name: problemtag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.problemtag_id_seq', 9, true);


--
-- Name: submission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.submission_id_seq', 99, true);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_solved_problem accounts_user_solved_problem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_solved_problem
    ADD CONSTRAINT accounts_user_solved_problem_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_solved_problem accounts_user_solved_problem_user_id_problem_id_85d62617_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_solved_problem
    ADD CONSTRAINT accounts_user_solved_problem_user_id_problem_id_85d62617_uniq UNIQUE (user_id, problem_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


--
-- Name: announcement announcement_announcement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT announcement_announcement_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_q_ormq django_q_ormq_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_q_ormq
    ADD CONSTRAINT django_q_ormq_pkey PRIMARY KEY (id);


--
-- Name: django_q_schedule django_q_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_q_schedule
    ADD CONSTRAINT django_q_schedule_pkey PRIMARY KEY (id);


--
-- Name: django_q_task django_q_task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_q_task
    ADD CONSTRAINT django_q_task_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: judge_server judge_server_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.judge_server
    ADD CONSTRAINT judge_server_pkey PRIMARY KEY (id);


--
-- Name: problem problem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT problem_pkey PRIMARY KEY (id);


--
-- Name: problem_tags problem_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_pkey PRIMARY KEY (id);


--
-- Name: problem_tags problem_tags_problem_id_problemtag_id_318459d1_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_problem_id_problemtag_id_318459d1_uniq UNIQUE (problem_id, problemtag_id);


--
-- Name: problemtag problemtag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problemtag
    ADD CONSTRAINT problemtag_pkey PRIMARY KEY (id);


--
-- Name: submission submission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission
    ADD CONSTRAINT submission_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_solved_problem_problem_id_3e9ac560; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_solved_problem_problem_id_3e9ac560 ON public.accounts_user_solved_problem USING btree (problem_id);


--
-- Name: accounts_user_solved_problem_user_id_96a0d7d9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_solved_problem_user_id_96a0d7d9 ON public.accounts_user_solved_problem USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username text_pattern_ops);


--
-- Name: announcement_announcement_author_id_bbcb5322; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX announcement_announcement_author_id_bbcb5322 ON public.announcement USING btree (author_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_q_task_id_32882367_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_q_task_id_32882367_like ON public.django_q_task USING btree (id varchar_pattern_ops);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: problem_author_id_9a42a827; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX problem_author_id_9a42a827 ON public.problem USING btree (author_id);


--
-- Name: problem_display_id_9a0b8076; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX problem_display_id_9a0b8076 ON public.problem USING btree (display_id);


--
-- Name: problem_display_id_9a0b8076_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX problem_display_id_9a0b8076_like ON public.problem USING btree (display_id text_pattern_ops);


--
-- Name: problem_tags_problem_id_866ecb8d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX problem_tags_problem_id_866ecb8d ON public.problem_tags USING btree (problem_id);


--
-- Name: problem_tags_problemtag_id_72d20571; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX problem_tags_problemtag_id_72d20571 ON public.problem_tags USING btree (problemtag_id);


--
-- Name: submission_author_id_dcec143d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX submission_author_id_dcec143d ON public.submission USING btree (author_id);


--
-- Name: submission_problem_id_76847b55; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX submission_problem_id_76847b55 ON public.submission USING btree (problem_id);


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_solved_problem accounts_user_solved_problem_problem_id_3e9ac560_fk_problem_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_solved_problem
    ADD CONSTRAINT accounts_user_solved_problem_problem_id_3e9ac560_fk_problem_id FOREIGN KEY (problem_id) REFERENCES public.problem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_solved_problem accounts_user_solved_user_id_96a0d7d9_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_solved_problem
    ADD CONSTRAINT accounts_user_solved_user_id_96a0d7d9_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: announcement announcement_announc_author_id_bbcb5322_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT announcement_announc_author_id_bbcb5322_fk_accounts_ FOREIGN KEY (author_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: problem problem_author_id_9a42a827_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT problem_author_id_9a42a827_fk_accounts_user_id FOREIGN KEY (author_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: problem_tags problem_tags_problem_id_866ecb8d_fk_problem_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_problem_id_866ecb8d_fk_problem_id FOREIGN KEY (problem_id) REFERENCES public.problem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: problem_tags problem_tags_problemtag_id_72d20571_fk_problemtag_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT problem_tags_problemtag_id_72d20571_fk_problemtag_id FOREIGN KEY (problemtag_id) REFERENCES public.problemtag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: submission submission_author_id_dcec143d_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission
    ADD CONSTRAINT submission_author_id_dcec143d_fk_accounts_user_id FOREIGN KEY (author_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: submission submission_problem_id_76847b55_fk_problem_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission
    ADD CONSTRAINT submission_problem_id_76847b55_fk_problem_id FOREIGN KEY (problem_id) REFERENCES public.problem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

