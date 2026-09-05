# Bookstore SQL Lab — Learning SQL with VS Code

**IE 481/581 · SQL Assignment companion tutorial**

This tutorial takes you from "I have never written SQL" to completing every question on the SQL assignment, using only free tools: **Visual Studio Code** and a small file-based database called **SQLite**. Nothing to sign up for, no server to install.

Plan on about 90 minutes.

## What's in this folder

| File | What it is | When you use it |
|---|---|---|
| `01_create_tables.sql` | Builds the nine empty tables | Once, in Step 5 |
| `02_insert_data.sql` | Loads the rows from the handout | Once, in Step 6 |
| `03_assignment.sql` | Your worksheet — write your answers here | Part C |
| `bookstore.db` | A finished copy of the database | Only if you get stuck in Part A |
| `04_answer_key.sql` | Instructor answer key | Instructor only |

---

## Part A — Set up your tools

### Step 1. Install Visual Studio Code

1. Go to <https://code.visualstudio.com> and click the big download button for your operating system.
2. Run the installer. On Windows, accept the defaults but **check "Add to PATH"** if it is offered.
3. Open VS Code. You should see the Welcome tab.

### Step 2. Install the SQLite extension

VS Code does not understand databases on its own. An *extension* adds that ability.

1. In VS Code click the **Extensions** icon in the left bar (four squares), or press `Ctrl+Shift+X` (`Cmd+Shift+X` on Mac).
2. In the search box type **`alexcvzz.vscode-sqlite`**.
3. The result is called **SQLite** by *alexcvzz*. Click **Install**.
4. When it finishes you will see a new **SQLITE EXPLORER** section at the bottom of the Explorer pane (the file list). It's empty for now.

> This extension ships with its own copy of SQLite, so on Windows and Mac there is nothing else to install.

### Step 3. Make a project folder and open it

1. Create a folder somewhere you'll find it again, for example `Documents\sql-lab`.
2. Copy the `.sql` files from this tutorial into that folder.
3. In VS Code choose **File → Open Folder…** and pick `sql-lab`. Click **Yes, I trust the authors** if asked.
4. The Explorer pane now lists your `.sql` files.

Everything else in this tutorial happens inside this folder.

### Step 4. Create an empty database file

A SQLite database is just one file. An empty file is a valid, empty database.

1. In the Explorer pane, hover over the folder name and click the **New File** icon.
2. Name it exactly **`bookstore.db`** and press Enter.
3. An empty editor opens. Close it — there's nothing to type here.

### Step 5. Create the tables

1. Click `01_create_tables.sql` to open it. Read the comments (lines starting with `--`); they explain each table.
2. Press **`Ctrl+Shift+Q`** (this runs the command **SQLite: Run Query**). You can also press `F1`, type *Run Query*, and choose it.
3. A list of databases appears at the top of the window. Click **`bookstore.db`**.
4. A **SQLite** results panel opens beside your editor. For `CREATE TABLE` statements it just confirms the statements ran.
5. Look at **SQLITE EXPLORER** at the bottom-left. Expand `bookstore.db`. You should see all nine tables:
   `AUTHOR, BOOK, BRANCH, CUSTOMERS, INVENTORY, ORDERS, PUBLISHER, SALES_REP, WROTE`

**Run this file only once.** Running it again gives `table BRANCH already exists`. If that happens see Troubleshooting.

### Step 6. Load the data

1. Open `02_insert_data.sql` and press `Ctrl+Shift+Q`. Choose `bookstore.db` again if asked.
2. Check it worked: press `Ctrl+N` for a new file, type

   ```sql
   SELECT * FROM BOOK;
   ```

   and press `Ctrl+Shift+Q`. You should see:

   | Book_Code | Book_Title | Publisher_Code | Book_Type | Book_Price | Paper_Back |
   |---|---|---|---|---|---|
   | 180 | Shyness | BB | PSY | 8.5 | Y |
   | 189 | Kane and Abel | PB | PB | 12.45 | N |
   | 200 | Dbase IV | SI | CS | 16.5 | N |
   | 378 | Case | BB | ART | 32.0 | N |

   `*` means "every column". Try `SELECT * FROM PUBLISHER;` and the other tables too.

You now have a working database. Time to learn to ask it questions.

---

## Part B — SQL in ten minutes

### The shape of a query

Every question you ask a database is a `SELECT` statement with up to four parts, always in this order:

```sql
SELECT   column1, column2        -- WHAT you want to see
FROM     table_name              -- WHERE it lives
WHERE    some_condition          -- WHICH rows to keep (optional)
ORDER BY column1 DESC;           -- HOW to sort (optional)
```

Capitalising keywords like `SELECT` is a convention, not a rule. Table and column names are not case-sensitive either. **Text values inside quotes are case-sensitive**: `'Boone'` and `'boone'` are different.

### Filtering with WHERE

| Operator | Meaning | Example |
|---|---|---|
| `=` | equals | `WHERE City = 'Ames'` |
| `<>` or `!=` | not equal | `WHERE Book_Type <> 'CS'` |
| `<`, `<=`, `>`, `>=` | comparisons | `WHERE Units_In_Stock <= 5` |
| `BETWEEN a AND b` | inclusive range | `WHERE Book_Price BETWEEN 10 AND 15` |
| `AND`, `OR` | combine conditions | `WHERE First = 'Tom' AND Last = 'Lee'` |
| `LIKE` | pattern match, `%` = anything | `WHERE Book_Title LIKE 'K%'` |

Text goes in **single quotes**. Numbers do not. Every statement ends with a **semicolon**.

### Sorting with ORDER BY

`ORDER BY Book_Title` sorts A→Z. `ORDER BY Book_Title DESC` sorts Z→A.

### Joining two tables

The BOOK table stores only a publisher *code* (`BB`). The publisher's name and city live in PUBLISHER. To see them together you **join** the tables on the column they share:

```sql
SELECT BOOK.Book_Title, PUBLISHER.Publisher_Name
FROM   BOOK
       JOIN PUBLISHER ON BOOK.Publisher_Code = PUBLISHER.Publisher_Code;
```

Read the `ON` clause as: "match a BOOK row to a PUBLISHER row whenever their Publisher_Code is the same." Writing `TABLE.column` says which table a column comes from, which matters when both tables have a column with the same name.

You can chain joins to reach a third table. That's what question 2b needs.

### Running one query at a time

`Ctrl+Shift+Q` runs **everything** in the file, or **only the highlighted text** if you have selected some. In your worksheet, highlight a single query with the mouse before pressing the shortcut so you see one result at a time.

---

## Part C — The assignment

Open `03_assignment.sql`. For each question:

1. Decide **which table** has the data (see the schema reference at the end).
2. Decide **which columns** you need to show.
3. Decide **which condition** picks the right rows.
4. Type the query under the question, highlight it, press `Ctrl+Shift+Q`.
5. Compare your result with the expected one below. Then screenshot or export it (Part D).

Try each one yourself before opening the solution.

### 1) Single table queries

#### 1a. List the first and last name of sales reps from Boone.

*Hint:* table `SALES_REP`, columns `First` and `Last`, condition on `City`.

<details><summary>Solution</summary>

```sql
SELECT First, Last
FROM   SALES_REP
WHERE  City = 'Boone';
```

| First | Last |
|---|---|
| Sue | Williams |

</details>

#### 1b. List the book titles for books that are NOT book type CS.

*Hint:* `<>` means "not equal".

<details><summary>Solution</summary>

```sql
SELECT Book_Title
FROM   BOOK
WHERE  Book_Type <> 'CS';
```

| Book_Title |
|---|
| Shyness |
| Kane and Abel |
| Case |

</details>

#### 1c. List the book codes that have inventory levels less than or equal to 5.

*Hint:* the stock count is in `INVENTORY`, not `BOOK`.

<details><summary>Solution</summary>

```sql
SELECT Book_Code
FROM   INVENTORY
WHERE  Units_In_Stock <= 5;
```

| Book_Code |
|---|
| 180 |
| 200 |
| 378 |

</details>

#### 1d. List the books that cost between $10.00 and $15.00.

*Hint:* `BETWEEN` includes both ends. Don't type the `$` sign.

<details><summary>Solution</summary>

```sql
SELECT Book_Title, Book_Price
FROM   BOOK
WHERE  Book_Price BETWEEN 10.00 AND 15.00;
```

| Book_Title | Book_Price |
|---|---|
| Kane and Abel | 12.45 |

</details>

### 2) Multi table queries

#### 2a. Display the title of each book and the publisher's name and city you would contact to reorder it.

*Hint:* BOOK and PUBLISHER share `Publisher_Code`.

<details><summary>Solution</summary>

```sql
SELECT BOOK.Book_Title, PUBLISHER.Publisher_Name, PUBLISHER.City
FROM   BOOK
       JOIN PUBLISHER ON BOOK.Publisher_Code = PUBLISHER.Publisher_Code;
```

| Book_Title | Publisher_Name | City |
|---|---|---|
| Shyness | Acme | Ames |
| Kane and Abel | Rizzoli | Milwaukee |
| Dbase IV | Pren Hall | Chicago |
| Case | Acme | Ames |

</details>

#### 2b. List the book titles from the author TOM LEE, sorted in descending alphabetical order.

*Hint:* BOOK doesn't know its authors. `WROTE` links `Book_Code` to `Author_Number`, and `AUTHOR` has the names. That's two joins.

<details><summary>Solution</summary>

```sql
SELECT BOOK.Book_Title
FROM   BOOK
       JOIN WROTE  ON BOOK.Book_Code      = WROTE.Book_Code
       JOIN AUTHOR ON WROTE.Author_Number = AUTHOR.Author_Number
WHERE  AUTHOR.First = 'Tom'
  AND  AUTHOR.Last  = 'Lee'
ORDER BY BOOK.Book_Title DESC;
```

| Book_Title |
|---|
| Kane and Abel |

Only one row comes back. Look at WROTE: only book 189 points to author 1 (Tom Lee). The other author numbers (20, 18, 16) have no matching row in AUTHOR, so those books drop out of the join. A join only keeps rows that match on **both** sides.

</details>

---

## Part D — Turning it in

The assignment asks for each SQL command **and** the results it produced.

- **Your SQL** is in `03_assignment.sql`. Save it with `Ctrl+S`.
- **Your results** are in the SQLite results panel. For each query either
  - take a screenshot (`Win+Shift+S` on Windows, `Cmd+Shift+4` on Mac) and paste it into your write-up, or
  - hover the result table's header in the panel and use the export buttons to save it as CSV or HTML.
- Submit the `.sql` file plus your results, following your instructor's directions.

---

## Troubleshooting

| You see | Why | Fix |
|---|---|---|
| `no such table: BOOK` | The query ran against the wrong database, or Step 5 never ran. | Press `Ctrl+Shift+Q` and be sure to pick `bookstore.db`. Expand SQLITE EXPLORER to confirm the tables exist. |
| `table BRANCH already exists` | You ran `01_create_tables.sql` twice. | Delete `bookstore.db` in the Explorer, redo Steps 4–6. |
| `UNIQUE constraint failed` | You ran `02_insert_data.sql` twice. | Same fix as above. |
| `near "...": syntax error` | A typo: missing comma, quote, or semicolon; a stray `$`. | Compare against the examples. Check every `'` has a partner. |
| Empty result, no error | The condition matched nothing, usually capitalisation inside quotes. | `'Boone'` not `'boone'`. Check spelling against the schema reference. |
| No database picker appears | The extension didn't find a `.db` file in the open folder. | Make sure you opened the *folder* (File → Open Folder), not just a file, and that `bookstore.db` is inside it. |
| Extension won't run at all | Rare on Windows/Mac; Linux needs `sqlite3` installed. | Alternative: install **SQLite3 Editor** (`yy0931.vscode-sqlite3-editor`), click `bookstore.db`, open **Query Editor**, and run with `Shift+Enter`. |

Stuck in Part A? Copy the provided `bookstore.db` into your folder and go straight to Part B.

---

## Schema reference — the nine tables

Column names are what you type in queries. Values shown are the sample data.

**BRANCH**

| Branch_Number | Branch_Name | Branch_Location | Number_Employees |
|---|---|---|---|
| 1 | Henry's Ames | 101 Main | 20 |
| 2 | Henry's Boon | 202 Y Ave | 10 |
| 3 | Henry's East | 801 Grand | 34 |
| 4 | Henry's West | 1612 Anton | 20 |

**PUBLISHER**

| Publisher_Code | Publisher_Name | City | State |
|---|---|---|---|
| BB | Acme | Ames | IA |
| PB | Rizzoli | Milwaukee | WI |
| SI | Pren Hall | Chicago | IL |
| BV | Maurice Books | New York | NY |

**BOOK**

| Book_Code | Book_Title | Publisher_Code | Book_Type | Book_Price | Paper_Back |
|---|---|---|---|---|---|
| 180 | Shyness | BB | PSY | 8.50 | Y |
| 189 | Kane and Abel | PB | PB | 12.45 | N |
| 200 | Dbase IV | SI | CS | 16.50 | N |
| 378 | Case | BB | ART | 32.00 | N |

**AUTHOR**

| Author_Number | Last | First |
|---|---|---|
| 1 | Lee | Tom |
| 2 | Forsythe | Sue |
| 3 | Smalley | Sarah |

**WROTE**

| Book_Code | Author_Number |
|---|---|
| 180 | 20 |
| 189 | 1 |
| 200 | 18 |
| 378 | 16 |

**INVENTORY**

| Book_Code | Branch_Number | Units_In_Stock |
|---|---|---|
| 180 | 1 | 4 |
| 189 | 1 | 8 |
| 200 | 2 | 3 |
| 378 | 4 | 0 |

**SALES_REP**

| Slsrep_Number | Last | First | Street | City |
|---|---|---|---|---|
| 3 | Smith | Sally | 121 | Ames |
| 6 | Williams | Sue | 222 | Boone |
| 12 | Rogers | Sam | 343 | Nevada |

**CUSTOMERS**

| Customer_Number | Last | First | Street | City |
|---|---|---|---|---|
| 124 | Bruner | Sue | 112 | Boone |
| 311 | Sannier | Jim | 321 | Le Mars |
| 256 | Oliver | Tom | 412 | Corydon |

**ORDERS**

| Order_Number | Order_Date | Customer_Number |
|---|---|---|
| 12489 | 2002-12-06 | 124 |
| 12491 | 2003-05-09 | 256 |
| 12501 | 2005-09-14 | 311 |

---

## Appendix — the same thing from the command line

If you already have the `sqlite3` program installed, you can skip the extension. In the VS Code terminal (`Ctrl+\``):

```bash
sqlite3 bookstore.db ".read 01_create_tables.sql" ".read 02_insert_data.sql"
sqlite3 -box bookstore.db "SELECT * FROM BOOK;"
```

`-box` draws the result as a table. Type `sqlite3 bookstore.db` alone to get an interactive prompt; `.tables` lists tables and `.quit` exits.
