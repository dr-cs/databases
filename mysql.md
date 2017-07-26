---
layout: default
title: CS 4400 - MySQL Guide
---

# MySQL Guide

This guide walks you through installation, intitial setup, and general use of MySQL on your computer. After using this guide to install MySQL and become comfortable with the command-line client, you should bookmark the [MySQL online reference manual](https://dev.mysql.com/doc/refman/5.7/en/) to learn details.

## Installing MySQL

### Linux

If you run Linux, you already know how to install MySQL. :-)

### Mac OS X

1. Install [Homebrew](http://brew.sh/)
2. Use [Homebrew](http://brew.sh/) to install MySQL:

    ```bash
    $ brew install mysql
    ```

#### Occasional Problem with Homebrew Version of macOS

Every semester a few students do something that causes `mysql.server start` to fail with an error message that looks something like:

```sh
ERROR! The server quit without updating PID file (/usr/local/var/mysql/username.local.pid).
```

Here's a brute force fix that seems to work:

1. Uninstall mysql.
2. Delete the `/usr/local/var/mysql` directory.
3. Install mysql.

Here's how a shell session executing the steps above might look:

```sh
$ brew uninstall mysql
$ sudo rm -rf /usr/local/var/mysql
$ brew install mysql
```

### Windows

1. Download and run the Windows installer from [dev.mysql.com](https://dev.mysql.com/downloads/installer/)

    - Be sure to select the "Developer" option, which installs the MySQL server and various client programs.

2. To be able to run the `mysql` command line client you'll need to add the MySQL installation binaries directory to your `PATH`. Copy the following path element to your clipboard:

```
C:\Program Files\MySQL\MySQL Server 5.7\bin
```
Now open your control panel, search for the "set environment variables" option, click the "Environment Variables" button, select the Path environment variable, and add the text you just copied to the clipboard. Here's a document explaining how to set environment variables in Windows: [environment variables](http://cs1331.gatech.edu/environment-variables.html). After you add the MySQL bin directory to your path, close the Windows command shell and re-open it so it re-reads the environment variables.


## Running MySQL

MySQL is a client-server database system. To "run MySQL" you need both a server and a client.

1. Run the MySQL server (will already be running on a standard Windows or Linux installation):

    ```bash
    $ mysql.server start
    ```

2. Connect using the MySQL command line client. The general form of the `mysql` command is:

    ```bash
    $ mysql -h <host_name> -u <user_name> -p <database_name>
    ```

- `<host_name>` is the name of the computer. Leave blank to connect to the MySQL server runnign on your computer (also known as `localhost`).
- `<user_name>` is the name of a MySQL user. Leave blank to use the user name of the shell account under which you run 'mysql`.
- `-p` tells `mysql` to prompt for `<user_name>`'s password before connecting. If the user specified in `-u` has an empty password, you can leave off `-p`.
- `<database_name>` is the name of a database to use upon starting the `mysql` client.

So running the MySQL client as thr root user would look like this:

```sh
$ mysql -u root -p
Enter password:
Welcome to MySQL ...
...
mysql>
```

The password is either empty, if you installed on macOS with HomeBrew or some linux package managers, or it's some value you chose when you ran the MySQL installer.

## Initial MySQL Setup

Note: this step is optional. For most students you can skip user creation and root user password creation and simply use the root user with no password, which is fine as long as your operating system doesn't allow connections on port 3306, the port on which the MySQL server listens.

### Setting a root password

MySQL has user accounts similar to operating system shells. If your installer asks you for a password for the MySQL root user, give it one. If your installer does not ask for a root password then the root password is blank. You can set a root password like this (`$` is the OS shell prompt, `mysql>` is the `mysql` client prompt):

```bash
$ mysql.server start
Starting MySQL
 SUCCESS!
$ mysql -u root -p
Enter password: (press ENTER)
mysql> alter user 'root'@'localhost' identified by 'rootpassword';
Query OK, 0 rows affected (0.01 sec)

```

In the example above `rootpassword` is the root user's password. You should choose something other than the literal string `rootpassword`, or if you set a password during installation and wish to set the password to the empty string to save yourself some typing, you can set the root user's password to nothing like this:

```bash
mysql> alter user 'root'@'localhost' identified by '';
```

### Creating a User (Optional)

After setting a root password it's a good idea to set up MySQL user accounts for different purposes. For example, you can create a MySQL user account for CS 4400 example databases and another user for your project work. To set up a user (assuming `mysql.server` has already been started):

1. Log into the MySQL client program as root:

    ```bash
    $ mysql -u root -p
    Enter password: (enter the password you set above)
    ```

2. Create a user:

    ```bash
    mysql> create user 'cs4400'@'localhost' identified by 'cs4400password';
    Query OK, 0 rows affected (0.00 sec)
    ```

3. Grant permissions for each database you want your user to use. (Note: you can grant permissions on a database before the database exists.)

    ```bash
    mysql> grant all on humanedb.* to 'cs4400'@'localhost';
    Query OK, 0 rows affected (0.00 sec)
    ```

## Running The MySQL Interactive Command Line Client

All SQL commands and queries must be terminated with a semicolon. Some MySQL don't need to be terminated with a semicolon but function with a semicolon as well, so get in the habit of using semicolons.

### Running SQL Scripts

Download the following files for practice:

- [pubs-schema.sql](resources/pubs-schema.sql)
- [pubs-data.sql](resources/pubs-data.sql)

Method 1: redirect input when running mysql client from OS command line

```sql
$ mysql -u root < pubs-schema.sql
```

Method 2: use the source when already in a mysql shell in the directory containing your SQL script

```sql
mysql> source pubs-data.sql
```

Note: to follow along with the rest of this guide you'll need to run both SQL files.

### `show databases`

The MySQL server can store many databases. To list the databases available in your MySQL server, use `show databases`.

```sql
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| company            |
| dorms              |
| mysql              |
| performance_schema |
| pubs               |
| sakila             |
| sys                |
| teach              |
+--------------------+
9 rows in set (0.00 sec)
```

### `use <database>`

To issue SQL commands and queries you'll need to `use` a database, and you can only use one database at a time.

```sql
mysql> use pubs;
Database changed
mysql>
```


### `show tables`

```sql
mysql> show tables;
+----------------+
| Tables_in_pubs |
+----------------+
| author         |
| author_pub     |
| book           |
| pub            |
+----------------+
4 rows in set (0.00 sec)

mysql>
```