% Advanced SQL
% CS 4400


# Many to Many Relationships

A single author can write many publications, and a single publication can have many authors. This is a many-to-many relationship, which is modeled in relational databases with a relationship (or link or bridge) table.

```sql
CREATE TABLE IF NOT EXISTS author_pub (
  author_id INTEGER NOT NULL REFERENCES author(author_id),
  pub_id INTEGER NOT NULL REFERENCES publication(pub_id),
  author_position INTEGER NOT NULL, -- first author, second, etc?
  PRIMARY KEY (author_id, pub_id)
);
```
`author_pub` tables links the `author` and `pub` tables

- `author_id` and `pub_id` are foreign keys to `author` and `pub` tables
- `(author_id, pub_id) is composite key for the table

# Queries in Depth

```
SELECT [DISTINCT] <select_header> FROM <source_tables>
WHERE <filter_expression>
GROUP BY <grouping_expressions>
HAVING <filter_expression>
ORDER BY <ordering_expressions>
LIMIT <count> OFFSET <count>
```

- The table is the fundamental data abstraction in a relational
database.
- The select command returns its result as a table
- Think of a select statement as creating a pipeline, each stage of which produces an intermediate working table

# The SELECT Pipeline

The evaluation order of select clauses is approximately:

1. `FROM <source_tables>` - Designates one or more source tables and
combines them together into one large working table.
2. `WHERE <filter_expression>` - Filters specific rows of working table
3. `GROUP BY <grouping_expressions>` - Groups sets of rows in the working table based on similar values
4. `SELECT <select_heading>` - Defines the result set columns and (if applicable) grouping aggregates.

# SELECT Pipeline (Continued)

5. `HAVING <filter_expression>` - Filters specific rows of the grouped table. Requires a GROUP BY
6. `DISTINCT` - Eliminates duplicate rows.
7. `ORDER BY <ordering_expressions> - Sorts the rows of the result set
8. `OFFSET <count>` - Skips over rows at the beginning of the result set. Requires a LIMIT.
9. `LIMIT <count>` - Limits the result set output to a specific number of rows.

# The FROM Clause

The `FROM` clause takes one or more source tables from the database and combines them into one (large) table using the `JOIN` operator. Three kinds of joins:

- CROSS JOIN
- INNER JOIN
- OUTER JOIN

Sicne DB designs are typically factored into many tables, the join is the most important part of a query.

# CROSS JOIN

A CROSS JOIN matches every row of the first table with every row of the second table. Think of a cross join as a cartesian product.

The general syntax for a cross join is:

```sql
SELECT select_header FROM table1 CROSS JOIN table2
```

or

```sql
SELECT <select_header> FROM <table1>, <table2>
```

# CROSS JOIN EXAMPLE

```sql
mysql> select * from pub cross join book;
+--------+-----------------+---------+---------+------------+----------+------+--------+
| pub_id | title           | book_id | book_id | book_title | month    | year | editor |
+--------+-----------------+---------+---------+------------+----------+------+--------+
|      1 | LISP            |       1 |       1 | CACM       | April    | 1960 |      8 |
|      2 | Unix            |       2 |       1 | CACM       | April    | 1960 |      8 |
|      3 | Info Theory     |       3 |       1 | CACM       | April    | 1960 |      8 |
|      4 | Turing Machines |       4 |       1 | CACM       | April    | 1960 |      8 |
|      5 | Turing Test     |       5 |       1 | CACM       | April    | 1960 |      8 |
|      6 | Lambda Calculus |       6 |       1 | CACM       | April    | 1960 |      8 |
|      1 | LISP            |       1 |       2 | CACM       | July     | 1974 |      8 |
|      2 | Unix            |       2 |       2 | CACM       | July     | 1974 |      8 |
|      3 | Info Theory     |       3 |       2 | CACM       | July     | 1974 |      8 |
|      4 | Turing Machines |       4 |       2 | CACM       | July     | 1974 |      8 |
|      5 | Turing Test     |       5 |       2 | CACM       | July     | 1974 |      8 |
|      6 | Lambda Calculus |       6 |       2 | CACM       | July     | 1974 |      8 |
|      1 | LISP            |       1 |       3 | BST        | July     | 1948 |      2 |
|      2 | Unix            |       2 |       3 | BST        | July     | 1948 |      2 |
|      3 | Info Theory     |       3 |       3 | BST        | July     | 1948 |      2 |
|      4 | Turing Machines |       4 |       3 | BST        | July     | 1948 |      2 |
|      5 | Turing Test     |       5 |       3 | BST        | July     | 1948 |      2 |
|      6 | Lambda Calculus |       6 |       3 | BST        | July     | 1948 |      2 |
|      1 | LISP            |       1 |       4 | LMS        | November | 1936 |      7 |
|      2 | Unix            |       2 |       4 | LMS        | November | 1936 |      7 |
|      3 | Info Theory     |       3 |       4 | LMS        | November | 1936 |      7 |
|      4 | Turing Machines |       4 |       4 | LMS        | November | 1936 |      7 |
|      5 | Turing Test     |       5 |       4 | LMS        | November | 1936 |      7 |
|      6 | Lambda Calculus |       6 |       4 | LMS        | November | 1936 |      7 |
|      1 | LISP            |       1 |       5 | Mind       | October  | 1950 |   NULL |
|      2 | Unix            |       2 |       5 | Mind       | October  | 1950 |   NULL |
|      3 | Info Theory     |       3 |       5 | Mind       | October  | 1950 |   NULL |
|      4 | Turing Machines |       4 |       5 | Mind       | October  | 1950 |   NULL |
|      5 | Turing Test     |       5 |       5 | Mind       | October  | 1950 |   NULL |
|      6 | Lambda Calculus |       6 |       5 | Mind       | October  | 1950 |   NULL |
|      1 | LISP            |       1 |       6 | AMS        | Month    | 1941 |   NULL |
|      2 | Unix            |       2 |       6 | AMS        | Month    | 1941 |   NULL |
|      3 | Info Theory     |       3 |       6 | AMS        | Month    | 1941 |   NULL |
|      4 | Turing Machines |       4 |       6 | AMS        | Month    | 1941 |   NULL |
|      5 | Turing Test     |       5 |       6 | AMS        | Month    | 1941 |   NULL |
|      6 | Lambda Calculus |       6 |       6 | AMS        | Month    | 1941 |   NULL |
|      1 | LISP            |       1 |       7 | AAAI       | July     | 2012 |      9 |
|      2 | Unix            |       2 |       7 | AAAI       | July     | 2012 |      9 |
|      3 | Info Theory     |       3 |       7 | AAAI       | July     | 2012 |      9 |
|      4 | Turing Machines |       4 |       7 | AAAI       | July     | 2012 |      9 |
|      5 | Turing Test     |       5 |       7 | AAAI       | July     | 2012 |      9 |
|      6 | Lambda Calculus |       6 |       7 | AAAI       | July     | 2012 |      9 |
|      1 | LISP            |       1 |       8 | NIPS       | July     | 2012 |      9 |
|      2 | Unix            |       2 |       8 | NIPS       | July     | 2012 |      9 |
|      3 | Info Theory     |       3 |       8 | NIPS       | July     | 2012 |      9 |
|      4 | Turing Machines |       4 |       8 | NIPS       | July     | 2012 |      9 |
|      5 | Turing Test     |       5 |       8 | NIPS       | July     | 2012 |      9 |
|      6 | Lambda Calculus |       6 |       8 | NIPS       | July     | 2012 |      9 |
+--------+-----------------+---------+---------+------------+----------+------+--------+
48 rows in set (0.00 sec)
```

# Inner Joins

A simple inner join uses an on condition.
```sql
mysql> select * from pub join book on pub.book_id = book.book_id;
+--------+-----------------+---------+---------+------------+----------+------+--------+
| pub_id | title           | book_id | book_id | book_title | month    | year | editor |
+--------+-----------------+---------+---------+------------+----------+------+--------+
|      1 | LISP            |       1 |       1 | CACM       | April    | 1960 |      8 |
|      2 | Unix            |       2 |       2 | CACM       | July     | 1974 |      8 |
|      3 | Info Theory     |       3 |       3 | BST        | July     | 1948 |      2 |
|      4 | Turing Machines |       4 |       4 | LMS        | November | 1936 |      7 |
|      5 | Turing Test     |       5 |       5 | Mind       | October  | 1950 |   NULL |
|      6 | Lambda Calculus |       6 |       6 | AMS        | Month    | 1941 |   NULL |
+--------+-----------------+---------+---------+------------+----------+------+--------+
6 rows in set (0.00 sec)
```

Notice that `book_id` appears twice, becuase we get one from each source table. We can fix that ...

# Natural Joins

The using clause, also called a natural join, joins on a like-named column from each table and includes it only once.

```sql
mysql> select * from pub join book using (book_id);
+---------+--------+-----------------+------------+----------+------+--------+
| book_id | pub_id | title           | book_title | month    | year | editor |
+---------+--------+-----------------+------------+----------+------+--------+
|       1 |      1 | LISP            | CACM       | April    | 1960 |      8 |
|       2 |      2 | Unix            | CACM       | July     | 1974 |      8 |
|       3 |      3 | Info Theory     | BST        | July     | 1948 |      2 |
|       4 |      4 | Turing Machines | LMS        | November | 1936 |      7 |
|       5 |      5 | Turing Test     | Mind       | October  | 1950 |   NULL |
|       6 |      6 | Lambda Calculus | AMS        | Month    | 1941 |   NULL |
+---------+--------+-----------------+------------+----------+------+--------+
6 rows in set (0.00 sec)
```

# Joining Multiple Tables

Remember that we linked the `author` table to the `pub` table using the `author_pub` table to model the many-to-many relationship between authors and publications. We can join all three tables by chaining join clauses:

```sql
mysql> select * from author join author_pub using (author_id) join pub using (pub_id);
+--------+-----------+------------+-----------+-----------------+-----------------+---------+
| pub_id | author_id | first_name | last_name | author_position | title           | book_id |
+--------+-----------+------------+-----------+-----------------+-----------------+---------+
|      1 |         1 | John       | McCarthy  |               1 | LISP            |       1 |
|      2 |         2 | Dennis     | Ritchie   |               1 | Unix            |       2 |
|      2 |         3 | Ken        | Thompson  |               2 | Unix            |       2 |
|      3 |         4 | Claude     | Shannon   |               1 | Info Theory     |       3 |
|      4 |         5 | Alan       | Turing    |               1 | Turing Machines |       4 |
|      5 |         5 | Alan       | Turing    |               1 | Turing Test     |       5 |
|      6 |         6 | Alonzo     | Church    |               1 | Lambda Calculus |       6 |
+--------+-----------+------------+-----------+-----------------+-----------------+---------+
7 rows in set (0.01 sec)

```

# String Matching with `LIKE`

Our where condition can match a pattern with like. Use a % for wildcard, i.e., matching any character sequence.

Which publications have "Turing" in their titles?

```sql
elect * from pub where title like 'Turing%';
+--------+-----------------+---------+
| pub_id | title           | book_id |
+--------+-----------------+---------+
|      4 | Turing Machines |       4 |
|      5 | Turing Test     |       5 |
+--------+-----------------+---------+
2 rows in set (0.00 sec)
```

Note that strings are not case-sensitive.


# `GROUP BY`

The `GOUR BY` clause groups the results in the working table by the specified column value

- we can apply an aggregate function to the resulting groups
- if we don’t apply an aggregate function, only the last row of a group is returned
    - Since the order of rows unspecified, failing to apply an aggregate function would essentially give us a random result

```sql
mysql> select author_id, last_name
    -> from author join author_pub using (author_id) join pub using (pub_id)
    -> group by author_id;
+-----------+-----------+
| author_id | last_name |
+-----------+-----------+
|         1 | McCarthy  |
|         2 | Ritchie   |
|         3 | Thompson  |
|         4 | Shannon   |
|         5 | Turing    |
|         6 | Church    |
+-----------+-----------+
6 rows in set (0.00 sec)

```

Notice that Turing has two pubs, but appears only once.

# Aggregate Functions

Aggregate functions apply some function the to rows grouped together by a `GROUP BY` clause.

How many papers did each author write?

```sql
mysql> select author_id, last_name, count(author_id)
    -> from author join author_pub using (author_id) join pub using (pub_id)
    -> group by author_id;
+-----------+-----------+------------------+
| author_id | last_name | count(author_id) |
+-----------+-----------+------------------+
|         1 | McCarthy  |                1 |
|         2 | Ritchie   |                1 |
|         3 | Thompson  |                1 |
|         4 | Shannon   |                1 |
|         5 | Turing    |                2 |
|         6 | Church    |                1 |
+-----------+-----------+------------------+
6 rows in set (0.00 sec)
```

Notice that the aggregate function is applied to the column that you `GROUP BY`.

# Sorting, Aliasing, and Limiting

Who wrote the most publications?

```sql
mysql> select author_id, last_name, count(author_id) as pub_count
    -> from author join author_pub using (author_id) join pub using (pub_id)
    -> group by author_id
    -> order by pub_count desc;
+-----------+-----------+-----------+
| author_id | last_name | pub_count |
+-----------+-----------+-----------+
|         5 | Turing    |         2 |
|         1 | McCarthy  |         1 |
|         2 | Ritchie   |         1 |
|         6 | Church    |         1 |
|         3 | Thompson  |         1 |
|         4 | Shannon   |         1 |
+-----------+-----------+-----------+
6 rows in set (0.00 sec)
```

Notice that we also used an alias so we could reference the count in the order by clause

# Limiting Results

If we want only the answer from the last query we can use `LIMIT`:

Who wrote the most publications?

```sql
mysql> select author_id, last_name, count(author_id) as pub_count
    -> from author join author_pub using (author_id) join pub using (pub_id)
    -> group by author_id
    -> order by pub_count desc
    -> limit 1;
+-----------+-----------+-----------+
| author_id | last_name | pub_count |
+-----------+-----------+-----------+
|         5 | Turing    |         2 |
+-----------+-----------+-----------+
1 row in set (0.00 sec)
```

# `HAVING`

In the previous query we got the top author by pub count. If we want all authors having a particular pub count, we can use a `HAVING` clause.

```sql
mysql> select author_id, last_name, count(author_id) as pub_count
    -> from author join author_pub using (author_id) join pub using (pub_id)
    -> group by author_id
    -> having count(*) = 1;
+-----------+-----------+-----------+
| author_id | last_name | pub_count |
+-----------+-----------+-----------+
|         1 | McCarthy  |         1 |
|         2 | Ritchie   |         1 |
|         3 | Thompson  |         1 |
|         4 | Shannon   |         1 |
|         6 | Church    |         1 |
+-----------+-----------+-----------+
5 rows in set (0.01 sec)
```

We can use comparisons like <, >. Notice that `Turing` is not in the result.

# HAVING vs. WHERE Conditions

Functionally HAVING and WHERE do the same thing: they filter-in tuples. The difference is where they are evaluated in the SELECT pipeline.

- WHERE is evaluated only after the FROM clause that selects the source tables, so WHERE clauses can only reference expressions that do not contain aggregate functions
- HAVING is evaluated after GROUP BY, and SELECT, so HAVING clauses can reference any result column

Also be aware that rows filtered out by a WHERE clause will not be included in a GROUP BY clause
