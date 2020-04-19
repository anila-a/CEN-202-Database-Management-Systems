SELECT * FROM trade_company.CLIENTS, trade_company.EMPLOYEES, trade_company.INVOICE,
	trade_company.INVOICE_DESCRIPTION, trade_company.PRODUCT;
    
/* Query 1: Retrieve the name and surname of all clients who live in Cardiff */
SELECT CName, CSurname FROM trade_company.CLIENTS WHERE Address = 'Cardiff, UK';

/* Query 2: Retrieve all the information of the employees whose phone number starts with 029 948 */
SELECT * FROM trade_company.EMPLOYEES WHERE Phone LIKE '029 948%';

/* Query 3: Retrieve all the information of the clients and employees whose surname is Brown */
SELECT * FROM trade_company.CLIENTS, trade_company.EMPLOYEES WHERE CSurname = 'Brown' AND ESurname = 'Brown';

/* Query 4: Retrieve for all invoices the ids and the products information */
SELECT ID, PID, PName, Product_Description, Quantity, Price, Due_Date
	FROM trade_company.INVOICE, trade_company.INVOICE_DESCRIPTION, trade_company.PRODUCT
	WHERE PR_IID = IID AND INV_ID = ID;

/* Query 5: Retrieve for all invoices the cashier name and the effect of a 10% discount on the total price */
SELECT ID, Total_Value - 0.1 * Total_Value, EName
	FROM trade_company.INVOICE, trade_company.EMPLOYEES WHERE INV_EID = EID