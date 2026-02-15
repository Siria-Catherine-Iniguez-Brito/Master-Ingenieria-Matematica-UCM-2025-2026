CREATE DATABASE  IF NOT EXISTS `practica1_bd` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `practica1_bd`;
-- MySQL dump 10.13  Distrib 8.0.26, for macos11 (x86_64)
--
-- Host: localhost    Database: practica1_bd
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
-- Table structure for table `archivo`
--

DROP TABLE IF EXISTS `archivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `archivo` (
  `hash_md5` varchar(50) NOT NULL,
  `tamano` int NOT NULL,
  `fichero` blob NOT NULL,
  PRIMARY KEY (`hash_md5`),
  UNIQUE KEY `hash_md5_UNIQUE` (`hash_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archivo`
--

LOCK TABLES `archivo` WRITE;
/*!40000 ALTER TABLE `archivo` DISABLE KEYS */;
INSERT INTO `archivo` VALUES ('8824127a4ac9e743076b36c307a724ab',2000,_binary '0x8824127a4ac9e743076b36c307a724ab'),('f00bef4e3b3eb79e787bc759e582def0',1000,_binary '0xf00bef4e3b3eb79e787bc759e582def0');
/*!40000 ALTER TABLE `archivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contiene`
--

DROP TABLE IF EXISTS `contiene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contiene` (
  `ID_mensaje` int NOT NULL,
  `hash_archivo` varchar(50) NOT NULL,
  `nombre_enviado` varchar(45) NOT NULL,
  PRIMARY KEY (`ID_mensaje`,`hash_archivo`),
  KEY `archivo_hash_contiene_hash_idx` (`hash_archivo`),
  CONSTRAINT `archivo_hash_contiene_hash` FOREIGN KEY (`hash_archivo`) REFERENCES `archivo` (`hash_md5`),
  CONSTRAINT `mensaje_id_contiene_id` FOREIGN KEY (`ID_mensaje`) REFERENCES `mensaje` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contiene`
--

LOCK TABLES `contiene` WRITE;
/*!40000 ALTER TABLE `contiene` DISABLE KEYS */;
INSERT INTO `contiene` VALUES (1,'8824127a4ac9e743076b36c307a724ab','curso_completado.xls'),(2,'f00bef4e3b3eb79e787bc759e582def0','informe.xls'),(3,'f00bef4e3b3eb79e787bc759e582def0','informe ultima semana abril.xls');
/*!40000 ALTER TABLE `contiene` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etiqueta`
--

DROP TABLE IF EXISTS `etiqueta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etiqueta` (
  `ID` int NOT NULL,
  `etiqueta` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`,`etiqueta`),
  CONSTRAINT `mensaje_id_etiqueta_id` FOREIGN KEY (`ID`) REFERENCES `mensaje` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etiqueta`
--

LOCK TABLES `etiqueta` WRITE;
/*!40000 ALTER TABLE `etiqueta` DISABLE KEYS */;
INSERT INTO `etiqueta` VALUES (1,'Formación'),(1,'RRHH'),(2,'informes'),(3,'informes');
/*!40000 ALTER TABLE `etiqueta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `externo`
--

DROP TABLE IF EXISTS `externo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `externo` (
  `DNI` char(9) NOT NULL,
  `nombre_empresa` varchar(45) NOT NULL,
  `acceso` tinyint NOT NULL,
  `DNI_responsable` char(9) NOT NULL,
  PRIMARY KEY (`DNI`),
  UNIQUE KEY `DNI_UNIQUE` (`DNI`),
  KEY `usuario_dni_externo_responsable_idx` (`DNI_responsable`),
  CONSTRAINT `usuario_dni_externo_dni` FOREIGN KEY (`DNI`) REFERENCES `usuario` (`DNI`),
  CONSTRAINT `usuario_dni_externo_responsable` FOREIGN KEY (`DNI_responsable`) REFERENCES `interno` (`DNI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `externo`
--

LOCK TABLES `externo` WRITE;
/*!40000 ALTER TABLE `externo` DISABLE KEYS */;
INSERT INTO `externo` VALUES ('67895678M','INNOVATEL SA',0,'12345678B');
/*!40000 ALTER TABLE `externo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interno`
--

DROP TABLE IF EXISTS `interno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interno` (
  `DNI` char(9) NOT NULL,
  `fecha_inicio` date NOT NULL,
  PRIMARY KEY (`DNI`),
  UNIQUE KEY `DNI_UNIQUE` (`DNI`),
  CONSTRAINT `usuario_dni_interno_dni` FOREIGN KEY (`DNI`) REFERENCES `usuario` (`DNI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interno`
--

LOCK TABLES `interno` WRITE;
/*!40000 ALTER TABLE `interno` DISABLE KEYS */;
INSERT INTO `interno` VALUES ('12345678B','2010-02-01'),('23443278K','2025-04-01');
/*!40000 ALTER TABLE `interno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensaje`
--

DROP TABLE IF EXISTS `mensaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensaje` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `fecha_evio` datetime NOT NULL,
  `asunto` varchar(50) DEFAULT NULL,
  `cuerpo` varchar(1000) DEFAULT NULL,
  `importante` tinyint DEFAULT NULL,
  `DNI_remitente` char(9) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `usuario_dni_mensaje_remitente_idx` (`DNI_remitente`),
  CONSTRAINT `usuario_dni_mensaje_remitente` FOREIGN KEY (`DNI_remitente`) REFERENCES `usuario` (`DNI`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensaje`
--

LOCK TABLES `mensaje` WRITE;
/*!40000 ALTER TABLE `mensaje` DISABLE KEYS */;
INSERT INTO `mensaje` VALUES (1,'2025-08-10 14:23:00','Curso de Riesgos Laborales','Recordar hacer el curso de riesgos laborales, rellenar la ficha',1,'12345678B'),(2,'2025-03-01 09:00:00','Informe semanal','te adjunto el informe de esta semana, un saludo',0,'67895678M'),(3,'2025-09-01 11:33:00','Informe','Te adjunto el informe que hablamos',0,'12345678B');
/*!40000 ALTER TABLE `mensaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recibe`
--

DROP TABLE IF EXISTS `recibe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recibe` (
  `DNI_usuario` char(9) NOT NULL,
  `ID_mensaje` int NOT NULL,
  PRIMARY KEY (`DNI_usuario`,`ID_mensaje`),
  KEY `mensaje_id_recibe_id_idx` (`ID_mensaje`),
  CONSTRAINT `mensaje_id_recibe_id` FOREIGN KEY (`ID_mensaje`) REFERENCES `mensaje` (`ID`),
  CONSTRAINT `usuario_id_recibe_dni` FOREIGN KEY (`DNI_usuario`) REFERENCES `usuario` (`DNI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recibe`
--

LOCK TABLES `recibe` WRITE;
/*!40000 ALTER TABLE `recibe` DISABLE KEYS */;
INSERT INTO `recibe` VALUES ('23443278K',1),('67895678M',1),('12345678B',2),('23443278K',3);
/*!40000 ALTER TABLE `recibe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `DNI` char(9) NOT NULL,
  `email` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido1` varchar(45) NOT NULL,
  `apellido2` varchar(45) DEFAULT NULL,
  `telefono` int NOT NULL,
  `contrasena` varchar(50) NOT NULL,
  PRIMARY KEY (`DNI`),
  UNIQUE KEY `DNI_UNIQUE` (`DNI`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `telefono_UNIQUE` (`telefono`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('12345678B','manu.fer@gmail.com','Manuel','Fernández','Hernández',654897689,'22ceaf99f44c4cc54c2b9f162f4f9579'),('23443278K','marimar@gmail.com','María de Mar','García','Jiménez',666666666,'21a4a7a79a7ee5ec0f73d861da106e08'),('67895678M','pedro.perez@yahoo.es','Pedro','Pérez','Pérez',676876567,'a121a2610112a5f18652bf0833b9c244');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-31 15:24:38
