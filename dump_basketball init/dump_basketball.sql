CREATE DATABASE  IF NOT EXISTS `basketball` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `basketball`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: basketball
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `championship`
--

DROP TABLE IF EXISTS `championship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `championship` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `year` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `championship`
--

LOCK TABLES `championship` WRITE;
/*!40000 ALTER TABLE `championship` DISABLE KEYS */;
INSERT INTO `championship` VALUES (1,'World cup',2022),(2,'Funny cup',2022);
/*!40000 ALTER TABLE `championship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `championshiplink`
--

DROP TABLE IF EXISTS `championshiplink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `championshiplink` (
  `national` int NOT NULL,
  `championship` int NOT NULL,
  PRIMARY KEY (`national`,`championship`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `championshiplink`
--

LOCK TABLES `championshiplink` WRITE;
/*!40000 ALTER TABLE `championshiplink` DISABLE KEYS */;
/*!40000 ALTER TABLE `championshiplink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `country` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Paris',1),(2,'Lyon',1),(3,'Dijon',1),(4,'Monaco',1),(5,'Blois',1),(6,'New York',2),(7,'Chicago',2),(8,'San Francisco',2),(9,'Washington',2),(10,'Las Vegas',2),(11,'Madrid',3),(12,'Barcelona',3),(13,'Valencia',3),(14,'Sevilla',3),(15,'Vitoria-Gasteiz',3),(16,'London',4),(17,'Manchester',4),(18,'Bristol',4),(19,'Liverpool',4),(20,'Birmingham',4),(21,'Le Pirée',5),(22,'Athènes',5),(23,'Peristeri',5),(24,'Maroussi',5),(25,'Rhodes',5),(26,'Munich',6),(27,'Bonn',6),(28,'Berlin',6),(29,'Ludwigsburg',6),(30,'Oldenburg',6),(31,'Montreal',7),(32,'Toronto',7),(33,'Vancouver',7),(34,'Ottawa',7),(35,'Calgary',7),(37,'Torino',8),(38,'Roma',8),(39,'Milano',8),(40,'Venezia',8),(41,'Firenze',8),(42,'Warszawa',9),(43,'Krakow',9),(44,'Wroclaw',9),(45,'Gdansk',9),(46,'Poznan',9),(47,'Copenhague',10),(48,'Odense',10),(49,'Elseneur',10),(50,'Ribe',10),(51,'Kolding',10);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club`
--

DROP TABLE IF EXISTS `club`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team` int NOT NULL,
  `city` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club`
--

LOCK TABLES `club` WRITE;
/*!40000 ALTER TABLE `club` DISABLE KEYS */;
/*!40000 ALTER TABLE `club` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(90) NOT NULL,
  `citizenship` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'France','French'),(2,'United States','American'),(3,'Spain','Spanish'),(4,'England','English'),(5,'Greece','Greek'),(6,'Germany','German'),(7,'Canada','Canadian'),(8,'Italy','Italian'),(9,'Poland','Polish'),(10,'Denmark','Danish');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kind` varchar(10) DEFAULT NULL,
  `kind_id` int DEFAULT NULL,
  `team_1` int NOT NULL,
  `team_2` int NOT NULL,
  `score_team_1` int NOT NULL DEFAULT '0',
  `score_team_2` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `league`
--

DROP TABLE IF EXISTS `league`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `league` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `season` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league`
--

LOCK TABLES `league` WRITE;
/*!40000 ALTER TABLE `league` DISABLE KEYS */;
INSERT INTO `league` VALUES (1,'League A','2022 - 2023'),(2,'League B','2022 - 2023'),(3,'League C','2022 - 2023');
/*!40000 ALTER TABLE `league` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaguelink`
--

DROP TABLE IF EXISTS `leaguelink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leaguelink` (
  `club` int NOT NULL,
  `league` int NOT NULL,
  PRIMARY KEY (`club`,`league`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaguelink`
--

LOCK TABLES `leaguelink` WRITE;
/*!40000 ALTER TABLE `leaguelink` DISABLE KEYS */;
/*!40000 ALTER TABLE `leaguelink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `national`
--

DROP TABLE IF EXISTS `national`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `national` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team` int NOT NULL,
  `country` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `national`
--

LOCK TABLES `national` WRITE;
/*!40000 ALTER TABLE `national` DISABLE KEYS */;
/*!40000 ALTER TABLE `national` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `birth` date NOT NULL,
  `height` int NOT NULL DEFAULT '0',
  `citizenship` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playergamestats`
--

DROP TABLE IF EXISTS `playergamestats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playergamestats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team_player` int NOT NULL,
  `game` int NOT NULL,
  `three_pts` int NOT NULL DEFAULT '0',
  `two_pts` int NOT NULL DEFAULT '0',
  `free_pts` int NOT NULL DEFAULT '0',
  `per_success` int NOT NULL DEFAULT '0',
  `assists` int NOT NULL DEFAULT '0',
  `rebounds` int NOT NULL DEFAULT '0',
  `blocks` int NOT NULL DEFAULT '0',
  `fouls` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playergamestats`
--

LOCK TABLES `playergamestats` WRITE;
/*!40000 ALTER TABLE `playergamestats` DISABLE KEYS */;
/*!40000 ALTER TABLE `playergamestats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor`
--

DROP TABLE IF EXISTS `sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `city` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor`
--

LOCK TABLES `sponsor` WRITE;
/*!40000 ALTER TABLE `sponsor` DISABLE KEYS */;
INSERT INTO `sponsor` VALUES (1,'LDLC',2),(2,'Le Coq Sportif',1),(3,'Coca-Cola Company',2),(4,'Google',8),(5,'Cacaolat',12),(6,'Babycream',32),(7,'Tutti Fruiti',38),(8,'Pantheon',18),(9,'Vanilla Sans',43),(10,'Euler Records',25),(11,'Closely',17),(12,'Barouth',27),(13,'Firo',33),(14,'Balamama',48);
/*!40000 ALTER TABLE `sponsor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsorlink`
--

DROP TABLE IF EXISTS `sponsorlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsorlink` (
  `team` int NOT NULL,
  `sponsor` int NOT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`team`,`sponsor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsorlink`
--

LOCK TABLES `sponsorlink` WRITE;
/*!40000 ALTER TABLE `sponsorlink` DISABLE KEYS */;
/*!40000 ALTER TABLE `sponsorlink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `kind` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamplayer`
--

DROP TABLE IF EXISTS `teamplayer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamplayer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `player` int NOT NULL,
  `team` int NOT NULL,
  `number` int NOT NULL DEFAULT '0',
  `three_pts` int NOT NULL DEFAULT '0',
  `two_pts` int NOT NULL DEFAULT '0',
  `free_pts` int NOT NULL DEFAULT '0',
  `per_success` int NOT NULL DEFAULT '0',
  `assists` int NOT NULL DEFAULT '0',
  `rebounds` int NOT NULL DEFAULT '0',
  `blocks` int NOT NULL DEFAULT '0',
  `fouls` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamplayer`
--

LOCK TABLES `teamplayer` WRITE;
/*!40000 ALTER TABLE `teamplayer` DISABLE KEYS */;
/*!40000 ALTER TABLE `teamplayer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-01 19:25:30
