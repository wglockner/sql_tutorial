-- ============================================================
--  01_create_tables.sql
--  Creates the nine tables used in the IE 481/581 SQL Assignment.
--  Run this file FIRST, one time, against an empty bookstore.db
-- ============================================================

-- Lines that start with two dashes are comments. SQL ignores them.
-- Every SQL statement ends with a semicolon ( ; ).

-- Turn on foreign key checking (SQLite has it off by default).
PRAGMA foreign_keys = ON;

-- ---------- BRANCH ----------
-- One row per bookstore branch.
CREATE TABLE BRANCH (
    Branch_Number     INTEGER PRIMARY KEY,   -- unique id for each branch
    Branch_Name       TEXT    NOT NULL,
    Branch_Location   TEXT,
    Number_Employees  INTEGER
);

-- ---------- PUBLISHER ----------
CREATE TABLE PUBLISHER (
    Publisher_Code    TEXT PRIMARY KEY,      -- short code such as 'BB'
    Publisher_Name    TEXT NOT NULL,
    City              TEXT,
    State             TEXT
);

-- ---------- BOOK ----------
-- Publisher_Code is a FOREIGN KEY: it must match a row in PUBLISHER.
CREATE TABLE BOOK (
    Book_Code         INTEGER PRIMARY KEY,
    Book_Title        TEXT    NOT NULL,
    Publisher_Code    TEXT    REFERENCES PUBLISHER(Publisher_Code),
    Book_Type         TEXT,                  -- PSY, PB, CS, ART ...
    Book_Price        REAL,                  -- dollars, e.g. 8.50
    Paper_Back        TEXT                   -- 'Y' or 'N'
);

-- ---------- AUTHOR ----------
CREATE TABLE AUTHOR (
    Author_Number     INTEGER PRIMARY KEY,
    Last              TEXT NOT NULL,
    First             TEXT NOT NULL
);

-- ---------- WROTE ----------
-- Links books to authors (a "bridge" table).
-- Its primary key is the PAIR of columns, so the same book/author
-- combination can only appear once.
CREATE TABLE WROTE (
    Book_Code         INTEGER REFERENCES BOOK(Book_Code),
    Author_Number     INTEGER,
    PRIMARY KEY (Book_Code, Author_Number)
);

-- ---------- INVENTORY ----------
-- How many copies of each book each branch has on the shelf.
CREATE TABLE INVENTORY (
    Book_Code         INTEGER REFERENCES BOOK(Book_Code),
    Branch_Number     INTEGER REFERENCES BRANCH(Branch_Number),
    Units_In_Stock    INTEGER,
    PRIMARY KEY (Book_Code, Branch_Number)
);

-- ---------- SALES_REP ----------
CREATE TABLE SALES_REP (
    Slsrep_Number     INTEGER PRIMARY KEY,
    Last              TEXT NOT NULL,
    First             TEXT NOT NULL,
    Street            TEXT,
    City              TEXT
);

-- ---------- CUSTOMERS ----------
CREATE TABLE CUSTOMERS (
    Customer_Number   INTEGER PRIMARY KEY,
    Last              TEXT NOT NULL,
    First             TEXT NOT NULL,
    Street            TEXT,
    City              TEXT
);

-- ---------- ORDERS ----------
-- Dates are stored as text in YYYY-MM-DD form so they sort correctly.
CREATE TABLE ORDERS (
    Order_Number      INTEGER PRIMARY KEY,
    Order_Date        TEXT,
    Customer_Number   INTEGER REFERENCES CUSTOMERS(Customer_Number)
);
