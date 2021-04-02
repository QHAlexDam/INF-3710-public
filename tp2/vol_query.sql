SELECT * FROM VOLDB.passager
WHERE noPassager IN (
	SELECT reservation.noPassager FROM VOLDB.reservation
	WHERE noVol IN (
		SELECT vol.noVol FROM VOLDB.vol
		WHERE codeAeroportDepart = 'YUL' AND codeAeroportArrivee = 'RBA'
	)
);