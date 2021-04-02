-- constructeurs
ALTER SEQUENCE constructeur_idConstructeur_seq RESTART WITH 1;
INSERT INTO FLOTTEDB.constructeur (nomCompagnie, type_constructeur, pays)
    VALUES ('Boeing Co', 'Avionneur', 'USA');
INSERT INTO FLOTTEDB.constructeur (nomCompagnie, type_constructeur, pays)
    VALUES ('Bombardier Aero', 'Avionneur','Canada');
INSERT INTO FLOTTEDB.constructeur (nomCompagnie, type_constructeur, pays)
    VALUES ('Airbus Industries', 'Avionneur', 'France');
INSERT INTO FLOTTEDB.constructeur (nomCompagnie, type_constructeur, pays)
    VALUES ('General Electric', 'Motoriste', 'USA');
INSERT INTO FLOTTEDB.constructeur (nomCompagnie, type_constructeur, pays)
    VALUES ('Pratt & Whitney', 'Motoriste', 'USA');
INSERT INTO FLOTTEDB.constructeur (nomCompagnie, type_constructeur, pays)
    VALUES ('Rolls Royce', 'Motoriste', 'Angleterre');

-- avions
ALTER SEQUENCE avion_idAvion_seq RESTART WITH 1;
INSERT INTO FLOTTEDB.avion (modele, idConstructeur, nbMoteurs, nbSieges)
    VALUES ('B747-400', 1, 4, 420);
INSERT INTO FLOTTEDB.avion (modele, idConstructeur, nbMoteurs, nbSieges)
    VALUES ('B757-200', 1, 2, 243);
INSERT INTO FLOTTEDB.avion (modele, idConstructeur, nbMoteurs, nbSieges)
    VALUES ('B727',     1, 2, 160);
INSERT INTO FLOTTEDB.avion (modele, idConstructeur, nbMoteurs, nbSieges)
    VALUES ('A340-600', 3, 2, 380);
INSERT INTO FLOTTEDB.avion (modele, idConstructeur, nbMoteurs, nbSieges)
    VALUES ('A340-500', 3, 2, 313);
INSERT INTO FLOTTEDB.avion (modele, idConstructeur, nbMoteurs, nbSieges)
    VALUES ('A330-300', 3, 2, 362);
INSERT INTO FLOTTEDB.avion (modele, idConstructeur,  nbMoteurs, nbSieges)
    VALUES ('A330-200', 3, 2, 363);
INSERT INTO FLOTTEDB.avion (modele, idConstructeur, nbMoteurs, nbSieges)
    VALUES ('A310-300', 3, 2, 259);

--  moteurs
ALTER SEQUENCE moteur_idMoteur_seq RESTART WITH 1;
INSERT INTO FLOTTEDB.moteur (modele, idConstructeur, diametre, longueur, poids, poussee )
    VALUES ('CF34-10D',    4, 57,  90,   3800, 18500);
INSERT INTO FLOTTEDB.moteur (modele, idConstructeur, diametre, longueur, poids, poussee )
    VALUES ('CF34-3A',     4, 49,  103,  1625, 9220);
INSERT INTO FLOTTEDB.moteur (modele, idConstructeur, diametre, longueur, poids, poussee )
    VALUES ('CF34-8C1',    4, 52,  128,  2350, 13790);
INSERT INTO FLOTTEDB.moteur (modele, idConstructeur, diametre, longueur, poids, poussee )
    VALUES ('CF6-50C1',    4, 105, 183,  8966, 52500);
INSERT INTO FLOTTEDB.moteur (modele, idConstructeur, diametre, longueur, poids, poussee )
    VALUES ('CF6-80E1A4',  4, 106, 168,  9790, 68100);
INSERT INTO FLOTTEDB.moteur (modele, idConstructeur, diametre, longueur, poids, poussee )
    VALUES ('RB211-524G',  6, 110, 150,  9100, 58000);
INSERT INTO FLOTTEDB.moteur (modele, idConstructeur, diametre, longueur, poids, poussee )
    VALUES ('RB211-535E4', 6, 110, 150,  9100, 40100);
INSERT INTO FLOTTEDB.moteur (modele, idConstructeur, diametre, longueur, poids, poussee )
    VALUES ('TRENT556',    6, 97,  145,  8900, 56000);
INSERT INTO FLOTTEDB.moteur (modele, idConstructeur, diametre, longueur, poids, poussee )
    VALUES ('TRENT553',    6, 97,  145,  8900, 53000);
INSERT INTO FLOTTEDB.moteur (modele, idConstructeur, diametre, longueur, poids, poussee )
    VALUES ('PW400-100',   5, 100, 163,  9200, 64500);
INSERT INTO FLOTTEDB.moteur (modele, idConstructeur, diametre, longueur, poids, poussee )
    VALUES ('JT9D',        5, 93,  132,  8900, 56000);

-- flotte
INSERT INTO FLOTTEDB.flotte (noSerieAvion, noSerieMoteur, idMoteur, idAvion, vitesse, autonomie, dateService, heuresVol, dateRetrait)
    VALUES ('1358D', 'S L120-8', 1, 2, 890, 34.5, '1982-12-04', 2300, '2006-10-17');
INSERT INTO FLOTTEDB.flotte (noSerieAvion, noSerieMoteur, idMoteur, idAvion, vitesse, autonomie, dateService, heuresVol, dateRetrait)
    VALUES ('2945F', 'pw340-A',  2, 5, 850, 43.1, '1994-04-12', 4500, NULL);


