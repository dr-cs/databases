drop database if exists humanedb;
create database humanedb;
use humanedb;

drop table if exists shelter;
create table shelter (
  shelter_id int primary key,
  name varchar(10) not null
);

drop table if exists worker;
create table worker (
  id int primary key,
  name varchar(10) not null,
  supervisor_id int,
  shelter_id int not null,

  foreign key (supervisor_id) references worker(id),
  foreign key (shelter_id) references shelter(shelter_id)
);


drop table if exists pet;
create table pet (
  shelter_id int not null,
  id int not null,
  name varchar(10) not null,
  breed varchar(10) not null,

  primary key (shelter_id, id),
  foreign key (shelter_id) references shelter(shelter_id)
);

insert into shelter values (1, "Howell");
insert into shelter values (2, "Mansell");

insert into worker values (1, "Tom", null, 1);
insert into worker values (2, "Jie", 1, 1);
insert into worker values (3, "Ravi", 2, 1);
insert into worker values (4, "Alice", 2, 1);
insert into worker values (5, "Aparna", null, 2);
insert into worker values (6, "Bob", 5, 2);
insert into worker values (7, "Xaoxi", 6, 2);
insert into worker values (8, "Rohan", 6, 2);

insert into pet values (1, 1, "Chloe", "Mix");
insert into pet values (1, 2, "Dante", "GSD");
insert into pet values (1, 3, "Heidi", "Dachshund");
insert into pet values (2, 1, "Bailey", "Mix");
insert into pet values (2, 2, "Sophie", "Lab");
insert into pet values (2, 3, "Heidi", "Dachshund");
