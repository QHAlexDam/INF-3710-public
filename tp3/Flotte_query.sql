--1) (1 point) Retourner le nombre d'appareils produits par pays.
SELECT pays, COUNT(*)
FROM flottedb.constructeur c, flottedb.avion a
WHERE a.idConstructeur = c.idConstructeur
GROUP BY pays;

--2) (1.5 point) Retourner le nombre d'appareils produits par pays dont le nombre de sièges 
--est supérieur à 200.
SELECT pays, COUNT(*)
FROM flottedb.constructeur c, flottedb.avion a
WHERE a.idConstructeur = c.idConstructeur AND a.nbSieges > 200
GROUP BY pays;

--3) (1 point) Préparer une requête afin de réaliser une analyse de l’état de la flotte à 
--partir des données suivantes : le modèle, le nombre de sièges, le nombre d’heures accumulées 
--et la vitesse.
SELECT a.modele AS modeleAvion , m.modele AS modeleMoteur, a.nbSieges, heuresVol, vitesse
FROM flottedb.avion a, flottedb.moteur m, flottedb.flotte f
WHERE f.idAvion = a.idAvion AND f.idMoteur = m.idMoteur;

--4) (1.5 point) Quels sont les avions encore en service ? Proposer une requête en listant 
--l’avion, son modèle, le nombre de sièges et le nombre d’heures de vol.
SELECT a.idAvion, a.modele, a.nbSieges, heuresVol
FROM flottedb.avion a, flottedb.flotte f
WHERE f.idAvion = a.idAvion;

--5) (1 point) Retourner le nombre de sièges et le nombre d’heures de vol des flottes.
SELECT a.nbSieges, heuresVol
FROM flottedb.avion a, flottedb.flotte f
WHERE f.idAvion = a.idAvion;

--6) (1 point) Quels sont le ou les modèles d'appareils dont le nombre de sièges est supérieur 
--à 300? Affichez le modèle et le nom de la compagnie.
SELECT a.modele, c.nomCompagnie
FROM flottedb.constructeur c, flottedb.avion a
WHERE a.idConstructeur = c.idConstructeur AND a.nbSieges > 300;

--7) (1.5 point) Quel est le nombre d'appareil (avions) dont le nombre des sièges est supérieur 
--à la moyenne des sièges de tous les appareils, en utilisant une ou des sous-requêtes?
SELECT COUNT(*)
FROM flottedb.avion a
WHERE a.nbSieges > (SELECT AVG(nbSieges)
FROM flottedb.avion);

--8) (1.5 point) Quelle est la différence entre le plus grand et le plus petit diamètre d'un moteur? 
--Affichez le résultat dans une colonne nommée différence.
SELECT MAX(m.diametre) - MIN(m.diametre) difference
FROM flottedb.moteur m;

--9) (1.5 point) Créer une vue Avion_Bombardier_Vue ayant le nom de la compagnie, lemodèle, 
--le nombre des sièges et le nombre des moteurs d’avion construit par 'BombardierAéro'.
DROP VIEW IF EXISTS Avion_Bombardier_Vue;
CREATE VIEW Avion_Bombardier_Vue
AS
	SELECT c.nomCompagnie, a.modele, a.nbMoteurs, a.nbSieges
	FROM flottedb.constructeur c, flottedb.avion a NATURAL JOIN flottedb.constructeur m
	WHERE c.nomCompagnie = 'Bombardier Aero' AND c.idConstructeur = a.idConstructeur
	WITH CHECK OPTION ; --Pour la question 10

--10) (0.5 point) Modifiez la vue en utilisant CHECK Option. Que se passe-t-il ?
--Elle ne marche pas puisque Check option fait echouer n'importe quelle modification de donnees.
--Check option fonctionne seulement sur les vues qui se update automatiquement. 
--Dans notre cas, etant donne que notre vue selectione de plusieurs tables, elle ne peut pas etre update automatiquement

--11) (1 point) Créez la vue Avion_Bombardier_Update_Check qui contient tous les avions de 
--constructeur dont l’id = 1. 
DROP VIEW IF EXISTS Avion_Bombardier_Update_Check;
CREATE VIEW Avion_Bombardier_Update_Check
AS
	SELECT * FROM flottedb.avion a
	WHERE a.idConstructeur = 1;
	SELECT * FROM Avion_Bombardier_Update_Check;

--12) (0.5 points) Mettez à jour les tuples de la vue en 11) en changeant l’id constructeur à 2. 
--Que se passe-t-il ?
CREATE OR REPLACE VIEW Avion_Bombardier_Update_Check
AS
		SELECT * FROM flottedb.avion a
		WHERE a.idConstructeur = 2;
SELECT * FROM Avion_Bombardier_Update_Check;

--la vue est remplacee par la nouvelle vue. dans notre cas, vide, car le constructeur de id 2 n'a pas 
--construit d'avion dans nos donnees.

--13) (0.5 points) Modifiez la vue en 11) en rajoutant l’option WITH CHECK OPTION. Réexécutez le 
--code de création de la vue et essayez de mettre à jour la vue comme dans 12. Que se passe-t-il ? 
--Ici, check option fonctionne, puisque la vue tire tous ses donnees d'une meme table, soit avion.