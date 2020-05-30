/* CEN 202 Database Management Systems - Midterm */
/* Author: Anila Hoxha 
   Last date modified: 05/30/2020 */
   
/* TRIGGERS */

/* Trigger 1 - Set salary by default if the registered salary is less than the minimum salary 3000. */
DELIMITER $$
CREATE TRIGGER minSalary 
BEFORE INSERT ON employee
FOR EACH ROW 
BEGIN
IF NEW.e_salary < 3000 THEN SET NEW.e_salary = 3000;
END IF;
END $$
DELIMITER ;

/* Trigger 2 - Set salary by default if the registered salary is more than the maximum salary 7000.*/
DELIMITER $$
CREATE TRIGGER maxSalary 
BEFORE INSERT ON employee
FOR EACH ROW 
BEGIN
IF NEW.e_salary > 7000 THEN SET NEW.e_salary = 7000;
END IF;
END $$
DELIMITER ;

/* Trigger 3 - Set description by default. */
DELIMITER $$
CREATE TRIGGER bookingDescription 
BEFORE INSERT ON booking
FOR EACH ROW 
BEGIN
SET NEW.b_description = 'Room reservation.';
END $$
DELIMITER ;
