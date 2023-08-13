# Update data in table

## `UPDATE` statement

```sql
UPDATE table_name
SET column_name = value, ...
WHERE expression;
```
*can specify multiple `column_name = value` entries.*

  - This statement can be read as: Set column(s) to these values in a table when an expression evaluates to true.

#

#

### Updating all the rows (uncommonly used in practice)

```sql
UPDATE users SET enabled = false;
```

### Updating specific rows

```sql
UPDATE users SET enabled = true
  WHERE full_name = 'Harry Potter'
  OR full_name = 'Jane Smith';
```

- If targeting specific row, useful to use `id`

```sql
UPDATE users SET full_name = 'Alice Walker' WHERE id = 2;
```


#
#
#

## Deleting Data

Used to remove entire row(s) from database table.

```sql
DELETE FROM table_name WHERE expression;
```

### Deleting specific rows

```sql
DELETE FROM users
WHERE full_name = 'Harry Potter' AND id > 3;
```

### Deleting all rows

```sql
DELETE FROM users;
```

#
#
#

## `UPDATE` vs `DELETE`

Key difference between how `UPDATE` works vs how `DELETE` works:

- with `UPDATE` you can update one or more columns within one or more rows by using the `SET` clause
- with `DELETE` you can only delete one or more *entire* rows, not particular pieces of data within those rows.

Workaround using `NULL`
  - by using an `UPDATE` statement to `SET` specific value to `NILL` we are not deleting, but effectively removing the value. 

  ```sql
  UPDATE table_name
  SET column_name1 = NULL
  WHERE expression;
  ```

  #
  #


  ## Exercises

1. Make sure you are connected to the encyclopedia database. Add a column to the animals table called class to hold strings of up to 100 characters.

Update all the rows in the table so that this column holds the value Aves.

```sql
ALTER TABLE animals
ADD COLUMN class varchar(100);

UPDATE animals SET class = 'Aves';
```

2. Add two more columns to the animals table called phylum and kingdom. Both should hold strings of up to 100 characters.

Update all the rows in the table so that phylum holds the value Chordata and kingdom holds Animalia for all the rows in the table.


```sql
ALTER TABLE animals
ADD COLUMN phylum varchar(100),
ADD COLUMN kingdom varchar(100);

UPDATE animals
SET phylum = 'Chordata', kingdom = 'Animalia';
```


3. Add a column to the countries table called continent to hold strings of up to 50 characters.

Update all the rows in the table so France and Germany have a value of Europe for this column, Japan has a value of Asia and the USA has a value of North America.


```sql
ALTER TABLE countries
ADD COLUMN continent varchar(50);

UPDATE countries
SET continent = 'North America'
WHERE name = 'USA';

UPDATE countries
SET continent = 'Asia'
WHERE name = 'Japan';

UPDATE countries
SET continent = 'Europe'
WHERE name = 'France' OR name = 'Germany';

```

4. In the celebrities table, update the Elvis row so that the value in the deceased column is true. Then change the column so that it no longer allows NULL values.

```sql
UPDATE celebrities
SET deceased = true
WHERE first_name = 'Elvis';

ALTER TABLE celebrities
ALTER COLUMN deceased
SET NOT NULL;
```


5. Remove Tom Cruise from the celebrities table.

```sql
DELETE FROM celebrities
WHERE first_name = 'Tom'
AND last_name = 'Cruise';
```

6. Change the name of the celebrities table to singers, and remove anyone who isn't a singer.

```sql
ALTER TABLE celebrities
RENAME TO singers;

SELECT * FROM singers
WHERE occupation
NOT LIKE '%Singer%';

DELETE FROM singers
WHERE occupation
NOT LIKE '%Singer%';
```


7. Remove all the rows from the countries table.

```sql
DELETE FROM countries;
```


8. Connect to the ls_burger database. Change the drink on James Bergman's order from a Cola to a Lemonade.


```sql
UPDATE orders
SET drink = 'Lemonade'
WHERE id = 1;
```


9. Add Fries to Aaron Muller's order. Make sure to add the cost ($0.99) to the appropriate field and add 3 loyalty points to the current total.


```sql
UPDATE orders
SET side = 'Fries',
side_cost= 0.99,
customer_loyalty_points = 13
WHERE id = 4;
```


10. The cost of Fries has increased to $1.20. Update the data in the table to reflect this.


```sql
UPDATE orders
SET side_cost = 1.20
WHERE side = 'Fries';
```

#
#