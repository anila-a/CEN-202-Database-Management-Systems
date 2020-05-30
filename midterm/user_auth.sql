/* CEN 202 Database Management Systems - Midterm */
/* Author: Anila Hoxha 
   Last date modified: 05/30/2020 */

/* USER MANAGEMENT FOR THE DATABASE */

/* General Manager User */
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'm123';
GRANT SELECT, INSERT, UPDATE, DELETE ON hotel.employee TO manager@localhost;
GRANT SELECT ON hotel.booking TO manager@localhost;

/* Concierge User */
CREATE USER 'concierges'@'localhost' IDENTIFIED BY 'c123';
GRANT SELECT, INSERT, UPDATE, DELETE ON hotel.booking TO concierge@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON hotel.guest TO concierge@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON hotel.invoice TO concierge@localhost;

/* Group Sales User */
CREATE USER 'sales'@'localhost' IDENTIFIED BY 's123';
GRANT SELECT ON hotel.invoice TO sales@localhost;

/* Service User */
CREATE USER 'service'@'localhost' IDENTIFIED BY 'se123';
GRANT SELECT, INSERT, UPDATE, DELETE ON hotel.service TO service@localhost;

/* Housekeeper User */
CREATE USER 'housekeeper'@'localhost' IDENTIFIED BY 'h123';
GRANT SELECT ON hotel.room TO housekeeper@localhost;

/* Executive Chef User */
CREATE USER 'chef'@'localhost' IDENTIFIED BY 'ch123';
GRANT SELECT ON hotel.menu TO chef@localhost;

/* Parking Lot Attendee User */
CREATE USER 'parking'@'localhost' IDENTIFIED BY 'p123';
GRANT SELECT, INSERT, UPDATE, DELETE ON hotel.parking TO parking@localhost;
