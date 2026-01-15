--
-- PostgreSQL database dump
--

\restrict W0zc04PxSZhADlcknhnflgCQgup98rRlKo5N3DMoUjIL1hJLVytFpseao3EuAH5

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

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

--
-- Name: album_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.album_genres (
    album_id bigint NOT NULL,
    genre_id bigint NOT NULL
);


ALTER TABLE public.album_genres OWNER TO postgres;

--
-- Name: album_subgenres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.album_subgenres (
    album_id bigint NOT NULL,
    subgenre_id bigint NOT NULL
);


ALTER TABLE public.album_subgenres OWNER TO postgres;

--
-- Name: albums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.albums (
    album_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    artist_id bigint NOT NULL,
    label_id bigint,
    release_date date NOT NULL,
    cover_image_url character varying(500),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.albums OWNER TO postgres;

--
-- Name: TABLE albums; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.albums IS 'Collection on songs released together';


--
-- Name: albums_album_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.albums_album_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.albums_album_id_seq OWNER TO postgres;

--
-- Name: albums_album_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.albums_album_id_seq OWNED BY public.albums.album_id;


--
-- Name: artists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artists (
    artist_id bigint NOT NULL,
    artist_name character varying(255) NOT NULL,
    bio text,
    country_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.artists OWNER TO postgres;

--
-- Name: TABLE artists; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.artists IS 'Musicians and artists who create music';


--
-- Name: artists_albums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artists_albums (
    artist_id bigint NOT NULL,
    album_id bigint NOT NULL,
    countributory_type character varying(100)
);


ALTER TABLE public.artists_albums OWNER TO postgres;

--
-- Name: artists_artist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.artists_artist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.artists_artist_id_seq OWNER TO postgres;

--
-- Name: artists_artist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.artists_artist_id_seq OWNED BY public.artists.artist_id;


--
-- Name: billing_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.billing_history (
    billing_id bigint NOT NULL,
    user_id bigint NOT NULL,
    billed_amount numeric(10,2) NOT NULL,
    due_date timestamp with time zone NOT NULL,
    is_paid boolean DEFAULT false NOT NULL,
    paid_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT check_amount CHECK ((billed_amount >= (0)::numeric)),
    CONSTRAINT check_due_date CHECK ((due_date >= created_at)),
    CONSTRAINT check_paid_logic CHECK ((((is_paid = false) AND (paid_at IS NULL)) OR ((is_paid = true) AND (paid_at IS NOT NULL))))
);


ALTER TABLE public.billing_history OWNER TO postgres;

--
-- Name: COLUMN billing_history.billed_amount; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.billing_history.billed_amount IS 'Amount billed in USD';


--
-- Name: billing_history_billing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.billing_history_billing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.billing_history_billing_id_seq OWNER TO postgres;

--
-- Name: billing_history_billing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.billing_history_billing_id_seq OWNED BY public.billing_history.billing_id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    country_id bigint NOT NULL,
    country_code character varying(2) NOT NULL,
    country_name character varying(100) NOT NULL
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: countries_country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.countries_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.countries_country_id_seq OWNER TO postgres;

--
-- Name: countries_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.countries_country_id_seq OWNED BY public.countries.country_id;


--
-- Name: follows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.follows (
    user_id bigint NOT NULL,
    artist_id bigint NOT NULL,
    liked_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.follows OWNER TO postgres;

--
-- Name: TABLE follows; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.follows IS 'Artists that uers follow';


--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    genre_id bigint NOT NULL,
    genre_code character varying(3),
    genre_name character varying(255) NOT NULL,
    description text
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: genres_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_genre_id_seq OWNER TO postgres;

--
-- Name: genres_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_genre_id_seq OWNED BY public.genres.genre_id;


--
-- Name: labels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.labels (
    label_id bigint NOT NULL,
    label_code character varying(3) NOT NULL,
    label_name character varying(255) NOT NULL,
    country_id bigint NOT NULL,
    active_years integer NOT NULL,
    CONSTRAINT check_years CHECK ((active_years > 0))
);


ALTER TABLE public.labels OWNER TO postgres;

--
-- Name: labels_label_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.labels_label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.labels_label_id_seq OWNER TO postgres;

--
-- Name: labels_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.labels_label_id_seq OWNED BY public.labels.label_id;


--
-- Name: listened; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.listened (
    listening_id bigint NOT NULL,
    song_id bigint,
    user_id bigint NOT NULL,
    played_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    device_info character varying(255),
    duration_played integer,
    CONSTRAINT check_duration_played CHECK ((duration_played >= 0))
);


ALTER TABLE public.listened OWNER TO postgres;

--
-- Name: TABLE listened; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.listened IS 'Real-time listening events for immediate tracking';


--
-- Name: COLUMN listened.duration_played; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.listened.duration_played IS 'How many seconds the listener actually listened';


--
-- Name: listened_listening_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.listened_listening_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.listened_listening_id_seq OWNER TO postgres;

--
-- Name: listened_listening_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.listened_listening_id_seq OWNED BY public.listened.listening_id;


--
-- Name: listening_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.listening_history (
    history_id bigint NOT NULL,
    user_id bigint NOT NULL,
    song_id bigint,
    listening_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    duration_played integer,
    device_info character varying(255),
    CONSTRAINT check_history_duration CHECK ((duration_played >= 0))
)
PARTITION BY RANGE (listening_date);


ALTER TABLE public.listening_history OWNER TO postgres;

--
-- Name: TABLE listening_history; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.listening_history IS 'Historical listening data partitioned by data partitioned by date for analytics';


--
-- Name: listening_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.listening_history_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.listening_history_history_id_seq OWNER TO postgres;

--
-- Name: listening_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.listening_history_history_id_seq OWNED BY public.listening_history.history_id;


--
-- Name: playlists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playlists (
    playlist_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    user_id bigint NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.playlists OWNER TO postgres;

--
-- Name: TABLE playlists; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.playlists IS 'User-created song collections';


--
-- Name: playlists_playlist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.playlists_playlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.playlists_playlist_id_seq OWNER TO postgres;

--
-- Name: playlists_playlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.playlists_playlist_id_seq OWNED BY public.playlists.playlist_id;


--
-- Name: playlists_songs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playlists_songs (
    playlist_id bigint NOT NULL,
    song_id bigint NOT NULL,
    song_position integer NOT NULL,
    added_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT check_position CHECK ((song_position > 0))
);


ALTER TABLE public.playlists_songs OWNER TO postgres;

--
-- Name: singles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.singles (
    single_id bigint NOT NULL,
    song_id bigint NOT NULL,
    release_type character varying(50),
    chart_peak_position integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT check_chart_position CHECK ((chart_peak_position > 0))
);


ALTER TABLE public.singles OWNER TO postgres;

--
-- Name: singles_single_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.singles_single_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.singles_single_id_seq OWNER TO postgres;

--
-- Name: singles_single_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.singles_single_id_seq OWNED BY public.singles.single_id;


--
-- Name: song_likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.song_likes (
    user_id bigint NOT NULL,
    song_id bigint NOT NULL,
    liked_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.song_likes OWNER TO postgres;

--
-- Name: TABLE song_likes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.song_likes IS 'Songs that users have liked';


--
-- Name: song_subgenres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.song_subgenres (
    song_id bigint NOT NULL,
    subgenre_id bigint NOT NULL
);


ALTER TABLE public.song_subgenres OWNER TO postgres;

--
-- Name: songs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.songs (
    song_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    artist_id bigint NOT NULL,
    album_id bigint,
    duration integer NOT NULL,
    release_date date NOT NULL,
    track_number integer,
    lyric text,
    popularity_score integer DEFAULT 0,
    is_single boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone,
    CONSTRAINT check_duration CHECK ((duration > 0)),
    CONSTRAINT check_popularity CHECK (((popularity_score >= 0) AND (popularity_score <= 100))),
    CONSTRAINT check_track_number CHECK ((track_number > 0))
);


ALTER TABLE public.songs OWNER TO postgres;

--
-- Name: TABLE songs; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.songs IS 'Individual music tracks';


--
-- Name: COLUMN songs.duration; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.songs.duration IS 'Song duration in seconds';


--
-- Name: COLUMN songs.popularity_score; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.songs.popularity_score IS 'Popularity score from 0-100';


--
-- Name: songs_artists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.songs_artists (
    song_id bigint NOT NULL,
    artist_id bigint NOT NULL,
    artist_role character varying(50)
);


ALTER TABLE public.songs_artists OWNER TO postgres;

--
-- Name: songs_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.songs_genres (
    song_id bigint NOT NULL,
    genre_id bigint NOT NULL
);


ALTER TABLE public.songs_genres OWNER TO postgres;

--
-- Name: songs_song_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.songs_song_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.songs_song_id_seq OWNER TO postgres;

--
-- Name: songs_song_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.songs_song_id_seq OWNED BY public.songs.song_id;


--
-- Name: subgenres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subgenres (
    subgenre_id bigint NOT NULL,
    subgenre_code character varying(3),
    subgenre_name character varying(255) NOT NULL,
    genre_id bigint NOT NULL,
    description text
);


ALTER TABLE public.subgenres OWNER TO postgres;

--
-- Name: subgenres_subgenre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subgenres_subgenre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subgenres_subgenre_id_seq OWNER TO postgres;

--
-- Name: subgenres_subgenre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subgenres_subgenre_id_seq OWNED BY public.subgenres.subgenre_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id bigint NOT NULL,
    user_name character varying(255) NOT NULL,
    gender character varying(100) NOT NULL,
    date_of_birth date NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    is_premium boolean DEFAULT false NOT NULL,
    country_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone,
    CONSTRAINT check_age CHECK ((date_of_birth <= (CURRENT_DATE - '13 years'::interval)))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.users IS 'Registered users of the music streaming platform';


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: albums album_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.albums ALTER COLUMN album_id SET DEFAULT nextval('public.albums_album_id_seq'::regclass);


--
-- Name: artists artist_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artists ALTER COLUMN artist_id SET DEFAULT nextval('public.artists_artist_id_seq'::regclass);


--
-- Name: billing_history billing_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing_history ALTER COLUMN billing_id SET DEFAULT nextval('public.billing_history_billing_id_seq'::regclass);


--
-- Name: countries country_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries ALTER COLUMN country_id SET DEFAULT nextval('public.countries_country_id_seq'::regclass);


--
-- Name: genres genre_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN genre_id SET DEFAULT nextval('public.genres_genre_id_seq'::regclass);


--
-- Name: labels label_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labels ALTER COLUMN label_id SET DEFAULT nextval('public.labels_label_id_seq'::regclass);


--
-- Name: listened listening_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listened ALTER COLUMN listening_id SET DEFAULT nextval('public.listened_listening_id_seq'::regclass);


--
-- Name: listening_history history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listening_history ALTER COLUMN history_id SET DEFAULT nextval('public.listening_history_history_id_seq'::regclass);


--
-- Name: playlists playlist_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlists ALTER COLUMN playlist_id SET DEFAULT nextval('public.playlists_playlist_id_seq'::regclass);


--
-- Name: singles single_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.singles ALTER COLUMN single_id SET DEFAULT nextval('public.singles_single_id_seq'::regclass);


--
-- Name: songs song_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.songs ALTER COLUMN song_id SET DEFAULT nextval('public.songs_song_id_seq'::regclass);


--
-- Name: subgenres subgenre_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subgenres ALTER COLUMN subgenre_id SET DEFAULT nextval('public.subgenres_subgenre_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: album_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.album_genres (album_id, genre_id) FROM stdin;
\.


--
-- Data for Name: album_subgenres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.album_subgenres (album_id, subgenre_id) FROM stdin;
\.


--
-- Data for Name: albums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.albums (album_id, title, artist_id, label_id, release_date, cover_image_url, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: artists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artists (artist_id, artist_name, bio, country_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: artists_albums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artists_albums (artist_id, album_id, countributory_type) FROM stdin;
\.


--
-- Data for Name: billing_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.billing_history (billing_id, user_id, billed_amount, due_date, is_paid, paid_at, created_at) FROM stdin;
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.countries (country_id, country_code, country_name) FROM stdin;
\.


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.follows (user_id, artist_id, liked_at) FROM stdin;
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (genre_id, genre_code, genre_name, description) FROM stdin;
\.


--
-- Data for Name: labels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.labels (label_id, label_code, label_name, country_id, active_years) FROM stdin;
\.


--
-- Data for Name: listened; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.listened (listening_id, song_id, user_id, played_at, device_info, duration_played) FROM stdin;
\.


--
-- Data for Name: playlists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.playlists (playlist_id, title, description, user_id, is_public, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: playlists_songs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.playlists_songs (playlist_id, song_id, song_position, added_at) FROM stdin;
\.


--
-- Data for Name: singles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.singles (single_id, song_id, release_type, chart_peak_position, created_at) FROM stdin;
\.


--
-- Data for Name: song_likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.song_likes (user_id, song_id, liked_at) FROM stdin;
\.


--
-- Data for Name: song_subgenres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.song_subgenres (song_id, subgenre_id) FROM stdin;
\.


--
-- Data for Name: songs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.songs (song_id, title, artist_id, album_id, duration, release_date, track_number, lyric, popularity_score, is_single, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: songs_artists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.songs_artists (song_id, artist_id, artist_role) FROM stdin;
\.


--
-- Data for Name: songs_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.songs_genres (song_id, genre_id) FROM stdin;
\.


--
-- Data for Name: subgenres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subgenres (subgenre_id, subgenre_code, subgenre_name, genre_id, description) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, user_name, gender, date_of_birth, email, password_hash, is_premium, country_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: albums_album_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.albums_album_id_seq', 1, false);


--
-- Name: artists_artist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.artists_artist_id_seq', 1, false);


--
-- Name: billing_history_billing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.billing_history_billing_id_seq', 1, false);


--
-- Name: countries_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.countries_country_id_seq', 1, false);


--
-- Name: genres_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_genre_id_seq', 1, false);


--
-- Name: labels_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.labels_label_id_seq', 1, false);


--
-- Name: listened_listening_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.listened_listening_id_seq', 1, false);


--
-- Name: listening_history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.listening_history_history_id_seq', 1, false);


--
-- Name: playlists_playlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.playlists_playlist_id_seq', 1, false);


--
-- Name: singles_single_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.singles_single_id_seq', 1, false);


--
-- Name: songs_song_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.songs_song_id_seq', 1, false);


--
-- Name: subgenres_subgenre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subgenres_subgenre_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: album_genres album_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_genres
    ADD CONSTRAINT album_genres_pkey PRIMARY KEY (album_id, genre_id);


--
-- Name: album_subgenres album_subgenres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_subgenres
    ADD CONSTRAINT album_subgenres_pkey PRIMARY KEY (album_id, subgenre_id);


--
-- Name: albums albums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (album_id);


--
-- Name: artists_albums artists_albums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artists_albums
    ADD CONSTRAINT artists_albums_pkey PRIMARY KEY (artist_id, album_id);


--
-- Name: artists artists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (artist_id);


--
-- Name: billing_history billing_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing_history
    ADD CONSTRAINT billing_history_pkey PRIMARY KEY (billing_id);


--
-- Name: countries countries_country_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_country_code_key UNIQUE (country_code);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);


--
-- Name: follows follows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (user_id, artist_id);


--
-- Name: genres genres_genre_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_genre_code_key UNIQUE (genre_code);


--
-- Name: genres genres_genre_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_genre_name_key UNIQUE (genre_name);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);


--
-- Name: labels labels_label_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labels
    ADD CONSTRAINT labels_label_code_key UNIQUE (label_code);


--
-- Name: labels labels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labels
    ADD CONSTRAINT labels_pkey PRIMARY KEY (label_id);


--
-- Name: listened listened_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listened
    ADD CONSTRAINT listened_pkey PRIMARY KEY (listening_id);


--
-- Name: listening_history listening_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listening_history
    ADD CONSTRAINT listening_history_pkey PRIMARY KEY (history_id, listening_date);


--
-- Name: playlists playlists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_pkey PRIMARY KEY (playlist_id);


--
-- Name: playlists_songs playlists_songs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlists_songs
    ADD CONSTRAINT playlists_songs_pkey PRIMARY KEY (playlist_id, song_id);


--
-- Name: singles singles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.singles
    ADD CONSTRAINT singles_pkey PRIMARY KEY (single_id);


--
-- Name: singles singles_song_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.singles
    ADD CONSTRAINT singles_song_id_key UNIQUE (song_id);


--
-- Name: song_likes song_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song_likes
    ADD CONSTRAINT song_likes_pkey PRIMARY KEY (user_id, song_id);


--
-- Name: song_subgenres song_subgenres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song_subgenres
    ADD CONSTRAINT song_subgenres_pkey PRIMARY KEY (song_id, subgenre_id);


--
-- Name: songs_artists songs_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.songs_artists
    ADD CONSTRAINT songs_artists_pkey PRIMARY KEY (song_id, artist_id);


--
-- Name: songs_genres songs_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.songs_genres
    ADD CONSTRAINT songs_genres_pkey PRIMARY KEY (song_id, genre_id);


--
-- Name: songs songs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.songs
    ADD CONSTRAINT songs_pkey PRIMARY KEY (song_id);


--
-- Name: subgenres subgenres_genre_id_subgenre_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subgenres
    ADD CONSTRAINT subgenres_genre_id_subgenre_name_key UNIQUE (genre_id, subgenre_name);


--
-- Name: subgenres subgenres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subgenres
    ADD CONSTRAINT subgenres_pkey PRIMARY KEY (subgenre_id);


--
-- Name: subgenres subgenres_subgenre_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subgenres
    ADD CONSTRAINT subgenres_subgenre_code_key UNIQUE (subgenre_code);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: index_albums_artist; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_albums_artist ON public.albums USING btree (artist_id);


--
-- Name: index_albums_release_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_albums_release_date ON public.albums USING btree (release_date DESC);


--
-- Name: index_albums_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_albums_title ON public.albums USING btree (title);


--
-- Name: index_artists_country; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_artists_country ON public.artists USING btree (country_id);


--
-- Name: index_artists_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_artists_name ON public.artists USING btree (artist_name);


--
-- Name: index_billing_due_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_billing_due_date ON public.billing_history USING btree (due_date);


--
-- Name: index_billing_unpaid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_billing_unpaid ON public.billing_history USING btree (is_paid) WHERE (is_paid = false);


--
-- Name: index_billing_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_billing_user ON public.billing_history USING btree (user_id);


--
-- Name: index_follows_artist; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_follows_artist ON public.follows USING btree (artist_id);


--
-- Name: index_follows_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_follows_user ON public.follows USING btree (user_id);


--
-- Name: index_listened_played_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_listened_played_at ON public.listened USING btree (played_at DESC);


--
-- Name: index_listened_song; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_listened_song ON public.listened USING btree (song_id);


--
-- Name: index_listened_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_listened_user ON public.listened USING btree (user_id);


--
-- Name: index_playlists_public; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_playlists_public ON public.playlists USING btree (is_public) WHERE (is_public = true);


--
-- Name: index_playlists_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_playlists_user ON public.playlists USING btree (user_id);


--
-- Name: index_song_likes_song; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_song_likes_song ON public.song_likes USING btree (song_id);


--
-- Name: index_song_likes_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_song_likes_user ON public.song_likes USING btree (user_id);


--
-- Name: index_songs_album; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_songs_album ON public.songs USING btree (album_id);


--
-- Name: index_songs_artist; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_songs_artist ON public.songs USING btree (artist_id);


--
-- Name: index_songs_popularity; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_songs_popularity ON public.songs USING btree (popularity_score DESC);


--
-- Name: index_songs_release_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_songs_release_date ON public.songs USING btree (release_date DESC);


--
-- Name: index_songs_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_songs_title ON public.songs USING btree (title);


--
-- Name: index_users_country; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_country ON public.users USING btree (country_id);


--
-- Name: index_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_email ON public.users USING btree (email);


--
-- Name: index_users_premium; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_premium ON public.users USING btree (is_premium);


--
-- Name: album_genres album_genres_album_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_genres
    ADD CONSTRAINT album_genres_album_id_fkey FOREIGN KEY (album_id) REFERENCES public.albums(album_id) ON DELETE CASCADE;


--
-- Name: album_genres album_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_genres
    ADD CONSTRAINT album_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(genre_id) ON DELETE CASCADE;


--
-- Name: album_subgenres album_subgenres_album_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_subgenres
    ADD CONSTRAINT album_subgenres_album_id_fkey FOREIGN KEY (album_id) REFERENCES public.albums(album_id) ON DELETE CASCADE;


--
-- Name: album_subgenres album_subgenres_subgenre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_subgenres
    ADD CONSTRAINT album_subgenres_subgenre_id_fkey FOREIGN KEY (subgenre_id) REFERENCES public.subgenres(subgenre_id) ON DELETE CASCADE;


--
-- Name: albums albums_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artists(artist_id) ON DELETE RESTRICT;


--
-- Name: albums albums_label_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_label_id_fkey FOREIGN KEY (label_id) REFERENCES public.labels(label_id) ON DELETE SET NULL;


--
-- Name: artists_albums artists_albums_album_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artists_albums
    ADD CONSTRAINT artists_albums_album_id_fkey FOREIGN KEY (album_id) REFERENCES public.albums(album_id) ON DELETE CASCADE;


--
-- Name: artists_albums artists_albums_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artists_albums
    ADD CONSTRAINT artists_albums_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artists(artist_id) ON DELETE CASCADE;


--
-- Name: artists artists_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artists
    ADD CONSTRAINT artists_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(country_id) ON DELETE RESTRICT;


--
-- Name: billing_history billing_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing_history
    ADD CONSTRAINT billing_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE RESTRICT;


--
-- Name: follows follows_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artists(artist_id) ON DELETE CASCADE;


--
-- Name: follows follows_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: labels labels_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labels
    ADD CONSTRAINT labels_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(country_id) ON DELETE SET NULL;


--
-- Name: listened listened_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listened
    ADD CONSTRAINT listened_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(song_id) ON DELETE SET NULL;


--
-- Name: listened listened_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listened
    ADD CONSTRAINT listened_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: listening_history listening_history_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.listening_history
    ADD CONSTRAINT listening_history_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(song_id) ON DELETE SET NULL;


--
-- Name: listening_history listening_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.listening_history
    ADD CONSTRAINT listening_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: playlists_songs playlists_songs_playlist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlists_songs
    ADD CONSTRAINT playlists_songs_playlist_id_fkey FOREIGN KEY (playlist_id) REFERENCES public.playlists(playlist_id) ON DELETE CASCADE;


--
-- Name: playlists_songs playlists_songs_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlists_songs
    ADD CONSTRAINT playlists_songs_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(song_id) ON DELETE CASCADE;


--
-- Name: playlists playlists_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: singles singles_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.singles
    ADD CONSTRAINT singles_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(song_id) ON DELETE CASCADE;


--
-- Name: song_likes song_likes_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song_likes
    ADD CONSTRAINT song_likes_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(song_id) ON DELETE CASCADE;


--
-- Name: song_likes song_likes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song_likes
    ADD CONSTRAINT song_likes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: song_subgenres song_subgenres_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song_subgenres
    ADD CONSTRAINT song_subgenres_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(song_id) ON DELETE CASCADE;


--
-- Name: song_subgenres song_subgenres_subgenre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song_subgenres
    ADD CONSTRAINT song_subgenres_subgenre_id_fkey FOREIGN KEY (subgenre_id) REFERENCES public.subgenres(subgenre_id) ON DELETE CASCADE;


--
-- Name: songs songs_album_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.songs
    ADD CONSTRAINT songs_album_id_fkey FOREIGN KEY (album_id) REFERENCES public.albums(album_id) ON DELETE SET NULL;


--
-- Name: songs songs_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.songs
    ADD CONSTRAINT songs_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artists(artist_id) ON DELETE RESTRICT;


--
-- Name: songs_artists songs_artists_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.songs_artists
    ADD CONSTRAINT songs_artists_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artists(artist_id) ON DELETE CASCADE;


--
-- Name: songs_artists songs_artists_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.songs_artists
    ADD CONSTRAINT songs_artists_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(song_id) ON DELETE CASCADE;


--
-- Name: songs_genres songs_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.songs_genres
    ADD CONSTRAINT songs_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(genre_id) ON DELETE CASCADE;


--
-- Name: songs_genres songs_genres_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.songs_genres
    ADD CONSTRAINT songs_genres_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(song_id) ON DELETE CASCADE;


--
-- Name: subgenres subgenres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subgenres
    ADD CONSTRAINT subgenres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(genre_id) ON DELETE RESTRICT;


--
-- Name: users users_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(country_id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict W0zc04PxSZhADlcknhnflgCQgup98rRlKo5N3DMoUjIL1hJLVytFpseao3EuAH5

