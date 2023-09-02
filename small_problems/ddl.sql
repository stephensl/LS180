CREATE DATABASE extrasolar;

\c extrasolar 

CREATE TABLE stars (
  id serial PRIMARY KEY, 
  name varchar(25) UNIQUE NOT NULL,
  distance int NOT NULL CHECK (distance > 0), 
  spectral_type char(1),
  companions int NOT NULL CHECK (companions >= 0)
);

CREATE TABLE planets (
  id serial PRIMARY KEY,
  designation char(1),
  mass int
);

ALTER TABLE planets
ADD COLUMN star_id int NOT NULL REFERENCES stars (id);


ALTER TABLE stars
ALTER COLUMN name
TYPE varchar(50);

ALTER TABLE stars
ALTER COLUMN distance
TYPE numeric;

ALTER TABLE stars
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN spectral_type SET NOT NULL;

CREATE TYPE spectral_options AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars 
DROP CONSTRAINT stars_spectral_type_check;

ALTER TABLE stars
ALTER COLUMN spectral_type
TYPE spectral_options
USING spectral_type::spectral_options;


ALTER TABLE planets
ALTER COLUMN mass
TYPE numeric;

ALTER TABLE planets
ALTER COLUMN mass
SET NOT NULL;

ALTER TABLE planets
ALTER COLUMN designation
SET NOT NULL;

ALTER TABLE planets
ADD CHECK (mass > 0.0);


ALTER TABLE planets
ADD COLUMN semi_major_axis numeric NOT NULL;


