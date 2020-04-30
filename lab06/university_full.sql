/* Anila Hoxha - LAB 06 */

CREATE DATABASE IF NOT EXISTS `university`;
USE `university`;

CREATE TABLE IF NOT EXISTS `department` (
  `d_code` enum('CEN','BINF','BAF','ECE','BUS','ECO','ARCH') NOT NULL,
  `dname` varchar(50) NOT NULL,
  `dmanager` char(8) NOT NULL,
  `dfaculty` varchar(50) NOT NULL,
  `dlocation` enum('Building A','Building E') DEFAULT NULL,
  PRIMARY KEY (`d_code`)
);

CREATE TABLE IF NOT EXISTS `person` (
  `p_id` char(8) NOT NULL,
  `name` varchar(20) NOT NULL,
  `surname` varchar(25) DEFAULT NULL,
  `email` varchar(25) NOT NULL,
  `pass` varchar(40) NOT NULL,
  `bdate` char(40) DEFAULT NULL,
  `dcode` enum('CEN','BINF','BAF','ECE','BUS','ECO','ARCH') NOT NULL,
  `fathersName` varchar(20) DEFAULT NULL,
  `pnumber` varchar(20) DEFAULT NULL,
  `position` enum('Lecturer','Bachelor','Master','Ph.D') DEFAULT NULL,
  `status` enum('Active','Graduated','Exchange','Onleave','On Suspension') DEFAULT NULL,
  PRIMARY KEY (`p_id`),
  CONSTRAINT `department` FOREIGN KEY (`dcode`) REFERENCES `department` (`d_code`) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `course` (
  `ccode` char(6) NOT NULL DEFAULT '',
  `ctitle` varchar(50) DEFAULT NULL,
  `cdept` enum('CEN','BINF','BAF','ECE','BUS','ECO','ARCH') NOT NULL,
  `clevel` enum('Bachelor','Master','Ph.D') DEFAULT NULL,
  `cinfo` tinytext,
  PRIMARY KEY (`ccode`),
  FOREIGN KEY (`cdept`) REFERENCES `department` (`d_code`) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `semester` (
  `semesterid` char(3) NOT NULL,
  `syear` year(4) DEFAULT NULL,
  `sterm` enum('Fall','Spring','Summer') DEFAULT NULL,
  `sdate` date DEFAULT NULL,
  `send` date DEFAULT NULL,
  `duration` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`semesterid`)
);

CREATE TABLE IF NOT EXISTS `course_open` (
  `ccopen` char(6) NOT NULL,
  `p_id` char(8) NOT NULL,
  `semesterid` char(3) NOT NULL,
  `ccode` char(6) NOT NULL,
  `chours` tinyint(4) DEFAULT NULL,
  `ects` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ccopen`),
  KEY `course_idx` (`ccode`),
  KEY `course_lecturer` (`p_id`),
  KEY `semester` (`semesterid`),
  CONSTRAINT `course` FOREIGN KEY (`ccode`) REFERENCES `course` (`ccode`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `course_lecturer` FOREIGN KEY (`p_id`) REFERENCES `person` (`p_id`) ON UPDATE CASCADE,
  CONSTRAINT `semester` FOREIGN KEY (`semesterid`) REFERENCES `semester` (`semesterid`) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `grades` (
  `rcode` int(16) NOT NULL AUTO_INCREMENT,
  `p_id` char(8) NOT NULL,
  `ccopen` char(6) NOT NULL,
  `gtype` enum('Midterm','Final','Quiz') DEFAULT NULL,
  `grade` int(11) DEFAULT NULL,
  `gweight` int(11) DEFAULT NULL,
  PRIMARY KEY (`rcode`),
  KEY `studenttakes` (`p_id`),
  KEY `coursetaken` (`ccopen`),
  CONSTRAINT `coursetaken` FOREIGN KEY (`ccopen`) REFERENCES `course_open` (`ccopen`) ON UPDATE CASCADE,
  CONSTRAINT `studenttakes` FOREIGN KEY (`p_id`) REFERENCES `person` (`p_id`) ON UPDATE CASCADE
);

/* Inserting Data */
INSERT INTO `department` (`d_code`, `dname`, `dmanager`, `dfaculty`, `dlocation`) VALUES
	('CEN', 'Computer Engineering', '00002165', 'Faculty of Architecture and Engineering', 'Building E'),
	('BINF', 'Business Informatics', '00004011', 'Faculty of Economics and Administrative Sciences', 'Building E'),
	('BAF', 'Banking and Finance', '00005008', 'Faculty of Economics and Administrative Sciences', 'Building E'),
	('BUS', 'Business Administration', '00003261', 'Faculty of Economics and Administrative Sciences', 'Building E'),
	('ECO', 'Economics', '00006277', 'Faculty of Economics and Administrative Sciences', 'Building E'),
	('ARCH', 'Architecture', '00001158', 'Faculty of Architecture and Engineering', 'Building A');
INSERT INTO `course` (`ccode`, `ctitle`, `cdept`, `clevel`, `cinfo`) VALUES
	('BUS102', 'MATH. FOR ECONOMICS AND BUSINESS II', 'BUS', 'Bachelor', 'The aim of this course is to give the basic ingredients of mathematics for business and economics. N'),
	('BUS103', 'INTRODUCTION TO BUSINESS', 'BUS', 'Bachelor', 'Upon completion of this course you will demonstrate the ability to describe and explain: Basic busin'),
	('BUS221', 'MANAGEMENT AND ORGANIZATION', 'BUS', 'Bachelor', 'Basic principles of management are explained. Main functions of management are discussed and some ma'),
	('BUS303', 'FUNDAMENTALS OF CORPORATE FINANCE', 'BUS', 'Bachelor', 'The primary objective of this course is to familiarize the student with basic concepts of corporate '),
	('CEN103', 'INTRODUCTION TO COMPUTER ENGINEERING', 'CEN', 'Bachelor', 'This course is a general introduction to Computer Science and Engineering. It introduces basic termi'),
	('CEN111', 'INTRODUCTION TO ALGORITHMS & PROGRAMMING', 'CEN', 'Bachelor', 'The objective of this course is to equip the students with the basic understanding of algorithms and'),
	('CEN112', 'C AND C++ PROGRAMMING', 'CEN', 'Bachelor', 'This course aims to teach and implement the structured programming concepts in C language, an overvi'),
	('CEN213', 'OBJECT ORIENTED PROGRAMMING WITH JAVA', 'CEN', 'Bachelor', 'This course calls on you to demonstrate: (1) knowledge of programming techniques and the Java langua'),
	('CEN222', 'WEB TECHNOLOGIES', 'CEN', 'Bachelor', 'Teaching to students how to create and publish a basic web page using HTML and its many tags; to describe limitations of creating interactivity including browser support and differences; understanding JavaScript variables, control structures, functions, a'),
	('CEN252', 'DATABASE MANAGEMENT SYSTEMS', 'CEN', 'Bachelor', 'The purpose of this course is to provide an introduction to the design and use of database systems, '),
	('CEN254', 'DATA STRUCTURES', 'CEN', 'Bachelor', 'To get accustomed to and be able to use common algorithms used in programming, including: divide-and-conquer, greedy algorithms, dynamic programming and analyze the efficiency of algorithms using recurrences and amortized analysis. It covers external memo'),
	('CEN303', 'ANALYSIS OF ALGORITHMS', 'CEN', 'Bachelor', 'To learn Divide and conquer techniques, greedy methods, and dynamic programming, Asymptotic notation'),
	('ECO206', 'MACROECONOMICS ', 'ECO', 'Bachelor', 'By analyzing macro economic theories, discussing the validity of macroeconomic topics is the aim of ');
INSERT INTO `semester` (`semesterid`, `syear`, `sterm`, `sdate`, `send`, `duration`) VALUES
	('020', '2013', 'Fall', '2012-09-12', '2013-01-28', 16),
	('021', '2013', 'Spring', '2013-02-18', '2013-06-05', 16),
	('022', '2014', 'Fall', '2013-09-09', '2014-01-16', 16),
	('023', '2014', 'Spring', '2014-02-11', '2014-06-02', 16);
INSERT INTO `person` (`p_id`, `name`, `surname`, `email`, `pass`, `bdate`, `dcode`, `fathersName`, `pnumber`, `position`, `status`) VALUES
	('00001043', 'Sonila ', 'Dedja', 'sdedja@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1972-04-30', 'ARCH', 'Saimir ', '3025148', 'Lecturer', 'Active'),
	('00001158', 'Jeton ', 'Duka', 'jduka@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1975-04-22', 'ARCH', 'Bledar ', '4256325', 'Lecturer', 'Active'),
	('00001234', 'Silvester', 'Stal', 'silvester@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1985-01-01', 'ARCH', 'Ndricim', '5681472', 'Lecturer', 'Active'),
	('00002103', 'Ilir', 'Kasapi', 'ikasapi@hotmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1977-03-10', 'CEN', 'Skender', '8254196', 'Lecturer', 'Active'),
	('00002157', 'Lindita', 'Baris', 'lbaris@gmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1981-07-02', 'CEN', 'Valmir', '5263145', 'Lecturer', 'Active'),
	('00002165', 'Aldo', 'Hoxha', 'ahoxha@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1975-11-18', 'CEN', 'Martin ', '4156854', 'Lecturer', 'Active'),
	('00002335', 'Gjon', 'Dibra', 'gdibra@gmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1975-05-01', 'CEN', 'Aleksander', '8526314', 'Lecturer', 'Active'),
	('00003261', 'Lorena', 'Domi', 'ldomi@gmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '2015-00-00', 'BUS', 'Saimir ', '3025148', 'Bachelor', 'Active'),
	('00004011', 'Igli', 'Maci', 'imaci@epoka.edu.a', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1985-02-22', 'BINF', 'Besim ', '4752369', 'Lecturer', 'Active'),
	('00005008', 'Valmir ', 'Rama', 'vrama@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1993-07-22', 'BAF', 'Ergys ', '3215874', 'Lecturer', 'Active'),
	('00006277', 'Loren', 'Nano', 'lnano@gmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1970-03-05', 'ECO', 'Artan', '3025148', 'Bachelor', 'Active'),
	('01263214', 'Renata ', 'Malaj', 'rmalaj@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1991-10-10', 'ARCH', 'Ergys ', '3215874', 'Bachelor', 'Active'),
	('02215698', 'Gledis', 'Basha', 'gbasha@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1994-08-05', 'CEN', 'Elvis ', '4201567', 'Bachelor', 'Active'),
	('02245863', 'Klodian', 'Lokaj', 'klokaj@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1989-09-18', 'CEN', 'Bledar ', '4256325', 'Bachelor', 'Active'),
	('02345678', 'Miranda', 'Farruku', 'mfarruku@gmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1990-01-01', 'CEN', 'Selim', '3256236', 'Ph.D', 'Active'),
	('02358912', 'Ornela ', 'Kamberi', 'okamberi@gmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1992-05-09', 'CEN', 'Erind ', '4225187', 'Bachelor', 'Active'),
	('02412630', 'Nensi', 'Xheka', 'nxheka@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1995-05-09', 'CEN', 'Martin ', '4156854', 'Master', 'Exchange'),
	('02548924', 'Saimir ', 'Gega', 'sgega@hotmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1993-01-08', 'CEN', 'Rudin', '3009852', 'Bachelor', 'Active'),
	('02559855', 'Luela', 'Kabila', 'mdenaj@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1995-08-05', 'CEN', 'Sabri ', '4111025', 'Bachelor', 'Active'),
	('02559875', 'Gerta', 'Xhoni', 'gxhoni@hotmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1995-11-11', 'CEN', 'Arif', '4258741', 'Bachelor', 'Graduated'),
	('02589584', 'Adela ', 'Cenaj', 'acenaj@gmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1986-03-25', 'CEN', 'Aurel ', '4251963', 'Bachelor', 'Active'),
	('02598451', 'Arban', 'Sula', 'rsula@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1991-04-18', 'CEN', 'Mentor ', '3529562', 'Bachelor', 'Active'),
	('02653575', 'Gert', 'Rama', 'grama@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1982-11-01', 'CEN', 'Ardit ', '3001000', 'Master', 'Active'),
	('02862544', 'Elton ', 'Rudi', 'erudi@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1992-11-07', 'CEN', 'Klevis ', '4225841', 'Bachelor', 'Active'),
	('04458795', 'Hysen', 'Dushku', 'hdushku@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1988-03-18', 'BINF', 'Idlir', '3025684', 'Bachelor', 'Active'),
	('04559875', 'Marsela', 'Koci', 'mkoci@gmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1985-11-11', 'BINF', 'Agim', '3002244', 'Bachelor', 'Active'),
	('04612874', 'Artan', 'Hoxha', 'ahoxha@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1980-04-01', 'BINF', 'Mehdi', '3021874', 'Master', 'Graduated'),
	('04659874', 'Xheni', 'Lala', 'xlala@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1992-11-01', 'BINF', 'Besim ', '4752369', 'Bachelor', 'Onleave'),
	('04822241', 'Miranda', 'Sokoli', 'ssokoli@hotmail.com', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1990-12-02', 'BINF', 'Dritan ', '3125289', 'Bachelor', 'Graduated'),
	('06526384', 'Jona ', 'Veshi', 'jveshi@epoka.edu.al', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '1994-04-02', 'ECO', 'Klajdi ', '4215893', 'Master', 'Active');
INSERT INTO `course_open` (`ccopen`, `p_id`, `semesterid`, `ccode`, `chours`, `ects`) VALUES
	('023001', '00002103', '022', 'CEN222', 4, 4),
	('023002', '00002165', '022', 'CEN252', 5, 5),
	('023003', '00002335', '022', 'CEN254', 3, 7),
	('023004', '00002103', '021', 'CEN111', 3, 5);
INSERT INTO `grades` (`rcode`, `p_id`, `ccopen`, `gtype`, `grade`, `gweight`) VALUES
	(10129, '02589584', '023001', 'Quiz', 10, 10),
	(10130, '02589584', '023002', 'Quiz', 50, 15),
	(10131, '02589584', '023003', 'Quiz', 100, 10),
	(10132, '02589584', '023001', 'Midterm', 50, 40),
	(10133, '02589584', '023002', 'Midterm', 50, 30),
	(10134, '02589584', '023003', 'Midterm', 90, 45),
	(10135, '02589584', '023001', 'Final', 15, 50),
	(10136, '02589584', '023002', 'Final', 80, 55),
	(10137, '02589584', '023003', 'Final', 75, 45),
	(10138, '02559855', '023001', 'Quiz', 100, 10),
	(10139, '02559855', '023002', 'Quiz', 95, 15),
	(10140, '02559855', '023003', 'Quiz', 85, 10),
	(10141, '02559855', '023001', 'Midterm', 70, 40),
	(10142, '02559855', '023002', 'Midterm', 100, 30),
	(10143, '02559855', '023003', 'Midterm', 50, 45),
	(10144, '02559855', '023001', 'Final', 85, 50),
	(10145, '02559855', '023002', 'Final', 55, 55),
	(10146, '02559855', '023003', 'Final', 75, 45),
	(10147, '02862544', '023001', 'Quiz', 60, 10),
	(10148, '02862544', '023002', 'Quiz', 90, 15),
	(10149, '02862544', '023003', 'Quiz', 60, 10),
	(10150, '02862544', '023001', 'Midterm', 90, 40),
	(10151, '02862544', '023002', 'Midterm', 80, 30),
	(10152, '02862544', '023003', 'Midterm', 75, 45),
	(10153, '02862544', '023001', 'Final', 80, 50),
	(10154, '02862544', '023002', 'Final', 60, 55),
	(10155, '02862544', '023003', 'Final', 75, 45),
	(10156, '02598451', '023001', 'Quiz', 75, 10),
	(10157, '02598451', '023002', 'Quiz', 40, 15),
	(10158, '02598451', '023003', 'Quiz', 15, 10),
	(10159, '02598451', '023001', 'Midterm', 100, 40),
	(10160, '02598451', '023002', 'Midterm', 75, 30),
	(10161, '02598451', '023003', 'Midterm', 80, 45),
	(10162, '02598451', '023001', 'Final', 90, 50),
	(10163, '02598451', '023002', 'Final', 70, 55),
	(10164, '02598451', '023003', 'Final', 50, 45),
	(10165, '02548924', '023001', 'Quiz', 95, 10),
	(10166, '02548924', '023002', 'Quiz', 70, 15),
	(10167, '02548924', '023003', 'Quiz', 60, 10),
	(10168, '02548924', '023001', 'Midterm', 100, 40),
	(10169, '02548924', '023002', 'Midterm', 100, 30),
	(10170, '02548924', '023003', 'Midterm', 95, 45),
	(10171, '02548924', '023001', 'Final', 100, 50),
	(10172, '02548924', '023002', 'Final', 80, 55),
	(10173, '02548924', '023003', 'Final', 90, 45),
	(10174, '02548924', '023004', 'Final', 95, 50),
	(10175, '02548924', '023004', 'Midterm', 85, 40),
	(10176, '02548924', '023004', 'Quiz', 85, 10);
ALTER TABLE `department` ADD CONSTRAINT `dhead` FOREIGN KEY (`dmanager`) REFERENCES `person` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/* Query 1: Find the number of courses that are part of CEN department with level Bachelor. */
SELECT count(*) FROM course WHERE cdept = 'CEN' AND clevel = 'Bachelor';

/* Query 2: Find the id and title of courses which are taught by an instructor named Sonila. Make sure there are no duplicates in the result. */
SELECT ccode, ctitle FROM course, person WHERE name = 'Sonila' AND cdept = dcode;

/* Query 3: Find the id and titles of courses which are taken by a student named Gledis. Make sure there are no duplicates in the result. */
SELECT ccode, ctitle FROM course, person WHERE p_id = '02215698' AND dcode = cdept;

/* Query 4: Find all titles of courses which have a string 'INTRODUCTION'. */
SELECT ctitle FROM course WHERE ctitle LIKE '%INTRODUCTION%';

/* Query 5: Find the student name which is registered in Data Structure course, during fall semester of 2013. */
SELECT name FROM person INNER JOIN course_open ON course_open.p_id = person.p_id WHERE course_open.ccode = 'CEN254';

/* Query 6: Find the student with the highest grade in department CEN taking Data Structures course. */
SELECT name, surname FROM person WHERE p_id IN (
	SELECT p_id FROM grades WHERE ccopen in (
		SELECT ccopen FROM course_open WHERE ccode IN (
			SELECT ccode FROM course WHERE ctitle = 'DATA STRUCTURES')) AND grade = (SELECT max(grade) FROM grades WHERE ccopen IN (
	(SELECT ccopen FROM course_open WHERE ccode IN ( 
		SELECT ccode FROM course WHERE ctitle = 'DATA STRUCTURES')))));

/* Query 7: Find number of persons with level of master, bachelor, and lecturer. */
(SELECT count(*) FROM person WHERE position = 'Bachelor') 
	UNION (SELECT count(*) FROM person WHERE position = 'Master')
		UNION (SELECT count(*) FROM person WHERE position = 'Lecturer');

/* Query 8: Find all courses in CEN departament opened in spring year 2013. */
SELECT ctitle FROM course INNER JOIN course_open ON course_open.ccode = course.ccode 
	INNER JOIN semester ON semester.semesterid = course_open.semesterid WHERE cdept = 'CEN' AND syear = '2013' AND sterm = 'Spring';
