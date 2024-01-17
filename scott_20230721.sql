   -- ���� �÷� ��������
-- ������������ ���� ���� Į�� ���� �˻��Ͽ� ���������� �������� ���ϴ� ��������
-- ���������� ������������ ���������� Į�� ����ŭ ����
-- ����
-- 1) PAIRWISE : Į���� ������ ��� ���ÿ� ���ϴ� ���
-- 2) UNPAIRWISE : Į������ ����� ���� ��, AND ������ �ϴ� ���

-- 1) PAIRWISE ���� Į�� ��������
-- ��1)    PAIRWISE �� ����� ���� �г⺰�� �����԰� �ּ��� 
--          �л��� �̸�, �г�, �����Ը� ����Ͽ��� 

SELECT NAME, GRADE, WEIGHT
FROM STUDENT
WHERE( GRADE, WEIGHT) IN (SELECT   GRADE, MIN(WEIGHT)
                          FROM     STUDENT
                          GROUP BY GRADE)
;

--  2) UNPAIRWISE : Į������ ����� ���� ��, AND ������ �ϴ� ���
-- UNPAIRWISE �� ����� ���� �г⺰�� �����԰� �ּ��� �л��� �̸�, �г�, �����Ը� ���
SELECT name, grade, weight
FROM   student
--        1,2,3,4
WHERE grade  IN (  SELECT   grade
                   FROM     student
                   GROUP BY grade)
--                              52,42,70,72              
AND  weight  IN (  SELECT   MIN(weight)
                   FROM     student
                   GROUP BY grade)
;

-- ��ȣ���� ��������     ***
-- ������������ ������������ �˻� ����� ��ȯ�ϴ� ��������
-- ��1)  �� �а� �л��� ��� Ű���� Ű�� ū �л��� �̸�, �а� ��ȣ, Ű�� ����Ͽ���
-- ���� ���� 1 -> select��from�� ���� ����
-- ������� 3 -> ��ü�� ��ȸ
SELECT deptno, name, grade, height
FROM   student s1
WHERE  height > (SELECT AVG(height)
                 FROM   student s2
                 -- WHERE S2.DEPTNO = 101
                 --                 �������2 - > �������� ����
                 WHERE s2.deptno = s1.deptno
                 )
ORDER BY deptno
;

--TEST
SELECT DEPTNO, NAME, GRADE, HEIGHT
FROM  STUDENT
WHERE  HEIGHT > ( SELECT DEPTNO, AVG(HEIGHT)
                  FROM STUDENT
                  GROUP BY DEPTNO
                 )
ORDER BY DEPTNO
;

----------------------  HW  (EMP) -------------------------
-- 1. Blake�� ���� �μ��� �ִ� ��� ����� ���ؼ� ��� �̸��� �Ի����� ���÷����϶�
SELECT ename, hiredate
FROM  emp
WHERE deptno = (
                 SELECT deptno
                 FROM emp 
                 WHERE  INITCAP(ename) = 'BLAKE'
                )
;


-- 2. ��� �޿� �̻��� �޴� ��� ����� ���ؼ� ��� ��ȣ�� �̸��� ���÷����ϴ� ���ǹ��� ����. 
--    �� ����� �޿� �������� �����϶�

SELECT empno, ename, sal
FROM emp e1
WHERE sal >= (
               SELECT AVG(sal)
               FROM emp e2
               WHERE e1.deptno = e2.deptno
               )
ORDER BY sal DESC
;

SELECT empno, ename, sal
FROM   emp
WHERE  sal >  ( SELECT AVG(sal)
               FROM  emp
               )
ORDER BY sal desc;

-- 3. ���ʽ��� �޴� � ����� �μ� ��ȣ�� 
--    �޿��� ��ġ�ϴ� ����� �̸�, �μ� ��ȣ �׸��� �޿��� ���÷����϶�.
SELECT ename, deptno ,sal
FROM emp e1
WHERE sal in (
               SELECT sal
               FROM   emp e2
               WHERE  e1.deptno = e2.deptno
               AND comm is not null
             )
;

SELECT ename, deptno, sal
FROM emp
WHERE (deptno, sal) IN
            	( SELECT deptno, sal
             	  FROM emp
            	  WHERE comm IS NOT NULL
                 );
    
--  ������ ���۾� (DML:Data Manpulation Language)  **                  ----------
-- 1.���� : ���̺� ���ο� �����͸� �Է��ϰų� ���� �����͸� ���� �Ǵ� �����ϱ� ���� ��ɾ�
-- 2. ���� 
--  1) INSERT : ���ο� ������ �Է� ��ɾ�
--  2) UPDATE : ���� ������ ���� ��ɾ�
--  3) DELETE : ���� ������ ���� ��ɾ�
--  4) MERGE : �ΰ��� ���̺��� �ϳ��� ���̺�� �����ϴ� ��ɾ�

-- 1) Insert
--not enough values
INSERT INTO DEPT VALUES (71, '�λ�' );
INSERT INTO DEPT VALUES (71, '�λ�', '�̴�');
INSERT INTO DEPT (deptno, Dname) VALUES (72, 'ȸ����');
INSERT INTO DEPT (deptno, Dname, LOC) VALUES (75, '������','�Ŵ��');
--unique constraint (SCOTT.PK_DEPT) violated (����ũ �������� ����)
INSERT INTO DEPT (deptno, LOC, Dname) VALUES (75, '������','ȸ����');
INSERT INTO DEPT (deptno, LOC) VALUES (73,'ȫ��');
INSERT INTO DEPT (LOC, deptno) VALUES ('���',77);

INSERT INTO PROFESSOR (profno,  name,   position, hiredate,                       deptno)
              VALUES  (9920  , '������', '������',  TO_DATE('2006/01/01','YYYY/MM/DD'),102);
INSERT INTO PROFESSOR (profno,  name,   position, hiredate, deptno)              
              VALUES  (9910  , '��̼�', '���Ӱ���', sysdate, 101);

DROP   TABLE JOB3;

CREATE TABLE JOB3
(  jobno     NUMBER(2)     PRIMARY KEY,
   jobname   VARCHAR2(20)
) ;

INSERT INTO JOB3 (JOBNO, JOBNAME) VALUES (10,'�б�');
INSERT INTO JOB3                  VALUES (11,'������');
INSERT INTO JOB3                  VALUES (12,'������');
INSERT INTO JOB3 (JOBNAME, JOBNO) VALUES ('����',13);
INSERT INTO JOB3 (JOBNO, JOBNAME) VALUES (14,'�߼ұ��');

CREATE TABLE Religion
( religion_no     NUMBER(2)   CONSTRAINT PK_ReligionNO3 PRIMARY KEY,
  religion_name VARCHAR2(20)
)
;  

INSERT INTO Religion                             VALUES (10,'�⵶��');
INSERT INTO Religion                             VALUES (20,'���縯��');
INSERT INTO Religion(religion_no, religion_name) VALUES (30,'�ұ�');
INSERT INTO Religion(religion_no, religion_name) VALUES (40,'����');

commit;
ROLLBACK;

--------------------------------------------------
-----   ���� �� �Է�                                           ------
--------------------------------------------------
-- 1. ������ TBL�̿� �ű� TBL ���� 
-- �⺻��Ҹ� ����� pk ���� x
create Table dept_second
AS SELECT * FROM dept;


--2. TBL ���� ����
create Table emp20
AS 
        SELECT empno, ename, sal*12 annsal
        FROM   emp
        WHERE  deptno = 20;
        
-- 3. TBL ������
create Table dept30
AS  
       SELECT deptno, dname
       FROM   dept
       WHERE  0=1; -- (����) 
       
       --WEHRE ������ �����̸� ������ ��� X ���̸� ������ ��� O

-- 4. Column �߰�
ALTER TABLE dept30
ADD(birth Date);

INSERT INTO dept30  VALUES(10,'�߾��б�',sysdate);
INSERT INTO dept30  VALUES(20,'�߾������б�',sysdate);

--5 Column ���� --> ���� data���� ���Դ� �ȵ�
ALTER TABLE dept30
Modify dname varchar2(11)
;

ALTER TABLE dept30
Modify dname varchar2(30)
;

--real data ���߱� --> ���� �������� max�����ٴ� ũ�� �ٿ����Ѵ�. �ּ��� ���� �ٿ����Ѵ�.
ALTER TABLE dept30
Modify dname varchar2(18)
;

--6 Column ����
ALTER TABLE dept30
Drop Column dname;

--7. TBL �� ����
RENAME dept30 TO dept35;

--8. TBL ����
DROP Table dept35;

--9. Truncate
TRUNCATE TABLE DEPT_SECOND;

CREATE TABLE height_info
( studNo        number(5),
    sname       VARCHAR2(20),
  height        number (5,2)
);

CREATE TABLE Weight_info
( studNo        number(5),
    sname       VARCHAR2(20),
  weight        number (5,2)
);

-- INSERT ALL(unconditional INSERT ALL) ��ɹ�
-- ���������� ��� ������ ���Ǿ��� ���� ���̺� ���ÿ� �Է�
-- ���������� �÷� �̸��� �����Ͱ� �ԷµǴ� ���̺��� Į���� �ݵ�� �����ؾ� ��
INSERT ALL
INTO   height_info VALUES (Studno, name, height)
INTO   weight_info VALUES (Studno, name, weight)
SELECT studno, name, height, weight
FROM   student
WHERE  grade >=2
;

DELETE height_info;
DELETE weight_info;

-- INSERT ALL 
-- [WHEN ������1 THEN
-- INTO [table1] VLAUES[(column1, column2,��)]
-- [WHEN ������2 THEN
-- INTO [table2] VLAUES[(column1, column2,��)]
-- [ELSE
-- INTO [table3] VLAUES[(column1, column2,��)]
-- subquery;

-- �л� ���̺��� 2�г� �̻��� �л��� �˻��Ͽ� 
-- height_info ���̺��� Ű�� 170���� ū �л��� �й�, �̸�, Ű�� �Է�
-- weight_info ���̺��� �����԰� 70���� ū �л��� �й�, �̸�, �����Ը� 
-- ���� �Է��Ͽ���
INSERT ALL
WHEN height > 170 Then
    INTO  height_info VALUES(studno, name, height)
WHEN weight > 70 Then
    INTO  weight_info VALUES(studno, name, weight)
SELECT studno, name, height, weight
FROM student
WHERE grade >='2'
;


-- ������ ���� ����
-- UPDATE ��ɹ��� ���̺� ����� ������ ������ ���� ���۾�
-- WHERE ���� �����ϸ� ���̺��� ��� ���� ����
--- Update 
-- ��1) ���� ��ȣ�� 9903�� ������ ���� ������ ���α������� �����Ͽ���
update professor 
set    position ='�α���'
where  profno = 9903
;

--  ��2) ���������� �̿��Ͽ� �й��� 10201�� �л��� �г�� �а� ��ȣ��
--        10103 �й� �л��� �г�� �а� ��ȣ�� �����ϰ� �����Ͽ���
-- 10201  ������  simply 2  102
-- 10103  �迵��  mandu  3  101
update student
set    (grade, deptno) = (
                            select grade, deptno
                            from   student
                            where  studno = 10103 --primary Ű�� where���� ���� single raw�� ���⶧���� =�� �����ϴ�
                         )
where  studno = 10201;

-- ������ ���� ����
-- DELETE ��ɹ��� ���̺� ����� ������ ������ ���� ���۾�
-- WHERE ���� �����ϸ� ���̺��� ��� �� ����

-- ��1) �л� ���̺��� �й��� 20103�� �л��� �����͸� ����
DELETE
FROM  student
WHERE studno = 20103;

---��2) �л� ���̺��� ��ǻ�Ͱ��а��� �Ҽӵ� �л��� ��� �����Ͽ���.
DELETE
FROM student 
WHERE DEPTNO = ( 
                SELECT DEPTNO
                FROM  DEPARTMENT
                WHERE DNAME = '��ǻ�Ͱ��а�'    
               )
;
ROLLBACK;

----------------------------------------------------------------------------------
---- MERGE
--  1. MERGE ����
--     ������ ���� �ΰ��� ���̺��� ���Ͽ� �ϳ��� ���̺�� ��ġ�� ���� ������ ���۾�
--     WHEN ���� ���������� ��� ���̺� �ش� ���� �����ϸ� UPDATE ��ɹ��� ���� ���ο� ������ ����,
--     �׷��� ������ INSERT ��ɹ����� ���ο� ���� ����
------------------------------------------------------------------------------------

-- 1] MERGE �����۾� 
--  ��Ȳ 
-- 1) ������ �������� 2�� Update
-- 2) �赵�� ���� �ű� Insert

CREATE Table professor_temp
AS SELECT * FROM professor
   WHERE position = '����';

UPDATE professor_temp
SET    position = '������'
WHERE  position = '����'
;

INSERT INTO professor_temp
VALUES (9999,'�����','arom21','���Ӱ���',200, sysdate, 10, 101)
;

commit;

-- 2] professor MERGE ���� 
-- ��ǥ : professor_temp�� �ִ� ����   ������ ������ professor Table�� Update
--                         ����� ���� �ű� Insert ������ professor Table�� Insert
-- 1) ������ �������� 2�� Update
-- 2) �赵�� ���� �ű� Insert

MERGE INTO professor p --����
USING professor_temp f --merge�� ����� ���̺�
ON   (p.profno = f. profno)
WHEN MATCHED THEN --pk �� ������ ������ update
        UPDATE SET p.position = f.position
WHEN NOT MATCHED THEN -- pk�� ������ �ű� insert
        INSERT VALUES( f.profno, f.name, f.userid, f.position, f.sal, f.hiredate, f.comm, f.deptno)
 ;       
      
---------------------------------------------------------------------------------
-- Ʈ����� ����  ***
-- ������ �����ͺ��̽����� ����Ǵ� ���� ���� SQL��ɹ��� �ϳ��� ���� �۾� ������ ó���ϴ� ����
-- COMMIT : Ʈ������� �������� ����
--               Ʈ����ǳ��� ��� SQL ��ɹ��� ���� ����� �۾� ������ ��ũ�� ���������� �����ϰ� 
--               Ʈ������� ����
--               �ش� Ʈ����ǿ� �Ҵ�� CPU, �޸� ���� �ڿ��� ����
--               ���� �ٸ� Ʈ������� �����ϴ� ����
--               COMMIT ��ɹ� �����ϱ� ���� �ϳ��� Ʈ����� ������ �����
--               �ٸ� Ʈ����ǿ��� ������ �� ������ �����Ͽ� �ϰ��� ����
 
-- ROLLBACK : Ʈ������� ��ü ���
--                   Ʈ����ǳ��� ��� SQL ��ɹ��� ���� ����� �۾� ������ ���� ����ϰ� Ʈ������� ����
--                   CPU,�޸� ���� �ش� Ʈ����ǿ� �Ҵ�� �ڿ��� ����, Ʈ������� ���� ����
---------------------------------------------------------------------------------

SELECT *
FROM TAB;

DESC student


