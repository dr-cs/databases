% Relational Data Model
% CS 4400
% Note: these slides are incomplete!

# Relational Data Model

A *relation schema* $R(A_a, ..., A_n)$ is a relation name $R$ and a list of attributes $A_1, ..., A_n$.

Each attribute $A_i$ is the name of a role played by some domain $D$.

- Example:  $AUTHOR(author\_id, first\_name, last\_name)$

    - $dom(A_1)$ (or $dom(author\_id)$) is integer

A *database schema* is a collection of relation schemas.

- Example: $PUBS$ database has relation schemas $BOOK$, $AUTHOR$, and $PUB$ (for publication, not public house)


# Relations and Databases

A *relation*, or *relation state*, $r(R)$ is a **set** of tuples that conform to a *relation schema* $R$.

- Example: $r(AUTHOR)$ =

    ```
    +-----------+------------+-----------+
    | author_id | first_name | last_name |
    +-----------+------------+-----------+
    |         1 | John       | McCarthy  |
    |         4 | Claude     | Shannon   |
    |         5 | Alan       | Turing    |
    |         6 | Alonzo     | Church    |
    +-----------+------------+-----------+
    ```

A *database* is a set of relations.

# Tuples

A *tuple* is an **ordered list** of values that is part of a relation

- Example: $t_1 =$ `<1, 'John', 'McCarthy'>`

Each value in the tuple is that tuple's value for the corresponding attribute of the relation schema.

- Example: (these are equivalent notations):

    - $t_1[first\_name] =$ `'John'` (bracket notation)
    - $t_1.first\_name =$ `'John'` (object notation)
    - $t_1[2] =$ `'John'` (positional notation)

The *degree* or *arity* of a relation is the number of attributes of its relation schema.

- Example: $AUTHOR$ has degree 3.

# Attributes and Domains

Each attribute has a name and a *domain*

- The name describes the role played by the attribute

    - Example: the $first\_name$ attribute of the $AUTHOR$ schema plays the role of the first name of an author represented by a tuple in a $r(AUTHOR)$ relation.

- The domain is a set of atomic values that a tuple may have for that attribute.

    - A *logical definition* of a domain specifies a simple type such as integer or string, and a *data type* or *format*

        - Example: `USA_phone_number` as $(ddd) ddd-dddd$, where $d$ is a digit

# Mathematical Definition of Relation

Given $R(A_1, ..., A_n)$, $r(R) \subseteq (dom(A_1) \times dom(A_2) \times ... \times dom(A_n)$

The total number of values, or *cardinality*, of a domain $D$ is $|D|$.

So the maximum number of tuples that could possibly be in $r(R)$ is

$|dom(A_1)| \times |dom(A_2)| \times ... \times |dom(A_n)|$

# Properties of Relations

- Atomicity of values

- Nulls

- Closed world assumption

# Constraints

- Inherent model-based (or *implicit*) constraints
- Schema-based (or *explicit*) contstraints
- Application-based (or semantic constraints), a.k.a., business rules

# Superkeys

A superkey $SK$ is a set of attributes of a relation schema $R$ such that

<center>
$t_i[SK] \ne t_j[SK]$
</center>

for any $i \ne j$.

In other words, the values of the superkey attributes of a tuple uniquely identify the tuple within the relation.

By the definition of the relational model, the full attribute set of a relation schema is a *default superkey*.

# Keys

A *minimal superkey* is a superkey removing an attribute would make it no longer unique, and thus no longer a superkey.

We call a minimal superkey a *key*.

A relation schema may have several keys. We call these *candidate keys* and choose one arbitrarily to be the *primary key*.

We underline the primary key in a relation schema.

- Example: $AUTHOR(\underline{author\_id}, first\_name, last\_name)$

# Databases and Integrity Constraints

# Entity Integrity Constraints

# Referential Integrity Constraints

# Semantic Integrity Constraints

# Constraint Violations on Insert

# Constraint Violations on Update

# Constraint Violations on Delete
