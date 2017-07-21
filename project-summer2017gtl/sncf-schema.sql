drop database if exists sncf;
create database sncf;
use sncf;

create table station(
  station_id int primary key auto_increment,
  name varchar(16) unique not null,
  address varchar(64)
);

create table train(
  train_id int primary key auto_increment,
  capacity int not null,
  price_per_km double not null
);

create table stop(
  stop_id int primary key auto_increment,
  station_id int not null,
  train_id int not null,
  time time not null,

  foreign key (station_id) references station(station_id),
  foreign key (train_id) references train(train_id)
);

create table trip_train(
  trip_id int primary key auto_increment,
  embark_stop int not null,
  disembark_stop int not null,

  foreign key (embark_stop) references stop(stop_id),
  foreign key (disembark_stop) references stop(stop_id)
);

insert into station (name) values ('Paris');
insert into station (name) values ('Metz');
insert into station (name) values ('Avignon');
insert into station (name) values ('Aix');
insert into station (name) values ('Marseille');
insert into station (name) values ('Nancy');
insert into station (name) values ('Strasbourg');
insert into station (name) values ('Lyon');
