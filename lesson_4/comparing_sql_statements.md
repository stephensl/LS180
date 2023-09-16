# Comparing SQL Statements

Often many ways to structure a SQL query in order to achieve the same results. 

How to choose best structure for query?

One way is by assessing how efficient different query structures are...


###

## Assessing a query with `EXPLAIN`

Gives step by step analysis of how the query will be run internally by PostgreSQL.

For each query, PostgreSQL devises an appropriate **query plan**. 

Using the `EXPLAIN` command allows us to view the query plan. 

