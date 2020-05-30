/* CEN 202 Database Management Systems - Midterm */
/* Author: Anila Hoxha 
   Last date modified: 05/30/2020 */

/* STORED PROCEDURES */

/* Stored Procedure 1 - Retrieve information for guests registered under the employee whose ID is given. */
DELIMITER $$
CREATE PROCEDURE getGuestInfo(IN empl_id CHAR(8))
BEGIN
SELECT g_id, g_name_1, g_surname_1, g_address
FROM guest
WHERE g_emplID = empl_id;
END $$
DELIMITER ;

CALL getGuestInfo('1002022');

/* Stored Procedure 2 - Retrieve the number of workers for the specified employment position. */
DELIMITER $$
CREATE PROCEDURE getNrOfWorkers(IN empl_position ENUM('General Manager', 'Concierge', 'Group Sales Person', 'Event Planner', 'Executive Chef', 'Housekeeper'),
OUT total INT)
BEGIN
SELECT COUNT(*)
INTO total
FROM employee
WHERE e_position = empl_position;
END$$
DELIMITER ;

CALL getNrOfWorkers('Concierge', @total);
SELECT @total AS 'Number of Workers in Position';

/* Stored Procedure 3 - Calculate the menu price for the room whose ID is given. */
DELIMITER $$
CREATE PROCEDURE getMenuPrice(IN room_id CHAR(3), OUT price INT)
BEGIN 
DECLARE typeOfMenu ENUM('Menu 1', 'Menu 2', 'Menu 3', 'Menu 4');
SELECT m_type INTO typeOfMenu FROM menu WHERE m_roomID = room_id;
IF typeOfMenu = 'Menu 1' THEN
	SET price = 35;
ELSEIF typeOfMenu = 'Menu 2' THEN
	SET price = 45;
ELSEIF typeOfMenu = 'Menu 3' THEN
	SET price = 50;
ELSEIF typeOfMenu = 'Menu 4' THEN
	SET price = 60;
END IF;
END $$
DELIMITER ;

CALL getMenuPrice('407', @price);
SELECT @price AS 'Menu Price';
