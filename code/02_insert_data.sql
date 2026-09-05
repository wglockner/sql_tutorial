-- ============================================================
--  02_insert_data.sql
--  Loads the sample rows from the assignment handout.
--  Run this file SECOND, one time, after 01_create_tables.sql
-- ============================================================

-- INSERT INTO table (columns) VALUES (values);
-- Text values go in single quotes. Numbers do not.
-- You can insert several rows at once by separating them with commas.

INSERT INTO BRANCH (Branch_Number, Branch_Name, Branch_Location, Number_Employees) VALUES
    (1, 'Henry''s Ames', '101 Main',   20),   -- two single quotes = one apostrophe
    (2, 'Henry''s Boon', '202 Y Ave',  10),
    (3, 'Henry''s East', '801 Grand',  34),
    (4, 'Henry''s West', '1612 Anton', 20);

INSERT INTO PUBLISHER (Publisher_Code, Publisher_Name, City, State) VALUES
    ('BB', 'Acme',          'Ames',      'IA'),
    ('PB', 'Rizzoli',       'Milwaukee', 'WI'),
    ('SI', 'Pren Hall',     'Chicago',   'IL'),
    ('BV', 'Maurice Books', 'New York',  'NY');

INSERT INTO BOOK (Book_Code, Book_Title, Publisher_Code, Book_Type, Book_Price, Paper_Back) VALUES
    (180, 'Shyness',       'BB', 'PSY',  8.50, 'Y'),
    (189, 'Kane and Abel', 'PB', 'PB',  12.45, 'N'),
    (200, 'Dbase IV',      'SI', 'CS',  16.50, 'N'),
    (378, 'Case',          'BB', 'ART', 32.00, 'N');

INSERT INTO AUTHOR (Author_Number, Last, First) VALUES
    (1, 'Lee',      'Tom'),
    (2, 'Forsythe', 'Sue'),
    (3, 'Smalley',  'Sarah');

-- Note: author numbers 20, 18 and 16 have no matching row in AUTHOR.
-- This is exactly how the handout lists them. Keep it in mind for question 2b.
INSERT INTO WROTE (Book_Code, Author_Number) VALUES
    (180, 20),
    (189,  1),
    (200, 18),
    (378, 16);

INSERT INTO INVENTORY (Book_Code, Branch_Number, Units_In_Stock) VALUES
    (180, 1, 4),
    (189, 1, 8),
    (200, 2, 3),
    (378, 4, 0);

INSERT INTO SALES_REP (Slsrep_Number, Last, First, Street, City) VALUES
    ( 3, 'Smith',    'Sally', '121', 'Ames'),
    ( 6, 'Williams', 'Sue',   '222', 'Boone'),
    (12, 'Rogers',   'Sam',   '343', 'Nevada');

INSERT INTO CUSTOMERS (Customer_Number, Last, First, Street, City) VALUES
    (124, 'Bruner',  'Sue', '112', 'Boone'),
    (311, 'Sannier', 'Jim', '321', 'Le Mars'),
    (256, 'Oliver',  'Tom', '412', 'Corydon');

INSERT INTO ORDERS (Order_Number, Order_Date, Customer_Number) VALUES
    (12489, '2002-12-06', 124),
    (12491, '2003-05-09', 256),
    (12501, '2005-09-14', 311);
