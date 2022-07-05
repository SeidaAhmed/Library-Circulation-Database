CREATE DATABASE  IF NOT EXISTS `library_circulation` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `library_circulation`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: library_circulation
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `borrow`
--

DROP TABLE IF EXISTS `borrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow` (
  `idBorrow` int NOT NULL AUTO_INCREMENT,
  `Item` int NOT NULL,
  `Patron` int NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `date_out` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `fines` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`idBorrow`),
  KEY `item_borrowed_idx` (`Item`),
  KEY `borrowed_by_idx` (`Patron`),
  CONSTRAINT `borrowed_by` FOREIGN KEY (`Patron`) REFERENCES `patron` (`member_id`),
  CONSTRAINT `item_borrowed` FOREIGN KEY (`Item`) REFERENCES `libraryitem` (`BarCode`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow`
--

LOCK TABLES `borrow` WRITE;
/*!40000 ALTER TABLE `borrow` DISABLE KEYS */;
INSERT INTO `borrow` VALUES (1,122,1,0,'2021-03-21',NULL,NULL),(2,124,2,1,'2021-02-19','2021-04-01',3.45),(3,134,3,0,'2021-04-05',NULL,NULL),(4,121,2,1,'2021-02-19','2021-04-01',3.45);
/*!40000 ALTER TABLE `borrow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `phone_num` varchar(11) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES ('Pape','79 Pape Ave.','4164446666'),('Robarts','48 St. George St.','6474447777'),('Runnymede','387 Bloor St. W','4161114646');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_card`
--

DROP TABLE IF EXISTS `library_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library_card` (
  `card_num` int NOT NULL,
  `date_issued` date NOT NULL,
  `Active` tinyint DEFAULT '0',
  `member` int DEFAULT NULL,
  PRIMARY KEY (`card_num`),
  KEY `member_idx` (`member`),
  CONSTRAINT `member` FOREIGN KEY (`member`) REFERENCES `patron` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_card`
--

LOCK TABLES `library_card` WRITE;
/*!40000 ALTER TABLE `library_card` DISABLE KEYS */;
INSERT INTO `library_card` VALUES (1,'2015-10-03',0,3),(2,'2019-09-15',1,2),(3,'2021-01-01',1,1),(4,'2020-05-17',1,3);
/*!40000 ALTER TABLE `library_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libraryitem`
--

DROP TABLE IF EXISTS `libraryitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libraryitem` (
  `BarCode` int NOT NULL,
  `CallNum` varchar(20) NOT NULL,
  `Status` varchar(10) DEFAULT 'AVAILABLE',
  `fine_per_day` decimal(3,2) DEFAULT '0.15',
  `loan_period` int DEFAULT '21',
  PRIMARY KEY (`BarCode`),
  KEY `CallNum_idx` (`CallNum`),
  CONSTRAINT `CallNum` FOREIGN KEY (`CallNum`) REFERENCES `work` (`CallNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libraryitem`
--

LOCK TABLES `libraryitem` WRITE;
/*!40000 ALTER TABLE `libraryitem` DISABLE KEYS */;
INSERT INTO `libraryitem` VALUES (121,'811.54 BRA','Damaged',0.15,21),(122,'811.54 BRA','Available',0.15,21),(123,' 	335.412 M13.3 ','Reference',0.15,21),(124,'811.54 MAY','Available',0.15,21),(133,'POPULAR BJO','Available',0.20,14),(134,'POPULAR BJO','Available',0.20,14),(145,'811.54 MAY','Lost',0.15,21),(212,'811.54 BRA','Available',0.15,21),(222,'335.412 MAR ROB','Available',0.22,21),(324,' 	811.5409 WHA','Available',0.15,21);
/*!40000 ALTER TABLE `libraryitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locate`
--

DROP TABLE IF EXISTS `locate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locate` (
  `item` int NOT NULL,
  `branch` varchar(45) DEFAULT NULL,
  `rack` int DEFAULT NULL,
  PRIMARY KEY (`item`),
  KEY `rack_idx` (`rack`),
  KEY `branch_idx` (`branch`),
  CONSTRAINT `branch` FOREIGN KEY (`branch`) REFERENCES `branch` (`name`),
  CONSTRAINT `item` FOREIGN KEY (`item`) REFERENCES `libraryitem` (`BarCode`),
  CONSTRAINT `rack` FOREIGN KEY (`rack`) REFERENCES `rack` (`RackID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locate`
--

LOCK TABLES `locate` WRITE;
/*!40000 ALTER TABLE `locate` DISABLE KEYS */;
INSERT INTO `locate` VALUES (121,'Robarts',3),(122,'Pape',4),(123,'Runnymede',6),(124,'Robarts',3),(133,'Pape',4),(134,'Pape',3),(145,'Runnymede',4),(212,'Robarts',3),(222,'Runnymede',4),(324,'Robarts',3);
/*!40000 ALTER TABLE `locate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patron`
--

DROP TABLE IF EXISTS `patron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patron` (
  `member_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phone_num` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `card_num_UNIQUE` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patron`
--

LOCK TABLES `patron` WRITE;
/*!40000 ALTER TABLE `patron` DISABLE KEYS */;
INSERT INTO `patron` VALUES (1,'Misia','123 Spruce St.','misia123@genericmail.ca','4164164164'),(2,'Seida','456 Elm Ave.','seida@email.com','NULL'),(3,'Seamus','792 Ànea St.','hotsox27@hotmail.com','5145145145');
/*!40000 ALTER TABLE `patron` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rack`
--

DROP TABLE IF EXISTS `rack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rack` (
  `RackID` int NOT NULL,
  `Section` varchar(45) NOT NULL,
  `Row` int NOT NULL,
  PRIMARY KEY (`RackID`),
  UNIQUE KEY `UNIQUEROW` (`Section`,`Row`) COMMENT 'Combo of section/row must be unique'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rack`
--

LOCK TABLES `rack` WRITE;
/*!40000 ALTER TABLE `rack` DISABLE KEYS */;
INSERT INTO `rack` VALUES (3,'Adult',1),(4,'Adult',2),(1,'Children',1),(2,'Children',2),(5,'Reference',1),(6,'Reference',2);
/*!40000 ALTER TABLE `rack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserve`
--

DROP TABLE IF EXISTS `reserve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserve` (
  `idReserve` int NOT NULL,
  `Card` int NOT NULL,
  `Work` varchar(20) NOT NULL,
  `CreationDate` date NOT NULL,
  `pickup` varchar(45) NOT NULL,
  `done` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`idReserve`),
  KEY `work_idx` (`Work`),
  KEY `patron_idx` (`Card`),
  KEY `Branch_idx` (`pickup`),
  CONSTRAINT `holding` FOREIGN KEY (`Work`) REFERENCES `work` (`CallNum`),
  CONSTRAINT `patron` FOREIGN KEY (`Card`) REFERENCES `patron` (`member_id`),
  CONSTRAINT `pickup_branch` FOREIGN KEY (`pickup`) REFERENCES `branch` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserve`
--

LOCK TABLES `reserve` WRITE;
/*!40000 ALTER TABLE `reserve` DISABLE KEYS */;
INSERT INTO `reserve` VALUES (1,3,'811.54 BRA','2021-03-21','Pape',0),(2,2,'811.54 MAY','2021-03-30','Robarts',0),(3,2,'POPULAR BJO','2021-04-06','Robarts',0);
/*!40000 ALTER TABLE `reserve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work`
--

DROP TABLE IF EXISTS `work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work` (
  `CallNum` varchar(20) NOT NULL,
  `MARC_ID` decimal(10,0) NOT NULL,
  `Format` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CallNum`),
  UNIQUE KEY `CallNum_UNIQUE` (`CallNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Library Holdings, stand in for catalogue entry';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work`
--

LOCK TABLES `work` WRITE;
/*!40000 ALTER TABLE `work` DISABLE KEYS */;
INSERT INTO `work` VALUES (' 	335.412 M13.3 ',1,'Reference'),(' 	811.5409 WHA',3,'Book'),('335.412 MAR ROB',4,'Book'),('811.54 BRA',5,'Oversize'),('811.54 MAY',2,'Book'),('POPULAR BJO',6,'CD');
/*!40000 ALTER TABLE `work` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-14 18:33:37
