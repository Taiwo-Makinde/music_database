# Music Streaming Database

A relational database schema designed for music streaming platforms, supporting user management, playlists, artist catalogs, and streaming analytics.

## Table of Contents
- [Architecture](#Architecture)
  - [Design Principles](#Design-Principles) 
- [Features](#Features)
- [Database Schema](#Database-Schema)
  - [Core Tables](#Core-Tables)
  - [Transaction Tables](#Transaction-Tables)
  - [Supporting Tables](#Supporting-Tables)
- [Prerequisites](#Prerequisites)
- [Performance Considerations](#Performance-Considerations)
- [Future Enhancement](#Future-Enhancement)
- [Project Structure](#Project-Structure)
- [Acknowledgements](#Acknowledgements)
- [Version History](#Version-History)

## Architecture 

- **Database Type**: Postgres 18

- **Schema Design**: SnowFlake schema(highly normalized)

- **Optimization**: OLTP (Online Transaction Processing)

- **Normalization Level**: 3NF (Third Normal Form)

This database is designed to handle high-volume transactional operations such as user registrations, playlist updates, and real-time streaming events while maintaining data integrity and minimizing data redundancy through normalization. 

### Design Principles 

- **Transactional Integrity**: ACID compliance for reliable concurrent operations. 

- **Data Consistency**: Normalization eliminates update anomalies and redundancy.

- **Scalability**: Optimized for frequent INSERT, UPDATE, and DELETE operations.

- **Referential Integrity**: Foreign key constraints maintain relationship consistency

## Features

- Complete artist, albums, and track catalog management

- User profiles with listening history and preferences

- Playlist creation and sharing capabilities

- Subscription tier management 

- Optimised for real-time streaming analytics and metrics

- Optimised for search functionality across artists, albums, tracks, labels, etc.  

- Genre and mood categorization

- User follow system for artists and other users

- Track and playlist sharing

- Partitioned tables for efficient 'Wrapped' trend analytics and yearly listening summaries 


## Database-Schema

The database includes the following main entities, among others:

### Core-Table
- 'users' - User accounts and profiles 
- 'artists' - Music artists and bands
- 'album' - Album information 
- 'tracks' - Individual songs
- 'playlists' - User-created playlists

### Junction Tables

- 'playlists_tracks' - Playlist-Track relationships
- 'albums_artists' - Album-Artists relationships for collaboration 
- 'track-genres' - Track-genre classifications

### Transaction-Tables

- 'streams' - streaming event logs 
-  'subscriptions' - User subscriptions tiers and billing 
- 'user_follows' - User following relationships
- 'likes' - user likes ontracks, albums and playlists. 

### Supporting-Tables

- 'countries' - Geographic information 
- 'labels' - Record labels 
- 'genres' - Music genre classification 

See [schema_diagram.png](diagrams/scham_diagram.png) for the complete ER diagram and all the available tables. 

## Prerequisites

- PostgreSQL 14+ (or compatible version)
- Basic understanding of SQL and relational databases
- psql command-line tool or database management GUI (pgadmin, DBeaver, etc)

## Performance-Considerations

- Indexes are created on frequently queried columns (user_id, track_id, artist_id)
- Materialized views for complex analytical queries


## Future-Enhancements

- [ ] Partitioning for streams table
- [ ] Regular VACUUM and ANALYZE operations
- [ ] Support for podcasts and audiobooks
- [ ] Add social features (comment and reviews)
- [ ] Advanced analytics 

## Project-Structure

| Folder | Purpose | When to Use |
| ------ | -------- | ----------- |
| **diagrams/** | Visual database diagrams (Entity relationship model diagram) | Understanding relationships and architecture|
| **schema/** | SQL table definitions and indexes | Initial database setup |
| **migrations/** | Version-controlled schema changes | Updating existing databases |
| **seeds/** | Reference and test data | Populating lookup tables and testing | 
| **security/** | Roles, permissiions, RLS policies | Access control configuration |
|**scripts/** | Maintenance and utility scripts | Ongoing operations and monitoring |

## Acknowledgements

- Inspired by real-world music streaming platforms 


 ---

 ⭐  If you find this project helpful, please give it a star! 
 
## Version-History

### Version 1.0.1 (February 2026)
