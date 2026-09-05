-- ============================================================
--  04_answer_key.sql  (INSTRUCTOR ANSWER KEY)
--  IE 481/581 SQL Assignment
-- ============================================================

-- ============ 1) SINGLE TABLE QUERIES ============

-- 1a) First and last name of sales reps from Boone.
SELECT First, Last
FROM   SALES_REP
WHERE  City = 'Boone';

-- 1b) Book titles for books that are NOT type CS.
--     (  <>  means "not equal".  !=  also works in SQLite.)
SELECT Book_Title
FROM   BOOK
WHERE  Book_Type <> 'CS';

-- 1c) Book codes with inventory less than or equal to 5.
SELECT Book_Code
FROM   INVENTORY
WHERE  Units_In_Stock <= 5;

-- 1d) Books that cost between $10.00 and $15.00 (BETWEEN is inclusive).
SELECT Book_Title, Book_Price
FROM   BOOK
WHERE  Book_Price BETWEEN 10.00 AND 15.00;

-- ============ 2) MULTI TABLE QUERIES ============

-- 2a) Title of each book plus the publisher name and city to reorder from.
--     Join BOOK to PUBLISHER on the column they share: Publisher_Code.
SELECT BOOK.Book_Title,
       PUBLISHER.Publisher_Name,
       PUBLISHER.City
FROM   BOOK
       JOIN PUBLISHER ON BOOK.Publisher_Code = PUBLISHER.Publisher_Code;

-- 2b) Book titles by Tom Lee, sorted Z -> A.
--     Three tables: BOOK -> WROTE -> AUTHOR.
--     Only book 189 links to author 1 (Tom Lee), so one row comes back.
SELECT BOOK.Book_Title
FROM   BOOK
       JOIN WROTE  ON BOOK.Book_Code      = WROTE.Book_Code
       JOIN AUTHOR ON WROTE.Author_Number = AUTHOR.Author_Number
WHERE  AUTHOR.First = 'Tom'
  AND  AUTHOR.Last  = 'Lee'
ORDER BY BOOK.Book_Title DESC;
