# SQL Language

SQL is language used to manipulate the structure and values of datasets stored in relational database.

SQL is a **special purpose language**
  - used for specific purpose: interacting with relational database
    - contrast with general purpose language like Ruby, JavaScript

SQL is predominantly **declarative** language.
  - describes what needs to be done, but not detail of *how* to accomplish it. 

## Sub-languages
  - Data Definition (DDL)
    - relation (table) structure and rules
    - describes schema/structure of the table
    - rules define constraints on the data that can be stored in the table
    - `CREATE`, `DROP`, `ALTER`, `ADD COLUMN`

  - Data Manipulation (DML)
    - controls values stored within relations
    - allows query, insert, update, delete data
    - `SELECT`, `INSERT`, `UPDATE`, `DELETE`

  - Data Control (DCL)
    - controls access level within database
    - provide or revoke privileges to a user or role 
    - crucial for managing security, data integrity
    - `GRANT`, `REVOKE`

##
##

## Syntax

SQL code is comprised of **statements**, terminated by `;`
  - can evaluate arbitrary SQL expressions typing them after `SELECT`
```sql
SELECT 1;

<!-- returns -->
  
?column?
--------
      1
(1 row)
```

**Expressions** using operators and functions.

```sql
SELECT 1 + 1;

<!-- returns -->

?column?
--------
      2
(1 row)
```

```sql
SELECT round(1.5678);

<!-- returns -->

round
-----
    2
(1 row)
```

#
#

## Practice Problems

1. What kind of programming language is SQL?

SQL is a *special purpose language* that is used for the specific purpose of interacting with data in a relational database. SQL is primarily a *declarative* language where the desired action is described, but not particular details of *how* the action is implemented. 

2. Three sub-languages of SQL?

Data Definition:
  - defining the structure and rules governing the database and its relations. 
  - utilizes `CREATE`, `ALTER`, `DROP`, `ADD COLUMN`, etc. that deal with the way a table is set up and the constraints surrounding what kinds of data can be stored in the database.

Data Manipulation
  - relates to manipulation of data stored within the database and interactions with particular data.
  - utilized `SELECT`, `UPDATE`, `INSERT`, `DELETE` to query, modify, or remove data.

Data Control
  - relates to privileges and access to the database and data stored within
  - adds measures for security and assists in data integrity
  - utilizes `GRANT`, `REVOKE` to allow or disable access for users/groups

3. Write the following values as quoted string values that could be used in a SQL query.
```
canoe
a long road
weren't
"No way!"
```

- `'canoe'`
- `'a long road'`
- `'weren''t'`
- `'"No way!"'`

4. What operator used to concatenate strings?

`||` operator

`SELECT 'Hello' || '' || 'World' AS concatenated_string;`

5. What function returns a lowercased version of a string?

`lower`

```sql
SELECT lower('ABC');

<!--  returns -->

lower
-----
'abc'
(1 row)
```

6. How does `psql` console display true and false values?

`t` and `f`

```sql
SELECT 'a' = 'a';

<!-- returns --> 

?column? 
----------
 t
(1 row)
```

7. The surface area of a sphere is calculated using the formula A = 4π r2, where A is the surface area and r is the radius of the sphere.

Use SQL to compute the surface area of a sphere with a radius of 26.3cm, truncated to return an integer.

```sql
SELECT trunc(4 * pi() * power(26.3, 2))

<!-- returns -->

trunc
-----
8692
(1 row)
```

#
#