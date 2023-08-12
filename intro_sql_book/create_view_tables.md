# Create and View Tables
  - we created a database, which is like the shell of the building
    - we need to create rooms in order to have location to organize stuff (data)
      - in SQL terms, we need to create tables. 

##

## Table Creation Syntax

`CREATE TABLE some_table();`

- Columns are what give tables their structure.
  - place column definitions between the `()`

```sql
CREATE TABLE table_name (
  column_1_name column_1_data_type [constraints,...],
  column_2_name column_2_data_type [constraints,...],
  .
  .
  .
  constraints
);
```

### Column names and data types are a required part of each column definition; constraints are optional.

### Constraints can be defined at either column level, or table level.

# 
#
#
#


## Creating a `users` table

Requirements: in `sql_book` database..
  - store list of users
    - for each user store:
      - `id`
      - `username`
      - `enabled/disabled` account


```sql
CREATE TABLE 
  users (
          id serial UNIQUE NOT NULL,
          username char(25),
          enabled boolean DEFAULT TRUE
  );
```

- `CREATE TABLE`: primary command

- `users`: name of table being created

- `()`: information within is related to columns in table

- `id, username, enabled`: three columns of the table

- `serial`, `char(25)`, `boolean`: data types of the columns

- `UNIQUE`, `NOT NULL`: constraints (column level)

- `DEFAULT TRUE`: specifies default value for the column

#


#
#
#

# Data Types

  - `serial` (deprecated) use `IDENTITY`
    - Integer identifier for columns. 

  #

  - `char(n)`
    - strings up to (n) chars in length
    - if string less than (n) in length, remaining length filled with space chars. 

  - `varchar(n)`
    - same as above, but if shorter string, remaining string length isn't used. 

  ** The difference between the two above in what to do with the remaining string length is a matter of tradeoffs. 

  Using char(n) and accepting that all unused string length (n - string_length), will be filled with spaces. 
    - consistent size
    - consistent string length
    - fixed length strings may be better performance-wise

  vs

  Using varchar(n)

    - potential for less storage
    - variable string lengths in data content
      - are exact string lengths in this particular column useful? ? char || var
      - 

#

  - `boolean`
    - true or false, displayed as `t` or `f`

#

  - `integer` or `INT`
    - whole number
    - may be less than 0

#

  - `decimal(precision scale)`
    - takes two arguments
      
      - `precision` 
        - total number of digits

      - `scale`
        - number of digits in fractional part, right of decimal

#

  - `timestamp`
    - contains both a simple date and time
      - `YYYY-MM-DD HH:MM:SS`

  -   `date`
    - date without time

##
##

##

## Keys and Constraints

Keys and constraints
  - rules that define what data values are allowed in certain columns. 
    - ensure data reliability and integrity. 

  - may apply to:
    - specific column
    - specific table
    - more than one table
    - entire schema

in `users` example:

```sql
CREATE TABLE users (
  id serial UNIQUE NOT NULL,
  username char(25), 
  enabled boolean DEFAULT TRUE 
);
```

Constraints:
  - `UNIQUE`
    - prevents duplicate values in column

  - `NOT NULL`
    - value must be specified and non-empty

  - `DEFAULT`
    - if no value set in this field when record created defaults to `TRUE`

  

##
##


# Exercises

1. From the Terminal, create a database called encyclopedia and connect to it via the psql console.

`createdb encyclopedia`

#
#


2. Create a table called countries. It should have the following columns:

    - An id column of type serial
    - A name column of type varchar(50)
    - A capital column of type varchar(50)
    - A population column of type integer

The name column should have a UNIQUE constraint. The name and capital columns should both have NOT NULL constraints.


```sql
CREATE TABLE countries (
  id serial,
  name varchar(50) UNIQUE NOT NULL,
  capital varchar(50) NOT NULL,
  population integer
);
```

#
#


3. Create a table called famous_people. It should have the following columns:

    - An id column that contains auto-incrementing values
    - A name column. This should contain a string up to 100 characters in length
    - An occupation column. This should contain a string up to 150 characters in length
    - A date_of_birth column that should contain each person's date of birth in a string of up to 50 characters
    - A deceased column that contains either true or false

The table should prevent NULL values being added to the name column. If the value of the deceased column is absent or unknown then false should be used.

```sql
CREATE TABLE famous_people (
  id serial,
  name varchar(100) NOT NULL,
  occupation varchar(150),
  date_of_birth varchar(50),
  deceased boolean DEFAULT false
);
```

#
#


4. Create a table called animals that could contain the sample data below:

Name 	      Binomial Name 	  Max Weight (kg) 	Max Age (years) 	Conservation Status
Lion 	        Pantera leo 	      250 	                20 	                VU
Killer Whale  Orcinus orca 	      6,000 	              60 	                DD
Golden Eagle 	Aquila chrysaetos 	6.35 	                24 	                LC

  - The database table should also contain an auto-incrementing id column.
  - Each animal should always have a name and a binomial name.
  - Names and binomial names vary in length but never exceed 100 characters.
  - The max weight column should be able to hold data in the range 0.001kg to 40,000kg
  - Conservation Status is denoted by a combination of two letters (CR, EN, VU, etc).

```sql
CREATE TABLE animals (
  id serial,
  name varchar(100) NOT NULL,
  binomial_name varchar(100) NOT NULL,
  max_weight_kg decimal(8,3),
  max_age_years integer,
  conservation_status char(2)
);
```


5. List all of the tables in the encyclopedia database.

`\dt`

6. Display the schema for the animals table.

`\d animals`

7. Create a database called ls_burger and connect to it.

`CREATE DATABASE ls_burger;`

`\c ls_burger`

8. Create a table in the ls_burger database called orders. The table should have the following columns:

    - An id column, that should contain an auto-incrementing integer value.
    - A customer_name column, that should contain a string of up to 100 characters
    - A burger column, that should hold a string of up to 50 characters
    - A side column, that should hold a string of up to 50 characters
    - A drink column, that should hold a string of up to 50 characters
    - An order_total column, that should hold a numeric value in dollars and cents. Assume that all orders will be less than $100.

The customer_name and order_total columns should always contain a value.

```sql
CREATE TABLE orders (
  id serial,
  customer_name varchar(100) NOT NULL,
  burger varchar(50),
  side varchar(50),
  drink varchar(50),
  order_total decimal(4,2) NOT NULL
);
```

##
##
##