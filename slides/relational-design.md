% Relational Design
% CS 4400

# Relational Design

- Basic design approaches.
- What makes a good design better than a bad design?
- How do we tell we have a "good" design?
- How to we go about creating a good design?

# Basic Design Approaches

- Bottom-up, a.k.a. *synthethis*

    - Start with individual attributes and large set of binary relationships among attributes
    - Unpopular

- Top-down, a.k.a. *analysis*

    - Start with groupings of attributes, e.g., a schema derived from ER-relational mapping
    - Decompose until design properties are met


# Relational Design Desiderata

- The sematics of relation schemas and their attributes should be clear
- There should be little or no redundant information in tuples
- The should be few or no NULL values in tuples
- It should be impossible to generate spurious (invalid) tuples

<!--

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

-->

# Functional Dependencies

A generalization of superkeys.

Given a relation schema $R$, and subsets of attributes $X$ and $Y$, the functional dependency

$$
X \rightarrow Y
$$

Means that for any pair of tuples $t_1$ and $t_2$ in $r(R)$

<center>
if $t_1[X] = t_2[X]$ <br/>
then $t_1[Y] = t_2[Y]$
</center>

In other words, whenever the attributes on the left side of a functional dependency are the same for two tuples in the relation, the attributes on the right side of the functional dependency will also be equal.

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

We say that a functional dependency $f$ *holds* on a relation if it is not legal to create a tuple that does not satisfy $f$. Alternately, we say that a relation *schema* (not just a particular state) satisfies a functional dependency.

+---------+-----------+-----------+
| name    | street    | city      |
+=========+===========+===========+
| Alice   | Elm       | Charlotte |
+---------+-----------+-----------+
| Bob     | Peachtree | Atlanta   |
+---------+-----------+-----------+
| Charlie | Elm       | Charlotte |
+---------+-----------+-----------+

Here $street \rightarrow city$ is satisifed by this relation state. However, we would not say that the functional dependency *holds*, or that the *relation schema* satisfies the functional dependency because we know there *can be* different cities with the same street names.

# Trivial Functional Dependencies

A functional dependency is *trivial* if it is satisfied by all relations.

Formally, a functional dependency $X \rightarrow Y$ is **trivial** if $Y \subseteq X$

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

- **Reflexivity**. If $Y \subseteq X$, then $X \rightarrow Y$
- **Augmentation**. If $X \rightarrow Y$ holds, then $XZ \rightarrow YZ$
- **Transitivity**. If $X \rightarrow Y$ holds and $Y \rightarrow Z$ holds, then $X \rightarrow Z$ holds

Note that $XY$ is shorhand for $X \cup Y$.

Armostrong's axioms are **sound** because they do not produce new FDs that don't hold, and **complete** becuase applying them repeatedly finds $F^+$, i.e., all FDs that are logically implied by $F$.

# Algorithm for Finding $F^+$

The following algorithm applies Armstrong's Axioms repeatedly to find $F^+$.

- Let $F^+ = F$
- **repeat**:
    - **for each** FD $f$ in $F^+$:
        - add results of applying reflexivity and augmentation rules on $f$ to $F^+$
    - **for each** pair of FDs $X \rightarrow Y$ and $Y \rightarrow Z$ in $F^+$:
        - add $X \rightarrow Z$ to $F^+$
- **until** $F^+$ does not change any further

This algorithm is instructive, but tedious and expensive. There's a better way ...

# Attribute Closure

The normal forms we consider in this class (1NF through BCNF) are based on keys, so we need a way to use FDs to determine the keys of a relation.

If $X$ is a superkey of $R$ then $X \rightarrow R$. In other words, all the attributes of $R$ are determined by $X$.

The set of attributes functionally determined by $X$ under $F$ is the *closure* of $X$ under $F$, denoted $X^+$.

# Computing Attribute Closure

**Algorithm 15.1** Determining $X^+$, the closure of $X$ under $F$

**Input:** A set $F$ of FDs on relation schema $R$, and a set of attributes $X \subseteq R$

- $X^+$ := $X$
- **repeat**:
    - $oldX^+$ := $X^+$
    - **for each** functional dependency $Y \rightarrow Z$:
        - if $Y \subseteq X^+$ then $X^+$ := $X^+ \cup Z$
- **until** $X^+$ = $oldX^+$

# Uses of Attribute Closure

- Test whether $X$ is a superkey of $R$.
    - If $X^+$ contains all attributes in $R$, then $X$ is a superkey of $R$.

- Checking whether an FD $X \rightarrow Y$ holds on $R$ under $F$.
    - Compute $X^+$. If $Y \subseteq X^+$ then $X \rightarrow Y$ holds.

- An alternate way to compute $F^+$.
    - For each $Z \subseteq R$, compute $Z^+$
        - For each $S \subseteq Z^+$ add FD $Z \rightarrow S$ to $F^+$

# Superkey Test Using Attribute Closure

Given $R(A, B, C, G, H, I)$ and $F = \{A \rightarrow B, A \rightarrow C, CG \rightarrow H, CG \rightarrow I, B \rightarrow H\}$,

compute $\{AG\}^+$.

The first time we execute the outer loop:

- $A \rightarrow B$ adds $B$ to $\{AG\}^+$, making $\{AG\}^+$ = $\{ABG\}$.
- $A \rightarrow C$ adds $C$, making $\{AG\}^+$ = $\{ABCG\}$.
- $CG \rightarrow H$ adds $H$, making $\{AG\}^+$ = $\{ABCGH\}$.
- $CG \rightarrow I$ adds $I$, making $\{AG\}^+$ = $\{ABCGHI\}$.

Since $\{AG\}^+$ now includes all attributes in $R$, the second iteration of the outer loop adds no new attributes, so the algorithm terminates. $\{AG\}^+$ is a superkey of $R$.

# Finding A Candidate Key

**Algorithm 15.2(a):** Finding a key $K$ for $R$ given a set $F$ of functional dependenceis on $R$

**Input**: A relation $R$ and FDs $F$ on $R$

1. set $K := R$
2. **for each** attribute $A$ in $K$:
    - compute $(K - \{A\})^+$ with respect to $F$
    - **if** $R \subseteq (K - \{A\})^+$, **then** set $K := K - \{A\}$

This algorithm finds a single candidate key depending on the order in which attributes are removed.

# Cover and Equivalence

A set of FDs $F$ **covers** a set of FDs $E$ if every FD in $E$ is in $F^+$, that is, every FD in $E$ can be inferred from $F$.

To test whether some $F$ covers some $E$:

- **for each** FD $X \rightarrow Y$ in $E$:
    - compute $X^+$ with respect to $F$
        - **if** $Y \subseteq X^+$ for every FD in $E$, then $F$ covers $E$

If $F$ covers $E$ and $E$ covers $F$, then $E$ and $F$ are **equivalent**.

# Extraneous Attributes in FDs

An attribute of an FD in $F$ is **extraneous** if we can remove it without changing the closure set $F^+$

Formally, given $X \rightarrow A$ in $F$,

- Attribute $Y$ is extraneous in $X$ if $Y \subset X$ and $F$ logically implies $(F - (X \rightarrow A) \cup \{(X - Y) \rightarrow A\})$.


# Minimal Cover FD Sets

$F$ is a **minimal cover** of $E$ if every FD in $E$ is in $F^+$ and $F$ is **minimal** (in standard/canonical form with no redundancies).

A set of FDs $F$ is minimal if:

1. Every dependency in F has a single attribute on the right side (canonical form).
2. We cannot replace any FD $X \rightarrow A$ in $F$ with an FD $Y \rightarrow A$ where $Y \subset X$ and have set of FDs that is equivalent to $F$.
3. We cannot remove any dependency from F and still have a set of FDs that is equivalent to F.

Note: in this class you will not need to compute the minimal cover set of FDs. They will always be given when needed.

# Normal Forms

A *normal form* is a set of conditions based on functional dependencies that acts as a set of tests for a relation schema.

Normalization is the process of decomposing relation schemas into new relatoin schemas that satisfy normal forms with the goals of:

- minimizing redundancy, and
- minimizing insertion, deletion, and update anomalies

We will consider first, second, third, and Boyce-Codd normal forms in this class. Each higher normal form subsumes the normal forms below it. The normal form of a relation schema is the highest normal form it satisfies.

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

Because Dlocations values are not atomic.

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

Given

EMP_PROJ(<u>Ssn</u>, <u>Pnumber</u>, Hours, Ename, Pname, Plocation)

and

- FD1: Ssn, Pnumber $\rightarrow$ Hours
- FD2: Ssn $\rightarrow$ Ename,
- FD3: Pnumber $\rightarrow$ Pname, Plocation

EMP_PROJ is not in 2NF due to FD2. Nonprime attribute Ename is partially dependent on the primary key <u>Ssn</u>, <u>Pnumber</u>.

EMP_PROJ is also not in 2NF due to FD3. Nonprime attributes Pname and Plocation are only partially dependent on the primary key.

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

- FD1: Ssn $\rightarrow$ Ename, Bdate, Address, Dnumber, Dname, Dmgr_ssn
- FD2: Dnumber $\rightarrow$ Dname, Dmgr_ssn

EMP_DEPT is not in 3NF because Dname and Dmgr_ssn are transitively dependent on Ssn via dependency on Dnumber.

# Fixing Non-3NF Schemas

Move the nonprime attributes that are transitively dependent on the primary key through another attribute to a separate schema along with the attribute through which they are transitively dependent on the PK.

EMP_DEPT(<u>Ssn</u>, Ename, Bdate, Address, Dnumber, Dname, Dmgr_ssn)

becomes

EMP(<u>Ssn</u>, Ename, Bdate, Address, Dnumber)

DEPT(<u>Dnumber</u>, Dname, Dmgr_ssn)

Note that a natural join on Dnumber will recover the original relation.

# General Definition of 2NF and 3NF

Preceding definitions based on primary key. General definitions based on all candidate keys.

Remember:

- An attribute is *prime* if it is part of a candidate key,
- otherwise it is *nonprime*.

General definition of 2NF: A relation schema $R$ is in 2NF if every nonprime attribute $A$ in $R$ is not partially dependent on *any* key of $R$.

# A Non-2NF Schema

LOTS(<u>Property_id</u>, County_name, Lot#, Area, Price, Tax_rate)

- FD1: Property_id $\rightarrow$ County_name, Lot#, Area, Price, Tax_rate
- FD2: County_name, Lot# $\rightarrow$ Property_id, Area, Price, Tax_rate
- FD3: County_name $\rightarrow$ Tax_rate
- FD4: Area $\rightarrow$ Price

Both Property_id and {County_name, Lot#} are candidate keys. So, by the general definition of 2NF LOTS is not in 2NF due to FD3, i.e., Tax_rate is partially dependent on a candidate key.

# 2NF Decomposition

LOTS(<u>Property_id</u>, County_name, Lot#, Area, Price, Tax_rate)

becomes

LOTS1(<u>Property_id</u>, County_name, Lot#, Area, Price)

- FD1: Property_id $\rightarrow$ County_name, Lot#, Area, Price, Tax_rate
- FD2: County_name, Lot# $\rightarrow$ Property_id, Area, Price, Tax_rate
- FD4: Area $\rightarrow$ Price

LOTS2(<u>County_name</u>, Tax_rate)

- FD3: County_name $\rightarrow$ Tax_rate


# General Definition of 3NF

A relation schema $R$ is in 3NF if, whenever a *nontrivial* functional dependency $X \rightarrow A$ holds in $R$, either

(a) $X$ is a superkey of $R$, or
(b) $A$ is a prime attribute of $R$.

LOTS1(<u>Property_id</u>, County_name, Lot#, Area, Price)

- FD1: Property_id $\rightarrow$ County_name, Lot#, Area, Price, Tax_rate
- FD2: County_name, Lot# $\rightarrow$ Property_id, Area, Price, Tax_rate
- FD4: Area $\rightarrow$ Price

not in 3NF due to FD4. Area is not a superkey and Price is not a prime attribute. Note that Price is transitively dependent on each candidate key.

# 3NF Decomposition

LOTS1(<u>Property_id</u>, County_name, Lot#, Area, Price)

becomes

LOTS1A(<u>Property_id</u>, County_name, Lot#, Area)

- FD1: Property_id $\rightarrow$ County_name, Lot#, Area, Price, Tax_rate
- FD2: County_name, Lot# $\rightarrow$ Property_id, Area, Price, Tax_rate

and

LOTS1B(<u>Area</u>, Price)

- FD4: Area $\rightarrow$ Price

# Straight to 3NF

Though we present a progression through 2NF to 3NF for historical reasons it's not necessary. Given our origial LOTS

LOTS(<u>Property_id</u>, County_name, Lot#, Area, Price, Tax_rate)

- FD1: Property_id $\rightarrow$ County_name, Lot#, Area, Price, Tax_rate
- FD2: County_name, Lot# $\rightarrow$ Property_id, Area, Price, Tax_rate
- FD3: County_name $\rightarrow$ Tax_rate
- FD4: Area $\rightarrow$ Price

We see that FD3 and FD4 are problem FDs because neither County_name nor Area is a superkey.

# Decomposition Straight to 3NF

So we can decompose

LOTS(<u>Property_id</u>, County_name, Lot#, Area, Price, Tax_rate)

directly into:

LOTS1A(<u>Property_id</u>, County_name, Lot#, Area)

- FD1: Property_id $\rightarrow$ County_name, Lot#, Area
- FD2: County_name, Lot# $\rightarrow$ Property_id, Area

LOTS1B(<u>Area</u>, Price)

- FD4: Area $\rightarrow$ Price

LOTS2(<u>County_name</u>, Tax_rate)

- FD3: County_name $\rightarrow$ Tax_rate

# Observations of General 3NF Tests

Two types of problematic FDs:

- A nonprime attribute determines another nonprime attribute, giving rise to a transitive dependency on a key.
- Some subset of a key determines a nonprime attribute, giving rise to a partial dependencey on a key which violates 2NF.

# Boyce-Codd Normal Form (BCNF)

A relation schema $R$ is in BCNF if whenever a *nontrivial* functional dependency $X \rightarrow A$ holds in $R$, then $X$ is a superkey of $R$

Note that this is the same as 3NF except that it doesn't allow any attributes (even prime attributes) to be determnined by non-keys.

General non-BCNF pattern: given $R(A, B, C)$

and FDs

- $AB \rightarrow C$
- $C \rightarrow B$

$R$ is in 3NF but not BCNF due to the FD $C \rightarrow B$.


# BCNF Example 1

Say we add FD5 to LOTS1A(<u>Property_id</u>, County_name, Lot#, Area)

- FD1: Property_id $\rightarrow$ County_name, Lot#, Area
- FD2: County_name, Lot# $\rightarrow$ Property_id, Area
- FD5: Area $\rightarrow$ County_name

And say that Fulton county lots are restriced to 1.1, 1.2, ..., 2.0 acres and DeKalb county lots are restricted to 0.5, 0.6, ..., 1.0 acres. LOTS1A will have a great deal of redundancy. BCNF doesn't allow this schema because of FD5: Area is not a superkey.

# BCNF Example 1 Decomposition

LOTS1A(<u>Property_id</u>, County_name, Lot#, Area)

becomes

LOTS1AX(<u>Property_id</u>, Area, Lot#)

- FD1: Property_id $\rightarrow$ County_name, Lot#, Area

and

LOTS1AY(<u>Area</u>, County_name)

- FD5: Area $\rightarrow$ County_name

Note that FD2 is lost because its attributes are no longer in the same relation schema. In general, FDs may not be preservable in BCNF decompositions.

# BCNF Example 2

Given TEACH(Student, Course, Instructor) and

- FD1: {Student, Course} $\rightarrow$ Instructor
- FD2: Instructor $\rightarrow$ Course.

FD2 violates BCNF. There are three possible BCNF decompositions:

1. R1(<u>Student</u>, <u>Instructor</u>) and R2(<u>Student</u>, <u>Course</u>)
2. R1(<u>Instructor</u>, Course) and R2(<u>Student</u>, <u>Course</u>)
3. R1(<u>Instructor</u>, Course) and R2(<u>Instructor</u>, <u>Student</u>)

All three decompositions lose FD1. Which decompositions are good?

# Desirable Properties of Decompositions

A decomposition of $R$ into $R_1$ and $R_2$ must preserve attributes, that is, $R = R_1 \cup R_2$. We'd also like:

1. Dependency preservation, and
2. Non-additive (lossless) joins.

Dependencies can be preserved in 3NF decompositions, but not in all BCNF decompositions. We must have non-additive join property.

# Non-Additive Join Test

A Decomposition $D = \{R_1, R_2\}$ of $R$ has the lossless (nonadditive) joint property with repect to FDs $F$ on $R$ if and only if either

- The FD $((R_1 \cap R_2) \rightarrow (R_1 - R_2))$ is in $F^+$, or
- The FD $((R_1 \cap R_2) \rightarrow (R_2 - R_1))$ is in $F^+$

# Test of Decomposition # 1

For

1. R1(<u>Student</u>, <u>Instructor</u>) and R2(<u>Student</u>, <u>Course</u>)

- $(R_1 \cap R_2)$ = Instructor
- $(R_1 - R_2)$ = Instructor
- $(R_2 - R_1)$ = Student

So either

- Instructor $\rightarrow$ Instructor, or
- Instructor $\rightarrow$ Student

must be in $F^+$. But they aren't.

# Visualizing Nonadditive Join

Say some original relation state r(R) is:

| student | course            | instructor |
|---------|-------------------|------------|
| Narayan | Database          | Mark       |
| Narayan | Operating Systems | Ammar      |
| Smith   | Database          | Navathe    |
| Smith   | Operating Systems | Ammar      |
| Smith   | Theory            | Schulman   |
| Wallace | Database          | Mark       |
| Wallace | Operating Systems | Ahamad     |
| Wong    | Database          | Omiecinski |
| Zelaya  | Database          | Navathe    |

# Decomposition 1

Then
<table>
<tr>
<td>
r(R1) =
</td>
<td>

| student | instructor |
|---------|------------|
| Narayan | Ammar      |
| Narayan | Mark       |
| Smith   | Ammar      |
| Smith   | Navathe    |
| Smith   | Schulman   |
| Wallace | Ahamad     |
| Wallace | Mark       |
| Wong    | Omiecinski |
| Zelaya  | Navathe    |

</td>
<td> </td>

<td>
r(R2) =
</td>
<td>

| student | course            |
|---------|-------------------|
| Narayan | Database          |
| Narayan | Operating Systems |
| Smith   | Database          |
| Smith   | Operating Systems |
| Smith   | Theory            |
| Wallace | Database          |
| Wallace | Operating Systems |
| Wong    | Database          |
| Zelaya  | Database          |

</td>
</tr>
</table>

We would join on student and end up with ...

# Join with Spurious Tuples

| student | course            | instructor |
|---------|-------------------|------------|
| Narayan | Database          | Ammar      |
| Narayan | Database          | Mark       |
| Narayan | Operating Systems | Ammar      |
| Narayan | Operating Systems | Mark       |
| Smith   | Database          | Ammar      |
| Smith   | Database          | Navathe    |

... 13 more tuples, which is way more tuples than the original relation due to spurious tuples.

# Test of Decomposition # 2

For

2. R1(<u>Instructor</u>, Course) and R2(<u>Student</u>, <u>Course</u>)

- $(R_1 \cap R_2)$ = Course
- $(R_1 - R_2)$ = Course
- $(R_2 - R_1)$ = Student

So either

- Course $\rightarrow$ Course, or
- Course $\rightarrow$ Student

must be in $F^+$. But they aren't.

# Test of Decomposition # 3

For

3. R1(<u>Instructor</u>, Course) and R2(<u>Instructor</u>, <u>Student</u>)

- $(R_1 \cap R_2)$ = Instructor
- $(R_1 - R_2)$ = Course
- $(R_2 - R_1)$ = Student

So either

- Instructor $\rightarrow$ Course, or
- Instructor $\rightarrow$ Student

must be in $F^+$. Instructor $\rightarrow$ Course is in $F^+$, so this decomposition is the right one.

# BCNF Decomposition Algorithm

Let

- $R$ be a relation schema not in BCNF,
- $X \subseteq R$, and
- $X \rightarrow A$ be the FD that violates BCNF.

$R$ may be decomposed into

- $R - A$, and
- $XA$

If either of these relations is not in BCNF, repeat the process.
