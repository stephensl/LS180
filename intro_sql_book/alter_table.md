# Alter a table

## Syntax

`ALTER TABLE` statement
  - part of DDL
  - altering table schema only, not data

- Example: 

```sql
ALTER TABLE table_to_change
  stuff_to_change
  additional_arguments
```


##

## Renaming a Table

```sql
ALTER TABLE users
  RENAME TO all_users;
```

#
#

## Renaming a Column

```sql
ALTER TABLE all_users
  RENAME COLUMN username TO full_name;
```

#
#

## Changing column data type

```sql
ALTER TABLE all_users
  ALTER COLUMN full_name TYPE varchar(25)
```

#
#

## Adding a Constraint

`NOT NULL` is always a column constraint
  - special syntax for adding to existing table

  ```sql
  ALTER TABLE table_name
    ALTER COLUMN column_name
    SET NOT NULL;
  ```

  ```sql
  ALTER TABLE all_users
    ALTER COLUMN full_name
    SET NOT NULL;
  ```

*** To add any other constraint to existing table use: ***

```sql 
ALTER TABLE table_name 
  ADD [ CONSTRAINT constraint_name ]
  constraint_clause;
```


#
#


## Removing a constraint

For most types, use same syntax for both column and table constraints.

```sql
ALTER TABLE table_name
  DROP CONSTRAINT constraint_name;
```

To remove `DEFAULT` clause, such as in data type `serial`

```sql
ALTER TABLE all_users
  ALTER COLUMN id
  DROP DEFAULT;
```

#
#
#


## Adding a column

Use `ADD COLUMN` clause in `ALTER TABLE` statement

```sql
ALTER TABLE all_users
  ADD COLUMN last_login timestamp
  NOT NULL
  DEFAULT NOW();
```

*`NOW()` is a SQL function, provides current data and time when called*

#
#
#


## Removing a Column

```sql
ALTER TABLE all_users
  DROP COLUMN enabled;
```


#
#
#

## Removing a Table

```sql
DROP TABLE all_users;
```

#
#

# Summary


- Renaming a table
- Renaming a column
- Changing a column's data type
- Adding a constraint
- Removing a constraint
- Adding a column
- Removing a column
- Dropping a table


#
#

# Exercises 

1. Make sure you are connected to the encyclopedia database. Rename the famous_people table to celebrities.

```sql
psql -d encyclopedia

ALTER TABLE famous_people
  RENAME TO celebrities;
```

2. Change the name of the name column in the celebrities table to first_name, and change its data type to varchar(80).
Solution

```sql
ALTER TABLE celebrities
RENAME COLUMN name TO first_name;

ALTER TABLE celebrities
ALTER COLUMN first_name TYPE varchar(80);
```

3. Create a new column in the celebrities table called last_name. It should be able to hold strings of lengths up to 100 characters. This column should always hold a value


```sql
ALTER TABLE celebrities
  ADD COLUMN last_name varchar(100) NOT NULL;
```

4. Change the celebrities table so that the date_of_birth column uses a data type that holds an actual date value rather than a string. Also ensure that this column must hold a value.

```sql
ALTER TABLE celebrities
  ALTER COLUMN date_of_birth TYPE date
    USING date_of_birth::date,
  ALTER COLUMN date_of_birth SET NOT NULL;
```

5. Change the max_weight_kg column in the animals table so that it can hold values in the range 0.0001kg to 200,000kg

```sql
ALTER TABLE animals
  ALTER COLUMN max_weight_kg TYPE decimal(10,4);
```

6. Change the animals table so that the binomial_name column cannot contain duplicate values.

```sql
ALTER TABLE animals
  ADD CONSTRAINT unique_binomial_name UNIQUE
  (binomial_name);
```

7. Connect to the ls_burger database. Add the following columns to the orders table:

    - A column called customer_email; it should hold strings of up to 50 characters.
    
    - A column called customer_loyalty_points that should hold integer values. If no value is specified for this column, then a   value of 0 should be applied.

  ```sql
  ALTER TABLE orders
  ADD COLUMN customer_email varchar(50),
  ADD COLUMN customer_loyalty_points integer DEFAULT 0;
  ```

8. Add three columns to the orders table called burger_cost, side_cost, and drink_cost to hold monetary values in dollars and cents (assume that all values will be less than $100). If no value is entered for these columns, a value of 0 dollars should be used.

```sql
ALTER TABLE orders
  ADD COLUMN burger_cost decimal(4,2) DEFAULT 0,
  ADD COLUMN side_cost decimal(4,2) DEFAULT 0,
  ADD COLUMN drink_cost decimal(4,2) DEFAULT 0;
```

9. Remove the order_total column from the orders table.

```sql
ALTER TABLE orders
  DROP COLUMN order_total;
```

#
#
#


INSERT INTO player_scores (name, team, score) VALUES ('Julie', 'Red', 22);
INSERT INTO player_scores (name, team, score) VALUES ('Mario', 'Gold', 18);
INSERT INTO player_scores (name, team, score) VALUES ('Steve', 'Red', 25);
INSERT INTO player_scores (name, team, score) VALUES ('Ruby', 'Blue', 30);
INSERT INTO player_scores (name, team, score) VALUES ('Dolores', 'Blue', 19);
INSERT INTO player_scores (name, team, score) VALUES ('Shawn', 'Gold', 27);
INSERT INTO player_scores (name, team, score) VALUES ('Lucas', 'Red', 28);
INSERT INTO player_scores (name, team, score) VALUES ('Ella', 'Gold', 24);
INSERT INTO player_scores (name, team, score) VALUES ('Alberto', 'Blue', 21);
