% Relational Algebra, Part 2
% CS 4400


# Join

`JOIN` is a `CARTESIAN PRODUCT` followed by `SELECT`

<center>
$R \Join_{<join condition>} S$
</center>

Where

- $R$ and $S$ are relations
- $<join condition>$ is a boolean condition on values of tuples from $R$ and $S$

$R \Join_{<join condition>} S$ returns the tuples in $R \times S$ that satisfy the $<join condition>$

# Join Conditions

$<join condition>$ is of the form $A_i \theta B_j$

- $A_i$ is an attribute of $R$, $B_j$ is an attribute of $S$
- $dom(A_i) = dom(B_j)$
- $\theta$ is one of $\{ =, \ne, \lt, \le, \gt, \ge \}$

A $<join condition>$ can be a conjunction of simple conditions, e.g.:

$<c_1> AND <c_2> ... AND <c_n>$

# Join Example

<table>
<tr>
<td>
worker
```
+----+--------+---------------+------------+
| id | name   | supervisor_id | shelter_id |
+----+--------+---------------+------------+
|  1 | Tom    |          NULL |          1 |
|  2 | Jie    |             1 |          1 |
|  3 | Ravi   |             2 |          1 |
|  4 | Alice  |             2 |          1 |
|  5 | Aparna |          NULL |          2 |
|  6 | Bob    |             5 |          2 |
|  7 | Xaoxi  |             6 |          2 |
|  8 | Rohan  |             6 |          2 |
+----+--------+---------------+------------+
```
</td>
<td>
shelter
```
+----+---------+
| id | name    |
+----+---------+
|  1 | Howell  |
|  2 | Mansell |
+----+---------+
```
</td>
</tr>
</table>


# Join Example

$worker \Join_{shelter\_id = sid} \rho_{(sid, sname)}(shelter)$

```
+----+--------+---------------+------------+-----+---------+
| id | name   | supervisor_id | shelter_id | sid | sname   |
+----+--------+---------------+------------+-----+---------+
|  1 | Tom    |          NULL |          1 |   1 | Howell  |
|  2 | Jie    |             1 |          1 |   1 | Howell  |
|  3 | Ravi   |             2 |          1 |   1 | Howell  |
|  4 | Alice  |             2 |          1 |   1 | Howell  |
|  5 | Aparna |          NULL |          2 |   2 | Mansell |
|  6 | Bob    |             5 |          2 |   2 | Mansell |
|  7 | Xaoxi  |             6 |          2 |   2 | Mansell |
|  8 | Rohan  |             6 |          2 |   2 | Mansell |
+----+--------+---------------+------------+-----+---------+

```

Notice that we had to use renaming of attributes in $shelter$.

A join operation in which the comparison operator $\theta$ is $=$ is called an *equijoin*.


# Natural Join

Notice that the `shelter_id` attribute was repeated in the previous equijoin result. A `NATURAL JOIN` is a equijoin in which the redundant attribute has been removed.

<center>
$R * S$
</center>

Where

- $R$ and $S$ have an attribute with the same name and same domain which is automatically chosen as the equijoin attribute

# Natural Join Example

Recall the first join example. If we rename the `id` attribute to `shelter_id` we can use a natural join:

$\rho_{(shelter\_id, sname)}(shelter) * worker$

```
+------------+---------+----+--------+---------------+
| shelter_id | sname   | id | name   | supervisor_id |
+------------+---------+----+--------+---------------+
|          1 | Howell  |  1 | Tom    |          NULL |
|          1 | Howell  |  2 | Jie    |             1 |
|          1 | Howell  |  3 | Ravi   |             2 |
|          1 | Howell  |  4 | Alice  |             2 |
|          2 | Mansell |  5 | Aparna |          NULL |
|          2 | Mansell |  6 | Bob    |             5 |
|          2 | Mansell |  7 | Xaoxi  |             6 |
|          2 | Mansell |  8 | Rohan  |             6 |
+------------+---------+----+--------+---------------+
```

<!-- # Division -->


# Outer Joins

The joins we've discussed so far have been inner joins. Result relations of inner joins include only tuples from the joined tables that match the join condition.

Outer join results inlude tuples that matched, and tuples that didn't match the join condition.

# Left Outer Join

<center>
$R \unicode{x27d5}_{<join condition>} S$
</center>

Where

- $R$ and $S$ are relations
- $<join condition>$ is a boolean condition on values of tuples from $R$ and $S$

$R \unicode{x275d5}_{<join condition>} S$ returns the tuples in $R \times S$ that satisfy the $<join condition>$ as well as the tuples from $R$ that don't match the join condition. In the result relation the unmatched tuples from $R$ are null-padded to give them the correct degree in the result.

# Left Outer Join Example

<table>
<tr>
<td>
author
```
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
```
</td>
<td>
book
```
+---------+------------+----------+------+--------+
| book_id | book_title | month    | year | editor |
+---------+------------+----------+------+--------+
|       1 | CACM       | April    | 1960 |      8 |
|       2 | CACM       | July     | 1974 |      8 |
|       3 | BST        | July     | 1948 |      2 |
|       4 | LMS        | November | 1936 |      7 |
|       5 | Mind       | October  | 1950 |   NULL |
|       6 | AMS        | Month    | 1941 |   NULL |
|       7 | AAAI       | July     | 2012 |      9 |
|       8 | NIPS       | July     | 2012 |      9 |
+---------+------------+----------+------+--------+
```
</td>
</tr>
</table>

Return all the authors. For all the authors who are editors, show their books.

# Authors and Edited Books

Show all the authors. For all the authors who are editors, show their books.

$R \unicode{x27d5}_{author_id = editor} S$

```
+-----------+------------+-----------+---------+------------+----------+------+--------+
| author_id | first_name | last_name | book_id | book_title | month    | year | editor |
+-----------+------------+-----------+---------+------------+----------+------+--------+
|         8 | Moshe      | Vardi     |       1 | CACM       | April    | 1960 |      8 |
|         8 | Moshe      | Vardi     |       2 | CACM       | July     | 1974 |      8 |
|         2 | Dennis     | Ritchie   |       3 | BST        | July     | 1948 |      2 |
|         7 | Perry      | White     |       4 | LMS        | November | 1936 |      7 |
|         9 | Roy        | Batty     |       7 | AAAI       | July     | 2012 |      9 |
|         9 | Roy        | Batty     |       8 | NIPS       | July     | 2012 |      9 |
|         1 | John       | McCarthy  |    NULL | NULL       | NULL     | NULL |   NULL |
|         3 | Ken        | Thompson  |    NULL | NULL       | NULL     | NULL |   NULL |
|         4 | Claude     | Shannon   |    NULL | NULL       | NULL     | NULL |   NULL |
|         5 | Alan       | Turing    |    NULL | NULL       | NULL     | NULL |   NULL |
|         6 | Alonzo     | Church    |    NULL | NULL       | NULL     | NULL |   NULL |
+-----------+------------+-----------+---------+------------+----------+------+--------+
```

Notice how attribute values are padded to the right in a left outer join.

# Right Outer Join

<center>
$R \unicode{x27d6}_{<join condition>} S$
</center>

Where

- $R$ and $S$ are relations
- $<join condition>$ is a boolean condition on values of tuples from $R$ and $S$

$R \unicode{x275d5}_{<join condition>} S$ returns the tuples in $R \times S$ that satisfy the $<join condition>$ as well as the tuples from $S$ that don't match the join condition. In the result relation the unmatched tuples from $S$ are null-padded to give them the correct degree in the result.




# Right Outer Join Example

Show all the books. For books with editors, show their editors.

$R \unicode{x27d6}_{author_id = editor} S$

```
+-----------+------------+-----------+---------+------------+----------+------+--------+
| author_id | first_name | last_name | book_id | book_title | month    | year | editor |
+-----------+------------+-----------+---------+------------+----------+------+--------+
|         8 | Moshe      | Vardi     |       1 | CACM       | April    | 1960 |      8 |
|         8 | Moshe      | Vardi     |       2 | CACM       | July     | 1974 |      8 |
|         2 | Dennis     | Ritchie   |       3 | BST        | July     | 1948 |      2 |
|         7 | Perry      | White     |       4 | LMS        | November | 1936 |      7 |
|      NULL | NULL       | NULL      |       5 | Mind       | October  | 1950 |   NULL |
|      NULL | NULL       | NULL      |       6 | AMS        | Month    | 1941 |   NULL |
|         9 | Roy        | Batty     |       7 | AAAI       | July     | 2012 |      9 |
|         9 | Roy        | Batty     |       8 | NIPS       | July     | 2012 |      9 |
+-----------+------------+-----------+---------+------------+----------+------+--------+
```

Notice how attribute values are padded to the left in a right outer join.

# Full Outer Join

<center>
$R \unicode{x27d7}_{<join condition>} S$
</center>

Where

- $R$ and $S$ are relations
- $<join condition>$ is a boolean condition on values of tuples from $R$ and $S$

$R \unicode{x275d5}_{<join condition>} S$ returns the tuples in $R \times S$ that satisfy the $<join condition>$ as well as the tuples from both $R$ and $S$ that don't match the join condition. In the result relation the unmatched tuples are null-padded to give them the correct degree in the result.


# Full Outer Join Example

Show all authors and books, matching editors with their books.

$R \unicode{x27d7}_{author_id = editor} S$

```
+-----------+------------+-----------+---------+------------+----------+------+--------+
| author_id | first_name | last_name | book_id | book_title | month    | year | editor |
+-----------+------------+-----------+---------+------------+----------+------+--------+
|         8 | Moshe      | Vardi     |       1 | CACM       | April    | 1960 |      8 |
|         8 | Moshe      | Vardi     |       2 | CACM       | July     | 1974 |      8 |
|         2 | Dennis     | Ritchie   |       3 | BST        | July     | 1948 |      2 |
|         7 | Perry      | White     |       4 | LMS        | November | 1936 |      7 |
|         9 | Roy        | Batty     |       7 | AAAI       | July     | 2012 |      9 |
|         9 | Roy        | Batty     |       8 | NIPS       | July     | 2012 |      9 |
|         1 | John       | McCarthy  |    NULL | NULL       | NULL     | NULL |   NULL |
|         3 | Ken        | Thompson  |    NULL | NULL       | NULL     | NULL |   NULL |
|         4 | Claude     | Shannon   |    NULL | NULL       | NULL     | NULL |   NULL |
|         5 | Alan       | Turing    |    NULL | NULL       | NULL     | NULL |   NULL |
|         6 | Alonzo     | Church    |    NULL | NULL       | NULL     | NULL |   NULL |
|      NULL | NULL       | NULL      |       5 | Mind       | October  | 1950 |   NULL |
|      NULL | NULL       | NULL      |       6 | AMS        | Month    | 1941 |   NULL |
+-----------+------------+-----------+---------+------------+----------+------+--------+
```

# Review Question 1

Given the $r(book)$:

```
+---------+------------+----------+------+--------+
| book_id | book_title | month    | year | editor |
+---------+------------+----------+------+--------+
|       1 | CACM       | April    | 1960 |      8 |
|       2 | CACM       | July     | 1974 |      8 |
|       3 | BST        | July     | 1948 |      2 |
|       4 | LMS        | November | 1936 |      7 |
|       5 | Mind       | October  | 1950 |      7 |
|       6 | AMS        | Month    | 1941 |      7 |
|       7 | AAAI       | July     | 2012 |      9 |
|       8 | NIPS       | July     | 2012 |      9 |
+---------+------------+----------+------+--------+
```

How many tuples are in $\pi_{book\_title}(book)$? (Notice I've abused notation here, since that's how you'll see it in the book and on the test.)

# Review Question 1 Answer

7:
```
+------------+
| book_title |
+------------+
| CACM       |
| BST        |
| LMS        |
| Mind       |
| AMS        |
| AAAI       |
| NIPS       |
+------------+
```
The $book\_title$ appears twice in $book$ and the result of a relational algebra expression is a set.

# Review Question 2

Given the relation $r(book)$:

```
+---------+------------+----------+------+--------+
| book_id | book_title | month    | year | editor |
+---------+------------+----------+------+--------+
|       1 | CACM       | April    | 1960 |      8 |
|       2 | CACM       | July     | 1974 |      8 |
|       3 | BST        | July     | 1948 |      2 |
|       4 | LMS        | November | 1936 |      7 |
|       5 | Mind       | October  | 1950 |      7 |
|       6 | AMS        | Month    | 1941 |      7 |
|       7 | AAAI       | July     | 2012 |      9 |
|       8 | NIPS       | July     | 2012 |      9 |
+---------+------------+----------+------+--------+
```

Which books were published before 1960 or after 2000?

# Review Question 2

Which books were published before 1960 or after 2000?

$\sigma_{year < 1960}(book) \cup \sigma_{year > 2000}(book)$

```
+---------+------------+----------+------+--------+
| book_id | book_title | month    | year | editor |
+---------+------------+----------+------+--------+
|       3 | BST        | July     | 1948 |      2 |
|       4 | LMS        | November | 1936 |      7 |
|       5 | Mind       | October  | 1950 |      7 |
|       6 | AMS        | Month    | 1941 |      7 |
|       7 | AAAI       | July     | 2012 |      9 |
|       8 | NIPS       | July     | 2012 |      9 |
+---------+------------+----------+------+--------+
```

# Review Question 3

Given:
<table>
<tr>
<td>
worker
```
+----+--------+---------------+------------+
| id | name   | supervisor_id | shelter_id |
+----+--------+---------------+------------+
|  1 | Tom    |          NULL |          1 |
|  2 | Jie    |             1 |          1 |
|  3 | Ravi   |             2 |          1 |
|  4 | Alice  |             2 |          1 |
|  5 | Aparna |          NULL |          2 |
|  6 | Bob    |             5 |          2 |
|  7 | Xaoxi  |             6 |          2 |
|  8 | Rohan  |             6 |          2 |
+----+--------+---------------+------------+
```
</td>
<td>
shelter
```
+----+---------+
| id | name    |
+----+---------+
|  1 | Howell  |
|  2 | Mansell |
+----+---------+
```
</td>
</tr>
</table>

How would we find the names of all the workers who work at Mansell?


# Review Question 3 Answer

How would we find all the workers who work at Mansell?

$ MANSELL\_WORKERS \leftarrow worker \Join_{shelter\_id = sid \land sname = 'Mansell'} \rho_{(sid, sname)}(shelter)$

Gives:
```
+----+--------+---------------+------------+-----+---------+
| id | name   | supervisor_id | shelter_id | sid | sname   |
+----+--------+---------------+------------+-----+---------+
|  5 | Aparna |          NULL |          2 |   2 | Mansell |
|  6 | Bob    |             5 |          2 |   2 | Mansell |
|  7 | Xaoxi  |             6 |          2 |   2 | Mansell |
|  8 | Rohan  |             6 |          2 |   2 | Mansell |
+----+--------+---------------+------------+-----+---------+
```
then,

# Review Question 3 Answer

$\pi{name}(MANSELL\_WORKERS)$

gives:

```
+--------+
| name   |
+--------+
| Aparna |
| Bob    |
| Xaoxi  |
| Rohan  |
+--------+
```

Full inline expression:

$ \pi_{name}(worker \Join_{shelter\_id = sid \land sname = 'Mansell'} \rho_{(sid, sname)}(shelter))$