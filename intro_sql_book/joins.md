# SQL Joins

Queries across multiple tables uses JOIN clauses.
  - Link two tables together, usually based on keys defining the relationship between the two tables. 
  - Several types of JOINs
    - `INNER`
    - `LEFT OUTER`
    - `RIGHT OUTER`
    - `FULL OUTER`
    - `CROSS`

  
## General `JOIN` syntax

```sql
SELECT table_nameN.column_name, ...
FROM table_name1
join_type JOIN table_name2
  ON join_condition;
```

Breakdown of above syntax:

`SELECT table_nameN.column_name...`

  - Columns in list are prepended with table name.

```sql
FROM table_name1
join_type JOIN table_name2
  ON join_condition
```

To join one table to another, PostgreSQL needs: 
  - The name of first table to join
  - Type of join to user
  - Name of second table to join
  - Join condition


Join condition: 
  - defines the logic by which a row in one table is joined to a row in another table. 
    - in most cases, created using primary key of one table and the foreign key of the table we want to join with. 


```sql
SELECT colors.color, shapes.shape
  FROM colors
  JOIN shapes
    ON colors.id = shapes.color_id;
```

Breakdown: 

`SELECT colors.color, shapes.shape`

  - We would like to select the `color` column from the `colors` table and the `shape` column from the `shapes` table.

`FROM colors`
  - starting point for the query. 

`JOIN shapes`
  - starting with the `colors` table, join with the shapes table.

`ON colors.id = shapes.color_id`
  - look through the colors.id column
    - for each id, check if there is a matching value in the `shapes.color_id` column.
    - for each match, join the two rows together to create a new row in the join table. 

- Once the join table is created based on the `ON` condition of the `JOIN` clause, the `SELECT` statement is executed in relation to the join table. 

We are effectively saying: 

```sql
SELECT colors.color, shapes.shape
  FROM shapes_colors_join_table;
```

**One of the most important things to remember about how joins work is that we set a condition that compares a value from the first table (usually a primary key), with one from the second table (usually a foreign key). If the condition that uses these two values evaluates to true, then the row that holds the first value is joined with the row that holds the second value.**