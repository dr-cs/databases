---
layout: exercise
title: Dorms Query Exercise
---

# Dorms

## Introduction

In this exercise you will practice

- executing SQL scripts, and
- writing basic SQL queries.

## Problem Description

You work for the housing department of a major university and want to analyze information in your residency database.

## Solution Description

1. Download [dorms-schema.sql](../resources/dorms-schema.sql) and [dorms-data.sql](../resources/dorms-data.sql)
2. On the command line, go to the directory where you downloaded the dorms database scripts.
3. If on macOS, make sure your MySQL server is running:

    ```sh
    $ mysql.server start
    Starting MySQL
    SUCCESS!
    ```

4. Run the ~dorms.sql~ script like this (can leave off -p if your password is blank):

   ```sh
   $ mysql -u root -p < dorms-schema.sql
   $ mysql -u root -p < dorms-data.sql
   ```

### Running Queries on the Dorms Database

Start MySQL's client and ~use~ the ~dorms~ database.

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

### Exploring the Database

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

### Simple Queries on Dorms Database

- What are the names of all the dorms?
- Which students have GPAs greater than 3.0?
- Which students are in Armstrong?
- Rank students by GPA.
- Which student has the top GPA?
