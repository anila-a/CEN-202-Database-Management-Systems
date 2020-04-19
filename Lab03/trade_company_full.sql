CREATE SCHEMA trade_company;
USE trade_company;

CREATE TABLE CLIENTS
(
  CID NUMERIC(5) NOT NULL,
  CName CHAR(20) NOT NULL,
  CSurname CHAR(20) NOT NULL,
  Phone VARCHAR(15) NOT NULL,
  Address CHAR(30) DEFAULT 'UK',
  PRIMARY KEY (CID)
);

CREATE TABLE EMPLOYEES
(
  EID NUMERIC(5) NOT NULL,
  EName CHAR(20) NOT NULL,
  ESurname CHAR(20) NOT NULL,
  Phone VARCHAR(15) NOT NULL,
  PRIMARY KEY (EID)
);

CREATE TABLE INVOICE
(
  ID NUMERIC(10) NOT NULL,
  Due_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, /* YYYY - MM - DD */
  Total_Value DECIMAL NOT NULL,
  INV_CID NUMERIC(5) NOT NULL,
  INV_EID NUMERIC(5) NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (INV_CID) REFERENCES CLIENTS(CID),
  FOREIGN KEY (INV_EID) REFERENCES EMPLOYEES(EID)
);

CREATE TABLE INVOICE_DESCRIPTION
(
  IID NUMERIC(10) NOT NULL,
  Amount INT NOT NULL,
  Price DECIMAL NOT NULL,
  INV_ID NUMERIC(10) NOT NULL,
  PRIMARY KEY (IID),
  FOREIGN KEY (INV_ID) REFERENCES INVOICE(ID)
);

CREATE TABLE PRODUCT
(
  PID NUMERIC(3) NOT NULL,
  PName CHAR(20) NOT NULL,
  Product_Description CHAR(50) NOT NULL,
  Quantity INT NOT NULL,
  Tax DECIMAL NOT NULL,
  PR_IID NUMERIC(10) NOT NULL,
  PRIMARY KEY (PID),
  FOREIGN KEY (PR_IID) REFERENCES INVOICE_DESCRIPTION(IID)
);

INSERT INTO CLIENTS VALUES
('12653', 'Ivor', 'Thompson', '029 3452 6439', 'Cardiff, UK'),
('93004', 'Ira', 'Harvey', '029 5244 6118', 'Cardiff, UK'),
('83299', 'Henry', 'Cotter', '029 3986 0039', 'Pembrokeshire, UK'),
('14576', 'Archie', 'Russell', '029 1958 3851', 'Cardiff, UK'),
('30277', 'Madeline', 'Cotter', '029 4986 3094', 'Pembrokeshire, UK'),
('48310', 'Esther', 'Fleming', '029 5983 0958', 'Flintshire, UK'),
('93842', 'Willie', 'Drayton', '029 5498 2938', 'Cardiff, UK'),
('12078', 'Leona', 'Saunders', '029 9831 0404', 'Flintshire, UK'),
('94332', 'Peter', 'Brown', '029 1194 4958', 'Cardigan, UK'),
('53081', 'Fred', 'Warman', '029 5310 4983', 'Cardigan, UK');

INSERT INTO EMPLOYEES VALUES
('04832', 'Stella', 'Gallop', '029 9481 6612'),
('04194', 'Jean', 'Lacey', '029 3821 2914'),
('04299', 'Curtis', 'Brown', '029 1505 3920'),
('04219', 'Sophia', 'Brading', '029 9482 2216');

INSERT INTO INVOICE VALUES
('0000736481', '', '28.40', '12653', '04832'),
('0000736482', '2020-03-23', '59.30', '93004', '04832'),
('0000736483', '2020-03-23', '11.05', '83299', '04832'),
('0000736484', '2020-03-24', '102.00', '14576', '04194'),
('0000736485', '2020-03-24', '5.80', '30277', '04194'),
('0000736486', '2020-03-24', '20.80', '48310', '04299'),
('0000736487', '2020-03-24', '35.99', '93842', '04299'),
('0000736488', '2020-03-25', '7.10', '12078', '04299'),
('0000736489', '2020-03-25', '19.59', '94332', '04219'),
('0000736490', '2020-03-25', '73.20', '53081', '04219');

INSERT INTO INVOICE_DESCRIPTION VALUES
('0003428472', '3', '2.99', '0000736481'),
('0003428473', '3', '1.99', '0000736481'),
('0003428474', '1', '13.46', '0000736481'),
('0003428475', '1', '30.00', '0000736482'),
('0003428476', '1', '29.30', '0000736482'),
('0003428477', '1', '11.05', '0000736483'),
('0003428478', '1', '102.00', '0000736484'),
('0003428479', '1', '5.80', '0000736485'),
('0003428480', '1', '20.80', '0000736486'),
('0003428481', '1', '35.99', '0000736487'),
('0003428482', '2', '3.00', '0000736488'),
('0003428483', '1', '1.10', '0000736488'),
('0003428484', '1', '19.59', '0000736489'),
('0003428485', '1', '73.20', '0000736490');

INSERT INTO PRODUCT VALUES
('045', 'xxx', 'xxx xxx', '3', '0.1', '0003428472'),
('046', 'xxx', 'xxx xxx', '3', '0.1', '0003428473'),
('047', 'xxx', 'xxx xxx', '3', '0.15', '0003428474'),
('048', 'xxx', 'xxx xxx', '3', '0.15', '0003428475'),
('049', 'xxx', 'xxx xxx', '3', '0.15', '0003428476'),
('050', 'xxx', 'xxx xxx', '3', '0.1', '0003428477'),
('051', 'xxx', 'xxx xxx', '3', '0.15', '0003428478'),
('052', 'xxx', 'xxx xxx', '3', '0.15', '0003428479'),
('053', 'xxx', 'xxx xxx', '3', '0.15', '0003428480'),
('054', 'xxx', 'xxx xxx', '3', '0.15', '0003428481'),
('055', 'xxx', 'xxx xxx', '3', '0.15', '0003428482'),
('056', 'xxx', 'xxx xxx', '3', '0.15', '0003428483'),
('057', 'xxx', 'xxx xxx', '3', '0.15', '0003428484'),
('058', 'xxx', 'xxx xxx', '3', '0.15', '0003428485');
