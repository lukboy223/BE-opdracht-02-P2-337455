USE `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spReadLeverancier;

DELIMITER //

CREATE PROCEDURE spReadLeverancier()
BEGIN
    SELECT
       Naam AS LeverancierNaam,
       ContactPersoon,
       LeverancierNummer,
       Mobiel,
       COUNT(PRO.ProductId) AS VerProducten
    FROM Leverancier AS LEV
    LEFT JOIN ProductPerLeverancier AS PRO
    ON LEV.id = PRO.LeverancierId
    GROUP BY LEV.id, Naam, ContactPersoon, LeverancierNummer, Mobiel
    ORDER BY VerProducten DESC;
END //

DELIMITER ;
