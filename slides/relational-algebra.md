% Relational Algebra
% CS 4400



# Relational Algebra

Relational model specifies stuctures and constraints, relational algebra provides retrieval operations

- Formal foundation for relational model operations
- Basis for internal query optimization in RDBMS
- Parts of relational algebra found in SQL

# Basic Rules

- Relational algebra expressions operate on relations and produce relations
- Relational algebra expressions can be chained

# Practical Setup

To make it easier to see relational algebra in action, we'll use examples from a simplified humane society database.


Shelter(<u>SID</u>, name)

+------------+------+
| <u>SID</u> | Name |
+------------+------+

Pet

+------------+------------+------+---------+
| <u>SID</u> | <u>PID</u> | Name | Species |
+------------+------------+------+---------+


# Select

<center>
$\sigma_{<condition>}(R)$
</center>

Where

- `<condition>` is a boolean expression
- `R` is the name of a relation


# Select SQL Equivalent

The relational algebra `SELECT` operator is represented by the `WHERE` clause of an SQL `SELECT` query.

For the quert

# Select Example

# Project

# Naming Intermediate Results

# Union

# Intersect

# Set Difference

# Cartesian Product

# Join

# Equijoin

# Natural Join

# Division

# Complete Set of Relational Operations

# Query Trees
