# More on `SELECT`

- Further filtering
- Using functions to process data
- Grouping data based on criteria

#

## Further Filtering through `LIMIT`, `OFFSET`, and `DISTINCT`

#

### `LIMIT` and `OFFSET`

We often don't want to return all of the results that match the conditions of our statement when working with larger data sets. 
  - We will commonly only want to display one portion of the data at a time. 

**pagination**
  - Displaying portions of data as separate pages
    - common user interface pattern in web apps. 
  - Example:
    - Displaying 10 results on first page, and next 10 results on next, etc. 

**EXAMPLE**

Requirement: display one user at a time 

  ```sql
  SELECT * FROM users LIMIT 1;
  ```
  Setting limit to 1 lets us select a single row, the first row, from our table. 


If we want to return the second row instead, we need to skip the first when querying data.

Use `OFFSET` clause. This will skip the first N rows. 

```sql
SELECT * FROM users LIMIT 1 OFFSET 1;
```
  We still just return 1 row based on the limit, but offsetting the query by 1, returns next row (2)


If we want to return more than one result per page, adjust limit and offset accordingly.

```sql
SELECT * FROM users LIMIT 10 OFFSET 10;
```

This would be used for page 2. Displaying the next 10 users (11-20)

##
##

### `DISTINCT` clause

If we had duplicate full_names in our table, we can use `DISTINCT` to only return unique values.

```sql
SELECT DISTINCT full_name FROM users;
```

Can be used in conjunction with SQL functions..

```sql
SELECT count(full_name) FROM users;
```
Returns: `5`

vs

```sql
SELECT DISTINCT count(full_name) FROM users;
```
Returns: `3`

*This would tell us, we have two duplicate values in full_name.*

#
#
#

## Functions

Generally grouped into types, a few of most common types of functions are:
  1. String
  2. Date/Time
  3. Aggregate


### String Functions

- `length`
```sql
SELECT length(full_name) FROM users;
```
  - this would return the length of every user's name. 
    - may also be used in WHERE clause to filter based on name length.


- `trim`
```sql
SELECT trim(leading ' ' from full_name) FROM users;
```
  - without `leading` or `trailing` keyword, trims both by default.

##
##

##

## Date/Time Functions

Most take a time or timestamp inputs

- `date_part`
```sql
SELECT full_name, date_part('year', last_login) FROM users;
```
  - this would allow us to see each user's name along with year of last_login.
    - useful when having some detail of date/time data is not necessary (minutes, seconds, etc.)


- `age`
```sql
SELECT full_name, age(last_login) FROM users;
```
  - the `age` function, when passed a timestamp, calculates elapsed time between timestamp and current time. 
    - this example shows how long since each user's last login


#
#
#

## Aggregate Functions

These functions perform aggregation, computing a single result from a set of input values. 


- `count`
```sql
SELECT count(id) FROM users;
```
  - returns number of values in the column passed in as an argument. 


- `sum`
```sql
SELECT sum(id) FROM users;
```

  - sums numeric type for all of the selected rows, returns total. 


- `min`
```sql
SELECT min(last_login) FROM users;
```

  - returns lowest value in a column for all of the selected rows. 
    - can be used with numerics, date/time, and strings


- `max`
  - same as above, but max values


- `avg`
```sql
SELECT avg(id) FROM users;
```

  - returns average (mean) of numeric type values for all selected rows.


**Aggregate functions are most useful when grouping table rows together using `GROUP BY`**

#
#
#

## `GROUP BY`

```sql
SELECT enabled, count(id) FROM users GROUP BY enabled;
```

  - this would show the count of how many users are not enabled, and how many are enabled. 
```
 enabled | count
---------+-------
 f       |     1
 t       |     4
(2 rows)
```

*When using aggregate functions, is you include columns in the column list alongside the function, those columns must be included in a `GROUP BY` clause.*

This example would throw an error:
```sql
SELECT enabled, full_name, count(id)
  FROM users
  GROUP BY enabled;
```
```
ERROR:  column "users.full_name" must appear in the GROUP BY clause or be used in an aggregate function
```

#
#
#


## Exercises

1. Make sure you are connected to the encyclopedia database. Write a query to retrieve the first row of data from the countries table.
```sql
SELECT * FROM countries LIMIT 1;
```

2. Write a query to retrieve the name of the country with the largest population.
```sql
SELECT name FROM countries
ORDER BY population DESC
LIMIT 1;
```


3. Write a query to retrieve the name of the country with the second largest population.
```sql
SELECT name FROM countries
ORDER BY population DESC
LIMIT 1 OFFSET 1;
```

4. Write a query to retrieve all of the unique values from the binomial_name column of the animals table.
```sql
SELECT DISTINCT binomial_name
  FROM animals;

```

5. Write a query to return the longest binomial name from the animals table.
```sql
SELECT binomial_name
FROM animals
ORDER BY length(binomial_name) DESC
LIMIT 1;

```

6. Write a query to return the first name of any celebrity born in 1958.
```sql
SELECT first_name
FROM celebrities
WHERE date_part('year', date_of_birth) = 1958;
```

7. Write a query to return the highest maximum age from the animals table.
```sql
SELECT max(max_age_years)
FROM animals;
```

8. Write a query to return the average maximum weight from the animals table.
```sql
SELECT avg(max_weight_kg)
FROM animals;
```

9. Write a query to return the number of rows in the countries table.
```sql
SELECT count(id) FROM countries;
```

10. Write a query to return the total population of all the countries in the countries table.
```sql
SELECT sum(population)
FROM countries;
```

11. Write a query to return each unique conservation status code alongside the number of animals that have that code.
```sql
SELECT conservation_status, count(id)
FROM animals
GROUP BY conservation_status;
```

12. Connect to the ls_burger database. Write a query that returns the average burger cost for all orders that include fries.
```sql
SELECT avg(burger_cost)
FROM orders
WHERE side = 'Fries';
```

13. Write a query that returns the cost of the cheapest side ordered.
```sql
SELECT min(side_cost)
FROM orders
WHERE side IS NOT NULL;
```

14. Write a query that returns the number of orders that include Fries and the number of orders that include Onion Rings.
```sql
SELECT side, count(id)
FROM orders
WHERE side = 'Fries'
OR side = 'Onion Rings'
GROUP BY side;
```

#
#
#
#