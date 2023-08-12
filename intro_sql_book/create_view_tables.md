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
