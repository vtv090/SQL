DROP TABLE IF EXISTS PRODUCTION;
Create Table PRODUCTION(
	production varchar(127) NOT NULL PRIMARY KEY,
	title varchar(127),
	runtime integer,
	year integer);


DROP TABLE IF EXISTS MOVIE;
CREATE TABLE MOVIE (
	production varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	typ varchar(127));


DROP TABLE IF EXISTS GENRE;
CREATE TABLE GENRE (
	production varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	genre varchar(127) NOT NULL PRIMARY KEY);


DROP TABLE IF EXISTS KEYWORD;
CREATE TABLE KEYWORD (
	production varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	keyword varchar(127) NOT NULL PRIMARY KEY);


DROP TABLE IF EXISTS COUNTRY;
CREATE TABLE COUNTRY (
	production varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	country varchar(127) NOT NULL PRIMARY KEY);

DROP TABLE IF EXISTS LOCATION;
CREATE TABLE LOCATION (
	production varchar(127),
	country varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	FOREIGN KEY (country) REFERENCES COUNTRY (country),
	location varchar(127) NOT NULL PRIMARY KEY);



DROP TABLE IF EXISTS LANGUAGES;
CREATE TABLE LANGUAGES (
	production varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	languages varchar(127) NOT NULL PRIMARY KEY);


DROP TABLE IF EXISTS LANGUAGES;
CREATE TABLE LANGUAGES (
	production varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	languages varchar(127) NOT NULL PRIMARY KEY);



DROP TABLE IF EXISTS RELEASES;
CREATE TABLE RELEASES (
	production varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	country varchar(127) NOT NULL PRIMARY KEY,
	years varchar(127),
	months varchar(127),
	days varchar(127));


DROP TABLE IF EXISTS AKA;
CREATE TABLE AKA (
	production varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	country varchar(127) NOT NULL PRIMARY KEY,
	aka varchar(127) NOT NULL PRIMARY KEY);



DROP TABLE IF EXISTS QUOTE;
CREATE TABLE QUOTE (
	production varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	dialog varchar(127) NOT NULL PRIMARY KEY,
	line varchar(127) NOT NULL PRIMARY KEY,
	quote varchar(127));


DROP TABLE IF EXISTS BUDGET;
CREATE TABLE BUDGET (
	production varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	budget varchar(127),
	currency varchar(127));
	

DROP TABLE IF EXISTS RATING;
CREATE TABLE RATING (
	production varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	rating varchar(127),
	votes varchar(127));


DROP TABLE IF EXISTS LINK;
CREATE TABLE LINK (
	production1 varchar(127),
	production2 varchar(127),
	FOREIGN KEY (production1) REFERENCES PRODUCTION (production),
	FOREIGN KEY (production2) REFERENCES PRODUCTION (production),
	link varchar(127) NOT NULL PRIMARY KEY);


DROP TABLE IF EXISTS SERIES;
CREATE TABLE SERIES (
	series varchar(127) NOT NULL PRIMARY KEY,
	title varchar(127),
	years varchar(127));


DROP TABLE IF EXISTS EPISODE;
CREATE TABLE EPISODE (
	production varchar(127),
	series varchar(127),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	FOREIGN KEY (series) REFERENCES SERIES (series),
	season varchar(127),
	episode varchar(127),
	air_date varchar(127));


DROP TABLE IF EXISTS PERSON;
CREATE TABLE PERSON (
	person varchar(127) NOT NULL PRIMARY KEY,
	name varchar(127),
	realname varchar(127),
	sex varchar(127),
	height varchar(127),
	birth_date varchar(127),
	birth_country varchar(127),
	birth_location varchar(127),
	death_date varchar(127),
	death_country varchar(127),
	death_location varchar(127));



DROP TABLE IF EXISTS PARENTS;
CREATE TABLE PARENTS (
	person varchar(127),
	mother varchar(127),
	father varchar(127),
	FOREIGN KEY (person) REFERENCES PERSON (person),
	FOREIGN KEY (mother) REFERENCES PERSON (person),
	FOREIGN KEY (father) REFERENCES PERSON (person));


DROP TABLE IF EXISTS WORKS;
CREATE TABLE WORKS (
	person varchar(127),
	production varchar(127),
	FOREIGN KEY (person) REFERENCES PERSON (person),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	job varchar(127) NOT NULL PRIMARY KEY,
	credit_pos varchar(127));


DROP TABLE IF EXISTS PLAYS;
CREATE TABLE PLAYS (
	person varchar(127),
	production varchar(127),
	FOREIGN KEY (person) REFERENCES PERSON (person),
	FOREIGN KEY (production) REFERENCES PRODUCTION (production),
	role varchar(127) NOT NULL PRIMARY KEY);










