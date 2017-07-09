drop database if exists registration;
create database registration;
use registration;

create table student (
  student_id int primary key,
  name varchar(256),
  gpa double(3,2)
);

create table dept(
  dept_id char(8) primary key,
  name varchar(32) not null unique,
  dean varchar(256) not null,
  building varchar(32),
  room varchar(16)
);

create table course(
  dept_id char(8),
  course_id int,
  name varchar(32) not null,
  hours int not null,

  primary key (dept_id, course_id),
  foreign key (dept_id) references dept(dept_id)
    on update cascade
    on delete cascade
);

create table enrolled(
  dept_id char(8),
  course_id int,
  student_id int,

  primary key (dept_id, course_id, student_id),
  foreign key (dept_id, course_id) references course(dept_id, course_id)
    on update cascade
    on delete cascade,
  foreign key (student_id) references student(student_id)
    on update cascade
    on delete cascade
);
