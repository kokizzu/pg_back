CREATE ROLE u1 LOGIN PASSWORD 'u1';
CREATE DATABASE b1 OWNER u1;
ALTER ROLE u1 IN DATABASE b1 SET work_mem TO '1MB';
ALTER ROLE u1 SET temp_buffers TO '32MB';
ALTER DATABASE b1 SET work_mem TO '5MB';
ALTER DATABASE b1 SET log_min_duration_statement TO '10s';

CREATE ROLE u2 LOGIN PASSWORD 'u2';
CREATE DATABASE b2 OWNER u1;
REVOKE ALL ON DATABASE b2 FROM PUBLIC;
GRANT CONNECT ON DATABASE b2 TO u2;

\c b1

SET ROLE u1;
CREATE TABLE IF NOT EXISTS t1 AS SELECT generate_series(0, 9) i;
CREATE TABLE IF NOT EXISTS t2 AS SELECT generate_series(10, 19) j;
CREATE TABLE IF NOT EXISTS t3 AS SELECT generate_series(0, 9) i;
CREATE TABLE IF NOT EXISTS t4 AS SELECT generate_series(10, 19) j;

\c b2

GRANT CREATE,USAGE ON SCHEMA public TO u2;
SET ROLE u2;
CREATE TABLE IF NOT EXISTS t1 AS SELECT generate_series(0, 9) i;
CREATE TABLE IF NOT EXISTS t2 AS SELECT generate_series(10, 19) j;
CREATE TABLE IF NOT EXISTS t3 AS SELECT generate_series(0, 9) i;
CREATE TABLE IF NOT EXISTS t4 AS SELECT generate_series(10, 19) j;
