# Working with single table

## Practice Problems

1. Write a SQL statement that will create the following table, people:

| Name       | Age | Occupation |
|------------|-----|------------|
| Abby       | 34  | biologist  |
| Mu'nisah   | 26  | NULL       |
| Mirabelle  | 40  | contractor |


```sql
CREATE TABLE people (
  name varchar(25),
  age integer, 
  occupation varchar(25)
);
```

#

2. Write SQL statements to insert the data shown in #1 into the table.

```sql
INSERT INTO people
            (name, age, occupation)
     VALUES
            ('Abby', 34, 'biologist'), 
            ('Mu''nisah', 26, NULL), 
            ('Mirabelle', 40, 'contractor')
            ;
```

#

3. Write 3 SQL queries that can be used to retrieve the second row of the table shown in #1 and #2.

```sql
/* first */ 
SELECT * FROM people 
 WHERE name = 'Mu''nisah';

/* second */
SELECT name, age, occupation
  FROM people
 WHERE age = 26;

/* third */
SELECT * FROM people
 WHERE occupation IS NULL;
```

#

4. Write a SQL statement that will create a table named birds that can hold the following values:

| Name              | Length | Wingspan | Family      | Extinct |
|-------------------|--------|----------|-------------|---------|
| Spotted Towhee    | 21.6   | 26.7     | Emberizidae | f       |
| American Robin    | 25.5   | 36.0     | Turdidae    | f       |
| Greater Koa Finch | 19.0   | 24.0     | Fringillidae| t       |
| Carolina Parakeet | 33.0   | 55.8     | Psittacidae | t       |
| Common Kestrel    | 35.5   | 73.5     | Falconidae  | f       |


```sql
CREATE TABLE birds (
                    name varchar(50), 
                    length numeric(4, 1),
                    wingspan numeric(4, 1), 
                    family varchar(50), 
                    extinct boolean 
                  );
```

# 

5. Using the table created in #4, write the SQL statements to insert the data as shown in the listing.

```sql
INSERT INTO birds 
            (name, length, wingspan, family, extinct)
     VALUES
            ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false),
            ('American Robin', 25.5, 36.0, 'Turdidae', false),
            ('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', true), 
            ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true),
            ('Common Kestrel', 35.5, 73.5, 'Falconidae', false)
          ;
```

#

6. Write a SQL statement that finds the names and families for all birds that are not extinct, in order from longest to shortest (based on the length column's value).

```sql
SELECT name, family FROM birds
 WHERE extinct = false
 ORDER BY length DESC; 
```
returns: 
```
      name      |   family
----------------+-------------
 Common Kestrel | Falconidae
 American Robin | Turdidae
 Spotted Towhee | Emberizidae
(3 rows)
```

#

7. Use SQL to determine the average, minimum, and maximum wingspan for the birds shown in the table.

```sql
SELECT round(avg(wingspan), 1) AS average_wingspan,
             min(wingspan)     AS minimum_wingspan, 
             max(wingspan)     AS maximum_wingspan
  FROM birds;
```

returns:

```
 average_wingspan | minimum_wingspan | maximum_wingspan 
------------------+------------------+------------------
             43.2 |             24.0 |             73.5
(1 row)
```

#

8. Write a SQL statement to create the table shown below, `menu_items`:

| Item     | Prep Time | Ingredient Cost | Sales | Menu Price |
|----------|-----------|-----------------|-------|------------|
| omelette | 10        | 1.50            | 182   | 7.99       |
| tacos    | 5         | 2.00            | 254   | 8.99       |
| oatmeal  | 1         | 0.50            | 79    | 5.99       |


```sql
CREATE TABLE menu_items (
    item            varchar(50),
    prep_time       integer,
    ingredient_cost numeric(3, 2),  
    sales           integer,
    menu_price      numeric(3, 2)
);
```

#

9. Write SQL statements to insert the data shown in #8 into the table.

```sql
INSERT INTO menu_items (item, prep_time, ingredient_cost, sales, menu_price)
VALUES ('omelette', 10, 1.50, 182, 7.99),
       ('tacos', 5, 2.00, 254, 8.99),
       ('oatmeal', 1, 0.50, 79, 5.99);
```

#

10. Using the table and data from #8 and #9, write a SQL query to determine which menu item is the most profitable based on the cost of its ingredients, returning the name of the item and its profit.

```sql
SELECT item, (menu_price - ingredient_cost) AS profit FROM menu_items
ORDER BY profit DESC
LIMIT 1;
```

#

11. Write a SQL query to determine how profitable each item on the menu is based on the amount of time it takes to prepare one item. Assume that whoever is preparing the food is being paid $13 an hour. 

List the most profitable items first. Keep in mind that `prep_time` is represented in minutes and `ingredient_cost` and `menu_price` are both in dollars and cents:

calculation notes:

fractional_prep_time = prep_time / 60
labor_cost = 13 * fractional_prep_time

total_cost = labor_cost + ingredient_cost
profit = menu_price - total_cost

```sql
SELECT item, round((menu_price - ((CAST(prep_time AS float) / 60) * 13 + ingredient_cost))::numeric, 2) AS profit
FROM menu_items
ORDER BY profit DESC;
```

or for more info in the table: LS solution

```sql
SELECT item, menu_price, ingredient_cost,
       round(prep_time/60.0 * 13.0, 2) AS labor,
       menu_price - ingredient_cost - round(prep_time/60.0 * 13.0, 2) AS profit
  FROM menu_items
  ORDER BY profit DESC;
```

#
#