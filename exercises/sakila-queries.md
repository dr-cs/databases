---
layout: exercise
title: Sakila Queries Exercise
---

## Introduction

In this exercise you will write more advanced queries on a database designed to resemble a real-world database system, MySQL's [Sakila Sample Database](https://dev.mysql.com/doc/sakila/en/).

## Problem Description

You're writing software to manage a chain of movie rental stores.

## Solution Description

Write the SQL statements that implement functions of your rental store management system. You may want to use this starter script: [sakila-queries.sql](sakila-queries.sql).


1. Download the schema and data scripts for the [Sakila Sample Database](https://dev.mysql.com/doc/sakila/en/).
2. Write an SQL script with queries that answer the following questions:

- Which actors have the first name 'Scarlett'
- Which actors have the last name 'Johansson'
- How many distinct actors last names are there?
- Which last names are not repeated?
- Which last names appear more than once?
- Which actor has appeared in the most films?
- Is 'Academy Dinosaur' available for rent from Store 1?
- Insert a record to represent Mary Smith renting 'Academy Dinosaur' from Mike Hillyer at Store 1 today .
- When is 'Academy Dinosaur' due?
- What is that average running time of all the films in the sakila DB?
- What is the average running time of films by category?
- Why does this query return the empty set?

  select * from film natural join inventory;

### Sample solution

Don't peek until you've tried the exercise!

- [sakila-queries-answers.sql](sakila-queries-answers.sql)