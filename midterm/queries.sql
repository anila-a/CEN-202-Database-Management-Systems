/* CEN 202 Database Management Systems - Midterm */
/* Author: Anila Hoxha 
   Last date modified: 05/30/2020 */

/* QUERIES */
/* 3 more queries are in the stored_functions file. */

/* Q4 - Display booking id, date, and guest information for each reservation. */
SELECT b_id AS 'Booking ID', b_date AS 'Booking Date', g_name_1 AS 'First Name', g_surname_1 AS 'Last Surname', g_idCard AS 'Card No.' 
	from booking inner join guest on b_gstID = g_id;
    
/* Q5 - Display guests information whose concierge named Tyler served. */
SELECT g_id AS 'Guest ID', g_name_1 AS 'First Name', g_surname_1 AS 'Last Name' FROM guest, employee WHERE g_emplID = e_id AND e_name = 'Tyler';

/* Q6 - Find the number of workers in each position. */
SELECT e_position AS 'Job Position', COUNT(*) AS 'No. of Workers' 
	FROM employee WHERE e_position in ('General Manager', 'Concierge', 'Group Sales Person', 'Event Planner', 'Executive Chef', 'Housekeeper')
		GROUP BY e_position;
    
/* Q7 - Display room and menu information for each guest. */
SELECT g_id AS 'Guest ID', g_name_1 AS 'First Name', g_surname_1 AS 'Last Name', r_id AS 'Room No.', r_type AS 'Room Type', m_type AS 'Menu Type' 
	FROM guest INNER JOIN room ON r_gstID = g_id
		INNER JOIN menu ON m_roomID = r_id;
        
/* Q8 - Find guest names who requested room menu of type 4. */
SELECT g_name_1 AS 'First Name', g_surname_1 AS 'Last Name' FROM guest INNER JOIN room ON r_gstID = g_id 
	INNER JOIN menu ON m_roomID = r_id AND m_type = 'Menu 4';

/* Q9 - Find guest names who payed for a reservation in the parking lot and calculate the price to be paid. */
SELECT g_name_1 AS 'First Name', g_surname_1 AS 'Last Name', p_hours * p_price AS 'Total Price' 
	FROM guest INNER JOIN booking ON b_gstID = g_id 
		INNER JOIN parking ON p_bookingID = b_id;
    
/* Q10 - Find the type of service which was requested on March 22 and the id of the guest who made the reservation. */
SELECT s_type AS 'Service Type', g_id AS 'Guest ID' FROM guest, service WHERE s_gstID = g_id AND s_reservationDate = '2020-03-22';
