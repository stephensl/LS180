# More practice

1. Create a new database called residents using the PostgreSQL command line tools.

`createdb residents`

#

2. Load this file into the database created in #1.
  - loaded file called test_data.sql

```zsh
psql -d residents < test_data.sql
```

#

3. Write a SQL query to list the ten states with the most rows in the people table in descending order.

```sql
SELECT state, count(id) AS state_count FROM people
GROUP BY state
ORDER BY state_count DESC
LIMIT 10;
```

#

4. Write a SQL query that lists each domain used in an email address in the people table and how many people in the database have an email address containing that domain. Domains should be listed with the most popular first.

```sql
SELECT substring(email, '@(.+)') AS domain, count(id) AS domain_count
FROM people
GROUP BY domain
ORDER BY domain_count DESC;
```

alternatively: LS SOLUTION

```sql
SELECT substr(email, strpos(email, '@') + 1) AS domain, 
        count(id)
FROM people
GROUP BY domain
ORDER BY count DESC;
```
in the launch school solution..
  - substr takes two arguments, the column name, and start position of substring
    - substr will extract a substring starting at a specified position.
    - in this case, starting at position of '@' + 1, to the end of the string.
      - can provide another argument (integer) to substr if want to control how far we extract from the string. 
  - strpos takes two argument, column name and substring
    - in this case, we are looking in the email column, and locating the first occurrence of the substring `'@'`. We add 1 to this position to get position of character following the '@'. 

#

5. Write a SQL statement that will delete the person with ID 3399 from the people table.

```sql
DELETE FROM people 
WHERE id = 3399;
```

#

6. Write a SQL statement that will delete all users that are located in the state of California (CA).

```sql
DELETE FROM people
WHERE state = 'CA';
```

#

7. Write a SQL statement that will update the `given_name` values to be all uppercase for all users with an email address that contains `teleworm.us`.

```sql
UPDATE people 
SET given_name = upper(given_name)
WHERE email LIKE '%teleworm.us';
```

8. Write a SQL statement that will delete all rows from the people table.

```sql
DELETE FROM people;
```

#
#