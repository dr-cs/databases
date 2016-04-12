% Basic Relational Design
% CS 4400

# Basic Relational Design

- Basic design approaches.
- What makes a good design better than a bad design?
- How do we tell we have a "good" design?
- How to we go about creating a good design?

# Basic Design Approaches

- Bottom-up, a.k.a. *synthethis*

    - Start with individual attributes and large set of binary relationship among attributes
    - Unpopular

- Top-down, a.k.a. *analysis*

    - Start with groupings of attributes, e.g., a schema derived from ER-relational mapping
    - Decompose until design properties are met


# Relational Design Desiderata

- The sematics of relation schemas and their attributes should be clear
- There should be little or no redundant information in tuples
- The should be few or no NULL values in tuples
- It should be impossible to generate spurious (invalid) tuples


# Clear Semantics of Relation Schemas


# Guideline 1: Convey cohesive meaning in relational schemas


# Redundant Information in Tuples

Redundant information in schemas:

- wastes storage space, and
- leads to data manipulation anomalies.

One way to think of schemas with redundancy: they are joined tables from well-designed schemas.

# Insertion Anomalies

# Deletion Anomalies

# Update (Modification) Anomalies

# Guideline 2: Eliminate data manipulation anomalies

# NULL Values in Tuples

# Guideline 3: Minimize the need for NULL values in tuples

# Spurious Tuples

# Guideline 4: Design relation schemas for natural joins

Design relation schemas to be naturally joined on attributes that are related by foreign key-primary key relationships.

# Functional Dependencies

A generalization of superkeys.

Given a relation schema $R$, and subsets of attributes $\alpha$ and $\beta$, the functional dependedcy

$$
\alpha \rightarrow \beta
$$

Means that for any pair of tuples $t_1$ and $t_2$ in $r(R)$

<center>
if $t_1[\alpha] = t_2[\alpha]$ <br/>
then $t_1[\beta] = t_2[\beta]$
</center>

In other words, whenever the attributes on the left side of a functional dependency are the same for two tuples in the relation, the attributes on the right side of the functional dependency will be equal.

# Relations *Satisfy* FDs

+-------+-------+-------+-------+
|   A   |   B   |   C   |   D   |
+=======+=======+=======+=======+
| $a_1$ | $b_1$ | $c_1$ | $d_1$ |
+-------+-------+-------+-------+
| $a_1$ | $b_2$ | $c_1$ | $d_2$ |
+-------+-------+-------+-------+
| $a_2$ | $b_2$ | $c_2$ | $d_2$ |
+-------+-------+-------+-------+
| $a_2$ | $b_2$ | $c_2$ | $d_3$ |
+-------+-------+-------+-------+
| $a_3$ | $b_3$ | $c_2$ | $d_4$ |
+-------+-------+-------+-------+

$A \rightarrow C$ is satisfied because no two tuples with the same $A$ value have different $C$ values.

$C \rightarrow A$ is not satisfied because we find a
$t_1 = (a_2, b_3, c_2, d_3)$ and
$t_2 = (a_3, b_3, c_2, d_4)$

# Satisfying vs. Holding

We say that a functional dependency $f$ *holds* on a relation if it is not legal to create a tuple that does not satisfy $f$.

+---------+-----------+-----------+
| name    | street    | city      |
+=========+===========+===========+
| Alice   | Elm       | Charlotte |
+---------+-----------+-----------+
| Bob     | Peachtree | Atlanta   |
+---------+-----------+-----------+
| Charlie | Elm       | Charlotte |
+---------+-----------+-----------+

Here $street \rightarrow city$ is satisifed. However, we would not say that it *holds* because we know there *can be* different cities with the same street names.

Though there may be relation states that satisfy a FD, we only include FDs that hold for every possible relation state when we design a database. The set of FDs come from domain knowledge about the data, not a particular set of data.

# Trivial Functional Dependencies

A functional dependency is *trivial* if it is satisfied by all relations.

Formally, a functional dependency $\alpha \rightarrow \beta$ is **trivial** if $\beta \subseteq \alpha$

For example:

$$
A \rightarrow A\\
AB \rightarrow A\\
AB \rightarrow B
$$

are trivial.

# Logically Implied FDs

Given a relation schema $R$, a functional dependency $f$  is logically implied by a set of FDs $F$  if every relation state $r(R)$ that stasifies $F$ also satisfies $f$.

For example, given $R(A, B, C, G, H, I)$ and $F$ =

$$
A \rightarrow B\\
A \rightarrow C\\
CG \rightarrow H\\
CG \rightarrow I\\
B \rightarrow H
$$

The functional dependency $A \rightarrow H$ also holds on R.

# Closure of a Set of FDs

The closure $F^+$ of $F$ is the set of all FDs logically implied by $F$. We can use a set if inference rules known as **Armstrong's Axioms** to derive new FDs.

- **Reflexivity**. If $\beta \subseteq \alpha$, then $\alpha \rightarrow \beta$
- **Augmentation**. If $\alpha \rightarrow \beta$ holds, then $\gamma\alpha \rightarrow \gamma\beta$
- **Transitivity**. If $\alpha \rightarrow \beta$ holds and $\beta \rightarrow \gamma$ holds, then $\alpha \rightarrow \gamma$ holds

Note that $\alpha\beta$ is shorhand for $\alpha \cup \beta$.

Armostrong's axioms are **sound** because they do not produce new FDs that don't hold, and **complete** becuase applying them repeatedly finds $F^+$, i.e., all FDs that are logically implied by $F$.

# Algorithm for Finding $F^+$

The following algorithm applies Armstrong's Axioms repeatedly to find $F^+$.

- Let $F^+ = F$
- **repeat**:
    - **for each** FD $f$ in $F^+$:
        - add results of applying reflexivity and augmentation rules on $f$ to $F^+$
    - **for each** pair of FDs $\alpha \rightarrow \beta$ and $\gamma \rightarrow \delta$ in $F^+$:
        - **if** $\beta = \gamma$, add $\alpha \rightarrow \delta$ to $F^+$
- **until** $F^+$ does not change any further

This algorithm is instructive, but tedious and expensive. There's a better way ...

# Attribute Closure

The normal forms we consider in this class (1NF through BCNF) are based on keys, so we need a way to use FDs to determine the keys of a relation.

If $\alpha$ is a superkey of $R$ then $\alpha \rightarrow R$. In other words, all the attributes of $R$ are determined by $\alpha$.

The set of attributes functionally determined by $\alpha$ under $F$ is the *closure* of $\alpha$ under $F$, denoted $\alpha^+$.

# Algorithm For Computing Attribute Closure

To compute the closure of an attribute set $\alpha$:

- $\alpha^+$ := $\alpha$
- **repeat**:
    - $old\alpha^+$ := $\alpha^+$
    - **for each** functional dependency $Y \rightarrow Z$:
        - if $Y \subseteq \alpha^+$ then $\alpha^+$ := $\alpha^+ \cup Z$
- **until** $\alpha^+$ = $old\alpha^+$


# Attribute Closure Example

Given $R(A, B, C, G, H, I)$ and $F = \{A \rightarrow B, A \rightarrow C, CG \rightarrow H, CG \rightarrow I, B \rightarrow H\}$,

compute $(AG)+$.

The first time we execute the outer loop:

- $A \rightarrow B$ adds $B$ to $(AG)^+$, making $(AG)^+$ = $ABG$.
- $A \rightarrow C$ adds $C$, making $(AG)^+$ = $ABCG$.
- $CG \rightarrow H$ adds $H$, making $(AG)^+$ = $ABCGH$.
- $CG \rightarrow I$ adds $I$, making $(AG)^+$ = $ABCGHI$.

Since $(AG)^+$ now includes all attributes in $R$, the second iteration of the outer loop adds no new attributes, so the algorithm terminates. $(AG)^+$ is a superkey of $R$.

# Uses of Attribute Closure

- Test whether $\alpha$ is a superkey of $R$.
    - If $\alpha^+$ contains all attributes in $R$, then $\alpha$ is a superkey of $R$.

- Checking whether an FD $\alpha \rightarrow \beta$ holds on $R$ under $F$.
    - Compute $\alpha^+$. If $\beta \subseteq \alpha^+$ then $\alpha \rightarrow \beta$ holds.

- An alternate way to compute $F^+$.
    - For each $\gamma \subseteq R$, compute $\gamma^+$
        - For each $S \subseteq \gamma^+$ add FD $\gamma \rightarrow S$ to $F^+$

# Extraneous Attributes in FDs

An attribute of an FD in $F$ is **extraneous** if we can remove it without changing the closure set $F^+$

Formally, given $\alpha \rightarrow \beta$ in $F$,

- Attribute $A$ is extraneous in $\alpha$ if $A \subset \alpha$ and $F$ logically implies $(F - (\alpha \rightarrow \beta) \cup \{(\alpha - A) \rightarrow \beta\})$.

- Attribute $A$ is extraneous in $\beta$ if $A \subset \beta$ and the set of FDs
$(F - \{\alpha \rightarrow \beta\}) \cup \{\alpha \rightarrow (\beta - A)\}$ logically implies $F$.


# Minimal Cover FD Sets

Two sets of FDs $F$ and $E$ are equivalent if $F^+$ = $E^+$.

A set of FDs $F$ is minimal if:

1. Every dependency in F has a single attribute on the right side (canonical form).
2. We cannot replace any FD $\alpha \rightarrow A$ in $F$ with an FD $\beta \rightarrow A$ where $\beta \subset \alpha$ and have set of FDs that is equivalent to $F$.
3. We cannot remove any dependency from F and still have a set of FDs that is equivalent to F.

Note: in this class you will not need to compute the minimal cover set of FDs. They will always be given.

# Normal Forms

Normalization uses functional dependencies to analyze relations and decompose them into new relations to:

- minimize redundancy, and
- minimize insertion, deletion, and update anomalies

We will consider first, second, third, and Boyce-Codd normal forms in this class.

The normal form of a relation is the highest normal form it satisfies.

# First Normal Form (1NF)

Every attribute value is atomic, which is effectively guaranteed by most RDBMS systems today.

The following relation is not in 1NF:

+----------+----------------+-----------+--------------------------------+
| Dname    | <u>Dnumber</u> | Dmgr_ssn  | Dlocations                     |
+==========+================+===========+================================+
| Research | 5              | 333445555 | {Bellaire, Sugarland, Houston} |
+----------+----------------+-----------+--------------------------------+
| Admin    | 4              | 987654321 | {Stafford}                     |
+----------+----------------+-----------+--------------------------------+
| HQ       | 1              | 888665555 | {Houston}                      |
+----------+----------------+-----------+--------------------------------+

Because Dlocation values are not atomic.

# Fixing Non 1NF Schemas

Many ways to fix (see book). Best way is to decompose into two schemas:

+----------+----------------+-----------+
| Dname    | <u>Dnumber</u> | Dmgr_ssn  |
+==========+================+===========+
| Research | 5              | 333445555 |
+----------+----------------+-----------+
| Admin    | 4              | 987654321 |
+----------+----------------+-----------+
| HQ       | 1              | 888665555 |
+----------+----------------+-----------+


+----------------+------------------+
| <u>Dnumber</u> | <u>Dlocation</u> |
+================+==================+
| 5              | Bellaire         |
+----------------+------------------+
| 5              | Sugarland        |
+----------------+------------------+
| 5              | Houston          |
+----------------+------------------+
| 4              | Stafford         |
+----------------+------------------+
| 1              | Houston          |
+----------------+------------------+

# Second Normal Form (2NF)

A *prime* attribute is part of any candidate key. A *nonprime* attribute is not part of any candidate key.

A relation is in 2NF if it is in 1NF and no nonprime attribute has a partial dependency on the primary key, i.e., every attribute is fully dependent on the primary key.

# 2NF Test

Given EMP_PROJ(<u>Ssn</u>, <u>Pnumber</u>, Hours, Ename, Pname, Plocation) and

$$
Ssn, Pnumber \rightarrow Hours,\\
Ssn \rightarrow Ename,\\
Pnumber \rightarrow Pname, Plocation\\
$$

EMP_PROJ is not in 2NF due to FD2, $Ssn \rightarrow Ename$. Nonprime attribute Ename is partially dependent on the primary key <u>Ssn</u>, <u>Pnumber</u>.

# Fixing non 2NF Schemas

Move the nonprime attributes that are dependent on part of the primary key to their own schemas with the part of the primary key on which they are fully dependent.

EMP_PROJ(<u>Ssn</u>, <u>Pnumber</u>, Hours, Ename, Pname, Plocation)

Becomes

EMP(<u>Ssn</u>, Ename)

EMP_PROJ(<u>Ssn</u>, <u>Pnumber</u>, Hours)

PROJ(<u>Pnumber</u>, Pname, Plocation)

# Third Normal Form (3NF)

A schema is in 3NF if it is in 2NF and no nonprime attribute is transitively dependent on the primary key.

Given

EMP_DEPT(<u>Ssn</u>, Ename, Bdate, Address, Dnumber, Dname, Dmgr_ssn)

and

$Ssn \rightarrow Ename, Bdate, Address, Dnumber, Dname, Dmgr\_ssn$
$Dnumber \rightarrow Dname, Dmgr\_ssn$

EMP_DEPT is not in 3NF because Dname and Dmgr_ssn are transitively dependent on Ssn via a transitive dependency on Dnumber.

# Fixing Non-3NFf Schemas

Move the nonprime attributes that are transitively dependent on the primary key through another attribute to a separate schema along with the attribute through which they are transitively dependent on the PK.

EMP_DEPT(<u>Ssn</u>, Ename, Bdate, Address, Dnumber, Dname, Dmgr_ssn)

becomes

EMP(<u>Ssn</u>, Ename, Bdate, Address, Dnumber)

DEPT(<u>Dnumber</u>, Dname, Dmgr_ssn)

Note that a natural join on Dnumber will recover the original relation.