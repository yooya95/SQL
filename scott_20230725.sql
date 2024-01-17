-- FK  ***
-- 1. Restrict : �ڽ� ���� ���� �ȵ�  (���� ���� ����)
--    1) ����   Emp Table����  REFERENCES DEPT (DEPTNO) 
--    2) ����   integrity constraint (SCOTT.FK_DEPTNO) violated - child record found

DELETE dept WHERE deptno = 10;


-- 2. Cascading Delete : ���� ����
--    1)���ӻ��� ���� : Emp Table���� REFERENCES DEPT (DEPTNO) ON DELETE CASCADE
DELETE dept WHERE deptno = 73;

-- 3.  SET NULL    (
--    1) ���� NULL ���� : Emp Table���� REFERENCES DEPT (DEPTNO)  ON DELETE SET NULL
DELETE dept WHERE deptno = 63;

---------------------------------------------------
--                            Backup Dir ���� 
---------------------------------------------------
-- Oracle �κ� Backup��  �κ� Restore  (scott)
--���� - cmd �۾�
--C:\Users\admin>cd C:\oraclexe\mdbackup
--C:\oraclexe\mdbackup>exp scott/tiger@xe file=address.dmp tables=address

--2) Oracle �κ� Restore  (scott)
--C:\oraclexe\mdbackup>imp scott/tiger@xe file=address.dmp full=y
--C:\oraclexe\mdbackup>imp scott/tiger@xe file=address.emp full=y
--------------------------------------------------------------
--��ü���/����
----------------------------------------------------------------
--1)Admin ����
--    [1] Backup Dir ����
--    [2] ���Ѻο�
--CREATE OR REPLACE Directory mdbackup as 'C:\oraclexe\mdbackup';
--GRANT read,write ON DIRECTORY mdbackup TO scott;

--2) scott ��ü Backup 
--   C:\oraclexe\mdbackup>EXPDP scott/tiger DIRECTORY=mdbackup DUMPFILE=scott.dmp

--3)  scott ��ü Restore
--    C:\oraclexe\mdbackup> IMPDP scott/tiger DIRECTORY=mdbackup DUMPFILE=scott.dmp

-----------------------------------------------------------------------------------------
--   11. View 
------------------------------------------------------------------------------
-- View : �ϳ� �̻��� �⺻ ���̺��̳� �ٸ� �並 �̿��Ͽ� �����Ǵ� ���� ���̺�
--        ��� �����͵�ųʸ� ���̺� �信 ���� ���Ǹ� ����
--       ���� :   ���� 
--       ���� :   Performance(����)�� �� ����

CREATE OR REPLACE VIEW VIEW_PROFESSOR AS
SELECT profno, name, userid, position, hiredate, deptno
FROM   professor;

CREATE OR REPLACE VIEW VIEW_PROFESSOR2 AS
SELECT name, userid, position, hiredate, deptno
FROM   professor;

-- ��ȸ�ϴ� ���� professor�� �޾Ƽ� ��ü������ ����
SELECT*FROM VIEW_PROFESSOR ;
-- Ư�� 1. ���� table [professor]�� �Է� ����, ������ ���������� �״�� ����!
-- �������ǿ� �ɸ��� �ʴ´ٸ� �並 ���� �Է� ����

INSERT INTO view_professor
VALUES(2000, 'view', 'userid','position',sysdate,101);

INSERT INTO view_professor (profno, userid, position, hiredate, deptno)
VALUES(2001, 'userid','position',sysdate,101);

INSERT INTO view_professor (profno, userid, position, hiredate, deptno)
VALUES(2002, 'userid','position',sysdate,101);

---- VIEW �̸� v_emp_sample  : emp(empno , ename , job, mgr,deptno)
CREATE OR REPLACE VIEW v_emp_sample 
AS
SELECT empno, ename, job, mgr, deptno
FROM emp;

--- ���� View  / ���� -->insert �ȵ�
CREATE OR REPLACE VIEW v_emp_complex
AS
SELECT *
FROM emp NATURAL JOIN dept;

SELECT*FROM v_emp_complex;

INSERT INTO v_emp_compelex (empno, ename, deptno)
            VALUES         (1500,     'ȫ�浿',20);
INSERT INTO v_emp_compelex (deptno, dname, loc)
            VALUES         (77,     '������','������');     
INSERT INTO v_emp_compelex (empno, ename, deptno, dname, loc)
            VALUES         (1500,'ȫ�浿', 77, '������','������');

------------     View  HomeWork     ----------------------------------------------------
---��1)  �л� ���̺��� 101�� �а� �л����� �й�, �̸�, �а� ��ȣ�� ���ǵǴ� �ܼ� �並 ����
---     �� �� :  v_stud_dept101
CREATE OR REPLACE VIEW v_stud_dept101
AS
SELECT studno, name, deptno
FROM student 
WHERE deptno = 101
;



--��2) �л� ���̺�� �μ� ���̺��� �����Ͽ� 102�� �а� �л����� �й�, �̸�, �г�, �а� �̸����� ���ǵǴ� ���� �並 ����
--      �� �� :   v_stud_dept102
CREATE OR REPLACE VIEW v_stud_dept102
AS
SELECT s.studno, s.name, s.grade, d.dname
FROM student s, department d
WHERE s.deptno = d. deptno 
AND  s.deptno = 102 ;


--��3)  ���� ���̺��� �а��� ��� �޿���     �Ѱ�� ���ǵǴ� �並 ����
--  �� �� :  v_prof_avg_sal       Column �� :   avg_sal      sum_sal

CREATE OR REPLACE VIEW v_stud_dept102
AS
SELECT s.studno, s.name, s.grade, d.dname
FROM student s, department d
WHERE s.deptno = d. deptno 
AND  s.deptno = 102 ;

--view ����
DROP VIEW v_stud_dept102;

SELECT view_name, text
FROM USER_VIEWS;


-------------------------------------
---- ������ ���ǹ�*
-------------------------------------
-- 1. ������ ������ ���̽� ���� ������� 2���� ���̺� ����
-- 2. ������ ������ ���̽����� �����Ͱ��� �θ� ���踦 ǥ���� �� �ִ� Į���� �����Ͽ� 
--    �������� ���踦 ǥ��
-- 3. �ϳ��� ���̺��� �������� ������ ǥ���ϴ� ���踦 ��ȯ����(recursive relationship)
-- 4. �������� �����͸� ������ Į�����κ��� �����͸� �˻��Ͽ� ���������� ��� ��� ����

-- ����
-- SELECT ��ɹ����� START WITH�� CONNECT BY ���� �̿�
-- ������ ���ǹ������� �������� ��� ���İ� ���� ��ġ ����
-- ��� ������  top-down �Ǵ� bottom-up
-- ����) CONNECT BY PRIOR �� START WITH���� ANSI SQL ǥ���� �ƴ�

-- ��1) ������ ���ǹ��� ����Ͽ� �μ� ���̺��� �а�,�к�,�ܰ������� �˻��Ͽ� �ܴ�,�к�
-- �а������� top-down ������ ���� ������ ����Ͽ���. ��, ���� �����ʹ� 10�� �μ�

SELECT          deptno, dname, college
FROM            department
START WITH      deptno = 10
CONNECT BY PRIOR deptno = college; --�ڽ��� ���� �θ� ���߿�(top-down)

-- ��2)������ ���ǹ��� ����Ͽ� �μ� ���̺��� �а�,�к�,�ܰ������� �˻��Ͽ� �а�,�к�
-- �ܴ� ������ bottom-up ������ ���� ������ ����Ͽ���. ��, ���� �����ʹ� 102�� �μ��̴�
SELECT deptno, dname, college
FROM   department
START WITH deptno = 102
CONNECT BY PRIOR college = deptno;

--- ��3) ������ ���ǹ��� ����Ͽ� �μ� ���̺��� �μ� �̸��� �˻��Ͽ� �ܴ�, �к�, �а�����
---         top-down �������� ����Ͽ���. ��, ���� �����ʹ� ���������С��̰�,
---        �� LEVEL(����)���� �������� 2ĭ �̵��Ͽ� ���

SELECT LEVEL, LPAD(' ', (LEVEL-1*2)) || dname ������--deptno, dname, college
FROM   department
START WITH dname = '��������'
CONNECT BY PRIOR deptno = college;

---      TableSpace  
---  ����  :�����ͺ��̽� ������Ʈ �� ���� �����͸� �����ϴ� ����
--           �̰��� �����ͺ��̽��� �������� �κ��̸�, ���׸�Ʈ�� �����Ǵ� ��� DBMS�� ���� 
--           �����(���׸�Ʈ)�� �Ҵ�
-------------------------------------------------------
-- 1. TableSpace ����
CREATE Tablespace user1 Datafile 'C:\oraclexe\tableSpace/user1.ora' SIZE 100M;
CREATE Tablespace user2 Datafile 'C:\oraclexe\tableSpace/user2.ora' SIZE 100M;
CREATE Tablespace user3 Datafile 'C:\oraclexe\tableSpace/user3.ora' SIZE 100M;
CREATE Tablespace user4 Datafile 'C:\oraclexe\tableSpace/user4.ora' SIZE 100M;

-- 2. ���̺��� ���̺� �����̽� ����
--    1) ���̺��� NDEX�� Table��  ���̺� �����̽� ��ȸ
SELECT INDEX_NAME, TABLE_NAME,TABLESPACE_NAME
FROM USER_INDEXES; 

SELECT TABLE_NAME,TABLESPACE_NAME
FROM USER_Tables;

--   2) �� ���̺� ���� Tablespace �� ���� 
--      �ش� Index ���� ���� �� Table �� Tablespace ����

ALTER INDEX PK_RELIGIONNO3 REBUILD TABLESPACE user1;
ALTER TABLE RELIGION MOVE TABLESPACE user1;

--   3) ���̺� �����̽� Size ����
ALTER Database Datafile 'C:\oraclexe\tableSpace/user4.ora' RESIZE 200M;

------------------------------------------------------------------------------------
--1) Admin ���� TableSpace Begin
------------------------------------------------------------------------------------
--1. TABLESPACE ����
CREATE Tablespace user5 Datafile 'C:\oraclexe\tableSpace/user5.ora' SIZE 100M;
CREATE Tablespace user6 Datafile 'C:\oraclexe\tableSpace/user6.ora' SIZE 100M;

CREATE Tablespace user6 Datafile 'C:\oraclexe\tableSpace/user6.ora' SIZE 100M;
--   2.  USER ����-- scott2 / tiger (SYSTEM ����)
CREATE USER scott2 IDENTIFIED BY tiger
DEFAULT TABLESPACE user6;
GRANT DBA TO scott2;
------------------------------------------------------------------------------------
--1) Admin ���� TableSpace END
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--2) Scott2 ���� TableSpace END
------------------------------------------------------------------------------------
--scott2 ���̺� ����

CREATE TABLE DEPT3
        ( DEPTNO number(2)   PRIMARY KEY,
          DNAME  VARCHAR2(14) ,
          LOC    VARCHAR2(13) );




