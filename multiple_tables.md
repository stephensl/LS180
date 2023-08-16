# Working with Multiple Tables

The process of normalization includes reducing possibilities for the duplication of data and improvements to integrity of data through splitting data into multiple tables, and defining relationships between them.

Decisions about structuring and distributing data across multiple tables is considered part of database design. 

## Database design

Defining entities to represent different data and designing relationships between those entities. 

**Entities**

  - Represent real world objects or a set of data we want to model in the database. 
    - may be identified as major nouns of the system we are modeling. 
      - data for a single entity may be stored in more than one table.

### Example entities for Book application

  - `users` table
    - user is specific entity within our app. 

  - `books`

  - `checkouts`
    - exists between users and books
 
  - `reviews`

  - `addresses`
    - not used for every user interaction
    - stored in separate table

  We can then plan tables for each entity:

  - `users`
    - id
    - full name
    - enabled
    - last_login

  - `books`
    - id
    - title
    - author
    - published date
    - isbn

  - `checkouts`
    - id
    - user_id
    - checkout date
    - return date

  - `addresses`
    - user id 
    - street
    - city 
    - state

  - `reviews`
    - id
    - book id
    - reviewer name
    - content 
    - rating
    - published date

#
#


### Defining relationships 

**Entity Relationship Diagram (ERD)** 

![ERD](https://d186loudes4jlv.cloudfront.net/sql/images/table_relationships/simple-erd-fixed.png)

Models relationships between entities.


## Implementing relationships in table schema

**Keys**

### Primary Keys

Primary key is a unique identifier for a row of data. 

  - Constraints `NOT NULL` and `UNIQUE`

```sql
ALTER TABLE users ADD PRIMARY KEY (id);
```

While any column in the table can have constraints `NOT NULL` and `UNIQUE`, table can have *only one* Primary Key. 

Primary key is half of the relationship, also need the Primary Key's partner, *Foreign Key*.


### Foreign Keys

Allow us to associate a row in one table to a row in another table.
  - setting a column in one table as a Foreign Key and having that column reference another table's Primary Key column. 

Achieved by using `REFERENCES` keyword.

```sql
FOREIGN KEY (fk_col_name)
REFERENCES target_table_name (pk_col_name)
```

Simple Example: 

![Colors and Shapes](https://d186loudes4jlv.cloudfront.net/sql/images/table_relationships/joins-explanation-separate-tables.png)

  - Red row of `colors` table associated with square and star rows of `shapes` table. 
  - Blue row associated with triangle row 
  - Green row associated with circle row

  Setting up reference to ensure **referential integrity** of a relationship.
    - assurance that a column value within a record must reference an existing value.
      - Error thrown if try to add value to Foreign Key column of a table if Primary Key column of the table it is referencing does not already contain that value. 


#### Formal relationship descriptions

  1. A user can have ONE address. An address has only ONE user. 
  2. A review can be about ONE book. A book may have MANY reviews.
  3. A user can have MANY books checked out ot returned. A book can be checked out by MANY users. 

Entity relationships may be classified as: 
  - one-to-one
  - one-to-many
  - many-to-many

#
#

### One-to-One

When particular entity instance exists in one table, it can have only one associated entity instance in another table. 

  - user can have only one address, and address belongs to only one user. 

  Example: address table.

  ```sql
  CREATE TABLE addresses (
    user_id int, -- both primary and foreign key
    street varchar(30) NOT NULL,
    city varchar(30) NOT NULL, 
    state varchar(30) NOT NULL,
    PRIMARY KEY (user_id)
    FOREIGN KEY (user_id)
      REFERENCES users (id)
      ON DELETE CASCADE
  );
  ```
This will create `addresses` table and create relationships between it and the `users` table. 
  - The `PRIMARY KEY` and `FOREIGN KEY` clauses make the `user_id` both the Primary key of the `addresses` table and the Foreign key that references the `users` table. 


```sql
INSERT INTO addresses
         (user_id, street, city, state)
  VALUES (1, '1 Market Street', 'San Francisco', 'CA'),
         (2, '2 Elm Street', 'San Francisco', 'CA'),
         (3, '3 Main Street', 'Boston', 'MA');
```

The `user_id` column uses values that exist in the `id` column of the `users` table in order to connect the tables through the foreign key constraint created above. 

#
#
#

## Referential Integrity

Table relationships must always be consistent.

Constraints defined for `addresses` table enforces the one-to-one relationship we want between it and the `users` table
  - user can have only one address 
  - address must have one, and only one user. 


If we try to add another address for a user who already has one, will get error.

```sql 
INSERT INTO addresses (user_id, street, city, state)
  VALUES (1, '2 Park Road', 'San Francisco', 'CA');

--- triggers
ERROR:  duplicate key value violates unique constraint "addresses_pkey"
DETAIL:  Key (user_id)=(1) already exists.
```

If we try to add an address for a user who does not exist...

```sql
INSERT INTO addresses (user_id, street, city, state)
       VALUES (7, '11 Station Road', 'Portland', 'OR');

---triggers

ERROR:  insert or update on table "addresses" violates foreign key constraint "addresses_user_id_fkey"
DETAIL:  Key (user_id)=(7) is not present in table "users".
```

This error occurs because the value `7` does not exist in the `id` column of `users` table.

We can add a user without an address, but not an address without a user. 
  - Due to **modality** of relationship between the two entities.


#
#

The `ON DELETE` clause

if row being referenced is deleted, the row referencing it is also deleted. 
  - other options are `SET NULL` or `SET DEFAULT`


#
#

### One-to-Many

Used if an entity instance in one of the tables can be associated with multiple entity instances in the other table. 

The opposite relationship does not exist, as each entity in the second table can only be associated with one entity instance in the first table. 

EXAMPLE: 

  - A review belongs to only one book. A book has many reviews. 

```sql
CREATE TABLE books (
  id serial, 
  title varchar(100) NOT NULL,
  author varchar(100) NOT NULL,
  published_date timestamp NOT NULL,
  isbn char(12),
  PRIMARY KEY (id),
  UNIQUE (isbn)
);
```
*one-to-many: Book has many reviews*

```sql
CREATE TABLE reviews (
  id serial, 
  book_id integer NOT NULL, 
  reviewer_name varchar(255),
  content varchar(255),
  rating integer,
  published_date timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN_KEY (book_id)
    REFERENCES books(id)
    ON DELETE CASCADE
);
```


##
##

### Many-to-Many 

If for one entity instance there may be multiple records in the other table, and vice versa. 

EXAMPLE: a user can check out many books. A book can be checked out by many users (over time). 


- Not way to implement many-to-many relationships between two tables directly. instead we break apart into two one-to-many relationships using third, cross reference, table. (Join Table)
  - This table holds the relationship between the two entities by:
    - having two `FOREIGN KEYS`
      - each references the `PRIMARY KEY` of one of the tables for which we want to create the relationship. 

  - In books and users table, need cross reference table called `checkouts`.

  ![cross reference](https://d186loudes4jlv.cloudfront.net/sql/images/table_relationships/checkouts-table-references.png)

    - `user_id` column in `checkouts` references the `id` column in `users`.
    - `book_id` column in `checkouts` references the `id` column in `books`. 

    - each row of the `checkouts` table uses these two Foreign Keys to create an association between rows of users and books. 

```sql
CREATE TABLE checkouts (
  id serial,
  user_id int NOT NULL,
  book_id int NOT NULL,
  checkout_date timestamp,
  return_date timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id)
                        ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES books(id)
                        ON DELETE CASCADE
);
```

The columns `checkout_date` and `return_date` are not necessary for the relationship between `users` and `books` tables, they can provide additional context to the relationship. 
  - these do not pertain specifically to users or specifically to books, but to the association between a user and a book. 


```sql
INSERT INTO checkouts
  (id, user_id, book_id, checkout_date, return_date)
  VALUES
    (1, 1, 1, '2017-10-15 14:43:18.095143-07',
              NULL),
    (2, 1, 2, '2017-10-05 16:22:44.593188-07',
              '2017-10-13 13:0:12.673382-05'),
    (3, 2, 2, '2017-10-15 11:11:24.994973-07',
              '2017-10-22 17:47:10.407569-07'),
    (4, 5, 3, '2017-10-15 09:27:07.215217-07',
              NULL);
```

![many to many](https://d186loudes4jlv.cloudfront.net/sql/images/table_relationships/many-to-many.png)

We can perhaps think of a many-to-many relationship as combining two one-to-many relationships; in this case between checkouts and users, and between checkouts and books.


### Relationships

- one-to-one 	
  - A User has ONE address
- one-to-many 	
  - A Book has MANY reviews
- many-to-many 	
  - A user has MANY books and a book has MANY users

#
#
#


## Exercises:

