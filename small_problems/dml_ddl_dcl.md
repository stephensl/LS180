1. SQL consists of 3 different sub languages. For example, one of these sub languages is called the Data Control Language (DCL) component of SQL. It is used to control access to a database; it is responsible for defining the rights and roles granted to individual users. Common SQL DCL statements include: `GRANT` and `REVOKE`

Name and define the remaining 2 sub languages, and give at least 2 examples of each.


Data Definition Language (create, modify, delete databases and tables)
  - defines the overall schema/structure of the database and relations within it. 
  - defines the rules and constraints that determine what kinds of data can be stored. 
  - ensures data is organized and constrained according to requirements of application or system
  - `CREATE`, `ALTER`, `DROP`, `ADD COLUMN`

Data Manipulation Language (query, insert, update, delete data)
  - related to accessing and modifying the data stored in the database
  - allows users to query, insert, update, modify data
  - `SELECT`, `UPDATE`, `INSERT`, `DELETE`

##

2. Does the following statement use the Data Definition Language (DDL) or the Data Manipulation Language (DML) component of SQL?

```sql
SELECT column_name FROM my_table;
```

This is an example of Data Manipulation Language as we are interacting with the actual data itself, rather than the structure or rules governing the database or relations. Data manipulation includes querying (reading) particular data stored in the database. In this case we are querying data residing in a particular column `column_name` from the relation `my_table`.

##

3. Does the following statement use the DDL or DML component of SQL?

```sql
CREATE TABLE things (
  id serial PRIMARY KEY,
  item text NOT NULL UNIQUE,
  material text NOT NULL
);
```

This example uses the Data Definition Language component of SQL as we are working with the schema (structure) of the database. In this case we are creating a table and defining the schema and rules governing the data that will be stored within it. 

##

4. Does the following statement use the DDL or DML component of SQL?

```sql
ALTER TABLE things
DROP CONSTRAINT things_item_key;
```

This example uses the DDL component of SQL as it is altering the schema of the table and rules governing the data that exist within it. We are altering the table `things` by removing a constraint previously defined. We are not manipulating the actual data itself, but the rules governing the data. 

##

5. Does the following statement use the DDL or DML component of SQL?

```sql
INSERT INTO things VALUES (3, 'Scissors', 'Metal')
```

This example uses the DML component of SQL as we are working with the actual data being stored in a table. In this case we are inserting a new row of data into the `things` table. Data manipulation language allows for the reading, creation, modification, and removal of particular data in the database. 

##

6. Does the following statement use the DDL or DML component of SQL?

```sql
UPDATE things
SET material = 'plastic'
WHERE item = 'Cup';
```

This example uses the DML component of SQL as we are modifying particular data within a relation. We are updating the `things` table, and more specifically the `material` column of the `things` table, by changing values stored  in the material column to `'plastic'` in places where the row currently stores the string `'Cup'` in its `item` column. The `UPDATE` command allows for modification of existing data, and thus, is part of the DML component of SQL. 

##

7. Does the following statement use the DDL, DML, or DCL component of SQL?

`\d things`

This example is a `psql` meta command, and is not part of any SQL sub language.


##

8. Does the following statement use the DDL or DML component of SQL?

```sql
DELETE FROM things WHERE item = 'Cup';
```

This example uses the DML component of SQL as we are manipulating particular data within the relation. We are removing rows in the `things` table that store the value `'Cup'` in its `item` column. Because we are manipulating the actual data, rather than the structure of the table itself, this is within the realm of DML. 

##

9. Does the following statement use the DDL or DML component of SQL?

```sql
DROP DATABASE xyzzy;
```

This example uses the DDL component of SQL as we are making a change to the actual structure of the database, rather than particular data within it. We are removing the database `xyzzy`. Its main purpose is to operate on data definitions; the deletion of data is merely a side effect. 

##

10. Does the following statement use the DDL or DML component of SQL?

```sql
CREATE SEQUENCE part_number_sequence;
```

DDL as we are modifying the characteristics/attributes of the database by adding a sequence object to the database structure. All CREATE statements are generally thought of as DDL.

##
##
##