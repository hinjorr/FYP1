/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 5.5.62-0ubuntu0.14.04.1 : Database - sql6511285
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sql6511285` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `sql6511285`;

/*Table structure for table `Tbl_AssesmentSubmission` */

DROP TABLE IF EXISTS `Tbl_AssesmentSubmission`;

CREATE TABLE `Tbl_AssesmentSubmission` (
  `SubmissionId` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) DEFAULT NULL,
  `AssesmentID` int(11) DEFAULT NULL,
  `FilePath` varchar(300) DEFAULT NULL,
  `DisplayName` varchar(300) DEFAULT NULL,
  `Link` varchar(500) DEFAULT NULL,
  `SubmissionTime` datetime DEFAULT NULL,
  PRIMARY KEY (`SubmissionId`),
  KEY `UserID` (`UserID`),
  KEY `AssesmentID` (`AssesmentID`),
  CONSTRAINT `Tbl_AssesmentSubmission_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_AssesmentSubmission_ibfk_2` FOREIGN KEY (`AssesmentID`) REFERENCES `Tbl_Assesments` (`AssesmentId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_AssesmentSubmission` */

insert  into `Tbl_AssesmentSubmission`(`SubmissionId`,`UserID`,`AssesmentID`,`FilePath`,`DisplayName`,`Link`,`SubmissionTime`) values 
(16,64,58,'/Upload/student-Mohsin-Assignment 1-79.pdf','student-Mohsin-Assignment 1-79','https://www.dropbox.com/s/sf8adsgd140kyt8/student-Mohsin-Quiz%202%20Testing-79.pdf?dl=0','2022-02-07 14:39:26'),
(37,64,76,'/Assesments_Submission/DSA Lab 82/Assignment 1/student-Mohsin-Assignment 1-82.json','student-Mohsin-Assignment 1-82.json','https://www.dropbox.com/sh/qrtd2p9d31yeajr/AACys5n9Co5E2Ad1KG57ghYna?dl=0','2022-03-15 23:45:27'),
(40,64,82,'/Assesments_Submission/DSA Lab 82/Quiz 2/student-Mohsin-Quiz 2-82.json','student-Mohsin-Quiz 2-82.json','https://www.dropbox.com/s/d1swqk5j5xqm2e1/student-Mohsin-Quiz%202-82.json?dl=0','2022-03-18 23:11:55'),
(41,157,92,'/Assesments_Submission/C&AG 78/Assignment 1/Std8110-Muhammad Arsalan-Assignment 1-78.jpg','Std8110-Muhammad Arsalan-Assignment 1-78.jpg','https://www.dropbox.com/s/c0j0yee1tpav015/Std8110-Muhammad%20Arsalan-Assignment%201-78.jpg?dl=0','2022-06-18 23:37:52');

/*Table structure for table `Tbl_Assesments` */

DROP TABLE IF EXISTS `Tbl_Assesments`;

CREATE TABLE `Tbl_Assesments` (
  `AssesmentId` int(11) NOT NULL AUTO_INCREMENT,
  `Class_ID` int(11) DEFAULT NULL,
  `Session_ID` int(11) DEFAULT NULL,
  `AssesmentName` varchar(500) DEFAULT NULL,
  `Description` text,
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
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Assesments` */

insert  into `Tbl_Assesments`(`AssesmentId`,`Class_ID`,`Session_ID`,`AssesmentName`,`Description`,`Start`,`End`,`LateSubmission`,`Submission_Folder`,`FolderPath`) values 
(58,79,195,'Assignment 1',NULL,'2022-02-07 13:38:00','2022-02-07 23:33:00','',NULL,NULL),
(75,79,197,'Project Presentation',NULL,'2022-03-15 22:45:00','2022-04-09 22:45:00','\0',NULL,NULL),
(76,82,195,'Assignment 1',NULL,'2022-03-15 23:25:00','2022-04-08 23:25:00','\0','https://www.dropbox.com/sh/qrtd2p9d31yeajr/AACys5n9Co5E2Ad1KG57ghYna?dl=0','/Assesments_Submission/DSA Lab 82/Assignment 1'),
(82,82,196,'Quiz 2',NULL,'2022-03-18 23:09:00','2022-03-25 23:09:00','\0','https://www.dropbox.com/sh/wrplxg18hfpdgir/AADqf5GLvittyjLG1yL14I8Wa?dl=0','/Assesments_Submission/DSA Lab 82/Quiz 2'),
(92,78,196,'Assignment 1',NULL,'2022-06-18 23:34:00','2022-06-29 23:34:00','','https://www.dropbox.com/sh/w26dscn5693x7j3/AABm9dg3RGQ_fGEy3tz_YkZda?dl=0','/Assesments_Submission/C&AG 78/Assignment 1');

/*Table structure for table `Tbl_AssesmetnAttachments` */

DROP TABLE IF EXISTS `Tbl_AssesmetnAttachments`;

CREATE TABLE `Tbl_AssesmetnAttachments` (
  `File_ID` int(11) NOT NULL AUTO_INCREMENT,
  `AssesmentId` int(11) DEFAULT NULL,
  `DisplayName` varchar(400) DEFAULT NULL,
  `Path` varchar(500) DEFAULT NULL,
  `Link` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`File_ID`),
  KEY `Tbl_AssesmetnAttachments_ibfk_1` (`AssesmentId`),
  CONSTRAINT `Tbl_AssesmetnAttachments_ibfk_1` FOREIGN KEY (`AssesmentId`) REFERENCES `Tbl_Assesments` (`AssesmentId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_AssesmetnAttachments` */

insert  into `Tbl_AssesmetnAttachments`(`File_ID`,`AssesmentId`,`DisplayName`,`Path`,`Link`) values 
(198,58,'Screenshot from 2022-02-03 00-29-29-835757.png','/Assesment_Attachment/Screenshot from 2022-02-03 00-29-29-835757.png','https://www.dropbox.com/s/1i7b2un9v1m37pd/Screenshot%20from%202022-02-03%2000-29-29-835757.png?dl=0'),
(199,58,'image3.1-192441.jpg','/Assesment_Attachment/image3.1-192441.jpg','https://www.dropbox.com/s/27skdox0x6pm3xa/image3.1-192441.jpg?dl=0'),
(214,82,'adept-cosine-342316-e7c94bbd1a61-26849.json','/Assesment_Attachment/adept-cosine-342316-e7c94bbd1a61-26849.json','https://www.dropbox.com/s/1vonndoogd5n3lb/adept-cosine-342316-e7c94bbd1a61-26849.json?dl=0'),
(218,92,'Screenshot from 2022-05-23 13-56-45-728536.png','/Assesment_Attachment/Screenshot from 2022-05-23 13-56-45-728536.png','https://www.dropbox.com/s/i2hvpohyabp59cc/Screenshot%20from%202022-05-23%2013-56-45-728536.png?dl=0');

/*Table structure for table `Tbl_Attendence` */

DROP TABLE IF EXISTS `Tbl_Attendence`;

CREATE TABLE `Tbl_Attendence` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Class_ID` int(11) DEFAULT NULL,
  `Session_ID` int(11) DEFAULT NULL,
  `User_ID` int(11) DEFAULT NULL,
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
(157,50,180,119,'518290','\0','\0'),
(158,50,180,75,'44560','\0','\0'),
(159,50,180,64,'student','','\0'),
(162,50,180,120,'24691','\0',''),
(163,50,180,121,'183492','\0','\0'),
(165,50,178,119,'518290','\0',''),
(166,50,178,75,'44560','\0','\0'),
(167,50,178,64,'student','\0',''),
(170,50,178,120,'24691','\0',''),
(171,50,178,121,'183492','\0',''),
(173,50,175,119,'518290','',''),
(174,50,175,75,'44560','',''),
(175,50,175,64,'student','',''),
(178,50,175,120,'24691','\0','\0'),
(179,50,175,121,'183492','\0','\0'),
(181,46,175,64,'student','',''),
(182,48,175,64,'student','',''),
(183,48,176,64,'student','','\0'),
(184,50,177,119,'518290','','\0'),
(185,50,177,75,'44560','',''),
(186,50,177,64,'student','\0','\0'),
(189,50,177,120,'24691','',''),
(190,50,177,121,'183492','','\0'),
(192,50,179,119,'518290','\0','\0'),
(193,50,179,75,'44560','\0',''),
(194,50,179,64,'student','\0','\0'),
(197,50,179,120,'24691','\0',''),
(198,50,179,121,'183492','\0','\0'),
(233,79,195,119,'518290','\0','\0'),
(234,79,195,64,'student','',''),
(235,79,195,75,'44560','\0',''),
(236,79,195,120,'24691','\0','\0'),
(264,80,195,119,'518290','\0','\0'),
(267,80,195,64,'student','',''),
(268,80,196,119,'518290','','\0'),
(271,80,196,64,'student','','');

/*Table structure for table `Tbl_ClassSessions` */

DROP TABLE IF EXISTS `Tbl_ClassSessions`;

CREATE TABLE `Tbl_ClassSessions` (
  `Session_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Semester_ID` int(11) DEFAULT NULL,
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
  `Class_Id` int(11) NOT NULL AUTO_INCREMENT,
  `ClassStrength` int(11) DEFAULT NULL,
  `Enrolled_Std` int(11) DEFAULT '0',
  `Course_Id` int(11) DEFAULT NULL,
  `Semester_Id` int(11) DEFAULT NULL,
  `Program_Id` int(11) DEFAULT NULL,
  `Day_Id` int(11) DEFAULT NULL,
  `Time_Id` int(11) DEFAULT NULL,
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
(78,14,3,44,72,1,1,1,'',NULL),
(79,12,11,42,72,1,3,1,'',NULL),
(80,12,5,47,72,6,2,2,'',NULL),
(81,34,0,50,72,1,3,1,'',NULL),
(82,12,8,49,72,1,1,1,'',NULL);

/*Table structure for table `Tbl_CourseEligiblity` */

DROP TABLE IF EXISTS `Tbl_CourseEligiblity`;

CREATE TABLE `Tbl_CourseEligiblity` (
  `Elgibilty_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Class_Id` int(11) DEFAULT NULL,
  `Program_Id` int(11) DEFAULT NULL,
  `RqdCourse_Id` int(11) DEFAULT NULL,
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
  `CourseID` int(11) NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) DEFAULT NULL,
  `ShortName` varchar(50) DEFAULT NULL,
  `CrHr` int(11) DEFAULT NULL,
  `IsActive` bit(1) DEFAULT b'1',
  PRIMARY KEY (`CourseID`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Courses` */

insert  into `Tbl_Courses`(`CourseID`,`FullName`,`ShortName`,`CrHr`,`IsActive`) values 
(30,'Programming Fundamentals','PF_',3,''),
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
  `Day_Id` int(11) NOT NULL AUTO_INCREMENT,
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
  `Doc_Id` int(11) NOT NULL AUTO_INCREMENT,
  `SessionId` int(11) DEFAULT NULL,
  `CLassId` int(11) DEFAULT NULL,
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
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `From` varchar(50) DEFAULT NULL,
  `Host` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `Port` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_EmailConfiguration` */

/*Table structure for table `Tbl_FacultyCourseRegistration` */

DROP TABLE IF EXISTS `Tbl_FacultyCourseRegistration`;

CREATE TABLE `Tbl_FacultyCourseRegistration` (
  `FCR_ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) DEFAULT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Class_ID` int(11) DEFAULT NULL,
  `SemesterId` int(11) DEFAULT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  PRIMARY KEY (`FCR_ID`),
  KEY `Tbl_FacultyCourseRegistration_ibfk_1` (`UserId`),
  KEY `Tbl_FacultyCourseRegistration_ibfk_2` (`Class_ID`),
  KEY `SemesterId` (`SemesterId`),
  CONSTRAINT `Tbl_FacultyCourseRegistration_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_FacultyCourseRegistration_ibfk_2` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_FacultyCourseRegistration_ibfk_3` FOREIGN KEY (`SemesterId`) REFERENCES `Tbl_Semester` (`Semester_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_FacultyCourseRegistration` */

insert  into `Tbl_FacultyCourseRegistration`(`FCR_ID`,`UserId`,`Username`,`Class_ID`,`SemesterId`,`IsActive`) values 
(8,101,'863281',59,52,'\0'),
(16,69,'faculty',50,52,'\0'),
(17,69,'faculty',46,52,'\0'),
(18,69,'faculty',52,52,'\0'),
(22,101,'863281',77,52,'\0'),
(23,72,'495159',51,52,'\0'),
(26,101,'863281',80,NULL,''),
(27,69,'faculty',79,NULL,''),
(28,72,'495159',81,NULL,''),
(29,69,'faculty',82,NULL,''),
(30,158,'Emp52111',78,NULL,'');

/*Table structure for table `Tbl_Marks` */

DROP TABLE IF EXISTS `Tbl_Marks`;

CREATE TABLE `Tbl_Marks` (
  `Marks_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Class_Id` int(11) DEFAULT NULL,
  `AssesmentId` int(11) DEFAULT NULL,
  `User_Id` int(11) DEFAULT NULL,
  `Total_Marks` int(11) DEFAULT NULL,
  `Obtained_Makrs` int(11) DEFAULT '0',
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
(165,79,58,120,12,30),
(166,79,58,75,12,3),
(167,79,58,64,12,4),
(168,79,58,119,12,30);

/*Table structure for table `Tbl_Menu` */

DROP TABLE IF EXISTS `Tbl_Menu`;

CREATE TABLE `Tbl_Menu` (
  `Menu_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Controller` varchar(50) DEFAULT NULL,
  `Action` varchar(50) DEFAULT NULL,
  `DisplayLink` varchar(50) DEFAULT NULL,
  `DisplayName` varchar(50) DEFAULT NULL,
  `Parent` int(11) DEFAULT NULL,
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
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NotificationId` int(11) DEFAULT NULL,
  `To` int(11) DEFAULT NULL,
  `IsSeen` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `NotificationId` (`NotificationId`),
  KEY `To` (`To`),
  CONSTRAINT `Tbl_NotificaionTo_ibfk_1` FOREIGN KEY (`NotificationId`) REFERENCES `Tbl_Notifications` (`Notification_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_NotificaionTo_ibfk_2` FOREIGN KEY (`To`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_NotificaionTo` */

insert  into `Tbl_NotificaionTo`(`ID`,`NotificationId`,`To`,`IsSeen`) values 
(4,1,119,0),
(5,1,64,1),
(6,1,75,0),
(7,1,120,0),
(14,2,119,0),
(15,2,64,1),
(16,2,75,0),
(17,2,120,0),
(28,7,119,0),
(29,7,64,1),
(30,7,75,0),
(31,7,120,0),
(35,8,75,0),
(36,8,64,1),
(37,8,119,0),
(38,8,120,0),
(39,8,121,0),
(43,9,64,1),
(44,9,75,0),
(45,9,119,0),
(46,9,120,0),
(47,9,121,0),
(54,10,119,0),
(55,10,64,1),
(56,10,75,0),
(57,10,120,0),
(61,11,64,1),
(62,11,75,0),
(63,11,119,0),
(64,11,120,0),
(65,11,121,0),
(72,12,119,0),
(73,12,64,1),
(74,12,75,0),
(75,12,120,0),
(82,16,69,1),
(83,17,64,1),
(87,18,119,0),
(88,18,64,1),
(89,18,75,0),
(90,18,120,0),
(97,19,119,0),
(98,19,64,1),
(99,19,75,0),
(100,19,120,0),
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
(133,37,120,0),
(134,37,75,0),
(135,37,64,1),
(136,37,119,0),
(143,38,119,0),
(144,38,64,1),
(145,38,75,0),
(146,38,120,0),
(153,39,119,0),
(154,39,64,1),
(155,39,75,0),
(156,39,120,0),
(160,40,69,1),
(161,41,64,1),
(162,42,69,1),
(163,43,64,1),
(167,44,119,0),
(168,44,64,1),
(169,44,75,0),
(170,44,120,0),
(174,45,64,1),
(175,45,75,0),
(176,45,119,0),
(177,45,120,0),
(178,45,121,0),
(182,46,69,1),
(183,47,64,1),
(184,48,119,0),
(185,48,75,0),
(186,48,64,1),
(187,48,120,0),
(188,48,121,0),
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
(211,67,64,1),
(212,68,119,0),
(215,68,64,1),
(216,69,119,0),
(219,69,64,1),
(220,70,119,0),
(223,70,64,1),
(224,71,119,0),
(227,71,64,1),
(228,72,64,1),
(229,72,75,0),
(230,72,119,0),
(231,72,120,0),
(232,72,121,0),
(236,73,69,1),
(237,74,64,1),
(238,75,64,1),
(239,75,75,0),
(240,75,119,0),
(241,75,120,0),
(242,75,121,0),
(246,76,69,1),
(247,77,64,1),
(248,78,64,1),
(249,78,75,0),
(250,78,119,0),
(251,78,120,0),
(252,78,121,0),
(256,79,64,1),
(257,79,75,0),
(258,79,119,0),
(259,79,120,0),
(260,79,121,0),
(264,80,64,1),
(265,80,75,0),
(266,80,119,0),
(267,80,120,0),
(268,80,121,0),
(272,81,64,1),
(273,81,75,0),
(274,81,119,0),
(275,81,120,0),
(276,81,121,0),
(280,82,69,1),
(281,83,64,1),
(282,84,157,0),
(283,85,157,0),
(284,86,157,0),
(285,87,157,0),
(286,88,157,0),
(287,89,157,0),
(288,90,157,0),
(289,91,158,0),
(290,92,157,0),
(291,93,64,0),
(292,93,75,0),
(293,93,119,0),
(294,93,120,0),
(295,93,121,0),
(296,94,64,0),
(297,94,75,0),
(298,94,119,0),
(299,94,120,0),
(300,94,121,0),
(301,95,64,0),
(302,95,75,0),
(303,95,119,0),
(304,95,120,0),
(305,95,121,0),
(306,96,64,0),
(307,96,75,0),
(308,96,119,0),
(309,96,120,0),
(310,96,121,0);

/*Table structure for table `Tbl_NotificationType` */

DROP TABLE IF EXISTS `Tbl_NotificationType`;

CREATE TABLE `Tbl_NotificationType` (
  `Type_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(500) DEFAULT NULL,
  `Icon` text,
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
  `Notification_ID` int(11) NOT NULL AUTO_INCREMENT,
  `From` varchar(500) DEFAULT NULL,
  `Type_Id` int(11) DEFAULT NULL,
  `Message` varchar(500) DEFAULT NULL,
  `UploadedTime` datetime DEFAULT NULL,
  `ClassId` int(11) DEFAULT '0',
  PRIMARY KEY (`Notification_ID`),
  KEY `From` (`From`),
  KEY `Type_Id` (`Type_Id`),
  CONSTRAINT `Tbl_Notifications_ibfk_3` FOREIGN KEY (`Type_Id`) REFERENCES `Tbl_NotificationType` (`Type_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=latin1;

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
(83,'DSA Lab 82',1,'Your Quiz 2 has been Submitted ','2022-03-18 23:12:45',82),
(84,'Academics',3,'C&AG 78 has been registered.','2022-06-18 22:29:05',78),
(85,'Academics',3,'BE Lab 79 has been registered.','2022-06-18 22:29:14',79),
(86,'Academics',3,'DLD Lab 80 has been registered.','2022-06-18 22:29:25',80),
(87,'C&AG 78',2,'new reference Link has been added in 27 September - 3 October','2022-06-18 22:40:33',78),
(88,'C&AG 78',1,'Quiz 2 has been assigned.','2022-06-18 23:30:46',78),
(89,'C&AG 78',1,'Quiz 2 has been assigned.','2022-06-18 23:33:29',78),
(90,'C&AG 78',1,'Assignment 1 has been assigned.','2022-06-18 23:35:28',78),
(91,'C&AG 78',1,'157 Submitted Assignment 1','2022-06-18 23:37:57',78),
(92,'C&AG 78',1,'Your Assignment 1 has been Submitted ','2022-06-18 23:37:58',78),
(93,'DSA Lab 82',2,'new reference Link has been added in 4 October - 10 October','2022-06-19 19:03:15',82),
(94,'DSA Lab 82',2,'New Lecture video(s) has been uploaded in 22 November - 28 November','2022-06-21 23:14:18',82),
(95,'DSA Lab 82',2,'New Lecture video(s) has been uploaded in 25 October - 31 October','2022-06-21 23:22:33',82),
(96,'DSA Lab 82',2,'New Lecture video(s) has been uploaded in 25 October - 31 October','2022-06-21 23:24:09',82);

/*Table structure for table `Tbl_ParentMenu` */

DROP TABLE IF EXISTS `Tbl_ParentMenu`;

CREATE TABLE `Tbl_ParentMenu` (
  `ParentID` int(11) NOT NULL AUTO_INCREMENT,
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
  `ProfileID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `FatherName` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `NIC` varchar(50) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `Picture` text,
  `DoB` varchar(50) DEFAULT NULL,
  `Gender` varchar(50) DEFAULT NULL,
  `PhoneNumber` varchar(50) DEFAULT NULL,
  `Profile_Date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ProfileID`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Profile` */

insert  into `Tbl_Profile`(`ProfileID`,`Name`,`FatherName`,`Email`,`NIC`,`Address`,`City`,`Country`,`Picture`,`DoB`,`Gender`,`PhoneNumber`,`Profile_Date`) values 
(55,'Subhana Shahzad',NULL,'subhana@gmail.com','1111111111111','gulshan Iqba;','Karachi','Pakistan','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','01-01-2014','male','03332271986','10/11/2021'),
(56,'Masood','Arif','masoodarif1313@gmail.com','6666663232222','6','Karachi','Pakistan','/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QMdaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzOCA3OS4xNTk4MjQsIDIwMTYvMDkvMTQtMDE6MDk6MDEgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkEwNkJDODdBMUFENjExRTdBRUQwOUE3NzBENTIwOTBBIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkEwNkJDODc5MUFENjExRTdBRUQwOUE3NzBENTIwOTBBIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE3IFdpbmRvd3MiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0iMEQwNkJGRkIyQTk0NEM0NzVGN0QzQ0YwMkI3MzFCN0EiIHN0UmVmOmRvY3VtZW50SUQ9IjBEMDZCRkZCMkE5NDRDNDc1RjdEM0NGMDJCNzMxQjdBIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB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','01-01-2014','male','03172945903','12/11/2021'),
(59,'Mubashir',NULL,'masoodarif1313@gmail.com','3245323432321','6','Karachi','Pakistan','/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QMdaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzOCA3OS4xNTk4MjQsIDIwMTYvMDkvMTQtMDE6MDk6MDEgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjQ5REQwMEUzMUFENzExRTc5NThGOTAzNUY0QzRBMUQ3IiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjQ5REQwMEUyMUFENzExRTc5NThGOTAzNUY0QzRBMUQ3IiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE3IFdpbmRvd3MiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0iMTA3NTIxMUUzQTREMTJBMDc3RTEyN0E4QkJENDZCNTAiIHN0UmVmOmRvY3VtZW50SUQ9IjEwNzUyMTFFM0E0RDEyQTA3N0UxMjdBOEJCRDQ2QjUwIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB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','01-01-2014','male','03172945903','12/11/2021'),
(60,'Altaf',NULL,'masoodarif1313@gmail.com','3454325243643','6','Karachi','Pakistan','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','01-01-2014','male','03172945903','12/11/2021'),
(61,'Hussain',NULL,'masoodarif1313@gmail.com','6266663232212','6','Karachi','Pakistan','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','01-01-2014','male','03172945903','12/11/2021'),
(67,'Sumair',NULL,'masoodarif1313@gmail.com','1112345111111','6','Karachi','Pakistan','/9j/4QAoRXhpZgAASUkqAAgAAAABAJiCAgAEAAAAQ0MwAAAAAABDQzAAAAD/7AARRHVja3kAAQAEAAAAZAAA/+EFpmh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8APD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxMzggNzkuMTU5ODI0LCAyMDE2LzA5LzE0LTAxOjA5OjAxICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXBSaWdodHM9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9yaWdodHMvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiB4bWxuczpJcHRjNHhtcENvcmU9Imh0dHA6Ly9pcHRjLm9yZy9zdGQvSXB0YzR4bXBDb3JlLzEuMC94bWxucy8iIHhtcFJpZ2h0czpNYXJrZWQ9IkZhbHNlIiB4bXBSaWdodHM6V2ViU3RhdGVtZW50PSJ3d3cuc3Rva3BpYy5jb20vIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9IkJGNDg1RUE3QkVGODQyOTFEMkUwMzc4QkY5ODdGNzc3IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjYxMzhBNDRBM0Y5RDExRTdBNDU2ODYwRkY0RDMwNTFCIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjYxMzhBNDQ5M0Y5RDExRTdBNDU2ODYwRkY0RDMwNTFCIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBMaWdodHJvb20gNS41IChNYWNpbnRvc2gpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6M2IzNTFjZDgtYzc0ZC00NmU3LTg4ZDktM2U0NDdlOGU2OGM2IiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjNiMzUxY2Q4LWM3NGQtNDZlNy04OGQ5LTNlNDQ3ZThlNjhjNiIvPiA8ZGM6cmlnaHRzPiA8cmRmOkFsdD4gPHJkZjpsaSB4bWw6bGFuZz0ieC1kZWZhdWx0Ij5DQzA8L3JkZjpsaT4gPC9yZGY6QWx0PiA8L2RjOnJpZ2h0cz4gPGRjOmNyZWF0b3I+IDxyZGY6U2VxPiA8cmRmOmxpPkVkIEdyZWdvcnk8L3JkZjpsaT4gPC9yZGY6U2VxPiA8L2RjOmNyZWF0b3I+IDxJcHRjNHhtcENvcmU6Q3JlYXRvckNvbnRhY3RJbmZvIElwdGM0eG1wQ29yZTpDaVRlbFdvcms9IjAwNDQ3OTAwNDEwMDAwIiBJcHRjNHhtcENvcmU6Q2lFbWFpbFdvcms9ImVkQHN0b2twaWMuY29tIiBJcHRjNHhtcENvcmU6Q2lVcmxXb3JrPSJ3d3cuZWQtZ3JlZ29yeS5jb20iLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7/7QBQUGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAABccAVoAAxslRxwCAAACAAIcAnQAA0NDMAA4QklNBCUAAAAAABCvU4+AkC9bhdMzRO6Pbe9d/+4ADkFkb2JlAGTAAAAAAf/bAIQAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQICAgICAgICAgICAwMDAwMDAwMDAwEBAQEBAQECAQECAgIBAgIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMD/8AAEQgAZABkAwERAAIRAQMRAf/EAaIAAAAGAgMBAAAAAAAAAAAAAAcIBgUECQMKAgEACwEAAAYDAQEBAAAAAAAAAAAABgUEAwcCCAEJAAoLEAACAQMEAQMDAgMDAwIGCXUBAgMEEQUSBiEHEyIACDEUQTIjFQlRQhZhJDMXUnGBGGKRJUOhsfAmNHIKGcHRNSfhUzaC8ZKiRFRzRUY3R2MoVVZXGrLC0uLyZIN0k4Rlo7PD0+MpOGbzdSo5OkhJSlhZWmdoaWp2d3h5eoWGh4iJipSVlpeYmZqkpaanqKmqtLW2t7i5usTFxsfIycrU1dbX2Nna5OXm5+jp6vT19vf4+foRAAIBAwIEBAMFBAQEBgYFbQECAxEEIRIFMQYAIhNBUQcyYRRxCEKBI5EVUqFiFjMJsSTB0UNy8BfhgjQlklMYY0TxorImNRlUNkVkJwpzg5NGdMLS4vJVZXVWN4SFo7PD0+PzKRqUpLTE1OT0laW1xdXl9ShHV2Y4doaWprbG1ub2Z3eHl6e3x9fn90hYaHiImKi4yNjo+DlJWWl5iZmpucnZ6fkqOkpaanqKmqq6ytrq+v/aAAwDAQACEQMRAD8AsEqzeomFmFpZFPAAF5GJ0kc2B/HtN05qalPLptmtc8sP6/g2I5YH6nkfT3sZ49V4DqC7afpYErzYgDk/9HfUe9cT1vhw6a5WBHN9N7W/GoccH829+/w9a6Jp8jfmZ1L8dK6PbG4KqXOb+rIaeaHa1IZaEYmOtutFXZ6vq4IaOKjqF5jEU95G9JZPr7alnSIZ4nh8+noLd5z20C+p4dVx7j/mcdlZHMwU+w9rYOm/ildBQYOu3NnJ6DDR1dPrTIUeS2jkmzNLV6jE2mWDJwckspYaQEzXTaSUGPU1/wAAwelQs0UhZGyfSnSdrP5n3dipU5GLDdRQUeP0QZKglwuVqaqjybEkUmWozmo89jYZk9UEsAmhkjPDuykHX1NxpqNP7P8AV/LrYtrViVUtq+3/AGOh26J/mi9cdj5el2n25tuPqHP1bQ00G5qbJT5briprKmYQ0cFXW18cWZ21FknYCGqqFnoGkYI88RIPt6O/BoswAr5jh/nHTUlhIqeJGdQHEcD+zz6syhq6etpaevo6qnraOqi81HW0k0NVSVMV7GSmqYJJIZVDC11Yj8e140v3Dh0h4dYJTqDBlN/oPppJf8W5+hH+sPd+vdNE4Y3UhfpwCPz+SSPpb37r32dM045P9eATwfofVYW4/wBb+nv3XusGlvsbfn+Iab3H08F73te9vfutVzTo6tSzGon02P7so1EHmzkAAm/5/wALWFvaXzz0/qZRT/VTpvlW5vcLwVbgkD/C34974dVoGPbjptmUMQosGYgA3KgEkJqH0AAvz70D2561xNB/Pql/5wfzCd4df7k3P0v0NRz47dOCqDhdz9jOlHW5jG5maGnmiweyaGeGqo8dlYEqAKmrqYpqiKRkSBNZJCe5m8EENQfnk+fSu1s3uQXUdo+Xp6/5D69U4zyb03Vl6Vtx7lxPbObzklRk66qzLbxzO4KWhqoWeuWryWanSatIjhkpx9vDJBFU2VgpGkE81wgbU5IB9Tjo+tdvn0eHFpd8k4IPrn/iunvtCJ8JW4ij2ljtxJR1FFStU7ay+FpnxVLJJTUxOFyWHxE80AnnWJJZJmZnimjBXwsrH3ZJI8kMuR6169Pa3RbSyMF9AvTft3oHt7NyU2d29R11XEYBSwGjiStrsVSsGZsa3mkFY2JWQ8xSeTQVuTyLpZt1tov05HVM+uD/AJuja15T3O4AlhiLgjgBkf5es9R1RurD0VV/GtnzvmKiomjx2BkpExn2UjxN/EKikIeOaaHIatQpow8Ba91H6RSO+gcltSmp4g16fl2K+tgBJGyPT4SKf8XXo2PxP+XW7fj3ubF9ddt4+pPUO5q/HYenzn3E5x/XGSeb7SHK1SyIEpMfVBlWriLIg06/SF5NrS90UWoMZPnx+3oN7ntclPFC6X/kfkfQn+fV9jNGyCWGWKogljjlp6mnkSanqKaZFmp6umnjLJNS1MTq6MCQyMCPr7PgQRUZHQaIINDg9N8/0JIv+STxY8H6fg397690yTKPWQALmwBvcWNuLfkH6n8/63v3XuuNn+x06Rf73/G3/Af66r/05/31vfuvdHQqipqJfqR5ZA11IBPkb9Q+gJI+n+x9piFzUdXNOPUGT62C3JIvf8X5FzyOLf7z719nXiKevUCRf6AsVIstieb25/Nz9B/j72OvEAfb0Ujqz4e9Ybo7e7x7h3htqj3HjtzbxzmC2PhMxT01dQQk+A9jb4+3ESrVzbj3YZKTHLL5BTUlE5SxcERJzzvEp3D6CByiRUqUOS3E58qYx6/LHWR3tVy7GuyjdJ41aScEjWARo4AUOKHOf8ues038rnqmtzRqNm7yzO3Maapa1MBVyTpSY8w1UtZBR0tTSFailpKeaeUoUKzDWPWWAJIY+Y9wdfBZkbFCSOP2+Vehs3JezxN44jdGr+A4Ga0Fcj/N1Pqf5e+Foa8VG490RblxSKjwvVYqWStLqSsfkrK51mlbxCxq0MU87Es4J+rb75eRp5K5OCK0+2h9fn0YryxYTPpjBdPRqV+eV4U+X59CxherNobOp4KHCbcph9v+01StLE9TUBQCCJnjS/jtcA8hfyT7IrncJrly0rFmPz/1CvQrtNkt7OIBFCgD0yegr7n6A2z2LtetjkxNHR5bHHzrUigip3mRpUaRJ2eNnMSxuW1RNHIttSH2v2rcZbOYOtTGTkf4P9XD5dFG+7Rb7hatDJpWQCoamR8uqVvkj1fR7dwOZxOSxtZPi5a1cfU/dQtJIpkSSlhmrK2KJ5cxTK2lpG8JkihcFyQNXuVLC4E+lwQaiuP9WPTrH/mKyNmjW7g0DZ8+PCvr6/Lo6v8ALl3tmt2/GPGYDcNRPV5jqXeG5OsWqKiQzTHA4v7XK7UjlqH1NUmDD5Lwq1zZI1B+lgM9vk1wU/hYj7BxA6iHcYzHdGopqUH7T5n8+jvygG4HHDfk2Fufr9L/ANP8fa3pD00TC97lh/X/AHmy2vbm3Pv3XuuOkfYX/H32j6/2fBe1v6X9+690dCqUeae+oXmlF720gux5uBYE/wCvx7Tf4enqmvoKfZ01uv14Bt9WF/6Dg83ueb/09++zqmAatUnqDIzRq0l7shLqCb20gsoP5tce9ovcPn1SQnQxJ8j0Imx46SgweKpvSjLRpGFJkiIDBqiQqKdWlEktRUOSQBcn/E+8Z95mkm3SeST+0Mr1/wB6Pp1nRyvax2+yW0MA/TS3j9DxQHzxnj0PuCyc1HQF5xTJHoUwtJW7ugaoqEv4Veho8VloY6cKgCsWiLG5/wAfblpJIkNWIoeH9oM+WAGx+yvTd7bJJOBGWyc4iIp5mpZST8s0/l0lNxVNPVoJ6408slTKZdUablEs0isRoM1W0zuP6WjUhedPB9obqRj8YqSf6X+H/N+zo122MRtRKhVFMlMfkKf4TX16SH2OKyMyw+CUIJGJVgtUVsCBAytBT5NQfw0Yk+tyvHtu1pIwBDAA/b/hAPRhdSzxRnQylqfZ+fEj8j01122sdTTJoMc1XU008dRL/nKeOndHVKcTainn4B06eFHIB9nSxRoQR/a/6qf6vTookvZJo9JH6Q9fP1x6ceqjPmXsikqqaaiioDV/cSSXhqxCopfRV1OtJWKmkjUQtH5EZSzkDkNb2MeXpitQ5wQP9X29RVzhAkjfpgHiPmMVH+x0XL+WXi6zGbE76hmaVqY9x4r7VpGN/OmzokrCIbjwkr4g/wBS5sSTb3J20kmORvIsP8HWPu/IY7mNDx0H/j3n1Y7LGLaef8Lcmx/r+Lr/ALyPZr0SdNU45IsCebAA8/1Jufr/AMT7917rDYfZaeL/AH17fj/MabWve359+690dGrYGaYXPM8n54azte5/BFvaShr5jpSzDTQn/iumuU8sFIPGs345/p/W592GMdMmgOOHz6gyAa1AH6l1C1uQb2H0+n+PvYrUU416o4Gg14UPQQ1vyzz3XuU3FjcD8aO6+1tsbOnGJze/dnUGJp8M+4qWNpctjMBT5iuoKzOJh0KQvUQo8MkurS3p5g7ctut33i4Mc9uqNO9AzEHJ+QIArUZ6yz5f3ncYNhtI57K8kmS1TVpVcUUUqCaklaH51x0c/or5HbY752FRby2dg91bSFVk8hhsrtvd+Mn29uTDZ/EQiGeiy2KrkkJjqo3jlgkQmKeJtSN/Qvuw1k/hFVDDzRgykUwQRxr+RB6EG2eHusf1aFgo4rIhV1zkEYII8jkHj0E3efe/eezt5UezutPjpjN6Qy4yiymR35urf9JsLbONnr3MYx5nmgnmmracxFpPUscaOoIa/N4baGeMzXLrbp6FSWJPnggAf6qdau7y5tLgW+3RtckjJ1AJTyUYJJPn0icV2l8oaKr+/wC0vjXjqbacEc9ZX5bqvs7C9mZTbtPrU09e+3aqDF5SsoFQM0ppwZdVhFx6hX92wH9S2uBIa8Cun9hJPn69aG6bnG2m9tPBQimpX1V+0UB+2lc+R6HCg3LSZZUqogailyUcGVoKxI5Iv4ljshEkkVZontIlQR6XV/WjKVJuPaOZmjlKSDv4/b0ZwBJ4VkiIpT9hHRA/lNQU1dkN0zM4XG4HG5LJZiQUJnmpMfSxa6yqjpklDTRxx3uT+2h+nJFxRtbMIlbAqRSuB8uo/wB8Ou7ZFqX4UALGpNMDzr5dAF8Otg7n2r1XurdOc2jmdn43tHsPIdibVxucp1ocnLtKvxOIw2Kyc+MeQ11FDXVdHIyiVQUDorEMwHuQ+Xd2sLkvYwya7kd3A6WAw2huDaT8VOHUVe4fJPM2wrFvm6Wwi22UiPDqzxO1WVZ0GYmkAJQE5oRgjozMoYBuPqL6gpBJ502U8Hj2Keow6aZUABLC4Olv6EWH0B/Pv3XuselPs7auPvtVrer/AIDWtqte9+bf09+61Va6fPo5NWt55iGAJme4/Asxv/rN/vftKSfKnSjQujUDnpslT9RPptY2/BP0JX/Gw978/wCXVArFcDHUGRifzY8j/kGxPH0IAAsP6+9j5dVIFPt6Ln3Z8ad19pb4627BxW59zQ4nAR4umlwdBl8pTYrFLT5J6/NrSYbGPAhym7aMJStkJDMaSxdYiePcT3O52Vjvu4+LBHKDJRQV8wBXgMCvGnGta9ZIbVs247xyltAjvZ7WYQq5dWyVFQoyRWgpQk8AF4dGg2BVZLB1mZydbhc3g3yeSqUx23K/JvlpcRgbn7KD+LVAFXXz01TYQyTAMI+DyOQBeyLJMQq6IpHrQE9vyB40+3qdNq2tXi1GXxJIIArSsoXxXP4iowO3BpxPTR3ntbI94YnA4qCsyeOoqfMtPk8RSUJphmGp6KSlx+QizfmSqxlbQ5F2mksrk+ICIBjrQyW+QNG3h6ij5Xhq+Z+Xl69EX7rMX1FvNIY/EiYRyg5iJ4UA4t5j+Z6QvT/xu7J6doNv023uw5ErMduLLV+5s5WDO5Gk7DwedqpKldu5zbeazVbitrybaEgjxldiFjnjhXxzeVDwfbnuNreQ+LDDHDOAACopn1P8Q+VPz6CWx7LcbYfpp7y6u4mJJEhBp8l9Ptr9o6NpuXEy1WLx84ETVtB+2jRgFXaRjI0XoCEqZLlWYcs359kFwfqFVj+Hgf8AV5dCbb0a1ncCoVv9X7fWnQSbewm2DufPVW64aU1O4JaLBL/G1jbF0q1byVVQKiZgtNT0c1NSM08k7+JQgAIvYsG5IjS2mBKu2kDOSc5p6AcerQbei3sl9bgGWH9QkcQBxpXzLEcM9E4wHftJ8h61sxtgbkrcZ1jnt7bE3PUZymwlFjqKkymPr3wVJtuqwqo2Zw1JX7egkjFWqVQaVHI+vsYcrRzwcyW8DvqYaiKUAVdDqVA9Dg5zUV6t7qWVsvtHvFxOsaSS/TOoqzM0qTxHWSxID0dlOntpUDpRzBSLk3BuAPwbfp/1rW9zJ1gz0zTj63vwCxbUCF+tz/U/7z7317rrQv2P1H/A76c6v+A176f62/x9+690cKpIE83/AC1kN/yAHJJ/I/4ke0pB9MdW6bZrWtcWsQvJHH5P+I/1/e/n14inTe5AuArfS1ravz9f6gA8+/DrTVofWnQ6bEanlpMKrStHTMphqPHeURzPIEcuAbuXUEFSNIJ/w9wHvStHv92sxIP1D/zNQfsoes0eT5oLnlDb3tgpf6KOn5ChHyNQenrJbOyWVqMhksfS1MkdZWVmNxIx8b1TzritH3EkiRAyR08cpsGZRcDVyB7LGtZJJBIgJFSABnh6/L+XQ1tdytrSxaCZlEjUZi3bSuFAPDNPL7OPT9taioK6OGKdZcTmoYqqKow+VgkjnqoaeSJpqqiiOgTpFLIo5IZAQfz7dMamnFX8wQR+Y6KJpZA5DUeA0IZSCAfQ+h6UTbWhmH3NQHSljjAEcrOal5C+kkpwAq3NiLn0/Tj28loJDreoHTEu6/TDwogvjE8aCgFP8Py+fSK36tLh6GOoonFkMTrG0gJkjZJGqGkRCAZUC3UDj25KihaJ8vnx416Q2907M0s1Ac4Hr5U6Kr2Psuh7Q603n1nlMzuKip+2KvGYHOSbTXGNn5drVEkdVn8XRT5NHoqahrKGIQVs9o5oad2EbB2J9p7gywSQtCCZK4xWnzpwr8j0Y8vyLJcSyuqskZ1EMxUEjgCRmlfTpKbioOvNl4Gj636r27idt7bw7UIraTD01FT44VeJoo8bBEtVSRLJmsnL4jNWVszOXlfxqSqn3KfJ/L8tk53W8DLM60RW+IAjLt82HAeQJ4dQX7ve4ab1F/VPbJVntkn8S4mT+zZlJZLeLyMcTGrFcFgBVqE9BpKLrxa4Jv8AQH/bn/efY+6gfpqlB/Nzxxfkj6f1sBweOOT7917r1h9hq9Pk++v+f+OP1/pfT+PfuvUHRwKwASzt/wA3ZLjgE3c2+oBIA+ntNnp1lAFRj7emuUkg2N7n0m/H+sfpYn8+/dVrXj1AlIDEn/WsCfzcDn+oH597610503YWG2HtzN5vP11JjMdgEWumyFfPHS0NOKudIIop55CANcsqFCoJYkC1/cMc62rLv0jgZdUb1rVaVp+R6yX9rN0VeWIIpDVI2kT7NL1ofyavSMx/c/Ye4Ztwf3Aw/ZcNBVJNT5vOUeCpoYYcHPSrNJuHB4yvyVJk6irdJNCeNBE0bhyNSqfYetbn6cVCucGppmlf20HUrS20l+Vfwy1qCCqmunUOFMGpPpUDpadO9jbfysuIqMZndybt3Hj6Gtw+KO+myWF3Dj8ZFUWyGJp8fnhFUR1SzQ2aaSSqmmKAmTTp9vyeDI40sfFPCp4eoH+qvSWXcI44WjljCAHuVVA7vVh6+vAeg6NxLuOFMajyeUeRklJkVkeGZ3InhIYWgMTW5J06jfm9vaqKNwug8R/h6Dl/dRFhKmFOKfID/V+XQabx1nGStVQpFJJUsacsQzszRF4FQEu0dTMQdCOqqq2On6kWFuAKCta9JvrSxpWkY6Krk8zUVm1sjUIBT0Od3PHT49YyWlkoMJSy/dTvKvOqrr5CrGNisiRjkr9RfyhAv72d2FTDb19e5yAOPmB59AD3GvXh5TSOJiv1l8FwaHREpZhUUwzUr8ug1lAF0WyqFKhV4APF1UcAafcnVJyePUCAACgwOm2U24IKkHUvI4Ab6Af6kn8/j3rrfTXMeSfp9SVBP003Fri49+6911c/ZfT/AJStV7C9vBa9/p+ni3vfXvl0bqsLeea5t+9IT/hd25BN+Tf/AGB9psaunSXIGo1Xppna/FrchgD9CL8nj8AC/vfVOoTseeQb8g8rx/rfQf8AEe/YGevdI3cdXTY16apydLT5Hb+TdMFnMfV0sNZRmSsSUYyvqo50dPEst4CwA0PJGQQxHsDc8bS93ZDcIP7WIaW9dBOD+TY+QPUm+2e/rtu5Ntk5PhTMHj+UiihH5gAj1K0PRcOxcB0FtDL024d29TdnV8G49K4rJ9b/AN4ocP8AbOzTmU12HzNI4QW1mkkRJgbqRINJ9x9aXcpXw5mIZB5kDhw4g1PWXlj7hG029LeWyWalP1EjDlh86MpHz45yPToxWzNqdIZTb+LzEXXecy2Emjhqtt5bfFZmaCEzOCI63EYaoy9VV0aUzKVaSqIlXUNKC+oNPKbgGKMMB58P8Iz+w56JuYeaH3EAzQQQREYARdZ9AzU/l0PsW5RlMJ/CzkoKGnxqR/wuNqkLX1EIclaTIRPI8hSk0tG1xZhY8j1e10UUtuiq1Svr506jOa6hu2ahCkeXz6Avcm+NxdnZSfY+3JkixUckL7v3XShPtsDRlViGFwTR/tVm6crTxsiCJnjoIGMkn7uhPat2SEa/xE4H+U/L5efSWkk5EYro8z8/ID/KfLqJ3BurZ+yG6w2nkq6LA/3mq9w43aqTRyJQz1G3cTQVdZj5a7mCingxM4mUzsvljjkbV6G9iTkQq1/dqT+p4S0HmaOa09fs6DHuvbyjYNtdV/SW5kqfSsYp+3PSJqFdGkjkRlkRmR1f0MrI1irKRqBQjnjj3JXUFdNMrWuQBqPP1/s2t/sAb+9cOPXumuUi3NiL8ckE2tY3/qTx7317rh5B9ja3q+/ta/F/t72t7917o3lYWE9R6hZpnJ/pxI3Fh9Lfn8e03n1byp5dMs9tV9X+BI4H5IH9Tx731rz6b3lA1ccc3N29A/qT/Qf7b37z690RL5Z/IOPb+6+sPi1sHLwDuDu/fGz9v56SkSgyVZ1xsGrykWRyE9RT1S1FDSb13rDjjRYunqELUkDyVciW8N6SJHOpt5D2SVVvkpwT07DM1tMlzHUTRsGWnGq5HQ8bY3j2tsvD4uuHWGa3pjslCmYwm6tlik3PgjQ5iJWmjgx9dWUk+GymOqAIJ4J49cRRyrMpVvcF3FvapfSxM6xyROyFXqGBBIzxBxQg+desstv3DcYttieJDNBNGkivERRlYA44EUNRQ+YOegl7F+buwthb2ixee27vbE7uytHCuC2NuLb1fRLU5Op/beegqIy+KqqfQHMqiZ7kg8G4Bzte1RvH46tG0IrVlNf2gU/YR0G993uc3CwNHIsrDtDDSD69xOT08bRxfZ3bs1Tltw5eLY+2MjNJWVEFFG8+5aqExKI8b/ElmFBi8Y9NGqfawtLJHHZZHa+n3q8vIV/Tt1LFcajw+2nHr237XOwEl24UN+FckA+RPD+R6NVtLCYzbFLS4zF08lNi43kkgc6Vlnqowiy1lSCgCtLY+tQi6eEFhcFLSFjqY9xr/q/zdCK1tFJAFRQgf6v8vRe/k7T4fsHs/qHYEtLS5WTqufdHd2+vOxmpNu0eT2DuPrnr/aWZjXUGyvY2S3RUTGhbXKuLxklTIgj0sw49tNsubnem3MgixjouryZ+Okeunz+ZA6B/vJullactxbICrbhLJq0V+GNQasfTUTQeeCeqvfgr85tu5nZG3unO8d1LhN1bdtt3YXYm5Kp5MTvLb9NWzY7B7d3TnnMseP3RhII4qWnyFSwp8nShDLIk0bF5CzGzK+FDGn2V/wBX+DrHK3m8aMGnAD8+rVqiKVFSRlAhmVmgqYnjnpKkKLPLS1cTSU1VGL8tG7Lz9fdgQRUcOn+mqQ3BHF/6n6kgcm/5uPr73x+zr3XHn7C+rn+I2tY6v8xbV9b/AF4/1vfuvdG2rWvPUXuNM0nH9VMjH8H13b2nPVv8nSG3tvLZ/Xm3Knd/YO69vbE2nRt459xbrycGKxrTFtIpqQyFqzK1vkIUU9HFUTknhPeqgZJ691S/8lP5p1TlMhVdf/E37nGrSPLFuPvTcWJSLJxPHf8AyDrPa+SSdcZUO/8Ay98nE9Qtg0FOl9XtuSQk9vVK1wvAcf8AV69VfbC7K/0d96dcd17lyc2Un2j2ztbfe6c3lpqnKVtV5M3GM9uDKVTM9RkpIKKtmqnZi0rNHwDYL78jaSO2pr/q/wA/Wy1O4+X5fZ1tW7c3nldtpS0OGx9Nndtw1MtZ/DmqYIpZcFmah6v+JYnJTPHQ0MdSmSiqaczeChkglj9UcMv3FKG+ZeUot6kN9bOIdzoBqIqkgAwHAyCOAcVPkQepN5K5+k5cjG37jH9RsxaoVTSSEk9xiJwVPEo1BXKkE9O/bnTHUvb9LjcbuWkMmPrjLPi5a6llxWe2/l8ZMI6iWgWtjpqzF5rCV4UVMAK1EL6da+OSN5Iruo955auQl1E0JY0r8Ub/ACDDtYHyHH5dTrYycu832fj7ZOlyi5K8Joz80PepHrQj5noAe2u18V8c9nVeKwzydsb7osdKdv7YwFDVNI70sZByuejoUq5hTU6xs9QEGptDCwW59v7aZN1uNCgBSc0yT8lHmf5Dp7cYRs1ibiU4jUEFqKKDzY8APn5+XVWm4/5hXyU6jqY6Le+79mUu8MpkaXdmZ2BhsNFn+y8Ls6uolXC7UosayVO1ut85lYWaqpp8u81XjkCVlXTD9uklHUXKFrIyy3fiRwAAaAaM1Dksc0qMfLy6h7c/dSTbi0NgsNxfkk6yCVQEUUIMAkHuBOPWvTZRfzJ8Bkfj/wDKzL7f2ZF17vTFLBRdfmfdE+793bz3D2Ng83hs5vnd+Vq6WmilzGyaWmkjasVpaWmiaMJokv5JQ2uaC1smS3iWC3iSiIvzwPzrkt5+fUJbpvNzudxLeXztNeSNUsxqSfPyx6ADA8qdU4bUdKHbe3Kan8jPSYimhcPy8mqERsCJbg60vcOpL3N+D7Qqe0E+nSSMlQAlf8v7OHQwdOfKbu34obm/inXWUGb2HmK6Jt2dQ7pra7I7HytOWCiqw8Inap2flodZVKvGmIwsSHSVDo900cDDRTXOOPr0wZZ7eWobs9Dkf7Hy9D8urp+r/wCZV8cuwv4bTbwO5OmMjk/FHTTbxhizeyZqtgPNSnee3Y5P4TMrnSkeQoqdnWx1EXtcNmhB6MEuYpOFQvqeHzz6/Lo+f8bwH90P71/3j23/AHS8v3f97f7wYb+7P2X2+vzf3g++/hOnR6reXX+LX49+1JStRTp/UtNVe3orPyR/mrbC2kcntr45YZex91F6qB9/bsxuQxfX2EqQ7p/uF29UCkzO9quFvV5J/ssb+D5fp7aVSxx8Pr028wUECuofLqh/ufvHszt/cU+7eyN653e+8KyP7cZjK1KNjtt44jxpiNpYOlSHE7YpY4joX7SGJ5VNmZuWajJ+3188dNDxTR8kdBrgqvH4aGBKlZEkqXWSSoZDMjuHKxIFjOoMy/UsCp5PB9tUNc5HV1EcZo2D+3p43N9lX4jIo8cU+OkpKiN4gGKVgngdSwBtdNMhEen8/m/Puy1xTpuYhlOmmmnH5+XRou//AJLbu3/8P/hBT56vzlF2HTf6XNuZ3KYrONRUe8sB1JhtubQ2tvbJ0lE1E+NzkEeXhhaJppaSrELVXigqNZlUyovhgAEqHH+Dh889NSXUywIxA1kNX0NMA5/n5Gleii4D5Wd2dcVFPUbX7t39gZ1qcdlZvJvPL12MnrsZjJ8FimrMbmKyupZnocFKaCO0RkFKVp+EjiCJpreKb9J0DRMO5SKg+tQcf5vLrVtu9/ZzLcW0jR3KfCyMUYfIFSCB8q06XUvzN+RpqY9y4ntOXYlRFHXfwyHZeOpdutJTZOJY67yGspq2q8FRFAh8NVJI+qKN7OwHtPFZQW9Wt444/mqqpp9oA6Mb7mHfdz7dxuZnQHCtIzL68CaE/bUjorGZ3ZlvNWjH+Wsrs5W1OQyubrK+ojq67KZKeary2Vy+XnM+YyWQy9XK0s0xbyzyyMzPyT7UoF08AT8+iRtbOWY+fHNa/b0k6ufOHb249dWYKArikraTHkRwT065GGWKmraaPyT1dPU5N4SxlfR6L2Yj2ojxU1NKZ/1f4OtrU/DwGTnoctr4OSHDQz1EjKZqeF46TSBPFTkMZL6uPISQyRkelL6be7ggYA7en0UrVsEk1rX/AFfs6adw5eimqcfjMNQ1GRywyj0lSFASlXHOkaVsE9TUhW8yyKHUxoFUpySOPe6EjHDpiUhlAWplr+VPz/l09Y+RoKesoZYYqinDi6utoahZAZCkiqBIZ4JBrWRAGQgFT7YZpQ32fs6vCvYVceePl/s9KT7uo/uh/d/7uo/hP95Puf4R5pvs/uf4f4/ufsfN9r934/8AlJ8Wu/qv/Z92141Y1UpXp7VJp0ajprXpT5TzffZG1vH56n6av+O0n6P7Vvr9f9h+fbXfX5fLpUfF09vHzr/q4f7PSIqvF92318Wun12t/mNKW125tb6/nRa3u4pmvD8+P5deXxNa6fg8+H5/7HTy32Pji8ujXoa17ePTpbT4tHq81/8AV+q19X596WnVZdWsaK1/1cOuptP8KqfN/m/tpNV7eHX4jo1W9fi02/T6dX190Wmsafjr1Xs0Hx/ipj04efz6Fvs3+Gf7IX8VLfZf3t/08dz/AMI16fuv7mf6HtlfxXza/wDJ/wCFfx7w3/see2vn29JTUuuumvlXj01Np8FKU1U86VpTP5fy6IjSfwv7tL6P4p50t/E/tNWvSdX2Hn/yb7vTbw3/AG9X+F/e2+M8fz9Oi3y/Do/1fz6us+MP+yCfwzHf39/ul9t5sn5v9Juj+O2/uZmfuf8ASZr/ANx//HzaPtP4d6vt/tdfN/Z3D9F4K+Do1Vzq+Ly41xT06XQ+Ho7qeH5aqeh4/wCz5U6B7uX/AIbD+0k/0e/6Z/4//eTYv/Mufvf7o/3H/u9Wf6Qf4P8A6RP9wn8e/vNo+183Hi/4D8a/ZfL+7KfqU8bSPh1UrXPDFaen+Hp2bwdI1f2dfw0rwxT8+q6s7/c3+LZP+7X94f7j/wB4YPvv7w/wX+Kf3X/jFH/A/wCIfwX9jz+T7X7q358mn8e0q+DRvBrpr5+n/Ff7Oek8Onxv06+Hmur/AFU6Fttf3Ed7fa64vL9r4tPju3kvb/lH0ar3/wBp/FvdZdHn8fSlvj7aU/P/AFU6b8po8cerw+f1faefw/e+LxyeHx6f8p8Wq+ry+n6X/HtldWvzr/Lqo+Hu4eXDpLYT+Mfbj+MfaffeI+L+F69GjynRr1ejV+q+n9v25L4dMcerw/D+tSn+r8/XpXft/wAE/seb+Kf4/cf8Bf8Ar9/sf9h7bxT+lT/V/q9etfp+J/Q/ydf/2Q==','01-01-2014','male','03172945903','13/11/2021'),
(81,'Iqbal','arif','masoodarif1313@gmail.com','1234567800000',NULL,NULL,NULL,'/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QMdaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzOCA3OS4xNTk4MjQsIDIwMTYvMDkvMTQtMDE6MDk6MDEgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjg1ODMwRUJEM0Y5QzExRTc5MUUzQzE3MTdCRDk0MjVFIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjg1ODMwRUJDM0Y5QzExRTc5MUUzQzE3MTdCRDk0MjVFIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE3IFdpbmRvd3MiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0iQjgzQzIwNzFERjI4MkJDNjZFMTEzOUM3NjdENEUzNUMiIHN0UmVmOmRvY3VtZW50SUQ9IkI4M0MyMDcxREYyODJCQzY2RTExMzlDNzY3RDRFMzVDIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB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','12/15/2021','male','03172945903','06/12/2021'),
(90,'Habib','Muhammad Arif','masoodarif1313@gmail.com','4130783592999','Shahlatif town','Karachi','Pakistan','/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QMdaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzOCA3OS4xNTk4MjQsIDIwMTYvMDkvMTQtMDE6MDk6MDEgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjg1ODMwRUJEM0Y5QzExRTc5MUUzQzE3MTdCRDk0MjVFIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjg1ODMwRUJDM0Y5QzExRTc5MUUzQzE3MTdCRDk0MjVFIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE3IFdpbmRvd3MiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0iQjgzQzIwNzFERjI4MkJDNjZFMTEzOUM3NjdENEUzNUMiIHN0UmVmOmRvY3VtZW50SUQ9IkI4M0MyMDcxREYyODJCQzY2RTExMzlDNzY3RDRFMzVDIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB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','12/07/2021','male','03172945903','26/12/2021'),
(91,'James','Butt','jbutt@gmail.com','1234567890111','6649 N Blue Gum St','New Orleans','Orleans','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','01/11/2022','male','50426218927','02/01/2022'),
(92,'Paprocki','Lenna','art@venere.org','7011645148116','6649 N Blue Gum St','New Orleans','Orleans','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','01/11/2022','male','50426218927','02/01/2022'),
(110,'Muhammad Arsalan','Muhammad Arif','Arasalan.karachi28@gmail.com','4137865954548','Something in Shahrah e faisal','Karachi','Pakistan','/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QN7aHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzOCA3OS4xNTk4MjQsIDIwMTYvMDkvMTQtMDE6MDk6MDEgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9IkVFRkVGN0VERDAzNkE2MzA3RUY0NjE5ODE0MjIwNTJFIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjY0RkRGNzREM0Y5QzExRTc4NDczQTRCNTVGQzY2NUY4IiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjY0RkRGNzRDM0Y5QzExRTc4NDczQTRCNTVGQzY2NUY4IiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBMaWdodHJvb20gNS43IChNYWNpbnRvc2gpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6YzYzMDNhNjMtMWYwZC00MGYxLTgwYWYtM2Q4ZGVhZTJhNGNmIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOmM2MzAzYTYzLTFmMGQtNDBmMS04MGFmLTNkOGRlYWUyYTRjZiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9y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','06/22/2022','male','03042873764','18/06/2022'),
(111,'Masood Arif','Hussain','masoodarif1313@gmail.com','4798256464187','6','Karachi','Pakistan','/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QMdaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzOCA3OS4xNTk4MjQsIDIwMTYvMDkvMTQtMDE6MDk6MDEgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjBDMURCRTI4M0Y5RDExRTdCNzY3QzE0QzFCM0FBQTU3IiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjBDMURCRTI3M0Y5RDExRTdCNzY3QzE0QzFCM0FBQTU3IiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE3IFdpbmRvd3MiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0iOTBBNUZBNkRFQzJFQTY3RDFDMUE2NTNEQjFGMDYyQjUiIHN0UmVmOmRvY3VtZW50SUQ9IjkwQTVGQTZERUMyRUE2N0QxQzFBNjUzREIxRjA2MkI1Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+0ASFBob3Rvc2hvcCAzLjAAOEJJTQQEAAAAAAAPHAFaAAMbJUccAgAAAgACADhCSU0EJQAA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','06/14/2022','male','03172945903','18/06/2022'),
(112,'Masood Arif','Muhammad Arif','masoodarif1313@gmail.com','7865312331231','6','Karachi','Pakistan','/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QMdaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzOCA3OS4xNTk4MjQsIDIwMTYvMDkvMTQtMDE6MDk6MDEgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjQ5REQwMEUzMUFENzExRTc5NThGOTAzNUY0QzRBMUQ3IiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjQ5REQwMEUyMUFENzExRTc5NThGOTAzNUY0QzRBMUQ3IiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE3IFdpbmRvd3MiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0iMTA3NTIxMUUzQTREMTJBMDc3RTEyN0E4QkJENDZCNTAiIHN0UmVmOmRvY3VtZW50SUQ9IjEwNzUyMTFFM0E0RDEyQTA3N0UxMjdBOEJCRDQ2QjUwIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB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','06/17/2022','male','03172945903','20/06/2022'),
(114,'Masood Arif','Hussain','masoodarif1313@gmail.com','1233453643548','6','Karachi','Pakistan','/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QN7aHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzOCA3OS4xNTk4MjQsIDIwMTYvMDkvMTQtMDE6MDk6MDEgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9IkVFRkVGN0VERDAzNkE2MzA3RUY0NjE5ODE0MjIwNTJFIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjY0RkRGNzREM0Y5QzExRTc4NDczQTRCNTVGQzY2NUY4IiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjY0RkRGNzRDM0Y5QzExRTc4NDczQTRCNTVGQzY2NUY4IiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBMaWdodHJvb20gNS43IChNYWNpbnRvc2gpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6YzYzMDNhNjMtMWYwZC00MGYxLTgwYWYtM2Q4ZGVhZTJhNGNmIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOmM2MzAzYTYzLTFmMGQtNDBmMS04MGFmLTNkOGRlYWUyYTRjZiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9y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','06/25/2022','male','03172945903','20/06/2022');

/*Table structure for table `Tbl_ProgramSyllabus` */

DROP TABLE IF EXISTS `Tbl_ProgramSyllabus`;

CREATE TABLE `Tbl_ProgramSyllabus` (
  `Syllabus_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Program_Id` int(11) DEFAULT NULL,
  `Course_Id` int(11) DEFAULT NULL,
  `RqdCourse_Id` int(11) DEFAULT '0',
  `Required_CrHr` int(11) DEFAULT '0',
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
  `ProgramID` int(11) NOT NULL AUTO_INCREMENT,
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
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Menu_ID` int(11) DEFAULT NULL,
  `Role_ID` int(11) DEFAULT NULL,
  `Check` bit(1) DEFAULT b'0',
  PRIMARY KEY (`Id`),
  KEY `Menu_ID` (`Menu_ID`),
  KEY `Role_ID` (`Role_ID`),
  CONSTRAINT `Tbl_RoleMenu_ibfk_1` FOREIGN KEY (`Menu_ID`) REFERENCES `Tbl_Menu` (`Menu_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_RoleMenu_ibfk_2` FOREIGN KEY (`Role_ID`) REFERENCES `Tbl_Roles` (`RoleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1296 DEFAULT CHARSET=latin1;

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
(1224,1,7,''),
(1225,25,7,''),
(1226,24,7,'\0'),
(1227,20,7,'\0'),
(1228,19,7,'\0'),
(1229,18,7,'\0'),
(1230,17,7,'\0'),
(1231,16,7,'\0'),
(1232,15,7,''),
(1233,14,7,''),
(1234,13,7,''),
(1235,12,7,'\0'),
(1236,11,7,'\0'),
(1237,10,7,'\0'),
(1238,9,7,'\0'),
(1239,8,7,''),
(1240,7,7,''),
(1241,6,7,'\0'),
(1242,5,7,'\0'),
(1243,4,7,''),
(1244,3,7,'\0'),
(1245,2,7,'\0'),
(1246,26,7,''),
(1247,27,7,''),
(1272,27,8,''),
(1273,25,8,''),
(1274,2,8,'\0'),
(1275,3,8,'\0'),
(1276,4,8,'\0'),
(1277,5,8,'\0'),
(1278,6,8,'\0'),
(1279,7,8,'\0'),
(1280,8,8,''),
(1281,9,8,'\0'),
(1282,10,8,'\0'),
(1283,26,8,''),
(1284,11,8,''),
(1285,13,8,'\0'),
(1286,14,8,'\0'),
(1287,15,8,'\0'),
(1288,16,8,'\0'),
(1289,17,8,'\0'),
(1290,18,8,''),
(1291,19,8,'\0'),
(1292,20,8,'\0'),
(1293,24,8,'\0'),
(1294,12,8,''),
(1295,1,8,'\0');

/*Table structure for table `Tbl_Roles` */

DROP TABLE IF EXISTS `Tbl_Roles`;

CREATE TABLE `Tbl_Roles` (
  `RoleID` int(11) NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(50) NOT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Roles` */

insert  into `Tbl_Roles`(`RoleID`,`RoleName`) values 
(1,'Admin'),
(2,'Faculty'),
(3,'Student'),
(7,'Academics'),
(8,'Program Manager');

/*Table structure for table `Tbl_Semester` */

DROP TABLE IF EXISTS `Tbl_Semester`;

CREATE TABLE `Tbl_Semester` (
  `Semester_Id` int(11) NOT NULL AUTO_INCREMENT,
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
  `Student_Id` int(11) NOT NULL AUTO_INCREMENT,
  `ProgramID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Student_Id`),
  KEY `ProgramID` (`ProgramID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `Tbl_Student_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Student_ibfk_2` FOREIGN KEY (`ProgramID`) REFERENCES `Tbl_Programs` (`ProgramID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Student` */

insert  into `Tbl_Student`(`Student_Id`,`ProgramID`,`UserID`) values 
(15,1,64),
(17,1,75),
(19,1,119),
(20,1,120),
(21,1,121),
(28,1,157),
(29,1,159);

/*Table structure for table `Tbl_StudentCourseRegistration` */

DROP TABLE IF EXISTS `Tbl_StudentCourseRegistration`;

CREATE TABLE `Tbl_StudentCourseRegistration` (
  `SCR_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) DEFAULT NULL,
  `User_ID` int(11) NOT NULL,
  `Class_ID` int(11) NOT NULL,
  `SemesterId` int(11) DEFAULT NULL,
  `IsActive` bit(1) NOT NULL,
  PRIMARY KEY (`SCR_Id`),
  KEY `Tbl_StudentCourseRegistration_ibfk_2` (`User_ID`),
  KEY `Tbl_StudentCourseRegistration_ibfk_3` (`Class_ID`),
  KEY `SemesterId` (`SemesterId`),
  CONSTRAINT `Tbl_StudentCourseRegistration_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `Tbl_User` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_StudentCourseRegistration_ibfk_3` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_StudentCourseRegistration_ibfk_4` FOREIGN KEY (`SemesterId`) REFERENCES `Tbl_Semester` (`Semester_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=latin1;

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
(38,'student',64,48,52,'\0'),
(44,'44560',75,46,52,'\0'),
(52,'518290',119,80,72,''),
(59,'518290',119,79,72,''),
(61,'student',64,79,72,''),
(62,'student',64,82,72,''),
(63,'44560',75,82,72,''),
(64,'518290',119,82,72,''),
(65,'24691',120,82,72,''),
(66,'183492',121,82,72,''),
(70,'44560',75,79,72,''),
(71,'24691',120,79,72,''),
(82,'student',64,80,72,''),
(83,'Std8110',157,78,72,''),
(84,'Std8110',157,79,72,''),
(85,'Std8110',157,80,72,'');

/*Table structure for table `Tbl_Time` */

DROP TABLE IF EXISTS `Tbl_Time`;

CREATE TABLE `Tbl_Time` (
  `Time_Id` int(11) NOT NULL AUTO_INCREMENT,
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
  `Url_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Class_ID` int(11) DEFAULT NULL,
  `Session_ID` int(11) DEFAULT NULL,
  `DisplayName` varchar(200) DEFAULT NULL,
  `Link` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`Url_ID`),
  KEY `Class_ID` (`Class_ID`),
  KEY `Session_ID` (`Session_ID`),
  CONSTRAINT `Tbl_Url_ibfk_1` FOREIGN KEY (`Class_ID`) REFERENCES `Tbl_Classes` (`Class_Id`),
  CONSTRAINT `Tbl_Url_ibfk_2` FOREIGN KEY (`Session_ID`) REFERENCES `Tbl_ClassSessions` (`Session_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=latin1;

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
(118,79,197,'LMS',NULL),
(119,78,195,'NoteBook','outlook.com'),
(120,82,196,'Facebook',NULL);

/*Table structure for table `Tbl_User` */

DROP TABLE IF EXISTS `Tbl_User`;

CREATE TABLE `Tbl_User` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `RoleID` int(11) NOT NULL,
  `ProfileID` int(11) NOT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  `User_Date` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  KEY `ProfileID` (`ProfileID`),
  KEY `RoleID` (`RoleID`),
  CONSTRAINT `Tbl_User_ibfk_1` FOREIGN KEY (`ProfileID`) REFERENCES `Tbl_Profile` (`ProfileID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_User_ibfk_2` FOREIGN KEY (`RoleID`) REFERENCES `Tbl_Roles` (`RoleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_User` */

insert  into `Tbl_User`(`UserID`,`UserName`,`Password`,`RoleID`,`ProfileID`,`IsActive`,`User_Date`) values 
(64,'Subhana','1050',3,55,'','10/11/2021'),
(69,'Admin','1050',2,56,'','12/11/2021'),
(72,'Osama','1050',2,59,'\0','12/11/2021'),
(75,'Altaf','1050',3,60,'\0','12/11/2021'),
(76,'Faisal','1050',1,61,'','12/11/2021'),
(91,'Ahsan','1050',2,67,'','13/11/2021'),
(101,'Ayesha','1050',2,81,'','06/12/2021'),
(119,'Disha','1050',3,90,'','26/12/2021'),
(120,'Masood','1050',3,91,'','02/01/2022'),
(121,'Muzammil','1050',3,92,'','02/01/2022'),
(156,'Admin1655','1050',1,55,'','18/06/2022'),
(157,'Std8110','1050',3,110,'','18/06/2022'),
(158,'Emp52111','1050',2,111,'','18/06/2022'),
(159,'Std7112','1050',3,112,'','20/06/2022'),
(162,'Emp36114','1050',2,114,'','20/06/2022'),
(163,'Std4114','1050',3,114,'','20/06/2022');

/*Table structure for table `Tbl_Videos` */

DROP TABLE IF EXISTS `Tbl_Videos`;

CREATE TABLE `Tbl_Videos` (
  `VideoID` int(11) NOT NULL AUTO_INCREMENT,
  `YTube_Video_ID` varchar(500) DEFAULT NULL,
  `Class_Id` int(11) DEFAULT NULL,
  `Session_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`VideoID`),
  KEY `Class_Id` (`Class_Id`),
  KEY `Session_ID` (`Session_ID`),
  CONSTRAINT `Tbl_Videos_ibfk_1` FOREIGN KEY (`Class_Id`) REFERENCES `Tbl_Classes` (`Class_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Tbl_Videos_ibfk_2` FOREIGN KEY (`Session_ID`) REFERENCES `Tbl_ClassSessions` (`Session_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `Tbl_Videos` */

insert  into `Tbl_Videos`(`VideoID`,`YTube_Video_ID`,`Class_Id`,`Session_ID`) values 
(1,'ixOfkBf4-OQ',82,195),
(8,'tirokjiZgn4',79,196),
(10,'kkW4oLiDR9I',79,199),
(11,'e5hsOgycysk',79,199),
(12,'',82,195),
(13,'DoBcWZCbRhE',82,203),
(14,'qvBTRYCddVo',82,199),
(15,'Qrz64t4eQjQ',82,199);

/*Table structure for table `comments` */

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_body` text NOT NULL,
  `posted_by` varchar(60) NOT NULL,
  `posted_to` varchar(60) NOT NULL,
  `date_added` datetime NOT NULL,
  `removed` varchar(3) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `comments` */

insert  into `comments`(`id`,`post_body`,`posted_by`,`posted_to`,`date_added`,`removed`,`post_id`) values 
(1,'g faisal','Ahsan','Faisal','2021-12-26 19:18:36','no',67),
(2,'osama ','Admin','Admin','2021-12-27 06:24:39','no',69),
(3,'homw','Ahsan','Ahsan','2021-12-27 15:00:53','no',70),
(4,'ok bro','Subhana','Osama','2021-12-29 16:44:05','no',75),
(5,'hello','Subhana','Subhana','2022-01-03 14:09:10','no',80),
(6,'hahahah','Subhana','Subhana','2022-01-03 14:39:23','no',82),
(7,'hello subha','Osama','Subhana','2022-01-08 12:42:44','no',84),
(8,'asaassasas','Osama','Subhana','2022-01-08 12:47:16','no',84),
(9,'hhh','Osama','Subhana','2022-01-08 13:01:17','no',84),
(10,'hahahahaaa','Osama','Subhana','2022-01-08 13:13:16','no',83),
(11,'asas','Osama','Osama','2022-01-12 20:44:20','no',85),
(12,'ashahshas','Osama','Osama','2022-01-13 06:17:13','no',89),
(13,'ahahah','Ahsan','Ahsan','2022-03-15 17:15:24','no',91),
(14,'gagaga','Subhana','Osama','2022-04-19 13:08:52','no',89);

/*Table structure for table `friend_requests` */

DROP TABLE IF EXISTS `friend_requests`;

CREATE TABLE `friend_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_to` varchar(50) NOT NULL,
  `user_from` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `friend_requests` */

/*Table structure for table `likes` */

DROP TABLE IF EXISTS `likes`;

CREATE TABLE `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(60) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

/*Data for the table `likes` */

insert  into `likes`(`id`,`username`,`post_id`) values 
(1,'Ahsan',67),
(2,'Admin',69),
(3,'Ahsan',70),
(4,'Subhana',75),
(5,'Admin',78),
(6,'Faisal',78),
(7,'Ahsan',78),
(8,'Admin',75),
(9,'Subhana',80),
(10,'Admin',82),
(11,'Admin',81),
(12,'Subhana',74),
(33,'Osama',84),
(34,'Osama',83),
(35,'Osama',89),
(36,'Ahsan',91),
(37,'Subhana',91),
(38,'Subhana',89),
(39,'Subhana',82);

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_to` varchar(50) NOT NULL,
  `user_from` varchar(50) NOT NULL,
  `body` text NOT NULL,
  `date` datetime NOT NULL,
  `opened` varchar(3) NOT NULL,
  `viewed` varchar(3) NOT NULL,
  `deleted` varchar(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=latin1;

/*Data for the table `messages` */

insert  into `messages`(`id`,`user_to`,`user_from`,`body`,`date`,`opened`,`viewed`,`deleted`) values 
(1,'Ahsan','Faisal','hello ahsan','2022-01-01 20:18:32','yes','yes','no'),
(2,'Faisal','Ahsan','how are yoy faisa;','2022-01-01 20:19:07','yes','yes','no'),
(3,'Ahsan','Faisal','han ahsan','2022-01-02 14:01:44','yes','yes','no'),
(4,'Faisal','Ahsan','ok bro','2022-01-02 14:02:24','yes','yes','no'),
(5,'Ahsan','Faisal','hello bro\r\n','2022-01-02 14:42:58','yes','yes','no'),
(6,'Admin','Osama','hey admin','2022-01-02 14:51:49','yes','yes','no'),
(7,'Admin','Osama','hey ','2022-01-03 03:47:29','yes','yes','no'),
(8,'Osama','Altaf','hey osama','2022-01-03 04:20:17','yes','yes','no'),
(9,'Altaf','Osama','how are you\r\n','2022-01-03 04:20:38','yes','yes','no'),
(10,'Subhana','Osama','hey','2022-01-03 14:14:30','yes','yes','no'),
(11,'Osama','Subhana','masood','2022-01-03 14:15:02','yes','yes','no'),
(12,'Subhana','Osama','hey','2022-01-03 14:15:23','yes','yes','no'),
(13,'Subhana','Ahsan','hey','2022-01-03 14:45:30','yes','yes','no'),
(14,'Subhana','Osama','hey','2022-01-12 18:07:23','yes','yes','no'),
(15,'Subhana','Osama','hey','2022-01-12 18:11:48','yes','yes','no'),
(16,'Subhana','Osama','hey','2022-01-12 18:12:31','yes','yes','no'),
(17,'Subhana','Osama','hey','2022-01-12 18:13:48','yes','yes','no'),
(18,'Subhana','Osama','hey','2022-01-12 18:16:10','yes','yes','no'),
(19,'Subhana','Osama','hello ','2022-01-12 18:16:27','yes','yes','no'),
(20,'Subhana','Osama','han masood','2022-01-12 18:16:37','yes','yes','no'),
(21,'Subhana','Osama','han masood','2022-01-12 18:21:09','yes','yes','no'),
(22,'Ayesha','Osama','hello','2022-01-13 06:26:34','yes','yes','no'),
(23,'Ahsan','Ahsan','hi\r\n','2022-03-09 13:24:39','yes','yes','no'),
(24,'Ahsan','Subhana','hhh','2022-03-09 13:29:21','yes','yes','no'),
(25,'Subhana','Ahsan','hehehhehehehehehehheheheh ','2022-03-09 13:30:22','yes','yes','no'),
(26,'Ahsan','Subhana','hahahahha','2022-03-09 13:30:34','yes','yes','no'),
(27,'Subhana','Ahsan','hi','2022-03-09 13:32:16','yes','yes','no'),
(28,'Subhana','Ahsan','hi','2022-03-09 13:32:40','yes','yes','no'),
(29,'Subhana','Ahsan','hi','2022-03-09 13:32:45','yes','yes','no'),
(30,'Ahsan','Subhana','hahahahha','2022-03-09 13:33:07','yes','yes','no'),
(31,'Ahsan','Subhana','hahahahha','2022-03-09 13:33:14','yes','yes','no'),
(32,'Ahsan','Subhana','hahahahha','2022-03-09 13:43:16','yes','yes','no'),
(33,'Ahsan','Subhana','hahahahha','2022-03-09 13:44:45','yes','yes','no'),
(34,'Ahsan','Subhana','hahahahha','2022-03-09 13:44:51','yes','yes','no'),
(35,'Ahsan','Subhana','hahahahha','2022-03-09 13:44:56','yes','yes','no'),
(36,'Ahsan','Subhana','hahahahha','2022-03-09 13:45:01','yes','yes','no'),
(37,'Ahsan','Subhana','hahahahha','2022-03-09 13:45:06','yes','yes','no'),
(38,'Ahsan','Subhana','hahahahha','2022-03-09 13:45:12','yes','yes','no'),
(39,'Ahsan','Subhana','hahahahha','2022-03-09 13:45:18','yes','yes','no'),
(40,'Ahsan','Subhana','hahahahha','2022-03-09 13:45:24','yes','yes','no'),
(41,'Ahsan','Subhana','hahahahha','2022-03-09 13:45:30','yes','yes','no'),
(42,'Ahsan','Subhana','hahahahha','2022-03-09 13:45:36','yes','yes','no'),
(43,'Ahsan','Subhana','hahahahha','2022-03-09 13:45:42','yes','yes','no'),
(44,'Ahsan','Subhana','hahahahha','2022-03-09 13:45:48','yes','yes','no'),
(45,'Ahsan','Subhana','hahahahha','2022-03-09 13:45:54','yes','yes','no'),
(46,'Ahsan','Subhana','hahahahha','2022-03-09 13:46:00','yes','yes','no'),
(47,'Ahsan','Subhana','hahahahha','2022-03-09 13:46:06','yes','yes','no'),
(48,'Ahsan','Subhana','hahahahha','2022-03-09 13:46:12','yes','yes','no'),
(49,'Ahsan','Subhana','hahahahha','2022-03-09 13:46:18','yes','yes','no'),
(50,'Ahsan','Subhana','hahahahha','2022-03-09 13:46:24','yes','yes','no'),
(51,'Ahsan','Subhana','hahahahha','2022-03-09 13:46:30','yes','yes','no'),
(52,'Ahsan','Subhana','hahahahha','2022-03-09 13:46:36','yes','yes','no'),
(53,'Ahsan','Subhana','hahahahha','2022-03-09 13:46:42','yes','yes','no'),
(54,'Ahsan','Subhana','hahahahha','2022-03-09 13:46:48','yes','yes','no'),
(55,'Ahsan','Subhana','hahahahha','2022-03-09 13:46:54','yes','yes','no'),
(56,'Ahsan','Subhana','hahahahha','2022-03-09 13:47:00','yes','yes','no'),
(57,'Ahsan','Subhana','hahahahha','2022-03-09 13:47:06','yes','yes','no'),
(58,'Ahsan','Subhana','hahahahha','2022-03-09 13:47:12','yes','yes','no'),
(59,'Ahsan','Subhana','hahahahha','2022-03-09 13:47:18','yes','yes','no'),
(60,'Ahsan','Subhana','hahahahha','2022-03-09 13:47:24','yes','yes','no'),
(61,'Ahsan','Subhana','hahahahha','2022-03-09 13:47:30','yes','yes','no'),
(62,'Ahsan','Subhana','hahahahha','2022-03-09 13:47:36','yes','yes','no'),
(63,'Ahsan','Subhana','hahahahha','2022-03-09 13:47:42','yes','yes','no'),
(64,'Ahsan','Subhana','hahahahha','2022-03-09 13:47:48','yes','yes','no'),
(65,'Ahsan','Subhana','hahahahha','2022-03-09 13:47:54','yes','yes','no'),
(66,'Ahsan','Subhana','hahahahha','2022-03-09 13:48:00','yes','yes','no'),
(67,'Ahsan','Subhana','hahahahha','2022-03-09 13:48:06','yes','yes','no'),
(68,'Ahsan','Subhana','hahahahha','2022-03-09 13:48:12','yes','yes','no'),
(69,'Ahsan','Subhana','hahahahha','2022-03-09 13:48:18','yes','yes','no'),
(70,'Ahsan','Subhana','hahahahha','2022-03-09 13:48:24','yes','yes','no'),
(71,'Ahsan','Subhana','hahahahha','2022-03-09 13:48:30','yes','yes','no'),
(72,'Ahsan','Subhana','hahahahha','2022-03-09 13:48:36','yes','yes','no'),
(73,'Ahsan','Subhana','hahahahha','2022-03-09 13:48:41','yes','yes','no'),
(74,'Ahsan','Subhana','hahahahha','2022-03-09 13:48:47','yes','yes','no'),
(75,'Ahsan','Subhana','hahahahha','2022-03-09 13:48:52','yes','yes','no'),
(76,'Subhana','Ahsan','h','2022-03-11 06:48:33','yes','yes','no'),
(77,'Subhana','Ahsan','h','2022-03-11 06:48:38','yes','yes','no'),
(78,'Subhana','Ahsan','h','2022-03-11 06:48:45','yes','yes','no'),
(79,'Subhana','Ahsan','h','2022-03-11 06:48:51','yes','yes','no'),
(80,'Subhana','Ahsan','h','2022-03-11 06:48:57','yes','yes','no'),
(81,'Subhana','Ahsan','h','2022-03-11 06:49:03','yes','yes','no'),
(82,'Subhana','Ahsan','h','2022-03-11 06:49:09','yes','yes','no'),
(83,'Subhana','Ahsan','h','2022-03-11 06:49:15','yes','yes','no'),
(84,'Subhana','Ahsan','h','2022-03-11 06:49:21','yes','yes','no'),
(85,'Subhana','Ahsan','h','2022-03-11 06:49:27','yes','yes','no'),
(86,'Subhana','Ahsan','h','2022-03-11 06:49:33','yes','yes','no'),
(87,'Subhana','Ahsan','h','2022-03-11 06:49:39','yes','yes','no'),
(88,'Subhana','Ahsan','h','2022-03-11 06:49:45','yes','yes','no'),
(89,'Subhana','Ahsan','h','2022-03-11 06:49:51','yes','yes','no'),
(90,'Subhana','Ahsan','h','2022-03-11 06:49:57','yes','yes','no'),
(91,'Subhana','Ahsan','h','2022-03-11 06:50:03','yes','yes','no'),
(92,'Subhana','Ahsan','h','2022-03-11 06:50:09','yes','yes','no'),
(93,'Subhana','Ahsan','h','2022-03-11 06:50:15','yes','yes','no'),
(94,'Subhana','Ahsan','h','2022-03-11 06:50:21','yes','yes','no'),
(95,'Subhana','Ahsan','h','2022-03-11 06:50:27','yes','yes','no'),
(96,'Subhana','Ahsan','h','2022-03-11 06:50:33','yes','yes','no'),
(97,'Subhana','Ahsan','h','2022-03-11 06:50:39','yes','yes','no'),
(98,'Subhana','Ahsan','h','2022-03-11 06:50:45','yes','yes','no'),
(99,'Subhana','Ahsan','h','2022-03-11 06:50:51','yes','yes','no'),
(100,'Subhana','Ahsan','h','2022-03-11 06:50:57','yes','yes','no'),
(101,'Subhana','Ahsan','h','2022-03-11 06:51:03','yes','yes','no'),
(102,'Subhana','Ahsan','h','2022-03-11 06:51:09','yes','yes','no'),
(103,'Subhana','Ahsan','h','2022-03-11 06:51:15','yes','yes','no'),
(104,'Subhana','Ahsan','h','2022-03-11 06:51:21','yes','yes','no'),
(105,'Subhana','Ahsan','h','2022-03-11 06:51:27','yes','yes','no'),
(106,'Subhana','Ahsan','h','2022-03-11 06:51:33','yes','yes','no'),
(107,'Subhana','Ahsan','h','2022-03-11 06:51:39','yes','yes','no'),
(108,'Subhana','Ahsan','h','2022-03-11 06:51:45','yes','yes','no'),
(109,'Subhana','Ahsan','h','2022-03-11 06:51:51','yes','yes','no'),
(110,'Subhana','Ahsan','h','2022-03-11 06:51:57','yes','yes','no'),
(111,'Subhana','Ahsan','h','2022-03-11 06:52:03','yes','yes','no'),
(112,'Subhana','Ahsan','h','2022-03-11 06:52:09','yes','yes','no'),
(113,'Subhana','Ahsan','h','2022-03-11 06:52:15','yes','yes','no'),
(114,'Subhana','Ahsan','h','2022-03-11 06:52:21','yes','yes','no'),
(115,'Subhana','Ahsan','h','2022-03-11 06:52:27','yes','yes','no'),
(116,'Subhana','Ahsan','h','2022-03-11 06:52:33','yes','yes','no'),
(117,'Subhana','Ahsan','h','2022-03-11 06:52:39','yes','yes','no'),
(118,'Subhana','Ahsan','h','2022-03-11 06:52:45','yes','yes','no'),
(119,'Subhana','Ahsan','h','2022-03-11 06:52:50','yes','yes','no'),
(120,'Subhana','Ahsan','h','2022-03-11 06:52:55','yes','yes','no'),
(121,'Subhana','Ahsan','h','2022-03-11 06:53:01','yes','yes','no'),
(122,'Subhana','Ahsan','h','2022-03-11 06:53:07','yes','yes','no'),
(123,'Subhana','Ahsan','h','2022-03-11 06:53:13','yes','yes','no'),
(124,'Subhana','Ahsan','h','2022-03-11 06:53:19','yes','yes','no'),
(125,'Subhana','Ahsan','h','2022-03-11 06:53:25','yes','yes','no'),
(126,'Subhana','Ahsan','h','2022-03-11 06:53:30','yes','yes','no'),
(127,'Subhana','Ahsan','h','2022-03-11 06:53:36','yes','yes','no'),
(128,'Subhana','Ahsan','h','2022-03-11 06:53:42','yes','yes','no'),
(129,'Subhana','Ahsan','h','2022-03-11 06:53:48','yes','yes','no'),
(130,'Subhana','Ahsan','h','2022-03-11 06:53:54','yes','yes','no'),
(131,'Subhana','Ahsan','h','2022-03-11 06:54:00','yes','yes','no'),
(132,'Subhana','Ahsan','h','2022-03-11 06:54:21','yes','yes','no'),
(133,'Subhana','Ahsan','hahahah\r\n','2022-03-11 06:54:27','yes','yes','no'),
(134,'Ahsan','Subhana','hhahahahha','2022-03-11 06:54:41','yes','no','no'),
(135,'Subhana','Ahsan','jjhjhjhjh\r\n','2022-03-11 06:55:28','yes','yes','no'),
(136,'Subhana','Ahsan','aaaaa','2022-03-11 06:56:06','yes','yes','no'),
(137,'Subhana','Ahsan','hi','2022-03-11 06:56:44','yes','yes','no'),
(138,'Subhana','Ahsan','hi','2022-03-11 06:57:00','yes','yes','no'),
(139,'Subhana','Ahsan','hi','2022-03-11 06:57:16','yes','yes','no'),
(140,'Subhana','Ahsan','hi','2022-03-11 06:57:32','yes','yes','no'),
(141,'Subhana','Ahsan','hi','2022-03-11 06:57:48','yes','yes','no'),
(142,'Subhana','Ahsan','hi','2022-03-11 06:58:04','yes','yes','no'),
(143,'Subhana','Ahsan','hi','2022-03-11 06:58:20','yes','yes','no'),
(144,'Subhana','Ahsan','hi','2022-03-11 06:58:36','yes','yes','no'),
(145,'Subhana','Ahsan','hi','2022-03-11 06:58:52','yes','yes','no'),
(146,'Subhana','Ahsan','hi','2022-03-11 06:59:08','yes','yes','no'),
(147,'Subhana','Ahsan','hi','2022-03-11 06:59:24','yes','yes','no'),
(148,'Subhana','Ahsan','hi','2022-03-11 06:59:40','yes','yes','no'),
(149,'Subhana','Ahsan','hi','2022-03-11 06:59:56','yes','yes','no'),
(150,'Subhana','Ahsan','hi','2022-03-11 07:00:12','yes','yes','no'),
(151,'Subhana','Ahsan','hi','2022-03-11 07:00:27','yes','yes','no'),
(152,'Ahsan','Subhana','hahahah','2022-03-11 07:00:37','yes','no','no'),
(153,'Subhana','Ahsan','hahahah','2022-03-11 07:01:46','yes','yes','no'),
(154,'Ayesha','Subhana','testin 763782','2022-03-20 15:17:55','yes','yes','no'),
(155,'Ayesha','Subhana','agagag','2022-04-19 13:09:56','yes','yes','no'),
(156,'Subhana','Ahsan','DB updated?','2022-06-18 00:05:27','no','yes','no'),
(157,'Altaf','admin','Any Updates?','2022-06-18 00:11:13','no','yes','no'),
(158,'Osama','Altaf','hy osama','2022-06-17 22:51:04','no','yes','no'),
(159,'Faisal','admin','hy june 18','2022-06-18 20:53:09','yes','yes','no'),
(160,'Faisal','admin','hy june 18','2022-06-18 20:53:07','yes','yes','no'),
(161,'Disha','Faisal','hy how r u','2022-06-18 22:26:15','yes','yes','no'),
(162,'Emp52111','Std8110','Hy sir','2022-06-18 22:36:07','yes','yes','no'),
(163,'Std8110','Emp52111','hy i am form sociala ','2022-06-18 22:42:49','no','no','no'),
(164,'Faisal','Disha','DB integrated?','2022-06-22 00:06:17','yes','yes','no'),
(165,'Faisal','Disha',' ??','2022-06-22 00:08:13','yes','yes','no'),
(166,'Faisal','Disha',' ??','2022-06-22 00:12:59','yes','yes','no'),
(167,'Admin','Admin1655','hy ','2022-08-07 15:14:35','no','no','no');

/*Table structure for table `notifications` */

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_to` varchar(50) NOT NULL,
  `user_from` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `link` varchar(100) NOT NULL,
  `datetime` datetime NOT NULL,
  `opened` varchar(3) NOT NULL,
  `viewed` varchar(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

/*Data for the table `notifications` */

insert  into `notifications`(`id`,`user_to`,`user_from`,`message`,`link`,`datetime`,`opened`,`viewed`) values 
(1,'Faisal','Admin','Admin liked your post','post.php?id=78','2022-01-02 16:08:52','yes','yes'),
(2,'Faisal','Ahsan','Ahsan liked your post','post.php?id=79','2022-01-02 17:02:56','yes','yes'),
(3,'Faisal','Ahsan','Ahsan liked your post','post.php?id=78','2022-01-02 17:29:26','yes','yes'),
(4,'Osama','Admin','Admin liked your post','post.php?id=75','2022-01-03 03:48:29','yes','yes'),
(5,'Osama','Subhana','Subhana liked your post','post.php?id=82','2022-01-03 14:11:42','yes','yes'),
(6,'Subhana','Admin','Admin liked your post','post.php?id=82','2022-01-03 14:12:49','no','yes'),
(7,'Subhana','Admin','Admin liked your post','post.php?id=81','2022-01-03 14:12:54','yes','yes'),
(8,'Osama','Subhana','Subhana commented on your profile post','post.php?id=82','2022-01-03 14:39:23','yes','yes'),
(9,'Osama','Subhana','Subhana liked your post','post.php?id=74','2022-01-03 14:39:41','no','yes'),
(10,'Ahsan','Subhana','Subhana liked your post','post.php?id=84','2022-01-03 14:47:00','yes','yes'),
(11,'Subhana','Osama','Osama commented on your post','post.php?id=84','2022-01-08 12:42:45','yes','yes'),
(12,'Ahsan','Osama','Osama commented on your profile post','post.php?id=84','2022-01-08 12:42:45','no','yes'),
(13,'Subhana','Osama','Osama commented on your post','post.php?id=84','2022-01-08 12:47:16','yes','yes'),
(14,'Ahsan','Osama','Osama commented on your profile post','post.php?id=84','2022-01-08 12:47:16','no','yes'),
(15,'Subhana','Osama','Osama commented on your post','post.php?id=84','2022-01-08 13:01:17','yes','yes'),
(16,'Ahsan','Osama','Osama commented on your profile post','post.php?id=84','2022-01-08 13:01:17','no','yes'),
(17,'Subhana','Osama','Osama commented on your post','post.php?id=83','2022-01-08 13:13:16','no','yes'),
(18,'Subhana','Osama','Osama liked your post','post.php?id=84','2022-01-08 13:57:56','yes','yes'),
(19,'Subhana','Osama','Osama liked your post','post.php?id=84','2022-01-08 13:58:04','yes','yes'),
(20,'Subhana','Osama','Osama liked your post','post.php?id=83','2022-01-08 14:19:49','no','yes'),
(21,'Subhana','Osama','Osama liked your post','post.php?id=83','2022-01-08 14:19:51','no','yes'),
(22,'Subhana','Osama','Osama liked your post','post.php?id=83','2022-01-08 14:19:52','no','yes'),
(23,'Subhana','Osama','Osama liked your post','post.php?id=83','2022-01-08 14:30:14','no','yes'),
(24,'Subhana','Osama','Osama liked your post','post.php?id=83','2022-01-08 14:31:46','no','yes'),
(25,'Subhana','Osama','Osama liked your post','post.php?id=83','2022-01-08 14:37:26','no','yes'),
(26,'Subhana','Osama','Osama liked your post','post.php?id=83','2022-01-08 14:42:42','no','yes'),
(27,'Subhana','Osama','Osama liked your post','post.php?id=83','2022-01-08 14:42:45','no','yes'),
(28,'Subhana','Osama','Osama liked your post','post.php?id=83','2022-01-08 14:44:00','no','yes'),
(29,'Subhana','Osama','Osama liked your post','post.php?id=83','2022-01-08 14:44:02','no','yes'),
(30,'Subhana','Osama','Osama liked your post','post.php?id=82','2022-01-08 14:44:07','no','yes'),
(31,'Subhana','Osama','Osama liked your post','post.php?id=82','2022-01-08 14:44:10','no','yes'),
(32,'Subhana','Osama','Osama liked your post','post.php?id=84','2022-01-08 14:46:36','yes','yes'),
(33,'Subhana','Osama','Osama liked your post','post.php?id=83','2022-01-12 18:29:28','no','yes'),
(34,'Ahsan','Osama','Osama posted on your profile','post.php?id=87','2022-01-12 21:07:29','yes','yes'),
(35,'Osama','Ayesha','Ayesha posted on your profile','post.php?id=90','2022-01-13 06:24:28','yes','yes'),
(36,'Ahsan','Subhana','Subhana liked your post','post.php?id=91','2022-03-30 21:02:38','no','no'),
(37,'Osama','Subhana','Subhana liked your post','post.php?id=89','2022-04-19 13:08:44','yes','yes'),
(38,'Osama','Subhana','Subhana commented on your post','post.php?id=89','2022-04-19 13:08:52','yes','yes');

/*Table structure for table `posts` */

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` text NOT NULL,
  `added_by` varchar(60) NOT NULL,
  `user_to` varchar(60) NOT NULL,
  `date_added` datetime NOT NULL,
  `user_closed` varchar(3) NOT NULL,
  `deleted` varchar(3) NOT NULL,
  `likes` int(11) NOT NULL,
  `image` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=latin1;

/*Data for the table `posts` */

insert  into `posts`(`id`,`body`,`added_by`,`user_to`,`date_added`,`user_closed`,`deleted`,`likes`,`image`) values 
(66,'osama','Admin','none','2021-12-26 12:19:57','no','no',0,''),
(67,'hi ahsan','Faisal','none','2021-12-26 19:17:59','no','no',1,''),
(68,'hy guyz','Osama','none','2021-12-26 19:36:31','no','no',0,''),
(69,'hello osama','Admin','none','2021-12-27 06:24:23','no','no',1,''),
(70,'osama good','Ahsan','none','2021-12-27 15:00:33','no','no',1,''),
(71,'masood aaaaa','Osama','Admin','2021-12-28 18:37:12','no','yes',0,''),
(72,'osama','Osama','none','2021-12-29 04:28:38','no','yes',0,''),
(73,'osama','Osama','none','2021-12-29 04:30:20','no','yes',0,''),
(74,'osama','Osama','none','2021-12-29 04:44:58','no','no',1,''),
(75,'osama','Osama','none','2021-12-29 16:43:38','no','no',2,''),
(76,'hello','Subhana','none','2021-12-29 17:14:33','no','yes',0,''),
(77,'osama','Subhana','none','2021-12-29 19:55:02','no','yes',0,''),
(78,'hhhhh','Faisal','none','2022-01-01 20:16:55','no','no',3,'assets/images/posts/61d0b6b72f112bb-16.png'),
(79,'hello faisal','Ahsan','Faisal','2022-01-02 17:02:56','no','no',0,''),
(80,'hi','Subhana','none','2022-01-03 14:08:59','no','yes',1,'assets/images/posts/61d3037b27402bb-16.png'),
(81,'hi','Subhana','none','2022-01-03 14:09:29','no','yes',1,'assets/images/posts/61d303999655fbb-16.png'),
(82,'hahahahahahha','Subhana','Osama','2022-01-03 14:11:42','no','no',2,''),
(83,'hahahahah','Subhana','none','2022-01-03 14:38:15','no','no',1,'assets/images/posts/61d30a57bc415bb-9.jpg'),
(84,'hahahahah','Subhana','Ahsan','2022-01-03 14:47:00','no','yes',1,''),
(85,'hello kal fyp hai ','Osama','none','2022-01-12 17:59:14','no','no',0,''),
(86,'hi ','Osama','none','2022-01-12 18:02:01','no','no',0,''),
(87,'hey ahsan','Osama','Ahsan','2022-01-12 21:07:29','no','no',0,''),
(88,'osama','Ahsan','none','2022-01-12 21:09:45','no','no',0,'assets/images/posts/61df4399cfc42t-12.jpg'),
(89,'faisal','Osama','none','2022-01-13 06:15:57','no','yes',2,'assets/images/posts/61dfc39d8283fuser-21.png'),
(90,'hahahah','Ayesha','Osama','2022-01-13 06:24:28','no','no',0,''),
(91,'afafafafaf','Ahsan','none','2022-03-15 17:14:48','no','no',2,''),
(92,'asdsadadsa','Subhana','none','2022-04-21 20:01:13','no','no',0,'assets/images/posts/6261a9f9008a7h-2.jpg'),
(93,'asdsadadsa','Subhana','none','2022-04-21 20:05:02','no','no',0,'assets/images/posts/6261aade8968bh-2.jpg'),
(94,'my car','Muzammil','none','2022-06-18 23:16:53','no','no',0,'assets/images/posts/62ae4ed502b45bb-9.jpg'),
(95,'my car','Muzammil','none','2022-06-18 23:16:55','no','no',0,'assets/images/posts/62ae4ed748ac5bb-9.jpg');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `num_posts` int(11) NOT NULL,
  `num_likes` int(11) NOT NULL,
  `user_closed` varchar(3) NOT NULL,
  `friend_array` text NOT NULL,
  `UserID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`num_posts`,`num_likes`,`user_closed`,`friend_array`,`UserID`) values 
(20,'Ahsan',0,0,'no',',Faisal,Altaf,',91),
(62,'Subhana',0,0,'no',',',64),
(63,'Admin',0,0,'no',',',69),
(65,'Altaf',0,0,'no',',',75),
(66,'Faisal',0,0,'no',',',76),
(67,'Ayesha',0,0,'no',',',101),
(68,'Disha',0,0,'no',',',119),
(69,'Masood',0,0,'no',',',120),
(70,'Muzammil',0,0,'no',',',121),
(71,'Osama',0,0,'no',',',72),
(72,'Admin1655',0,0,'no',',',156),
(73,'Std8110',0,0,'no',',',157),
(74,'Emp52111',0,0,'no',',',158),
(75,'Std7112',0,0,'no',',',159),
(76,'Emp36114',0,0,'no',',',120),
(77,'Muzammil',0,0,'no',',',162),
(78,'Std4114',0,0,'no',',',163);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
