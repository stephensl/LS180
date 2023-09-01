-- --- Create devices table

-- CREATE TABLE devices (
--     id serial PRIMARY KEY,
--     name text NOT NULL, 
--     created_at timestamp DEFAULT CURRENT_TIMESTAMP
-- );

-- --- Create parts table

-- CREATE TABLE parts (
--     id serial PRIMARY KEY,
--     part_number integer UNIQUE NOT NULL, 
--     device_id integer REFERENCES devices (id)
-- );


-- Insert devices

-- INSERT INTO devices (name)
--     VALUES ('Accelerometer'), ('Gyroscope');


-- Insert parts, and assign to devices

-- INSERT INTO parts (part_number, device_id)
--     VALUES
--     (1, 1),
--     (2, 1), 
--     (3, 1),
--     (4, 2), 
--     (5, 2), 
--     (6, 2), 
--     (7, 2), 
--     (8, 2), 
--     (9, NULL),
--     (10, NULL),
--     (11, NULL);

-- SELECT devices.name, parts.part_number
-- FROM devices
-- INNER JOIN parts ON devices.id = parts.device_id;

-- SELECT * FROM parts WHERE CAST(part_number AS TEXT) LIKE '3%';


-- SELECT devices.name, COUNT(parts.device_id)
-- FROM devices
-- LEFT OUTER JOIN parts ON devices.id = parts.device_id
-- GROUP BY devices.name
-- ORDER BY devices.name DESC, count DESC;


-- SELECT part_number, device_id FROM parts
-- WHERE device_id IS NOT NULL;

-- SELECT part_number, device_id FROM parts
-- WHERE device_id IS NULL;

-- INSERT INTO devices (name) VALUES ('Magnetometer');
-- INSERT INTO parts (part_number, device_id) VALUES (42, 3);

-- SELECT name, MAX(AGE(created_at)) as time_since_creation FROM devices
-- GROUP BY name LIMIT 1;

UPDATE parts SET device_id = 1 WHERE part_number = 7 OR part_number = 8;

UPDATE parts SET device_id = MIN(part_number);