% Advanced Relational Design
% CS 4400


# Closure of a Set of FDs

The closure $F^+$ of $F$ is the set of all FDs logically implied by $F$. We can use a set if inference rules known as **Armstrong's Axioms** to derive new FDs.

- **Reflexivity**. If $Y \subseteq X$, then $X \rightarrow Y$
- **Augmentation**. If $X \rightarrow Y$ holds, then $XZ \rightarrow YZ$
- **Transitivity**. If $X \rightarrow Y$ holds and $Y \rightarrow Z$ holds, then $X \rightarrow Z$ holds

Note that $XY$ is shorhand for $X \cup Y$.

Armostrong's axioms are **sound** because they do not produce new FDs that don't hold, and **complete** becuase applying them repeatedly finds $F^+$, i.e., all FDs that are logically implied by $F$.

Note that $F^+$ includes **all** FDs, including trivial FDs.

# Algorithm for Finding $F^+$

The following algorithm applies Armstrong's Axioms repeatedly to find $F^+$.

- Let $F^+ = F$
- **repeat**:
    - **for each** FD $f$ in $F^+$:
        - add results of applying reflexivity and augmentation rules on $f$ to $F^+$
    - **for each** pair of FDs $X \rightarrow Y$ and $Y \rightarrow Z$ in $F^+$:
        - add $X \rightarrow Z$ to $F^+$
- **until** $F^+$ does not change any further

This algorithm is instructive, but tedious and expensive and we present it mainly for conceptual understanding. There's also a better way ...

# Attribute Closure

The set of attributes functionally determined by $X$ under $F$ is the *closure* of $X$ under $F$, denoted $X^+$.

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


# Computing Minimal Cover FDs

REove extraneous attributes by:

- **while** there is an FD $F$ in $T$ that is implied by other FDs in $T$:
    - remove $F$ from $T$
- **repeat**

    - **for each** FD $Y \rightarrow B$ in $T$ such that $|Y| > 1$:
        - let $Z$ be $Y$ minus one attribute in $Y$
        - **if** $Z \rightarrow B$ follows from the FDs in $T$ (including $Y \rightarrow B$), **then** replace $Y \rightarrow B$ with $Z \rightarrow B$

- **until** no more changes to $T$ can be made

# Normal Forms

A *normal form* is a set of conditions based on functional dependencies that acts as a set of tests for a relation schema.

Normalization is the process of decomposing relation schemas into new relation schemas that satisfy normal forms with the goals of:

- minimizing redundancy, and
- minimizing insertion, deletion, and update anomalies

We will consider first, second, third, and Boyce-Codd normal forms in this class. Each higher normal form subsumes the normal forms below it. The normal form of a relation schema is the highest normal form it satisfies.

# Schema Decomposition

A decomposition of a relation $R$ into $R_1$ and $R_2$ can be defined as:

- $R_1 = \pi_A(R)$
- $R_2 = \pi_B(R)$

Where $R = A \cup B$

To find the functional dependencies that hold on $R_1$ and $R_2$ we project the functional dependencies that hold on $R$ into sets of FDs for $R_1$ and $R_2$.

# Projection of FDs

**Input:** A relation $R$, a relation $R_1$ computed by the projection $\pi_L(R)$, and a set of FDs $S$ that hold on $R$.

1. **set** $T = \{\}$ (the empty set)
2. **for each** subset of attributes $X$ in $R_1$:
    - compute $X^+$ with respect to $S$. Note that there may be attributes in $X^+$ that are in $R$ but not in $R_1$.
    - Add to $T$ on nontrivial FDs $X \rightarrow A$ for which $A$ is in $X^+$ and $R_1$.
3. Transform $T$ into a minimal cover of the FDs that hold on $R_1$ by the follosing procedure:
    - **while** there is an FD $F$ in $T$ that is implied by other FDs in $T$:
        - remove $F$ from $T$
    - **repeat**
        **for each** FD $Y \rightarrow B$ in $T$ with two or more attributes in $Y$:
            - let $Z$ be $Y$ minus one attribute in $Y$
            - **if** $Z \rightarrow B$ follows from the FDs in $T$ (including $Y \rightarrow B$), **then** replace $Y \rightarrow B$ with $Z \rightarrow B$
    - **until** no more changes to $T$ can be made

**Output:** $T$, a minimal set of functional dependencies that hold on $R_1$

# Bottom-Up Design Approaches

Bottom-up approaches start with one **universl relation** which contains all attributes in the database. 3NF or BCNF relation schemas are *synthesized* from this universal relation schema.

- Algorithm 15.4 sythesizes univeral relation $R$ into 3NF schemas that have the nonadditive join property *and* preserve dependencies.
- Algorithm 15.5 converts univeral relation $R$ into BCNF schemas that have the nonadditive join property (but not necessarily preserving dependencies) by iterative decomposition.

In this class you only need to know Algorithm 15.5, BCNF decomposition.

# Informal 3NF Synthesis

Informally, Algorithm 15.4 for 3NF synthesis does this:

1. Find a minimal cover set of FDs for $R$.
2. For each FD in the minimal cover create a relation schema with each attribute in the FD. The left-hand side of the FD is the key.
3. If none of the schemas above contains a key of $R$, create one more relation schema with attributes that form a key of $R$ (the previously created schemas will contain foreign keys to this relation schema).
4. Elminate redundant schemas.

Easy to understand conceptually, but many details which we don't require you to know.

# Informal BCNF Decomposition

Before diving into the much simpler BCNF decomposition algorithm, here's an informal decription of the process it follows.

Let

- $R$ be a relation schema not in BCNF,
- $X \subseteq R$, and
- $X \rightarrow A$ be the FD that violates BCNF.

Decompose $R$ into

- $R - A$, and
- $XA$

If either of these relations is not in BCNF, repeat the process.

# BCNF Decomposition Algorithm

**Algorithm 15.5:** Relational Decomposition into BCNF with Nonadditive Join Property

**Input:** A universal relation $R$ and a set of FDs $F$ on $R$

1. **set** $D := \{R\}$
2. **while** there is a relation schema $Q$ in $D$ that is not in BCNF:
    - choose a relation schema $Q$ in $D$ that is not in BCNF
    - find a functional dependency $X \rightarrow Y$ in $Q$ that violates BCNF
    - replace $Q$ in $D$ by two schemas $(Q - X^+)$ jand $X^+$
    - project the functional dependencies from $Q$ into the new schemas.

**Output:** $D$, a set of relation schemas in BCNF with the non-additive join property such that $D = \bigcup_1^n D_i$

Note that each schema has its own set of functional dependencies, so each decomposition results in the loss of one schema from $D$ along with its functional dependencies, and the addition of two new schemas each with their own sets of functional dependencies.