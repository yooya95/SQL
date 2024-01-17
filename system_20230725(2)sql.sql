CREATE Tablespace user6 Datafile 'C:\oraclexe\tableSpace/user6.ora' SIZE 100M;
------------------------------------------------------
--    USER »ý¼º
--   scott3  / tiger
--------------------------------------------------------
CREATE USER scott2 IDENTIFIED BY tiger
DEFAULT TABLESPACE user6;
GRANT DBA TO scott2;