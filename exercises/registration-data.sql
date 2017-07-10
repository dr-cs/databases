use registration;

insert into student values (11,'Bush',3.0);
insert into student values (12,'Cruz',3.2);
insert into student values (13,'Clinton',3.9);
insert into student values (22,'Sanders',3.0);
insert into student values (33,'Trump',3.8);

insert into dept values ('CS','Computer Science','Rubio','Ajax',100);
insert into dept values ('Math','Mathemagics','Carson','Acme',300);
insert into dept values ('EE','Electrical Engineering','Kasich','Ajax',200);
insert into dept values ('IE','Industrial Engineering','Cruz','West',200);
insert into dept values ('Music','Musicology','Costello','North',100);

insert into course values ('CS',101,'Programming',4);
insert into course values ('CS',201,'Algorithms',3);
insert into course values ('CS',202,'Systems',3);
insert into course values ('Math',101,'Algebra',3);
insert into course values ('Math',201,'Calculus',4);
insert into course values ('Math',301,'Analysis',4);
insert into course values ('Music',104,'Jazz',3);
insert into course values ('EE',102,'Circuits',3);
insert into course values ('IE',101,'Proabability',3);
insert into course values ('IE',102,'Statistics',3);

insert into enrolled values ('CS',101,11);
insert into enrolled values ('Math',101,11);
insert into enrolled values ('CS',101,12);
insert into enrolled values ('CS',201,22);
insert into enrolled values ('Math',201,33);
insert into enrolled values ('EE',102,33);
insert into enrolled values ('Math',301,22);
