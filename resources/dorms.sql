drop database if exists dorms;
create database dorms;
use dorms;

drop table if exists dorm;
create table dorm (
    dorm_id integer primary key,
    name text,
    spaces integer
);
insert into dorm values(1, 'Armstrong', 124);
insert into dorm values(2, 'Brown', 158);
insert into dorm values(3, 'Caldwell', 158);

drop table if exists stud;
create table stud (
    stud_id integer primary key,
    name text,
    gpa float,
    dorm_id integer references dorm(dorm_id)
);
insert into stud values (1, 'Alice', 3.6, 1);
insert into stud values (2, 'Bob', 2.7, 1);
insert into stud values (3, 'Cheng', 3.9, 1);
insert into stud values (4, 'Dhruv', 3.4, 2);
insert into stud values (5, 'Ellie', 4.0, 2);
insert into stud values (6, 'Fong', 2.3, 2);
insert into stud values (7, 'Gerd', 4.0, 3);
insert into stud values (8, 'Hal', 2.2, 3);
insert into stud values (9, 'Isaac', 2.0, 3);
insert into stud values (10, 'Jacque', 5.0, 3);
