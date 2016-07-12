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

drop table if exists student;
create table student (
    student_id integer primary key,
    name text,
    gpa float(3,2),
    dorm_id integer,
    foreign key (dorm_id) references dorm(dorm_id)
);
insert into student values (1, 'Alice', 3.6, 1);
insert into student values (2, 'Bob', 2.7, 1);
insert into student values (3, 'Cheng', 3.9, 1);
insert into student values (4, 'Dhruv', 3.4, 2);
insert into student values (5, 'Ellie', 4.0, 2);
insert into student values (6, 'Fong', 2.3, 2);
insert into student values (7, 'Gerd', 4.0, 3);
insert into student values (8, 'Hal', 2.2, 3);
insert into student values (9, 'Isaac', 2.0, 3);
insert into student values (10, 'Jacque', 4.0, 3);
