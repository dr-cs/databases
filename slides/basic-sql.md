% Basic SQL
% CS 4400

# Sturctured Query Language

- Practical implementation of the relational model
- Originally SEQUEL (Structured English QEUry Language) at IBM research
- SQL became standard in 1986
- Supported by all major RDBMS vendors, with minor (and sometimes major) differences

SQL's big advantage: if you stick to ANSI SQL, your database code is portable between RDBMS systems.

# SQL Relational Model

- Relations are *tables*
- Tuples are *rows*
- Attributes are *columns*

For the most part these terms are interchangeable.

- Important difference: tables allow duplicate rows

# Schemas and Catalogs

A *schema* (database in the relational model) is a collection of related tables and constructs. A schema has:

- a cchema name
- an authorization identifier (user who owns the schema)

In MySQL `create schema` is a synonym for `create database`.

A catalog is a named collection of schemas. MySQL includes a `table_catalog` column in its `information_schema.tables` table for compatibility with the SQL standard, but does not use catalogs.

# CREATE TABLE

The `CREATE TABLE` command creates a *base table* (`CREATE VIEW` creates a *virtual* or *derived* table):

General form:
```sql
CREATE TABLE <table_name> (
 <column_name> <column_type> <column_constraints>...,
 [... ,]
 <table_constraints>,
 [...]
);
```

# CREATE TABLE Example

```sql
CREATE TABLE pub (
  pub_id INT PRIMARY KEY,
  title VARCHAR(16) NOT NULL,
  book_id INT NOT NULL REFERENCES book(book_id)
);
```

By convention, SQL keywords are in ALL CAPS in instructional examples but not when typing.

Note: see [pubs.sql](http://www.cc.gatech.edu/~simpkins/teaching/gatech/cs4400/resources/pubs.sql) for examples of SQL database creation and population commands.

# Attribute Types

- Numeric data types
    - Integer numbers: INTEGER, INT, and SMALLINT
    - Floating-point (real) numbers: FLOAT or REAL, and DOUBLE PRECISION
- Character-string data types
    - Fixed length: CHAR(n), CHARACTER(n)
    - Varying length: VARCHAR(n), CHAR VARYING(n), CHARACTER VARYING(n)

# Bits and Booleans

- Bit-string data types
    - Fixed length: BIT(n)
    - Varying length: BIT VARYING(n)
- Boolean data type
    - Values of TRUE or FALSE or NULL
- Dates and Timestamps
    - YEAR, MONTH, and DAY in the form YYYY-MM-DD
    - Multiple mapping functions available in RDBMSs to change date formats

# Constraints

- Attribute (a.k.a. column) constraints
- Key (a.k.a. unique)
- Primary key
- Foreign key

We'll also learn named constraints, assertions and triggers when in Advanced SQL.

# Key and Primary Key Constraints

Key:

```sql
  name CHAR(10) UNIQUE,
```


Primary key:
```sql
  pub_id INT PRIMARY KEY,
```

A primary key is implicitly `UNIQUE`

# Foreign Key Constratins

```sql
  book_id INT NOT NULL REFERENCES book(book_id)
```

Notice also that we don't allow `book_id` to be `NULL`. So `pub` totally participates in its relationship with `book`.


# CHECK Constraints

```sql
CREATE TABLE bartender (
  id INT PRIMARY KEY,
  name VARCHAR(10) NOT NULL,
  age INT CHECK (age > 20)
);
```

Note: MySQL does not enforce `CHECK` constraints. We'll learn about triggers in Advanced SQL.

# Retrieval: The SELECT-FROM-WHERE Structure

```sql
SELECT <attributes>
FROM <tables>
WHERE <conditions>
```

From relational algebra:
- `SELECT <attributes>` corresponds to projection
- `FROM <tables>` specifies the table in parentheses in a relational algebra expression and joins
- `WHERE <conditions>` corresponds to selection

# Projection

$\pi_{first\_name, last\_name}(author)$

```sql
mysql> select first_name, last_name from author;
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| John       | McCarthy  |
| Dennis     | Ritchie   |
| Ken        | Thompson  |
| Claude     | Shannon   |
| Alan       | Turing    |
| Alonzo     | Church    |
| Perry      | White     |
| Moshe      | Vardi     |
| Roy        | Batty     |
+------------+-----------+
9 rows in set (0.00 sec)
```

# Asterisk

```sql
mysql> select * from author;
+-----------+------------+-----------+
| author_id | first_name | last_name |
+-----------+------------+-----------+
|         1 | John       | McCarthy  |
|         2 | Dennis     | Ritchie   |
|         3 | Ken        | Thompson  |
|         4 | Claude     | Shannon   |
|         5 | Alan       | Turing    |
|         6 | Alonzo     | Church    |
|         7 | Perry      | White     |
|         8 | Moshe      | Vardi     |
|         9 | Roy        | Batty     |
+-----------+------------+-----------+
9 rows in set (0.00 sec)
```

Notice that with no condition on select, all rows returned.

# Select

$\sigma_{year = 2012}(book)$

```sql
mysql> select * from book where year = 2012;
+---------+------------+-------+------+--------+
| book_id | book_title | month | year | editor |
+---------+------------+-------+------+--------+
|       7 | AAAI       | July  | 2012 |      9 |
|       8 | NIPS       | July  | 2012 |      9 |
+---------+------------+-------+------+--------+
2 rows in set (0.00 sec)
```

# INSERT Command

General form is
```sql
INSERT INTO <table_name> (<column_name> [, ...]) VALUES (<new_value> [, ...]);
```

Example:
```sql
insert into author (author_id, first_name, second_name)
    values (1, "Jenny","McCarthy");
```

Can leave off column names list to insert positionally:
```sql
insert into author values (1, "Jenny","McCarthy");
```

# UPDATE Command

General form:
```sql
UPDATE <table_name> SET <column_name>=<new_value> [, ...] WHERE expression
```

Example: Surely we meant Lisp inventor, AI co-founder, and Turing Award winner
John McCarthy instead of anti-vaxxer Jenny McCarthy.
```sql
update author set first_name='John' where last_name='McCarthy';
```

Notice that we can use single or double quotes in most RDBMS systems.

# DELETE Command

General form:
```sql
DELETE FROM <table_name> WHERE <boolean_expression>;
```

Example:
```sql
delete from author where last_name="Batty";
```

Can also drop whole tables:
```sql
DROP TABLE <table_name>
```

# Referential Integrity

To maintain integrity on update or delete specify:

- For `ON DELETE`:
    - `SET NULL`
    - `SET DEFAULT`
- For `ON UPDATE`
    - `CASCADE`

Note: for MySQL `ON DELETE RESTRICT` is the default.

# Referential Integrity - SET NULL

Example:
```sql
CREATE TABLE pub (
  pub_id INT PRIMARY KEY,
  title VARCHAR(16) NOT NULL,
  book_id INT,
  foreign key (book_id) REFERENCES book(book_id) ON DELETE SET NULL
);
```

Means that if the row from the `book` table containing `book_id` is deleted, then `book_id` is set to `NULL` for each affected row in the `pub` table.

Notice that if you choose `SET NULL` as your `ON DELETE` action your column definition must allow nulls.

# Referential Integrity in MySQL

MySQL will only enforce referential integrity contraints that are specfied separately from column definitions as above. The following syntax:

```sql
CREATE TABLE pub (
  pub_id INT PRIMARY KEY,
  title VARCHAR(16) NOT NULL,
  book_id INT REFERENCES book(book_id) ON DELETE SET NULL
);
```
is valid SQL syntax but is ignored by MySQL's default InnoDB engine.

# Referential Integrity - SET DEFAULT

Example:
```sql
CREATE TABLE pub (
  pub_id INT PRIMARY KEY,
  title VARCHAR(16) NOT NULL,
  book_id INT DEFAULT 0 REFERENCES book(book_id) ON DELETE SET DEFAULT
);
```

Means that if the row from the `book` table containing `book_id` is deleted, then `book_id` is set to `0` for each affected row in the `pub` table.

Note: MySQL's default InnoDB engine does not implement `ON DELETE SET DEFAULT`.

# Referential Integrity - CASCADE

Example:
```sql
CREATE TABLE pub (
  pub_id INT PRIMARY KEY,
  title VARCHAR(16) NOT NULL,
  book_id INT NOT NULL,
  FOREIGN KEY (book_id) REFERENCES book(book_id) ON UPDATE CASCADE
);
```

Means that if a `book_id` value changes for a row in the `book` table, the change is applied to the affected rows of the `pub` table also.

# Multiple Referential Integrity Constraints

You would normally set contraints for updates and deletes.

Example:
```sql
CREATE TABLE pub (
  pub_id INT PRIMARY KEY,
  title VARCHAR(16) NOT NULL,
  book_id INT,
  FOREIGN KEY (book_id) REFERENCES book(book_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);
```

# Simple Database: Dorms

1. Download [dorms.sql](../resources/dorms.sql)
2. On the command line, go to the directory where you downloaded dorms.sql
3. Make sure your MySQL server is running:
    ```sh
    $ mysql.server start
    Starting MySQL
    SUCCESS!
    ```
4. Run the `dorms.sql` script like this:
    ```sh
    $ mysql -u root -p < dorms.sql
    Enter password:
    ```

# Running Queries on the Dorms Database

Start MySQL's client and `use` the `dorms` database.

    ```sh
    $ mysql -u root -p
    Enter password:
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    ...
    mysql> use dorms
    ...
    Database changed
    mysql>
    ```

# Exploring the Database

Get a list of the tables:

```sql
mysql> show tables;
+-----------------+
| Tables_in_dorms |
+-----------------+
| dorm            |
| student         |
+-----------------+
2 rows in set (0.00 sec)
```

See the structure of a table:

```sql
mysql> describe dorm;
+---------+---------+------+-----+---------+-------+
| Field   | Type    | Null | Key | Default | Extra |
+---------+---------+------+-----+---------+-------+
| dorm_id | int(11) | NO   | PRI | NULL    |       |
| name    | text    | YES  |     | NULL    |       |
| spaces  | int(11) | YES  |     | NULL    |       |
+---------+---------+------+-----+---------+-------+
3 rows in set (0.00 sec)
```

# Simple Queries on Dorms Database

- What are the names of all the dorms?
- Which students are in Armstrong?

# More Advanced Queries

After we learn joins and aggregate functions in Advanced SQL we'll be able to answer questions like these:

- What is the total capacity (number of spaces) for all dorms?
- Which student has the highest GPA?
- Which dorm has the most students?
- Which dorm’s students have the highest average GPA?
