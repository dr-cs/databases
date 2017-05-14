---
layout: default
title: CS 4400 - BCNF Decomposition Exercise
---

# BCNF Decomposition Exercises

Given the universal relation schema:

$R(eid, pid, hours, ename, city, did, dname, mgrid, pname, ploc)$

And the FDs:

- $eid, pid \rightarrow hours$
- $eid, pid \rightarrow dname$
- $eid \rightarrow ename, city, did, mgrid$
- $did \rightarrow dname, mgrid$
- $pid \rightarrow pname, ploc$

And the data:

| eid | pid | hours | ename | did | dname | mgrid | pname | ploc |
|-----|-----|-------|-------|-----|-------|-------|-------|------|
| 101 | 1   | 20    | smith | 10  | toy   | 103   | acme  | atl  |
| 101 | 2   | 25    | smith | 10  | toy   | 103   | ajax  | chi  |
| 102 | 1   | 40    | jones | 15  | shoe  | 105   | acme  | atl  |
| 103 | 2   | 25    | brown | 10  | toy   | 103   | ajax  | chi  |
| 103 | 3   | 25    | brown | 10  | toy   | 103   | aaa   | mia  |
| 104 | 1   | 40    | green | 15  | shoe  | 105   | acme  | atl  |
| 105 | 2   | 40    | black | 15  | shoe  | 105   | ajax  | chi  |

Decompose the universal relation schema $R$ into BCNF relation schemas and show how the data above would be stored in states of the new set of relation schemas.