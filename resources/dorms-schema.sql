drop database if exists dorms;
create database dorms;
use dorms;

drop table if exists dorm;
create table dorm (
    dorm_id int primary key,
    name text,
    spaces integer
);

drop table if exists student;
create table student (
    student_id int primary key,
    name text,
    gpa float(3,2),
    dorm_id integer not null,
    foreign key (dorm_id) references dorm(dorm_id)
);
