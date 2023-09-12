# Using Foreign Keys

## May refer to two different, but related things:

1. Foreign Key Column
  - column that represents relationship between two rows, by pointing to a specific row in another table using its *primary key*. 
  - stores reference to primary key column elsewhere in the database.

2. Foreign Key Constraint
  - constraint that enforces rules about what values are permitted in these foreign key relationships. 


### Creating Foreign Key Columns

Create a column of the same type as the primary key column it will point to. 

#### Creating Foreign Key Constraints

Two syntax options...

1. Add `REFERENCES` clause to description of a column in `CREATE TABLE` statement.

```sql
CREATE TABLE orders (
  id serial PRIMARY KEY, 
  product_id integer REFERENCES products (id),
  quantity integer NOT NULL
);
```


2. Add foreign key constraint separately to existing table

```sql
ALTER TABLE orders ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id);
```


**Benefit of Referential Integrity**

Using foreign key constraints preserves referential integrity of the data in the database. 

Ensures every value in a foreign key column exists in the primary key column of the table being referenced. 

If attempt to insert row that violate the constraint, will raise error. 




### FOREIGN KEY constraints DO NOT prevent NULL values from being stored in the column

Often necessary to use `NOT NULL` and a foreign key constraint together. 

