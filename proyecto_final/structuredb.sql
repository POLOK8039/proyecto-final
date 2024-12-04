/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.8-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: packaging_test
-- ------------------------------------------------------
-- Server version	10.11.8-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `box`
--

DROP TABLE IF EXISTS `box`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `box` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `height` decimal(10,2) DEFAULT NULL,
  `width` decimal(10,2) DEFAULT NULL,
  `length` decimal(10,2) DEFAULT NULL,
  `volume` decimal(10,2) DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER calculate_box_volume_insert
BEFORE INSERT ON box
FOR EACH ROW
Begin
    SET NEW.volume = NEW.height*NEW.width*NEW.length;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER calculate_box_volume_update
BEFORE UPDATE ON box
FOR EACH ROW
Begin
    SET NEW.volume = NEW.height*NEW.width*NEW.length;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `incident`
--

DROP TABLE IF EXISTS `incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `description` text NOT NULL,
  `user` int(11) DEFAULT NULL,
  `traceability` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  UNIQUE KEY `UQ_incident_date` (`date`),
  KEY `fk_user_incident` (`user`),
  KEY `fk_traceability_incident` (`traceability`),
  CONSTRAINT `fk_traceability_incident` FOREIGN KEY (`traceability`) REFERENCES `traceability` (`num`),
  CONSTRAINT `fk_user_incident` FOREIGN KEY (`user`) REFERENCES `user` (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material` (
  `code` varchar(5) NOT NULL,
  `material_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `available_quantity` int(11) DEFAULT NULL,
  `unit_of_measure` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `fk_unit_of_measure` (`unit_of_measure`),
  CONSTRAINT `fk_unit_of_measure` FOREIGN KEY (`unit_of_measure`) REFERENCES `unit_of_measure` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `material_package`
--

DROP TABLE IF EXISTS `material_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material_package` (
  `material` varchar(5) NOT NULL,
  `package` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`material`,`package`),
  KEY `fk_package_material` (`package`),
  CONSTRAINT `fk_material_package` FOREIGN KEY (`material`) REFERENCES `material` (`code`),
  CONSTRAINT `fk_package_material` FOREIGN KEY (`package`) REFERENCES `package` (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER material_package_insert
AFTER INSERT ON material_package
FOR EACH ROW
BEGIN
    UPDATE material
    SET available_quantity = available_quantity - NEW.quantity
    WHERE code = NEW.material;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `material_packging`
--

DROP TABLE IF EXISTS `material_packging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material_packging` (
  `packaging` varchar(5) NOT NULL,
  `material` varchar(5) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`material`,`packaging`),
  KEY `fk_packaging_material` (`packaging`),
  CONSTRAINT `fk_material_packaging` FOREIGN KEY (`material`) REFERENCES `material` (`code`),
  CONSTRAINT `fk_packaging_material` FOREIGN KEY (`packaging`) REFERENCES `packaging` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER material_packging_insert
AFTER INSERT ON material_packging
FOR EACH ROW
BEGIN
    UPDATE material
    SET available_quantity = available_quantity - NEW.quantity
    WHERE code = NEW.material;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `outbound`
--

DROP TABLE IF EXISTS `outbound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outbound` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `exit_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `product_quantity` int(11) DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  `product` varchar(5) DEFAULT NULL,
  `packaging` varchar(5) DEFAULT NULL,
  `box` int(11) DEFAULT NULL,
  `tag` int(11) DEFAULT NULL,
  `traceability` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  UNIQUE KEY `UQ_package_tag` (`tag`),
  KEY `fk_product_package` (`product`),
  KEY `fk_packaging_package` (`packaging`),
  KEY `fk_box_package` (`box`),
  KEY `fk_traceability_package` (`traceability`),
  CONSTRAINT `fk_box_package` FOREIGN KEY (`box`) REFERENCES `box` (`num`),
  CONSTRAINT `fk_packaging_package` FOREIGN KEY (`packaging`) REFERENCES `packaging` (`code`),
  CONSTRAINT `fk_product_package` FOREIGN KEY (`product`) REFERENCES `product` (`code`),
  CONSTRAINT `fk_tag_package` FOREIGN KEY (`tag`) REFERENCES `tag` (`num`),
  CONSTRAINT `fk_traceability_package` FOREIGN KEY (`traceability`) REFERENCES `traceability` (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER calculate_package_weight
BEFORE INSERT ON package
FOR EACH ROW
BEGIN
    DECLARE prod_weight DECIMAL(10, 2);

    SET prod_weight = (
        SELECT SUM(weight) * NEW.product_quantity
        FROM product
        WHERE package = NEW.num
    );

    SET NEW.weight = prod_weight;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `packaging`
--

DROP TABLE IF EXISTS `packaging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packaging` (
  `code` varchar(5) NOT NULL,
  `height` decimal(10,2) DEFAULT NULL,
  `width` decimal(10,2) DEFAULT NULL,
  `length` decimal(10,2) DEFAULT NULL,
  `package_quantity` int(11) DEFAULT NULL,
  `zone` varchar(5) DEFAULT NULL,
  `outbound` int(11) DEFAULT NULL,
  `tag` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `UQ_packaging_tag` (`tag`),
  KEY `fk_zone_packaging` (`zone`),
  KEY `fk_outbound_packaging` (`outbound`),
  CONSTRAINT `fk_outbound_packaging` FOREIGN KEY (`outbound`) REFERENCES `outbound` (`num`),
  CONSTRAINT `fk_tag_packaging` FOREIGN KEY (`tag`) REFERENCES `tag` (`num`),
  CONSTRAINT `fk_zone_packaging` FOREIGN KEY (`zone`) REFERENCES `zone` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `packaging_protocol`
--

DROP TABLE IF EXISTS `packaging_protocol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packaging_protocol` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `file_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `code` varchar(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `height` decimal(10,2) DEFAULT NULL,
  `width` decimal(10,2) DEFAULT NULL,
  `length` decimal(10,2) DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  `packaging_protocol` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `UQ_product_name` (`name`),
  KEY `fk_packaging_protocol_product` (`packaging_protocol`),
  CONSTRAINT `fk_packaging_protocol_product` FOREIGN KEY (`packaging_protocol`) REFERENCES `packaging_protocol` (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report` (
  `folio` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `report_date` date DEFAULT NULL,
  `packed_products` int(11) DEFAULT NULL,
  `observations` text DEFAULT NULL,
  `traceability` int(11) DEFAULT NULL,
  PRIMARY KEY (`folio`),
  UNIQUE KEY `UQ_report_report_date` (`report_date`),
  KEY `fk_traceability_report` (`traceability`),
  CONSTRAINT `fk_traceability_report` FOREIGN KEY (`traceability`) REFERENCES `traceability` (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `code` varchar(5) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `tag_type` varchar(5) DEFAULT NULL,
  `destination` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`num`),
  UNIQUE KEY `UQ_tag_barcode` (`barcode`),
  KEY `fk_tag_type_tag` (`tag_type`),
  CONSTRAINT `fk_tag_type_tag` FOREIGN KEY (`tag_type`) REFERENCES `tag_type` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_tag
BEFORE INSERT ON tag
FOR EACH ROW
BEGIN
    DECLARE checksum INT DEFAULT 0;
    DECLARE gs1_code VARCHAR(255);
    DECLARE i INT DEFAULT 1;
    DECLARE len INT;
    DECLARE digito INT;
    DECLARE suma_impar INT DEFAULT 0;
    DECLARE suma_par INT DEFAULT 0;

    -- Generar el código GS1-128 básico (sin checksum)
    SET gs1_code = CONCAT(
        '(17)', DATE_FORMAT(NEW.date, '%y%m%d'),
        '(410)', NEW.destination,
        '(420)', NEW.tag_type
    );
    
    -- Longitud del código generado
    SET len = CHAR_LENGTH(gs1_code);

    -- Calcular el checksum recorriendo cada carácter
    WHILE i <= len DO
        SET digito = CAST(SUBSTRING(gs1_code, i, 1) AS UNSIGNED);

        IF i % 2 = 1 THEN
            -- Sumar posición impar y multiplicar por 3
            SET suma_impar = suma_impar + digito;
        ELSE
            -- Sumar posición par
            SET suma_par = suma_par + digito;
        END IF;
        
        SET i = i + 1;
    END WHILE;

    -- Sumar los resultados y calcular el checksum
    SET checksum = (10 - ((suma_impar * 3 + suma_par) % 10)) % 10;

    -- Concatenar el checksum al final del código GS1-128
    SET NEW.barcode = CONCAT(gs1_code, checksum);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tag_type`
--

DROP TABLE IF EXISTS `tag_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_type` (
  `code` varchar(5) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traceability`
--

DROP TABLE IF EXISTS `traceability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traceability` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `product` varchar(5) DEFAULT NULL,
  `packaging` varchar(5) DEFAULT NULL,
  `state` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `fk_product_traceability` (`product`),
  KEY `fk_packaging_traceability` (`packaging`),
  KEY `fk_state_traceability` (`state`),
  CONSTRAINT `fk_packaging_traceability` FOREIGN KEY (`packaging`) REFERENCES `packaging` (`code`),
  CONSTRAINT `fk_product_traceability` FOREIGN KEY (`product`) REFERENCES `product` (`code`),
  CONSTRAINT `fk_state_traceability` FOREIGN KEY (`state`) REFERENCES `state` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unit_of_measure`
--

DROP TABLE IF EXISTS `unit_of_measure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_of_measure` (
  `code` varchar(5) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `first_surname` varchar(30) NOT NULL,
  `second_surname` varchar(30) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `neighborhood` varchar(50) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `postal_code` int(11) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `active` bit(1) DEFAULT b'1',
  `user_type` varchar(5) DEFAULT NULL,
  `supervisor` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_user_type` (`user_type`),
  KEY `fk_user_supervisor` (`supervisor`),
  CONSTRAINT `fk_user_supervisor` FOREIGN KEY (`supervisor`) REFERENCES `user` (`num`),
  CONSTRAINT `fk_user_type` FOREIGN KEY (`user_type`) REFERENCES `user_type` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_traceability`
--

DROP TABLE IF EXISTS `user_traceability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_traceability` (
  `user` int(11) NOT NULL,
  `traceability` int(11) NOT NULL,
  PRIMARY KEY (`user`,`traceability`),
  KEY `fk_traceability_user` (`traceability`),
  CONSTRAINT `fk_traceability_user` FOREIGN KEY (`traceability`) REFERENCES `traceability` (`num`),
  CONSTRAINT `fk_user_traceability` FOREIGN KEY (`user`) REFERENCES `user` (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_type`
--

DROP TABLE IF EXISTS `user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_type` (
  `code` varchar(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `vw_box_info`
--

DROP TABLE IF EXISTS `vw_box_info`;
/*!50001 DROP VIEW IF EXISTS `vw_box_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_box_info` AS SELECT
 1 AS `num`,
  1 AS `height`,
  1 AS `width`,
  1 AS `length`,
  1 AS `volume`,
  1 AS `weight` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_incident_info`
--

DROP TABLE IF EXISTS `vw_incident_info`;
/*!50001 DROP VIEW IF EXISTS `vw_incident_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_incident_info` AS SELECT
 1 AS `num`,
  1 AS `date`,
  1 AS `description`,
  1 AS `user`,
  1 AS `traceability` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_material_info`
--

DROP TABLE IF EXISTS `vw_material_info`;
/*!50001 DROP VIEW IF EXISTS `vw_material_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_material_info` AS SELECT
 1 AS `code`,
  1 AS `material_name`,
  1 AS `description`,
  1 AS `available_quantity`,
  1 AS `unit_of_measure` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_outbound_info`
--

DROP TABLE IF EXISTS `vw_outbound_info`;
/*!50001 DROP VIEW IF EXISTS `vw_outbound_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_outbound_info` AS SELECT
 1 AS `num`,
  1 AS `date`,
  1 AS `exit_quantity` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_package_info`
--

DROP TABLE IF EXISTS `vw_package_info`;
/*!50001 DROP VIEW IF EXISTS `vw_package_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_package_info` AS SELECT
 1 AS `num`,
  1 AS `product_quantity`,
  1 AS `weight`,
  1 AS `packaging`,
  1 AS `box`,
  1 AS `tag` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_packaging_info`
--

DROP TABLE IF EXISTS `vw_packaging_info`;
/*!50001 DROP VIEW IF EXISTS `vw_packaging_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_packaging_info` AS SELECT
 1 AS `code`,
  1 AS `height`,
  1 AS `width`,
  1 AS `length`,
  1 AS `package_quantity`,
  1 AS `zone`,
  1 AS `outbound`,
  1 AS `tag` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_packaging_protocol_info`
--

DROP TABLE IF EXISTS `vw_packaging_protocol_info`;
/*!50001 DROP VIEW IF EXISTS `vw_packaging_protocol_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_packaging_protocol_info` AS SELECT
 1 AS `num`,
  1 AS `name`,
  1 AS `file_name` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_product_info`
--

DROP TABLE IF EXISTS `vw_product_info`;
/*!50001 DROP VIEW IF EXISTS `vw_product_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_product_info` AS SELECT
 1 AS `code`,
  1 AS `name`,
  1 AS `description`,
  1 AS `height`,
  1 AS `width`,
  1 AS `length`,
  1 AS `weight`,
  1 AS `packaging_protocol` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_supervisor`
--

DROP TABLE IF EXISTS `vw_supervisor`;
/*!50001 DROP VIEW IF EXISTS `vw_supervisor`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_supervisor` AS SELECT
 1 AS `num`,
  1 AS `username`,
  1 AS `full_name`,
  1 AS `date_of_birth`,
  1 AS `neighborhood`,
  1 AS `street`,
  1 AS `postal_code`,
  1 AS `phone`,
  1 AS `email` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_tag_info`
--

DROP TABLE IF EXISTS `vw_tag_info`;
/*!50001 DROP VIEW IF EXISTS `vw_tag_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_tag_info` AS SELECT
 1 AS `num`,
  1 AS `date`,
  1 AS `barcode`,
  1 AS `tag_type`,
  1 AS `destination` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_traceability_info`
--

DROP TABLE IF EXISTS `vw_traceability_info`;
/*!50001 DROP VIEW IF EXISTS `vw_traceability_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_traceability_info` AS SELECT
 1 AS `num`,
  1 AS `product`,
  1 AS `packaging`,
  1 AS `state` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_user_info`
--

DROP TABLE IF EXISTS `vw_user_info`;
/*!50001 DROP VIEW IF EXISTS `vw_user_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_user_info` AS SELECT
 1 AS `num`,
  1 AS `username`,
  1 AS `password`,
  1 AS `active`,
  1 AS `user_type`,
  1 AS `supervisor` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_user_personal_info`
--

DROP TABLE IF EXISTS `vw_user_personal_info`;
/*!50001 DROP VIEW IF EXISTS `vw_user_personal_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_user_personal_info` AS SELECT
 1 AS `num`,
  1 AS `full_name`,
  1 AS `date_of_birth`,
  1 AS `neighborhood`,
  1 AS `street`,
  1 AS `postal_code`,
  1 AS `phone`,
  1 AS `email`,
  1 AS `user` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_zone_info`
--

DROP TABLE IF EXISTS `vw_zone_info`;
/*!50001 DROP VIEW IF EXISTS `vw_zone_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_zone_info` AS SELECT
 1 AS `code`,
  1 AS `area`,
  1 AS `available_capacity`,
  1 AS `total_capacity` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `zone`
--

DROP TABLE IF EXISTS `zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zone` (
  `code` varchar(5) NOT NULL,
  `area` varchar(50) NOT NULL,
  `available_capacity` int(11) DEFAULT NULL,
  `total_capacity` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `area` (`area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `vw_box_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_box_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_box_info` AS select `box`.`num` AS `num`,`box`.`height` AS `height`,`box`.`width` AS `width`,`box`.`length` AS `length`,`box`.`volume` AS `volume`,`box`.`weight` AS `weight` from `box` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_incident_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_incident_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_incident_info` AS select `incident`.`num` AS `num`,`incident`.`date` AS `date`,`incident`.`description` AS `description`,`incident`.`user` AS `user`,`incident`.`traceability` AS `traceability` from `incident` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_material_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_material_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_material_info` AS select `material`.`code` AS `code`,`material`.`material_name` AS `material_name`,`material`.`description` AS `description`,`material`.`available_quantity` AS `available_quantity`,`material`.`unit_of_measure` AS `unit_of_measure` from `material` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_outbound_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_outbound_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_outbound_info` AS select `outbound`.`num` AS `num`,`outbound`.`date` AS `date`,`outbound`.`exit_quantity` AS `exit_quantity` from `outbound` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_package_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_package_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_package_info` AS select `package`.`num` AS `num`,`package`.`product_quantity` AS `product_quantity`,`package`.`weight` AS `weight`,`package`.`packaging` AS `packaging`,`package`.`box` AS `box`,`package`.`tag` AS `tag` from `package` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_packaging_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_packaging_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_packaging_info` AS select `packaging`.`code` AS `code`,`packaging`.`height` AS `height`,`packaging`.`width` AS `width`,`packaging`.`length` AS `length`,`packaging`.`package_quantity` AS `package_quantity`,`packaging`.`zone` AS `zone`,`packaging`.`outbound` AS `outbound`,`packaging`.`tag` AS `tag` from `packaging` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_packaging_protocol_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_packaging_protocol_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_packaging_protocol_info` AS select `packaging_protocol`.`num` AS `num`,`packaging_protocol`.`name` AS `name`,`packaging_protocol`.`file_name` AS `file_name` from `packaging_protocol` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_product_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_product_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_product_info` AS select `product`.`code` AS `code`,`product`.`name` AS `name`,`product`.`description` AS `description`,`product`.`height` AS `height`,`product`.`width` AS `width`,`product`.`length` AS `length`,`product`.`weight` AS `weight`,`product`.`packaging_protocol` AS `packaging_protocol` from `product` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_supervisor`
--

/*!50001 DROP VIEW IF EXISTS `vw_supervisor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_supervisor` AS select `user`.`num` AS `num`,`user`.`username` AS `username`,concat(`user`.`name`,' ',`user`.`first_surname`,ifnull(concat(' ',`user`.`second_surname`),'')) AS `full_name`,date_format(`user`.`date_of_birth`,'%M-%d-%y') AS `date_of_birth`,`user`.`neighborhood` AS `neighborhood`,`user`.`street` AS `street`,`user`.`postal_code` AS `postal_code`,`user`.`phone` AS `phone`,`user`.`email` AS `email` from `user` where `user`.`user_type` = 'super' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_tag_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_tag_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_tag_info` AS select `tag`.`num` AS `num`,`tag`.`date` AS `date`,`tag`.`barcode` AS `barcode`,`tag`.`tag_type` AS `tag_type`,`tag`.`destination` AS `destination` from `tag` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_traceability_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_traceability_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_traceability_info` AS select `traceability`.`num` AS `num`,`traceability`.`product` AS `product`,`traceability`.`packaging` AS `packaging`,`traceability`.`state` AS `state` from `traceability` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_user_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_user_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_user_info` AS select `u`.`num` AS `num`,`u`.`username` AS `username`,`u`.`password` AS `password`,`u`.`active` AS `active`,`u`.`user_type` AS `user_type`,`u`.`supervisor` AS `supervisor` from `user` `u` where `u`.`active` = 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_user_personal_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_user_personal_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_user_personal_info` AS select `u`.`num` AS `num`,concat(`u`.`name`,' ',`u`.`first_surname`,ifnull(concat(' ',`u`.`second_surname`),'')) AS `full_name`,date_format(`u`.`date_of_birth`,'%M-%d-%y') AS `date_of_birth`,`u`.`neighborhood` AS `neighborhood`,`u`.`street` AS `street`,`u`.`postal_code` AS `postal_code`,`u`.`phone` AS `phone`,`u`.`email` AS `email`,(select `user_type`.`name` from `user_type` where `user_type`.`code` = `u`.`user_type`) AS `user` from `user` `u` where `u`.`active` = 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_zone_info`
--

/*!50001 DROP VIEW IF EXISTS `vw_zone_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_zone_info` AS select `zone`.`code` AS `code`,`zone`.`area` AS `area`,`zone`.`available_capacity` AS `available_capacity`,`zone`.`total_capacity` AS `total_capacity` from `zone` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-13 20:08:19
