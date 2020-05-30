/* CEN 202 Database Management Systems - Midterm */
/* Author: Anila Hoxha 
   Last date modified: 05/30/2020 */

/* STORED FUNCTIONS */

/* Stored Function 1 - Given the p_id and p_hours, calculate the total amount to be paid by the guest for the reserved parking lot. */
DELIMITER $$
CREATE FUNCTION getParkingPrice(parking_hours FLOAT, parking_id CHAR(8)) RETURNS FLOAT DETERMINISTIC
BEGIN
DECLARE total FLOAT;
IF parking_id LIKE '%0005%' THEN
	SET total = parking_hours * 1.5;
ELSEIF parking_id LIKE '%0006%' THEN
	SET total = parking_hours * 1.7;
END IF;
RETURN (total);
END$$
DELIMITER ;

/* Q1 - Calculate total amount to be paid for the parking lot space reservation. */
SELECT p_id, getParkingPrice(p_hours, p_id) AS 'Total Price' FROM parking;

/* Stored Function 2 - If discount applies, calculate the total amount to be paid for the room. */
DELIMITER $$
CREATE FUNCTION getRoomDiscount(room_type ENUM('Single', 'Double', 'Triple', 'Quad', 'Twin'), duration INTEGER) RETURNS FLOAT DETERMINISTIC
BEGIN
DECLARE price FLOAT;
IF room_type = 'Single' AND duration > '14' THEN
	SET price = 190 * duration;
ELSEIF room_type = 'Quad' AND duration > '7' THEN
	SET price = 310 * duration;
SET price = price - 0.07 * price;
END IF;
RETURN (price);
END$$
DELIMITER ;

/* Q2 - Calculate discount, if applicable. */
select r_type AS 'Room Type', g_stayingDuration AS 'Guest Staying Duration', getRoomDiscount(r_type, g_stayingDuration) AS 'Price with Discount(-10%)' 
	from room inner join guest on r_gstID = g_id;

/* Stored Function 3 - Calculate the total amount to be paid by the guest for all expenses (room price, menu price, service price). */
DELIMITER $$
CREATE FUNCTION getInvoiceTotal(room_type ENUM('Single', 'Double', 'Triple', 'Quad', 'Twin'), 
		menu_type ENUM('Menu 1', 'Menu 2', 'Menu 3', 'Menu 4'), 
        service_type ENUM('Table Service', 'Room Service', 'Taxi Service', 'Event Organization Service', 'Laundry Service', 'Spa Service'),
        staying_duration INTEGER) RETURNS FLOAT DETERMINISTIC
BEGIN 
DECLARE total FLOAT;
IF room_type = 'Single' THEN
	SET total = 190;
ELSEIF room_type = 'Double' THEN
	SET total = 230;
ELSEIF room_type = 'Tripple' THEN
	SET total = 280;
ELSEIF room_type = 'Quad' THEN
	SET total = 310;
ELSEIF room_type = 'Twin' THEN
	SET total = 210;
END IF;
IF menu_type = 'Menu 1' THEN 
	SET total = total + 35;
ELSEIF menu_type = 'Menu 2' THEN
	SET total = total + 45;
ELSEIF menu_type = 'Menu 3' THEN
	SET total = total + 50;
ELSEIF menu_type = 'Menu 4' THEN
	SET total = total + 60;
END IF;
SET total = total * staying_duration;
IF service_type = 'Table Service' THEN
	SET total = total + 40;
ELSEIF service_type = 'Room Service' THEN
	SET total = total + 15;
ELSEIF service_type = 'Taxi Service' THEN
	SET total = total + 50;
ELSEIF service_type = 'Event Organization Service' THEN
	SET total = total + 45;   
ELSEIF service_type = 'Laundry Service' THEN
	SET total = total + 10;   
ELSEIF service_type = 'Spa Service' THEN
	SET total = total + 35;  
ELSEIF service_type = 'None' THEN
	SET total = total;
END IF;
RETURN (total);
END$$
DELIMITER ;

/* Q3 - Calculate total invoice amount to be paid. */
select g_id AS 'Guest ID', r_id AS 'Room Nr', r_type AS 'Room Type', m_type AS 'Menu Type', s_type AS 'Service Type', getInvoiceTotal(r_type, m_type, s_type, g_stayingDuration) AS 'Invoice Amount' 
	from guest inner join room on r_gstID = g_id inner join menu on m_roomID = r_id 
		inner join service on s_gstID = r_gstID;
