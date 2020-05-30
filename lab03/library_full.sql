CREATE SCHEMA library;
USE library;

CREATE TABLE PUBLISHER
(
  PUBID NUMERIC(3) NOT NULL,
  PName CHAR(20) NOT NULL,
  Phone VARCHAR(15) NOT NULL,
  Contact_Person CHAR(30) NOT NULL,
  Contact_Description CHAR(50) NOT NULL,
  Address CHAR(30) NOT NULL,
  PRIMARY KEY (PUBID)
);

CREATE TABLE LIBRARY
(
  BID NUMERIC(10) NOT NULL,
  Library_Description CHAR(50) NOT NULL,
  PRIMARY KEY (BID)
);

CREATE TABLE BOOK
(
  ISBN CHAR(13) NOT NULL,
  Title CHAR(30) NOT NULL,
  Author CHAR(30) NOT NULL,
  Publishing_Year TIMESTAMP DEFAULT CURRENT_TIMESTAMP, /* YYYY - MM - DD */
  Book_PUBID NUMERIC(3) NOT NULL,
  Book_BID NUMERIC(10) NOT NULL,
  PRIMARY KEY (ISBN),
  FOREIGN KEY (Book_PUBID) REFERENCES PUBLISHER(PUBID),
  FOREIGN KEY (Book_BID) REFERENCES LIBRARY(BID)
);

CREATE TABLE MEMBERS
(
  IDM NUMERIC(5) NOT NULL,
  Registration_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, /* YYYY - MM - DD */
  MName CHAR(30) NOT NULL,
  MSurname CHAR(30) NOT NULL,
  Address CHAR(30) NOT NULL,
  Phone VARCHAR(15) NOT NULL,
  Members_BID NUMERIC(10) NOT NULL,
  PRIMARY KEY (IDM),
  FOREIGN KEY (Members_BID) REFERENCES LIBRARY(BID)
);

INSERT INTO PUBLISHER VALUES
('234', 'Publisher 1', '020 2932 3411', 'Jenny Russell', 'Publisher', 'London, UK'),
('239', 'Publisher 2', '020 3947 1095', 'Martin Brading', 'Publisher', 'London, UK'),
('451', 'Publisher 3', '029 0199 4873', 'Mae Smith', 'Book Editor', 'Cardiff, UK'),
('667', 'Publisher 4', '029 3982 7015', 'Esther Souter', 'Book Editor', 'Cardiff, UK');

INSERT INTO LIBRARY VALUES
('1298473801', 'Library 1'),
('1298473802', 'Library 2'),
('1298473803', 'Library 3'),
('1298473804', 'Library 4'),
('1298473805', 'Library 5');

INSERT INTO BOOK VALUES
('1003256009802', 'The Three Musketeers', 'Alexander Dumas', '2001-04-17', '234', '1298473802'),
('4-49821-398-3', 'David Copperfield', 'Charles Dickens', '2007-11-23', '234', '1298473801'),
('3-79003-419-8', 'A Divine Comedy', 'Dante Alighieri', '2012-03-29', '239', '1298473801'),
('5-38710-737-0', 'Anna Karenina', 'Leo Tolstoy', '2010-03-08', '451', '1298473803'),
('8-19384-291-9', 'Pride And Prejudice', 'Jane Austin', '2016-02-10', '451', '1298473804'),
('3-71837-481-5', 'A Brief History of Time', 'Stephen Hawkings', '2018-09-19', '667', '1298473805');

INSERT INTO MEMBERS VALUES
('34217', '2019-05-23', 'Fred', 'Hobbs', 'London, UK', '020 9283 0104', '1298473801'),
('34218', '2019-05-23', 'Curtis', 'Orchard', 'London, UK', '020 0193 1847', '1298473801'),
('40291', '2019-05-23', 'Opal', 'Humber', 'London, UK', '020 2984 1210', '1298473802'),
('50291', '2019-05-24', 'Mae', 'Leal', 'Cardiff, UK', '029 1029 2938', '1298473803'),
('62043', '2019-05-25', 'Lester', 'Meecham', 'London, UK', '020 2918 3763', '1298473804'),
('78173', '2019-05-26', 'Blache', 'Russell', 'London, UK', '020 1975 5013', '1298473805');
