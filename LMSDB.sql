/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 8.0.28-0ubuntu0.20.04.3 : Database - LMS
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

/*Table structure for table `Tbl_AssesmentSubmission` */

DROP TABLE IF EXISTS `Tbl_AssesmentSubmission`;

CREATE TABLE `Tbl_AssesmentSubmission` (
  `SubmissionId` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `AssesmentID` int DEFAULT NULL,
  `FilePath` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `DisplayName` varchar(300) DEFAULT NULL,
  `SubmissionTime` datetime DEFAULT NULL,
  `LateSubmit` bit(1) DEFAULT NULL,
  PRIMARY KEY (`SubmissionId`),
  KEY `UserID` (`UserID`),
  KEY `AssesmentID` (`AssesmentID`),
  CONSTRAINT `Tbl_AssesmentSubmission_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_AssesmentSubmission_ibfk_2` FOREIGN KEY (`AssesmentID`) REFERENCES `Tbl_Assesments` (`AssesmentId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_AssesmentSubmission` */

insert  into `Tbl_AssesmentSubmission`(`SubmissionId`,`UserID`,`AssesmentID`,`FilePath`,`DisplayName`,`SubmissionTime`,`LateSubmit`) values 
(3,64,36,'/Upload/student-Mohsin-Assignment 1-79.pdf','student-Mohsin-Assignment 1-79','2022-02-04 00:25:25',''),
(4,151,36,'/Upload/Std22107-Masood Arif-Assignment 1-79.pdf','Std22107-Masood Arif-Assignment 1-79','2022-02-04 00:52:33',''),
(5,119,36,'/Upload/518290-Habib-Assignment 1-79.pdf','518290-Habib-Assignment 1-79','2022-02-04 01:37:46','');

/*Table structure for table `Tbl_Assesments` */

DROP TABLE IF EXISTS `Tbl_Assesments`;

CREATE TABLE `Tbl_Assesments` (
  `AssesmentId` int NOT NULL AUTO_INCREMENT,
  `Class_ID` int DEFAULT NULL,
  `Session_ID` int DEFAULT NULL,
  `AssesmentName` varchar(500) DEFAULT NULL,
  `Description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `Start` datetime DEFAULT NULL,
  `End` datetime DEFAULT NULL,
  `LateSubmission` bit(1) DEFAULT NULL,
  PRIMARY KEY (`AssesmentId`),
  KEY `Class_ID` (`Class_ID`),
  KEY `Session_ID` (`Session_ID`),
  CONSTRAINT `Tbl_Assesments_ibfk_1` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`),
  CONSTRAINT `Tbl_Assesments_ibfk_2` FOREIGN KEY (`Session_ID`) REFERENCES `Tbl_ClassSessions` (`Session_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Assesments` */

insert  into `Tbl_Assesments`(`AssesmentId`,`Class_ID`,`Session_ID`,`AssesmentName`,`Description`,`Start`,`End`,`LateSubmission`) values 
(36,79,195,'Assignment 1',NULL,'2022-02-03 20:24:00','2022-02-03 20:24:00','');

/*Table structure for table `Tbl_AssesmetnAttachments` */

DROP TABLE IF EXISTS `Tbl_AssesmetnAttachments`;

CREATE TABLE `Tbl_AssesmetnAttachments` (
  `File_ID` int NOT NULL AUTO_INCREMENT,
  `AssesmentId` int DEFAULT NULL,
  `DisplayName` varchar(400) DEFAULT NULL,
  `Path` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`File_ID`),
  KEY `Tbl_AssesmetnAttachments_ibfk_1` (`AssesmentId`),
  CONSTRAINT `Tbl_AssesmetnAttachments_ibfk_1` FOREIGN KEY (`AssesmentId`) REFERENCES `Tbl_Assesments` (`AssesmentId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_AssesmetnAttachments` */

insert  into `Tbl_AssesmetnAttachments`(`File_ID`,`AssesmentId`,`DisplayName`,`Path`) values 
(85,36,'Fee Bill.pdf','/Upload/Fee Bill.pdf'),
(86,36,'delta-fact-339916-a210693749f2.json','/Upload/delta-fact-339916-a210693749f2.json');

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
  KEY `Tbl_Attendence_ibfk_1` (`User_ID`),
  KEY `Tbl_Attendence_ibfk_2` (`Session_ID`),
  KEY `Tbl_Attendence_ibfk_3` (`Class_ID`),
  CONSTRAINT `Tbl_Attendence_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Attendence_ibfk_2` FOREIGN KEY (`Session_ID`) REFERENCES `Tbl_ClassSessions` (`Session_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Attendence_ibfk_3` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Attendence` */

insert  into `Tbl_Attendence`(`Id`,`Class_ID`,`Session_ID`,`User_ID`,`User_Name`,`1st`,`2nd`) values 
(141,50,176,119,'518290','',''),
(142,50,176,75,'44560','',''),
(143,50,176,64,'student','',''),
(146,50,176,120,'24691','\0','\0'),
(147,50,176,121,'183492','\0','\0'),
(148,50,176,122,'793093','\0','\0'),
(157,50,180,119,'518290','\0','\0'),
(158,50,180,75,'44560','\0','\0'),
(159,50,180,64,'student','','\0'),
(162,50,180,120,'24691','\0',''),
(163,50,180,121,'183492','\0','\0'),
(164,50,180,122,'793093','\0','\0'),
(165,50,178,119,'518290','\0',''),
(166,50,178,75,'44560','\0','\0'),
(167,50,178,64,'student','\0',''),
(170,50,178,120,'24691','\0',''),
(171,50,178,121,'183492','\0',''),
(172,50,178,122,'793093','\0',''),
(173,50,175,119,'518290','',''),
(174,50,175,75,'44560','',''),
(175,50,175,64,'student','',''),
(178,50,175,120,'24691','\0','\0'),
(179,50,175,121,'183492','\0','\0'),
(180,50,175,122,'793093','\0','\0'),
(181,46,175,64,'student','',''),
(182,48,175,64,'student','',''),
(183,48,176,64,'student','','\0'),
(184,50,177,119,'518290','','\0'),
(185,50,177,75,'44560','',''),
(186,50,177,64,'student','\0','\0'),
(189,50,177,120,'24691','',''),
(190,50,177,121,'183492','','\0'),
(191,50,177,122,'793093','','\0'),
(192,50,179,119,'518290','\0','\0'),
(193,50,179,75,'44560','\0',''),
(194,50,179,64,'student','\0','\0'),
(197,50,179,120,'24691','\0',''),
(198,50,179,121,'183492','\0','\0'),
(199,50,179,122,'793093','\0','\0');

/*Table structure for table `Tbl_ClassContent` */

DROP TABLE IF EXISTS `Tbl_ClassContent`;

CREATE TABLE `Tbl_ClassContent` (
  `Content_ID` int NOT NULL AUTO_INCREMENT,
  `Class_ID` int DEFAULT NULL,
  `Session_ID` int DEFAULT NULL,
  `ContentName` varchar(100) DEFAULT NULL,
  `ContentLink` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Content_ID`),
  KEY `Tbl_ClassContent_ibfk_1` (`Class_ID`),
  KEY `Tbl_ClassContent_ibfk_2` (`Session_ID`),
  CONSTRAINT `Tbl_ClassContent_ibfk_1` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_ClassContent_ibfk_2` FOREIGN KEY (`Session_ID`) REFERENCES `Tbl_ClassSessions` (`Session_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_ClassContent` */

/*Table structure for table `Tbl_ClassSessions` */

DROP TABLE IF EXISTS `Tbl_ClassSessions`;

CREATE TABLE `Tbl_ClassSessions` (
  `Session_ID` int NOT NULL AUTO_INCREMENT,
  `Semester_ID` int DEFAULT NULL,
  `SessionName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Session_ID`),
  KEY `Tbl_ClassSessions_ibfk_1` (`Semester_ID`),
  CONSTRAINT `Tbl_ClassSessions_ibfk_1` FOREIGN KEY (`Semester_ID`) REFERENCES `Tbl_Semester` (`Semester_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_ClassSessions` */

insert  into `Tbl_ClassSessions`(`Session_ID`,`Semester_ID`,`SessionName`) values 
(175,52,'11 October - 17 October'),
(176,52,'18 October - 24 October'),
(177,52,'25 October - 31 October'),
(178,52,'1 November - 7 November'),
(179,52,'8 November - 14 November'),
(180,52,'15 November - 21 November'),
(190,71,'Jan '),
(191,71,'Feb'),
(192,71,'March'),
(193,71,'April '),
(194,71,'May '),
(195,72,'27 September - 3 October'),
(196,72,'4 October - 10 October'),
(197,72,'11 October - 17 October'),
(198,72,'18 October - 24 October'),
(199,72,'25 October - 31 October'),
(200,72,'1 November - 7 November'),
(201,72,'8 November - 14 November'),
(202,72,'15 November - 21 November'),
(203,72,'22 November - 28 November'),
(204,72,'6 December - 12 December');

/*Table structure for table `Tbl_Classes` */

DROP TABLE IF EXISTS `Tbl_Classes`;

CREATE TABLE `Tbl_Classes` (
  `Class_Id` int NOT NULL AUTO_INCREMENT,
  `ClassStrength` int DEFAULT NULL,
  `Enrolled_Std` int DEFAULT '0',
  `Course_Id` int DEFAULT NULL,
  `Semester_Id` int DEFAULT NULL,
  `Program_Id` int DEFAULT NULL,
  `Day_Id` int DEFAULT NULL,
  `Time_Id` int DEFAULT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  `Class_Image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Class_Id`),
  KEY `Tbl_Classes_ibfk_1` (`Semester_Id`),
  KEY `Tbl_Classes_ibfk_4` (`Course_Id`),
  KEY `Tbl_Classes_ibfk_5` (`Program_Id`),
  KEY `Tbl_Classes_ibfk_6` (`Day_Id`),
  KEY `Tbl_Classes_ibfk_7` (`Time_Id`),
  CONSTRAINT `Tbl_Classes_ibfk_1` FOREIGN KEY (`Semester_Id`) REFERENCES `Tbl_Semester` (`Semester_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Classes_ibfk_4` FOREIGN KEY (`Course_Id`) REFERENCES `Tbl_Courses` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Classes_ibfk_5` FOREIGN KEY (`Program_Id`) REFERENCES `Tbl_Programs` (`ProgramID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Classes_ibfk_6` FOREIGN KEY (`Day_Id`) REFERENCES `Tbl_Days` (`Day_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Classes_ibfk_7` FOREIGN KEY (`Time_Id`) REFERENCES `Tbl_Time` (`Time_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Classes` */

insert  into `Tbl_Classes`(`Class_Id`,`ClassStrength`,`Enrolled_Std`,`Course_Id`,`Semester_Id`,`Program_Id`,`Day_Id`,`Time_Id`,`IsActive`,`Class_Image`) values 
(46,3,2,31,52,1,2,1,'\0',NULL),
(48,12,1,32,52,1,3,2,'\0',NULL),
(50,12,6,37,52,1,6,2,'\0','/Upload/1134531111111.jpg'),
(51,34,0,49,52,1,6,1,'\0',NULL),
(52,34,1,30,52,1,6,3,'\0',NULL),
(57,23,1,31,52,1,6,1,'\0',NULL),
(59,12,1,39,52,1,2,1,'\0',NULL),
(75,23,1,51,52,1,1,1,'\0',NULL),
(76,12,0,51,52,1,2,2,'\0',NULL),
(77,23,0,37,52,1,6,1,'\0',NULL),
(78,14,6,44,72,1,1,1,'',NULL),
(79,12,5,42,72,1,3,1,'',NULL),
(80,12,4,47,72,6,2,2,'',NULL);

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
  CONSTRAINT `Tbl_CourseEligiblity_ibfk_1` FOREIGN KEY (`Class_Id`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_CourseEligiblity_ibfk_2` FOREIGN KEY (`Program_Id`) REFERENCES `Tbl_Programs` (`ProgramID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_CourseEligiblity_ibfk_3` FOREIGN KEY (`RqdCourse_Id`) REFERENCES `Tbl_Courses` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE
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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Courses` */

insert  into `Tbl_Courses`(`CourseID`,`FullName`,`ShortName`,`CrHr`,`IsActive`) values 
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

/*Table structure for table `Tbl_EmailConfiguration` */

DROP TABLE IF EXISTS `Tbl_EmailConfiguration`;

CREATE TABLE `Tbl_EmailConfiguration` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `From` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `Host` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `Port` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_EmailConfiguration` */

/*Table structure for table `Tbl_FacultyCourseRegistration` */

DROP TABLE IF EXISTS `Tbl_FacultyCourseRegistration`;

CREATE TABLE `Tbl_FacultyCourseRegistration` (
  `FCR_ID` int NOT NULL AUTO_INCREMENT,
  `UserId` int DEFAULT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Class_ID` int DEFAULT NULL,
  `SemesterId` int DEFAULT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  PRIMARY KEY (`FCR_ID`),
  KEY `Tbl_FacultyCourseRegistration_ibfk_1` (`UserId`),
  KEY `Tbl_FacultyCourseRegistration_ibfk_2` (`Class_ID`),
  KEY `SemesterId` (`SemesterId`),
  CONSTRAINT `Tbl_FacultyCourseRegistration_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_FacultyCourseRegistration_ibfk_2` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_FacultyCourseRegistration_ibfk_3` FOREIGN KEY (`SemesterId`) REFERENCES `Tbl_Semester` (`Semester_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_FacultyCourseRegistration` */

insert  into `Tbl_FacultyCourseRegistration`(`FCR_ID`,`UserId`,`Username`,`Class_ID`,`SemesterId`,`IsActive`) values 
(8,101,'863281',59,52,'\0'),
(16,69,'faculty',50,52,'\0'),
(17,69,'faculty',46,52,'\0'),
(18,69,'faculty',52,52,'\0'),
(22,101,'863281',77,52,'\0'),
(23,72,'495159',51,52,'\0'),
(24,147,'Emp36104',78,NULL,''),
(26,101,'863281',80,NULL,''),
(27,69,'faculty',79,NULL,'');

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
  KEY `Tbl_Marks_ibfk_1` (`Class_Id`),
  KEY `Tbl_Marks_ibfk_2` (`User_Id`),
  CONSTRAINT `Tbl_Marks_ibfk_1` FOREIGN KEY (`Class_Id`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Marks_ibfk_2` FOREIGN KEY (`User_Id`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Marks` */

insert  into `Tbl_Marks`(`Marks_Id`,`Class_Id`,`Assement_Name`,`User_Id`,`UserName`,`Total_Marks`,`Obtained_Makrs`) values 
(22,52,'Project 1',64,'student',20,15),
(25,46,'Assignment 1',64,'student',10,8),
(26,46,'Quiz 1',64,'student',30,25),
(27,46,'Assignment 2',64,'student',10,2),
(28,50,'Quiz 1',119,'518290',5,3),
(29,50,'Quiz 1',75,'44560',5,3),
(30,50,'Quiz 1',64,'student',5,2),
(33,50,'Quiz 1',120,'24691',5,3),
(34,50,'Quiz 1',121,'183492',5,3),
(35,50,'Quiz 1',122,'793093',5,3),
(36,50,'Assignment 2',119,'518290',30,12),
(37,50,'Assignment 2',75,'44560',30,12),
(38,50,'Assignment 2',64,'student',30,12),
(41,50,'Assignment 2',120,'24691',30,0),
(42,50,'Assignment 2',121,'183492',30,0),
(43,50,'Assignment 2',122,'793093',30,0),
(44,48,'Assignment 1',64,'student',10,7),
(45,50,'Project',119,'518290',200,1),
(46,50,'Project',75,'44560',200,1),
(47,50,'Project',64,'student',200,23),
(48,50,'Project',120,'24691',200,23),
(49,50,'Project',121,'183492',200,32),
(50,50,'Project',122,'793093',200,45);

/*Table structure for table `Tbl_Menu` */

DROP TABLE IF EXISTS `Tbl_Menu`;

CREATE TABLE `Tbl_Menu` (
  `Menu_ID` int NOT NULL AUTO_INCREMENT,
  `Controller` varchar(50) DEFAULT NULL,
  `Action` varchar(50) DEFAULT NULL,
  `DisplayLink` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `DisplayName` varchar(50) DEFAULT NULL,
  `Parent` int DEFAULT NULL,
  `Icon` text,
  PRIMARY KEY (`Menu_ID`),
  KEY `Parent` (`Parent`),
  CONSTRAINT `Tbl_Menu_ibfk_1` FOREIGN KEY (`Parent`) REFERENCES `Tbl_ParentMenu` (`ParentID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Menu` */

insert  into `Tbl_Menu`(`Menu_ID`,`Controller`,`Action`,`DisplayLink`,`DisplayName`,`Parent`,`Icon`) values 
(1,'AdminCourses','AddNewCourse','AddNewCourse','Add new Course',2,NULL),
(2,'Attendence','MarkAttedence','MarkAttendence','Mark Attendence',6,NULL),
(3,'Attendence','AttendenceReport','AttendenceReport','Attendence Report',6,NULL),
(4,'Classes','AssignNewClass','AssignClasses','Assign new class',2,NULL),
(5,'Classes','ViewClass',NULL,NULL,NULL,NULL),
(6,'Classes','ViewClasses','ViewAllClasses','All Classes',2,NULL),
(7,'Classes','ClassInformation',NULL,NULL,NULL,NULL),
(8,'Home','Index','Home','Dashboard',NULL,'<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\" />\r\n                                <path\r\n                                    d=\"M3.95709826,8.41510662 L11.47855,3.81866389 C11.7986624,3.62303967 12.2013376,3.62303967 12.52145,3.81866389 L20.0429,8.41510557 C20.6374094,8.77841684 21,9.42493654 21,10.1216692 L21,19.0000642 C21,20.1046337 20.1045695,21.0000642 19,21.0000642 L4.99998155,21.0000673 C3.89541205,21.0000673 2.99998155,20.1046368 2.99998155,19.0000673 L2.99999828,10.1216672 C2.99999935,9.42493561 3.36258984,8.77841732 3.95709826,8.41510662 Z M10,13 C9.44771525,13 9,13.4477153 9,14 L9,17 C9,17.5522847 9.44771525,18 10,18 L14,18 C14.5522847,18 15,17.5522847 15,17 L15,14 C15,13.4477153 14.5522847,13 14,13 L10,13 Z\"\r\n                                    fill=\"#000000\" />\r\n                            </g>\r\n                        </svg>'),
(9,'Marks','StudentTestResults','ViewResults','Test Results',5,NULL),
(10,'Marks','UploadTestResults','UploadResults','Upload Results',5,NULL),
(11,'Programs','AddNewProgram','AddNewProgram','Add new Program',3,NULL),
(12,'ProgramSyllabus','AddNewSyllabus','NewSyllabus','Programs Syllabus',3,NULL),
(13,'RegisterCourses','EnrollStdents','EnrollStdents','Enroll Students',4,NULL),
(14,'RegisterCourses','EnrollFaculty','EnrollFaculty','Enroll Faculty',4,NULL),
(15,'Semester','Index','Semester','Semester',NULL,'<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"4\" y=\"4\" width=\"16\" height=\"16\" rx=\"2\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"9\" y=\"9\" width=\"6\" height=\"6\" />\r\n                                <path\r\n                                    d=\"M20,7 L21,7 C21.5522847,7 22,7.44771525 22,8 L22,8 C22,8.55228475 21.5522847,9 21,9 L20,9 L20,7 Z\"\r\n                                    fill=\"#000000\" />\r\n                                <path\r\n                                    d=\"M20,11 L21,11 C21.5522847,11 22,11.4477153 22,12 L22,12 C22,12.5522847 21.5522847,13 21,13 L20,13 L20,11 Z\"\r\n                                    fill=\"#000000\" />\r\n                                <path\r\n                                    d=\"M20,15 L21,15 C21.5522847,15 22,15.4477153 22,16 L22,16 C22,16.5522847 21.5522847,17 21,17 L20,17 L20,15 Z\"\r\n                                    fill=\"#000000\" />\r\n                                <path\r\n                                    d=\"M3,7 L4,7 L4,9 L3,9 C2.44771525,9 2,8.55228475 2,8 L2,8 C2,7.44771525 2.44771525,7 3,7 Z\"\r\n                                    fill=\"#000000\" />\r\n                                <path\r\n                                    d=\"M3,11 L4,11 L4,13 L3,13 C2.44771525,13 2,12.5522847 2,12 L2,12 C2,11.4477153 2.44771525,11 3,11 Z\"\r\n                                    fill=\"#000000\" />\r\n                                <path\r\n                                    d=\"M3,15 L4,15 L4,17 L3,17 C2.44771525,17 2,16.5522847 2,16 L2,16 C2,15.4477153 2.44771525,15 3,15 Z\"\r\n                                    fill=\"#000000\" />\r\n                            </g>\r\n                        </svg>'),
(16,'User','AddNewUser','NewUser','Add new user',1,NULL),
(17,'User','ViewUsers','ViewUsers','View all users',1,NULL),
(18,'User','ViewProfile',NULL,NULL,NULL,NULL),
(19,'User','Calender','Calender','Calender',NULL,'<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <polygon points=\"0 0 24 0 24 24 0 24\" />\r\n                                <path\r\n                                    d=\"M18.5,8 C17.1192881,8 16,6.88071187 16,5.5 C16,4.11928813 17.1192881,3 18.5,3 C19.8807119,3 21,4.11928813 21,5.5 C21,6.88071187 19.8807119,8 18.5,8 Z M18.5,21 C17.1192881,21 16,19.8807119 16,18.5 C16,17.1192881 17.1192881,16 18.5,16 C19.8807119,16 21,17.1192881 21,18.5 C21,19.8807119 19.8807119,21 18.5,21 Z M5.5,21 C4.11928813,21 3,19.8807119 3,18.5 C3,17.1192881 4.11928813,16 5.5,16 C6.88071187,16 8,17.1192881 8,18.5 C8,19.8807119 6.88071187,21 5.5,21 Z\"\r\n                                    fill=\"#000000\" opacity=\"0.3\" />\r\n                                <path\r\n                                    d=\"M5.5,8 C4.11928813,8 3,6.88071187 3,5.5 C3,4.11928813 4.11928813,3 5.5,3 C6.88071187,3 8,4.11928813 8,5.5 C8,6.88071187 6.88071187,8 5.5,8 Z M11,4 L13,4 C13.5522847,4 14,4.44771525 14,5 C14,5.55228475 13.5522847,6 13,6 L11,6 C10.4477153,6 10,5.55228475 10,5 C10,4.44771525 10.4477153,4 11,4 Z M11,18 L13,18 C13.5522847,18 14,18.4477153 14,19 C14,19.5522847 13.5522847,20 13,20 L11,20 C10.4477153,20 10,19.5522847 10,19 C10,18.4477153 10.4477153,18 11,18 Z M5,10 C5.55228475,10 6,10.4477153 6,11 L6,13 C6,13.5522847 5.55228475,14 5,14 C4.44771525,14 4,13.5522847 4,13 L4,11 C4,10.4477153 4.44771525,10 5,10 Z M19,10 C19.5522847,10 20,10.4477153 20,11 L20,13 C20,13.5522847 19.5522847,14 19,14 C18.4477153,14 18,13.5522847 18,13 L18,11 C18,10.4477153 18.4477153,10 19,10 Z\"\r\n                                    fill=\"#000000\" />\r\n                            </g>\r\n                        </svg>'),
(20,'Roles','AssignPermissions','Permissions','Roles Management',NULL,'<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\" />\r\n                                <path\r\n                                    d=\"M4,4 L11.6314229,2.5691082 C11.8750185,2.52343403 12.1249815,2.52343403 12.3685771,2.5691082 L20,4 L20,13.2830094 C20,16.2173861 18.4883464,18.9447835 16,20.5 L12.5299989,22.6687507 C12.2057287,22.8714196 11.7942713,22.8714196 11.4700011,22.6687507 L8,20.5 C5.51165358,18.9447835 4,16.2173861 4,13.2830094 L4,4 Z\"\r\n                                    fill=\"#000000\" opacity=\"0.3\" />\r\n                                <path\r\n                                    d=\"M12,11 C10.8954305,11 10,10.1045695 10,9 C10,7.8954305 10.8954305,7 12,7 C13.1045695,7 14,7.8954305 14,9 C14,10.1045695 13.1045695,11 12,11 Z\"\r\n                                    fill=\"#000000\" opacity=\"0.3\" />\r\n                                <path\r\n                                    d=\"M7.00036205,16.4995035 C7.21569918,13.5165724 9.36772908,12 11.9907452,12 C14.6506758,12 16.8360465,13.4332455 16.9988413,16.5 C17.0053266,16.6221713 16.9988413,17 16.5815,17 C14.5228466,17 11.463736,17 7.4041679,17 C7.26484009,17 6.98863236,16.6619875 7.00036205,16.4995035 Z\"\r\n                                    fill=\"#000000\" opacity=\"0.3\" />\r\n                            </g>\r\n                        </svg>'),
(24,'ClassContent','ViewAssesment',NULL,NULL,NULL,NULL);

/*Table structure for table `Tbl_ParentMenu` */

DROP TABLE IF EXISTS `Tbl_ParentMenu`;

CREATE TABLE `Tbl_ParentMenu` (
  `ParentID` int NOT NULL AUTO_INCREMENT,
  `DisplayName` varchar(50) DEFAULT NULL,
  `Icon` text,
  PRIMARY KEY (`ParentID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_ParentMenu` */

insert  into `Tbl_ParentMenu`(`ParentID`,`DisplayName`,`Icon`) values 
(1,'Users','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <polygon points=\"0 0 24 0 24 24 0 24\" />\r\n                                <path\r\n                                    d=\"M12,11 C9.790861,11 8,9.209139 8,7 C8,4.790861 9.790861,3 12,3 C14.209139,3 16,4.790861 16,7 C16,9.209139 14.209139,11 12,11 Z\"\r\n                                    fill=\"#000000\" fill-rule=\"nonzero\" opacity=\"0.3\" />\r\n                                <path\r\n                                    d=\"M3.00065168,20.1992055 C3.38825852,15.4265159 7.26191235,13 11.9833413,13 C16.7712164,13 20.7048837,15.2931929 20.9979143,20.2 C21.0095879,20.3954741 20.9979143,21 20.2466999,21 C16.541124,21 11.0347247,21 3.72750223,21 C3.47671215,21 2.97953825,20.45918 3.00065168,20.1992055 Z\"\r\n                                    fill=\"#000000\" fill-rule=\"nonzero\" />\r\n                            </g>\r\n                        </svg>'),
(2,'Courses','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\" />\r\n                                <path\r\n                                    d=\"M5,3 L6,3 C6.55228475,3 7,3.44771525 7,4 L7,20 C7,20.5522847 6.55228475,21 6,21 L5,21 C4.44771525,21 4,20.5522847 4,20 L4,4 C4,3.44771525 4.44771525,3 5,3 Z M10,3 L11,3 C11.5522847,3 12,3.44771525 12,4 L12,20 C12,20.5522847 11.5522847,21 11,21 L10,21 C9.44771525,21 9,20.5522847 9,20 L9,4 C9,3.44771525 9.44771525,3 10,3 Z\"\r\n                                    fill=\"#000000\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\"\r\n                                    transform=\"translate(17.825568, 11.945519) rotate(-19.000000) translate(-17.825568, -11.945519) \"\r\n                                    x=\"16.3255682\" y=\"2.94551858\" width=\"3\" height=\"18\" rx=\"1\" />\r\n                            </g>\r\n                        </svg>'),
(3,'Programs','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\" />\r\n                                <path\r\n                                    d=\"M5,5 C5,4.44771525 5.44771525,4 6,4 L15.75,4 C15.9073787,4 16.0555728,4.07409708 16.15,4.2 L18.9,7.86666667 C18.9649111,7.95321475 19,8.05848156 19,8.16666667 L19,19 C19,19.5522847 18.5522847,20 18,20 L6,20 C5.44771525,20 5,19.5522847 5,19 L5,5 Z M7,6 L7,9 L9,9 L9,6 L7,6 Z M10,6 L10,9 L12,9 L12,6 L10,6 Z M13,6 L13,9 L15,9 L15,6 L13,6 Z\"\r\n                                    fill=\"#000000\" />\r\n                            </g>\r\n                        </svg>'),
(4,'User Registration','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\" />\r\n                                <rect fill=\"#000000\" x=\"4\" y=\"5\" width=\"16\" height=\"3\" rx=\"1.5\" />\r\n                                <path\r\n                                    d=\"M5.5,15 L18.5,15 C19.3284271,15 20,15.6715729 20,16.5 C20,17.3284271 19.3284271,18 18.5,18 L5.5,18 C4.67157288,18 4,17.3284271 4,16.5 C4,15.6715729 4.67157288,15 5.5,15 Z M5.5,10 L18.5,10 C19.3284271,10 20,10.6715729 20,11.5 C20,12.3284271 19.3284271,13 18.5,13 L5.5,13 C4.67157288,13 4,12.3284271 4,11.5 C4,10.6715729 4.67157288,10 5.5,10 Z\"\r\n                                    fill=\"#000000\" opacity=\"0.3\" />\r\n                            </g>\r\n                        </svg>'),
(5,'Marks','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <polygon points=\"0 0 24 0 24 24 0 24\" />\r\n                                <path\r\n                                    d=\"M5.85714286,2 L13.7364114,2 C14.0910962,2 14.4343066,2.12568431 14.7051108,2.35473959 L19.4686994,6.3839416 C19.8056532,6.66894833 20,7.08787823 20,7.52920201 L20,20.0833333 C20,21.8738751 19.9795521,22 18.1428571,22 L5.85714286,22 C4.02044787,22 4,21.8738751 4,20.0833333 L4,3.91666667 C4,2.12612489 4.02044787,2 5.85714286,2 Z\"\r\n                                    fill=\"#000000\" fill-rule=\"nonzero\" opacity=\"0.3\" />\r\n                                <path\r\n                                    d=\"M8.95128003,13.8153448 L10.9077535,13.8153448 L10.9077535,15.8230161 C10.9077535,16.0991584 11.1316112,16.3230161 11.4077535,16.3230161 L12.4310522,16.3230161 C12.7071946,16.3230161 12.9310522,16.0991584 12.9310522,15.8230161 L12.9310522,13.8153448 L14.8875257,13.8153448 C15.1636681,13.8153448 15.3875257,13.5914871 15.3875257,13.3153448 C15.3875257,13.1970331 15.345572,13.0825545 15.2691225,12.9922598 L12.3009997,9.48659872 C12.1225648,9.27584861 11.8070681,9.24965194 11.596318,9.42808682 C11.5752308,9.44594059 11.5556598,9.46551156 11.5378061,9.48659872 L8.56968321,12.9922598 C8.39124833,13.2030099 8.417445,13.5185067 8.62819511,13.6969416 C8.71848979,13.773391 8.8329684,13.8153448 8.95128003,13.8153448 Z\"\r\n                                    fill=\"#000000\" />\r\n                            </g>\r\n                        </svg>'),
(6,'Attendence','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\" />\r\n                                <path\r\n                                    d=\"M8,3 L8,3.5 C8,4.32842712 8.67157288,5 9.5,5 L14.5,5 C15.3284271,5 16,4.32842712 16,3.5 L16,3 L18,3 C19.1045695,3 20,3.8954305 20,5 L20,21 C20,22.1045695 19.1045695,23 18,23 L6,23 C4.8954305,23 4,22.1045695 4,21 L4,5 C4,3.8954305 4.8954305,3 6,3 L8,3 Z\"\r\n                                    fill=\"#000000\" opacity=\"0.3\" />\r\n                                <path\r\n                                    d=\"M11,2 C11,1.44771525 11.4477153,1 12,1 C12.5522847,1 13,1.44771525 13,2 L14.5,2 C14.7761424,2 15,2.22385763 15,2.5 L15,3.5 C15,3.77614237 14.7761424,4 14.5,4 L9.5,4 C9.22385763,4 9,3.77614237 9,3.5 L9,2.5 C9,2.22385763 9.22385763,2 9.5,2 L11,2 Z\"\r\n                                    fill=\"#000000\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"10\" y=\"9\" width=\"7\" height=\"2\" rx=\"1\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"7\" y=\"9\" width=\"2\" height=\"2\" rx=\"1\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"7\" y=\"13\" width=\"2\" height=\"2\" rx=\"1\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"10\" y=\"13\" width=\"7\" height=\"2\" rx=\"1\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"7\" y=\"17\" width=\"2\" height=\"2\" rx=\"1\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"10\" y=\"17\" width=\"7\" height=\"2\" rx=\"1\" />\r\n                            </g>\r\n                        </svg>');

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
  `Profile_Date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ProfileID`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Profile` */

insert  into `Tbl_Profile`(`ProfileID`,`Name`,`FatherName`,`Email`,`NIC`,`Address`,`City`,`Country`,`Picture`,`DoB`,`Gender`,`PhoneNumber`,`Profile_Date`) values 
(55,'Mohsin',NULL,'masoodarif1313@gmail.com','1111111111111','6','Karachi','Pakistan','/Upload/1111111111111.jpg','01-01-2014','male','03172945903','10/11/2021'),
(56,'Masood','Arif','masoodarif1313@gmail.com','6666663232222','6','Karachi','Pakistan','/Upload/6666663232222.jpg','01-01-2014','male','03172945903','12/11/2021'),
(59,'Mubashir',NULL,'masoodarif1313@gmail.com','3245323432321','6','Karachi','Pakistan','/Upload/3245323432321.jpg','01-01-2014','male','03172945903','12/11/2021'),
(60,'Altaf',NULL,'masoodarif1313@gmail.com','3454325243643','6','Karachi','Pakistan','/Upload/3454325243643.jpg','01-01-2014','male','03172945903','12/11/2021'),
(61,'Hussain',NULL,'masoodarif1313@gmail.com','6266663232212','6','Karachi','Pakistan','/Upload/6266663232212.jpg','01-01-2014','male','03172945903','12/11/2021'),
(67,'Sumair',NULL,'masoodarif1313@gmail.com','1112345111111','6','Karachi','Pakistan','/Upload/1112345111111.jpg','01-01-2014','male','03172945903','13/11/2021'),
(81,'Iqbal','arif','masoodarif1313@gmail.com','1234567800000',NULL,NULL,NULL,'/Upload/1234567800000.jpg','12/15/2021','male','03172945903','06/12/2021'),
(90,'Habib','Muhammad Arif','masoodarif1313@gmail.com','4130783592999','Shahlatif town','Karachi','Pakistan','/Upload/4130783592999.jpg','12/07/2021','male','03172945903','26/12/2021'),
(91,'James','Butt','jbutt@gmail.com','1234567890111','6649 N Blue Gum St','New Orleans','Orleans','/Upload/1234567890111.jpg','01/11/2022','male','50426218927','02/01/2022'),
(92,'Paprocki','Lenna','art@venere.org','7011645148116','6649 N Blue Gum St','New Orleans','Orleans','/Upload/7011645148116.jpg','01/11/2022','male','50426218927','02/01/2022'),
(93,'Paprocki','Lenna','art@venere.org','7012345148116','6649 N Blue Gum St','New Orleans','Orleans','/Upload/7012345148116.jpg','01/11/2022','female','50426218927','02/01/2022'),
(94,'Shabir ','Hussain','masoodarif1313@gmail.com','1234567891111','6','Karachi','Pakistan','/Upload/1234567891111.jpg','01/20/2022','male','03172945903','10/01/2022'),
(95,'Niaz ','Hussain','masoodarif1313@gmail.com','1234567895321','6','Karachi','Pakistan','/Upload/1234567895321.jpg','01/20/2022','male','03172945903','10/01/2022'),
(96,'Liaqat  Khan','Ali hsaan','masoodarif1313@gmail.com','6784567895321','6','Karachi','Pakistan','/Upload/6784567895321.jpg','01/20/2022','male','03172945903','10/01/2022'),
(97,'Masood ','Muhammad Arif','masoodarif1313@gmail.com','4130783292999','R:36 sector 17/c','Karachi','Pakistan','/Upload/4130783292999.jpg','01/12/2022','male','03172945903','16/01/2022'),
(99,'Ali','Saqib','masoodarif1313@gmail.com','4130782563299','6','Karachi','Pakistan','/Upload/4130782563299.jpg','01/13/2022','male','03172945903','24/01/2022'),
(100,'Masood Arif',NULL,'masoodarif1313@gmail.com','1234567890332','R:36 sector 17/c','Karachi','Pakistan','/Upload/1234567890332.jpg','01/12/2022','male','03172945903','27/01/2022'),
(102,'Mohsin',NULL,'masoodarif1313@gmail.com','1111123421111','6','Karachi','Pakistan','/Upload/1111123421111.jpg','01-01-2014','male','03172945903','27/01/2022'),
(103,'Mohsin',NULL,'masoodarif1313@gmail.com','1134511111111','6','Karachi','Pakistan','/Upload/1134511111111.jpg','01-01-2014','male','03172945903','27/01/2022'),
(104,'Mohsin',NULL,'masoodarif1313@gmail.com','1134511341111','6','Karachi','Pakistan','/Upload/1134511341111.jpg','01-01-2014','male','03172945903','27/01/2022'),
(105,'Mohsin',NULL,'masoodarif1313@gmail.com','1134517841111','6','Karachi','Pakistan','/Upload/1134517841111.jpg','01-01-2014','male','03172945903','27/01/2022'),
(106,'Masood Arif',NULL,'masoodarif1313@gmail.com','1234567890122','6','Karachi','Pakistan','/Upload/1234567890122.jpg','12/28/2021','male','03172945903','28/01/2022'),
(107,'Masood Arif','Muhammad Arif','masoodarif1313@gmail.com','7453471234578','6','Karachi','Pakistan','/Upload/7453471234578.jpg','01/11/2022','male','03172945903','29/01/2022');

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
  CONSTRAINT `Tbl_ProgramSyllabus_ibfk_1` FOREIGN KEY (`Program_Id`) REFERENCES `Tbl_Programs` (`ProgramID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_ProgramSyllabus_ibfk_2` FOREIGN KEY (`Course_Id`) REFERENCES `Tbl_Courses` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_ProgramSyllabus_ibfk_3` FOREIGN KEY (`RqdCourse_Id`) REFERENCES `Tbl_Courses` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_ProgramSyllabus` */

insert  into `Tbl_ProgramSyllabus`(`Syllabus_Id`,`Program_Id`,`Course_Id`,`RqdCourse_Id`,`Required_CrHr`) values 
(29,1,39,30,0),
(31,1,41,32,0),
(32,1,42,33,0),
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
(81,1,83,70,0),
(82,1,83,73,0),
(83,1,83,74,0),
(84,1,84,83,0),
(103,6,30,44,23),
(104,6,47,40,12),
(108,1,37,NULL,0);

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
  `Check` bit(1) DEFAULT b'0',
  PRIMARY KEY (`Id`),
  KEY `Menu_ID` (`Menu_ID`),
  KEY `Role_ID` (`Role_ID`),
  CONSTRAINT `Tbl_RoleMenu_ibfk_1` FOREIGN KEY (`Menu_ID`) REFERENCES `Tbl_Menu` (`Menu_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_RoleMenu_ibfk_2` FOREIGN KEY (`Role_ID`) REFERENCES `Tbl_Roles` (`RoleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=679 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_RoleMenu` */

insert  into `Tbl_RoleMenu`(`Id`,`Menu_ID`,`Role_ID`,`Check`) values 
(590,20,4,'\0'),
(591,18,4,''),
(592,2,4,'\0'),
(593,3,4,'\0'),
(594,4,4,'\0'),
(595,5,4,'\0'),
(596,6,4,'\0'),
(597,7,4,'\0'),
(598,8,4,''),
(599,19,4,'\0'),
(600,9,4,'\0'),
(601,11,4,''),
(602,12,4,''),
(603,13,4,'\0'),
(604,14,4,'\0'),
(605,15,4,'\0'),
(606,16,4,'\0'),
(607,17,4,'\0'),
(608,10,4,'\0'),
(609,1,4,'\0'),
(613,24,4,'\0'),
(616,24,2,''),
(617,19,2,''),
(618,2,2,''),
(619,3,2,'\0'),
(620,4,2,'\0'),
(621,5,2,''),
(622,6,2,''),
(623,7,2,'\0'),
(624,8,2,''),
(625,9,2,'\0'),
(626,10,2,''),
(627,11,2,'\0'),
(628,12,2,'\0'),
(629,13,2,'\0'),
(630,14,2,'\0'),
(631,15,2,'\0'),
(632,16,2,'\0'),
(633,17,2,'\0'),
(634,18,2,''),
(635,20,2,'\0'),
(636,1,2,'\0'),
(637,24,1,''),
(638,19,1,''),
(639,2,1,'\0'),
(640,3,1,'\0'),
(641,4,1,''),
(642,5,1,''),
(643,6,1,''),
(644,7,1,''),
(645,8,1,''),
(646,9,1,'\0'),
(647,10,1,'\0'),
(648,11,1,''),
(649,12,1,''),
(650,13,1,''),
(651,14,1,''),
(652,15,1,''),
(653,16,1,''),
(654,17,1,''),
(655,18,1,''),
(656,20,1,''),
(657,1,1,''),
(658,24,3,''),
(659,19,3,''),
(660,2,3,'\0'),
(661,3,3,''),
(662,4,3,'\0'),
(663,5,3,''),
(664,6,3,''),
(665,7,3,'\0'),
(666,8,3,''),
(667,9,3,''),
(668,10,3,'\0'),
(669,11,3,'\0'),
(670,12,3,'\0'),
(671,13,3,'\0'),
(672,14,3,'\0'),
(673,15,3,'\0'),
(674,16,3,'\0'),
(675,17,3,'\0'),
(676,18,3,''),
(677,20,3,'\0'),
(678,1,3,'\0');

/*Table structure for table `Tbl_Roles` */

DROP TABLE IF EXISTS `Tbl_Roles`;

CREATE TABLE `Tbl_Roles` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(50) NOT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Roles` */

insert  into `Tbl_Roles`(`RoleID`,`RoleName`) values 
(1,'Admin'),
(2,'Faculty'),
(3,'Student'),
(4,'Program Manager'),
(6,'Academics');

/*Table structure for table `Tbl_Semester` */

DROP TABLE IF EXISTS `Tbl_Semester`;

CREATE TABLE `Tbl_Semester` (
  `Semester_Id` int NOT NULL AUTO_INCREMENT,
  `SemesterName` varchar(50) DEFAULT NULL,
  `StartDate` varchar(50) DEFAULT NULL,
  `EndDate` varchar(50) DEFAULT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Semester_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=latin1;

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
(52,'Fall 2023','02/12/2021','25/01/2022','\0'),
(62,'Fall 2022','25/01/2022',NULL,'\0'),
(65,'Fall 2021','25/01/2022',NULL,'\0'),
(66,'fall 2020','25/01/2022','25/01/2022','\0'),
(67,'FALL21','25/01/2022','25/01/2022','\0'),
(68,'FALL 2021','25/01/2022','25/01/2022','\0'),
(69,'FALL 2020','25/01/2022','25/01/2022','\0'),
(70,'FALL 2020111','25/01/2022','25/01/2022','\0'),
(71,'SPRING 2022','25/01/2022','26/01/2022','\0'),
(72,'FALL 2022','26/01/2022',NULL,'');

/*Table structure for table `Tbl_Student` */

DROP TABLE IF EXISTS `Tbl_Student`;

CREATE TABLE `Tbl_Student` (
  `Student_Id` int NOT NULL AUTO_INCREMENT,
  `ProgramID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  PRIMARY KEY (`Student_Id`),
  KEY `ProgramID` (`ProgramID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `Tbl_Student_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Student_ibfk_2` FOREIGN KEY (`ProgramID`) REFERENCES `Tbl_Programs` (`ProgramID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Student` */

insert  into `Tbl_Student`(`Student_Id`,`ProgramID`,`UserID`) values 
(15,1,64),
(17,1,75),
(19,1,119),
(20,1,120),
(21,1,121),
(22,1,122),
(23,6,129),
(24,6,130),
(25,6,131),
(26,1,139),
(27,1,151);

/*Table structure for table `Tbl_StudentCourseRegistration` */

DROP TABLE IF EXISTS `Tbl_StudentCourseRegistration`;

CREATE TABLE `Tbl_StudentCourseRegistration` (
  `SCR_Id` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) DEFAULT NULL,
  `User_ID` int NOT NULL,
  `Class_ID` int NOT NULL,
  `SemesterId` int DEFAULT NULL,
  `IsActive` bit(1) NOT NULL,
  PRIMARY KEY (`SCR_Id`),
  KEY `Tbl_StudentCourseRegistration_ibfk_2` (`User_ID`),
  KEY `Tbl_StudentCourseRegistration_ibfk_3` (`Class_ID`),
  KEY `SemesterId` (`SemesterId`),
  CONSTRAINT `Tbl_StudentCourseRegistration_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_StudentCourseRegistration_ibfk_3` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_StudentCourseRegistration_ibfk_4` FOREIGN KEY (`SemesterId`) REFERENCES `Tbl_Semester` (`Semester_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_StudentCourseRegistration` */

insert  into `Tbl_StudentCourseRegistration`(`SCR_Id`,`Username`,`User_ID`,`Class_ID`,`SemesterId`,`IsActive`) values 
(15,'student',64,52,52,'\0'),
(23,'518290',119,50,52,'\0'),
(24,'518290',119,59,52,'\0'),
(26,'44560',75,50,52,'\0'),
(29,'student',64,75,52,'\0'),
(30,'student',64,50,52,'\0'),
(33,'24691',120,50,52,'\0'),
(34,'183492',121,50,52,'\0'),
(35,'793093',122,50,52,'\0'),
(38,'student',64,48,52,'\0'),
(42,'341996',131,57,52,'\0'),
(44,'44560',75,46,52,'\0'),
(45,'24691',120,78,72,''),
(46,'44560',75,78,72,''),
(47,'518290',119,78,72,''),
(48,'793093',122,78,72,''),
(49,'Std22107',151,79,72,''),
(50,'student',64,79,72,''),
(51,'student',64,80,72,''),
(52,'518290',119,80,72,''),
(53,'793093',122,79,72,''),
(54,'793093',122,80,72,''),
(55,'525395',130,80,72,''),
(56,'525395',130,79,72,''),
(57,'525395',130,78,72,''),
(58,'student',64,78,72,''),
(59,'518290',119,79,72,'');

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

/*Table structure for table `Tbl_Url` */

DROP TABLE IF EXISTS `Tbl_Url`;

CREATE TABLE `Tbl_Url` (
  `Url_ID` int NOT NULL AUTO_INCREMENT,
  `Class_ID` int DEFAULT NULL,
  `Session_ID` int DEFAULT NULL,
  `DisplayName` varchar(200) DEFAULT NULL,
  `Link` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`Url_ID`),
  KEY `Class_ID` (`Class_ID`),
  KEY `Session_ID` (`Session_ID`),
  CONSTRAINT `Tbl_Url_ibfk_1` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`),
  CONSTRAINT `Tbl_Url_ibfk_2` FOREIGN KEY (`Session_ID`) REFERENCES `Tbl_ClassSessions` (`Session_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Url` */

insert  into `Tbl_Url`(`Url_ID`,`Class_ID`,`Session_ID`,`DisplayName`,`Link`) values 
(106,79,195,'Github','https://lms.kiet.edu.pk/kietlms/course/view.php?id=3327');

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
  CONSTRAINT `Tbl_User_ibfk_1` FOREIGN KEY (`ProfileID`) REFERENCES `Tbl_Profile` (`ProfileID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_User_ibfk_2` FOREIGN KEY (`RoleID`) REFERENCES `Tbl_Roles` (`RoleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_User` */

insert  into `Tbl_User`(`UserID`,`UserName`,`Password`,`RoleID`,`ProfileID`,`IsActive`,`User_Date`) values 
(64,'student','1050',3,55,'','10/11/2021'),
(69,'faculty','1050',2,56,'','12/11/2021'),
(72,'495159','1050',2,59,'\0','12/11/2021'),
(75,'44560','1050',3,60,'\0','12/11/2021'),
(76,'826361','1050',1,61,'','12/11/2021'),
(91,'668667','1050',2,67,'','13/11/2021'),
(101,'863281','1050',2,81,'','06/12/2021'),
(119,'518290','1050',3,90,'','26/12/2021'),
(120,'24691','1050',3,91,'','02/01/2022'),
(121,'183492','1050',3,92,'','02/01/2022'),
(122,'793093','1050',3,93,'','02/01/2022'),
(129,'408494','1050',3,94,'','10/01/2022'),
(130,'525395','1050',3,95,'','10/01/2022'),
(131,'341996','1050',3,96,'','10/01/2022'),
(132,'admin','1050',1,97,'','16/01/2022'),
(135,'700490','1050',1,90,'','19/01/2022'),
(138,'382499','1050',4,99,'','24/01/2022'),
(139,'Std29100','1050',3,100,'','27/01/2022'),
(142,'Emp4955','1050',4,55,'','27/01/2022'),
(143,'Emp5055','1050',6,55,'','27/01/2022'),
(144,'Emp5055','1050',6,55,'','27/01/2022'),
(145,'Emp50102','1050',2,102,'','27/01/2022'),
(146,'Emp58103','1050',4,103,'','27/01/2022'),
(147,'Emp36104','1050',2,104,'','27/01/2022'),
(148,'Emp46105','1050',2,105,'','27/01/2022'),
(149,'Emp51105','masood',4,105,'','27/01/2022'),
(150,'Emp58106','1050',2,106,'','28/01/2022'),
(151,'Std22107','1050',3,107,'','29/01/2022'),
(152,'Emp34107','1050',4,107,'','29/01/2022');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
