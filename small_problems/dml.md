 # Small Problems Data Manipulation Language

#
#

1. For this set of exercises we'll want to create a new database and some tables to work with. The theme for the exercise is that of a workshop. Create a database to store information and tables related to this workshop.

One table should be called devices. This table should have columns that meet the following specifications:

Includes a primary key called id that is auto-incrementing.
A column called name, that can contain a String. It cannot be NULL.
A column called created_at that lists the date this device was created. It should be of type timestamp and it should also have a default value related to when a device is created.
In the workshop, we have several devices, and each device should have many different parts. These parts are unique to each device, so one device can have various parts, but those parts won't be used in any other device. Make a table called parts that reflects the information listed above. Table parts should have the following columns that meet the following specifications:

An id which auto-increments and acts as the primary key
A part_number. This column should be unique and not null.
A foreign key column called device_id. This will be used to associate various parts with a device.


```sql
--- Create devices table

CREATE TABLE devices (
    id serial PRIMARY KEY,
    name text NOT NULL, 
    created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

--- Create parts table

CREATE TABLE parts (
    id serial PRIMARY KEY,
    part_number integer UNIQUE NOT NULL, 
    device_id integer REFERENCES devices (id)
);

```

#

2. Now that we have the infrastructure for our workshop set up, let's start adding in some data. Add in two different devices. One should be named, "Accelerometer". The other should be named, "Gyroscope".

The first device should have 3 parts (this is grossly simplified). The second device should have 5 parts. The part numbers may be any number between 1 and 10000. There should also be 3 parts that don't belong to any device yet.

```sql
INSERT INTO parts (part_number, device_id)
    VALUES
    (1, 1),
    (2, 1), 
    (3, 1),
    (4, 2), 
    (5, 2), 
    (6, 2), 
    (7, 2), 
    (8, 2), 
    (9, NULL),
    (10, NULL),
    (11, NULL);
```

#

3. Write an SQL query to display all devices along with all the parts that make them up. We only want to display the name of the devices. Its parts should only display the part_number.

Expected output:
```
     name      | part_number
---------------+-------------
 Accelerometer |          12
 Accelerometer |          14
 Accelerometer |          16
 Gyroscope     |          31
 Gyroscope     |          33
 Gyroscope     |          35
 Gyroscope     |          37
 Gyroscope     |          39
(8 rows)
```

```sql
SELECT devices.name, parts.part_number
FROM devices
INNER JOIN parts ON devices.id = parts.device_id;
```

#

4. We want to grab all parts that have a part_number that starts with 3. Write a SELECT query to get this information. This table may show all attributes of the parts table.

```sql
SELECT * FROM parts WHERE CAST(part_number AS TEXT) LIKE '3%';
```

#

5. Write an SQL query that returns a result table with the name of each device in our database together with the number of parts for that device.

```sql
SELECT devices.name, COUNT(parts.device_id)
FROM devices
LEFT OUTER JOIN parts ON devices.id = parts.device_id
GROUP BY devices.name;
```

#

6. In the previous exercise, we had to use a GROUP BY clause to obtain the expected output. In that exercise, we used an SQL query like:

```sql
SELECT devices.name AS name, COUNT(parts.device_id)
FROM devices
JOIN parts ON devices.id = parts.device_id
GROUP BY devices.name;
```

Now, we want to work with the same query, but we want to guarantee that the devices and the count of their parts are listed in descending alphabetical order. Alter the SQL query above so that we get a result table that looks like the following.

```
name          | count
--------------+-------
Gyroscope     |     5
Accelerometer |     3
(2 rows)
```

```sql
SELECT devices.name, COUNT(parts.device_id)
FROM devices
LEFT OUTER JOIN parts ON devices.id = parts.device_id
GROUP BY devices.name
ORDER BY devices.name DESC;
```

#

7. Write two SQL queries:

One that generates a listing of parts that currently belong to a device.
One that generates a listing of parts that don't belong to a device.
Do not include the id column in your queries.


```sql
SELECT part_number, device_id FROM parts
WHERE device_id IS NOT NULL;
```


```sql
SELECT part_number, device_id FROM parts
WHERE device_id IS NULL;
```

#


8. Insert one more device into the devices table. You may use this SQL statement or create your own.

```sql
INSERT INTO devices (name) VALUES ('Magnetometer');
INSERT INTO parts (part_number, device_id) VALUES (42, 3);
```

Assuming nothing about the existing order of the records in the database, write an SQL statement that will return the name of the oldest device from our devices table.

```sql
SELECT name AS oldest_device
 FROM devices
ORDER BY created_at ASC
LIMIT 1;
```

#

9. We've realized that the last two parts we're using for device number 2, "Gyroscope", actually belong to an "Accelerometer". Write an SQL statement that will associate the last two parts from our parts table with an "Accelerometer" instead of a "Gyroscope".

```sql
UPDATE parts SET device_id = 1 WHERE part_number = 7 OR part_number = 8;
```

#

10. Our workshop has decided to not make an Accelerometer after all. Delete any data related to "Accelerometer", this includes the parts associated with an Accelerometer.

```sql
CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number integer NOT NULL UNIQUE,
  device_id integer REFERENCES devices ON DELETE CASCADE
);
```


                        Table "public.products"
    Column     |          Type          |                       Modifiers
---------------+------------------------+-------------------------------------------------------
 id            | integer                | not null default nextval('products_id_seq'::regclass)
 product_name  | character varying(100) | not null
 supplier_name | character varying(100) |
 cost          | numeric(6,2)           | not null default 0
 price         | numeric(6,2)           | not null default 0
 stock         | integer                | not null default 0
Indexes:
    "products_pkey" PRIMARY KEY, btree (id)
    "products_product_name_key" UNIQUE CONSTRAINT, btree (product_name)
Check constraints:
    "price_check" CHECK (price > cost)