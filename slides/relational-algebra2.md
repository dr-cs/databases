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

# Another Join Example

How would we find all the workers who work at Mansell?

$worker \Join_{shelter\_id = sid \land sname = 'Mansell'} \rho_{(sid, sname)}(shelter)$

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

# Natural Join

Notice that the `shelter_id` attribute was repeated in the previous equijoin result. A `NATURAL JOIN` is a equijoin in which the redundant attribute has been removed.

<center>
$R * S$
</center>

Where

- $R$ and $S$ have an attribute with the same name and same domain which is automatically chosen as the equijoin attribute

# Natural Join Example

Recall the first join example. If we rename the `id` attribute to `shelter_id` we can use a natural join:

$\rho_{(shelter_id, sname)}(shelter) * worker$

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



# Division


# Outer Join
