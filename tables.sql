DROP TABLE IF EXISTS movie;
Create Table movie(
	mid varchar(127) NOT NULL PRIMARY KEY,
	title varchar(127),
	year integer);


DROP TABLE IF EXISTS actor;
CREATE TABLE actor (
 id INTEGER NOT NULL PRIMARY KEY,
 name varchar(127),
 movie_id varchar(127),
 role varchar(127),
 position Integer,
 FOREIGN KEY (movie_id) REFERENCES movie (mid));


DROP TABLE IF EXISTS actress;
CREATE TABLE actress (
 id INTEGER NOT NULL PRIMARY KEY,
 name varchar(127),
 movie_id varchar(127),
 role varchar(127),
 position Integer,
 FOREIGN KEY (movie_id) REFERENCES movie (mid));


DROP TABLE IF EXISTS producer;
CREATE TABLE producer (
 id INTEGER NOT NULL PRIMARY KEY,
 name varchar(127),
 movie_id varchar(127),
 role varchar(127),
 FOREIGN KEY (movie_id) REFERENCES movie (mid));


DROP TABLE IF EXISTS genre;
CREATE TABLE genre (
 id INTEGER NOT NULL PRIMARY KEY,
 movie_id varchar(127),
 genre varchar(127),
 FOREIGN KEY (movie_id) REFERENCES movie (mid));

