-- 1) Une fonction nbAvions en PL/pgSQL qui retourne le nombre total d’avions;
CREATE OR REPLACE FUNCTION nbAvions()
	RETURNS INTEGER AS $$
	DECLARE nb INTEGER;
	BEGIN
		SELECT COUNT(*) INTO nb FROM flottedb.avion;
		RETURN nb;
	END;
	$$ LANGUAGE plpgsql;
SELECT nbAvions();

-- 2) Un trigger contrôle_inspection qui crée une insertion dans une table nommée
-- Controle. Ce trigger se déclenche lorsqu’il y a une mise à jour d’un nouveau modèle d’avion.
-- On veut conserver les informations de l’avion ainsi que la date de la mise à jour.
CREATE OR REPLACE FUNCTION controleInspectionFunc()
RETURNS trigger AS $emp_stamp$
	BEGIN
		CREATE TABLE IF NOT EXISTS Controle (
            idAvion VARCHAR(10),
            modele VARCHAR(20), 
            idConstructeur VARCHAR(10), 
            nbMoteurs VARCHAR(10), 
            nbSieges VARCHAR(10),
            date DATE,
			PRIMARY KEY (idAvion)
		);
		INSERT INTO Controle VALUES (DEFAULT, NEW.modele, NEW.idConstructeur, NEW.nbMoteurs, NEW.nbSieges, date);
		RETURN NEW;
	END;
	$emp_stamp$ LANGUAGE plpgsql;

    CREATE TRIGGER controleInspection
	BEFORE UPDATE ON flottedb.avion
	FOR EACH ROW
	WHEN (OLD.modele IS DISTINCT FROM NEW.modele)
	EXECUTE PROCEDURE controleInspectionFunc();
