-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: dbtest
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu0.16.04.1

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
-- Table structure for table `account_emailaddress`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_emailaddress_user_id_2c513194_fk` (`user_id`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirmation_email_address_id_5b7f8c58_fk` (`email_address_id`),
  CONSTRAINT `account_emailconfirmation_email_address_id_5b7f8c58_fk` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailconfirmation`
--

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add user',2,'add_user'),(5,'Can change user',2,'change_user'),(6,'Can delete user',2,'delete_user'),(7,'Can add permission',3,'add_permission'),(8,'Can change permission',3,'change_permission'),(9,'Can delete permission',3,'delete_permission'),(10,'Can add group',4,'add_group'),(11,'Can change group',4,'change_group'),(12,'Can delete group',4,'delete_group'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add Idea Status',8,'add_ideastatus'),(23,'Can change Idea Status',8,'change_ideastatus'),(24,'Can delete Idea Status',8,'delete_ideastatus'),(25,'Can add Extended User',9,'add_extendeduser'),(26,'Can change Extended User',9,'change_extendeduser'),(27,'Can delete Extended User',9,'delete_extendeduser'),(28,'Can add Roles',10,'add_role'),(29,'Can change Roles',10,'change_role'),(30,'Can delete Roles',10,'delete_role'),(31,'Can add Ideas',11,'add_ideas'),(32,'Can change Ideas',11,'change_ideas'),(33,'Can delete Ideas',11,'delete_ideas'),(34,'Can add email address',12,'add_emailaddress'),(35,'Can change email address',12,'change_emailaddress'),(36,'Can delete email address',12,'delete_emailaddress'),(37,'Can add email confirmation',13,'add_emailconfirmation'),(38,'Can change email confirmation',13,'change_emailconfirmation'),(39,'Can delete email confirmation',13,'delete_emailconfirmation'),(40,'Can add social application',14,'add_socialapp'),(41,'Can change social application',14,'change_socialapp'),(42,'Can delete social application',14,'delete_socialapp'),(43,'Can add social application token',15,'add_socialtoken'),(44,'Can change social application token',15,'change_socialtoken'),(45,'Can delete social application token',15,'delete_socialtoken'),(46,'Can add social account',16,'add_socialaccount'),(47,'Can change social account',16,'change_socialaccount'),(48,'Can delete social account',16,'delete_socialaccount'),(49,'Can add attachment',17,'add_attachment'),(50,'Can change attachment',17,'change_attachment'),(51,'Can delete attachment',17,'delete_attachment'),(52,'Can add kv store',18,'add_kvstore'),(53,'Can change kv store',18,'change_kvstore'),(54,'Can delete kv store',18,'delete_kvstore');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$100000$0DK3NyWxw7Kz$kBLNREgzNSpOipzLadIV2tE6kFn47pw1EaQ/jANJQks=','2018-05-23 17:47:04.543160',1,'admin','','','',1,1,'2018-05-23 17:32:56.719639'),(2,'pbkdf2_sha256$100000$i2ALTHEOYS6E$EuLdc6BbYj07KbLv3saqAfX9s22UJK51lLwiBOQJBdE=','2018-05-23 17:50:34.525211',1,'Tetyana','','','',1,1,'2018-05-23 17:49:14.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-05-23 17:38:02.750258','1','User',1,'[{\"added\": {}}]',10,1),(2,'2018-05-23 17:38:18.299229','1','New Idea',1,'[{\"added\": {}}]',8,1),(3,'2018-05-23 17:39:27.226346','1','\"Ifewewfew\" by \"admin\" now is New Idea',1,'[{\"added\": {}}]',11,1),(4,'2018-05-23 17:47:59.409371','1','\"Ifewewfew\" by \"admin\" now is New Idea',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',11,1),(5,'2018-05-23 17:49:14.979621','2','Tetyana',1,'[{\"added\": {}}]',2,1),(6,'2018-05-23 17:49:24.219314','2','Tetyana',2,'[{\"changed\": {\"fields\": [\"is_staff\", \"is_superuser\"]}}]',2,1),(7,'2018-05-23 17:59:03.909397','1','admin (User)',1,'[{\"added\": {}}]',9,1),(8,'2018-05-23 17:59:35.625769','2','\"оптовое приготовление пищи\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(9,'2018-05-23 18:03:47.584702','3','\"BICYCLE REPAIR\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(10,'2018-05-23 18:05:44.841923','4','\"EDITORIAL SERVICES\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(11,'2018-05-23 18:08:21.797735','5','\"Event planning\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(12,'2018-05-23 18:10:41.754480','6','\"personal training business\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(13,'2018-05-23 18:13:17.103888','7','\"Цветочный бизнес (флоромат)\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(14,'2018-05-23 18:15:24.829614','8','\"Установка для зарядки гаджетов\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(15,'2018-05-23 18:17:08.431052','9','\"Автомат по продаже оригинальных носков\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(16,'2018-05-23 18:20:08.697496','10','\"NOTARY PUBLIC/JUSTICE OF THE PEACE\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(17,'2018-05-23 18:26:14.980944','11','\"Instagram Marketing\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(18,'2018-05-23 18:28:50.475235','12','\"Start a Blog\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(19,'2018-05-23 18:30:41.334944','1','\"Ifewewfew\" by \"admin\" now is New Idea',3,'',11,1),(20,'2018-05-23 18:32:42.957810','13','\"Sell on Etsy\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(21,'2018-05-23 18:35:45.108061','14','\"Сервис аренды вечерних и свадебных платьев\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(22,'2018-05-23 18:38:02.163001','15','\"изготовления кроватей-трансформеров\" by \"Tetyana\" now is New Idea',1,'[{\"added\": {}}]',11,2),(23,'2018-05-23 19:44:26.216432','2','\"оптовое приготовление пищи\" by \"Tetyana\" now is New Idea',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',11,1),(24,'2018-05-23 19:45:10.571566','2','\"оптовое приготовление пищи\" by \"Tetyana\" now is New Idea',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',11,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (12,'account','emailaddress'),(13,'account','emailconfirmation'),(1,'admin','logentry'),(4,'auth','group'),(3,'auth','permission'),(2,'auth','user'),(5,'contenttypes','contenttype'),(17,'django_summernote','attachment'),(6,'sessions','session'),(7,'sites','site'),(16,'socialaccount','socialaccount'),(14,'socialaccount','socialapp'),(15,'socialaccount','socialtoken'),(9,'testproj','extendeduser'),(11,'testproj','ideas'),(8,'testproj','ideastatus'),(10,'testproj','role'),(18,'thumbnail','kvstore');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-05-23 17:31:44.142808'),(2,'auth','0001_initial','2018-05-23 17:31:54.210375'),(3,'account','0001_initial','2018-05-23 17:31:56.818462'),(4,'account','0002_email_max_length','2018-05-23 17:31:58.680782'),(5,'admin','0001_initial','2018-05-23 17:32:00.798420'),(6,'admin','0002_logentry_remove_auto_add','2018-05-23 17:32:00.889312'),(7,'contenttypes','0002_remove_content_type_name','2018-05-23 17:32:02.126875'),(8,'auth','0002_alter_permission_name_max_length','2018-05-23 17:32:03.144854'),(9,'auth','0003_alter_user_email_max_length','2018-05-23 17:32:04.062160'),(10,'auth','0004_alter_user_username_opts','2018-05-23 17:32:04.151348'),(11,'auth','0005_alter_user_last_login_null','2018-05-23 17:32:04.838802'),(12,'auth','0006_require_contenttypes_0002','2018-05-23 17:32:04.887522'),(13,'auth','0007_alter_validators_add_error_messages','2018-05-23 17:32:05.103240'),(14,'auth','0008_alter_user_username_max_length','2018-05-23 17:32:07.967422'),(15,'auth','0009_alter_user_last_name_max_length','2018-05-23 17:32:09.054115'),(16,'django_summernote','0001_initial','2018-05-23 17:32:09.569929'),(17,'django_summernote','0002_update-help_text','2018-05-23 17:32:09.626250'),(18,'sessions','0001_initial','2018-05-23 17:32:10.322079'),(19,'sites','0001_initial','2018-05-23 17:32:10.937405'),(20,'sites','0002_alter_domain_unique','2018-05-23 17:32:11.506957'),(21,'socialaccount','0001_initial','2018-05-23 17:32:21.313584'),(22,'socialaccount','0002_token_max_lengths','2018-05-23 17:32:21.884786'),(23,'socialaccount','0003_extra_data_default_dict','2018-05-23 17:32:21.969854'),(24,'testproj','0001_initial','2018-05-23 17:32:34.080678'),(25,'thumbnail','0001_initial','2018-05-23 17:32:34.590534');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('h3zu3257p8mw27la578kewtamhf21uka','NTczYTEwNzA0MjgwOTc2M2NkNTJhM2Y2YjY1Mzc5OTI5YzFmZmUxZTp7Il9hdXRoX3VzZXJfaGFzaCI6IjVkNzFhMGUzZWYyMTExNGM4YjNhNWIxY2E3MWFlZTNiZjQ0NmY0NTAiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFsbGF1dGguYWNjb3VudC5hdXRoX2JhY2tlbmRzLkF1dGhlbnRpY2F0aW9uQmFja2VuZCJ9','2018-06-06 17:47:04.595811'),('ncr1oqm3jixqvmw762c46wdotla0pad2','YjE4NDljMDkwNzE5MTNiNDY2YjNhMjc1MTMwNTI3MGZjMTViMDVkODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWxsYXV0aC5hY2NvdW50LmF1dGhfYmFja2VuZHMuQXV0aGVudGljYXRpb25CYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWQ3MWEwZTNlZjIxMTE0YzhiM2E1YjFjYTcxYWVlM2JmNDQ2ZjQ1MCJ9','2018-06-06 17:37:44.898797'),('r4c7x3s9o3ir32op5x4gcc73ix7u74u7','MDA1Nzk5NTZlM2EwMzRhZjEyNDM1NzAwZDFlZDFlYWRiYzY4ZDMzYzp7Il9hdXRoX3VzZXJfaGFzaCI6IjViZjNkOGQ4MGE0YTg5NzYxNzI0ZmMzZGFiMzk5ZDAwNWY2NWE1YjAiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFsbGF1dGguYWNjb3VudC5hdXRoX2JhY2tlbmRzLkF1dGhlbnRpY2F0aW9uQmFja2VuZCJ9','2018-06-06 17:50:34.570087');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_summernote_attachment`
--

DROP TABLE IF EXISTS `django_summernote_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_summernote_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `file` varchar(100) NOT NULL,
  `uploaded` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_summernote_attachment`
--

LOCK TABLES `django_summernote_attachment` WRITE;
/*!40000 ALTER TABLE `django_summernote_attachment` DISABLE KEYS */;
INSERT INTO `django_summernote_attachment` VALUES (1,'640x480_10.jpg','django-summernote/2018-05-23/d88497e0-781f-4b2e-91e0-9cb1919d7a58.jpg','2018-05-23 17:47:22.658715'),(2,'Chicken-Meal-Prep-Five-Ways-6-1024x678.jpg','django-summernote/2018-05-23/b7b4226a-fe26-4f9f-b4a4-1fe68c669b8e.jpg','2018-05-23 17:58:54.273073'),(3,'Без названия (1).jpg','django-summernote/2018-05-23/eef1decd-40f1-4f11-9d32-81b2a6934699.jpg','2018-05-23 18:07:27.216927'),(4,'Без названия (1).jpg','django-summernote/2018-05-23/98f96296-589f-4e9c-af7a-ed6b6020f33e.jpg','2018-05-23 18:07:53.089890');
/*!40000 ALTER TABLE `django_summernote_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extendeduser`
--

DROP TABLE IF EXISTS `extendeduser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extendeduser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bio` longtext NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `extendeduser_role_id_c2d96986_fk_roles_id` (`role_id`),
  CONSTRAINT `extendeduser_role_id_c2d96986_fk_roles_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `extendeduser_user_id_11149204_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extendeduser`
--

LOCK TABLES `extendeduser` WRITE;
/*!40000 ALTER TABLE `extendeduser` DISABLE KEYS */;
INSERT INTO `extendeduser` VALUES (1,'Info about me',0,1,1);
/*!40000 ALTER TABLE `extendeduser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ideas`
--

DROP TABLE IF EXISTS `ideas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ideas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `cover` varchar(100) DEFAULT NULL,
  `content` longtext NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `edit_date` datetime(6) NOT NULL,
  `views` int(10) unsigned NOT NULL,
  `slug` varchar(50) NOT NULL,
  `author_id` int(11) NOT NULL,
  `moderator_id` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `ideas_author_id_7fcd599d_fk_auth_user_id` (`author_id`),
  KEY `ideas_moderator_id_8a4343c0_fk_auth_user_id` (`moderator_id`),
  KEY `ideas_status_id_470785bc_fk_ideastatus_id` (`status_id`),
  CONSTRAINT `ideas_author_id_7fcd599d_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `ideas_moderator_id_8a4343c0_fk_auth_user_id` FOREIGN KEY (`moderator_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `ideas_status_id_470785bc_fk_ideastatus_id` FOREIGN KEY (`status_id`) REFERENCES `ideastatus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ideas`
--

LOCK TABLES `ideas` WRITE;
/*!40000 ALTER TABLE `ideas` DISABLE KEYS */;
INSERT INTO `ideas` VALUES (2,'оптовое приготовление пищи','uploads/2018/05/23/767c63017b53e43535fce494a2249aff30bf7967.jpg','<p data-plerdy=\"485\" style=\"margin-bottom: 30px; padding: 0px; border: 0px; vertical-align: baseline; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 1.66667em; font-family: Roboto, Arial, sans-serif;\"><span style=\"color: rgb(105, 105, 105);\">Можете воспользоваться идеей для малого бизнеса, связанного с выпечкой. Вы создаете разные десерты дома, а потом оптом продаёте их местным булочным или ресторанам. Это не только интересная идея для бизнеса с нуля</span><font color=\"#696969\">, которая поможет хорошо зарабатывать, делая то, что любите, но и отличный способ испробовать свои кулинарные шедевры, прежде чем инвестировать в создание полноценного ресторанчика.</font></p><p data-plerdy=\"485\" style=\"margin-bottom: 30px; padding: 0px; border: 0px; vertical-align: baseline; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 1.66667em; font-family: Roboto, Arial, sans-serif; color: rgb(105, 105, 105);\"><img src=\"/media/django-summernote/2018-05-23/b7b4226a-fe26-4f9f-b4a4-1fe68c669b8e.jpg\" style=\"width: 698px;\"><br></p><p data-plerdy=\"487\" style=\"margin-bottom: 30px; padding: 0px; border: 0px; vertical-align: baseline; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 1.66667em; font-family: Roboto, Arial, sans-serif; color: rgb(105, 105, 105);\">Но сперва нужно будет больше узнать о законах, которые регулируют приготовление пищи в домашних условиях на продажу, а они достаточно строгие, а также чтобы были соответственные медицинские книжки у персонала.</p>',1,'2018-05-23 17:59:35.517126','2018-05-23 19:45:10.561807',0,'delivery_food',2,NULL,1),(3,'BICYCLE REPAIR','uploads/2018/05/23/Без_названия.jpg','<p><a href=\"https://www.youtube.com/watch?v=wPTbkqdaxnE\" target=\"_blank\">BICYCLE REPAIR</a></p><p><span style=\"color: rgb(33, 33, 33); font-family: &quot;PT Serif&quot;, TimesNewRoman, &quot;Times New Roman&quot;, Times, Georgia, serif; font-size: 19px;\">In many parts of the country, this business tends to be seasonal, but you can find ways around that. Rent a storage unit and offer to store people\'s bicycles over the winter after you do a tune-up and any needed repairs on them. If you want to cater to the Lance Armstrong wannabes, you can have business all year round. These road race riders are training through snow, sleet and dark of night. Some of them work on their own bicycles, but many of them don\'t, so you can get their business all year. And if you keep Saturday shop hours, you can be sure you will have a group of enthusiasts coming by to talk all things cycling.</span><br><br></p>',1,'2018-05-23 18:03:47.577520','2018-05-23 18:03:47.577619',0,'BICYCLE_REPAIR',2,NULL,1),(4,'EDITORIAL SERVICES','uploads/2018/05/23/proofreading-and-editing-services.jpg','<p style=\"box-sizing: inherit; margin-bottom: 1.75rem; color: rgb(33, 33, 33); font-family: &quot;PT Serif&quot;, TimesNewRoman, &quot;Times New Roman&quot;, Times, Georgia, serif; font-size: 19px;\">Here are some of the editorial services you can provide from the quiet of your own home:</p><ul style=\"box-sizing: inherit; padding: 0px; margin-left: 3rem; color: rgb(33, 33, 33); font-family: &quot;PT Serif&quot;, TimesNewRoman, &quot;Times New Roman&quot;, Times, Georgia, serif; font-size: 19px;\"><li style=\"box-sizing: inherit; list-style-type: disc;\"><span style=\"box-sizing: inherit; font-weight: 700;\">Copyediting.</span>&nbsp;This is where fact checking takes place, and where grammatical, stylistic and typographical errors are caught.</li><li style=\"box-sizing: inherit; list-style-type: disc;\"><span style=\"box-sizing: inherit; font-weight: 700;\">Proofreading.</span>&nbsp;This is the last stop for a \"finished\" piece. The proofreader makes sure the copyediting changes have been properly made and no new errors are created in the process.</li><li style=\"box-sizing: inherit; list-style-type: disc;\"><span style=\"box-sizing: inherit; font-weight: 700;\">Indexing.</span>&nbsp;There are indexing courses available and you can get indexing software.</li><li style=\"box-sizing: inherit; list-style-type: disc;\"><span style=\"box-sizing: inherit; font-weight: 700;\">Developmental editing.</span>&nbsp;A developmental editor works with a manuscript on big-picture things like organization and content issues.</li><li style=\"box-sizing: inherit; list-style-type: disc;\"><span style=\"box-sizing: inherit; font-weight: 700;\">Book doctoring.</span>&nbsp;This is an editorial service provided for manuscripts written by experts. They create a manuscript as best they can and then a book doctor puts it into publishable shape.</li><li style=\"box-sizing: inherit; list-style-type: disc;\"><span style=\"box-sizing: inherit; font-weight: 700;\">Ghost Writing.</span>&nbsp;As a ghost writer, you actually do the research and write the book and someone else\'s name is attached as the author.</li><li style=\"box-sizing: inherit; list-style-type: disc;\"><span style=\"box-sizing: inherit; font-weight: 700;\">Copywriting.</span>&nbsp;Also known as business writing, this is writing that promotes a product or a service.</li><li style=\"box-sizing: inherit; list-style-type: disc;\"><span style=\"box-sizing: inherit; font-weight: 700;\">Book writing.</span>&nbsp;Do you have an expertise in something professional, such as accounting or interior decorating? Or personally, like knitting? Why not write a book about it?</li><li style=\"box-sizing: inherit; list-style-type: disc;\"><span style=\"box-sizing: inherit; font-weight: 700;\">Magazine article writing.</span>&nbsp;Magazines and newspapers are a great way to get your writing published before tackling the daunting task of writing a whole book.</li><li style=\"box-sizing: inherit; list-style-type: disc;\"><span style=\"box-sizing: inherit; font-weight: 700;\">Web page content provider.</span>&nbsp;Providing content for a web site is a good way to make some money writing.</li></ul>',1,'2018-05-23 18:05:44.832452','2018-05-23 18:05:44.832551',0,'editorial_services',2,NULL,1),(5,'Event planning','uploads/2018/05/23/Без_названия_2.jpg','<p><img src=\"/media/django-summernote/2018-05-23/98f96296-589f-4e9c-af7a-ed6b6020f33e.jpg\" style=\"width: 283px;\"><span style=\"color: rgb(33, 33, 33); font-family: &quot;PT Serif&quot;, TimesNewRoman, &quot;Times New Roman&quot;, Times, Georgia, serif; font-size: 19px;\"><br></span></p><p><span style=\"color: rgb(33, 33, 33); font-family: &quot;PT Serif&quot;, TimesNewRoman, &quot;Times New Roman&quot;, Times, Georgia, serif; font-size: 19px;\">One of the first things you need to do is visit every potential event location with which you plan to work. Work with the marketing manager to tour each site and learn what is available at each location. Start a database that will allow you to sort venues by varying features--the number of people each site holds, if there is AV equipment available on site, will you need to arrange for rental chairs, etc. Then when you are beginning to plan an event with a client, you can find out what the key parameters are for the event and easily pull up the three or four sites that meet the basic criteria. and engagement parties, etc.</span><br></p>',1,'2018-05-23 18:08:21.789596','2018-05-23 18:08:21.789707',0,'planning_event',2,NULL,1),(6,'personal training business','uploads/2018/05/23/maxresdefault.jpg','<p style=\"margin-bottom: 12.5px; font-family: &quot;PT Serif&quot;, serif; font-size: 18px; line-height: 32px; color: rgb(51, 51, 51);\">If you’re into some aspect of fitness, a personal training business could be a great small business idea. From general fitness coaching&nbsp;to becoming an instructor (think Zumba or Pilates)—if you’re more&nbsp;<a target=\"_blank\" href=\"http://thoughtcatalog.com/nico-lang/2013/05/these-34-chris-traeger-isms-are-literally-the-greatest-quotes-of-all-time/\" rel=\"noopener\" style=\"color: rgb(3, 133, 200);\">motivational than Chris Traeger from Parks and Rec,</a>&nbsp;a personal training business might be a successful route for you. After all, the&nbsp;best business ideas for you will be the ones that play to your strengths.&nbsp;</p><p style=\"margin-bottom: 12.5px; font-family: &quot;PT Serif&quot;, serif; font-size: 18px; line-height: 32px; color: rgb(51, 51, 51);\">Bear in mind that like many options on this list, you’ll need certification. NASM, ACE, and ACSM are a few of the most common and well-respected certifications, but the path you choose will depend on your specific focus.</p><div id=\"hooly00\" style=\"color: rgb(52, 55, 66); font-family: &quot;Open Sans&quot;, Helvetica, Arial, sans-serif; font-size: 16px;\"><div style=\"width: 544px; margin: 0px auto; max-width: 544px;\"><div id=\"aniBox\" style=\"margin: 15px 0px; overflow: hidden; transition: height 1s ease; opacity: 0; width: 544px; height: 1px;\"><div id=\"aniplayer_aniviewJS\" style=\"visibility: hidden;\"><div id=\"aniplayer_aniviewJSgui\"><div id=\"av-container\" class=\" desktop hide-controls\" style=\"position: relative; width: 544px; height: 306px; background: black; margin: 0px; overflow: hidden; text-align: initial;\"><div id=\"av-inner\" style=\"position: absolute; top: 0px; left: 0px; width: 544px; height: 306px;\"><div id=\"slot\" style=\"position: absolute; width: 544px; height: 306px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 0px 1px inset;\"><div id=\"imgpreloader\"></div><div id=\"preloader\" style=\"width: 0px; height: 0px; position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px; margin: auto; outline: none;\"><svg class=\"icon\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" x=\"0px\" y=\"0px\" viewBox=\"0 0 30 30\" xml:space=\"preserve\"><g><path d=\"M23.3,14.9c0-0.4-0.3-0.9-0.8-1.2l-10-6.4c-1.1-0.7-2-0.1-2,1.3v7.5C15.8,13.7,23.1,14.9,23.3,14.9z M23.3,15 c-7.9,0.6-11.4,3.5-12.8,5.7v0.8c0,1.4,0.9,2,2,1.3l10-6.4C23.1,16,23.4,15.5,23.3,15z\"></path></g></svg><svg class=\"circle\" width=\"70\" height=\"70\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\"><circle cx=\"35\" cy=\"35\" r=\"32\"></circle></svg><svg class=\"circle active\" width=\"70\" height=\"70\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\"><circle cx=\"35\" cy=\"35\" r=\"32\"></circle></svg></div><div id=\"videoslot\" class=\"loaded\" style=\"position: absolute; top: 153px; transform: translateY(-50%); left: 0px; right: 0px; bottom: 0px; width: 544px; object-fit: initial; opacity: 1; animation: fade-in 0.5s ease; height: 306px;\"></div></div><div id=\"gui\"><div id=\"close-btn\" style=\"z-index: 100; position: absolute; top: 0px; left: 0px; width: 28px; height: 28px; background-color: rgba(0, 0, 0, 0.4); background-image: url(&quot;data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20xmlns%3Axlink%3D%22http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink%22%20id%3D%22close-Layer_1%22%20xml%3Aspace%3D%22preserve%22%20height%3D%2223%22%20viewBox%3D%220%200%2022.677%2022.677%22%20width%3D%2223%22%20version%3D%221.1%22%20y%3D%220px%22%20x%3D%220px%22%20enable-background%3D%22new%200%200%2022.677%2022.677%22%3E%09%09%3Cpolygon%20fill%3D%22white%22%20points%3D%2219.346%205.421%2017.256%203.332%2011.338%209.25%205.42%203.332%203.332%205.421%209.25%2011.338%203.332%2017.257%205.42%2019.345%2011.338%2013.427%2017.256%2019.345%2019.346%2017.257%2013.428%2011.338%22%20clip-rule%3D%22evenodd%22%20fill-rule%3D%22evenodd%22%2F%3E%3C%2Fsvg%3E&quot;); background-repeat: no-repeat; background-size: 60%; background-position: center center; border-color: white; border-style: solid; border-width: 0px 1px 1px 0px; transition: all 0.15s ease-in-out; display: inline;\"></div><div id=\"aniview-credit\" style=\"position: absolute; top: 2px; right: 2px; height: 24px; line-height: 24px; font-size: 11px; font-family: Helvetica, Arial, fallback, sans-serif; color: white; display: inline;\"><span style=\"display: inline-block; vertical-align: top; width: 5px; height: 5px; background-repeat: no-repeat; background-size: cover; background-image: url(&quot;https://hoolymedia.com&quot;);\"></span></div></div></div></div></div></div></div></div></div><p style=\"margin-bottom: 12.5px; font-family: &quot;PT Serif&quot;, serif; font-size: 18px; line-height: 32px; color: rgb(51, 51, 51);\"><b>For more information:</b></p><ul style=\"margin-bottom: 30px; margin-left: 15px; padding-left: 15px; color: rgb(52, 55, 66); font-family: &quot;Open Sans&quot;, Helvetica, Arial, sans-serif; font-size: 16px;\"><li style=\"margin-bottom: 14px; font-family: &quot;PT Serif&quot;, serif; font-size: 18px; line-height: 32px; color: rgb(51, 51, 51);\"><a target=\"_blank\" href=\"http://www.afpafitness.com/blog/successful-personal-trainer-business\" rel=\"noopener\" style=\"color: rgb(3, 133, 200);\">17 Tips for a Successful Personal Trainer Business</a></li><li style=\"margin-bottom: 14px; font-family: &quot;PT Serif&quot;, serif; font-size: 18px; line-height: 32px; color: rgb(51, 51, 51);\"><a target=\"_blank\" href=\"http://afoodiestaysfit.com/popular/become-a-fitness-instructor/\" rel=\"noopener\" style=\"color: rgb(3, 133, 200);\">Become a Fitness Instructor</a></li></ul>',1,'2018-05-23 18:10:41.658748','2018-05-23 18:10:41.658851',0,'personal_training',2,NULL,1),(7,'Цветочный бизнес (флоромат)','uploads/2018/05/23/FSTOR_-_Цветочный_Автомат_по_продаже_цветов.jpg','<p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Цветочный бизнес – бизнес мечты любой женщины. Однако обычным цветочным ларьком сегодня вы вряд ли сможете кого-то удивить. А вот флоромат – совершенно другое дело. Идея свежая, модная, наверное, одна из самых перспективных для стартапа.</p><p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Успех вашего бизнеса будет напрямую зависеть от места размещения вашего автомата. Вам нужно будет позаботиться, чтобы он находился в самом хлебном месте, в идеале в метро, в торговых центрах, в аэропорту, на вокзале, в супермаркете.</p><p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Конечно же, вам придется вложиться, чтобы купить непосредственно сам вендинговый аппарат, который стоит от 1,000 до 2,000 долларов в зависимости от модели. Также вам необходимо будет регулярно закупать сами цветы. Вы можете найти надежного поставщика и покупать у него цветы по оптовым ценам.</p><p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\"><img src=\"https://prostocoin.com/assets/images/business3.png\" alt=\"Флоромат\" style=\"max-width: 100%;\"></p><p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Отличный вариант для тех, кто может себе позволить вложить в бизнес такую сумму. Проект окупится в течение трех-пяти месяцев. Далее вы сможете расширять сеть своих автоматов.</p>',1,'2018-05-23 18:13:17.094237','2018-05-23 18:13:17.094350',0,'flowermat',2,NULL,1),(8,'Установка для зарядки гаджетов','uploads/2018/05/23/Без_названия_3.jpg','<p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Наверное, каждый из нас хоть раз в жизни сталкивался с проблемой, что вам срочно понадобилось подзарядить свой гаджет, а зарядки или розетки поблизости нет. В таком случае на помощь приходят универсальные автоматы для зарядки гаджетов. Вы можете установить подобные автоматы в торговых центрах, университетах, парках, на вокзалах и т.д.</p><p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Логика данного бизнеса проста – вы приобретаете оборудование, договариваетесь о его размещении в «хлебном» месте, а затем просто получаете деньги. Люди будут платить вам за возможность зарядить свой гаджет, а также вы можете зарабатывать на рекламе, продавая рекламное место на своём автомате.</p><p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Конечно же, данный вариант не окупится за пару дней или даже за месяц. Скорее всего на это уйдет от 3 месяцев до полугода (в зависимости от месторасположения вашего автомата). Достаточно легкий вариант заработать, от вас не требуется ничего кроме начальных вложений.</p>',1,'2018-05-23 18:15:24.819714','2018-05-23 18:15:24.819814',0,'charger_station',2,NULL,1),(9,'Автомат по продаже оригинальных носков','uploads/2018/05/23/images_1.jpg','<p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Наверное, все девушки и дети любят оригинальные, милые носочки. Некоторые молодые люди также делают выбор в пользу ярких, стильных носков. Соответственно, носки – отличный вариант наполнения вашего вендингового аппарата.</p><p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Ваши первоначальные инвестиции будут такими же, как и в случае флоромата или установки для зарядки гаджетов. Разместить автомат лучше в торговом центре. Приобрести оригинальные носки вы можете на ebay или в китайских интернет-магазинах. Цены там невероятно низкие, ассортимент потрясает, а сам процесс оплаты и доставки достаточно прост. В перспективе вы можете наладить бизнес с Китаем и приобретать интересный товар по приятным, оптовым ценам.</p>',1,'2018-05-23 18:17:08.338345','2018-05-23 18:17:08.338478',0,'socks',2,NULL,1),(10,'NOTARY PUBLIC/JUSTICE OF THE PEACE','uploads/2018/05/23/images_2.jpg','<p style=\"box-sizing: inherit; margin-bottom: 1.75rem; color: rgb(33, 33, 33); font-family: &quot;PT Serif&quot;, TimesNewRoman, &quot;Times New Roman&quot;, Times, Georgia, serif; font-size: 19px;\"><span style=\"box-sizing: inherit; font-weight: 700;\">Experience, training or licensing may be needed</span></p><p style=\"box-sizing: inherit; margin-bottom: 1.75rem; color: rgb(33, 33, 33); font-family: &quot;PT Serif&quot;, TimesNewRoman, &quot;Times New Roman&quot;, Times, Georgia, serif; font-size: 19px;\">In most states in the U.S., a notary public is a state officer who is authorized to witness and attest to the legalities of certain documents by signature and stamping a seal. Most states require that you pass an exam and a background check. It costs very little to become a notary and your income from notary work is negligible. A justice of the peace typically performs wedding ceremonies. States have varying rules and procedures for becoming a JP and performing services. Becoming a JP and/or notary public does not cost much money. And it is not a big moneymaking venture! Many states set the fees you can charge for JP services. JPs can add additional fees, and often do, including travel and hourly rates for additional meetings such as rehearsals, other prep time and any special requests.</p>',1,'2018-05-23 18:20:08.687032','2018-05-23 18:20:08.687131',0,'JPservices',2,NULL,1),(11,'Instagram Marketing','uploads/2018/05/23/Без_названия_4.jpg','<p><span style=\"color: rgb(51, 51, 51); font-family: &quot;Open Sans&quot;; font-size: 17px;\">Build up a following on your Instagram account and you could quickly be approached by major brands, gear companies, and other relevant businesses that sell products or services related to the type of content you share on Instagram—creating multiple potential side business ideas that\'ll come to you. If you have the right&nbsp;</span><a href=\"https://www.ryrob.com/marketing-skills/\" target=\"_blank\" rel=\"noopener\" style=\"margin: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 17px; line-height: inherit; font-family: &quot;Open Sans&quot;; vertical-align: baseline; color: rgb(30, 115, 190); background-color: rgb(255, 255, 255); transition: all 0.15s ease-in-out; outline: none !important;\">marketing skills</a><span style=\"color: rgb(51, 51, 51); font-family: &quot;Open Sans&quot;; font-size: 17px;\">&nbsp;and hundreds of thousands of followers, you can easily charge anywhere between $500 to $5,000 per post (or more)—which makes for a very profitable side business idea. Check out&nbsp;</span><span style=\"margin: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 17px; line-height: inherit; font-family: &quot;Open Sans&quot;; vertical-align: baseline; color: rgb(15, 135, 201);\"><a href=\"http://www.thepennyhoarder.com/fashion-bloggers-make-money-on-instagram/\" target=\"_blank\" rel=\"nofollow noopener noreferrer\" style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(15, 135, 201); transition: all 0.15s ease-in-out; outline: none !important;\">this fashion Instagrammer</a></span><span style=\"color: rgb(51, 51, 51); font-family: &quot;Open Sans&quot;; font-size: 17px;\">&nbsp;on ThePennyHoarder, making a significant income from brand sponsorships. Once you get some traction, to cut down on the amount of time you spend uploading images, you can make your entire workflow more efficient by&nbsp;</span><a href=\"https://ihitthebutton.com/upload-instagram-pc/\" target=\"_blank\" rel=\"noopener noreferrer\" style=\"margin: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 17px; line-height: inherit; font-family: &quot;Open Sans&quot;; vertical-align: baseline; color: rgb(30, 115, 190); background-color: rgb(255, 255, 255); transition: all 0.15s ease-in-out; outline: none !important;\">posting photos from your Mac or PC</a><span style=\"color: rgb(51, 51, 51); font-family: &quot;Open Sans&quot;; font-size: 17px;\">.</span><br></p>',1,'2018-05-23 18:26:14.973535','2018-05-23 18:26:14.973632',0,'Instagram_Marketing',2,NULL,1),(12,'Start a Blog','uploads/2018/05/23/Без_названия.png','<p><a href=\"https://www.youtube.com/watch?v=KKofWVEbfLQ\" target=\"_blank\">Start a Blog</a></p><p style=\"margin: 20px auto; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 17px; line-height: inherit; font-family: &quot;Open Sans&quot;; vertical-align: baseline; -webkit-font-smoothing: antialiased; opacity: 1; visibility: visible; transition: opacity 0.24s ease-in-out; color: rgb(51, 51, 51);\"><img class=\"wp-image-3412 aligncenter\" src=\"https://mk0ryrobg0ysk5t06n.kinstacdn.com/wp-content/uploads/2018/04/Best-Business-Ideas-Start-A-Blog-Freelance-1024x683.jpg\" alt=\"Best Business Ideas Start A Blog\" width=\"750\" height=\"500\" srcset=\"https://mk0ryrobg0ysk5t06n.kinstacdn.com/wp-content/uploads/2018/04/Best-Business-Ideas-Start-A-Blog-Freelance-1024x683.jpg 1024w, https://mk0ryrobg0ysk5t06n.kinstacdn.com/wp-content/uploads/2018/04/Best-Business-Ideas-Start-A-Blog-Freelance-300x200.jpg 300w, https://mk0ryrobg0ysk5t06n.kinstacdn.com/wp-content/uploads/2018/04/Best-Business-Ideas-Start-A-Blog-Freelance-768x513.jpg 768w\" sizes=\"(max-width: 750px) 100vw, 750px\" style=\"margin: 30px auto; padding: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; max-width: 100%; height: auto; text-align: center; float: none; display: block;\"></p><p style=\"margin: 20px auto; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 17px; line-height: inherit; font-family: &quot;Open Sans&quot;; vertical-align: baseline; -webkit-font-smoothing: antialiased; opacity: 1; visibility: visible; transition: opacity 0.24s ease-in-out; color: rgb(51, 51, 51);\">Think blogging is no longer a viable source of income? Think again. Tens of&nbsp;thousands&nbsp;of bloggers, creating content&nbsp;on topics as diverse as scrapbooking, home cooking, travel, film, lifestyle, and more are launching self-employed careers&nbsp;thanks to a combination of email subscribers, affiliate marketing,&nbsp;<a href=\"https://www.ryrob.com/get-blog-sponsorships/\" target=\"_blank\" rel=\"noopener\" style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(30, 115, 190); transition: all 0.15s ease-in-out; outline: none !important;\">blog sponsorships</a>, and other revenue streams. Your first step is sharpening your writing abilities, understanding what your audience craves and learning how to&nbsp;<a href=\"http://www.ryrob.com/resources/creativelive/write-blog-post/\" style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(30, 115, 190); transition: all 0.15s ease-in-out; outline: none !important;\">write a blog post that drives traffic</a>&nbsp;and brings you readers on a regular basis.&nbsp;Even blogging about tech gadgets and products you love can turn into a profitable side business. Take my friend Andy\'s blog,&nbsp;<a href=\"https://awesomestufftobuy.com/\" target=\"_blank\" rel=\"noopener noreferrer\" style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(30, 115, 190); transition: all 0.15s ease-in-out; outline: none !important;\">AwesomeStuffToBuy</a>&nbsp;for example. Or listen to my interview with Gaby Dalkin about how her journey to&nbsp;<a href=\"https://www.ryrob.com/start-food-blog-gaby-dalkin-interview/\" target=\"_blank\" rel=\"noopener\" style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(30, 115, 190); transition: all 0.15s ease-in-out; outline: none !important;\">start a food blog</a>&nbsp;as a side business idea.</p><p style=\"margin: 20px auto; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 17px; line-height: inherit; font-family: &quot;Open Sans&quot;; vertical-align: baseline; -webkit-font-smoothing: antialiased; opacity: 1; visibility: visible; transition: opacity 0.24s ease-in-out; color: rgb(51, 51, 51);\">If you want to speed up the process of building your blog, I recommend setting up quick, affordable and easy website hosting with a company like&nbsp;<a href=\"http://www.ryrob.com/resources/hostgator\" target=\"_blank\" rel=\"noopener noreferrer\" style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(30, 115, 190); transition: all 0.15s ease-in-out; outline: none !important;\">HostGator</a>&nbsp;and then hiring a talented freelance designer or web developer on a high quality marketplace like&nbsp;<span style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(15, 135, 201);\"><a href=\"http://www.ryrob.com/resources/crew/\" target=\"_blank\" rel=\"noopener noreferrer\" style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(15, 135, 201); transition: all 0.15s ease-in-out; outline: none !important;\">Crew</a></span>&nbsp;in order to free up more of your time to utilize on creating content, connecting with (and building) your audience. Then once you\'ve been able to&nbsp;<a href=\"https://www.ryrob.com/build-community-side-hustle-chris-guillebeau/\" target=\"_blank\" rel=\"noopener noreferrer\" style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(30, 115, 190); transition: all 0.15s ease-in-out; outline: none !important;\">build a community</a>&nbsp;around your blog, you\'ll want to invest in really understanding your readers—so that you can give them more of what they want.</p><p><br></p>',1,'2018-05-23 18:28:50.463715','2018-05-23 18:28:50.463813',0,'Start_a_Blog',2,NULL,1),(13,'Sell on Etsy','uploads/2018/05/23/images_3.jpg','<p><span style=\"color: rgb(51, 51, 51); font-family: &quot;Open Sans&quot;; font-size: 17px;\">Have a talent for crafting or creating other handmade goods? From bracelets to phone cases, rings,&nbsp;furniture, and more,&nbsp;</span><span style=\"margin: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 17px; line-height: inherit; font-family: &quot;Open Sans&quot;; vertical-align: baseline; color: rgb(15, 135, 201);\"><a href=\"https://www.etsy.com/\" target=\"_blank\" rel=\"nofollow noopener noreferrer\" style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(15, 135, 201); transition: all 0.15s ease-in-out; outline: none !important;\">Etsy</a></span><span style=\"color: rgb(51, 51, 51); font-family: &quot;Open Sans&quot;; font-size: 17px;\">&nbsp;is one of the world\'s largest independent marketplaces that’s perfect for anyone who is creative and willing to sell their handmade creations. As long as you have the space, this can make for one of the best home business ideas that can be started as a side hustle with a very limited investment. Consider these&nbsp;</span><span style=\"margin: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 17px; line-height: inherit; font-family: &quot;Open Sans&quot;; vertical-align: baseline; color: rgb(15, 135, 201);\"><a href=\"http://www.handmadeology.com/5-things-to-consider-before-starting-an-etsy-shop/\" target=\"_blank\" rel=\"noopener noreferrer\" style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(15, 135, 201); transition: all 0.15s ease-in-out; outline: none !important;\">5 steps to starting an Etsy store</a></span><span style=\"color: rgb(51, 51, 51); font-family: &quot;Open Sans&quot;; font-size: 17px;\">, from Handmadeology. Then, after you\'re able to build your brand and grow your own audience, you can&nbsp;</span><span style=\"margin: 0px; padding: 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 17px; line-height: inherit; font-family: &quot;Open Sans&quot;; vertical-align: baseline; color: rgb(15, 135, 201);\"><a href=\"https://www.fundera.com/blog/starting-an-ecommerce-site/\" target=\"_blank\" rel=\"noopener noreferrer\" style=\"margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(15, 135, 201); transition: all 0.15s ease-in-out; outline: none !important;\">start an eCommerce site</a></span><span style=\"color: rgb(51, 51, 51); font-family: &quot;Open Sans&quot;; font-size: 17px;\">&nbsp;of your own and retain a larger portion of the revenue from your product sales—making this a very lucrative potential business idea if you\'re able to find an audience that loves your products.</span><br></p>',1,'2018-05-23 18:32:42.946674','2018-05-23 18:32:42.946773',0,'Etsy_store',2,NULL,1),(14,'Сервис аренды вечерних и свадебных платьев','uploads/2018/05/23/images_4.jpg','<p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Не все могут себе позволить купить дорогое платье, чтобы покрасоваться на нем на фотосессии, выпускном, свадьбе или любом другом мероприятии. Для этого был придуман сервис аренды вечерних и свадебных платьев. Хороший вариант для женщин и девушек, которые разбираются в моде и имеют чувство стиля (а если вы еще занимаетесь ремонтом и пошивом одежды, то этот вариант точно для вас).</p><p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Для начала вам нужно будет арендовать помещение, закупить вешалки, отпариватели, зеркала и т.д. Вам необязательно покупать новые платья; вы можете выкупать б/у платья в отличном состоянии или же брать их «под реализацию» (в таком случае владелица платья будет получать комиссию с каждой аренды ее платья). Главное – подобрать ходовой ассортимент, а также обеспечить себе хорошую рекламу. Можно договориться со свадебными агентствами, ивент-агентствами, фотографами, чтобы те направляли клиентов прямиком к вам. Создайте аккаунты в социальных сетях, разместите рекламу в интернете, напишите сайт.</p><p style=\"padding-bottom: 25px; color: rgb(51, 51, 51); font-family: Merriweather, serif; font-size: 16px;\">Окупаемость данного проекта будет не быстрой – минимум 3-5 месяцев. Однако в перспективе подобный бизнес может приносить вам очень хороший доход, если вы все сделаете правильно!</p>',1,'2018-05-23 18:35:45.098786','2018-05-23 18:35:45.098883',0,'rentOFdresses',2,NULL,1),(15,'изготовления кроватей-трансформеров','uploads/2018/05/23/бизнес-идея-изготовления-и-монтажа-кроватей-трансформеров-1024x689.png','<p><span style=\"color: rgb(34, 34, 34); font-family: Verdana, Geneva, sans-serif; font-size: 15px;\">Высокие цены на недвижимость заставляют многих людей использовать нестандартные варианты рационального использования жилой площади.</span></p><p><span style=\"color: rgb(34, 34, 34); font-family: Verdana, Geneva, sans-serif; font-size: 15px; text-decoration-line: underline;\">Владельцы небольших квартир-студий часто отдают предпочтение такому интересному дизайнерскому решению, как установка скрытой кровати</span><span style=\"color: rgb(34, 34, 34); font-family: Verdana, Geneva, sans-serif; font-size: 15px;\">.</span></p><p style=\"font-family: Verdana, Geneva, sans-serif; font-size: 15px; line-height: 26px; margin-bottom: 26px; word-wrap: break-word; color: rgb(34, 34, 34);\">Это позволяет использовать данный предмет мебели только в ночное время суток, не загромождая жилое пространство днем.</p><p style=\"font-family: Verdana, Geneva, sans-serif; font-size: 15px; line-height: 26px; margin-bottom: 26px; word-wrap: break-word; color: rgb(34, 34, 34);\"><strong>Изготовление и монтаж кроватей-трансформеров –&nbsp;<a href=\"http://realybiz.ru/\" target=\"_blank\" class=\"seolink_target\" style=\"color: royalblue !important;\">отличная идея</a>&nbsp;и довольно выгодный бизнес</strong>.</p><p style=\"font-family: Verdana, Geneva, sans-serif; font-size: 15px; line-height: 26px; margin-bottom: 26px; word-wrap: break-word; color: rgb(34, 34, 34);\">Спрос на такую мебель с каждым днем растет. Ее часто заказывают не только владельцы малогабаритных квартир, но и те люди, к которым часто приезжают гости.</p><p style=\"font-family: Verdana, Geneva, sans-serif; font-size: 15px; line-height: 26px; margin-bottom: 26px; word-wrap: break-word; color: rgb(34, 34, 34);\"><span style=\"text-decoration-line: underline;\">Потенциальными клиентами фирма, занимающейся изготовлением выдвижных кроватей, могут стать владельцы хостелов, мини-гостиниц</span>, которым необходимо размещать в номерах одновременно нескольких постояльцев.</p><p style=\"font-family: Verdana, Geneva, sans-serif; font-size: 15px; line-height: 26px; margin-bottom: 26px; word-wrap: break-word; color: rgb(34, 34, 34);\">Прибыль от изготовления и монтажа кровати-трансформера может достигать 10-15 тысяч рублей. При хорошем раскладе вложения в реализацию проекта окупаются в течение 6 месяцев непрерывной работы.</p><p style=\"font-family: Verdana, Geneva, sans-serif; font-size: 15px; line-height: 26px; margin-bottom: 26px; word-wrap: break-word; color: rgb(34, 34, 34);\">Но при этом не стоит забывать о том, что величина будущего заработка будет зависеть в первую очередь от того, какого размера производство вы планируете наладить. К примеру, реализовывая одну кровать-трансформер можно получить порядка 10-15 тысяч. Если же в месяц устанавливать примерно 4-5 кроватей, то ежемесячный доход может составлять около 50-70 тысяч рублей.</p><p><br></p>',1,'2018-05-23 18:38:02.153785','2018-05-23 18:38:02.153892',0,'bed_transformer',2,NULL,1);
/*!40000 ALTER TABLE `ideas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ideas_likes`
--

DROP TABLE IF EXISTS `ideas_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ideas_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ideas_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ideas_likes_ideas_id_user_id_f1ae6a50_uniq` (`ideas_id`,`user_id`),
  KEY `ideas_likes_user_id_4c39f6b2_fk_auth_user_id` (`user_id`),
  CONSTRAINT `ideas_likes_ideas_id_a61da2ab_fk_ideas_id` FOREIGN KEY (`ideas_id`) REFERENCES `ideas` (`id`),
  CONSTRAINT `ideas_likes_user_id_4c39f6b2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ideas_likes`
--

LOCK TABLES `ideas_likes` WRITE;
/*!40000 ALTER TABLE `ideas_likes` DISABLE KEYS */;
INSERT INTO `ideas_likes` VALUES (1,2,1);
/*!40000 ALTER TABLE `ideas_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ideastatus`
--

DROP TABLE IF EXISTS `ideastatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ideastatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ideastatus`
--

LOCK TABLES `ideastatus` WRITE;
/*!40000 ALTER TABLE `ideastatus` DISABLE KEYS */;
INSERT INTO `ideastatus` VALUES (1,'New Idea');
/*!40000 ALTER TABLE `ideastatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'User');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialaccount`
--

DROP TABLE IF EXISTS `socialaccount_socialaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` (`user_id`),
  CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp`
--

DROP TABLE IF EXISTS `socialaccount_socialapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp`
--

LOCK TABLES `socialaccount_socialapp` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp_sites`
--

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialapp_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `socialapp_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`),
  CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp_sites`
--

LOCK TABLES `socialaccount_socialapp_sites` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialtoken`
--

DROP TABLE IF EXISTS `socialaccount_socialtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialtoken`
--

LOCK TABLES `socialaccount_socialtoken` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thumbnail_kvstore`
--

DROP TABLE IF EXISTS `thumbnail_kvstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thumbnail_kvstore` (
  `key` varchar(200) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thumbnail_kvstore`
--

LOCK TABLES `thumbnail_kvstore` WRITE;
/*!40000 ALTER TABLE `thumbnail_kvstore` DISABLE KEYS */;
INSERT INTO `thumbnail_kvstore` VALUES ('sorl-thumbnail||image||070a1b521c5583b371b9886c48915c5a','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/6a/62/6a629ee40067a9887fc81ab1af423a61.jpg\", \"size\": [640, 320]}'),('sorl-thumbnail||image||0908666453831b07efb09f911b035522','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/images_3.jpg\", \"size\": [225, 225]}'),('sorl-thumbnail||image||09295bbbdb8d02f596a8edeb4dcedb5c','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/images_4.jpg\", \"size\": [275, 183]}'),('sorl-thumbnail||image||10ad4028aa26640e9fd2aa8197b36601','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/cf/be/cfbedeac0a7e84aca2b1fe2327d70b5e.jpg\", \"size\": [640, 406]}'),('sorl-thumbnail||image||12cca73e797f107009975cc70fed455b','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/\\u0411\\u0435\\u0437_\\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u044f_2.jpg\", \"size\": [318, 159]}'),('sorl-thumbnail||image||16f8f197e76983d74ee9caa1993a8314','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/a8/1d/a81d0b3bd5994d203c34220d85e29f52.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||21e1ba428fc3133007b199b2bd9b62d8','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/\\u0411\\u0435\\u0437_\\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u044f_3.jpg\", \"size\": [282, 179]}'),('sorl-thumbnail||image||2570a56c4f9254a1530290c5dbd177e9','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/5a/c6/5ac6342bef6c516e16b990027d0e9267.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||300bd066399846a1a2a31236a53f4c1c','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/FSTOR_-_\\u0426\\u0432\\u0435\\u0442\\u043e\\u0447\\u043d\\u044b\\u0439_\\u0410\\u0432\\u0442\\u043e\\u043c\\u0430\\u0442_\\u043f\\u043e_\\u043f\\u0440\\u043e\\u0434\\u0430\\u0436\\u0435_\\u0446\\u0432\\u0435\\u0442\\u043e\\u0432.jpg\", \"size\": [1000, 667]}'),('sorl-thumbnail||image||34531b810a270b2813e4b0bd007d001d','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/86/d8/86d848f3cbad36a12ffba347cace37ed.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||389ac2dabc8fa62b152b8a0b488453ad','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/ff/28/ff28b25cde8144113d63006e7279cb2f.jpg\", \"size\": [320, 122]}'),('sorl-thumbnail||image||3c85da6255ae9ea8f00b2abc310ee8cf','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/\\u0431\\u0438\\u0437\\u043d\\u0435\\u0441-\\u0438\\u0434\\u0435\\u044f-\\u0438\\u0437\\u0433\\u043e\\u0442\\u043e\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f-\\u0438-\\u043c\\u043e\\u043d\\u0442\\u0430\\u0436\\u0430-\\u043a\\u0440\\u043e\\u0432\\u0430\\u0442\\u0435\\u0439-\\u0442\\u0440\\u0430\\u043d\\u0441\\u0444\\u043e\\u0440\\u043c\\u0435\\u0440\\u043e\\u0432-1024x689.png\", \"size\": [1024, 689]}'),('sorl-thumbnail||image||3d66f0d81b14ad90944923f5f747427b','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/ba/38/ba3821674487592ae36b70841b8ac5b5.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||3dde01bea856d891ec6ac756e4c9e088','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/03/01/0301a4d2bdf4399ddbae0315232e46b6.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||41266657c70915761f7d27eb83f5d11b','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/6c/1e/6c1e4a0f49cfcaca7238857d86b9a89d.jpg\", \"size\": [320, 203]}'),('sorl-thumbnail||image||4594791a1ac1f68f4738f2dfab2a410d','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/bf/25/bf2588030713de0dbb5c397c81abb13a.jpg\", \"size\": [320, 213]}'),('sorl-thumbnail||image||57f5d00ad256dcc22ee49754270bf14b','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/e7/85/e7854b30e248de6fbca544f1f8ef26dd.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||5e7088076fb2f266f33f63d90337bd67','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/57/50/5750c0db89ffdf6eb70bf7cbdad9ca1a.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||612bdf85380ab3f398fc9c07a8d35f4e','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/\\u0411\\u0435\\u0437_\\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u044f_4.jpg\", \"size\": [300, 168]}'),('sorl-thumbnail||image||6222ea5a39bcd8e4b74dab76c4a9af37','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/17/6e/176e41d19a72aa9ff80b747ef0a9eb47.jpg\", \"size\": [320, 160]}'),('sorl-thumbnail||image||66da6900feca3b557d691e3b826ac152','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/33/be/33becaa8dbd16f0524f6f4df6f0d15d7_9dqzVN6.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||70bf99ae0ef9ccd64ff350f1285a1a7a','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/7e/0f/7e0f21c56c970c9c1334db1ea1c9d07c.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||7ae279907c6142efdd99c3795c02c979','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/1e/0b/1e0b9b20bab4098650f39f719607e71f.jpg\", \"size\": [411, 480]}'),('sorl-thumbnail||image||7df158a3dad020d7b7ad78a11a8bc42c','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/3e/ff/3effa88653273ce8641af9d8e4c93e0a.jpg\", \"size\": [480, 480]}'),('sorl-thumbnail||image||80840dbb21ae61de76c3ea065c5edd89','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/767c63017b53e43535fce494a2249aff30bf7967.jpg\", \"size\": [600, 330]}'),('sorl-thumbnail||image||833b7dd2f19604de13e535191cc52985','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/proofreading-and-editing-services.jpg\", \"size\": [595, 227]}'),('sorl-thumbnail||image||916a2294865ab1cb04aad8fd44abe548','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/e8/1c/e81c646379cbd556d0b24bee359c810e.jpg\", \"size\": [320, 156]}'),('sorl-thumbnail||image||92d951fe6c89dc47b3ba253a3ff85374','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/d2/f1/d2f1cf08a8b72cab59306b6787c6373d.jpg\", \"size\": [320, 215]}'),('sorl-thumbnail||image||963dca4824232525a603996566a1e5a5','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/b6/f1/b6f14fa5e1795a71baf8830a6725b6a2.jpg\", \"size\": [640, 473]}'),('sorl-thumbnail||image||98e4b8ff99aaa9b91f1f344e25cc8b0e','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/d5/b0/d5b06a83ca78f4c86a1ade7f7f43abe3_75IvaiZ.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||99ffcda7ce0f795433dea1be703f6bcf','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/22/ae/22ae623488ae1058d64fae396fe274df_uWEUGuj.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||9eb67fcd283d30ccbb81c5dc2d5946ae','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/22/ae/22ae623488ae1058d64fae396fe274df.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||a282fa1adfd397d17f430d1c936d5ed9','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/fb/5c/fb5c09b0dc7c1cd22468c7392695ca59.jpg\", \"size\": [320, 213]}'),('sorl-thumbnail||image||aa957c084cb0968bdda9510293492c94','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/images_2.jpg\", \"size\": [261, 193]}'),('sorl-thumbnail||image||ab8b3027aff40ccc6faef6ad8c1cf6a1','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/ff/80/ff8052cda25f51e5dabbfaad0e684b7f.jpg\", \"size\": [640, 427]}'),('sorl-thumbnail||image||ac170049f71ac43251f91d0871854c54','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/87/5a/875ac50064bc0997d58ca6ab47d67a60.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||aca2c20e0700296f425bbd56ae7b7d19','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/maxresdefault.jpg\", \"size\": [1920, 1080]}'),('sorl-thumbnail||image||ad6a3dfc8d7dc070d9ec59a7e5e83282','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/85/f6/85f6d0636e8b520ec04dd469efe03d3b.jpg\", \"size\": [640, 312]}'),('sorl-thumbnail||image||ae0a6568a87732deb16ce6b1a89e622a','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/\\u0411\\u0435\\u0437_\\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u044f.png\", \"size\": [208, 243]}'),('sorl-thumbnail||image||aef84c8a72f1122d225c1ebe0259d844','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/03/01/0301a4d2bdf4399ddbae0315232e46b6_fLIa923.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||af2c6a3ba1ff973742685649361a1162','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/90/d8/90d8ffdad64776a805cc178b345367db.jpg\", \"size\": [640, 360]}'),('sorl-thumbnail||image||b35f8619fb9ad0b06fd9d972a3a7627f','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/39/ba/39bab8b58b6190b9cf6aa602df991f45.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||bc644732626f7aa5429064b48ce1e7b1','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/ac/93/ac9323d8557d1fe1a03f259f12cd6a9d.jpg\", \"size\": [320, 237]}'),('sorl-thumbnail||image||c2f125faa5ca442949b316dd3210425a','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/40/36/4036b505d1b674e07ecda705701ca1ed.jpg\", \"size\": [640, 352]}'),('sorl-thumbnail||image||c3c9108ed6f1b8e2e67ae6fd299d9030','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/7e/0f/7e0f21c56c970c9c1334db1ea1c9d07c_LyfR0GA.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||c858dc74cf1a70a00349ade69dbc0cb3','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/a8/d4/a8d4f9b081387f3483ca01c248b73589.jpg\", \"size\": [320, 176]}'),('sorl-thumbnail||image||cd5b7c6b3b7d6fc112d371719911bb6a','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/d5/b0/d5b06a83ca78f4c86a1ade7f7f43abe3.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||d13e9a5954e0c8ca078882f744601336','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/a8/1d/a81d0b3bd5994d203c34220d85e29f52_PnN29W3.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||d30a28c6108a98bb34fbed2913a9a53f','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/e7/85/e7854b30e248de6fbca544f1f8ef26dd_7XPTLUk.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||d474a5117bd4b2a0c2f642bac8636c7b','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/bc/15/bc156cf817aa3873adf7d6dd466dcd15.jpg\", \"size\": [205, 240]}'),('sorl-thumbnail||image||d49a630cc32e6d75a517b33806ba94da','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/9f/e7/9fe7c3a46f781d712a621eff7d34ad34.jpg\", \"size\": [640, 358]}'),('sorl-thumbnail||image||da687103bfe9fd25d93806f57e6c0745','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/53/79/537942dd26374a36ee265348db1e0a3e.jpg\", \"size\": [240, 240]}'),('sorl-thumbnail||image||dcabb7850a994a854423cf0cab744273','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/images_1.jpg\", \"size\": [275, 183]}'),('sorl-thumbnail||image||e99722cde79efbf793d585c66a188696','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/81/24/81243132578545c5f338b2561ba9140a.jpg\", \"size\": [320, 213]}'),('sorl-thumbnail||image||ea659d840f55e85e3ada9d49bc098372','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/a0/8d/a08de68bfa0afe52713f24acd492c124.jpg\", \"size\": [320, 180]}'),('sorl-thumbnail||image||ee28dcde05019a9616ce4a2aec711a17','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/79/e7/79e7890b5cabace7f20affac7a0484a5.jpg\", \"size\": [640, 244]}'),('sorl-thumbnail||image||ef3b2f27d1ecfc7320843a0791767a22','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"uploads/2018/05/23/\\u0411\\u0435\\u0437_\\u043d\\u0430\\u0437\\u0432\\u0430\\u043d\\u0438\\u044f.jpg\", \"size\": [322, 157]}'),('sorl-thumbnail||image||f71555623ae494f119687edddcd52b9f','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/0f/84/0f846712bc1ddfccc70930b20bee160d.jpg\", \"size\": [320, 179]}'),('sorl-thumbnail||image||f9b81874c2902585e9961fd81767567e','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/33/be/33becaa8dbd16f0524f6f4df6f0d15d7.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||fde50923675c40ab68e8652134e0b983','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/61/d0/61d06e7c512c2988759e1572e3ff9a48.jpg\", \"size\": [320, 240]}'),('sorl-thumbnail||image||fecd1b4f003cd362bbd77d0eb0f0686e','{\"storage\": \"django.core.files.storage.FileSystemStorage\", \"name\": \"cache/97/31/9731ec3293526e5aeb6c0edc2b48ea72.jpg\", \"size\": [640, 426]}'),('sorl-thumbnail||thumbnails||0908666453831b07efb09f911b035522','[\"7df158a3dad020d7b7ad78a11a8bc42c\", \"da687103bfe9fd25d93806f57e6c0745\", \"fde50923675c40ab68e8652134e0b983\"]'),('sorl-thumbnail||thumbnails||09295bbbdb8d02f596a8edeb4dcedb5c','[\"c3c9108ed6f1b8e2e67ae6fd299d9030\", \"4594791a1ac1f68f4738f2dfab2a410d\"]'),('sorl-thumbnail||thumbnails||12cca73e797f107009975cc70fed455b','[\"070a1b521c5583b371b9886c48915c5a\", \"34531b810a270b2813e4b0bd007d001d\", \"6222ea5a39bcd8e4b74dab76c4a9af37\"]'),('sorl-thumbnail||thumbnails||21e1ba428fc3133007b199b2bd9b62d8','[\"ac170049f71ac43251f91d0871854c54\", \"10ad4028aa26640e9fd2aa8197b36601\", \"41266657c70915761f7d27eb83f5d11b\"]'),('sorl-thumbnail||thumbnails||300bd066399846a1a2a31236a53f4c1c','[\"d30a28c6108a98bb34fbed2913a9a53f\", \"a282fa1adfd397d17f430d1c936d5ed9\", \"57f5d00ad256dcc22ee49754270bf14b\", \"ab8b3027aff40ccc6faef6ad8c1cf6a1\"]'),('sorl-thumbnail||thumbnails||3c85da6255ae9ea8f00b2abc310ee8cf','[\"d13e9a5954e0c8ca078882f744601336\", \"92d951fe6c89dc47b3ba253a3ff85374\"]'),('sorl-thumbnail||thumbnails||612bdf85380ab3f398fc9c07a8d35f4e','[\"aef84c8a72f1122d225c1ebe0259d844\", \"d49a630cc32e6d75a517b33806ba94da\", \"f71555623ae494f119687edddcd52b9f\"]'),('sorl-thumbnail||thumbnails||80840dbb21ae61de76c3ea065c5edd89','[\"c2f125faa5ca442949b316dd3210425a\", \"c858dc74cf1a70a00349ade69dbc0cb3\", \"2570a56c4f9254a1530290c5dbd177e9\"]'),('sorl-thumbnail||thumbnails||833b7dd2f19604de13e535191cc52985','[\"ee28dcde05019a9616ce4a2aec711a17\", \"389ac2dabc8fa62b152b8a0b488453ad\", \"b35f8619fb9ad0b06fd9d972a3a7627f\"]'),('sorl-thumbnail||thumbnails||aa957c084cb0968bdda9510293492c94','[\"98e4b8ff99aaa9b91f1f344e25cc8b0e\", \"bc644732626f7aa5429064b48ce1e7b1\", \"963dca4824232525a603996566a1e5a5\"]'),('sorl-thumbnail||thumbnails||aca2c20e0700296f425bbd56ae7b7d19','[\"9eb67fcd283d30ccbb81c5dc2d5946ae\", \"99ffcda7ce0f795433dea1be703f6bcf\", \"af2c6a3ba1ff973742685649361a1162\", \"ea659d840f55e85e3ada9d49bc098372\"]'),('sorl-thumbnail||thumbnails||ae0a6568a87732deb16ce6b1a89e622a','[\"d474a5117bd4b2a0c2f642bac8636c7b\", \"5e7088076fb2f266f33f63d90337bd67\", \"7ae279907c6142efdd99c3795c02c979\"]'),('sorl-thumbnail||thumbnails||dcabb7850a994a854423cf0cab744273','[\"fecd1b4f003cd362bbd77d0eb0f0686e\", \"66da6900feca3b557d691e3b826ac152\", \"e99722cde79efbf793d585c66a188696\"]'),('sorl-thumbnail||thumbnails||ef3b2f27d1ecfc7320843a0791767a22','[\"3d66f0d81b14ad90944923f5f747427b\", \"916a2294865ab1cb04aad8fd44abe548\", \"ad6a3dfc8d7dc070d9ec59a7e5e83282\"]');
/*!40000 ALTER TABLE `thumbnail_kvstore` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-24 18:44:47
