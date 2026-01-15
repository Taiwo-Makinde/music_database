-- ==============================================================================================
-- MUSIC DATABASE SCHEMA 
-- ==============================================================================================
-- This schema defines a comprehensive music streaming wit support for:
-- 	- User managemnt and premium subscription
--	- Artists, albums, songs with genre/subgenre claasification
--	- Playlists and listening history 
--	- Social features such as likes, follows, and shared playlists
--	- Billing and payment tracking
-- ==============================================================================================

-- ==============================================================================================
--	LOOKUP/REFERENCE TABLES
-- These tables provide standardized reference data. 
-- It is standard practice to begin with lookup/reference tables as these tables do not have dependencies.
-- ==============================================================================================

CREATE TABLE countries(
			country_id BIGSERIAL PRIMARY KEY,
			country_code VARCHAR(2) NOT NULL UNIQUE,
			country_name VARCHAR(100) NOT NULL
			);

CREATE TABLE genres (
			genre_id BIGSERIAL PRIMARY KEY, 
			genre_code VARCHAR(3) UNIQUE,
			genre_name VARCHAR(255) NOT NULL UNIQUE, 
			description TEXT
			);

CREATE TABLE subgenres(	
			subgenre_id BIGSERIAL PRIMARY KEY, 
			subgenre_code VARCHAR(3) UNIQUE,
			subgenre_name VARCHAR(255) NOT NULL,
			genre_id BIGINT NOT NULL REFERENCES genres(genre_id) ON DELETE RESTRICT,
			description TEXT,
			UNIQUE(genre_id, subgenre_name)
			);

-- ==============================================================================================
-- CORE ENTITY TABLES 
-- These tables represent the main entities in the database.
-- Without these core entities tables, wewould not be able to develop junction tables.
-- ==============================================================================================

CREATE TABLE users (
			user_id BIGSERIAL PRIMARY KEY,
			user_name VARCHAR(255) NOT NULL,
			gender VARCHAR (100)  NOT NULL,
			date_of_birth DATE NOT NULL,
			email VARCHAR (255) NOT NULL UNIQUE,
			password_hash VARCHAR(255) NOT NULL,
			is_premium BOOLEAN NOT NULL DEFAULT FALSE,
			country_id BIGINT NOT NULL REFERENCES countries(country_id) ON DELETE RESTRICT,
			created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			updated_at TIMESTAMPTZ,
			CONSTRAINT check_age CHECK (date_of_birth <= CURRENT_DATE - INTERVAL '13 years')
			);

CREATE TABLE artists(
			artist_id BIGSERIAL PRIMARY KEY, 
			artist_name VARCHAR(255) NOT NULL,
			bio TEXT,
			country_id BIGINT NOT NULL REFERENCES countries(country_id) ON DELETE RESTRICT,
			created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			updated_at TIMESTAMPTZ
			);

CREATE TABLE labels(
			label_id BIGSERIAL PRIMARY KEY,
			label_code VARCHAR(3) NOT NULL UNIQUE, 
			label_name VARCHAR(255) NOT NULL,
			country_id BIGINT NOT NULL REFERENCES countries(country_id) ON DELETE SET NULL,
			active_years INT NOT NULL,
			CONSTRAINT check_years CHECK (active_years > 0)
			);

CREATE TABLE albums(
			album_id BIGSERIAL PRIMARY KEY,
			title VARCHAR(255) NOT NULL, 
			artist_id BIGINT NOT NULL REFERENCES artists(artist_id) ON DELETE RESTRICT, 
			label_id BIGINT REFERENCES labels(label_id) ON DELETE SET NULL,
			release_date DATE NOT NULL,
			cover_image_url VARCHAR(500),
			created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			updated_at TIMESTAMPTZ
			);

CREATE TABLE songs(
			song_id BIGSERIAL PRIMARY KEY, 
			title VARCHAR(255) NOT NULL, 
			artist_id BIGINT NOT NULL REFERENCES artists(artist_id) ON DELETE RESTRICT,
			album_id BIGINT REFERENCES albums(album_id) ON DELETE SET NULL, 
			duration INT NOT NULL, 
			release_date DATE NOT NULL,
			track_number INT,
			lyric TEXT,
			popularity_score INT DEFAULT 0,
			is_single BOOLEAN DEFAULT FALSE,
			created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			updated_at TIMESTAMPTZ,
			CONSTRAINT check_duration CHECK (duration > 0),
			CONSTRAINT check_popularity CHECK (popularity_score BETWEEN 0 AND 100),
			CONSTRAINT check_track_number CHECK (track_number > 0)
			);

CREATE TABLE singles(
			single_id BIGSERIAL PRIMARY KEY,
			song_id BIGINT NOT NULL UNIQUE REFERENCES songs(song_id) ON DELETE CASCADE,
			release_type VARCHAR(50),
			chart_peak_position INT,
			created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT check_chart_position CHECK (chart_peak_position > 0)
			);

CREATE TABLE playlists(
			playlist_id BIGSERIAL PRIMARY KEY,
			title VARCHAR(255) NOT NULL,
			description TEXT,
			user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
			is_public BOOLEAN NOT NULL DEFAULT FALSE,
			created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			updated_at TIMESTAMPTZ
			);

CREATE TABLE billing_history (
			billing_id BIGSERIAL PRIMARY KEY,
			user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE RESTRICT,
			billed_amount DECIMAL(10,2) NOT NULL,
			due_date TIMESTAMPTZ NOT NULL,
			is_paid BOOLEAN NOT NULL DEFAULT FALSE,
			paid_at TIMESTAMPTZ,
			created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT check_amount CHECK (billed_amount >= 0),
			CONSTRAINT check_due_date CHECK (due_date >= created_at),
			CONSTRAINT check_paid_logic CHECK (
			(is_paid = FALSE AND paid_at IS NULL) OR
			(is_paid = TRUE AND paid_at IS NOT NULL)
			)
			);

-- ==============================================================================================
-- JUNCTION TABLES (Many-to-Many Relationships)
-- These tables enable flexible relationships between entities.
-- ==============================================================================================

CREATE TABLE playlists_songs(
			playlist_id BIGINT NOT NULL REFERENCES playlists(playlist_id) ON DELETE CASCADE,
			song_id BIGINT NOT NULL REFERENCES songs(song_id) ON DELETE CASCADE,
			song_position INT NOT NULL,
			added_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			PRIMARY KEY (playlist_id, song_id),
			CONSTRAINT check_position CHECK (song_position > 0) 
			);

CREATE TABLE songs_artists(
			song_id BIGINT NOT NULL REFERENCES songs(song_id) ON DELETE CASCADE,
			artist_id BIGINT NOT NULL REFERENCES artists(artist_id) ON DELETE CASCADE,
			artist_role VARCHAR(50),
			PRIMARY KEY(song_id, artist_id)
			);

CREATE TABLE artists_albums (
			artist_id BIGINT NOT NULL REFERENCES artists(artist_id) ON DELETE CASCADE,
			album_id BIGINT NOT NULL REFERENCES albums(album_id) ON DELETE CASCADE,
			countributory_type VARCHAR(100),
			PRIMARY KEY (artist_id, album_id)
			);

CREATE TABLE songs_genres(
			song_id BIGINT NOT NULL REFERENCES songs(song_id) ON DELETE CASCADE,
			genre_id BIGINT NOT NULL REFERENCES genres(genre_id) ON DELETE CASCADE,
			PRIMARY KEY (song_id, genre_id)
			);

CREATE TABLE song_subgenres(
			song_id BIGINT NOT NULL REFERENCES songs(song_id) ON DELETE CASCADE,
			subgenre_id BIGINT NOT NULL REFERENCES subgenres(subgenre_id) ON DELETE CASCADE,
			PRIMARY KEY(song_id, subgenre_id)
			);

CREATE TABLE album_genres(
			album_id BIGINT NOT NULL REFERENCES albums(album_id) ON DELETE CASCADE,
			genre_id BIGINT NOT NULL REFERENCES genres(genre_id) ON DELETE CASCADE,
			PRIMARY KEY (album_id, genre_id)
			);

CREATE TABLE album_subgenres(
			album_id BIGINT NOT NULL REFERENCES albums(album_id) ON DELETE CASCADE,
			subgenre_id BIGINT NOT NULL REFERENCES subgenres(subgenre_id) ON DELETE CASCADE,
			PRIMARY KEY(album_id, subgenre_id)
			);

-- ==============================================================================================
-- USER INTERACTION TABLES
-- These tables track user engagement and activity
-- ==============================================================================================

CREATE 	TABLE listened(
			listening_id BIGSERIAL PRIMARY KEY,
			song_id BIGINT REFERENCES songs(song_id) ON DELETE SET NULL,
			user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE, 
			played_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			device_info VARCHAR(255),
			duration_played INT,
			CONSTRAINT check_duration_played CHECK (duration_played >= 0) 
			);

CREATE TABLE song_likes(
			user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
			song_id BIGINT NOT NULL REFERENCES songs(song_id) ON DELETE CASCADE,
			liked_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			PRIMARY KEY (user_id, song_id)
			);

CREATE TABLE follows(
			user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
			artist_id BIGINT NOT NULL REFERENCES artists(artist_id) ON DELETE CASCADE,
			liked_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			PRIMARY KEY (user_id, artist_id)
			);

-- ==============================================================================================
-- PARTITIONED TABLE FOR ANALYICS
-- Honestly, this is not ideal for a transaction processing database. 
-- These partitioning might be more suitable for an analytics processing database.
-- But with the rise in "wrap" trend, we might need to create a partioned table in anticipation.
-- One alternative is etl to analytics database, partitioning, and then reverse etl to software database.
-- This partitioned table is optimized for time-series queries on listening history. 
-- ==============================================================================================


CREATE TABLE listening_history(
			history_id BIGSERIAL, 
			user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
			song_id BIGINT REFERENCES songs(song_id) ON DELETE SET NULL,
			listening_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
			duration_played INT,
			device_info VARCHAR(255),
			
			PRIMARY KEY (history_id, listening_date),
			CONSTRAINT check_history_duration CHECK (duration_played >= 0) 
			)
			PARTITION BY RANGE(listening_date);

-- ==============================================================================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION 
-- We should create indexes on columns we anticipate we would frequently query. 
-- These indexes would also be used for our database views.
-- Indexes improve query performance for common access patterns.
-- ==============================================================================================

-- User Lookup

CREATE INDEX index_users_email ON users(email);
CREATE INDEX index_users_country ON users(country_id);
CREATE INDEX index_users_premium ON users(is_premium);

-- Artist Searches 

CREATE INDEX index_artists_name ON artists(artist_name);
CREATE INDEX index_artists_country ON artists(country_id);

-- Song Searches 

CREATE INDEX index_songs_title ON songs(title);
CREATE INDEX index_songs_artist ON songs(artist_id);
CREATE INDEX index_songs_album ON songs(album_id);
CREATE INDEX index_songs_popularity ON songs(popularity_score DESC);
CREATE INDEX index_songs_release_date ON songs(release_date DESC);

-- Album Searches

CREATE INDEX index_albums_title ON albums(title);
CREATE INDEX index_albums_artist ON albums(artist_id);
CREATE INDEX index_albums_release_date ON albums(release_date DESC);

-- Playlists Lookups

CREATE INDEX index_playlists_user ON playlists(user_id);
CREATE INDEX index_playlists_public ON playlists(is_public) WHERE is_public = TRUE;

-- Listening Activity

CREATE INDEX index_listened_user ON listened(user_id);
CREATE INDEX index_listened_song ON listened(song_id);
CREATE INDEX index_listened_played_at ON listened(played_at DESC);

-- Social Features

CREATE INDEX index_song_likes_user ON song_likes(user_id);
CREATE INDEX index_song_likes_song ON song_likes(song_id);
CREATE INDEX index_follows_user ON follows(user_id);
CREATE INDEX index_follows_artist ON follows(artist_id);

-- Billing

CREATE INDEX index_billing_user ON billing_history(user_id);
CREATE INDEX index_billing_due_date ON billing_history(due_date);
CREATE INDEX index_billing_unpaid ON billing_history (is_paid) WHERE is_paid = FALSE;

-- ===============================================================================================
-- COMMENTS FOR DOCUMENTATION
-- ===============================================================================================

COMMENT ON TABLE users IS 'Registered users of the music streaming platform';
COMMENT ON TABLE artists IS 'Musicians and artists who create music';
COMMENT ON TABLE songs IS 'Individual music tracks';
COMMENT ON TABLE albums IS 'Collection on songs released together';
COMMENT ON TABLE playlists IS 'User-created song collections';
COMMENT ON TABLE listened IS 'Real-time listening events for immediate tracking';
COMMENT ON TABLE listening_history IS 'Historical listening data partitioned by data partitioned by date for analytics';
COMMENT ON TABLE song_likes IS 'Songs that users have liked';
COMMENT ON TABLE follows IS 'Artists that uers follow';

COMMENT ON COLUMN songs.duration IS 'Song duration in seconds';
COMMENT ON COLUMN songs.popularity_score IS 'Popularity score from 0-100';
COMMENT ON COLUMN billing_history.billed_amount IS 'Amount billed in USD';
COMMENT ON COLUMN listened.duration_played IS 'How many seconds the listener actually listened';

