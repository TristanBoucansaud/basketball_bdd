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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-01 19:23:09
