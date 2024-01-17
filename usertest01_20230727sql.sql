CREATE TABLE DEPT
        (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
         DNAME VARCHAR2(14),
	     LOC   VARCHAR2(13) ) ;
         
--나는 admin tbl 스스로 조회 가능
SELECT * FROM system.systemTBL;