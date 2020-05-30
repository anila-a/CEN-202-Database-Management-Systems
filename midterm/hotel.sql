/* CEN 202 Database Management Systems - Midterm */
/* Author: Anila Hoxha 
   Last date modified: 05/30/2020 */

/* HOTEL DATABASE SCHEMA */

CREATE DATABASE IF NOT EXISTS hotel;
USE hotel;

CREATE TABLE IF NOT EXISTS employee
(
  e_id CHAR(8) NOT NULL,
  e_name VARCHAR(20) NOT NULL,
  e_surname VARCHAR(25) NOT NULL,
  e_bdate DATE DEFAULT NULL,
  e_address CHAR(30) DEFAULT NULL,
  e_position ENUM('General Manager', 'Concierge', 'Group Sales Person', 'Service Agent', 'Executive Chef', 'Housekeeper', 'Parking Lot Attendant') DEFAULT NULL,
  e_salary NUMERIC(5),
  PRIMARY KEY (e_id)
);

CREATE TABLE IF NOT EXISTS guest
(
  g_id CHAR(8) NOT NULL,
  g_name_1 VARCHAR(20) NOT NULL,
  g_surname_1 VARCHAR(25) NOT NULL,
  g_name_2 VARCHAR(20) DEFAULT NULL,
  g_surname_2 VARCHAR(25) DEFAULT NULL,
  g_name_3 VARCHAR(20) DEFAULT NULL,
  g_surname_3 VARCHAR(25) DEFAULT NULL,
  g_name_4 VARCHAR(20) DEFAULT NULL,
  g_surname_4 VARCHAR(25) DEFAULT NULL,
  g_bdate DATE DEFAULT NULL,
  g_idCard CHAR(7) NOT NULL,
  g_address CHAR(30) DEFAULT NULL,
  g_emplID CHAR(8) NOT NULL,
  g_stayingDuration INTEGER NOT NULL,
  PRIMARY KEY (g_id),
  CONSTRAINT employee FOREIGN KEY (g_emplID) REFERENCES employee(e_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS booking
(
  b_id CHAR(11) NOT NULL,
  b_date DATETIME NOT NULL,
  b_description CHAR(40) DEFAULT NULL,
  b_emplID CHAR(8) NOT NULL,
  b_gstID CHAR(8) NOT NULL,
  PRIMARY KEY (b_id),
  FOREIGN KEY (b_emplID) REFERENCES employee(e_id) ON UPDATE CASCADE,
  CONSTRAINT guest FOREIGN KEY (b_gstID) REFERENCES guest(g_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS invoice
(
  i_id CHAR(11) NOT NULL,
  i_date DATETIME NOT NULL,
  i_description CHAR(50) DEFAULT NULL,
  i_bookingID CHAR(11) NOT NULL,
  PRIMARY KEY (i_id),
  CONSTRAINT booking FOREIGN KEY (i_bookingID) REFERENCES booking(b_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS room
(
  r_id CHAR(3) NOT NULL,
  r_type ENUM('Single', 'Double', 'Triple', 'Quad', 'Twin') NOT NULL,
  r_description CHAR(40) NOT NULL,
  r_price NUMERIC(5) NOT NULL,
  r_gstID CHAR(8) NOT NULL,
  PRIMARY KEY (r_id),
  FOREIGN KEY (r_gstID) REFERENCES guest(g_id) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS menu
(
  m_id CHAR(5) NOT NULL,
  m_type ENUM('Menu 1', 'Menu 2', 'Menu 3', 'Menu 4') NOT NULL,
  m_roomID CHAR(3) NOT NULL,
  PRIMARY KEY (m_id),
  CONSTRAINT room FOREIGN KEY (m_roomID) REFERENCES room(r_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS service
(
  s_id CHAR(8) NOT NULL,
  s_type ENUM('Table Service', 'Room Service', 'Taxi Service', 'Event Organization Service', 'Laundry Service', 'Spa Service', 'None') NOT NULL,
  s_reservationDate DATE DEFAULT NULL,
  s_dueDate DATE DEFAULT NULL,
  s_gstID CHAR(8) NOT NULL,
  PRIMARY KEY (s_id),
  FOREIGN KEY (s_gstID) REFERENCES guest(g_id) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS parking
(
  p_id CHAR(8) NOT NULL,
  p_hours FLOAT NOT NULL,
  p_price FLOAT NOT NULL,
  p_bookingID CHAR(11) NOT NULL,
  PRIMARY KEY (p_id),
  FOREIGN KEY (p_bookingID) REFERENCES booking(b_id) ON UPDATE CASCADE
);

INSERT INTO employee (e_id, e_name, e_surname, e_bdate, e_address, e_position, e_salary) VALUES 
	('1001020', 'David', 'Smith', '1973-05-23', 'London, UK', 'General Manager', '7000'),
    ('1001021', 'Eric', 'Green', '1976-11-01', 'London, UK', 'General Manager', '7000'),
    ('1002022', 'Lucy', 'Wood', '1988-02-09', 'London, UK', 'Concierge', '3000'),
    ('1002023', 'Tyler', 'Lee', '1988-12-03', 'London, UK', 'Concierge', '3000'),
    ('1002024', 'Janet', 'King', '1991-08-14', 'London, UK', 'Concierge', '3000'),
    ('1002025', 'Victoria', 'Miller', '1995-04-19', 'London, UK', 'Concierge', '3000'),
    ('1003026', 'Moore', 'Smith', '1979-01-02', 'London, UK', 'Group Sales Person', '5500'),
    ('1003027', 'Jones', 'Garcia', '1985-07-21', 'London, UK', 'Group Sales Person', '5500'),
    ('1003028', 'Moore', 'Smith', '1979-01-02', 'London, UK', 'Group Sales Person', '5500'),
    ('1004029', 'Ashley', 'Edwards', '1992-03-24', 'London, UK', 'Service Agent', '4500'),
    ('1004030', 'Herman', 'Gates', '1987-10-27', 'London, UK', 'Service Agent', '4500'),
    ('1005031', 'Cooper', 'Janssen', '1985-10-30', 'London, UK', 'Executive Chef', '4500'),
    ('1005032', 'Anna', 'Middleton', '1995-04-21', 'London, UK', 'Housekeeper', '2500'),
    ('1005033', 'Emily', 'Boe', '1992-09-15', 'London, UK', 'Housekeeper', '2500'),
    ('1005034', 'Henry', 'Jensen', '1974-02-28', 'London, UK', 'Parking Lot Attendant', '3200');

INSERT INTO guest (g_id, g_name_1, g_surname_1, g_name_2, g_surname_2, g_name_3, g_surname_3, g_name_4, g_surname_4, g_bdate, g_idCard, g_address, g_stayingDuration, g_emplID) VALUES 
	('30001100', 'Ruby', 'Clark', '', '', '', '', '', '', '1990-02-28', 'DX3981J', 'Cardiff, UK', '4', '1002022'),
	('30001101', 'Joanna', 'Antoine', '', '', '', '', '', '', '2001-03-14', 'A39NY10', 'Paris, France', '3', '1002022'),
	('30001102', 'Leonie', 'Lee', 'Sandra', 'Lee', '', '', '', '', '1989-10-27', 'S309CT3', 'Edinburgh, UK', '3', '1002022'),
	('30001103', 'Visha', 'Chettia', '', '', '', '', '', '', '1983-07-20', 'I0E398B', 'Mumbai, India', '15', '1002023'),
	('30001104', 'Owen', 'Souter', 'Iva', 'Souter', 'Mae', 'Souter', 'Iris', 'Souter', '1980-11-29', 'A93MIW0', 'Workshire, UK', '8', '1002023'),
	('30001105', 'Horace', 'Moore', 'Caroline', 'More', '', '', '', '', '1989-03-14', 'C198OP3', 'Manchester, UK', '4', '1002023'),
	('30001106', 'Mark', 'Zimmer', '', '', '', '', '', '', '1992-09-03', 'G20K40V', 'Munich, Germany', '2', '1002024'),
	('30001107', 'Barbara', 'Matthews', '', '', '', '', '', '', '1998-06-11', 'X0R115K', 'Bristol, UK', '5', '1002024'),
    ('30001108', 'Luca', 'Baresi', 'Pietra', 'Baresi', 'Gabriele', 'Baresi', '', '', '1993-03-10', 'HI20M4C', 'Rome, Italy', '2', '1002025'),
	('30001109', 'Ivor', 'Moore', '', '', '', '', '', '', '1999-05-21', 'K20C1T8', 'Liverpool, UK', '7', '1002025'),
	('30001110', 'Naomi', 'Coffen', '', '', '', '', '', '', '1995-07-25', 'B22YU83', 'Glasgow, UK', '2', '1002025');
    
INSERT INTO booking (b_id, b_date, b_description, b_emplID, b_gstID) VALUES 
	('10030001703', '2020-03-15 10:29:45', '', '1002022', '30001100'),
    ('10030001704', '2020-03-15 13:02:58', '', '1002022', '30001101'),
    ('10030001705', '2020-03-16 14:19:05', '', '1002022', '30001102'),
    ('10030001706', '2020-03-16 17:23:48', '', '1002023', '30001103'),
    ('10030001707', '2020-03-17 09:10:11', '', '1002023', '30001104'),
    ('10030001708', '2020-03-21 16:06:13', '', '1002023', '30001105'),
    ('10030001709', '2020-03-22 11:45:18', '', '1002024', '30001106'),
    ('10030001710', '2020-03-22 15:39:01', '', '1002024', '30001107'),
    ('10030001711', '2020-03-27 20:15:17', '', '1002025', '30001108'),
    ('10030001712', '2020-03-28 09:33:47', '', '1002025', '30001109'),
    ('10030001713', '2020-03-28 12:23:14', '', '1002025', '30001110');

INSERT INTO invoice (i_id, i_date, i_description, i_bookingID) VALUES
	('00000017701', '2020-03-15 10:29:45', '', '10030001703'),
    ('00000017702', '2020-03-15 13:02:58', '', '10030001704'),
    ('00000017703', '2020-03-16 14:19:05', '', '10030001705'),
    ('00000017704', '2020-03-16 17:23:48', '', '10030001706'),
    ('00000017705', '2020-03-17 09:10:11', '', '10030001707'),
    ('00000017706', '2020-03-21 16:06:13', '', '10030001708'),
    ('00000017707', '2020-03-22 11:45:18', '', '10030001709'),
    ('00000017708', '2020-03-22 15:39:01', '', '10030001710'),
    ('00000017709', '2020-03-27 20:15:17', '', '10030001711'),
    ('00000017710', '2020-03-28 09:33:47', '', '10030001712'),
    ('00000017711', '2020-03-28 12:23:14', '', '10030001713');

INSERT INTO room (r_id, r_type, r_description, r_price, r_gstID) VALUES
	('203', 'Single', 'One bed, 37x37m', '190', '30001100'),
    ('204', 'Single', 'One bed, 37x37m', '190', '30001101'),
    ('407', 'Double', 'One bed, 45x45m', '230', '30001102'),
    ('205', 'Single', 'One bed, 37x37m', '190', '30001103'),
    ('509', 'Quad', 'Two beds, 75x75m', '310', '30001104'),
    ('409', 'Double', 'One bed, 45x45m', '230', '30001105'),
    ('206', 'Single', 'One bed, 37x37m', '190', '30001106'),
    ('207', 'Single', 'One bed, 37x37m', '190', '30001107'),
    ('209', 'Single', 'One bed, 37x37m', '190', '30001108'),
    ('213', 'Single', 'One bed, 37x37m', '190', '30001109'),
    ('410', 'Double', 'One bed, 45x45m', '230', '30001110');
    
INSERT INTO menu (m_id, m_type, m_roomID) VALUES
	('10010', 'Menu 2', '203'),
    ('10011', 'Menu 2', '204'),
    ('10012', 'Menu 1', '407'),
    ('10013', 'Menu 4', '205'),
    ('10014', 'Menu 3', '509'),
    ('10015', 'Menu 3', '409'),
    ('10016', 'Menu 2', '206'),
    ('10017', 'Menu 1', '207'),
    ('10018', 'Menu 4', '209'),
    ('10019', 'Menu 1', '213'),
    ('10020', 'Menu 1', '410');

INSERT INTO service (s_id, s_type, s_reservationDate, s_dueDate, s_gstID) VALUES
	('11000000', 'None', '', '', '30001100'), 
	('11000001', 'Table Service', '2020-03-15', '2020-03-17', '30001101'), 
    ('11000002', 'Taxi Service', '2020-03-16', '2020-03-16', '30001102'),
    ('11000003', 'None', '', '', '30001103'),
    ('11000004', 'Event Organization Service', '2020-03-17', '2020-03-18', '30001104'),
    ('11000005', 'None', '', '', '30001105'),
    ('11000006', 'None', '', '', '30001106'),
	('11000007', 'Spa Service', '2020-03-22', '2020-03-24', '30001107'),
    ('11000008', 'None', '', '', '30001108'),
    ('11000009', 'Laundry Service', '2020-03-28', '2020-03-31', '30001109'),
    ('11000010', 'Spa Service', '2020-03-28', '2020-03-29', '30001110');
    
INSERT INTO parking (p_id, p_hours, p_price, p_bookingID) VALUES 
	('00050100', '96', '1.5', '10030001705'),
    ('00050101', '72', '1.5', '10030001707'),
    ('00050102', '120', '1.5', '10030001710'),
    ('00050103', '48', '1.5', '10030001711');
