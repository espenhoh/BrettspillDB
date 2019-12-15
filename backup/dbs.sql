-- MySQL dump 10.17  Distrib 10.3.15-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: brettspill
-- ------------------------------------------------------
-- Server version	10.3.15-MariaDB

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
-- Table structure for table `brettdel`
--

DROP TABLE IF EXISTS `brettdel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brettdel` (
  `brettdel_id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_spill` int(11) NOT NULL,
  PRIMARY KEY (`brettdel_id`),
  KEY `fk_HANDLING_TUR1_idx` (`fk_spill`),
  CONSTRAINT `fk_BRETTDEL_SPILL1` FOREIGN KEY (`fk_spill`) REFERENCES `spill` (`spill_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brettdel`
--

LOCK TABLES `brettdel` WRITE;
/*!40000 ALTER TABLE `brettdel` DISABLE KEYS */;
/*!40000 ALTER TABLE `brettdel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `handling`
--

DROP TABLE IF EXISTS `handling`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `handling` (
  `handling_id` int(11) NOT NULL AUTO_INCREMENT,
  `handling_type` enum('Legge ut kart','Legge ut number token') NOT NULL,
  `tur_id` int(11) NOT NULL,
  PRIMARY KEY (`handling_id`),
  KEY `fk_HANDLING_TUR1_idx` (`tur_id`),
  CONSTRAINT `fk_HANDLING_TUR1` FOREIGN KEY (`tur_id`) REFERENCES `tur` (`tur_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `handling`
--

LOCK TABLES `handling` WRITE;
/*!40000 ALTER TABLE `handling` DISABLE KEYS */;
/*!40000 ALTER TABLE `handling` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spill`
--

DROP TABLE IF EXISTS `spill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spill` (
  `spill_id` int(11) NOT NULL AUTO_INCREMENT,
  `navn` varchar(45) DEFAULT NULL,
  `fk_leder` int(11) NOT NULL,
  `spill_type` enum('Bosetterne','Byer og riddere','Sjøfarer','Sjøfarer med byer og riddere','Traders and barbarians ikke planlagt implementert','Explorers and Pirates ikke planlagt implementert') NOT NULL,
  `dato_fom` timestamp NULL DEFAULT NULL,
  `dato_tom` timestamp NULL DEFAULT NULL,
  `maks_poeng` tinyint(1) unsigned NOT NULL DEFAULT 13,
  PRIMARY KEY (`spill_id`),
  KEY `fk_SPILL_LEDER` (`fk_leder`),
  KEY `idx_dato` (`dato_fom`,`dato_tom`) USING BTREE,
  CONSTRAINT `fk_SPILL_LEDER` FOREIGN KEY (`fk_leder`) REFERENCES `spiller_i_spill` (`spiller_i_spill_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spill`
--

LOCK TABLES `spill` WRITE;
/*!40000 ALTER TABLE `spill` DISABLE KEYS */;
/*!40000 ALTER TABLE `spill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spiller`
--

DROP TABLE IF EXISTS `spiller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spiller` (
  `spiller_id` int(11) NOT NULL AUTO_INCREMENT,
  `kallenavn` varchar(45) NOT NULL,
  `epost` varchar(45) NOT NULL,
  `passord` varchar(45) NOT NULL,
  `dato_registrert` date NOT NULL,
  `innlogget` bit(1) NOT NULL DEFAULT b'0',
  `i_spill` bit(1) NOT NULL DEFAULT b'0',
  `dato_sist_innlogget` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`spiller_id`),
  UNIQUE KEY `navn_UNIQUE` (`kallenavn`),
  UNIQUE KEY `epost_UNIQUE` (`epost`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spiller`
--

LOCK TABLES `spiller` WRITE;
/*!40000 ALTER TABLE `spiller` DISABLE KEYS */;
/*!40000 ALTER TABLE `spiller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spiller_i_spill`
--

DROP TABLE IF EXISTS `spiller_i_spill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spiller_i_spill` (
  `spiller_i_spill_id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_spiller_id` int(11) NOT NULL,
  `fk_spill_id` int(11) NOT NULL,
  `farge` char(7) NOT NULL,
  `plassering` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`spiller_i_spill_id`),
  UNIQUE KEY `game_id_UNIQUE` (`fk_spill_id`,`fk_spiller_id`) USING BTREE,
  KEY `fk_SPILLER_i_SPILL` (`fk_spiller_id`),
  KEY `fk_SPILL_med_SPILLER_idx` (`fk_spill_id`) USING BTREE,
  CONSTRAINT `fk_SPILLER_i_SPILL` FOREIGN KEY (`fk_spiller_id`) REFERENCES `spiller` (`spiller_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_SPILL_med_SPILLER` FOREIGN KEY (`fk_spill_id`) REFERENCES `spill` (`spill_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spiller_i_spill`
--

LOCK TABLES `spiller_i_spill` WRITE;
/*!40000 ALTER TABLE `spiller_i_spill` DISABLE KEYS */;
/*!40000 ALTER TABLE `spiller_i_spill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tur`
--

DROP TABLE IF EXISTS `tur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tur` (
  `tur_id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_spiller_i_spill_id` int(11) NOT NULL,
  PRIMARY KEY (`tur_id`),
  KEY `fk_table1_SPILL1` (`fk_spiller_i_spill_id`),
  CONSTRAINT `fk_table1_SPILL1` FOREIGN KEY (`fk_spiller_i_spill_id`) REFERENCES `spiller_i_spill` (`spiller_i_spill_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tur`
--

LOCK TABLES `tur` WRITE;
/*!40000 ALTER TABLE `tur` DISABLE KEYS */;
/*!40000 ALTER TABLE `tur` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-11 22:49:12
