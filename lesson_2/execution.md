# How PostgreSQL Executes Queries

## Declarative Language

- Describes what to do, but not how to do it. 

### Process for `SELECT`

1. Rows are collected into virtual derived table
  - can think of as database creating temporary table sing data from all tables listed in `FROM` clause.
  - includes tables used in `JOIN` clauses (different from transient tables with joins)

2. Rows are filtered using `WHERE` conditions
  - All conditions in the `WHERE` clause are evaluated for each row
    - removed if do not meet requirement

3. Rows divided into groups
  - If query includes `GROUP BY` clause, remaining rows are divided into appropriate groups.

4. Groups filtered using `HAVING` conditions
  - Similar to `WHERE` condition but for grouped data

5. Compute values to return using select list
  - each element in the select list is evaluated, including any functions
  - resulting values are associated with name of the column they are from, or the name of the last function evaluated unless different alias specified. 

6. Sort Results
  - Results set sorted as specified by `ORDER BY` clause. 

7. Limit Results
  - If `LIMIT` or `OFFSET` clauses included, used to adjust which rows are returned. 

