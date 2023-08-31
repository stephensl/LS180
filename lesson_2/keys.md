# Using Keys

Keys are identifiers for specific rows of data in a database table. 

## Natural Key
  - existing value in dataset that can be used to uniquely identify each row of data. 
  - natural 'part of the data'
    - Not ideal solution for large data sets, where there may be difficulty establishing enduring distinct values. 
      - email address, ssn, phone #, address etc. 

## Surrogate Keys 
  - Created solely for identifying row of data in table. 
    - most common is auto incrementing integer. 
    
    
    ```sql
    CREATE TABLE colors (id serial, name text);
    ```


### `serial` columns
```sql
-- This statement:
CREATE TABLE colors (id serial, name text);

-- is actually interpreted as if it were this one:
CREATE SEQUENCE colors_id_seq;
CREATE TABLE colors (
    id integer NOT NULL DEFAULT nextval('colors_id_seq'),
    name text
);
```

## Sequence
- Sequence is a special type of relation that generates a series of numbers. 
  - above, is used as the `id` column's default value.
  - the next value of a sequence is accessed using `nextval`
    - can be used in any SQL statement
```sql
SELECT nextval('colors_id_seq');
```

Once a number is returned by `nextval` for a standard sequence, it will not be returned again, regardless of whether the value was stored in a row or not. 

If we have the table: 

```sql
sql-course=# SELECT * FROM colors;
 id | name
----+-------
  1 | red
  2 | green
  3 | blue
(3 rows)
```

then run the following:

```sql
SELECT nextval('colors_id_seq');
```
This will return `4`...

Now if we add a row... 

```sql
INSERT INTO colors (name)
  VALUES ('purple');
```

we skip `4` for the `id` of the new row

```sql
sql-course=# SELECT * FROM colors;
 id | name
----+-------
  1 | red
  2 | green
  3 | blue
  5 | purple  -- skipped 4, because nextval will not return same value more than once. 
  (4 rows)
```

#
#

## Enforcing Uniqueness

At this point, we can add duplicate values to row ids.

```sql
INSERT INTO colors (id, name) VALUES (3, 'orange');

-- INSERT 0 1

SELECT * FROM colors;

--  id |  name
-- ----+--------
--   1 | red
--   2 | green
--   3 | blue
--   5 | yellow
--   3 | orange    ** duplicate id
-- (5 rows)
```

Add UNIQUE constraint

```sql
ALTER TABLE colors
  ADD CONSTRAINT id_unique UNIQUE (id);

-- ERROR could not create unique index "id_unique"
-- DETAIL: Key (id)=(3) is duplicated.
```

We must first fix the duplicate..

```sql
UPDATE colors 
  SET id = nextval('colors_id_seq')
  WHERE name = 'orange';

-- UPDATE 1

ALTER TABLE colors
  ADD CONSTRAINT id_unique UNIQUE (id);

-- ALTER TABLE
```

```sql
SELECT * FROM colors;

--  id |  name
-- ----+--------
--   1 | red
--   2 | green
--   3 | blue
--   5 | yellow
--   6 | orange
-- (5 rows)
```

##
##

## Primary Keys

Serial is shortcut for creating columns with default auto-incrementing value.

Using `PRIMARY KEY` is a shortcut for creating columns that uniquely identify the rows in a table. 

```sql
CREATE TABLE more_colors (
  id int PRIMARY KEY, 
  name text
);
```

This will enforce unique values, and NOT NULL. works the same as...

```sql
CREATE TABLE more_colors (
  id int NOT NULL UNIQUE,
  name text
);
```

**By using `PRIMARY KEY` makes design intention clear that using `id` column can be relied upon to identify specific rows, as this is part of the table's schema.**

Note that, though `PRIMARY KEY` is effectively the same as having both `NOT NULL` and `UNIQUE` constraints, the `PRIMARY KEY` *does not require those constraints*. 

In particular, if you want to change an existing column to a `PRIMARY KEY`, you don't have to add the `NOT NULL` and `UNIQUE` constraints first -- all that is required is that the column contains unique values, none of which are `NULL`.


#
#

## Conventions

1. All table should have a primary key column called `id`
2. The `id` column should automatically be set to a unique value as new rows inserted into the table.
3. The `id` column will often be an integer, but there are other data types (UUIDs) that can provide specific benefits. 

**Generally a good idea to declare a column as `PRIMARY KEY` in every table.**

#

### UUID

Universally Unique Identifiers
  - very large numbers used to identify individual objects, or when working with database, rows in a database. 
  - often represented using hexadecimal strings with dashes such as `f47ac10b-58cc-4372-a567-0e02b2c3d479`.

#
#


## Practice Problems

1. Write SQL statement that makes a new sequence called "counter".

```sql
CREATE SEQUENCE counter
```

2. Write a SQL statement to retrieve the next value from the sequence created in #1.

```sql
SELECT nextval('counter');
```

3. Write a SQL statement that removes a sequence called "counter".

```sql
DROP SEQUENCE counter;
```

4. Is it possible to create a sequence that returns only even numbers? The documentation for sequence might be useful.

Yes, you can define the starting point, and increment values for the sequence..

```sql
CREATE SEQUENCE even_count
  INCREMENT BY 2
  START WITH 2;  -- or MINVALUE 2
```

5. What will the name of the sequence created by the following SQL statement be?

```sql
CREATE TABLE regions (
  id serial PRIMARY KEY.
  name text, 
  area integer
);
```

`regions-id-seq`


6. Write a SQL statement to add an auto-incrementing integer primary key column to the films table.

```sql
ALTER TABLE films
ADD COLUMN id serial PRIMARY KEY;
```

7. What error do you receive if you attempt to update a row to have a value for id that is used by another row?

```sql
ERROR:  duplicate key value violates unique constraint "films_pkey"
DETAIL:  Key (id)=(4) already exists.
```

8. What error do you receive if you attempt to add another primary key column to the films table?

```sql
ALTER TABLE films
ADD COLUMN another_id serial PRIMARY KEY;

-- ERROR:  multiple primary keys for table "films" are not allowed
```

9. Write a SQL statement that modifies the table `films` to remove its primary key while preserving the `id` column and the values it contains.

```sql
ALTER TABLE films DROP CONSTRAINT films_pkey;
```
