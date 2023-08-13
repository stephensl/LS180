# Select Queries

Querying data forms the *Read* part of CRUD operations. 
  - generally most common operation in database-backed applications. 

## Syntax

```sql
SELECT column_name,...
  FROM table_name
  WHERE condition;
```
*Multiple column names may be specified*. 

#
#

Identifiers and Keywords
  - Example: 

  ```sql
  SELECT enabled, full_name FROM users;
  ```

    - Identifiers:
      - `enabled`
      - `full_name`
      - `users`

    - Keywords
      - `SELECT`
      - `FROM`

If not a keyword, treated as identifier. 
  - may use keywords as identifiers if double quoted. ex. `"year"`

#
#

## ORDER BY

Return sorted data by adding `ORDER BY column_name` clause to the query. 

```sql
SELECT column_name, ...
  FROM table_name
  WHERE condition
  ORDER BY column_name;
```

Can use `ASC` or `DESC` to specify ascending or descending order. 

```sql
SELECT full_name, enabled FROM users
  ORDER BY enabled DESC;
```

##

### ORDER BY multiple columns

```sql
SELECT full_name, enabled FROM users
ORDER BY enabled DESC, id DESC;
```

#
#
#

## Operators

Used as part of an expression in a `WHERE` clause.

  ### Common types:

  1. Comparison
  2. Logical
  3. String matching 

#

### Comparison Operators

```sql
SELECT full_name, enabled, last_login
  FROM users
  WHERE id >= 2;
```

#
#

### NULL values

- Represents absence of a value or unknown value

**MUST USE `IS NULL` or `IS NOT NULL` comparison predicates rather than `=`**

```sql
SELECT * FROM my_table WHERE my_column IS NULL;
```

#
#
#

### Logical Operators

  1. `AND`
  2. `OR`
  3. `NOT`

Allow combining of multiple conditions 

```sql
SELECT * FROM users
  WHERE full_name = 'Harry Potter'
    OR enabled = 'false';
```

```sql
SELECT * FROM users
  WHERE full_name = 'Harry Potter'
    AND enabled = 'false';
```


#
#
#

### String Matching Operators 

Can be used to match substrings, often using `LIKE` operator. 

```sql
SELECT * FROM users WHERE full_name LIKE '%Smith';
```

**The `%` says, "match any number of characters, followed by 'Smith'"**

`LIKE` is case sensitive. Use `ILIKE` for case insensitive selection. 

#
#


## Exercises

1. Make sure you are connected to the encyclopedia database. Write a query to retrieve the population of the USA.

```sql
SELECT population
  FROM countries
  WHERE name = 'USA';
```

2. Write a query to return the population and the capital (with the columns in that order) of all the countries in the table.

```sql
SELECT population, capital 
FROM countries;
```

3. Write a query to return the names of all the countries ordered alphabetically.
```sql
SELECT name
  FROM countries
  ORDER BY name;
```

4. Write a query to return the names and the capitals of all the countries in order of population, from lowest to highest.
```sql
SELECT name, capital 
  FROM countries
  ORDER BY population;
```


5. Write a query to return the same information as the previous query, but ordered from highest to lowest.
```sql
SELECT name, capital 
  FROM countries
  ORDER BY population DESC;
```

6. Write a query on the animals table, using ORDER BY, that will return the following output:

```sql 
       name       |      binomial_name       | max_weight_kg | max_age_years
------------------+--------------------------+---------------+---------------
 Peregrine Falcon | Falco Peregrinus         |        1.5000 |            15
 Pigeon           | Columbidae Columbiformes |        2.0000 |            15
 Dove             | Columbidae Columbiformes |        2.0000 |            15
 Golden Eagle     | Aquila Chrysaetos        |        6.3500 |            24
 Kakapo           | Strigops habroptila      |        4.0000 |            60
(5 rows)
```
Use only the columns that can be seen in the above output for ordering purposes.

```sql
SELECT name, binomial_name, max_weight_kg, max_age_years
  FROM animals
  SORT BY max_age_years, max_weight_kg, name DESC;
```
7. Write a query that returns the names of all the countries with a population greater than 70 million.
```sql
SELECT name FROM countries 
WHERE population > 70000000;
```

8. Write a query that returns the names of all the countries with a population greater than 70 million but less than 200 million.
```sql

```

9. Write a query that will return the first name and last name of all entries in the celebrities table where the value of the deceased column is not true.
```sql

```

10. Write a query that will return the first and last names of all the celebrities who sing.
```sql

```

11. Write a query that will return the first and last names of all the celebrities who act.
```sql

```
12. Write a query that will return the first and last names of all the celebrities who both sing and act.
```sql

```
13. Connect to the ls_burger database. Write a query that lists all of the burgers that have been ordered, from cheapest to most expensive, where the cost of the burger is less than $5.00.
```sql

```

14. Write a query to return the customer name and email address and loyalty points from any order worth 20 or more loyalty points. List the results from the highest number of points to the lowest.
```sql

```

15. Write a query that returns all the burgers ordered by Natasha O'Shea.

```sql

```
16. Write a query that returns the customer name from any order which does not include a drink item.
```sql

```
17. Write a query that returns the three meal items for any order which does not include fries.
```sql

```

18. Write a query that returns the three meal items for any order that includes both a side and a drink.
