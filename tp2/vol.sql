-- CREATE DATABASE volDB;

SET search_path = volDB;

DROP SCHEMA IF EXISTS VOLDB CASCADE;
CREATE SCHEMA VOLDB;

CREATE TABLE IF NOT EXISTS VOLDB.client (
    noClient        VARCHAR(10)     NOT NULL,
    nomClient       VARCHAR(20)     NOT NULL,
    prenomClient    VARCHAR(20)     NOT NULL,
    PRIMARY KEY (noClient)
);

CREATE TABLE IF NOT EXISTS VOLDB.aeroport (
    codeAeroport    VARCHAR(10)     NOT NULL,
    ville           VARCHAR(20)     NOT NULL,
    PRIMARY KEY (codeAeroport)
);

CREATE TABLE IF NOT EXISTS VOLDB.carteCredit (
    noCarte         VARCHAR(10)     NOT NULL,
    expiration      DATE            NOT NULL,
    nomDuTitulaire  VARCHAR(20)     NOT NULL,
    PRIMARY KEY (noCarte)
);

CREATE DOMAIN VOLDB.sexeType AS CHAR
	CHECK (VALUE IN ('M', 'F'));

CREATE TABLE IF NOT EXISTS VOLDB.passager (
    noPassager      VARCHAR(10)     NOT NULL,
    nomPassager     VARCHAR(20)     NOT NULL,
    prenomPassager  VARCHAR(20)     NOT NULL,
    sexe            sexeType        DEFAULT 'M',
    PRIMARY KEY (noPassager)
);

CREATE TABLE IF NOT EXISTS VOLDB.avion (
    noAppareil      VARCHAR(10)     NOT NULL,
    fabricant       VARCHAR(10)     NOT NULL,
    modele          VARCHAR(10)     NOT NULL,
    dateAcquisition DATE            NOT NULL,
    nombreDeSiege   NUMERIC(4,0)    NOT NULL,
    PRIMARY KEY (noAppareil)
);

CREATE TABLE IF NOT EXISTS VOLDB.vol (
    noVol           VARCHAR(10)     NOT NULL,
    dateDepart      DATE            NOT NULL,
    heureDepart     TIME            NOT NULL,
    heureArrivee     TIME            NOT NULL,
    dateArrivee     DATE            NOT NULL,
    codeAeroportDepart    VARCHAR(10)     NOT NULL,
    codeAeroportArrivee    VARCHAR(10)     NOT NULL,
    noAppareil      VARCHAR(10)     NOT NULL,
    PRIMARY KEY (noVol),
    FOREIGN KEY (codeAeroportDepart) REFERENCES VOLDB.aeroport(codeAeroport)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (codeAeroportArrivee) REFERENCES VOLDB.aeroport(codeAeroport)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (noAppareil) REFERENCES VOLDB.avion(noAppareil)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS VOLDB.reservation (
    noReservation       VARCHAR(10)     NOT NULL,
    dateReservation     DATE            NOT NULL,
    prixTotal           NUMERIC(8,2)    NOT NULL,
    paiementEffectue    NUMERIC(8,2)    NOT NULL,
    noClient            VARCHAR(10)     NOT NULL,
    noPassager          VARCHAR(10)     NOT NULL,
    noVol               VARCHAR(10)     NOT NULL,
    PRIMARY KEY (noReservation),
    FOREIGN KEY (noClient) REFERENCES VOLDB.client(noClient)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (noPassager) REFERENCES VOLDB.passager(noPassager)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (noVol) REFERENCES VOLDB.vol(noVol)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS VOLDB.paiement (
    noPaiement      VARCHAR(10)     NOT NULL,
    datePaiement    DATE            NOT NULL,
    montantPaiement NUMERIC(8,2)    NOT NULL,
    noReservation   VARCHAR(10)     NOT NULL,
    noCarte         VARCHAR(10)     NOT NULL,
    PRIMARY KEY (noPaiement, noReservation, noCarte),
    FOREIGN KEY (noReservation) REFERENCES VOLDB.reservation(noReservation)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (noCarte) REFERENCES VOLDB.carteCredit(noCarte)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS VOLDB.billet (
    noBillet        VARCHAR(10)     NOT NULL,
    noReservation   VARCHAR(10)     NOT NULL,
    noPassager      VARCHAR(10)     NOT NULL,
    PRIMARY KEY (noBillet, noReservation, noPassager),
    FOREIGN KEY (noReservation) REFERENCES VOLDB.reservation(noReservation)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (noPassager) REFERENCES VOLDB.passager(noPassager)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS VOLDB.baggage (
    noBaggage           VARCHAR(10)     NOT NULL,
    dateEnregistrement  DATE            NOT NULL,
    heureEnregistrement TIME            NOT NULL,
    noPassager          VARCHAR(10)     NOT NULL,
    noVol               VARCHAR(10)     NOT NULL,
    PRIMARY KEY (noBaggage, noPassager, noVol),
    FOREIGN KEY (noPassager) REFERENCES VOLDB.passager(noPassager)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (noVol) REFERENCES VOLDB.vol(noVol)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE DOMAIN VOLDB.responsabiliteType AS CHAR
	CHECK (VALUE IN ('P', 'H'));

CREATE TABLE IF NOT EXISTS VOLDB.employe (
    noEmploye       VARCHAR(10)         NOT NULL,
    nateEmbauche    DATE                NOT NULL,
    responsabilite  responsabiliteType  DEFAULT 'H',
    noVol           VARCHAR(10)         NOT NULL,
    PRIMARY KEY (noEmploye),
    FOREIGN KEY (noVol) REFERENCES VOLDB.vol(noVol)
        ON DELETE RESTRICT ON UPDATE CASCADE
 );

CREATE TABLE IF NOT EXISTS VOLDB.pilote (
    noLicence               VARCHAR(10)         NOT NULL,
    dateObtentionLicence    DATE                NOT NULL,
    noEmploye               VARCHAR(10)         NOT NULL,
    PRIMARY KEY (noLicence, noEmploye),
    FOREIGN KEY (noEmploye) REFERENCES VOLDB.employe(noEmploye)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS VOLDB.annulation (
    noAnnulation    VARCHAR(10)         NOT NULL,
    raison          VARCHAR(20),
    noVol           VARCHAR(10)         NOT NULL,
    PRIMARY KEY (noAnnulation, noVol),
    FOREIGN KEY (noVol) REFERENCES VOLDB.vol(noVol)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS VOLDB.retard (
    noRetard        VARCHAR(10)     NOT NULL,
    minutesAuDepart TIME            NOT NULL,
    minutesArrive   TIME            NOT NULL,
    raison          VARCHAR(20),
    noVol           VARCHAR(10)     NOT NULL,
    PRIMARY KEY (noRetard, noVol),
    FOREIGN KEY (noVol) REFERENCES VOLDB.vol(noVol)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE DOMAIN VOLDB.classeType AS CHAR
	CHECK (VALUE IN ('P', 'E'));

CREATE TABLE IF NOT EXISTS VOLDB.siege (
    noSiege     VARCHAR(10)     NOT NULL,
    classe      classeType      DEFAULT 'E',
    noAppareil  VARCHAR(10)     NOT NULL,
    PRIMARY KEY (noSiege, noAppareil),
    FOREIGN KEY (noAppareil) REFERENCES VOLDB.avion(noAppareil)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS VOLDB.tarif (
    codeTarif       VARCHAR(10)     NOT NULL,
    condition       VARCHAR(20)     NOT NULL,
    noReservation   VARCHAR(10)     NOT NULL,
    PRIMARY KEY (codeTarif, noReservation),
    FOREIGN KEY (noReservation) REFERENCES  VOLDB.reservation(noReservation)
        ON DELETE RESTRICT ON UPDATE CASCADE
);







