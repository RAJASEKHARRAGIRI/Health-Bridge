CREATE DATABASE  IF NOT EXISTS `rrs_db` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `rrs_db`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: 192.168.7.88    Database: rrs_db
-- ------------------------------------------------------
-- Server version	5.1.70-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `health_bridge_registrations`
--

DROP TABLE IF EXISTS `health_bridge_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `health_bridge_registrations` (
  `sno` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `location` varchar(45) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `email` varchar(45) NOT NULL,
  `mobileno` double NOT NULL,
  `password` varchar(45) NOT NULL,
  `status` varchar(6) NOT NULL DEFAULT 'True',
  PRIMARY KEY (`sno`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `health_bridge_registrations`
--

LOCK TABLES `health_bridge_registrations` WRITE;
/*!40000 ALTER TABLE `health_bridge_registrations` DISABLE KEYS */;
INSERT INTO `health_bridge_registrations` VALUES (1,'RRS','Hyderabad','Male','rrs@gmail.com',7382016541,'6363','True'),(2,'Sai Teja','Hyderabad','Male','sai@gmail.com',8234782374,'sai123','True'),(3,'Administrator','USA','Male','admin@gmail.com',8983945895,'admin','True'),(16,'P Srinu','Hyderabad','Male','srinu@gmail.om',8384348534,'srinu','True'),(17,'Ragiri Rajasekhar','Hyderabad','Male','ragirirajasekhar@gmail.com',8348345834,'6363','True'),(18,'Aleti Eswar','Hyderabad','Male','eswar@gmail.com',7723847283,'eswar','True'),(19,'Derangula Harish Kumar','Bangalore','Male','harish@gmail.com',7237283782,'harish','True'),(20,'John Cena','Bangalore','Male','johncena@gmail.com',7282738728,'john','True'),(21,'testing','Hyderabad','Male','testing@gmail.com',7234234234,'test','True');
/*!40000 ALTER TABLE `health_bridge_registrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-13 13:26:32
