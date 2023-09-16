# Indexes

An index is a mechanism used by the SQL engines to speed up queries. 
  - indexed data is stored in table-like structure that can be quickly searched using particular search algorithms. 
  - results of search provide link back to records to which indexed data belongs.
  - allows engine to more efficiently locate column values.

In the same way that an index in a book gives you direct page number to access data, indexes in database provide a streamlined access point to the data. 

Example:


| Book Title           | Author         |
|----------------------|----------------|
| Neuromancer          | William Gibson |
| Consider Phlebas     | Iain M. Banks  |
| Idoru                | William Gibson |
| The State of the Art | Iain M. Banks  |
| The Simulacra        | Philip K. Dick |
| Pattern Recognition  | William Gibson |
| A Scanner Darkly     | Philip K. Dick |

If we wanted to query all book titles for books by particular author.. PostgreSQL would need to go through table row by row to find each row where author name matches search condition. 

If we indexed `author` column, PostgreSQL would only need to search index for name that matched the search condition in order to identify the relevant rows. 

#

## When to use an index

1. Best used in cases where sequential reading is inadequate.
  - columns that help in mapping relationships (Foreign Key columns) or columns frequently used as part of `ORDER BY` clause are good candidates for indexing.

2. Best used in tables and/or columns where data will be read much more frequently than it is created or updated. 

#

### Types of Index

Different types of index use different data structures and search algorithms.

Types available within PotgreSQL include:
  - B-tree
  - Hash
  - GiST
  - GIN

##

## Syntax

General syntax for adding index to table 

```sql
CREATE INDEX index_name ON table_name (field_name);
```

#

## Unique and Non-unique

Indexes can be unique or not. 

When an index is created via `PRIMARY KEY` or `UNIQUE` constraints, the index is unique.
  - when an index is unique multiple table rows with equal values for that index are not allowed.
  - it is not possible to insert duplicate values in the columns that they index.

Non-unique indexes do not enforce unique constraint, meaning that the same value can occur multiple times in the indexed colum. 
  - this is referred to as a **non-unique index**

#

### Multi-column indexes

Can be created on more than one column. 

Syntax:

```sql
CREATE INDEX index_name ON table_name (field_name_1, field_name_2);
```

*Only certain types of indexes support multi-column index, and limit to number of columns that can be combined in an index* 

#

### Partial indexes

Built from a subset of data in a table. 

Subset of data defined by conditional expression and index contains entries only for the rows from the table where the value in the indexed column satisfies the condition. 
  - For example, indexing only the rows in the `author_name` column where the value of `author_name` starts with an `A`. 

Most often will use single-column or multi-column indexes instead of partial. 

##

Syntax to delete index

```sql
DROP INDEX index_name;
```

##
