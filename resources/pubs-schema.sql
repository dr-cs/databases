drop database if exists pubs;
create database pubs;
use pubs;

drop table if exists author;
create table if not exists author (
  author_id int primary key,
  first_name varchar(16) not null,
  last_name varchar(16) not null
);

drop table if exists book;
create table if not exists book (
  book_id int primary key not null,
  book_title varchar(16),
  month varchar(16) not null,
  year int not null,
  editor int,
  FOREIGN KEY (editor) references author(author_id)
    ON DELETE SET NULL
);

drop table if exists pub;
CREATE TABLE pub (
  pub_id INT PRIMARY KEY,
  title VARCHAR(16) NOT NULL,
  book_id INT,
  FOREIGN KEY (book_id) REFERENCES book(book_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

drop table if exists author_pub;
create table if not exists author_pub (
  author_id int not null references author(author_id),
  pub_id int not null references publication(pub_id),
  author_position int not null, -- first author, second, etc?

  primary key (author_id, pub_id)
);
