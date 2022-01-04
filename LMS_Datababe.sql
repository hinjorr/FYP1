/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 8.0.27-0ubuntu0.20.04.1 : Database - LMS
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`LMS` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `LMS`;

/*Table structure for table `Tbl_Admin` */

DROP TABLE IF EXISTS `Tbl_Admin`;

CREATE TABLE `Tbl_Admin` (
  `AdminID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  PRIMARY KEY (`AdminID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `Tbl_Admin_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Tbl_User` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Admin` */

insert  into `Tbl_Admin`(`AdminID`,`UserID`) values 
(1,65),
(2,73),
(3,76);

/*Table structure for table `Tbl_Attendence` */

DROP TABLE IF EXISTS `Tbl_Attendence`;

CREATE TABLE `Tbl_Attendence` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Class_ID` int DEFAULT NULL,
  `Session_ID` int DEFAULT NULL,
  `User_ID` int DEFAULT NULL,
  `User_Name` varchar(50) DEFAULT NULL,
  `1st` bit(1) DEFAULT b'0',
  `2nd` bit(1) DEFAULT b'0',
  PRIMARY KEY (`Id`),
  KEY `User_ID` (`User_ID`),
  KEY `Session_ID` (`Session_ID`),
  KEY `Class_ID` (`Class_ID`),
  CONSTRAINT `Tbl_Attendence_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `Tbl_User` (`UserID`),
  CONSTRAINT `Tbl_Attendence_ibfk_2` FOREIGN KEY (`Session_ID`) REFERENCES `Tbl_ClassSessions` (`Session_ID`),
  CONSTRAINT `Tbl_Attendence_ibfk_3` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Attendence` */

insert  into `Tbl_Attendence`(`Id`,`Class_ID`,`Session_ID`,`User_ID`,`User_Name`,`1st`,`2nd`) values 
(141,50,176,119,'518290','',''),
(142,50,176,75,'44560','',''),
(143,50,176,64,'student','',''),
(144,50,176,70,'317056','\0','\0'),
(145,50,176,78,'125961','\0','\0'),
(146,50,176,120,'24691','\0','\0'),
(147,50,176,121,'183492','\0','\0'),
(148,50,176,122,'793093','\0','\0'),
(157,50,180,119,'518290','\0','\0'),
(158,50,180,75,'44560','\0','\0'),
(159,50,180,64,'student','','\0'),
(160,50,180,70,'317056','\0','\0'),
(161,50,180,78,'125961','\0','\0'),
(162,50,180,120,'24691','\0',''),
(163,50,180,121,'183492','\0','\0'),
(164,50,180,122,'793093','\0','\0'),
(165,50,178,119,'518290','\0',''),
(166,50,178,75,'44560','\0','\0'),
(167,50,178,64,'student','\0',''),
(168,50,178,70,'317056','\0','\0'),
(169,50,178,78,'125961','',''),
(170,50,178,120,'24691','\0',''),
(171,50,178,121,'183492','\0',''),
(172,50,178,122,'793093','\0',''),
(173,50,175,119,'518290','',''),
(174,50,175,75,'44560','',''),
(175,50,175,64,'student','',''),
(176,50,175,70,'317056','',''),
(177,50,175,78,'125961','\0','\0'),
(178,50,175,120,'24691','\0','\0'),
(179,50,175,121,'183492','\0','\0'),
(180,50,175,122,'793093','\0','\0'),
(181,46,175,64,'student','',''),
(182,48,175,64,'student','',''),
(183,48,176,64,'student','','\0');

/*Table structure for table `Tbl_ClassContent` */

DROP TABLE IF EXISTS `Tbl_ClassContent`;

CREATE TABLE `Tbl_ClassContent` (
  `Content_ID` int NOT NULL AUTO_INCREMENT,
  `Class_ID` int DEFAULT NULL,
  `Session_ID` int DEFAULT NULL,
  `ContentName` varchar(100) DEFAULT NULL,
  `ContentLink` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Content_ID`),
  KEY `Class_ID` (`Class_ID`),
  KEY `Session_ID` (`Session_ID`),
  CONSTRAINT `Tbl_ClassContent_ibfk_1` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`),
  CONSTRAINT `Tbl_ClassContent_ibfk_2` FOREIGN KEY (`Session_ID`) REFERENCES `Tbl_ClassSessions` (`Session_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_ClassContent` */

/*Table structure for table `Tbl_ClassSessions` */

DROP TABLE IF EXISTS `Tbl_ClassSessions`;

CREATE TABLE `Tbl_ClassSessions` (
  `Session_ID` int NOT NULL AUTO_INCREMENT,
  `Semester_ID` int DEFAULT NULL,
  `SessionName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Session_ID`),
  KEY `Semester_ID` (`Semester_ID`),
  CONSTRAINT `Tbl_ClassSessions_ibfk_1` FOREIGN KEY (`Semester_ID`) REFERENCES `Tbl_Semester` (`Semester_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_ClassSessions` */

insert  into `Tbl_ClassSessions`(`Session_ID`,`Semester_ID`,`SessionName`) values 
(175,52,'11 October - 17 October'),
(176,52,'18 October - 24 October'),
(177,52,'25 October - 31 October'),
(178,52,'1 November - 7 November'),
(179,52,'8 November - 14 November'),
(180,52,'15 November - 21 November');

/*Table structure for table `Tbl_Classes` */

DROP TABLE IF EXISTS `Tbl_Classes`;

CREATE TABLE `Tbl_Classes` (
  `Class_Id` int NOT NULL AUTO_INCREMENT,
  `ClassStrength` int DEFAULT NULL,
  `Course_Id` int DEFAULT NULL,
  `Semester_Id` int DEFAULT NULL,
  `Program_Id` int DEFAULT NULL,
  `Day_Id` int DEFAULT NULL,
  `Time_Id` int DEFAULT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  `Class_Image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Class_Id`),
  KEY `Semester_Id` (`Semester_Id`),
  KEY `Course_Id` (`Course_Id`),
  KEY `Program_Id` (`Program_Id`),
  KEY `Day_Id` (`Day_Id`),
  KEY `Time_Id` (`Time_Id`),
  CONSTRAINT `Tbl_Classes_ibfk_1` FOREIGN KEY (`Semester_Id`) REFERENCES `Tbl_Semester` (`Semester_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Tbl_Classes_ibfk_4` FOREIGN KEY (`Course_Id`) REFERENCES `Tbl_Courses` (`CourseID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Tbl_Classes_ibfk_5` FOREIGN KEY (`Program_Id`) REFERENCES `Tbl_Programs` (`ProgramID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Tbl_Classes_ibfk_6` FOREIGN KEY (`Day_Id`) REFERENCES `Tbl_Days` (`Day_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Tbl_Classes_ibfk_7` FOREIGN KEY (`Time_Id`) REFERENCES `Tbl_Time` (`Time_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Classes` */

insert  into `Tbl_Classes`(`Class_Id`,`ClassStrength`,`Course_Id`,`Semester_Id`,`Program_Id`,`Day_Id`,`Time_Id`,`IsActive`,`Class_Image`) values 
(3,12,31,47,1,2,1,'\0',NULL),
(4,12,30,47,1,3,2,'\0',NULL),
(5,23,32,47,1,4,3,'\0',NULL),
(6,23,32,47,1,5,2,'\0',NULL),
(9,30,82,48,6,1,1,'\0',NULL),
(10,30,82,48,6,2,2,'\0',NULL),
(11,30,33,48,1,4,3,'\0',NULL),
(12,45,32,48,1,4,1,'\0',NULL),
(13,12,38,48,1,4,3,'\0',NULL),
(14,12,44,48,1,5,2,'\0',NULL),
(15,12,50,48,1,2,2,'\0',NULL),
(16,12,50,48,1,2,2,'\0',NULL),
(17,123,45,48,1,3,2,'\0',NULL),
(18,123,45,48,1,3,2,'\0',NULL),
(19,45,46,48,1,2,1,'\0',NULL),
(20,34,54,48,1,7,3,'\0',NULL),
(21,43,71,48,1,1,1,'\0',NULL),
(22,23,56,48,1,1,1,'\0',NULL),
(23,455,83,48,1,4,2,'\0',NULL),
(24,12,65,48,1,5,2,'\0',NULL),
(25,123,33,49,1,2,1,'\0',NULL),
(26,12,50,49,1,2,1,'\0',NULL),
(27,12,43,49,1,2,2,'\0',NULL),
(28,12,31,49,1,2,1,'\0',NULL),
(29,12,30,49,1,3,2,'\0',NULL),
(30,12,31,49,1,2,2,'\0',NULL),
(31,23,33,49,1,1,1,'\0',NULL),
(32,23,33,49,1,1,1,'\0',NULL),
(33,23,82,49,6,5,1,'\0',NULL),
(35,34,44,49,1,4,2,'\0',NULL),
(36,12,30,50,1,1,1,'\0',NULL),
(37,123,32,50,1,6,1,'\0',NULL),
(40,23,43,50,1,2,2,'\0',NULL),
(41,234,82,50,6,4,2,'\0',NULL),
(42,23,45,50,1,4,2,'\0',NULL),
(43,13,77,50,1,7,1,'\0',NULL),
(44,112,74,50,1,5,3,'\0',NULL),
(46,123,31,52,1,2,1,'',NULL),
(48,12,32,52,1,3,2,'',NULL),
(50,34,37,52,1,6,2,'','/Upload/1134531111111.jpg'),
(51,34,49,52,1,6,1,'',NULL),
(52,34,30,52,1,6,3,'',NULL),
(53,34,32,52,1,4,2,'',NULL),
(54,23,82,52,6,7,2,'',NULL),
(55,234,58,52,1,6,2,'',NULL),
(56,12,30,52,6,2,1,'',NULL),
(57,23,31,52,1,6,1,'',NULL),
(58,12,31,52,1,3,3,'',NULL),
(59,12,39,52,1,2,1,'',NULL);

/*Table structure for table `Tbl_CourseEligiblity` */

DROP TABLE IF EXISTS `Tbl_CourseEligiblity`;

CREATE TABLE `Tbl_CourseEligiblity` (
  `Elgibilty_ID` int NOT NULL AUTO_INCREMENT,
  `Class_Id` int DEFAULT NULL,
  `Program_Id` int DEFAULT NULL,
  `RqdCourse_Id` int DEFAULT NULL,
  PRIMARY KEY (`Elgibilty_ID`),
  KEY `Class_Id` (`Class_Id`),
  KEY `Program_Id` (`Program_Id`),
  KEY `RqdCourse_Id` (`RqdCourse_Id`),
  CONSTRAINT `Tbl_CourseEligiblity_ibfk_1` FOREIGN KEY (`Class_Id`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Tbl_CourseEligiblity_ibfk_2` FOREIGN KEY (`Program_Id`) REFERENCES `Tbl_Programs` (`ProgramID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Tbl_CourseEligiblity_ibfk_3` FOREIGN KEY (`RqdCourse_Id`) REFERENCES `Tbl_Courses` (`CourseID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_CourseEligiblity` */

/*Table structure for table `Tbl_Courses` */

DROP TABLE IF EXISTS `Tbl_Courses`;

CREATE TABLE `Tbl_Courses` (
  `CourseID` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) DEFAULT NULL,
  `ShortName` varchar(50) DEFAULT NULL,
  `CrHr` int DEFAULT NULL,
  `IsActive` bit(1) DEFAULT b'1',
  PRIMARY KEY (`CourseID`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Courses` */

insert  into `Tbl_Courses`(`CourseID`,`FullName`,`ShortName`,`CrHr`,`IsActive`) values 
(0,'Select Course','Select Course',0,''),
(30,'Programming Fundamentals	','PF',3,''),
(31,'Programming Fundamentals Lab','PF Lab',1,''),
(32,'Introduction to Info. & Communication Technologies ','IICT',3,''),
(33,'Introduction to Info. & Communication Technologies	 Lab','IICT Lab',1,''),
(34,'Pakistan and Islamic Studies	','PIS',3,''),
(35,'Visionary Leadership & Motivation	','VLM',3,''),
(36,'Algebra & Trigonometry	','A&T',3,''),
(37,'English-I (Proficiency Development)	','E1',3,''),
(38,'Principles of Management	','POM',3,''),
(39,'Object Oriented Programming	','OOP',3,''),
(40,'Object Oriented Programming	 Lab','OOP Lab',1,''),
(41,'Basic Electronics	','BE',3,''),
(42,'Basic Electronics	 Lab','BE Lab',1,''),
(43,'Financial Accounting	','FA',3,''),
(44,'Calculus & Analytical Geometry	','C&AG',3,''),
(45,'English-II (Public Speaking)	','E2',3,''),
(46,'Digital Logic & Design	','DLD',3,''),
(47,'Digital Logic & Design	 Lab','DLD Lab',1,''),
(48,'Data Structures & Algorithms	','DSA',3,''),
(49,'Data Structures & Algorithms	 Lab','DSA Lab',1,''),
(50,'Discrete Mathematics	','DM',3,''),
(51,'English-III (Official Communication)	','E3',3,''),
(52,'Differential Equations & Multivariable Calculus	','DE&MC',3,''),
(53,'Operating Systems	','OS',3,''),
(54,'Operating Systems	 Lab','OS Lab',1,''),
(55,'Computer Organization & Assembly Language	','COAL',3,''),
(56,'Computer Organization & Assembly Language	 Lab','COAL Lab',1,''),
(57,'Database Management Systems	','DBMS',3,''),
(58,'Database Management Systems	 Lab','DBMS Lab',1,''),
(59,'Numerical Computing	','NC',3,''),
(60,'Numerical Computing	 Lab','NC Lab',1,''),
(61,'Data Communication and Networks	','DCN',3,''),
(62,'Data Communication and Networks	 Lab','DCN Lab',1,''),
(63,'Computer Architecture	','CA',3,''),
(64,'Computer Architecture	 Lab','CA Lab',1,''),
(65,'Technology Entrepreneurship	','TE',3,''),
(66,'Internet & Intranet Architecture	','IIA',3,''),
(67,'Internet & Intranet Architecture	 Lab','IIA Lab',1,''),
(68,'Probability & Statistics	','P&S',3,''),
(69,'Network Programming	','NP',3,''),
(70,'Object Oriented Analysis & Design	','OOAD',3,''),
(71,'Automata Theory	','ToA',3,''),
(72,'Design & Patterns	','DP',3,''),
(73,'Human Computer Interaction	','HCI',3,''),
(74,'Artificial Intelligence	','AI',3,''),
(75,'Artificial Intelligence	 Lab','AI Lab',1,''),
(76,'Software Engineering	','SE',3,''),
(77,'Compiler Construction	','CC',3,''),
(78,'Design & Analysis of Algorithm	','DAA',3,''),
(79,'Cryptography','Crypto',3,''),
(81,'Elective I','Elective 1',3,''),
(82,'Elective II','Elective 2',3,''),
(83,'Final Year Project I','FYP 1',3,''),
(84,'Final Year Project II','FYP 2',3,'');

/*Table structure for table `Tbl_Days` */

DROP TABLE IF EXISTS `Tbl_Days`;

CREATE TABLE `Tbl_Days` (
  `Day_Id` int NOT NULL AUTO_INCREMENT,
  `DayName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Day_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Days` */

insert  into `Tbl_Days`(`Day_Id`,`DayName`) values 
(1,'Monday'),
(2,'Tuesday'),
(3,'Wednesday'),
(4,'Thursday'),
(5,'Friday'),
(6,'Saturday'),
(7,'Sunday');

/*Table structure for table `Tbl_Faculty` */

DROP TABLE IF EXISTS `Tbl_Faculty`;

CREATE TABLE `Tbl_Faculty` (
  `FacultyId` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  PRIMARY KEY (`FacultyId`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `Tbl_Faculty_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Tbl_User` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Faculty` */

insert  into `Tbl_Faculty`(`FacultyId`,`UserID`) values 
(1,69),
(2,72),
(3,74),
(4,77),
(5,85),
(6,91),
(7,101),
(8,124);

/*Table structure for table `Tbl_FacultyCourseRegistration` */

DROP TABLE IF EXISTS `Tbl_FacultyCourseRegistration`;

CREATE TABLE `Tbl_FacultyCourseRegistration` (
  `FCR_ID` int NOT NULL AUTO_INCREMENT,
  `UserId` int DEFAULT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Class_ID` int DEFAULT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  PRIMARY KEY (`FCR_ID`),
  KEY `UserId` (`UserId`),
  KEY `Class_ID` (`Class_ID`),
  CONSTRAINT `Tbl_FacultyCourseRegistration_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Tbl_User` (`UserID`),
  CONSTRAINT `Tbl_FacultyCourseRegistration_ibfk_2` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_FacultyCourseRegistration` */

insert  into `Tbl_FacultyCourseRegistration`(`FCR_ID`,`UserId`,`Username`,`Class_ID`,`IsActive`) values 
(5,74,'720660',51,''),
(7,101,'863281',54,''),
(8,101,'863281',59,''),
(9,77,'662661',48,''),
(10,77,'662661',53,''),
(11,74,'720660',55,''),
(12,74,'720660',56,''),
(16,69,'faculty',50,''),
(17,69,'faculty',46,''),
(18,69,'faculty',52,'');

/*Table structure for table `Tbl_Marks` */

DROP TABLE IF EXISTS `Tbl_Marks`;

CREATE TABLE `Tbl_Marks` (
  `Marks_Id` int NOT NULL AUTO_INCREMENT,
  `Class_Id` int DEFAULT NULL,
  `Assement_Name` varchar(50) DEFAULT NULL,
  `User_Id` int DEFAULT NULL,
  `UserName` varchar(50) DEFAULT NULL,
  `Total_Marks` int DEFAULT NULL,
  `Obtained_Makrs` int DEFAULT '0',
  PRIMARY KEY (`Marks_Id`),
  KEY `Class_Id` (`Class_Id`),
  KEY `User_Id` (`User_Id`),
  CONSTRAINT `Tbl_Marks_ibfk_1` FOREIGN KEY (`Class_Id`) REFERENCES `Tbl_Classes` (`Class_Id`),
  CONSTRAINT `Tbl_Marks_ibfk_2` FOREIGN KEY (`User_Id`) REFERENCES `Tbl_User` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Marks` */

insert  into `Tbl_Marks`(`Marks_Id`,`Class_Id`,`Assement_Name`,`User_Id`,`UserName`,`Total_Marks`,`Obtained_Makrs`) values 
(22,52,'Project 1',64,'student',20,15),
(23,52,'Project 1',70,'317056',20,18),
(25,46,'Assignment 1',64,'student',10,8),
(26,46,'Quiz 1',64,'student',30,25),
(27,46,'Assignment 2',64,'student',10,2),
(28,50,'Quiz 1',119,'518290',5,3),
(29,50,'Quiz 1',75,'44560',5,3),
(30,50,'Quiz 1',64,'student',5,2),
(31,50,'Quiz 1',70,'317056',5,2),
(32,50,'Quiz 1',78,'125961',5,1),
(33,50,'Quiz 1',120,'24691',5,3),
(34,50,'Quiz 1',121,'183492',5,3),
(35,50,'Quiz 1',122,'793093',5,3),
(36,50,'Assignment 2',119,'518290',30,12),
(37,50,'Assignment 2',75,'44560',30,12),
(38,50,'Assignment 2',64,'student',30,12),
(39,50,'Assignment 2',70,'317056',30,12),
(40,50,'Assignment 2',78,'125961',30,0),
(41,50,'Assignment 2',120,'24691',30,0),
(42,50,'Assignment 2',121,'183492',30,0),
(43,50,'Assignment 2',122,'793093',30,0),
(44,48,'Assignment 1',64,'student',10,7);

/*Table structure for table `Tbl_Menu` */

DROP TABLE IF EXISTS `Tbl_Menu`;

CREATE TABLE `Tbl_Menu` (
  `Menu_ID` int NOT NULL AUTO_INCREMENT,
  `Controller/Action` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`Menu_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Menu` */

insert  into `Tbl_Menu`(`Menu_ID`,`Controller/Action`) values 
(1,'NewUser'),
(2,'ViewUsers');

/*Table structure for table `Tbl_Profile` */

DROP TABLE IF EXISTS `Tbl_Profile`;

CREATE TABLE `Tbl_Profile` (
  `ProfileID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `FatherName` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `NIC` varchar(50) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `Picture` varchar(1000) DEFAULT NULL,
  `DoB` varchar(50) DEFAULT NULL,
  `Gender` varchar(50) DEFAULT NULL,
  `PhoneNumber` varchar(50) DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `Profile_Date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ProfileID`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Profile` */

insert  into `Tbl_Profile`(`ProfileID`,`Name`,`FatherName`,`Email`,`NIC`,`Address`,`City`,`Country`,`Picture`,`DoB`,`Gender`,`PhoneNumber`,`IsActive`,`Profile_Date`) values 
(55,'Mohsin',NULL,'masoodarif1313@gmail.com','1111111111111','6','Karachi','Pakistan','/Upload/1111111111111.jpg','01-01-2014','male','03172945903',1,'10/11/2021'),
(56,'Ahsan',NULL,'masoodarif1313@gmail.com','6666663232222','6','Karachi','Pakistan','/Upload/3245323432321.jpg','01-01-2014','male','03172945903',1,'12/11/2021'),
(59,'Mubashir',NULL,'masoodarif1313@gmail.com','3245323432321','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','female','03172945903',1,'12/11/2021'),
(60,'Altaf',NULL,'masoodarif1313@gmail.com','3454325243643','6','Karachi','Pakistan','/Upload/3454325243643.jpg','01-01-2014','female','03172945903',1,'12/11/2021'),
(61,'Hussain',NULL,'masoodarif1313@gmail.com','6266663232212','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'12/11/2021'),
(62,'Arif','Muhammad Arif','masoodarif1313@gmail.com','3245321433221','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'13/11/2021'),
(63,'Taimoor','Muhammad Arif','masoodarif1313@gmail.com','3243221433221','6','Karachi','Pakistan','/Upload/6266663232212.jpg','01-01-2014','male','03172945903',1,'13/11/2021'),
(64,'Mansoor','Muhammad Arif','masoodarif1313@gmail.com','3243221213221','6','Karachi','Pakistan','/Upload/6666663232222.jpg','01-01-2014','male','03172945903',1,'13/11/2021'),
(65,'Ali Hassan','Muhammad Arif','masoodarif1313@gmail.com','3243221113221','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'13/11/2021'),
(67,'Sumair',NULL,'masoodarif1313@gmail.com','1112345111111','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'13/11/2021'),
(68,'Munawar',NULL,'masoodarif1313@gmail.com','3242353422122','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'05/12/2021'),
(70,'Pervez',NULL,'masoodarif1313@gmail.com','1111111111323','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'05/12/2021'),
(80,'Asim','Muhammad Arif','masoodarif1313@gmail.com','2221111111111','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'06/12/2021'),
(81,'Iqbal','arif','masoodarif1313@gmail.com','1234567800000',NULL,NULL,NULL,'/Upload/1134531111111.jpg','12/15/2021','male','03172945903',1,'06/12/2021'),
(82,'Shakeel',NULL,'masoodarif1313@gmail.com','4441111111111','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'07/12/2021'),
(83,'Sherry',NULL,'masoodarif1313@gmail.com','1111333111111','6','Karachi','Pakistan','','01-01-2014','male','03172945903',1,'07/12/2021'),
(84,'Asif',NULL,'masoodarif1313@gmail.com','1123111111111','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'07/12/2021'),
(85,'Haris ',NULL,'masoodarif1313@gmail.com','1134511111111','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'07/12/2021'),
(86,'Ahmed',NULL,'masoodarif1313@gmail.com','1123465111111','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'07/12/2021'),
(87,'Osama',NULL,'masoodarif1313@gmail.com','1111124411111','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'07/12/2021'),
(88,'Rafay',NULL,'masoodarif1313@gmail.com','1134511134111','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'07/12/2021'),
(89,'Sufiyan',NULL,'masoodarif1313@gmail.com','1134531111111','6','Karachi','Pakistan','/Upload/1134531111111.jpg','01-01-2014','male','03172945903',1,'07/12/2021'),
(90,'Habib','Muhammad Arif','masoodarif1313@gmail.com','4130783592999','Shahlatif town','Karachi','Pakistan','/Upload/4130783592999.jpg','12/07/2021','male','03172945903',1,'26/12/2021'),
(91,'James','Butt','jbutt@gmail.com','1234567890111','6649 N Blue Gum St','New Orleans','Orleans','/Upload/1234567890111.jpg','01/11/2022','male','50426218927',1,'02/01/2022'),
(92,'Paprocki','Lenna','art@venere.org','7011645148116','6649 N Blue Gum St','New Orleans','Orleans','/Upload/7011645148116.jpg','01/11/2022','male','50426218927',1,'02/01/2022'),
(93,'Paprocki','Lenna','art@venere.org','7012345148116','6649 N Blue Gum St','New Orleans','Orleans','/Upload/7012345148116.jpg','01/11/2022','female','50426218927',1,'02/01/2022');

/*Table structure for table `Tbl_ProgramSyllabus` */

DROP TABLE IF EXISTS `Tbl_ProgramSyllabus`;

CREATE TABLE `Tbl_ProgramSyllabus` (
  `Syllabus_Id` int NOT NULL AUTO_INCREMENT,
  `Program_Id` int DEFAULT NULL,
  `Course_Id` int DEFAULT NULL,
  `RqdCourse_Id` int DEFAULT '0',
  `Required_CrHr` int DEFAULT '0',
  PRIMARY KEY (`Syllabus_Id`),
  KEY `Tbl_ProgramSyllabus_ibfk_1` (`Program_Id`),
  KEY `Tbl_ProgramSyllabus_ibfk_2` (`Course_Id`),
  KEY `Tbl_ProgramSyllabus_ibfk_3` (`RqdCourse_Id`),
  CONSTRAINT `Tbl_ProgramSyllabus_ibfk_1` FOREIGN KEY (`Program_Id`) REFERENCES `Tbl_Programs` (`ProgramID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Tbl_ProgramSyllabus_ibfk_2` FOREIGN KEY (`Course_Id`) REFERENCES `Tbl_Courses` (`CourseID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Tbl_ProgramSyllabus_ibfk_3` FOREIGN KEY (`RqdCourse_Id`) REFERENCES `Tbl_Courses` (`CourseID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_ProgramSyllabus` */

insert  into `Tbl_ProgramSyllabus`(`Syllabus_Id`,`Program_Id`,`Course_Id`,`RqdCourse_Id`,`Required_CrHr`) values 
(20,1,30,0,0),
(21,1,31,0,0),
(22,1,32,0,0),
(23,1,33,0,8),
(24,1,34,0,0),
(25,1,35,0,0),
(26,1,36,0,0),
(27,1,37,0,0),
(28,1,38,0,0),
(29,1,39,30,0),
(30,1,40,0,0),
(31,1,41,32,0),
(32,1,42,33,0),
(33,1,43,0,0),
(34,1,44,36,0),
(35,1,45,37,0),
(36,1,46,41,0),
(37,1,47,42,0),
(38,1,48,39,0),
(39,1,49,40,0),
(40,1,50,36,0),
(41,1,51,45,0),
(42,1,52,44,0),
(43,1,53,32,0),
(44,1,54,33,0),
(45,1,55,30,0),
(46,1,55,46,0),
(47,1,56,31,0),
(48,1,56,47,0),
(49,1,57,48,0),
(50,1,58,49,0),
(51,1,59,44,0),
(52,1,60,44,0),
(53,1,61,32,0),
(54,1,62,33,0),
(55,1,63,55,0),
(56,1,64,56,0),
(57,1,65,43,0),
(58,1,65,38,0),
(59,1,66,61,0),
(60,1,67,62,0),
(61,1,68,36,0),
(62,1,69,39,0),
(63,1,69,53,0),
(64,1,69,55,0),
(65,1,70,39,0),
(66,1,70,40,0),
(67,1,71,50,0),
(68,1,72,70,0),
(69,1,73,48,0),
(70,1,73,49,0),
(71,1,74,50,0),
(72,1,75,50,0),
(73,1,76,70,0),
(74,1,77,71,0),
(75,1,78,50,0),
(76,1,78,48,0),
(77,1,79,61,0),
(78,1,79,66,0),
(79,1,81,0,0),
(80,1,82,0,0),
(81,1,83,70,0),
(82,1,83,73,0),
(83,1,83,74,0),
(84,1,84,83,0),
(103,6,30,44,23),
(104,6,47,40,12);

/*Table structure for table `Tbl_Programs` */

DROP TABLE IF EXISTS `Tbl_Programs`;

CREATE TABLE `Tbl_Programs` (
  `ProgramID` int NOT NULL AUTO_INCREMENT,
  `ProgramFullName` varchar(50) NOT NULL,
  `ProgramShortName` varchar(50) DEFAULT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ProgramID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Programs` */

insert  into `Tbl_Programs`(`ProgramID`,`ProgramFullName`,`ProgramShortName`,`IsActive`) values 
(1,'bachelor\'s in computer science','BSCS',''),
(6,'Master\'s in Computer science','MCS','');

/*Table structure for table `Tbl_RoleMenu` */

DROP TABLE IF EXISTS `Tbl_RoleMenu`;

CREATE TABLE `Tbl_RoleMenu` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Menu_ID` int DEFAULT NULL,
  `Role_ID` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Menu_ID` (`Menu_ID`),
  KEY `Role_ID` (`Role_ID`),
  CONSTRAINT `Tbl_RoleMenu_ibfk_1` FOREIGN KEY (`Menu_ID`) REFERENCES `Tbl_Menu` (`Menu_ID`),
  CONSTRAINT `Tbl_RoleMenu_ibfk_2` FOREIGN KEY (`Role_ID`) REFERENCES `Tbl_Roles` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_RoleMenu` */

/*Table structure for table `Tbl_Roles` */

DROP TABLE IF EXISTS `Tbl_Roles`;

CREATE TABLE `Tbl_Roles` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(50) NOT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Roles` */

insert  into `Tbl_Roles`(`RoleID`,`RoleName`) values 
(1,'Admin'),
(2,'Faculty'),
(3,'Student');

/*Table structure for table `Tbl_Semester` */

DROP TABLE IF EXISTS `Tbl_Semester`;

CREATE TABLE `Tbl_Semester` (
  `Semester_Id` int NOT NULL AUTO_INCREMENT,
  `SemesterName` varchar(50) DEFAULT NULL,
  `StartDate` varchar(50) DEFAULT NULL,
  `EndDate` varchar(50) DEFAULT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Semester_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Semester` */

insert  into `Tbl_Semester`(`Semester_Id`,`SemesterName`,`StartDate`,`EndDate`,`IsActive`) values 
(35,'Fall 2021','04/11/2021','11/11/2021','\0'),
(36,'fall 2020','11/11/2021','11/11/2021','\0'),
(37,'Fall 2021','11/11/2021','11/11/2021','\0'),
(38,'Fall 2021','11/11/2021','11/11/2021','\0'),
(39,'Fall 2021','11/11/2021','11/11/2021','\0'),
(40,'Fall 2021','11/11/2021','11/11/2021','\0'),
(41,'Fall 2021','11/11/2021','11/11/2021','\0'),
(42,'Fall 2021','11/11/2021','11/11/2021','\0'),
(43,'Fall 2021','11/11/2021','11/11/2021','\0'),
(44,'Fall 2021','11/11/2021','11/11/2021','\0'),
(45,'Fall 2021','11/11/2021','11/11/2021','\0'),
(46,'Fall 20212','11/11/2021','11/11/2021','\0'),
(47,'Fall 20212','11/11/2021','13/11/2021','\0'),
(48,'Fall 2030','13/11/2021','13/11/2021','\0'),
(49,'Fall 20212','13/11/2021','16/11/2021','\0'),
(50,'fall21','16/11/2021','02/12/2021','\0'),
(51,'Fall2023','02/12/2021','02/12/2021','\0'),
(52,'Fall 2023','02/12/2021','25/12/2021',''),
(59,'fall 2020','24/12/2021',NULL,'\0'),
(60,'fall 2020','25/12/2021',NULL,'\0'),
(61,'fall 2020','25/12/2021',NULL,'\0');

/*Table structure for table `Tbl_Student` */

DROP TABLE IF EXISTS `Tbl_Student`;

CREATE TABLE `Tbl_Student` (
  `Student_Id` int NOT NULL AUTO_INCREMENT,
  `ProgramID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Student_Id`),
  KEY `ProgramID` (`ProgramID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `Tbl_Student_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Tbl_User` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Tbl_Student_ibfk_2` FOREIGN KEY (`ProgramID`) REFERENCES `Tbl_Programs` (`ProgramID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Student` */

insert  into `Tbl_Student`(`Student_Id`,`ProgramID`,`UserID`,`IsActive`) values 
(15,1,64,NULL),
(16,1,70,NULL),
(17,1,75,NULL),
(18,1,78,NULL),
(19,1,119,NULL),
(20,1,120,NULL),
(21,1,121,NULL),
(22,1,122,NULL);

/*Table structure for table `Tbl_StudentCourseRegistration` */

DROP TABLE IF EXISTS `Tbl_StudentCourseRegistration`;

CREATE TABLE `Tbl_StudentCourseRegistration` (
  `SCR_Id` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) DEFAULT NULL,
  `User_ID` int NOT NULL,
  `Class_ID` int NOT NULL,
  `IsActive` bit(1) NOT NULL,
  PRIMARY KEY (`SCR_Id`),
  KEY `User_ID` (`User_ID`),
  KEY `Class_ID` (`Class_ID`),
  CONSTRAINT `Tbl_StudentCourseRegistration_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `Tbl_User` (`UserID`),
  CONSTRAINT `Tbl_StudentCourseRegistration_ibfk_3` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_StudentCourseRegistration` */

insert  into `Tbl_StudentCourseRegistration`(`SCR_Id`,`Username`,`User_ID`,`Class_ID`,`IsActive`) values 
(15,'student',64,52,''),
(16,'317056',70,57,''),
(18,'317056',70,52,''),
(23,'518290',119,50,''),
(24,'518290',119,59,''),
(26,'44560',75,50,''),
(29,'student',64,46,''),
(30,'student',64,50,''),
(31,'317056',70,50,''),
(32,'125961',78,50,''),
(33,'24691',120,50,''),
(34,'183492',121,50,''),
(35,'793093',122,50,''),
(37,'125961',78,51,''),
(38,'student',64,48,'');

/*Table structure for table `Tbl_Time` */

DROP TABLE IF EXISTS `Tbl_Time`;

CREATE TABLE `Tbl_Time` (
  `Time_Id` int NOT NULL AUTO_INCREMENT,
  `TimeName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Time_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Time` */

insert  into `Tbl_Time`(`Time_Id`,`TimeName`) values 
(1,'9:00-12:00 (morning)'),
(2,'1:00-3:00 (noon)'),
(3,'6:00-9:00 (evening)');

/*Table structure for table `Tbl_User` */

DROP TABLE IF EXISTS `Tbl_User`;

CREATE TABLE `Tbl_User` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `RoleID` int NOT NULL,
  `ProfileID` int NOT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  `User_Date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  KEY `ProfileID` (`ProfileID`),
  KEY `RoleID` (`RoleID`),
  CONSTRAINT `Tbl_User_ibfk_1` FOREIGN KEY (`ProfileID`) REFERENCES `Tbl_Profile` (`ProfileID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Tbl_User_ibfk_2` FOREIGN KEY (`RoleID`) REFERENCES `Tbl_Roles` (`RoleID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_User` */

insert  into `Tbl_User`(`UserID`,`UserName`,`Password`,`RoleID`,`ProfileID`,`IsActive`,`User_Date`) values 
(64,'student','1050',3,55,'','10/11/2021'),
(65,'admin','1050',1,56,'','12/11/2021'),
(69,'faculty','1050',2,56,'','12/11/2021'),
(70,'317056','1048470',3,56,'','12/11/2021'),
(72,'495159','10140159',2,59,'','12/11/2021'),
(73,'16060','11457560',1,60,'\0','12/11/2021'),
(74,'720660','1638620',2,60,'','12/11/2021'),
(75,'44560','1275480',3,60,'','12/11/2021'),
(76,'826361','15878961',1,61,'','12/11/2021'),
(77,'662661','971650',2,61,'','12/11/2021'),
(78,'125961','1410480',3,61,'','12/11/2021'),
(85,'214955','1592540',2,55,'','13/11/2021'),
(91,'668667','15877567',2,67,'','13/11/2021'),
(101,'863281','9826181',2,81,'','06/12/2021'),
(119,'518290','11087590',3,90,'','26/12/2021'),
(120,'24691','9478291',3,91,'','02/01/2022'),
(121,'183492','17111492',3,92,'','02/01/2022'),
(122,'793093','12878193',3,93,'','02/01/2022'),
(124,'238790','1210020',2,90,'','04/01/2022');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
