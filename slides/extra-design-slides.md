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

**Input:** $T$, a set of FDs

- **while** there is an FD $F$ in $T$ that is implied by other FDs in $T$:
    - remove $F$ from $T$
- **repeat**
    - **for each** FD $Y \rightarrow B$ in $T$ such that $|Y| > 1$:
        - let $Z$ be $Y$ minus one attribute in $Y$
        - **if** $Z \rightarrow B$ follows from the FDs in $T$ (including $Y \rightarrow B$), **then** replace $Y \rightarrow B$ with $Z \rightarrow B$

- **until** no more changes to $T$ can be made
