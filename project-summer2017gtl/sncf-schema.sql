drop database if exists sncf;
create database sncf;
use sncf;

create table user(
  user_id int primary key auto_increment,
  email char(32) unique not null,
  password char(128) not null,
);

create table customer(
  customer_id int primary key auto_increment,
  email char(32) unique not null,
  birthdate date,
  credit_card_no char(17) not null,
  credit_card_expiry date,
  address varchar(64),
  user_id int not null,
  foreign key (user_id) references user(user_id)
    on update cascade
    on delete cascade
);

create table trip (

);

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
