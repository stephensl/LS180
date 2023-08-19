# Loading Database Dumps

Importing SQL file into database
  - file will contain list of SQL statements as if they had been typed out manually. 

## Two ways to load SQL files into PostgreSQL database

### `psql`

1. From command line:
  - pipe the SQL file into the `psql` program using redirection on the command line to stream the SQL file into `psql`'s standard input. 

```zsh
psql -d my_database < file_to_import.sql
```
This will execute the SQL statements within `file_to_import.sql` within the `my_database` database.


2. Inside `psql` session:
  - import a SQL file using the `\i` meta command

```sql
\i ~/some/files/file_to_import.sql
```

#
#

## Practice Problems

1. Load this file into your database.

```sql
DROP TABLE IF EXISTS public.films;
CREATE TABLE films (title varchar(255), "year" integer, genre varchar(100));

INSERT INTO films(title, "year", genre) VALUES ('Die Hard', 1988, 'action');  
INSERT INTO films(title, "year", genre) VALUES ('Casablanca', 1942, 'drama');  
INSERT INTO films(title, "year", genre) VALUES ('The Conversation', 1974, 'thriller');  
```

Copied content to file: `file_to_load.sql` locally. 

- What does the file do?

The file will first check to see if a table already exists in the database into which the file is being imported. If so, the DDL command `DROP TABLE` will execute, deleting the table. 

Next, a new table called `films` is created, followed by three `INSERT INTO` commands which add data to the `films` table. 

- What is the output of the command? What does each line in this output mean?

Output is: 
```sql
/* these two lines show that the database does not already have a table called "films", so the DROP TABLE command is skipped. */
NOTICE:  table "films" does not exist, skipping
DROP TABLE

/* this line confirms that a new table was created */
CREATE TABLE

/* these three lines each show that we inserted 3 rows into the table. The 0 indicates the number of rows that were updated, and the 1 indicates the number of rows added by the statement. This shows that we had three separate INSERT statements which added one new row each to the table. */
INSERT 0 1
INSERT 0 1
INSERT 0 1
```

- Open up the file and look at its contents. What does the first line do?

DROPS the `films` table if it exists.


#

2. Write a SQL statement that returns all rows in the films table.

```sql
SELECT * FROM films;
```

#

3. Write a SQL statement that returns all rows in the films table with a title shorter than 12 letters.

```sql
SELECT * FROM films
WHERE length(title) < 12;
```
# 

4. Write the SQL statements needed to add two additional columns to the `films` table: `director`, which will hold a director's full name, and `duration`, which will hold the length of the film in minutes.

```sql
ALTER TABLE films
ADD COLUMN director varchar(50), 
ADD COLUMN duration integer;
```

#

5. Write SQL statements to update the existing rows in the database with values for the new columns:

| Title            | Director             | Duration |
|------------------|----------------------|----------|
| Die Hard         | John McTiernan       | 132      |
| Casablanca       | Michael Curtiz       | 102      |
| The Conversation | Francis Ford Coppola | 113      |


```sql
UPDATE films
   SET director = 'John McTiernan', duration = 132
 WHERE title = 'Die Hard';

UPDATE films
   SET director = 'Michael Curtiz', duration = 102
 WHERE title = 'Casablanca';

UPDATE films
   SET director = 'Francis Ford Coppola', duration = 113
 WHERE title = 'The Conversation';
```

#

6. Write SQL statements to insert the following data into the films table:

| Title                      | Year | Genre     | Director          | Duration |
|----------------------------|------|-----------|-------------------|----------|
| 1984                       | 1956 | scifi     | Michael Anderson  | 90       |
| Tinker Tailor Soldier Spy  | 2011 | espionage | Tomas Alfredson   | 127      |
| The Birdcage               | 1996 | comedy    | Mike Nichols      | 118      |


```sql
INSERT INTO films (title, year, genre, director, duration)
     VALUES 
            ('1984', 1956, 'scifi', 'Michael Anderson', 90),
            ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127),
            ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);
```

#

7. Write a SQL statement that will return the title and age in years of each movie, with newest movies listed first:

```sql
SELECT title, extract(year FROM now()) - year AS age
FROM films
ORDER BY age;
```

#

8. Write a SQL statement that will return the title and duration of each movie longer than two hours, with the longest movies first.

```sql
SELECT title, duration FROM films
WHERE duration > 120
ORDER BY duration DESC;
```

#

9. Write a SQL statement that returns the title of the longest film.

```sql
SELECT title FROM films
ORDER BY duration DESC
LIMIT 1;
```
#
#
