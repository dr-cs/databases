---
layout: default
title: CS 4400 - Project
---

[Summer 2016 Project Description](project-summer2016.html)

# General Project Information

You will design and implement a database application using the MySQL relational database system available via CoC (College of Computing). The Project must be done in groups of 3 - 5 students. Groups of more than 5 or less than 3 will not be allowed. The project will consist of 3 phases (deliverables) as well as a final demonstration to the TA.

## Phase 1

Given a problem specification from (a) fictional user(s), create an EER model of the users' data, a list of semantic constraints that cannot be modeled in EER, and an information flow diagram of a database application suited to the user's problem.

Submit your Phase 1 deliverables in a single PDF file named `teamN-phase1.pdf`, where N is your team number. For example, if you're Team 3 you'd submit a file named `team3-phase1.pdf`.

## Phase 2

Map your (corrected) EER model and semantic constraints from Phase 1 to a relational model and write an SQL script with DDL (`create table`) statements that will create the (unpopulated) database in MySQL.

Submit your Phase 2 deliverable as a single SQL file named `teamN-schema.sql`, where N is your team number. For example, if you're Team 3 you'd submit a file named `team3-schema.sql`.

## Phase 3

Given the problem specification and your (corrected) relational database schema from Phase 2, write an SQL script with DML (`insert`) statements to populate the database with data and another SQL script with a set of queries that answer questions provided in the project description.

Submit your Phase 3 deliverable as two SQL files: (remember to substitute your team number for N) `teamN-data.sql` with SQL `insert` statements to populate the database you created in Phase 2, and `teamN-queries.sql` with SQL queries to answer the questions provided in the project description for your semester.

Heavyweight option: in addition to the items above, create an application that provides an interface to the database for a database user as specified in the project desctiption.


[Peer Evaluation](peer-eval.html)
