create table employee (
  Fname varchar(15) not null,
  Minit char,
  Lname varchar(15) not null,
  Ssn char(9) not null,
  Bdate date,
  Address varchar(30),
  Sex char,
  Salary decimal(10,2),
  Super_ssn char(9),
  Dno int,
  primary key (Ssn)
);

create table department (
  Dname varchar(15) not null,
  Dnumber int not null,
  Mgr_ssn char(9) not null,
  Mgr_start_date date,
  primary key (Dnumber),
  unique (Dname),
  foreign key (Mgr_ssn) references employee (Ssn)
);

create table dept_locations (
  Dnumber int not null,
  Dlocation varchar(15) not null,
  primary key (Dnumber, Dlocation),
  foreign key (Dnumber) references department (Dnumber)
);

create table project (
  Pname varchar(15) not null,
  Pnumber int not null,
  Plocation varchar(15),
  Dnum int not null,
  primary key (Pnumber),
  unique (Pname),
  foreign key (Dnum) references department (Dnumber)
);

create table works_on (
  Essn char(9) not null,
  Pno int not null,
  Hours decimal(3,1) not null,
  primary key (Essn, Pno),
  foreign key (Essn) references employee (Ssn),
  foreign key (Pno) references project (Pnumber)
);

create table dependent (
  Essn char(9) not null,
  Dependent_name varchar(15) not null,
  Sex char,
  Bdate date,
  Relationship varchar(8),
  primary key (Essn, Dependent_name),
  foreign key (Essn) references employee(Ssn)
);

insert into EMPLOYEE values ('John', 'B', 'Smith', 123456789, '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, 333445555, 5);
insert into EMPLOYEE values ('Franklin', 'T', 'Wong', 333445555, '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, 888665555, 5);
insert into EMPLOYEE values ('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321 Castle, Spring, Tx', 'F', 25000, 987654321, 4);
insert into EMPLOYEE values ('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000, 888665555, 4);
insert into EMPLOYEE values ('Ramesh', 'K', 'Narayan', 666884444, '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, 333445555, 5);
insert into EMPLOYEE values ('Joyce', 'A', 'English', 453453453, '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, 333445555, 5);
insert into EMPLOYEE values ('Ahmad', 'V', 'Jabbar', 987987987, '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000, 987654321, 4);
insert into EMPLOYEE values ('James', 'E', 'Borg', 888665555, '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);

insert into DEPARTMENT values ('Research', 5, 333445555, '1988-05-22');
insert into DEPARTMENT values ('Administration', 4, 987654321, '1995-01-01');
insert into DEPARTMENT values ('Headquarters', 1, 888665555, '1981-06-19');

insert into DEPT_LOCATIONS values (1, 'Houston');
insert into DEPT_LOCATIONS values (4, 'Stafford');
insert into DEPT_LOCATIONS values (5, 'Bellaire');
insert into DEPT_LOCATIONS values (5, 'Sugarland');
insert into DEPT_LOCATIONS values (5, 'Houston');

insert into WORKS_ON values (123456789, 1, 32.5);
insert into WORKS_ON values (123456789, 2, 7.5);
insert into WORKS_ON values (666884444, 3, 40.0);
insert into WORKS_ON values (453453453, 1, 20.0);
insert into WORKS_ON values (453453453, 2, 20.0);
insert into WORKS_ON values (333445555, 2, 10.0);
insert into WORKS_ON values (333445555, 3, 10.0);
insert into WORKS_ON values (333445555, 10, 10.0);
insert into WORKS_ON values (333445555, 20, 10.0);
insert into WORKS_ON values (999887777, 30, 30.0);
insert into WORKS_ON values (999887777, 10, 10.0);
insert into WORKS_ON values (987987987, 10, 35.0);
insert into WORKS_ON values (987987987, 30, 5.0);
insert into WORKS_ON values (987654321, 30, 20.0);
insert into WORKS_ON values (987654321, 20, 15.0);
insert into WORKS_ON values (888665555, 20, NULL);

insert into PROJECT values ('ProductX', 1, 'Bellaire', 5);
insert into PROJECT values ('ProductY', 2, 'Sugarland', 5);
insert into PROJECT values ('ProductZ', 3, 'Houston', 5);
insert into PROJECT values ('Computerization', 10, 'Stafford', 4);
insert into PROJECT values ('Reorganization', 20, 'Houston', 1);
insert into PROJECT values ('Newbenefits', 30, 'Stafford', 4);

insert into DEPENDENT values (333445555, 'Alice', 'F', '1986-04-05', 'Daughter');
insert into DEPENDENT values (333445555, 'Theodore', 'M', '1983-10-25', 'Son');
insert into DEPENDENT values (333445555, 'Joy', 'F', '1958-05-03', 'Spouse');
insert into DEPENDENT values (987654321, 'Abner', 'M', '1942-02-28', 'Spouse');
insert into DEPENDENT values (123456789, 'Michael', 'M', '1988-01-04', 'Son');
insert into DEPENDENT values (123456789, 'Alice', 'F', '1988-12-30', 'Daughter');
insert into DEPENDENT values (123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse');
