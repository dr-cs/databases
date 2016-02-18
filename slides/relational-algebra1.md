% Relational Algebra, Part 1
% CS 4400


# Relational Algebra

Relational model specifies stuctures and constraints, relational algebra provides retrieval operations

- Formal foundation for relational model operations
- Basis for internal query optimization in RDBMS
- Parts of relational algebra found in SQL

# Basic Rules

- Relational algebra expressions operate on relations and produce relations as results
- Relational algebra expressions can be chained

# `SELECT`

<center>
$\sigma_{<condition>}(R)$
</center>

- $R$ is the name of a relation
- $<condition>$ is a boolean condition on the values of attributes in the tuples of $R$

The select operation returns all the tuples from $R$ for which $<condition>$ is true.

# `SELECT` Example

Given the following data for `pet`:

```
+------------+----+--------+-----------+
| shelter_id | id | name   | breed     |
+------------+----+--------+-----------+
|          1 |  1 | Chloe  | Mix       |
|          1 |  2 | Dante  | GSD       |
|          1 |  3 | Heidi  | Dachshund |
|          2 |  1 | Bailey | Mix       |
|          2 |  2 | Sophie | Lab       |
|          2 |  3 | Heidi  | Dachshund |
+------------+----+--------+-----------+
```

$\sigma_{breed='mix'}(pet)$ returns:

```
+------------+----+--------+-----------+
| shelter_id | id | name   | breed     |
+------------+----+--------+-----------+
|          1 |  1 | Chloe  | Mix       |
|          2 |  1 | Bailey | Mix       |
+------------+----+--------+-----------+
```

# Properties of `SELECT`

- Result of $\sigma_{<condition>}(R)$ has same schema as $R$, i.e., same attributes
- SELECT is commutative, e.g.,

    $\sigma_{<c1>}(\sigma_{<c2>}(R))$ = $\sigma_{<c2>}(\sigma_{<c1>}(R))$

- Cascaded SELECTs can be replaced by single SELECT with conjuction of conditions, e.g.

    $\sigma_{<c1>}(\sigma_{<c2>}(R))$ = $\sigma_{<c1> AND <c2>}(R)$

- Result of $\sigma_{<condition>}(R)$ has equal or fewer tuples than $R$

# `PROJECT`

<center>
$\pi_{<attribute list>}(R)$
</center>

- $R$ is the name of a relation
- $<attribute list>$ is a subset of the attributes of relation $R$

The project operation returns all the tuples in $R$ but with only the attributes in $<attribute-list>$

# `PROJECT` Example

Given the following data for `pet`:

```
+------------+----+--------+-----------+
| shelter_id | id | name   | breed     |
+------------+----+--------+-----------+
|          1 |  1 | Chloe  | Mix       |
|          1 |  2 | Dante  | GSD       |
|          1 |  3 | Heidi  | Dachshund |
|          2 |  1 | Bailey | Mix       |
|          2 |  2 | Sophie | Lab       |
|          2 |  3 | Heidi  | Dachshund |
+------------+----+--------+-----------+
```

$\pi_{name, breed}(pet)$ returns:

```
+--------+-----------+
| name   | breed     |
+--------+-----------+
| Chloe  | Mix       |
| Dante  | GSD       |
| Heidi  | Dachshund |
| Bailey | Mix       |
| Sophie | Lab       |
+--------+-----------+
```

Notice that the duplicate tuple `<Heidi, Dachshund>` was removed. Results of relational algebra operations are sets.

# Properties of `PROJECT`

- Number of tuples returned by `PROJECT` is less than or equal to the number of tuples in the input relation because result is a set, i.e., $|\pi_{<attrs>}(R)| \le |R|$

    - What if $<attrs>$ includes a key of $R$?

- `PROJECT` is *not* commutative. In fact $\pi_{<attrs1>}(\pi_{<attrs2>}(R))$ is only a correct expression if $<attrs2>$ contains the attributes in $<attrs1>$. In this case the result is simply $\pi_{<attrs1>}(R)$.

# Combining `PROJECT` and `SELECT`

```
+------------+----+--------+-----------+
| shelter_id | id | name   | breed     |
+------------+----+--------+-----------+
|          1 |  1 | Chloe  | Mix       |
|          1 |  2 | Dante  | GSD       |
|          1 |  3 | Heidi  | Dachshund |
|          2 |  1 | Bailey | Mix       |
|          2 |  2 | Sophie | Lab       |
|          2 |  3 | Heidi  | Dachshund |
+------------+----+--------+-----------+
```

$\pi_{name}(\sigma_{breed='Mix'}(pet))$ produces:

```
+--------+
| name   |
+--------+
| Chloe  |
| Bailey |
+--------+
```

# Intermediate Results

Previous *in-line expression* could be split up into multiple steps with named intermediate results.

$\pi_{name}(\sigma_{breed='Mix'}(pet))$

becomes:

$MIXES \leftarrow \sigma_{breed='Mix'}(pet)$

$RESULT \leftarrow \pi_{name}(MIXES)$

# `RENAME`

- Rename relation $R$ to $S$:

    $\rho_{S}(R)$

- Rename attributes of $R$ to $B_1, ... B_n$:

    $\rho_{(B_1, ..., B_n)}(R)$

- Rename $R$ to $S$ and attributes to $B_1, ... B_n$:

    $\rho_{S(B_1, ..., B_n)}(R)$

# Binary Operators

- UNION, $R \cup S$, is set of all tuples in either $R$ or $S$
- INTERSECTION, $R \cap S$, is set of all tuples in both $R$ and $S$
- SET DIFFERENCE, $R - S$, is set of all tuples in $R$ but not in $S$

Operands must be *union compatible*, or *type compatible*. For $R$ and $S$ to be union compatible:

- Degree of $R$ bust be same as degree of $S$
- For each attribute $A_i$ in $R$ and $B_i$ in $S$, $dom(A_i) = dom(B_i)$

# Cartesian Product

$R \times S$ Creates "super-tuples" by concatenating every tuple in $R$ with every tuple in $S$.

$R(A_1, ..., A_n) \times S(B_1, ..., B_m) =  Q(A_1, ..., A_n, B_1, ..., B_m)$

Notice that

- $Q$ has degree $n + m$
- $|q(Q)| = |r(R)| \times |s(S)|$

Note that the book abusses notation a bit and writes that last bullet as
$|Q| = |R| \times |S|$

# Cartesian Product Example

<table>
<tr>
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
<td>
pet
```
+------------+----+--------+-----------+
| shelter_id | id | name   | breed     |
+------------+----+--------+-----------+
|          1 |  1 | Chloe  | Mix       |
|          1 |  2 | Dante  | GSD       |
|          1 |  3 | Heidi  | Dachshund |
|          2 |  1 | Bailey | Mix       |
|          2 |  2 | Sophie | Lab       |
|          2 |  3 | Heidi  | Dachshund |
+------------+----+--------+-----------+
```
</td>
</tr>
</table>

# Cross Product Example

```
+-----+---------+------------+-----+--------+-----------+
| sid | sname   | shelter_id | pid | pname  | breed     |
+-----+---------+------------+-----+--------+-----------+
|   1 | Howell  |          1 |   1 | Chloe  | Mix       |
|   2 | Mansell |          1 |   1 | Chloe  | Mix       |
|   1 | Howell  |          1 |   2 | Dante  | GSD       |
|   2 | Mansell |          1 |   2 | Dante  | GSD       |
|   1 | Howell  |          1 |   3 | Heidi  | Dachshund |
|   2 | Mansell |          1 |   3 | Heidi  | Dachshund |
|   1 | Howell  |          2 |   1 | Bailey | Mix       |
|   2 | Mansell |          2 |   1 | Bailey | Mix       |
|   1 | Howell  |          2 |   2 | Sophie | Lab       |
|   2 | Mansell |          2 |   2 | Sophie | Lab       |
|   1 | Howell  |          2 |   3 | Heidi  | Dachshund |
|   2 | Mansell |          2 |   3 | Heidi  | Dachshund |
+-----+---------+------------+-----+--------+-----------+
```

Note that we've also done a `RENAME` to disambiguate `name`s and `id`s:

$\rho_{(sid, sname, shelter\_id, pid, pname, breed)}(shelter \times pet)$

# Cross Product and Select

Cross product meaningful when combined with `SELECT`.

$\sigma_{sid = shelter\_id}(\rho_{(sid, sname, shelter\_id, pid, pname, breed)}(shelter \times pet))$

```
+-----+---------+------------+-----+--------+-----------+
| sid | sname   | shelter_id | pid | pname  | breed     |
+-----+---------+------------+-----+--------+-----------+
|   1 | Howell  |          1 |   1 | Chloe  | Mix       |
|   1 | Howell  |          1 |   2 | Dante  | GSD       |
|   1 | Howell  |          1 |   3 | Heidi  | Dachshund |
|   2 | Mansell |          2 |   1 | Bailey | Mix       |
|   2 | Mansell |          2 |   2 | Sophie | Lab       |
|   2 | Mansell |          2 |   3 | Heidi  | Dachshund |
+-----+---------+------------+-----+--------+-----------+
```

$CROSSED \leftarrow shelter \times pet$

$RENAMED \leftarrow \rho_{(sid, sname, shelter\_id, pid, pname, breed)}(CROSSED)$

$RESULT \leftarrow \sigma_{sid = shelter\_id}(RENAMED)$
