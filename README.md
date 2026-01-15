# Music Streaming Database

A relational database schema designed for music streaming platforms, supporting user management, playlists, artist catalogs, and streaming analytics.

## Architecture 

-- **Database Type**: Postgres 18

-- **Schema Design**: Snowflake schema(hioghly normalized

-- **Optimization**: OLTP (Online Transaction Processing)

-- **Normalization Level**: 3NF (Third Normal Form)

This database is designed to handle high-volume transactional operations such as user registrations, playlist updates, and real-time streaming events while maintaining data integrity and minimising data redundancy through normalization. 

## Design Principles 

-- **Transactional Integrity**: ACID compliance for reliable concurrent operations. 

-- **Data Consistency**: Normalization eliminates update anomalies and redundancy.

-- **Scalability**: Optimized for frequent INSERT, UPDATE, and DELETE operations.

-- **Referential Integrity**: Foreign key constraints maintain relationship consistency

## Features

-- Complete artist, albums, and track catalog management

-- User profiles with listening history and preferences

-- Playlist creation and sharing capabilities

-- Subscription tier management 

-- Optimised for real-time streaming analytics and metrics

-- Optimised for search functionality across artists, albums, tracks, labels, etc.  

-- Partitioned tables for 'wrap' trend 
