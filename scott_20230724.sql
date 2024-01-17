----------------------------------
-- SEQUENCE ***
-- ������ �ĺ���
-- �⺻ Ű ���� �ڵ����� �����ϱ� ���Ͽ� �Ϸù�ȣ ���� ��ü
-- ���� ���, �� �Խ��ǿ��� ���� ��ϵǴ� ������� ��ȣ�� �ϳ��� �Ҵ��Ͽ� �⺻Ű�� �����ϰ��� �Ҷ� 
-- �������� ���ϰ� �̿�
-- ���� ���̺��� ���� ����  -- > �Ϲ������δ� ������ ��� 
----------------------------------
-- 1) SEQUENCE ����
--CREATE SEQUENCE sequence
--[INCREMENT BY n]
--[START WITH n]
--[MAXVALUE n | NOMAXVALUE]
--[MINVALUE n | NOMINVALUE]
--[CYCLE | NOCYCLE]
--[CACHE n | NOCACHE];
--INCREMENT BY n : ������ ��ȣ�� ����ġ�� �⺻�� 1,  �Ϲ������� ?1 ���
--START WITH n : ������ ���۹�ȣ, �⺻���� 1
--MAXVALUE n : ���� ������ �������� �ִ밪
--MAXVALUE n : ������ ��ȣ�� ��ȯ������ ����ϴ� cycle�� ������ ���, MAXVALUE�� ������ �� ���� �����ϴ� ��������
--CYCLE | NOCYCLE : MAXVALUE �Ǵ� MINVALUE�� ������ �� �������� ��ȯ���� ������ ��ȣ�� ���� ���� ����
--CACHE n | NOCACHE : ������ ���� �ӵ� ������ ���� �޸𸮿� ĳ���ϴ� ������ ����, �⺻���� 20

-- 2) SEQUENCE sample ����1
CREATE SEQUENCE sample_seq
INCREMENT BY 1
START WITH 10000;
-- �� �������κ��� ������ ��
SELECT sample_seq.NEXTVAL FROM dual;
-- �� �������κ��� ������ ���� �ٽ��ѹ� ��ȸ (���� ��)
SELECT sample_seq.CURRVAL FROM dual;


-- 3) SEQUENCE sample ����2 --> �� ��� ����
CREATE SEQUENCE dept_dno_seq
INCREMENT BY 1
START WITH 10
;

-- 4) SEQUENCE dept_dno_seq�� �̿� dept_second �Է� --> �� ��� ����
INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL, 'Accfounting' , 'NEW YORK')
;

SELECT dept_dno_seq.CURRVAL FROM dual;

INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL, 'ȸ��' , '�̴�')
;

SELECT dept_dno_seq.CURRVAL FROM dual;

INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL, '�λ���' , '���')
;

SELECT dept_dno_seq.CURRVAL FROM dual;

--max ��ȯ (�������� ����� ���� �Ҿ����)
INSERT INTO dept_second
VALUES((SELECT MAX(DEPTNO)+1 FROM dept_second)
            , '�濵��'
            , ' �븲'
      );
 -- MAX�� �� �� ������ ���� ����  ORA-00001: unique constraint (SCOTT.DEPT_SECOND_PK) violated    
INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL, '�λ�3��' , '���3')
;

--5) Data �������� ���� ��ȸ
SELECT sequence_name, min_value, max_value, increment_by
FROM   user_sequences;

--6) ������ ����
DROP SEQUENCE SAMPLE_SEQ;

------------------------------------------------------
----                               Table ����                             ----
------------------------------------------------------
-- 1.Table ����
CREATE TABLE address
(   id              NUMBER(3)    ,
    Name            VARCHAR2(50) ,
    addr            VARCHAR2(100),
    phone           VARCHAR2(30) ,
    email           VARCHAR2(100)
);

INSERT INTO ADDRESS
VALUES (1,'HGDNG','SEOUL','123-4567','gbhong@naver.com')
;

------------------------------------------------------
----                   HW                         ----
------------------------------------------------------
-- ��1) address��Ű��/Data �����ϸ�     addr_second Table ���� 
CREATE TABLE addr_second
AS SELECT ID, NAME, ADDR, PHONE, EMAIL
    FROM   address
;
CREATE TABLE addr_second (ID, NAME, ADDR, PHONE, EMAIL)
AS  SELECT * FROM address;


-- ��2) address��Ű�� �����ϸ�  Data ���� ���� �ʰ�   addr_seven Table ���� 
CREATE TABLE addr_seven (ID, NAME, ADDR, PHONE, EMAIL)
AS SELECT *
   FROM address
   WHERE 0=1;
-- ��3) address(�ּҷ�) ���̺��� id, name Į���� �����Ͽ� addr_third ���̺��� �����Ͽ���    
CREATE TABLE addr_third
AS SELECT ID, NAME
   FROM  ADDRESS
   ;
-- ��4) addr_second ���̺� �� addr_tmp�� �̸��� ���� �Ͻÿ�
RENAME ADDR_SECOND TO addr_tmp;

------------------------------------------------------
----                   HW END                         ----
-----------------------------------------------------

------------------------------------------------------------------
-----     ������ ����
-- 1. ����ڿ� �����ͺ��̽� �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺��� ����
-- 2. ���� ������ ������ ����Ŭ ������ ����
-- 3. ����Ŭ ������ ����Ÿ���̽��� ����, ����, ����� ����, ������ ���� ���� ������ �ݿ��ϱ� ����
--    ������ ���� �� ����
-- 4. ����Ÿ���̽� �����ڳ� �Ϲ� ����ڴ� �б� ���� �信 ���� ������ ������ ������ ��ȸ�� ����
-- 5. �ǹ������� ���̺�, Į��, �� ��� ���� ������ ��ȸ�ϱ� ���� ���

------------------------------------------------------------------
------------------------------------------------------------------
-----     ������ ���� ���� ����
-- 1.�����ͺ��̽��� ������ ������ ��ü�� ���� ����
-- 2. ����Ŭ ����� �̸��� ��Ű�� ��ü �̸�
-- 3. ����ڿ��� �ο��� ���� ���Ѱ� ��
-- 4. ���Ἲ �������ǿ� ���� ����
-- 5. Į������ ������ �⺻��
-- 6. ��Ű�� ��ü�� �Ҵ�� ������ ũ��� ��� ���� ������ ũ�� ����
-- 7. ��ü ���� �� ���ſ� ���� ���� ����
-- 8.�����ͺ��̽� �̸�, ����, ������¥, ���۸��, �ν��Ͻ� �̸� ����
------------------------------------------------------------------
-------     ������ ���� ����
-- 1. USER_ : ��ü�� �����ڸ� ���� ������ ������ ���� ��
-- user_tables�� ����ڰ� ������ ���̺� ���� ������ ��ȸ�� �� �ִ� ������ ���� ��.

SELECT table_name    -- *
FROM   user_tables;

SELECT *
FROM user_catalog;

-- 2. ALL_    : �ڱ� ���� �Ǵ� ������ �ο� ���� ��ü�� ���� ������ ������ ���� ��
SELECT owner, table_name
FROM all_tables;

-- 3. DBA_   : �����ͺ��̽� �����ڸ� ���� ������ ������ ���� ��
SELECT owner, table_name
FROM dba_Tables;

------------------------------------------------------------
------------            ��������(Constraint)        ***          ------------
--  ����  : �������� ��Ȯ���� �ϰ����� ����
-- 1. ���̺� ������ ���Ἲ ���������� ���� ����
-- 2. ���̺� ���� ����, ������ ��ųʸ��� ����ǹǷ� ���� ���α׷����� �Էµ� 
--     ��� �����Ϳ� ���� �����ϰ� ����
-- 3. ���������� Ȱ��ȭ, ��Ȱ��ȭ �� �� �ִ� ���뼺
-------------------------------------------------------------

-------------------------------------------------------------
------------            ��������(Constraint)   ����      ***  ------------
-- 1 .NOT NULL  : ���� NULL�� ������ �� ����
-- 2. �⺻Ű(primary key) : UNIQUE +  NOT NULL + �ּҼ�  ���������� ������ ����
-- 3. ����Ű(foreign key) :  ���̺� ���� �ܷ� Ű ���踦 ���� ***
-- 4. CHECK : �ش� Į���� ���� ������ ������ ���� ������ ���� ����
-------------------------------------------------------------
-- 1.  ��������(Constraint) ���� ���� ����(subject) ���̺� �ν��Ͻ�

CREATE TABLE subject (
    subno       NUMBER(5)    CONSTRAINT subject_no_pk PRIMARY KEY,
    subname     VARCHAR2(20) CONSTRAINT subject_name_nn NOT NULL,
    term        VARCHAR2(1)  CONSTRAINT subject_term_ck CHECK(term IN('1','2')),
    typeGubun   Varchar2(1)
);

COMMENT ON COLUMN subject.subno     IS  '������ȣ';
COMMENT ON COLUMN subject.subname   IS  '��������';
COMMENT ON COLUMN subject.term      IS  '�б�';

INSERT INTO subject(subno, subname, term, typeGubun)
                    values(1000, '��ǻ�Ͱ���','1','1');
                    
--INSERT INTO subject(subno, subname, term, typeGubun)
--                    values(1000, ' ',' ','1'); �������

INSERT INTO subject(subno, subname, term, typeGubun)
                    values(1001, 'DB����',   '2','1');
INSERT INTO subject(subno, subname, term, typeGubun)
                    values(1002, 'JSP����',  '1','1');                    
        
-- PK Constraint   --> Unique
INSERT INTO subject(subno, subname, term, typeGubun)
                    values(1001, 'spring����', '1','1');
-- PK Constraint   --> NN
INSERT INTO subject(subno, subname, term, typeGubun)
                    values( '','spring����2', '1','1');          
-- subname NN
INSERT INTO subject(subno, subname, term, typeGubun)
                    values( 1003 ,'',  '1','1');                   
-- Check  Constraint   --> term
INSERT INTO subject(subno, subname, term, typeGubun)
                    values( 1003 , 'spring����3', '5','1');
                    
-- Table ����� ���Ѱ��� ���� ���� ����
-- Student Table �� idnum�� unique�� ����
ALTER TABLE student
ADD CONSTRAINT stud_idnum_uk UNIQUE(idnum); --ADD�� UNIQUE

--idunum ---->ok
INSERT INTO student(studno, name, idnum)
            values(30101,   '������','8012301036613');
--idunum ----> unique constraint         
INSERT INTO student(studno, name, idnum)
            values(30102,   '������','8012301036613');
            
-- student table�� name�� NN���� ����
ALTER table student
MODIFY (name CONSTRAINT stud_name_nn NOT NULL); --MODIFY �� NOT NULL

-- NAME --> NN constraint
INSERT INTO student(studno, name, idnum)
            values(30103,   ,'8012301036614');
            
--constratint��ȸ
SELECT CONSTRAINT_name, CONSTRAINT_Type
FROM user_CONSTRAINTS
WHERE table_name IN('SUBJECT','STUDENT','ADDRESS');

---------------------------------------------------------------
-----      INDEX      ***
--  �ε����� SQL ��ɹ��� ó�� �ӵ��� ���(*) ��Ű�� ���� Į���� ���� �����ϴ� ��ü
--  �ε����� ����Ʈ�� �̿��Ͽ� ���̺� ����� �����͸� ���� �׼����ϱ� ���� �������� ���
--  [1]�ε����� ����
--   1)���� �ε��� : ������ ���� ������ Į���� ���� �����ϴ� �ε����� ��� �ε��� Ű��
--           ���̺��� �ϳ��� ��� ����
CREATE UNIQUE INDEX idx_dept_name
ON     department(dname);
--   2)����� �ε���, ���ɿ��� ������ ��ġ�� �������ǿ��� ������ ����
-- ��) �л� ���̺��� birthdate Į���� ����� �ε����� �����Ͽ���
CREATE INDEX idx_stud_birthdate
ON student(birthdate);

INSERT INTO student( studno, name, idnum,             birthdate)
            values(30102 , '������','8012301036614' , '84/09/16');
            
--   3)���� �ε���
--   4)���� �ε��� :  �� �� �̻��� Į���� �����Ͽ� �����ϴ� �ε���
--     ��) �л� ���̺��� deptno, grade Į���� ���� �ε����� ����
--          ���� �ε����� �̸��� idx_stud_dno_grade �� ����
CREATE INDEX idx_stud_dno_grade
ON     student(deptno, grade);

SELECT *
FROM   student
WHERE  deptno =101
AND    grade = 2
;

--- Optimizer
--- 1) RBO  2) CBO
-- RBO ����
ALTER SESSION SET OPTIMIZER_MODE=RULE;

--SESSION �󿡼� �����Ҷ�
ALTER SESSION SET optimizer_mode= rule
ALTER SESSION SET optimizer_mode= CHOOSE
ALTER SESSION SET optimizer_mode= first_rows
ALTER SESSION SET optimizer_mode= ALL_Rows

--   5)�Լ� ��� �ε���(FBI) function based index
--      ����Ŭ 8i �������� �����ϴ� ���ο� ������ �ε����� Į���� ���� �����̳� �Լ��� ��� ����� 
--      �ε����� ���� ����
--      UPPER(column_name) �Ǵ� LOWER(column_name) Ű����� ���ǵ�
--      �Լ� ��� �ε����� ����ϸ� ��ҹ��� ���� ���� �˻�

CREATE INDEX lowercase_idx ON emp (LOWER(ename));
 
SELECT *
FROM emp
WHERE lower(ename) = 'king' ;

--�л� ���̺� ������ PK_STUDNO �ε����� �籸��
ALTER INDEX PK_STUDNO REBUILD;

--1. Index ���� ��ȸ;
SELECT index_name, table_name, column_name
FROM user_ind_columns;

--2. Index ���� emp(job)
CREATE INDEX idx_emp_job ON emp(job);

--3. ��ȸ
SELECT * FROM emp WHERE JOB = 'MANAGER';
SELECT * FROM emp WHERE JOB <>'MANAGER'; --�������� �ε����� Ÿ�� �ʴ´�!
SELECT * FROM emp WHERE JOB LIKE 'MA%';
SELECT * FROM emp WHERE JOB LIKE '%MA%'; --�ε����� Ÿ�� ����
SELECT * FROM emp WHERE UPPER(JOB) = 'MANAGER';


--SQL Optimizer
--Hint ���� --> /*+  +/
SELECT /* + first_row*/ ename From emp;

SELECT /*+ rule */ ename From emp;

--OPTIMIZER ��� Ȯ��
SELECT NAME, VALUE, ISDEFAULT, ISMODIFIED, DESCRIPTION
FROM V$SYSTEM_PARAMETER
WHERE NAME LIKE '%optimizer_mode%'




