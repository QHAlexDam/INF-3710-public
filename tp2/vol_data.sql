SET search_path = volDB;

INSERT INTO VOLDB.aeroport (codeAeroport, ville) 
    VALUES ('YUL', 'Montreal');
INSERT INTO VOLDB.aeroport (codeAeroport, ville) 
    VALUES ('RBA', 'Rabat');

INSERT INTO VOLDB.passager (noPassager, nomPassager, prenomPassager) 
    VALUES ('p1', 'Doe', 'John');
INSERT INTO VOLDB.passager (noPassager, nomPassager, prenomPassager) 
    VALUES ('p2', 'Deep', 'Marc');
INSERT INTO VOLDB.passager (noPassager, nomPassager, prenomPassager) 
    VALUES ('p3', 'Lawrence', 'Anthony');
INSERT INTO VOLDB.passager (noPassager, nomPassager, prenomPassager) 
    VALUES ('p4', 'Baker', 'Adam');
INSERT INTO VOLDB.passager (noPassager, nomPassager, prenomPassager) 
    VALUES ('p5', 'Philips', 'Frank');

INSERT INTO VOLDB.avion (noAppareil, fabricant, modele, dateAcquisition, nombreDeSiege) 
    VALUES ('A505', 'Airbus', '182421rA', DATE'2019-04-01', '300');
INSERT INTO VOLDB.avion (noAppareil, fabricant, modele, dateAcquisition, nombreDeSiege) 
    VALUES ('B300', 'Boing', '0099srvs', DATE'2018-04-01', '500');

INSERT INTO VOLDB.vol (noVol, dateDepart, heureDepart, heureArrivee, dateArrivee, codeAeroportDepart, codeAeroportArrivee , noAppareil) 
    VALUES ('P221', DATE'2020-01-15', TIME'12:05', TIME'19:15', DATE'2020-01-15', 'YUL', 'RBA', 'A505');
INSERT INTO VOLDB.vol (noVol, dateDepart, heureDepart, heureArrivee, dateArrivee, codeAeroportDepart, codeAeroportArrivee , noAppareil) 
    VALUES ('L889', DATE'2020-02-05', TIME'18:05', TIME'08:30', DATE'2020-02-06', 'YUL', 'RBA', 'B300');

INSERT INTO VOLDB.client (noClient, nomClient, prenomClient) 
    VALUES ('c1', 'Abbot', 'Josh');
INSERT INTO VOLDB.client (noClient, nomClient, prenomClient) 
    VALUES ('c2', 'Ferdinand', 'Julie');

INSERT INTO VOLDB.reservation (noReservation, dateReservation, prixTotal, paiementEffectue, noClient, noPassager, noVol) 
    VALUES ('355', DATE'2020-01-05', '1500.00', '1000.00', 'c1', 'p1', 'P221');
INSERT INTO VOLDB.reservation (noReservation, dateReservation, prixTotal, paiementEffectue, noClient, noPassager, noVol) 
    VALUES ('356', DATE'2020-01-05', '1500.00', '1000.00', 'c1', 'p2', 'P221');
INSERT INTO VOLDB.reservation (noReservation, dateReservation, prixTotal, paiementEffectue, noClient, noPassager, noVol) 
    VALUES ('357', DATE'2020-01-05', '1500.00', '1000.00', 'c1', 'p3', 'p221');
INSERT INTO VOLDB.reservation (noReservation, dateReservation, prixTotal, paiementEffectue, noClient, noPassager, noVol) 
    VALUES ('115', DATE'2020-01-05', '2000.00', '1600.00', 'c2', 'p4', 'L889');
INSERT INTO VOLDB.reservation (noReservation, dateReservation, prixTotal, paiementEffectue, noClient, noPassager, noVol) 
    VALUES ('116', DATE'2020-01-05', '2000.00', '1600.00', 'c2', 'p5', 'L889');