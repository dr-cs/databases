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



# Constraints

# Primary Key Constraints



# Foreign Key Constratins

# CHECK Constraints

# Retrieval Queries

# The SELECT-FROM-WHERE Structure

# Aliasing and Renaming

# Tuple Variables

# Unspecified WHERE Clause

# Astrisks

# SQL Tables as Sets

# String Pattern Matching

# Arithmetic Operators

# Example Queries

- From pubs database

# INSERT Command

# DELETE Command

# UPDATE Command
