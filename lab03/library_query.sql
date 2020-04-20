SELECT * FROM library.BOOK, library.LIBRARY, library.MEMBERS, library.PUBLISHER;

/* Query 1: Update the ISBN in row 1 to match the format */
UPDATE library.BOOK SET ISBN = '1-03256-098-2' WHERE Book_BID = '1298473802';

/* Query 2: Retrieve all the information of the publisher contacts whose name starts with 'ma' */
SELECT * FROM library.PUBLISHER WHERE Contact_Person LIKE 'Ma%';

/* Query 3: Retrieve the book title, author, and ISBN of all the books registered in Library 1 */
SELECT Library_Description, Title, Author, ISBN FROM library.LIBRARY, library.BOOK WHERE BID = '1298473801' AND Book_BID = BID;

/* Query 4: Add a new book from Tolstoy's worklist */
INSERT INTO BOOK VALUE 
('6-39028-107-9', 'War And Peace', 'Leo Tolstoy', '2008-09-11', '451', '1298473804');

/* Query 5: Retrieve the books information published from Mae Smith */
SELECT Title, Author, ISBN FROM library.PUBLISHER, library.BOOK WHERE Contact_Person = 'Mae Smith' AND Book_PUBID = PUBID;

/* Query 6: Retrieve the contact information of the Tolstoy books publisher */
SELECT DISTINCT Contact_Person, Contact_Description FROM library.PUBLISHER, library.BOOK WHERE Author = 'Leo Tolstoy' AND Book_PUBID = PUBID;
