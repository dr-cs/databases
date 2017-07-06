---
layout: exercise
title: Registration Database Exercise
---

<style>
table{
    border-collapse: collapse;
    border-spacing: 0;
    border: 2px solid;
}

th{
    border: 2px solid #000000;
    padding: 2px;
}

td{
    border: 1px solid #000000;
    padding: 2px;
}
</style>

# Registration Database

## Introduction

In this exercise you will practice

- basic relational data modeling,
- writing SQL create table statements,
- writing SQL schema and data insertion scripts, and
- writing basic SQL queries.

## Problem Description

You work for the registrar of a major university and have been tasked with creating a database to hold courses and semester schedules.

## Solution Description

### Part 1: Creating the database

Write a SQL script named `registration-schema.sql` that creates a database with the following tables:

- student(<u>student_id</u>, name, gpa)

- dept(<u>dept_id</u>, name, dean, building, room)

- course(<u>dept_id</u>, <u>course_id</u>, name, hours), where dept_id is a foreign key referencing the dept(dept_id)

- enrolled(<u>dept_id</u>, <u>course_id</u>, <u>student_id</u>), where (dept_id, course_id) is a foreign key referencing course(dept_id, course_id) and student_id is a foreign key referencing student(student_id)

### Part 2: Populating the database

Write a SQL script that populates the following data:



#### Student

|------------+---------+-----|
| student_id | name    | gpa |
|------------+---------+-----|
| 11         | Bush    | 3.0 |
| 12         | Cruz    | 3.2 |
| 13         | Clinton | 3.9 |
| 22         | Sanders | 3.0 |
| 33         | Trump   | 3.8 |
|------------+---------+-----|



#### Enrolled

| dept_id | coruse_id | student_id |
|---------+-----------+------------|
| CS | 101 | 11 |
| Math | 101 | 11 |
| CS | 101 | 12 |
| CS | 101 | 22 |
| Math | 103 | 33 |
| EE | 102 | 33 |
| CS | 102 | 22 |


#### Department

| dept_id | name | dean | building | room |
|---------+------+------+----------+------|
| CS | Computer Science |Rubio | Ajax | 100 |
| Math | Mathemagics | Carson | Acme | 300 |
| EE | Electrical Engineering | Kasich | Ajax | 200 |
| Music | Musicology | Costello | North | 100 |

#### Course

| dept_id | course_id | name | hours |
|---------|-----------|------|-------|
| CS | 101 | Programming | 4 |
| CS | 102 | Algorithms | 3 |
| Math | 101 | Algebra | 3 |
| Math | 103 | Calculus | 4 |
| Music | 104 | Jazz | 3 |
| EE | 102 | Circuits | 3 |


### Part 3: Updating the database

Once the database has been populated, make the following updates:

- Change the name of the CS dept to 'College of Computing'
- Change the dean of the CoC to 'Galil'


### Part 4: Querying the database

Write a sql script with queries that answer the following questions:

- What are all the departments?
- What are the names of all the department deans?
- What are all the course numbers, e.g., 'CS 2316'?
- What are the course numbers of all the first-year courses?
- What are the course numbers of all the CS courses?
- What are the course numbers of all the IE courses?
- What are all the CS and IE courses?
