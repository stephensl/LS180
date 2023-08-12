# SQL Basics Tutorial 

## Select All
  - used to select all columns from a particular table

`SELECT * FROM orders;`

  - `SELECT` is the keyword identifying type of statement issued. 
    - in this case, we are retrieving data

  - `*` is a wildcard character
    - acts as identifier for all columns in given table

  - `FROM` is a keyword 
    - used as a clause within `SELECT` statement to identify which table

  - `orders` name of the table from which data is retrieved

### Output
```
ls_burger=# SELECT * FROM orders;
 id |  customer_name  |         burger          |    side     |      drink      
----+-----------------+-------------------------+-------------+-----------------
  1 | Todd Perez      | LS Burger               | Fries       | Lemonade
  2 | Florence Jordan | LS Cheeseburger         | Fries       | Chocolate Shake
  3 | Robin Barnes    | LS Burger               | Onion Rings | Vanilla Shake
  4 | Joyce Silva     | LS Double Deluxe Burger | Fries       | Chocolate Shake
  5 | Joyce Silva     | LS Chicken Burger       | Onion Rings | Cola
(5 rows)
```

##
##
##

## Selecting Columns
  - retrieve only the data in a particular column

`SELECT side FROM orders;`

### Output

```
ls_burger=# SELECT side FROM orders;
    side     
-------------
 Fries
 Fries
 Onion Rings
 Fries
 Onion Rings
(5 rows)
```

## Selecting Multiple Columns
  - use comma separated column names

  `SELECT drink, side FROM orders;`

### Output

```
ls_burger=# SELECT drink, side FROM orders;
    drink      |    side     
-----------------+-------------
Lemonade        | Fries
Chocolate Shake | Fries
Vanilla Shake   | Onion Rings
Chocolate Shake | Fries
Cola            | Onion Rings
(5 rows)
```

##
##
##

## Selecting Rows
  - if we want to return data from particular row, can use `WHERE` clause 

`SELECT * FROM orders WHERE id = 1;`

```
ls_burger=# SELECT * FROM orders WHERE id = 1;
 id | customer_name |  burger   | side  |  drink   
----+---------------+-----------+-------+----------
  1 | Todd Perez    | LS Burger | Fries | Lemonade
(1 row)
```

##
##
##

## Selecting Columns and Rows

`SELECT customer_name FROM orders WHERE side = 'Fries';`  
  - notice use of single `' '` around `'Fries'`. 
    - double quotes would reference a column

```
ls_burger=# SELECT customer_name FROM orders WHERE side = 'Fries';
  customer_name  
-----------------
 Todd Perez
 Florence Jordan
 Joyce Silva
(3 rows)
```


###
###

## Exercises

1. Write a query that returns all of the customer names from the orders table.

`SELECT customer_name FROM orders;`

2. Write a query that returns all of the orders that include a Chocolate Shake.

`SELECT * FROM orders WHERE drink = 'Chocolate Shake'`

3. Write a query that returns the burger, side, and drink for the order with an id of 2.

`SELECT burger, side, drink FROM orders WHERE id = 2;`

4. Write a query that returns the name of anyone who ordered Onion Rings.

`SELECT customer_name FROM orders WHERE side = 'Onion Rings';`