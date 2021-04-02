-- CREATE DATABASE flotteDB

SET search_path = flotteDB;

DROP SCHEMA IF EXISTS FLOTTEDB CASCADE;
CREATE SCHEMA FLOTTEDB;


CREATE DOMAIN FLOTTEDB.typeConstructeur AS CHAR(10)
	CHECK (VALUE IN ('Motoriste', 'Avionneur', 'Systemes'));

CREATE TABLE IF NOT EXISTS FLOTTEDB.constructeur (
    idConstructeur      SERIAL RESTART WITH 1,
    nomCompagnie        VARCHAR(20) NOT NULL,
    type_constructeur   typeConstructeur NOT NULL,
    pays                VARCHAR(20) NOT NULL,
    PRIMARY KEY (idConstructeur)
);

CREATE TABLE IF NOT EXISTS FLOTTEDB.avion (
    idAvion         SERIAL RESTART WITH 1,       
    modele          VARCHAR(20) NOT NULL,
    idConstructeur  INT NOT NULL,
    nbMoteurs       INT NOT NULL,
    nbSieges        INT NOT NULL,
    PRIMARY KEY (idAvion),
    FOREIGN KEY (idConstructeur) REFERENCES FLOTTEDB.constructeur(idConstructeur)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS FLOTTEDB.moteur (
    idMoteur            SERIAL RESTART WITH 1,       
    modele              VARCHAR(20) NOT NULL,
    idConstructeur      INT NOT NULL,
    diametre            DECIMAL NOT NULL,
    longueur            DECIMAL NOT NULL,
    poids               DECIMAL NOT NULL,
    poussee             DECIMAL NOT NULL,
    PRIMARY KEY (idMoteur),
    FOREIGN KEY (idConstructeur) REFERENCES FLOTTEDB.constructeur(idConstructeur)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS FLOTTEDB.flotte (
    noSerieAvion        VARCHAR(20) NOT NULL, 
    noSerieMoteur       VARCHAR(20) NOT NULL, 
    idMoteur            INT NOT NULL, 
    idAvion             INT NOT NULL, 
    vitesse             DECIMAL NOT NULL,
    autonomie           DECIMAL NOT NULL, 
    dateService         DATE NOT NULL, 
    heuresVol           DECIMAL NOT NULL, 
    dateRetrait         DATE,
    PRIMARY KEY (noSerieAvion, noSerieMoteur),
    FOREIGN KEY (idMoteur) REFERENCES FLOTTEDB.moteur(idMoteur)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idAvion) REFERENCES FLOTTEDB.avion(idAvion)
        ON DELETE RESTRICT ON UPDATE CASCADE
);