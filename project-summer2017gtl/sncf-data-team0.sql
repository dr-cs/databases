use sncf_team0;

insert into address values (1, 'rue Paris', null, 'Paris', 'Île-de-France', '75001', 'France');
insert into address values (2, 'rue Metz', null, 'Metz', 'Grand-Est', '57000', 'France');
insert into address values (3, 'rue Nancy', null, 'Nancy', 'Grand-Est', '75001', 'France');
insert into address values (4, 'rue Strasbourg', null, 'Strasbourg', 'Grand-Est', '75001', 'France');
insert into address values (5, 'rue Avignon', null, 'Avignon', 'Grand-Est', '57000', 'France');
insert into address values (6, 'rue Aix', null, 'Aix', 'Grand-Est', '57000', 'France');
insert into address values (7, 'rue Marseille', null, 'Marseille', 'Grand-Est', '57000', 'France');
insert into address values (8, 'rue Lyon', null, 'Lyon', 'Grand-Est', '57000', 'France');
insert into address values (9, 'rue Nice', null, 'Nice', 'Grand-Est', '57000', 'France');
insert into address values (10, 'rue Dijon', null, 'Dijon', 'Grand-Est', '57000', 'France');
insert into address values (11, 'rue Bordeaux', null, 'Bordeaux', 'Grand-Est', '57000', 'France');
insert into address values (12, 'rue Rennes', null, 'Rennes', 'Grand-Est', '57000', 'France');
insert into address values (13, 'rue Lille', null, 'Lille', 'Grand-Est', '57000', 'France');

insert into station values (1, 'Paris', 1);
insert into station values (2, 'Metz', 2);
insert into station values (3, 'Nancy', 3);
insert into station values (4, 'Strasbourg', 4);
insert into station values (5, 'Avignon', 5);
insert into station values (6, 'Aix', 6);
insert into station values (7, 'Marseille', 7);
insert into station values (8, 'Lyon', 8);
insert into station values (9, 'Nice', 9);
insert into station values (10, 'Dijon', 10);
insert into station values (11, 'Bordeaux', 11);
insert into station values (12, 'Rennes', 12);
insert into station values (13, 'Lille', 13);

insert into train values (1, 100, .1);
insert into train values (2, 100, .1);
insert into train values (3, 100, .1);
insert into train values (4, 100, .1);
insert into train values (5, 100, .1);
insert into train values (6, 100, .1);
insert into train values (7, 100, .1);
insert into train values (8, 100, .1);
insert into train values (9, 100, .1);
insert into train values (10, 100, .1);
insert into train values (11, 100, .1);
insert into train values (12, 100, .1);
insert into train values (13, 100, .1);

-- Metz - Paris - Rennes
insert into stop values (1, 1, 2, null, '8:00', 0);
insert into stop values (2, 1, 1, '9:30', '9:40', 300);
insert into stop values (3, 1, 12, '11:00', null, 500);

-- Lille - Paris - Avignon - Aix - Marseille
insert into stop values (4, 2, 13, null, '9:00', 0);
insert into stop values (5, 2, 1, '10:00', '10:10', 200);
insert into stop values (6, 2, 5, '12:00', '12:10', 500);
insert into stop values (7, 2, 6, '13:00', '13:10', 550);
insert into stop values (8, 2, 7, '15:00', null, 0);
