SET search_path = netflix_polyDB;

DROP SCHEMA IF EXISTS NETFLIX_POLYDB CASCADE;
CREATE SCHEMA NETFLIX_POLYDB;

CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Member (
    member_id               SERIAL,
    first_name              VARCHAR(255) NOT NULL,
    last_name               VARCHAR(255) NOT NULL,
    email                   VARCHAR(255) NOT NULL,
    password                VARCHAR(255) NOT NULL,
    address_no              INT NOT NULL,
    address_road            VARCHAR(255) NOT NULL,
    address_postal_code     VARCHAR(255) NOT NULL,
    address_town            VARCHAR(255) NOT NULL,
    PRIMARY KEY (member_id)
);

CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Member_monthly (
    member_id               INT NOT NULL,
    price_monthly           NUMERIC(6,2) NOT NULL,
    subscription_begin      DATE NOT NULL,
    subscription_end        DATE NOT NULL,
    PRIMARY KEY (member_id),
    FOREIGN KEY (member_id) REFERENCES NETFLIX_POLYDB.Member(member_id)
);

CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Member_per_vue (
    member_id              INT NOT NULL,
    nb_views               INT NOT NULL,
    PRIMARY KEY (member_id),
    FOREIGN KEY (member_id) REFERENCES NETFLIX_POLYDB.Member(member_id)
);

CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Account (
    member_id              INT NOT NULL,
    total_watch_time       NUMERIC(5,2) DEFAULT 0.0 NOT NULL,
    nb_dvd_ordered         INT DEFAULT 0 NOT NULL,
    viewed_films_id        INT ARRAY,
    purchased_dvd_id       INT ARRAY,
    PRIMARY KEY (member_id),
    FOREIGN KEY (member_id) REFERENCES NETFLIX_POLYDB.Member(member_id)   
);

CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Credit_card (
    card_id                 SERIAL,
    member_id               INT NOT NULL,
    card_holder             VARCHAR(255) NOT NULL,
    card_number             VARCHAR(16) NOT NULL,
    expiration_date         DATE NOT NULL, 
    CCV                     VARCHAR(3) NOT NULL,
    PRIMARY KEY (card_id, member_id),
    FOREIGN KEY (member_id) REFERENCES NETFLIX_POLYDB.Member(member_id)
);

CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Film (
    film_id                 SERIAL,
    title                   VARCHAR(255) NOT NULL,
    genre                   VARCHAR(255) NOT NULL,
    production_date         VARCHAR(4) NOT NULL,
    lenght_minutes          INT NOT NULL,
    last_ordered_date       DATE,
    PRIMARY KEY (film_id)
);

CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Film_streaming (
    film_id                 INT,
    stream_begin_date       DATE NOT NULL,
    stream_time_minutes     NUMERIC(4,2) NOT NULL,
    per_view_price          NUMERIC(4,2) NOT NULL,
    times_viewed            INT DEFAULT 0 NOT NULL,
    PRIMARY KEY (film_id),
    FOREIGN KEY (film_id) REFERENCES NETFLIX_POLYDB.Film(film_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Film_dvd (
    dvd_id                  SERIAL,
    film_id                 INT,
    price                   NUMERIC(4,2) NOT NULL,
    times_bought            INT DEFAULT 0 NOT NULL,
    PRIMARY KEY (dvd_id, film_id),
    FOREIGN KEY (film_id) REFERENCES NETFLIX_POLYDB.Film(film_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TYPE SEX AS ENUM('M', 'F');

CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Participant (
    participant_id          SERIAL,
    first_name              VARCHAR(255) NOT NULL,
    last_name               VARCHAR(255) NOT NULL,
    sex                     SEX NOT NULL, 
    province_state          VARCHAR(255) NOT NULL,
    country                 VARCHAR(255) NOT NULL,
    birth_date              DATE NOT NULL,
    PRIMARY KEY (participant_id)
);

CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Role (
    participant_id          INT,
    film_id                 INT,
    role_name               VARCHAR(255) NOT NULL,
    salary                  NUMERIC(7,2) NOT NULL,
    PRIMARY KEY (participant_id, film_id, role_name),
    FOREIGN KEY (participant_id) REFERENCES NETFLIX_POLYDB.Participant(participant_id),
    FOREIGN KEY (film_id) REFERENCES NETFLIX_POLYDB.Film(film_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Ceremony (
    ceremony_id             SERIAL,
    ceremony_date           DATE NOT NULL,
    ceremony_mc_name        VARCHAR(255) NOT NULL,
    ceremony_location       VARCHAR(255) NOT NULL,
    PRIMARY KEY (ceremony_id)
);

CREATE TYPE CAT AS ENUM('Best Actor', 'Best Sound', 'Best fx', 'Best supporting'); --en exemple seulement
CREATE TABLE IF NOT EXISTS NETFLIX_POLYDB.Nomination (
    ceremony_id             INT,
    film_id                 INT,
    category_name           CAT NOT NULL,
    is_winner               BOOLEAN NOT NULL,
    PRIMARY KEY (ceremony_id, film_id, category_name),
    FOREIGN KEY (ceremony_id) REFERENCES NETFLIX_POLYDB.Ceremony(ceremony_id),
    FOREIGN KEY (film_id) REFERENCES NETFLIX_POLYDB.Film(film_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TYPE FILM_TYPE AS ENUM('stream', 'dvd');
CREATE TABLE IF NOT EXISTS netflix_polydb.order (
	order_id 		SERIAL,
	member_id 		INT NOT NULL,
    film_id         INT NOT NULL,
    order_type      FILM_TYPE NOT NULL,
    order_date      DATE,
	PRIMARY KEY 	(order_id),
	FOREIGN KEY 	(member_id) REFERENCES netflix_polydb.member(member_id)
);
CREATE TABLE IF NOT EXISTS netflix_polydb.shipping (
	order_id 				INT,
	dvd_id					INT NOT NULL,
	price					NUMERIC(4, 2) NOT NULL,
	shipping_date			DATE NOT NULL, 				
	distance			 	INT,
	PRIMARY KEY 			(order_id),
	FOREIGN KEY 			(order_id) REFERENCES netflix_polydb.order(order_id)
);

