# Comparing SQL Statements

Often many ways to structure a SQL query in order to achieve the same results. 

How to choose best structure for query?

One way is by assessing how efficient different query structures are...


###

## Assessing a query with `EXPLAIN`

Gives step by step analysis of how the query will be run internally by PostgreSQL.

For each query, PostgreSQL devises an appropriate **query plan**. 

Using the `EXPLAIN` command allows us to view the query plan. 


#

Example: use with `auction` database and `items` table

```sql
auction=# EXPLAIN SELECT * FROM items;
                       QUERY PLAN                        
---------------------------------------------------------
 Seq Scan on items  (cost=0.00..18.80 rows=880 width=64)
(1 row)
```

The structure of the query plan is a node tree. 

In this case there is only one node in the plan tree. Each node consists of the node type (sequential scan of the `items` table) along with the estimated cost for that node (start-up cost, followed by total cost), the estimated number of rows to be output by the node, and the estimated average width of the rows in bytes. 

Start-up cost: initial cost before any row can be returned by the operation. For example, if data needs to be sorted, the startup cost would include the time to perform the sort. 

Total-cost: represents total time and resources to complete operation.

Rows: estimate of number of rows that will be processed or returned by operation. helps understanding scale of operation. 

Width: number of bytes in each row that is being processed. gives idea of how much data needs to be read or written. 

In total, this is a helpful metric in optimizing queries. 

##

**A key piece of info from theses is to compare the 'total cost' value of the top-most node.**
 In the example above is `18.80`.

##

### `EXPLAIN ANALYZE`

When we run `EXPLAIN` the query is not actually run. The values output by `EXPLAIN` are estimates. In order to assess the query more accurately, using actual data, add `ANALYZE` option to an `EXPLAIN` command. 

```sql
auction=# EXPLAIN ANALYZE SELECT name FROM items
auction-# JOIN bids ON items.id = bids.item_id
auction-# WHERE amount > 100 AND amount < 120;
                                                QUERY PLAN                                                 
-----------------------------------------------------------------------------------------
 Hash Join  (cost=32.75..54.93 rows=8 width=32) (actual time=0.438..0.442 rows=1 loops=1)
   Hash Cond: (items.id = bids.item_id)
   ->  Seq Scan on items  (cost=0.00..18.80 rows=880 width=36) (actual time=0.017..0.019 rows=6 loops=1)
   ->  Hash  (cost=32.65..32.65 rows=8 width=4) (actual time=0.398..0.398 rows=1 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 9kB
         ->  Seq Scan on bids  (cost=0.00..32.65 rows=8 width=4) (actual time=0.016..0.026 rows=1 loops=1)
               Filter: ((amount > '100'::numeric) AND (amount < '120'::numeric))
               Rows Removed by Filter: 25
 Planning Time: 0.410 ms
 Execution Time: 0.491 ms
(10 rows)
```
Using the ANALYZE option actually runs the query and, in addition to the output normally returned by EXPLAIN, includes the actual time (in milliseconds) required to run the query and its constituent parts, as well as the actual rows returned by each plan node rather than just a number of rows based on defaults statistics.

#
#
