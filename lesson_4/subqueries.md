# Subqueries

In some situations, a subquery can be more efficient that using a join.

Subqueries essentially issue a `SELECT` query, and then use the results of that `SELECT` query as a condition in another `SELECT` query. We are nesting queries here. 

## Subquery Expressions

PostgreSQL provides expressions that can be used specifically with subqueries such as:
  - `IN`
  - `NOT IN`
  - `ANY`
  - `SOME`
  - `ALL`

These essentially compare values to the result of a subquery. 

Lets write this as a subquery:

```sql
SELECT u.full_name
       FROM users u
       LEFT JOIN checkouts c ON u.id = c.user_id
       WHERE c.user_id IS NULL;
```
becomes...

```sql
SELECT u.full name FROM users u
    WHERE u.id NOT IN (
        SELECT c.user_id FROM checkouts c
    );
```    

##

### Subqueries are nested queries
  - use nested query to generate a set of one or more values, then use those values as part of an outer query (usually as part of a condition)

#

### Example using titles of books

```sql
SELECT title FROM books WHERE author_id = 
  (SELECT id FROM authors WHERE name = 'William Gibson');
```

1. The nested query, when executed, returns the `authors.id` value that satisfies the condition (`name = 'William Gibson`).
2. The subquery returns the integer `1`. 
3. The outer query, then uses this value to complete its operation.
  - `SELECT title FROM books WHERE author_id = 1;`

**In the above example, we were able to use = in the WHERE condition in this way because the nested query returned a single value. Much of the time when using subqueries, the nested query will return more than one value; this is where subquery expressions become useful.**

#

## Subquery Expressions

Special set of operators for use specifically with subqueries, most commonly within a conditional subquery. 

### `EXISTS`

Checks whether *any* rows at all are returned by the nested query. 
  - if at least one row returned, evaluates to true, otherwise false. 

```sql
SELECT 1 WHERE EXISTS
  (SELECT id FROM books
    WHERE isbn = '9780316005388');

--- returns

?column?
-----------
        1
(1 row)
```
This returns `1` if there is a row in the `books` table with the corresponding `isbn` and no rows otherwise. 

Useful in **correlated subqueries** (not efficient).

##

### `IN`

Compares an evaluated expression to every row in the subquery result. 
  - If a row equal to the evaluated expression is found, then the result of `IN` is true, otherwise false.

```sql
SELECT name FROM authors WHERE id IN
  (SELECT author_id FROM books
    WHERE title LIKE 'The%');

--- returns

  name
----------
Iain M. Banks
Philip K. Dick
(2 rows)
```

In this case, the nested query returns a list of `author_id` values `(2, 3)` from the `books` table where the title of the books for that row starts with `'The'`. 

The outer query returns the `name` value from any row of the `authors` table where the `id` for that row is in the results from the nested query. 

##

### `NOT IN`

Similar to `IN` except result of `NOT IN` is true if an equal row is NOT found, and false otherwise. 

```sql
SELECT name FROM authors WHERE id NOT IN
  (SELECT author_id FROM books
    WHERE title LIKE 'The%');

--- returns

  name
---------
William Gibson
(1 row)
```

##

### `ANY` / `SOME`

`ANY` and `SOME` are synonyms and can be used interchangeably. 

These expressions are used along with an operator (`=`, `<`, `>`, etc). 

The result of `ANY` or `SOME` is true if *any* true result is obtained when the expression to the left of the operator is evaluated using that operator against the results of the nested query. 

```sql
SELECT name FROM authors WHERE length(name) > ANY
  (SELECT length(title) FROM books
    WHERE title LIKE 'The%');

--- returns

 name
----------------
 William Gibson
 Philip K. Dick
(2 rows)
```

The nested query will return a list of lengths (integers) of titles that start with 'The'. 

The outer query then returns the name of any author where the length of name is greater than any of the results from the nested query. 

Two of the author names are 14 characters in length and so satisfy the condition since they are greater in length than at least one of the title lengths (13) from the results of the nested query.

Note: when the = operator is used with ANY / SOME, this is equivalent to IN.

##

### `ALL`

`ALL` is used alongside an operator.

The result is true if *all* the results are true when the expression to the left of the operator is evaluated using that operator against the results of the nested query. 

```sql
SELECT name FROM authors WHERE length(name) > ALL
  (SELECT length(title) FROM books
    WHERE title LIKE 'The%');

--- returns
 name
------
(0 rows)
```

NOTE: when the `<>` or `!=` operator is used with `ALL` this is equivalent to `NOT IN`. 

##

## When to use subqueries

Personal preference until looking at optimization metrics. In some situations, one may be more readable, more logical, or simpler.

For example, if you want to return data from one table conditional on data from another table, but don't need to return any data from the second table, a subquery may make more logical sense and aid readability. 

If you need to return data from both tables, use a join. 

##
