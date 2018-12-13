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
-- Table structure for table `health_bridge_doctors`
--

DROP TABLE IF EXISTS `health_bridge_doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `health_bridge_doctors` (
  `HospitalId` int(11) NOT NULL AUTO_INCREMENT,
  `HospitalName` varchar(100) NOT NULL,
  `DoctorName` varchar(45) NOT NULL,
  `Specialization` varchar(45) NOT NULL,
  `HospitalLocation` varchar(45) NOT NULL,
  `HospitalAddress` varchar(100) NOT NULL,
  `Rating` int(11) DEFAULT NULL,
  `ConsultancyFee` int(11) NOT NULL,
  `Image` varchar(45) NOT NULL DEFAULT 'face.png',
  `FileType` varchar(45) DEFAULT NULL,
  `ImageBlob` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`HospitalId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `health_bridge_doctors`
--

LOCK TABLES `health_bridge_doctors` WRITE;
/*!40000 ALTER TABLE `health_bridge_doctors` DISABLE KEYS */;
INSERT INTO `health_bridge_doctors` VALUES (1,'RRS Creations Care','Rajasekhar Ragiri','ENT Specialist','Hyderabad','Madhapur, Near Happi Mobiles',5,300,'1.jpg',NULL,NULL),(2,'Image Hospital','Rama Rao','Cardiologist','Hyderabad','Hitech City',4,250,'2.jpg',NULL,NULL),(3,'Appolo Care','Meenakshi','Physiologist','Bangalore','Near Four Roads',3,400,'3.jpg',NULL,NULL),(4,'Zootopia Care','Napoleon','Dentist','Bangalore','RTC Circle',5,350,'4.jpg',NULL,NULL),(5,'Ideal Hospital','John Cena','Cardiologist','Hyderabad','Mehadhipatnam',4,400,'face.png',NULL,NULL),(6,'Virinchi Hospital','Sai teja','ENT Specialist','Bangalore','Jaya Nagar',5,1000,'5.jpg',NULL,NULL),(7,'Vijaya Super Speciality Hospital','Aravind Kumar','Dentist','Hyderabad','Jubliee Hills',4,600,'3.jpg',NULL,NULL),(8,'RainBow Hospital','Surya Siva','Neurologist','Hyderabad','Banjara Hills',3,700,'1.jpg',NULL,NULL),(9,'Andhra Hospital','Kavitha','Dentist','Vijayawada','Near MRO Office',5,800,'2.jpg',NULL,NULL),(10,'Manipal Hospital','Balaji','Neurologist','Chennai','Near Municipal Office',4,700,'4.jpg',NULL,NULL),(11,'Ramesh Hospital','Karthik ','Cardiologist','Hyderabad','Madhaur',3,600,'face.png',NULL,NULL),(12,'Nims Hospital','Harish Kumar','ENT Specialist','Bangalore','Near RailWay Station',5,500,'1.jpg',NULL,NULL),(13,'Rims Hospital','Mani kanta','Physiologist','Bangalore','Marathahalli',5,700,'4.jpg',NULL,NULL),(14,'Global Hospital','Raadha krishna','Dermatologist','Hyderabad','Lak di ka pul',3,1300,'face.png',NULL,NULL);
/*!40000 ALTER TABLE `health_bridge_doctors` ENABLE KEYS */;
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
