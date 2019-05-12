-- MySQL dump 10.13  Distrib 8.0.16, for osx10.14 (x86_64)
--
-- Host: localhost    Database: blogdb
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_types`
--

DROP TABLE IF EXISTS `access_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `access_types` (
  `userid` int(20) NOT NULL AUTO_INCREMENT,
  `accessid` int(8) NOT NULL DEFAULT '1',
  PRIMARY KEY (`userid`),
  KEY `admin_index` (`userid`,`accessid`),
  CONSTRAINT `access_types_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_types`
--

LOCK TABLES `access_types` WRITE;
/*!40000 ALTER TABLE `access_types` DISABLE KEYS */;
INSERT INTO `access_types` VALUES (1,3);
/*!40000 ALTER TABLE `access_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `blog_data`
--

DROP TABLE IF EXISTS `blog_data`;
/*!50001 DROP VIEW IF EXISTS `blog_data`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `blog_data` AS SELECT 
 1 AS `postid`,
 1 AS `creatorid`,
 1 AS `username`,
 1 AS `firstName`,
 1 AS `lastName`,
 1 AS `accessid`,
 1 AS `postdate`,
 1 AS `subject`,
 1 AS `body`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `posts` (
  `postid` int(20) NOT NULL AUTO_INCREMENT,
  `creatorid` int(20) NOT NULL,
  `postdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `subject` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `body` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`postid`),
  KEY `creatorid` (`creatorid`),
  KEY `post_index` (`postid`,`creatorid`,`postdate`,`subject`,`body`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`creatorid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'2019-05-11 03:59:14','Hello World!','This is a test post.'),(3,3,'2019-05-11 05:12:17','Winterfell Massacre','Winterfell janitorial department is gonna have hella overtime tomorrow.'),(4,4,'2019-05-11 05:13:27','GOT Ep 4','Is Bran going to finally do something in this episode ??'),(5,4,'2019-05-11 05:14:26','RIP Missandei',';('),(7,2,'2019-05-12 01:22:53','Episode 5','Study for finals, or watch episode 5 ?');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `userid` int(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `pass` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `firstName` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lastName` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dateCreated` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`),
  KEY `user_index` (`userid`,`username`,`pass`,`firstName`,`lastName`,`dateCreated`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','pbkdf2:sha256:50000$kWhkvjfh$6d80b446582cd51b2040ac0e515468ef9b86fdc58ba32859ff122e41b9df8ba2','root','user','2019-05-10 20:59:14'),(2,'JonSnow123','pbkdf2:sha256:50000$pGzTmzWO$77f34d298861c8236fca3dd211d561a5f657975179bc2e0b32eae7fbf3abfe4d','John ','Smith','2019-05-10 21:35:23'),(3,'AryaKiddingMe123','pbkdf2:sha256:50000$jCMMt2a6$43c91bbca2dd53606615ce1e27b2fed445c84ecd190e828fc6b30f9b0ad2f5ab','Monique','Namsinh','2019-05-10 21:35:47'),(4,'Unsullied247','pbkdf2:sha256:50000$LRCRtjSB$b265035b70fe18554f63e5b729fd862c5df669546716876e799e359fb9a75bcf','Jane','Doe','2019-05-10 21:36:18');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `blog_data`
--

/*!50001 DROP VIEW IF EXISTS `blog_data`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `blog_data` AS select `p`.`postid` AS `postid`,`p`.`creatorid` AS `creatorid`,`u`.`username` AS `username`,`u`.`firstName` AS `firstName`,`u`.`lastName` AS `lastName`,`a`.`accessid` AS `accessid`,`p`.`postdate` AS `postdate`,`p`.`subject` AS `subject`,`p`.`body` AS `body` from ((`posts` `p` join `users` `u` on((`p`.`creatorid` = `u`.`userid`))) left join `access_types` `a` on((`a`.`userid` = `u`.`userid`))) */;
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

-- Dump completed on 2019-05-11 19:13:29
