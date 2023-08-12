# Schema

## Schema is part of the database
  - if a building is a database...
    - schema is the floorplan
      - physical rooms correspond to tables in database 
        - rooms may be different size, and contain different things
        - rooms may be connected to other rooms
      - All rooms exist within the schema (floor plan) of the building (database)

## Using DDL (Data Definition Language) to create database
  - deals with setting up the structure or schema of the database.
  - focused on defining characteristics of the database and its tables and columns 

#
#

## Exercises

1. From the Terminal, create a database called database_one.

`createdb database_one`

2. From the Terminal, connect via the psql console to the database that you created in the previous question.

`psql -d database_one`

3. From the psql console, create a database called database_two.

`database_one=# CREATE DATABASE database_two;`

4. From the psql console, connect to database_two.

`\c database_two`

5. Display all databases that currently exist

`\list`

6. From the psql console, delete database_two.

`DROP DATABASE database_two;`

7. From the Terminal, delete the database_one and ls_burger databases.

`dropdb database_one`
`dropdb ls_burger`

