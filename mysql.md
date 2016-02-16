---
layout: default
title: CS 4400 - MySQL Guide
---

# MySQL Guide

This guide walks you through installation, intitial setup, and general use of MySQL on your computer.

## Installing MySQL

### Linux

If you run Linux, you already know how to install MySQL. :-)

### Mac OS X

1. Install [Homebrew](http://brew.sh/)
2. Use [Homebrew](http://brew.sh/) to install MySQL:

    ```sh
    $ brew install mysql
    ```

### Windows

1. Download and run the Windows installer from [dev.mysql.com](https://dev.mysql.com/downloads/installer/)

## Running MySQL

MySQL is a client-server database system. To "run MySQL" you need both a server and a client.

1. Run the MySQL server:

    ```sh
    $ mysql.server start
    ```

2. Connect using the MySQL command line client. The general form of the `mysql` command is:

    ```sh
    $ mysql -h <host_name> -u <user_name> -p <database_name>
    ```

- `<host_name>` is the name of the computer. Leave blank to connect to the MySQL server runnign on your computer (also known as `localhost`).
- `<user_name>` is the name of a MySQL user. Leave blank to use the user name of the shell account under which you run 'mysql`.
- `-p` tells `mysql` to prompt for `<user_name>`'s password before connecting.
- `<database_name>` is the name of a database to use upon starting the `mysql` client.


## Initial MySQL Setup

### Setting a root password

MySQL has user accounts similar to operating system shells. If your installer asks you for a password for the MySQL root user, give it one. If your installer does not ask for a root password then the root password is blank. You can set a root password like this (`$` is the OS shell prompt, `mysql>` is the `mysql` client prompt):

```sh
$ mysql.server start
Starting MySQL
 SUCCESS!
$ mysql -u root -p
Enter password: (press ENTER)
mysql> alter user 'root'@'localhost' identified by 'rootpassword';
Query OK, 0 rows affected (0.01 sec)

```

### Creating a User

After setting a root password it's a good idea to set up MySQL user accounts for different purposes. For example, you can create a MySQL user account for CS 4400 example databases and another user for your project work. To set up a user (assuming `mysql.server` has already been started):

1. Log into the MySQL client program as root:

    ```sh
    $ mysql -u root -p
    Enter password: (enter the password you set above)
    ```

2. Create a user:

    ```sh
    mysql> create user 'cs4400'@'localhost' identified by 'cs4400password';
    Query OK, 0 rows affected (0.00 sec)
    ```

3. Grant permissions for each database you want your user to use. (Note: you can grant permissions on a database before the database exists.)

    ```sh
    mysql> grant all on humanedb.* to 'cs4400'@'localhost';
    Query OK, 0 rows affected (0.00 sec)
    ```
