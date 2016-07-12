drop database if exists teach;
create database teach;
use teach;

drop table if exists teach;
create table if not exists teach (
  student varchar(20) not null,
  course varchar(20) not null,
  instructor varchar(20) not null,
  primary key (student, course)
);

insert into teach values ('Narayan', 'Database', 'Mark');
insert into teach values ('Smith', 'Database', 'Navathe');
insert into teach values ('Smith', 'Operating Systems', 'Ammar');
insert into teach values ('Smith', 'Theory', 'Schulman');
insert into teach values ('Wallace', 'Database', 'Mark');
insert into teach values ('Wallace', 'Operating Systems', 'Ahamad');
insert into teach values ('Wong', 'Database', 'Omiecinski');
insert into teach values ('Zelaya', 'Database', 'Navathe');
insert into teach values ('Narayan', 'Operating Systems', 'Ammar');

drop table if exists r1;
create table if not exists r1 (
  student varchar(20) not null,
  instructor varchar(20) not null,
  primary key (student, instructor)
);

insert into r1 values ('Narayan', 'Mark');
insert into r1 values ('Smith', 'Navathe');
insert into r1 values ('Smith', 'Ammar');
insert into r1 values ('Smith', 'Schulman');
insert into r1 values ('Wallace', 'Mark');
insert into r1 values ('Wallace', 'Ahamad');
insert into r1 values ('Wong', 'Omiecinski');
insert into r1 values ('Zelaya', 'Navathe');
insert into r1 values ('Narayan', 'Ammar');


drop table if exists r2;
create table if not exists r2 (
  student varchar(20) not null,
  course varchar(20) not null,
  primary key (student, course)
);

insert into r2 values ('Narayan', 'Database');
insert into r2 values ('Smith', 'Database');
insert into r2 values ('Smith', 'Operating Systems');
insert into r2 values ('Smith', 'Theory');
insert into r2 values ('Wallace', 'Database');
insert into r2 values ('Wallace', 'Operating Systems');
insert into r2 values ('Wong', 'Database');
insert into r2 values ('Zelaya', 'Database');
insert into r2 values ('Narayan', 'Operating Systems');
