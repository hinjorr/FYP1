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
  `Link` varchar(500) DEFAULT NULL,
  `SubmissionTime` datetime DEFAULT NULL,
  PRIMARY KEY (`SubmissionId`),
  KEY `UserID` (`UserID`),
  KEY `AssesmentID` (`AssesmentID`),
  CONSTRAINT `Tbl_AssesmentSubmission_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_AssesmentSubmission_ibfk_2` FOREIGN KEY (`AssesmentID`) REFERENCES `Tbl_Assesments` (`AssesmentId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_AssesmentSubmission` */

insert  into `Tbl_AssesmentSubmission`(`SubmissionId`,`UserID`,`AssesmentID`,`FilePath`,`DisplayName`,`Link`,`SubmissionTime`) values 
(16,64,58,'/Upload/student-Mohsin-Assignment 1-79.pdf','student-Mohsin-Assignment 1-79','https://www.dropbox.com/s/sf8adsgd140kyt8/student-Mohsin-Quiz%202%20Testing-79.pdf?dl=0','2022-02-07 14:39:26'),
(37,64,76,'/Assesments_Submission/DSA Lab 82/Assignment 1/student-Mohsin-Assignment 1-82.json','student-Mohsin-Assignment 1-82.json','https://www.dropbox.com/sh/qrtd2p9d31yeajr/AACys5n9Co5E2Ad1KG57ghYna?dl=0','2022-03-15 23:45:27'),
(40,64,82,'/Assesments_Submission/DSA Lab 82/Quiz 2/student-Mohsin-Quiz 2-82.json','student-Mohsin-Quiz 2-82.json','https://www.dropbox.com/s/d1swqk5j5xqm2e1/student-Mohsin-Quiz%202-82.json?dl=0','2022-03-18 23:11:55');

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
  `LateSubmission` bit(1) DEFAULT b'0',
  `Submission_Folder` varchar(500) DEFAULT NULL,
  `FolderPath` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`AssesmentId`),
  KEY `Class_ID` (`Class_ID`),
  KEY `Session_ID` (`Session_ID`),
  CONSTRAINT `Tbl_Assesments_ibfk_1` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`),
  CONSTRAINT `Tbl_Assesments_ibfk_2` FOREIGN KEY (`Session_ID`) REFERENCES `Tbl_ClassSessions` (`Session_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Assesments` */

insert  into `Tbl_Assesments`(`AssesmentId`,`Class_ID`,`Session_ID`,`AssesmentName`,`Description`,`Start`,`End`,`LateSubmission`,`Submission_Folder`,`FolderPath`) values 
(58,79,195,'Assignment 1',NULL,'2022-02-07 13:38:00','2022-02-07 23:33:00','',NULL,NULL),
(75,79,197,'Project Presentation',NULL,'2022-03-15 22:45:00','2022-04-09 22:45:00','\0',NULL,NULL),
(76,82,195,'Assignment 1',NULL,'2022-03-15 23:25:00','2022-04-08 23:25:00','\0','https://www.dropbox.com/sh/qrtd2p9d31yeajr/AACys5n9Co5E2Ad1KG57ghYna?dl=0','/Assesments_Submission/DSA Lab 82/Assignment 1'),
(82,82,196,'Quiz 2',NULL,'2022-03-18 23:09:00','2022-03-25 23:09:00','\0','https://www.dropbox.com/sh/wrplxg18hfpdgir/AADqf5GLvittyjLG1yL14I8Wa?dl=0','/Assesments_Submission/DSA Lab 82/Quiz 2');

/*Table structure for table `Tbl_AssesmetnAttachments` */

DROP TABLE IF EXISTS `Tbl_AssesmetnAttachments`;

CREATE TABLE `Tbl_AssesmetnAttachments` (
  `File_ID` int NOT NULL AUTO_INCREMENT,
  `AssesmentId` int DEFAULT NULL,
  `DisplayName` varchar(400) DEFAULT NULL,
  `Path` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `Link` varchar(5000) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`File_ID`),
  KEY `Tbl_AssesmetnAttachments_ibfk_1` (`AssesmentId`),
  CONSTRAINT `Tbl_AssesmetnAttachments_ibfk_1` FOREIGN KEY (`AssesmentId`) REFERENCES `Tbl_Assesments` (`AssesmentId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_AssesmetnAttachments` */

insert  into `Tbl_AssesmetnAttachments`(`File_ID`,`AssesmentId`,`DisplayName`,`Path`,`Link`) values 
(198,58,'Screenshot from 2022-02-03 00-29-29-835757.png','/Assesment_Attachment/Screenshot from 2022-02-03 00-29-29-835757.png','https://www.dropbox.com/s/1i7b2un9v1m37pd/Screenshot%20from%202022-02-03%2000-29-29-835757.png?dl=0'),
(199,58,'image3.1-192441.jpg','/Assesment_Attachment/image3.1-192441.jpg','https://www.dropbox.com/s/27skdox0x6pm3xa/image3.1-192441.jpg?dl=0'),
(214,82,'adept-cosine-342316-e7c94bbd1a61-26849.json','/Assesment_Attachment/adept-cosine-342316-e7c94bbd1a61-26849.json','https://www.dropbox.com/s/1vonndoogd5n3lb/adept-cosine-342316-e7c94bbd1a61-26849.json?dl=0');

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
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=latin1;

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
(199,50,179,122,'793093','\0','\0'),
(231,79,195,122,'793093','\0',''),
(232,79,195,130,'525395','\0','\0'),
(233,79,195,119,'518290','\0','\0'),
(234,79,195,64,'student','',''),
(235,79,195,75,'44560','\0',''),
(236,79,195,120,'24691','\0','\0'),
(237,79,195,129,'408494','\0',''),
(238,79,195,131,'341996','\0','\0'),
(239,79,195,139,'Std29100','','\0'),
(264,80,195,119,'518290','\0','\0'),
(265,80,195,122,'793093','\0',''),
(266,80,195,130,'525395','','\0'),
(267,80,195,64,'student','',''),
(268,80,196,119,'518290','','\0'),
(269,80,196,122,'793093','','\0'),
(270,80,196,130,'525395','',''),
(271,80,196,64,'student','','');

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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=latin1;

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
(78,14,2,44,72,1,1,1,'',NULL),
(79,12,10,42,72,1,3,1,'',NULL),
(80,12,4,47,72,6,2,2,'',NULL),
(81,34,0,50,72,1,3,1,'',NULL),
(82,12,8,49,72,1,1,1,'',NULL);

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

/*Table structure for table `Tbl_Docs` */

DROP TABLE IF EXISTS `Tbl_Docs`;

CREATE TABLE `Tbl_Docs` (
  `Doc_Id` int NOT NULL AUTO_INCREMENT,
  `SessionId` int DEFAULT NULL,
  `CLassId` int DEFAULT NULL,
  `Display_Name` varchar(500) DEFAULT NULL,
  `Path` varchar(500) DEFAULT NULL,
  `Link` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Doc_Id`),
  KEY `SessionId` (`SessionId`),
  KEY `CLassId` (`CLassId`),
  CONSTRAINT `Tbl_Docs_ibfk_1` FOREIGN KEY (`SessionId`) REFERENCES `Tbl_ClassSessions` (`Session_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Docs_ibfk_2` FOREIGN KEY (`CLassId`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Docs` */

insert  into `Tbl_Docs`(`Doc_Id`,`SessionId`,`CLassId`,`Display_Name`,`Path`,`Link`) values 
(12,196,79,'Screenshot from 2022-03-04 19-48-19-650294.png','/Lectures/Screenshot from 2022-03-04 19-48-19-650294.png','https://www.dropbox.com/s/9fskiuuvbdu16xy/Screenshot%20from%202022-03-04%2019-48-19-650294.png?dl=0'),
(13,196,79,'Google Drive API Integration And Use Of Functions10-664755.png','/Lectures/Google Drive API Integration And Use Of Functions10-664755.png','https://www.dropbox.com/s/h1v5k3tkjbga8pt/Google%20Drive%20API%20Integration%20And%20Use%20Of%20Functions10-664755.png?dl=0'),
(14,196,79,'FYP Proposal Updated-455950.pdf','/Lectures/FYP Proposal Updated-455950.pdf','https://www.dropbox.com/s/hajq2i247b2xy46/FYP%20Proposal%20Updated-455950.pdf?dl=0'),
(15,196,79,'FYP Proposal-774695.pdf','/Lectures/FYP Proposal-774695.pdf','https://www.dropbox.com/s/ui9x00zn6r50823/FYP%20Proposal-774695.pdf?dl=0'),
(16,196,79,'dailymotion-banner-27010.jpg','/Lectures/dailymotion-banner-27010.jpg','https://www.dropbox.com/s/fka94w95bxqlqy8/dailymotion-banner-27010.jpg?dl=0'),
(17,196,79,'asdsada-86409.pdf','/Lectures/asdsada-86409.pdf','https://www.dropbox.com/s/9zprs08mrajcdzw/asdsada-86409.pdf?dl=0'),
(18,199,79,'NICU (1)-585515.xlsx','/Lectures/NICU (1)-585515.xlsx','https://www.dropbox.com/scl/fi/b6vh0ll5vhqj580tnl99w/NICU-1-585515.xlsx?dl=0&rlkey=6e5vbup15m4p1hczw59ns4zle'),
(19,201,79,'Resume Masood Arif-193843.pdf','/Lectures/Resume Masood Arif-193843.pdf','https://www.dropbox.com/s/79ani5d5hxp8ien/Resume%20Masood%20Arif-193843.pdf?dl=0'),
(20,197,82,'Resume Masood Arif-426625.pdf','/Lectures/Resume Masood Arif-426625.pdf','https://www.dropbox.com/s/nt626yzr5zgpcpw/Resume%20Masood%20Arif-426625.pdf?dl=0'),
(21,197,82,'Resume Masood Arif-791743.docx','/Lectures/Resume Masood Arif-791743.docx','https://www.dropbox.com/scl/fi/xptpiqx73yadw8jrcidow/Resume-Masood-Arif-791743.docx?dl=0&rlkey=hzk3b7qsixlhympztra215it7'),
(22,202,79,'Assigment 1 Masood Arif 9763pdf-146355','/Lectures/Assigment 1 Masood Arif 9763pdf-146355','https://www.dropbox.com/s/qpt790xieekvybf/Assigment%201%20Masood%20Arif%209763pdf-146355?dl=0'),
(23,196,79,'GPL License Terms-394287.pdf','/Lectures/GPL License Terms-394287.pdf','https://www.dropbox.com/s/vkzstqb0vzayio6/GPL%20License%20Terms-394287.pdf?dl=0'),
(24,198,79,'MAD SP2022 Assign# 1-252029.docx','/Lectures/BE Lab79/18 October - 24 October/MAD SP2022 Assign# 1-252029.docx','https://www.dropbox.com/scl/fi/z48771rl78ew03ov2eg1m/MAD-SP2022-Assign-1-252029.docx?dl=0&rlkey=thb2j9z4c6d3yukav1kzq2fsg'),
(25,195,82,'Assigment 1 Masood Arif 9763pdf-211781','/Lectures/DSA Lab 82/27 September - 3 October/Assigment 1 Masood Arif 9763pdf-211781','https://www.dropbox.com/sh/s17mkvonbsgukeg/AADAeFl7-r0GQKrXWml_q8sha?dl=0');

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

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
(27,69,'faculty',79,NULL,''),
(28,72,'495159',81,NULL,''),
(29,69,'faculty',82,NULL,'');

/*Table structure for table `Tbl_Marks` */

DROP TABLE IF EXISTS `Tbl_Marks`;

CREATE TABLE `Tbl_Marks` (
  `Marks_Id` int NOT NULL AUTO_INCREMENT,
  `Class_Id` int DEFAULT NULL,
  `AssesmentId` int DEFAULT NULL,
  `User_Id` int DEFAULT NULL,
  `Total_Marks` int DEFAULT NULL,
  `Obtained_Makrs` int DEFAULT '0',
  PRIMARY KEY (`Marks_Id`),
  KEY `Tbl_Marks_ibfk_1` (`Class_Id`),
  KEY `Tbl_Marks_ibfk_2` (`User_Id`),
  KEY `AssesmentId` (`AssesmentId`),
  CONSTRAINT `Tbl_Marks_ibfk_1` FOREIGN KEY (`Class_Id`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Marks_ibfk_2` FOREIGN KEY (`User_Id`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Marks_ibfk_3` FOREIGN KEY (`AssesmentId`) REFERENCES `Tbl_Assesments` (`AssesmentId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Marks` */

insert  into `Tbl_Marks`(`Marks_Id`,`Class_Id`,`AssesmentId`,`User_Id`,`Total_Marks`,`Obtained_Makrs`) values 
(163,79,58,139,12,0),
(164,79,58,129,12,0),
(165,79,58,120,12,30),
(166,79,58,75,12,3),
(167,79,58,64,12,4),
(168,79,58,119,12,30),
(169,79,58,130,12,30),
(170,79,58,122,12,3),
(171,79,58,131,12,0);

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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

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
(24,'ClassContent','ViewAssesment',NULL,NULL,NULL,NULL),
(25,'Chat','NewChat','NewChat','New Message',7,NULL),
(26,'Chat','Inbox','Inbox','Inbox',7,NULL),
(27,'Chat','Sent_Message','MessageSent','Sent',7,NULL);

/*Table structure for table `Tbl_NotificaionTo` */

DROP TABLE IF EXISTS `Tbl_NotificaionTo`;

CREATE TABLE `Tbl_NotificaionTo` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NotificationId` int DEFAULT NULL,
  `To` int DEFAULT NULL,
  `IsSeen` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `NotificationId` (`NotificationId`),
  KEY `To` (`To`),
  CONSTRAINT `Tbl_NotificaionTo_ibfk_1` FOREIGN KEY (`NotificationId`) REFERENCES `Tbl_Notifications` (`Notification_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_NotificaionTo_ibfk_2` FOREIGN KEY (`To`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_NotificaionTo` */

insert  into `Tbl_NotificaionTo`(`ID`,`NotificationId`,`To`,`IsSeen`) values 
(2,1,122,0),
(3,1,130,0),
(4,1,119,0),
(5,1,64,1),
(6,1,75,0),
(7,1,120,0),
(8,1,129,0),
(9,1,131,0),
(10,1,139,0),
(12,2,122,0),
(13,2,130,0),
(14,2,119,0),
(15,2,64,1),
(16,2,75,0),
(17,2,120,0),
(18,2,129,0),
(19,2,131,0),
(20,2,139,0),
(26,7,122,0),
(27,7,130,0),
(28,7,119,0),
(29,7,64,1),
(30,7,75,0),
(31,7,120,0),
(32,7,129,0),
(33,7,131,0),
(34,7,139,0),
(35,8,75,0),
(36,8,64,1),
(37,8,119,0),
(38,8,120,0),
(39,8,121,0),
(40,8,129,0),
(41,8,139,0),
(43,9,64,1),
(44,9,75,0),
(45,9,119,0),
(46,9,120,0),
(47,9,121,0),
(48,9,129,0),
(49,9,139,0),
(52,10,122,0),
(53,10,130,0),
(54,10,119,0),
(55,10,64,1),
(56,10,75,0),
(57,10,120,0),
(58,10,129,0),
(59,10,131,0),
(60,10,139,0),
(61,11,64,1),
(62,11,75,0),
(63,11,119,0),
(64,11,120,0),
(65,11,121,0),
(66,11,129,0),
(67,11,139,0),
(70,12,122,0),
(71,12,130,0),
(72,12,119,0),
(73,12,64,1),
(74,12,75,0),
(75,12,120,0),
(76,12,129,0),
(77,12,131,0),
(78,12,139,0),
(82,16,69,1),
(83,17,64,1),
(85,18,122,0),
(86,18,130,0),
(87,18,119,0),
(88,18,64,1),
(89,18,75,0),
(90,18,120,0),
(91,18,129,0),
(92,18,131,0),
(93,18,139,0),
(95,19,122,0),
(96,19,130,0),
(97,19,119,0),
(98,19,64,1),
(99,19,75,0),
(100,19,120,0),
(101,19,129,0),
(102,19,131,0),
(103,19,139,0),
(104,20,69,1),
(105,21,64,1),
(106,22,69,1),
(107,23,64,1),
(108,24,69,1),
(109,25,64,1),
(110,26,69,1),
(111,27,64,1),
(112,28,69,1),
(113,29,64,1),
(114,30,69,1),
(115,31,64,1),
(116,32,69,1),
(117,33,64,1),
(118,34,69,1),
(119,35,64,1),
(130,37,139,0),
(131,37,131,0),
(132,37,129,0),
(133,37,120,0),
(134,37,75,0),
(135,37,64,1),
(136,37,119,0),
(137,37,130,0),
(138,37,122,0),
(141,38,122,0),
(142,38,130,0),
(143,38,119,0),
(144,38,64,1),
(145,38,75,0),
(146,38,120,0),
(147,38,129,0),
(148,38,131,0),
(149,38,139,0),
(151,39,122,0),
(152,39,130,0),
(153,39,119,0),
(154,39,64,1),
(155,39,75,0),
(156,39,120,0),
(157,39,129,0),
(158,39,131,0),
(159,39,139,0),
(160,40,69,1),
(161,41,64,1),
(162,42,69,1),
(163,43,64,1),
(165,44,122,0),
(166,44,130,0),
(167,44,119,0),
(168,44,64,1),
(169,44,75,0),
(170,44,120,0),
(171,44,129,0),
(172,44,131,0),
(173,44,139,0),
(174,45,64,1),
(175,45,75,0),
(176,45,119,0),
(177,45,120,0),
(178,45,121,0),
(179,45,129,0),
(180,45,139,0),
(182,46,69,1),
(183,47,64,1),
(184,48,119,0),
(185,48,75,0),
(186,48,64,1),
(187,48,120,0),
(188,48,121,0),
(189,48,129,0),
(190,48,139,0),
(193,52,64,1),
(195,54,64,1),
(196,55,64,1),
(197,56,64,1),
(198,57,64,1),
(199,58,64,1),
(200,59,64,1),
(201,60,64,1),
(202,61,64,1),
(203,62,64,1),
(204,63,64,1),
(205,64,64,1),
(206,65,64,1),
(207,66,64,1),
(208,67,119,0),
(209,67,122,0),
(210,67,130,0),
(211,67,64,1),
(212,68,119,0),
(213,68,122,0),
(214,68,130,0),
(215,68,64,1),
(216,69,119,0),
(217,69,122,0),
(218,69,130,0),
(219,69,64,1),
(220,70,119,0),
(221,70,122,0),
(222,70,130,0),
(223,70,64,1),
(224,71,119,0),
(225,71,122,0),
(226,71,130,0),
(227,71,64,1),
(228,72,64,1),
(229,72,75,0),
(230,72,119,0),
(231,72,120,0),
(232,72,121,0),
(233,72,129,0),
(234,72,139,0),
(236,73,69,1),
(237,74,64,1),
(238,75,64,1),
(239,75,75,0),
(240,75,119,0),
(241,75,120,0),
(242,75,121,0),
(243,75,129,0),
(244,75,139,0),
(246,76,69,1),
(247,77,64,1),
(248,78,64,1),
(249,78,75,0),
(250,78,119,0),
(251,78,120,0),
(252,78,121,0),
(253,78,129,0),
(254,78,139,0),
(256,79,64,1),
(257,79,75,0),
(258,79,119,0),
(259,79,120,0),
(260,79,121,0),
(261,79,129,0),
(262,79,139,0),
(264,80,64,1),
(265,80,75,0),
(266,80,119,0),
(267,80,120,0),
(268,80,121,0),
(269,80,129,0),
(270,80,139,0),
(272,81,64,1),
(273,81,75,0),
(274,81,119,0),
(275,81,120,0),
(276,81,121,0),
(277,81,129,0),
(278,81,139,0),
(280,82,69,1),
(281,83,64,1);

/*Table structure for table `Tbl_NotificationType` */

DROP TABLE IF EXISTS `Tbl_NotificationType`;

CREATE TABLE `Tbl_NotificationType` (
  `Type_Id` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(500) DEFAULT NULL,
  `Icon` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  PRIMARY KEY (`Type_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_NotificationType` */

insert  into `Tbl_NotificationType`(`Type_Id`,`Type`,`Icon`) values 
(1,'Assesment','https://img.icons8.com/color/50/000000/task--v1.png'),
(2,'Lecture Material','https://img.icons8.com/color/48/000000/classroom.png'),
(3,'Course Registration','https://img.icons8.com/external-wanicon-lineal-color-wanicon/64/000000/external-registration-hospital-wanicon-lineal-color-wanicon.png'),
(4,'Attendence','https://img.icons8.com/external-flaticons-lineal-color-flat-icons/64/000000/external-report-back-to-work-flaticons-lineal-color-flat-icons.png'),
(5,'Marks','https://img.icons8.com/external-konkapp-outline-color-konkapp/64/000000/external-grade-online-learning-konkapp-outline-color-konkapp.png');

/*Table structure for table `Tbl_Notifications` */

DROP TABLE IF EXISTS `Tbl_Notifications`;

CREATE TABLE `Tbl_Notifications` (
  `Notification_ID` int NOT NULL AUTO_INCREMENT,
  `From` varchar(500) DEFAULT NULL,
  `Type_Id` int DEFAULT NULL,
  `Message` varchar(500) DEFAULT NULL,
  `UploadedTime` datetime DEFAULT NULL,
  `ClassId` int DEFAULT '0',
  PRIMARY KEY (`Notification_ID`),
  KEY `From` (`From`),
  KEY `Type_Id` (`Type_Id`),
  CONSTRAINT `Tbl_Notifications_ibfk_3` FOREIGN KEY (`Type_Id`) REFERENCES `Tbl_NotificationType` (`Type_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Notifications` */

insert  into `Tbl_Notifications`(`Notification_ID`,`From`,`Type_Id`,`Message`,`UploadedTime`,`ClassId`) values 
(1,'BE Lab 79',2,'new reference Link has been added in 4 October - 10 October','2022-03-08 19:24:42',79),
(2,'BE Lab 79',2,'new reference Link has been added in 4 October - 10 October','2022-03-10 16:00:18',79),
(7,'BE Lab 79',2,'New Lecture File(s) has been uploaded in 8 November - 14 November','2022-03-11 16:00:18',79),
(8,'DSA Lab 82',2,'New Lecture File(s) has been uploaded in 11 October - 17 October','2022-03-12 16:00:18',82),
(9,'DSA Lab 82',2,'New Lecture video(s) has been uploaded in 27 September - 3 October','2022-03-12 17:00:18',82),
(10,'BE Lab 79',2,'new reference Link has been added in 11 October - 17 October','2022-03-12 19:24:54',79),
(11,'DSA Lab 82',1,'Quiz 5 has been assigned.','2022-03-12 19:30:00',82),
(12,'BE Lab 79',2,'New Lecture File(s) has been uploaded in 15 November - 21 November','2022-03-12 20:11:54',79),
(13,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-12 22:01:19',82),
(14,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-12 22:04:19',82),
(15,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-12 22:11:50',82),
(16,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-12 22:14:47',82),
(17,'DSA Lab 82',1,'Your Quiz 5 has been Submitted ','2022-03-12 22:14:48',82),
(18,'BE Lab 79',4,'Your attendence of 27 September - 3 October has been marked.','2022-03-14 15:22:07',79),
(19,'BE Lab 79',4,'Your attendence of 27 September - 3 October has been marked.','2022-03-14 15:46:06',79),
(20,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-14 16:08:23',82),
(21,'DSA Lab 82',1,'Your Quiz 5 has been Submitted ','2022-03-14 16:08:23',82),
(22,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-14 16:11:28',82),
(23,'DSA Lab 82',1,'Your Quiz 5 has been Submitted ','2022-03-14 16:11:28',82),
(24,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-14 16:15:01',82),
(25,'DSA Lab 82',1,'Your Quiz 5 has been Submitted ','2022-03-14 16:15:01',82),
(26,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-14 16:16:06',82),
(27,'DSA Lab 82',1,'Your Quiz 5 has been Submitted ','2022-03-14 16:16:06',82),
(28,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-14 16:19:19',82),
(29,'DSA Lab 82',1,'Your Quiz 5 has been Submitted ','2022-03-14 16:19:19',82),
(30,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-14 16:19:43',82),
(31,'DSA Lab 82',1,'Your Quiz 5 has been Submitted ','2022-03-14 16:19:43',82),
(32,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-14 16:20:42',82),
(33,'DSA Lab 82',1,'Your Quiz 5 has been Submitted ','2022-03-14 16:20:42',82),
(34,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-14 16:23:24',82),
(35,'DSA Lab 82',1,'Your Quiz 5 has been Submitted ','2022-03-14 16:23:24',82),
(37,'BE Lab 79',5,'Assignment 1 Marks have veen uploaded.','2022-03-14 16:41:13',79),
(38,'BE Lab 79',2,'New Lecture File(s) has been uploaded in 4 October - 10 October','2022-03-15 12:06:44',79),
(39,'BE Lab 79',2,'New Lecture File(s) has been uploaded in 18 October - 24 October','2022-03-15 22:14:30',79),
(40,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-15 22:35:17',82),
(41,'DSA Lab 82',1,'Your Quiz 5 has been Submitted ','2022-03-15 22:35:18',82),
(42,'DSA Lab 82',1,'64 Submitted Quiz 5','2022-03-15 22:41:47',82),
(43,'DSA Lab 82',1,'Your Quiz 5 has been Submitted ','2022-03-15 22:41:47',82),
(44,'BE Lab 79',1,'Project Presentation has been assigned.','2022-03-15 22:45:41',79),
(45,'DSA Lab 82',1,'Assignment 1 has been assigned.','2022-03-15 23:26:57',82),
(46,'DSA Lab 82',1,'64 Submitted Assignment 1','2022-03-15 23:53:17',82),
(47,'DSA Lab 82',1,'Your Assignment 1 has been Submitted ','2022-03-15 23:53:19',82),
(48,'DSA Lab 82',2,'New Lecture File(s) has been uploaded in 27 September - 3 October','2022-03-16 00:17:57',82),
(51,'Academics',3,'DLD Lab 80 has been dropped','2022-03-17 18:54:25',0),
(52,'Academics',3,'DLD Lab 80 has been registered.','2022-03-17 19:00:13',80),
(53,'Academics',3,'DLD Lab 80 has been dropped','2022-03-17 19:01:37',NULL),
(54,'Academics',3,'DLD Lab 80 has been registered.','2022-03-17 19:37:57',80),
(55,'Academics',3,'DLD Lab 80 has been dropped.','2022-03-17 19:38:13',NULL),
(56,'Academics',3,'DLD Lab 80 has been registered.','2022-03-17 19:53:06',80),
(57,'Academics',3,'DLD Lab 80 has been dropped.','2022-03-17 19:57:37',NULL),
(58,'Academics',3,'DLD Lab 80 has been registered.','2022-03-17 19:57:45',80),
(59,'Academics',3,'DLD Lab 80 has been dropped.','2022-03-17 19:57:54',NULL),
(60,'Academics',3,'DLD Lab 80 has been registered.','2022-03-17 19:58:03',80),
(61,'Academics',3,'DLD Lab 80 has been dropped.','2022-03-17 19:58:36',NULL),
(62,'Academics',3,'DLD Lab 80 has been registered.','2022-03-17 19:59:01',80),
(63,'Academics',3,'DLD Lab 80 has been dropped.','2022-03-17 19:59:12',NULL),
(64,'Academics',3,'DLD Lab 80 has been registered.','2022-03-17 20:14:20',80),
(65,'Academics',3,'DLD Lab 80 has been dropped.','2022-03-17 20:14:25',NULL),
(66,'Academics',3,'DLD Lab 80 has been registered.','2022-03-17 20:14:29',80),
(67,'DLD Lab 80',4,'Your attendence of 27 September - 3 October has been marked.','2022-03-17 20:33:23',80),
(68,'DLD Lab 80',4,'Your attendence of 27 September - 3 October has been marked.','2022-03-17 20:34:03',80),
(69,'DLD Lab 80',4,'Your attendence of 27 September - 3 October has been marked.','2022-03-17 20:34:24',80),
(70,'DLD Lab 80',4,'Your attendence of 27 September - 3 October has been marked.','2022-03-17 20:34:40',80),
(71,'DLD Lab 80',4,'Your attendence of 4 October - 10 October has been marked.','2022-03-17 20:35:09',80),
(72,'DSA Lab 82',1,'Testing Assesment has been assigned.','2022-03-18 22:38:24',82),
(73,'DSA Lab 82',1,'64 Submitted Testing Assesment','2022-03-18 22:40:08',82),
(74,'DSA Lab 82',1,'Your Testing Assesment has been Submitted ','2022-03-18 22:40:08',82),
(75,'DSA Lab 82',1,'Quiz 9763 has been assigned.','2022-03-18 22:48:52',82),
(76,'DSA Lab 82',1,'64 Submitted Quiz 9763','2022-03-18 22:55:14',82),
(77,'DSA Lab 82',1,'Your Quiz 9763 has been Submitted ','2022-03-18 22:55:15',82),
(78,'DSA Lab 82',1,'Quiz 9763 has been assigned.','2022-03-18 22:56:13',82),
(79,'DSA Lab 82',1,'Quiz 43 has been assigned.','2022-03-18 23:01:48',82),
(80,'DSA Lab 82',1,'Quiz 23 has been assigned.','2022-03-18 23:03:27',82),
(81,'DSA Lab 82',1,'Quiz 2 has been assigned.','2022-03-18 23:11:14',82),
(82,'DSA Lab 82',1,'64 Submitted Quiz 2','2022-03-18 23:12:45',82),
(83,'DSA Lab 82',1,'Your Quiz 2 has been Submitted ','2022-03-18 23:12:45',82);

/*Table structure for table `Tbl_ParentMenu` */

DROP TABLE IF EXISTS `Tbl_ParentMenu`;

CREATE TABLE `Tbl_ParentMenu` (
  `ParentID` int NOT NULL AUTO_INCREMENT,
  `DisplayName` varchar(50) DEFAULT NULL,
  `Icon` text,
  PRIMARY KEY (`ParentID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_ParentMenu` */

insert  into `Tbl_ParentMenu`(`ParentID`,`DisplayName`,`Icon`) values 
(1,'Users','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <polygon points=\"0 0 24 0 24 24 0 24\" />\r\n                                <path\r\n                                    d=\"M12,11 C9.790861,11 8,9.209139 8,7 C8,4.790861 9.790861,3 12,3 C14.209139,3 16,4.790861 16,7 C16,9.209139 14.209139,11 12,11 Z\"\r\n                                    fill=\"#000000\" fill-rule=\"nonzero\" opacity=\"0.3\" />\r\n                                <path\r\n                                    d=\"M3.00065168,20.1992055 C3.38825852,15.4265159 7.26191235,13 11.9833413,13 C16.7712164,13 20.7048837,15.2931929 20.9979143,20.2 C21.0095879,20.3954741 20.9979143,21 20.2466999,21 C16.541124,21 11.0347247,21 3.72750223,21 C3.47671215,21 2.97953825,20.45918 3.00065168,20.1992055 Z\"\r\n                                    fill=\"#000000\" fill-rule=\"nonzero\" />\r\n                            </g>\r\n                        </svg>'),
(2,'Courses','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\" />\r\n                                <path\r\n                                    d=\"M5,3 L6,3 C6.55228475,3 7,3.44771525 7,4 L7,20 C7,20.5522847 6.55228475,21 6,21 L5,21 C4.44771525,21 4,20.5522847 4,20 L4,4 C4,3.44771525 4.44771525,3 5,3 Z M10,3 L11,3 C11.5522847,3 12,3.44771525 12,4 L12,20 C12,20.5522847 11.5522847,21 11,21 L10,21 C9.44771525,21 9,20.5522847 9,20 L9,4 C9,3.44771525 9.44771525,3 10,3 Z\"\r\n                                    fill=\"#000000\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\"\r\n                                    transform=\"translate(17.825568, 11.945519) rotate(-19.000000) translate(-17.825568, -11.945519) \"\r\n                                    x=\"16.3255682\" y=\"2.94551858\" width=\"3\" height=\"18\" rx=\"1\" />\r\n                            </g>\r\n                        </svg>'),
(3,'Programs','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\" />\r\n                                <path\r\n                                    d=\"M5,5 C5,4.44771525 5.44771525,4 6,4 L15.75,4 C15.9073787,4 16.0555728,4.07409708 16.15,4.2 L18.9,7.86666667 C18.9649111,7.95321475 19,8.05848156 19,8.16666667 L19,19 C19,19.5522847 18.5522847,20 18,20 L6,20 C5.44771525,20 5,19.5522847 5,19 L5,5 Z M7,6 L7,9 L9,9 L9,6 L7,6 Z M10,6 L10,9 L12,9 L12,6 L10,6 Z M13,6 L13,9 L15,9 L15,6 L13,6 Z\"\r\n                                    fill=\"#000000\" />\r\n                            </g>\r\n                        </svg>'),
(4,'User Registration','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\" />\r\n                                <rect fill=\"#000000\" x=\"4\" y=\"5\" width=\"16\" height=\"3\" rx=\"1.5\" />\r\n                                <path\r\n                                    d=\"M5.5,15 L18.5,15 C19.3284271,15 20,15.6715729 20,16.5 C20,17.3284271 19.3284271,18 18.5,18 L5.5,18 C4.67157288,18 4,17.3284271 4,16.5 C4,15.6715729 4.67157288,15 5.5,15 Z M5.5,10 L18.5,10 C19.3284271,10 20,10.6715729 20,11.5 C20,12.3284271 19.3284271,13 18.5,13 L5.5,13 C4.67157288,13 4,12.3284271 4,11.5 C4,10.6715729 4.67157288,10 5.5,10 Z\"\r\n                                    fill=\"#000000\" opacity=\"0.3\" />\r\n                            </g>\r\n                        </svg>'),
(5,'Marks','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <polygon points=\"0 0 24 0 24 24 0 24\" />\r\n                                <path\r\n                                    d=\"M5.85714286,2 L13.7364114,2 C14.0910962,2 14.4343066,2.12568431 14.7051108,2.35473959 L19.4686994,6.3839416 C19.8056532,6.66894833 20,7.08787823 20,7.52920201 L20,20.0833333 C20,21.8738751 19.9795521,22 18.1428571,22 L5.85714286,22 C4.02044787,22 4,21.8738751 4,20.0833333 L4,3.91666667 C4,2.12612489 4.02044787,2 5.85714286,2 Z\"\r\n                                    fill=\"#000000\" fill-rule=\"nonzero\" opacity=\"0.3\" />\r\n                                <path\r\n                                    d=\"M8.95128003,13.8153448 L10.9077535,13.8153448 L10.9077535,15.8230161 C10.9077535,16.0991584 11.1316112,16.3230161 11.4077535,16.3230161 L12.4310522,16.3230161 C12.7071946,16.3230161 12.9310522,16.0991584 12.9310522,15.8230161 L12.9310522,13.8153448 L14.8875257,13.8153448 C15.1636681,13.8153448 15.3875257,13.5914871 15.3875257,13.3153448 C15.3875257,13.1970331 15.345572,13.0825545 15.2691225,12.9922598 L12.3009997,9.48659872 C12.1225648,9.27584861 11.8070681,9.24965194 11.596318,9.42808682 C11.5752308,9.44594059 11.5556598,9.46551156 11.5378061,9.48659872 L8.56968321,12.9922598 C8.39124833,13.2030099 8.417445,13.5185067 8.62819511,13.6969416 C8.71848979,13.773391 8.8329684,13.8153448 8.95128003,13.8153448 Z\"\r\n                                    fill=\"#000000\" />\r\n                            </g>\r\n                        </svg>'),
(6,'Attendence','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\"\r\n                            height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n                            <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n                                <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\" />\r\n                                <path\r\n                                    d=\"M8,3 L8,3.5 C8,4.32842712 8.67157288,5 9.5,5 L14.5,5 C15.3284271,5 16,4.32842712 16,3.5 L16,3 L18,3 C19.1045695,3 20,3.8954305 20,5 L20,21 C20,22.1045695 19.1045695,23 18,23 L6,23 C4.8954305,23 4,22.1045695 4,21 L4,5 C4,3.8954305 4.8954305,3 6,3 L8,3 Z\"\r\n                                    fill=\"#000000\" opacity=\"0.3\" />\r\n                                <path\r\n                                    d=\"M11,2 C11,1.44771525 11.4477153,1 12,1 C12.5522847,1 13,1.44771525 13,2 L14.5,2 C14.7761424,2 15,2.22385763 15,2.5 L15,3.5 C15,3.77614237 14.7761424,4 14.5,4 L9.5,4 C9.22385763,4 9,3.77614237 9,3.5 L9,2.5 C9,2.22385763 9.22385763,2 9.5,2 L11,2 Z\"\r\n                                    fill=\"#000000\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"10\" y=\"9\" width=\"7\" height=\"2\" rx=\"1\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"7\" y=\"9\" width=\"2\" height=\"2\" rx=\"1\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"7\" y=\"13\" width=\"2\" height=\"2\" rx=\"1\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"10\" y=\"13\" width=\"7\" height=\"2\" rx=\"1\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"7\" y=\"17\" width=\"2\" height=\"2\" rx=\"1\" />\r\n                                <rect fill=\"#000000\" opacity=\"0.3\" x=\"10\" y=\"17\" width=\"7\" height=\"2\" rx=\"1\" />\r\n                            </g>\r\n                        </svg>'),
(7,'Messenger','<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"24px\" height=\"24px\" viewBox=\"0 0 24 24\" version=\"1.1\">\r\n    <g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\">\r\n        <rect x=\"0\" y=\"0\" width=\"24\" height=\"24\"/>\r\n        <polygon fill=\"#000000\" opacity=\"0.3\" points=\"5 15 3 21.5 9.5 19.5\"/>\r\n        <path d=\"M13.5,21 C8.25329488,21 4,16.7467051 4,11.5 C4,6.25329488 8.25329488,2 13.5,2 C18.7467051,2 23,6.25329488 23,11.5 C23,16.7467051 18.7467051,21 13.5,21 Z M8.5,13 C9.32842712,13 10,12.3284271 10,11.5 C10,10.6715729 9.32842712,10 8.5,10 C7.67157288,10 7,10.6715729 7,11.5 C7,12.3284271 7.67157288,13 8.5,13 Z M13.5,13 C14.3284271,13 15,12.3284271 15,11.5 C15,10.6715729 14.3284271,10 13.5,10 C12.6715729,10 12,10.6715729 12,11.5 C12,12.3284271 12.6715729,13 13.5,13 Z M18.5,13 C19.3284271,13 20,12.3284271 20,11.5 C20,10.6715729 19.3284271,10 18.5,10 C17.6715729,10 17,10.6715729 17,11.5 C17,12.3284271 17.6715729,13 18.5,13 Z\" fill=\"#000000\"/>\r\n    </g>\r\n</svg>');

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
(100,'Masood Arif',NULL,'masoodarif1313@gmail.com','1234567890332','R:36 sector 17/c','Karachi','Pakistan','/Upload/1234567890332.jpg','01/12/2022','male','03172945903','27/01/2022'),
(102,'Mohsin',NULL,'masoodarif1313@gmail.com','1111123421111','6','Karachi','Pakistan','/Upload/1111123421111.jpg','01-01-2014','male','03172945903','27/01/2022'),
(104,'Mohsin',NULL,'masoodarif1313@gmail.com','1134511341111','6','Karachi','Pakistan','/Upload/1134511341111.jpg','01-01-2014','male','03172945903','27/01/2022'),
(106,'Masood Arif',NULL,'masoodarif1313@gmail.com','1234567890122','6','Karachi','Pakistan','/Upload/1234567890122.jpg','12/28/2021','male','03172945903','28/01/2022');

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
) ENGINE=InnoDB AUTO_INCREMENT=1224 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_RoleMenu` */

insert  into `Tbl_RoleMenu`(`Id`,`Menu_ID`,`Role_ID`,`Check`) values 
(1080,27,1,''),
(1081,25,1,''),
(1082,2,1,'\0'),
(1083,3,1,'\0'),
(1084,4,1,''),
(1085,5,1,''),
(1086,6,1,''),
(1087,7,1,''),
(1088,8,1,''),
(1089,9,1,'\0'),
(1090,10,1,'\0'),
(1091,26,1,''),
(1092,11,1,''),
(1093,13,1,''),
(1094,14,1,''),
(1095,15,1,''),
(1096,16,1,''),
(1097,17,1,''),
(1098,18,1,''),
(1099,19,1,''),
(1100,20,1,''),
(1101,24,1,''),
(1102,12,1,''),
(1103,1,1,''),
(1104,27,2,''),
(1105,25,2,''),
(1106,2,2,''),
(1107,3,2,'\0'),
(1108,4,2,'\0'),
(1109,5,2,''),
(1110,6,2,''),
(1111,7,2,'\0'),
(1112,8,2,''),
(1113,9,2,'\0'),
(1114,10,2,''),
(1115,26,2,''),
(1116,11,2,'\0'),
(1117,13,2,'\0'),
(1118,14,2,'\0'),
(1119,15,2,'\0'),
(1120,16,2,'\0'),
(1121,17,2,'\0'),
(1122,18,2,''),
(1123,19,2,''),
(1124,20,2,'\0'),
(1125,24,2,''),
(1126,12,2,'\0'),
(1127,1,2,'\0'),
(1128,27,3,''),
(1129,25,3,''),
(1130,2,3,'\0'),
(1131,3,3,''),
(1132,4,3,'\0'),
(1133,5,3,''),
(1134,6,3,''),
(1135,7,3,'\0'),
(1136,8,3,''),
(1137,9,3,''),
(1138,10,3,'\0'),
(1139,26,3,''),
(1140,11,3,'\0'),
(1141,13,3,''),
(1142,14,3,'\0'),
(1143,15,3,'\0'),
(1144,16,3,'\0'),
(1145,17,3,'\0'),
(1146,18,3,''),
(1147,19,3,''),
(1148,20,3,'\0'),
(1149,24,3,''),
(1150,12,3,'\0'),
(1151,1,3,'\0'),
(1176,27,6,''),
(1177,25,6,''),
(1178,2,6,'\0'),
(1179,3,6,'\0'),
(1180,4,6,''),
(1181,5,6,'\0'),
(1182,6,6,''),
(1183,7,6,''),
(1184,8,6,''),
(1185,9,6,'\0'),
(1186,10,6,'\0'),
(1187,26,6,''),
(1188,11,6,'\0'),
(1189,13,6,''),
(1190,14,6,''),
(1191,15,6,'\0'),
(1192,16,6,'\0'),
(1193,17,6,'\0'),
(1194,18,6,'\0'),
(1195,19,6,''),
(1196,20,6,'\0'),
(1197,24,6,'\0'),
(1198,12,6,'\0'),
(1199,1,6,''),
(1200,27,4,''),
(1201,25,4,''),
(1202,2,4,'\0'),
(1203,3,4,'\0'),
(1204,4,4,'\0'),
(1205,5,4,'\0'),
(1206,6,4,'\0'),
(1207,7,4,'\0'),
(1208,8,4,''),
(1209,9,4,'\0'),
(1210,10,4,'\0'),
(1211,26,4,''),
(1212,11,4,''),
(1213,13,4,'\0'),
(1214,14,4,'\0'),
(1215,15,4,'\0'),
(1216,16,4,'\0'),
(1217,17,4,'\0'),
(1218,18,4,''),
(1219,19,4,'\0'),
(1220,20,4,'\0'),
(1221,24,4,'\0'),
(1222,12,4,''),
(1223,1,4,'\0');

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
(26,1,139);

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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=latin1;

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
(48,'793093',122,78,72,''),
(52,'518290',119,80,72,''),
(53,'793093',122,79,72,''),
(54,'793093',122,80,72,''),
(55,'525395',130,80,72,''),
(56,'525395',130,79,72,''),
(57,'525395',130,78,72,''),
(59,'518290',119,79,72,''),
(61,'student',64,79,72,''),
(62,'student',64,82,72,''),
(63,'44560',75,82,72,''),
(64,'518290',119,82,72,''),
(65,'24691',120,82,72,''),
(66,'183492',121,82,72,''),
(67,'408494',129,82,72,''),
(68,'Std29100',139,82,72,''),
(70,'44560',75,79,72,''),
(71,'24691',120,79,72,''),
(72,'408494',129,79,72,''),
(73,'341996',131,79,72,''),
(74,'Std29100',139,79,72,''),
(82,'student',64,80,72,'');

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
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Url` */

insert  into `Tbl_Url`(`Url_ID`,`Class_ID`,`Session_ID`,`DisplayName`,`Link`) values 
(107,79,196,'Github',NULL),
(108,79,195,'Youtube',NULL),
(110,79,195,'OneD',NULL),
(112,82,195,'Github','adsa'),
(113,79,196,'Github Testing 0.2','https://www.youtube.com/watch?v=j5g45avErRM'),
(114,79,200,'Youtube',NULL),
(115,79,197,'Youtube',NULL),
(116,79,196,'213 Youtube',NULL),
(117,79,196,'453 Github',NULL),
(118,79,197,'LMS',NULL);

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
(139,'Std29100','1050',3,100,'','27/01/2022'),
(142,'Emp4955','1050',4,55,'','27/01/2022'),
(143,'Emp5055','1050',6,55,'','27/01/2022'),
(145,'Emp50102','1050',2,102,'','27/01/2022'),
(147,'Emp36104','1050',2,104,'','27/01/2022'),
(150,'Emp58106','1050',2,106,'','28/01/2022');

/*Table structure for table `Tbl_Videos` */

DROP TABLE IF EXISTS `Tbl_Videos`;

CREATE TABLE `Tbl_Videos` (
  `VideoID` int NOT NULL AUTO_INCREMENT,
  `YTube_Video_ID` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `Class_Id` int DEFAULT NULL,
  `Session_ID` int DEFAULT NULL,
  PRIMARY KEY (`VideoID`),
  KEY `Class_Id` (`Class_Id`),
  KEY `Session_ID` (`Session_ID`),
  CONSTRAINT `Tbl_Videos_ibfk_1` FOREIGN KEY (`Class_Id`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Videos_ibfk_2` FOREIGN KEY (`Session_ID`) REFERENCES `Tbl_ClassSessions` (`Session_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Videos` */

insert  into `Tbl_Videos`(`VideoID`,`YTube_Video_ID`,`Class_Id`,`Session_ID`) values 
(1,'ixOfkBf4-OQ',82,195),
(8,'tirokjiZgn4',79,196),
(10,'kkW4oLiDR9I',79,199),
(11,'e5hsOgycysk',79,199),
(12,'',82,195);

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_to` int NOT NULL,
  `user_from` int NOT NULL,
  `body` text,
  `date` datetime NOT NULL,
  `isSeen` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_to` (`user_to`),
  KEY `user_from` (`user_from`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`user_to`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`user_from`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=latin1;

/*Data for the table `messages` */

insert  into `messages`(`id`,`user_to`,`user_from`,`body`,`date`,`isSeen`) values 
(1,64,132,'Hy how r u','2022-03-17 12:21:48',1),
(5,132,64,'I\'m fine you say?','2022-03-17 15:16:37',1),
(7,132,64,'Whats going on?','2022-03-19 01:07:53',1),
(8,64,132,'Nothing much just boring boring....','2022-03-19 01:09:04',1),
(9,64,132,'wht r u doing?','2022-03-19 01:43:04',1),
(10,64,132,'wht r u doing?\n','2022-03-19 01:43:06',1),
(11,64,132,'whst going on','2022-03-19 01:43:48',1),
(12,64,132,'hy','2022-03-19 01:44:31',1),
(13,64,132,'buys?','2022-03-19 01:44:46',1),
(14,64,132,'whst up?','2022-03-19 01:52:48',1),
(15,64,132,'whst up?\n','2022-03-19 01:52:54',1),
(16,119,132,'sadasd','2022-03-19 01:54:00',1),
(17,119,132,'I\'m admin President has called yout ommy morning.','2022-03-19 01:54:32',1),
(18,69,132,'Come to president office urgent','2022-03-19 02:00:06',1),
(19,69,132,' President has called you','2022-03-19 02:00:21',1),
(20,64,132,'still busy?','2022-03-19 02:03:21',1),
(23,69,132,'You r not answring','2022-03-19 14:52:44',1),
(26,69,132,' hy','2022-03-19 14:53:04',1),
(31,69,132,'answer please','2022-03-19 14:54:32',1),
(32,64,132,'hy','2022-03-19 14:55:21',1),
(33,64,132,' wstapp?','2022-03-19 14:55:28',1),
(34,69,132,' still seen?','2022-03-19 14:55:45',1),
(35,69,132,' still seen?','2022-03-19 14:55:45',1),
(36,69,132,' still seen?','2022-03-19 14:55:45',1),
(37,69,132,' seen','2022-03-19 14:55:51',1),
(38,69,132,' seen','2022-03-19 14:55:51',1),
(39,69,132,' seen','2022-03-19 14:55:51',1),
(40,64,132,' hy','2022-03-19 14:56:15',1),
(41,64,132,' hy','2022-03-19 14:56:15',1),
(42,64,132,' hy','2022-03-19 14:56:15',1),
(43,64,132,' hy','2022-03-19 14:56:15',1),
(44,64,132,' 12','2022-03-19 14:56:34',1),
(45,64,132,' 12','2022-03-19 14:56:34',1),
(46,64,132,' 12','2022-03-19 14:56:34',1),
(47,64,132,' 12','2022-03-19 14:56:34',1),
(48,150,132,'hy','2022-03-19 14:57:04',1),
(49,150,132,'my name is masood','2022-03-19 14:57:14',1),
(50,69,132,'my name is masood\n','2022-03-19 14:57:24',1),
(51,69,132,'my name is masood\n','2022-03-19 14:57:24',1),
(52,69,132,'your name\n\n','2022-03-19 14:57:38',1),
(53,69,132,'your name\n\n','2022-03-19 14:57:38',1),
(54,64,132,'your name\n\n\n','2022-03-19 14:57:47',1),
(55,64,132,'your name\n\n\n','2022-03-19 14:57:47',1),
(56,64,132,'your name\n\n\n','2022-03-19 14:57:47',1),
(57,64,132,'hy','2022-03-19 15:00:52',1),
(58,64,132,'hy','2022-03-19 15:00:52',1),
(59,76,132,'hy','2022-03-19 15:06:05',1),
(60,76,132,'hy','2022-03-19 15:06:54',1),
(61,76,132,'hy','2022-03-19 15:06:54',1),
(62,135,132,'hy','2022-03-19 15:11:37',1),
(63,135,132,'hy','2022-03-19 15:11:37',1),
(64,135,132,'hy','2022-03-19 15:11:37',1),
(65,69,132,' test','2022-03-19 15:11:54',1),
(66,69,132,' test','2022-03-19 15:11:54',1),
(67,69,132,' test','2022-03-19 15:11:54',1),
(68,69,132,' test','2022-03-19 15:11:54',1),
(69,69,132,'masood','2022-03-19 15:30:43',1),
(70,69,132,'masood','2022-03-19 15:30:43',1),
(71,69,132,'masood','2022-03-19 15:30:43',1),
(72,69,132,'masood','2022-03-19 15:30:43',1),
(73,76,132,'aaaa','2022-03-19 15:35:49',1),
(74,76,132,'aaa','2022-03-19 15:38:11',1),
(75,91,132,' fwfewf','2022-03-19 15:38:53',1),
(76,101,132,' jhds','2022-03-19 15:39:13',1),
(77,101,132,' jhds','2022-03-19 15:39:13',1),
(78,101,132,' jhds','2022-03-19 15:39:13',1),
(79,101,132,' jhds','2022-03-19 15:39:13',1),
(80,101,132,' fffffff','2022-03-19 15:39:28',1),
(81,147,132,'hello hi','2022-03-19 15:39:55',1),
(82,147,132,'hello hi','2022-03-19 15:39:55',1),
(83,147,132,'hello hi','2022-03-19 15:39:55',1),
(84,147,132,'hello hi','2022-03-19 15:39:55',1),
(85,147,132,'hello hi','2022-03-19 15:39:55',1),
(86,147,132,' hello r','2022-03-19 15:40:06',1),
(87,76,132,'hy 123','2022-03-19 15:43:06',1),
(88,76,132,' hy 24','2022-03-19 15:43:12',1),
(89,76,132,' hy 24','2022-03-19 15:43:12',1),
(90,76,132,'hy masood','2022-03-19 15:49:46',1),
(91,76,132,' 12345','2022-03-19 15:49:51',1),
(97,91,132,'hy\n\n','2022-03-19 15:52:19',1),
(98,64,122,'hy','2022-03-19 17:41:30',1),
(99,132,64,'hy how r you','2022-03-19 17:41:41',1),
(100,132,122,' fine u say','2022-03-19 17:41:52',1),
(101,69,64,'Asslam u Alikum sir\n','2022-03-19 18:26:29',1),
(102,64,69,'W slam','2022-03-19 18:26:37',1),
(103,132,64,' free ?\n','2022-03-19 18:26:47',1),
(104,132,139,'hy whstup?\n','2022-04-23 12:53:05',1),
(105,132,139,'hy whstup?\n\n','2022-04-23 12:53:05',1),
(106,64,132,'nope\n','2022-04-25 14:11:26',1),
(107,132,132,'hy\n','2022-04-25 21:32:13',1),
(108,69,132,'hy\n','2022-04-25 21:42:47',1),
(109,69,132,'masood','2022-04-25 22:27:11',1),
(110,145,132,' hy\n','2022-04-25 22:27:35',1),
(111,147,132,'er','2022-04-25 22:30:41',1),
(112,132,64,'free kub hoge?\n','2022-04-30 12:49:28',1),
(113,132,64,'free kub hoge?\n','2022-04-30 12:49:28',1),
(114,132,64,'?','2022-04-30 12:49:49',1),
(115,132,139,'reply please','2022-04-30 13:06:50',1),
(116,145,132,'hy','2022-04-30 13:15:09',0),
(117,69,132,'heloo','2022-04-30 13:15:28',0),
(118,119,132,'hello','2022-04-30 13:16:49',0),
(119,145,132,'sa','2022-04-30 13:23:01',0),
(120,150,132,'President is calling you','2022-04-30 13:26:00',0),
(121,147,132,'reply on time','2022-04-30 13:26:49',0),
(122,147,132,'hy','2022-04-30 13:35:05',0),
(123,64,132,'hy','2022-04-30 13:35:27',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
