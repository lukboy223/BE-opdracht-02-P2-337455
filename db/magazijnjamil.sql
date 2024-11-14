-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 28, 2024 at 04:03 PM
-- Server version: 8.0.31
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `magazijnjamil`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `spReadMagazijnProduct`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadMagazijnProduct` ()   BEGIN
SELECT
    Naam
    ,Barcode
    ,VerpakingsInhoudKilogram
    ,AantalAanwezig
    ,Product.Id
FROM Magazijn
INNER JOIN Product
ON Magazijn.ProductId = Product.Id
order by Barcode;


 END$$

DROP PROCEDURE IF EXISTS `spReadProductLeverancierById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadProductLeverancierById` (IN `GivenProductId` INT UNSIGNED)   BEGIN
SELECT
    Product.Naam AS ProductNaam
    ,ProductPerLeverAncier.DatumLevering
    ,ProductPerLeverAncier.Aantal AS LeveringAantal
    ,ProductPerLeverAncier.DatumEerstVolgendeLevering
    ,Leverancier.Naam AS LeverancierNaam
    ,Leverancier.ContactPersoon
    ,Leverancier.LeverancierNummer
    ,Leverancier.Mobiel
FROM ProductPerLeverAncier
INNER JOIN Product ON ProductPerLeverAncier.ProductId = Product.Id
INNER JOIN Leverancier ON ProductPerLeverAncier.LeverancierId = Leverancier.Id
WHERE ProductPerLeverAncier.ProductId = GivenProductId
ORDER BY ProductPerLeverAncier.DatumLevering;


END$$

DROP PROCEDURE IF EXISTS `spReadProductPerAllergeenById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadProductPerAllergeenById` (IN `GivenProductId` INT)   BEGIN
SELECT
    Product.Naam as ProductNaam
    ,Product.Barcode
    ,Allergeen.Naam as AllergeenNaam
    ,Allergeen.Omschrijving
FROM ProductPerAllergeen
INNER JOIN Product
ON ProductPerAllergeen.ProductId = Product.Id
INNER JOIN Allergeen
ON ProductPerAllergeen.AllergeenId = Allergeen.Id
WHERE ProductPerAllergeen.ProductId = GivenProductId
ORDER BY AllergeenNaam;

 END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `allergeen`
--

DROP TABLE IF EXISTS `allergeen`;
CREATE TABLE IF NOT EXISTS `allergeen` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(50) NOT NULL,
  `Omschrijving` varchar(250) NOT NULL,
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `allergeen`
--

INSERT INTO `allergeen` (`Id`, `Naam`, `Omschrijving`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Gluten', 'Dit product bevat gluten', NULL, '2024-10-28 12:32:36.589574', '2024-10-28 12:32:36.589574'),
(2, 'Gelatine', 'Dit product bevat gelatine ', NULL, '2024-10-28 12:32:36.589574', '2024-10-28 12:32:36.589574'),
(3, 'AZO-Kleurstof', 'Dit product bevat AZO-kleurstoffen ', NULL, '2024-10-28 12:32:36.589574', '2024-10-28 12:32:36.589574'),
(4, 'Lactose', 'Dit product bevat lactose ', NULL, '2024-10-28 12:32:36.589574', '2024-10-28 12:32:36.589574'),
(5, 'Soja', 'Dit product bevat soja ', NULL, '2024-10-28 12:32:36.589574', '2024-10-28 12:32:36.589574');

-- --------------------------------------------------------

--
-- Table structure for table `leverancier`
--

DROP TABLE IF EXISTS `leverancier`;
CREATE TABLE IF NOT EXISTS `leverancier` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(50) NOT NULL,
  `ContactPersoon` varchar(120) NOT NULL,
  `LeverancierNummer` varchar(50) NOT NULL,
  `Mobiel` varchar(15) NOT NULL,
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  UNIQUE KEY `LeverancierNummer` (`LeverancierNummer`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `leverancier`
--

INSERT INTO `leverancier` (`Id`, `Naam`, `ContactPersoon`, `LeverancierNummer`, `Mobiel`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Venco', 'Bert van Linge', 'L1029384719', '06-28493827', NULL, '2024-10-28 12:32:36.624910', '2024-10-28 12:32:36.624910'),
(2, 'Astra Sweets', 'Jasper del Monte', 'L1029284315', '06-39398734 ', NULL, '2024-10-28 12:32:36.624910', '2024-10-28 12:32:36.624910'),
(3, 'Haribo', 'Sven Stalman', 'L1029324748', '06-24383291', NULL, '2024-10-28 12:32:36.624910', '2024-10-28 12:32:36.624910'),
(4, 'Basset', 'Joyce Stelterberg', 'L1023845773', '06-48293823', NULL, '2024-10-28 12:32:36.624910', '2024-10-28 12:32:36.624910'),
(5, 'De Bron', 'Remco Veenstra', 'L1023857736', '06-34291234', NULL, '2024-10-28 12:32:36.624910', '2024-10-28 12:32:36.624910');

-- --------------------------------------------------------

--
-- Table structure for table `magazijn`
--

DROP TABLE IF EXISTS `magazijn`;
CREATE TABLE IF NOT EXISTS `magazijn` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` int UNSIGNED NOT NULL,
  `VerpakingsInhoudKilogram` decimal(6,2) NOT NULL,
  `AantalAanwezig` mediumint UNSIGNED DEFAULT '0',
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `ProductId` (`ProductId`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `magazijn`
--

INSERT INTO `magazijn` (`Id`, `ProductId`, `VerpakingsInhoudKilogram`, `AantalAanwezig`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, '5.00', 453, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(2, 2, '2.50', 400, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(3, 3, '5.00', 1, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(4, 4, '1.00', 800, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(5, 5, '3.00', 234, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(6, 6, '2.00', 345, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(7, 7, '1.00', 795, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(8, 8, '10.00', 233, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(9, 9, '2.50', 123, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(10, 10, '3.00', 0, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(11, 11, '2.00', 367, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(12, 12, '1.00', 467, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320'),
(13, 13, '5.00', 20, NULL, '2024-10-28 12:32:36.559320', '2024-10-28 12:32:36.559320');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(120) NOT NULL,
  `Barcode` varchar(20) NOT NULL,
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Id`, `Naam`, `Barcode`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Mintnopjes', '8719587231278', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(2, 'Schoolkrijt', '8719587326713', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(3, 'Honingdrop', '8719587327836', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(4, 'Zure Beren', '8719587321441', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(5, 'Cola Flesjes', '8719587321237', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(6, 'Turtles', '8719587322245', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(7, 'Witte Muizen', '8719587328256', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(8, 'Reuzen Slangen', '8719587325641', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(9, 'Zoute Rijen', '8719587322739', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(10, 'Winegums', '8719587327527', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(11, 'Drop Munten', '8719587322345', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(12, 'Kruis Drop', '8719587322265', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693'),
(13, 'Zoute Ruitjes', '8719587323256', NULL, '2024-10-28 12:32:36.520693', '2024-10-28 12:32:36.520693');

-- --------------------------------------------------------

--
-- Table structure for table `productperallergeen`
--

DROP TABLE IF EXISTS `productperallergeen`;
CREATE TABLE IF NOT EXISTS `productperallergeen` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` int UNSIGNED NOT NULL,
  `AllergeenId` int UNSIGNED NOT NULL,
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `ProductId` (`ProductId`),
  KEY `AllergeenId` (`AllergeenId`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `productperallergeen`
--

INSERT INTO `productperallergeen` (`Id`, `ProductId`, `AllergeenId`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 2, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059'),
(2, 1, 1, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059'),
(3, 1, 3, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059'),
(4, 3, 4, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059'),
(5, 6, 5, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059'),
(6, 9, 2, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059'),
(7, 9, 5, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059'),
(8, 10, 2, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059'),
(9, 12, 4, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059'),
(10, 13, 1, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059'),
(11, 13, 4, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059'),
(12, 13, 5, NULL, '2024-10-28 12:32:36.704059', '2024-10-28 12:32:36.704059');

-- --------------------------------------------------------

--
-- Table structure for table `productperleverancier`
--

DROP TABLE IF EXISTS `productperleverancier`;
CREATE TABLE IF NOT EXISTS `productperleverancier` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` int UNSIGNED NOT NULL,
  `LeverancierId` int UNSIGNED NOT NULL,
  `DatumLevering` date DEFAULT NULL,
  `Aantal` mediumint UNSIGNED NOT NULL,
  `DatumEerstVolgendeLevering` date DEFAULT NULL,
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `ProductId` (`ProductId`),
  KEY `LeverancierId` (`LeverancierId`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `productperleverancier`
--

INSERT INTO `productperleverancier` (`Id`, `ProductId`, `LeverancierId`, `DatumLevering`, `Aantal`, `DatumEerstVolgendeLevering`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 1, '2024-10-09', 23, '2024-10-16', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(2, 1, 1, '2024-10-18', 21, '2024-10-25', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(3, 2, 1, '2024-10-09', 12, '2024-10-16', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(4, 3, 1, '2024-10-10', 11, '2024-10-17', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(5, 4, 2, '2024-10-14', 16, '2024-10-21', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(6, 4, 2, '2024-10-21', 23, '2024-10-28', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(7, 5, 2, '2024-10-14', 45, '2024-10-21', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(8, 6, 2, '2024-10-14', 30, '2024-10-21', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(9, 7, 3, '2024-10-12', 12, '2024-10-19', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(10, 7, 3, '2024-10-19', 23, '2024-10-26', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(11, 8, 3, '2024-10-10', 12, '2024-10-01', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(12, 9, 3, '2024-10-11', 1, '2024-10-18', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(13, 10, 4, '2024-10-16', 24, '2024-10-30', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(14, 11, 5, '2024-10-10', 47, '2024-10-17', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(15, 11, 5, '2024-10-19', 60, '2024-10-26', NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(16, 12, 5, '2024-10-11', 45, NULL, NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960'),
(17, 13, 5, '2024-10-12', 23, NULL, NULL, '2024-10-28 12:32:36.670960', '2024-10-28 12:32:36.670960');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
