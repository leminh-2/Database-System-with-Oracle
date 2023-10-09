--in admin (system) connection to the database
CREATE USER c##dbs2223 identified by dbs2223;

--set permissions to user connection to the database
GRANT CREATE SESSION TO c##dbs2223;
GRANT DBA TO c##dbs2223;
GRANT CREATE TABLE TO c##dbs2223;