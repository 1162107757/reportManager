/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.22 : Database - report_manager
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`report_manager` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `report_manager`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `userId` varchar(50) NOT NULL,
  `userCode` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `createTime` datetime NOT NULL DEFAULT '2018-09-10 10:00:00',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `admin` */

insert  into `admin`(`userId`,`userCode`,`password`,`createTime`) values ('148f6285-de4f-4252-ab76-818c403e8537','123456','e10adc3949ba59abbe56e057f20f883e','2019-06-05 19:54:34');

/*Table structure for table `assignment` */

DROP TABLE IF EXISTS `assignment`;

CREATE TABLE `assignment` (
  `assignmentId` varchar(40) NOT NULL,
  `assignmentName` varchar(40) NOT NULL,
  `gradeId` varchar(40) NOT NULL,
  `fileUrl` varchar(200) NOT NULL,
  `courseId` varchar(40) NOT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`assignmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `assignment` */

insert  into `assignment`(`assignmentId`,`assignmentName`,`gradeId`,`fileUrl`,`courseId`,`createTime`) values ('95f153ce-cfba-426d-bf8d-3f2e7a934be2','2019年春局域网管理作业（二）','b53c560a-143e-4261-96ed-4db222df80fd','http://47.100.175.30:8080/file/1560044253507.txt','0c558bb7-0cc4-46c0-9fbc-526489ad9ab1','2019-06-09 09:37:35'),('efd94723-62f0-4ff9-82ef-546a2c626184','2019年春局域网管理作业（一）','b53c560a-143e-4261-96ed-4db222df80fd','http://47.100.175.30:8080/file/1560043901227.docx','0c558bb7-0cc4-46c0-9fbc-526489ad9ab1','2019-06-09 09:31:45');

/*Table structure for table `assignment_detail` */

DROP TABLE IF EXISTS `assignment_detail`;

CREATE TABLE `assignment_detail` (
  `assignmentDetailId` varchar(40) NOT NULL,
  `assignmentId` varchar(40) NOT NULL,
  `studentId` varchar(40) NOT NULL,
  `fileUrl` varchar(200) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`assignmentDetailId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `assignment_detail` */

insert  into `assignment_detail`(`assignmentDetailId`,`assignmentId`,`studentId`,`fileUrl`,`score`,`createTime`) values ('589d5961-5d66-4b20-b497-db3e23a1eef3','efd94723-62f0-4ff9-82ef-546a2c626184','4ce36188-0835-415d-a1e2-9c7b1b1b2da2','http://47.100.175.30:8080/file/1560044436080.doc',80,'2019-06-09 09:40:37'),('e7a46577-068d-40b3-b418-253df35b5cf9','95f153ce-cfba-426d-bf8d-3f2e7a934be2','4ce36188-0835-415d-a1e2-9c7b1b1b2da2','http://47.100.175.30:8080/file/1560044506932.doc',80,'2019-06-09 09:41:47');

/*Table structure for table `course` */

DROP TABLE IF EXISTS `course`;

CREATE TABLE `course` (
  `courseId` varchar(40) NOT NULL,
  `courseName` varchar(40) NOT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`courseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `course` */

insert  into `course`(`courseId`,`courseName`,`createTime`) values ('0c558bb7-0cc4-46c0-9fbc-526489ad9ab1','局域网管理','2019-06-09 09:29:43'),('9d5c28b6-5d8e-4e53-bc34-414e5233a1b2','高等数学','2019-06-09 09:52:39'),('9db73740-6ce8-4e4b-b08a-104919b4dd32','java','2019-06-09 09:29:33'),('d15cde5d-1a7c-409b-91a5-47204e365532','大学英语','2019-06-09 13:18:18');

/*Table structure for table `employe` */

DROP TABLE IF EXISTS `employe`;

CREATE TABLE `employe` (
  `employeId` varchar(40) NOT NULL,
  `employeName` varchar(15) NOT NULL,
  `workNumber` varchar(15) NOT NULL,
  `password` varchar(40) NOT NULL,
  `createTime` datetime NOT NULL DEFAULT '2018-09-10 10:00:00',
  PRIMARY KEY (`employeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `employe` */

insert  into `employe`(`employeId`,`employeName`,`workNumber`,`password`,`createTime`) values ('9eeb3a42-e047-4ddf-b7da-14c4644d4ef3','刘德华','1001','e10adc3949ba59abbe56e057f20f883e','2019-06-09 09:51:14'),('ca083c1a-30d1-4d31-ae94-7a2cb911980a','马云','1000','6547436690a26a399603a7096e876a2d','2019-06-09 09:26:04');

/*Table structure for table `grade` */

DROP TABLE IF EXISTS `grade`;

CREATE TABLE `grade` (
  `gradeId` varchar(40) NOT NULL,
  `attrYear` varchar(4) NOT NULL,
  `gradeName` varchar(40) NOT NULL,
  `createTime` datetime NOT NULL DEFAULT '2018-09-10 10:00:00',
  PRIMARY KEY (`gradeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `grade` */

insert  into `grade`(`gradeId`,`attrYear`,`gradeName`,`createTime`) values ('0da8b1c2-d06b-49a3-b1de-a393335631c9','2015','计算机科学与技术二班','2019-06-09 13:18:46'),('b53c560a-143e-4261-96ed-4db222df80fd','2015','网路工程一班','2019-06-09 09:27:25'),('eb5e9629-71ec-48a8-a10c-2a2fb05f34eb','2015','计算机科学与技术一班','2019-06-09 09:51:43');

/*Table structure for table `labreport` */

DROP TABLE IF EXISTS `labreport`;

CREATE TABLE `labreport` (
  `labreportId` varchar(40) NOT NULL,
  `gradeId` varchar(40) NOT NULL,
  `labreportName` varchar(40) NOT NULL,
  `fileUrl` varchar(200) NOT NULL,
  `courseId` varchar(40) NOT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`labreportId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `labreport` */

insert  into `labreport`(`labreportId`,`gradeId`,`labreportName`,`fileUrl`,`courseId`,`createTime`) values ('0b31ba68-8a65-4fcb-98e7-08a72520fdde','b53c560a-143e-4261-96ed-4db222df80fd','2019年春局域网管理报告（一）','http://47.100.175.30:8080/file/1560044313227.docx','0c558bb7-0cc4-46c0-9fbc-526489ad9ab1','2019-06-09 09:38:34');

/*Table structure for table `labreport_detail` */

DROP TABLE IF EXISTS `labreport_detail`;

CREATE TABLE `labreport_detail` (
  `labreportDetailId` varchar(40) NOT NULL,
  `labreportId` varchar(40) NOT NULL,
  `studentId` varchar(40) NOT NULL,
  `fileUrl` varchar(200) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`labreportDetailId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `labreport_detail` */

/*Table structure for table `score` */

DROP TABLE IF EXISTS `score`;

CREATE TABLE `score` (
  `scoreId` varchar(40) NOT NULL,
  `studentId` varchar(40) NOT NULL,
  `addScore` int(11) NOT NULL DEFAULT '60',
  `subScore` int(11) NOT NULL DEFAULT '100',
  `courseId` varchar(40) NOT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`scoreId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `score` */

insert  into `score`(`scoreId`,`studentId`,`addScore`,`subScore`,`courseId`,`createTime`) values ('','',60,100,'','0000-00-00 00:00:00'),('098a1573-6005-4085-8549-a0228a1059a7','bd3e58d4-bbea-4db8-abc6-bd8c08134421',60,0,'138a522d-7099-470d-8652-3b7ff2fc2b97','2019-06-08 20:01:24'),('11b6518f-831b-4c3f-b1f6-a2d42298257c','7d46aae4-59ec-4ad6-813d-ea1de262b28b',100,100,'138a522d-7099-470d-8652-3b7ff2fc2b97','2019-06-08 20:01:28'),('1ea79601-fccc-4eac-9539-afed7a5dcae9','e548b9c4-21ca-41ee-a5ba-1309b9e9fbd5',60,100,'138a522d-7099-470d-8652-3b7ff2fc2b97','2019-06-08 20:01:24'),('3e563698-d52a-424a-8d9b-5c29fda50b69','03b44b10-df11-4c8f-836d-9729584f3ae8',60,100,'138a522d-7099-470d-8652-3b7ff2fc2b97','2019-06-08 19:55:07'),('54f50cbb-d866-4fec-acca-730c37d8e586','c3fd0372-1246-4aba-ba66-5f87e5971d5b',60,100,'138a522d-7099-470d-8652-3b7ff2fc2b97','2019-06-08 19:42:18'),('77122a88-b96f-41d2-b5cb-14af434dccec','4ce36188-0835-415d-a1e2-9c7b1b1b2da2',70,100,'9db73740-6ce8-4e4b-b08a-104919b4dd32','2019-06-09 10:42:14'),('80f7db40-a4ff-436b-95de-3cb96463d416','4b4afa2d-4728-404a-b228-ac4df795cf34',60,100,'138a522d-7099-470d-8652-3b7ff2fc2b97','2019-06-08 19:55:06'),('884690b0-37dd-4e16-a11c-538c7b102326','4ce36188-0835-415d-a1e2-9c7b1b1b2da2',60,90,'','2019-06-09 13:21:09'),('986eb982-6f4f-466b-9b37-fe7a7627f848','7014d57d-35e8-4646-ab3e-ca23f4013d52',60,100,'138a522d-7099-470d-8652-3b7ff2fc2b97','2019-06-08 20:01:27'),('a6548cfd-8bf7-42a7-a8c9-3120ca76f6a2','b5dfa004-8c1b-4827-8f99-b68f6b85f396',60,100,'0c558bb7-0cc4-46c0-9fbc-526489ad9ab1','2019-06-09 09:44:17'),('d9768458-bf7d-4fe1-a0c4-1d9c832a7ad4','ca4de357-f563-4fd7-bc17-6748e7778b9e',60,100,'138a522d-7099-470d-8652-3b7ff2fc2b97','2019-06-08 19:55:07'),('da3ee392-896e-44f4-a5b1-3f2615bdd902','86d30e15-a138-406d-b37f-60618574a348',80,100,'0c558bb7-0cc4-46c0-9fbc-526489ad9ab1','2019-06-09 09:44:17'),('e7a678b8-ec4a-4b69-80fd-e6af14aa77ff','de2cb233-e7a3-4b6a-979c-25e783f867d1',60,100,'138a522d-7099-470d-8652-3b7ff2fc2b97','2019-06-08 19:55:05'),('e8ee9ddf-1143-4f17-a7c2-f5b21b726393','4ce36188-0835-415d-a1e2-9c7b1b1b2da2',100,80,'0c558bb7-0cc4-46c0-9fbc-526489ad9ab1','2019-06-09 10:40:15'),('ee3bb0ab-6fd6-487b-b042-f20ed73bfe09','a0e151c2-c0d6-4368-8410-345a15968f33',60,100,'138a522d-7099-470d-8652-3b7ff2fc2b97','2019-06-08 20:01:24'),('ee79bf30-1147-432d-940c-adc2c9109084','6f2a08d0-d253-497a-a091-1c034d40c8c6',60,100,'138a522d-7099-470d-8652-3b7ff2fc2b97','2019-06-08 19:41:53');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `studentId` varchar(40) NOT NULL,
  `studentNumber` varchar(10) NOT NULL,
  `name` varchar(15) NOT NULL,
  `sex` int(11) NOT NULL DEFAULT '1',
  `gradeId` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `createTime` datetime NOT NULL DEFAULT '2018-09-10 10:00:00',
  PRIMARY KEY (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `student` */

insert  into `student`(`studentId`,`studentNumber`,`name`,`sex`,`gradeId`,`password`,`createTime`) values ('4ce36188-0835-415d-a1e2-9c7b1b1b2da2','1000','黄渤',1,'b53c560a-143e-4261-96ed-4db222df80fd','e10adc3949ba59abbe56e057f20f883e','2019-06-09 09:27:51'),('86d30e15-a138-406d-b37f-60618574a348','1002','王迅',1,'b53c560a-143e-4261-96ed-4db222df80fd','e10adc3949ba59abbe56e057f20f883e','2019-06-09 09:28:57'),('b5dfa004-8c1b-4827-8f99-b68f6b85f396','1001','黄磊',1,'b53c560a-143e-4261-96ed-4db222df80fd','e10adc3949ba59abbe56e057f20f883e','2019-06-09 09:28:44'),('d49663d9-7fe9-44ec-a564-879bdfddb301','1003','范冰冰',0,'b53c560a-143e-4261-96ed-4db222df80fd','e10adc3949ba59abbe56e057f20f883e','2019-06-09 09:29:13');

/*Table structure for table `teaching` */

DROP TABLE IF EXISTS `teaching`;

CREATE TABLE `teaching` (
  `teachingId` varchar(40) NOT NULL,
  `employeId` varchar(40) NOT NULL,
  `gradeId` varchar(40) NOT NULL,
  `courseId` varchar(40) NOT NULL,
  `classTime` datetime DEFAULT NULL,
  `credits` int(11) DEFAULT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`teachingId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `teaching` */

insert  into `teaching`(`teachingId`,`employeId`,`gradeId`,`courseId`,`classTime`,`credits`,`createTime`) values ('23e37ec7-535e-4069-9481-b589136cd228','ca083c1a-30d1-4d31-ae94-7a2cb911980a','b53c560a-143e-4261-96ed-4db222df80fd','0c558bb7-0cc4-46c0-9fbc-526489ad9ab1','2019-06-09 09:29:59',NULL,'2019-06-09 09:30:04'),('453a9067-9703-4213-87c8-293efdffec53','ca083c1a-30d1-4d31-ae94-7a2cb911980a','b53c560a-143e-4261-96ed-4db222df80fd','9db73740-6ce8-4e4b-b08a-104919b4dd32','2019-06-10 00:00:00',NULL,'2019-06-09 09:30:29'),('939da34f-7a89-415a-8f05-041ac6859521','9eeb3a42-e047-4ddf-b7da-14c4644d4ef3','b53c560a-143e-4261-96ed-4db222df80fd','0c558bb7-0cc4-46c0-9fbc-526489ad9ab1','2019-06-09 00:00:00',NULL,'2019-06-09 13:09:48'),('d16e85c3-d2e6-490c-8b08-0a80635b7799','9eeb3a42-e047-4ddf-b7da-14c4644d4ef3','b53c560a-143e-4261-96ed-4db222df80fd','9db73740-6ce8-4e4b-b08a-104919b4dd32','2019-06-09 00:00:00',NULL,'2019-06-09 13:17:57');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
