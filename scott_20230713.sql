CREATE TABLE ex_type
( c char(10),
  v VARCHAR2(10)
) 
;
-- Table ���� ��ɾ� 
INSERT INTO ex_type
VALUES ('sql','sql')
;

-- �⺻ SELECT ��ɾ�
SELECT *        --������ �÷�
FROM ex_type    --������ ���̺�� (��ü table���)
WHERE c = 'sql' --������ ���� 
;

SELECT *        --������ �÷�
FROM ex_type    --������ ���̺�� (��ü table���)
WHERE v = 'sql' --������ ���� 
;
-- ������ ���� ����
SELECT *
FROM ex_type
WHERE c=v
;
 COMMENT ON COLUMN "SCOTT"."STUDENT"."STUDNO" IS '�й�';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."NAME" IS '�̸�';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."USERID" IS 'USERID';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."GRADE" IS '�г�';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."IDNUM" IS '�ֹι�ȣ';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."BIRTHDATE" IS '�������';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."TEL" IS '��ȭ';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."HEIGHT" IS 'Ű';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."WEIGHT" IS '������';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."DEPTNO" IS '�а���ȣ';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."PROFNO" IS '������ȣ';


?
--ROWID�� �ý����� ���������� ������ �ִ� �ĺ����� ���� ����
--ROWNUM�� ��ȸ���� �� ����, ����, �Ϸù�ȣ�� ������
--1���� �����ؾ� ������� ����,�ſ��߿���. 1���� �������� ������ ���ϴ� ������� ���� �� ����
-- �л����̺�κ��� ��� ROWID�� �й� ���
SELECT rownum, STUDNO, NAME
FROM student
WHERE ROWNUM = 1;
--ROWNUM�� 1���� �����ؾ� �۵��ϴ� ���ѻ����� �ִ�*** �߿�!

--
CREATE TABLE ex_time
(id            NUMBER(2), 
 basictime     TIMESTAMP,
 standardtime  TIMESTAMP WITH TIME ZONE,
 localtime     TIMESTAMP WITH LOCAL TIME ZONE
 );

--sysdate ����Ŭ���� ������ �ִ� ����ð�
 INSERT INTO ex_time
 VALUES(1,  sysdate  , sysdate  ,  systdate) 
 ;
 
 SELECT * FROM EX_TIME;
 
 
 SELECT UPPER('abc')
 FROM  dual;
 
--�л� ���̺��� 1�г� �л��� �˻��Ͽ� �й�, �̸�, �а� ��ȣ�� ���
select studno, name, DEPTNO, grade
from   student
where  grade = '1';

--�л� ���̺��� �����԰� 70kg ������ �л��� �˻��Ͽ� �й�, �̸�, �г�, �а���ȣ, �����Ը� ���
select studno, name, grade, deptno, weight
from   student
where weight <= 70;

--�л� ���̺��� 1�г� �̸鼭 �����԰� 70kg �̻��� �л��� �˻��Ͽ� �̸�, �г�, ������, �а���ȣ�� ���
select name, grade, weight, deptno
from student
where grade='1' and weight >=70;

--�л� ���̺��� 1�г��̰ų� �����԰� 70kg �̻��� �л��� �˻��Ͽ� �̸�, �г�, ������, �а���ȣ�� ���
select name, grade, weight, deptno
from student
where grade = '1' 
or weight >=70;

-- �л� ���̺��� �а���ȣ�� ��101���� �ƴ� �л��� �й��� �̸��� �а���ȣ�� ���
SELECT STUDNO, name, deptno
FROM student
WHERE NOT deptno = 101;

-- �����԰� 50kg���� 70kg ������ �л��� �й�, �̸�, �����Ը� ���
select studno, name, weight
from student
where weight >= 50 
and weight <= 70;

-- between �����ڸ� ����Ͽ� �����԰� 50kg���� 70kg ������ �л��� �й�, �̸�, �����Ը� ���***
select studno, name, weight
from student
where weight between 50 and 70;

-- BETWEEN �л����̺��� 81�⿡�� 83�⵵�� �¾ �л��� �̸��� ��������� ���
select name, BIRTHDATE
from student
where birthdate  between '81/01/01' and '83/12/31';

--101�� �а��� 102�� �а��� 201�� �а� 
-- �л��� �̸�, �г�, �а���ȣ�� ���
select name, grade, deptno
from student
where deptno = 101
or deptno = 102
or deptno = 201;

--in �����ڸ� ����Ͽ� 101�� �а��� 102�� �а��� 201�� �а� ***
-- �л��� �̸�, �г�, �а���ȣ�� ���
select name, grade, deptno
from student
where deptno in(101,102,201);

-- �л� ���̺��� ���� ���衯���� �л��� �̸�, �г�, �а� ��ȣ�� ��� (like 'd%') �κ����
select name, grade, deptno
from student
where name like '��%';

-- �л� ���̺��� ������ ���ڰ�  ���桯�� �л��� �̸�, �г�, �а� ��ȣ�� ���
select name, grade, deptno
from student
where name like '%��';

-- �л� ���̺��� �̸��� 3����, ���� ���衯���� 
-- ������ ���ڰ� ���������� ������ �л��� �̸�, �г�, �а� ��ȣ�� ���
select name, grade, deptno
from student
--where name like '��%��';
where name like '��_��';

-- NULL ����
--EMP TABLE���� ���, �޿�, ���ʽ� ���
select empno, sal, comm
from emp;

--EMP TABLE���� ���, �޿�, ���ʽ�, �޿�+���ʽ� ���
-- ������ : comm�� null�϶� sal+com�� �� null
select empno, sal, comm, sal+comm
from emp ;

--�ذ�å : comm�� null �϶� nvl(***) �Ǵ� nvl2 ��� nvl(�÷���, null���϶� ��ü�� ��)
select empno, sal, comm, sal+nvl(comm, 0)
from emp;

-- comm�� null�ΰ� ��
select *
from emp
where comm is null;
-- where comm =null; �߸��� ����

-- COMM�� NULL�ƴѰ� ��
select *
from emp
where comm is not null;

-- ���� ���̺��� ���������� ���� ������ �̸�, ����, ���������� ���
select  NAME, position, comm
from professor
where comm is null;
-- ���� ���̺��� ������ �̸�, ����,�޿�, �޿�+�������� --> NULL�ذ�
--sal_com�̶�� �������� ���
select name, position, sal, sal+nvl(comm,0) sal_com
from professor;

-- 102�� �а��� �л� �߿��� 
--1�г� �Ǵ� 4�г� �л��� �̸�, �г�, �а� ��ȣ�� ���
select name, grade, deptno
from student
where grade in( 1,4)
and deptno = 102;

select name, grade, deptno
from student
where deptno = 102
and (grade = '1' or grade = '4');

-- 1�г� �̸鼭 �����԰� 70kg �̻��� �л��� ����--> Table stud_heavy
create table stud_heavy3
AS
    select *
    from student
    where grade = 1 
    and weight >=70;
    
-- 1�г� �̸鼭 101�� �а��� �Ҽӵ� �л� --> Table stud_101
create table stud_101
as
    select *
    from student
    where grade = 1 and deptno = 101;
    
-- ���� ������------------------- select Ÿ�԰� ������ ���ƾ� ������ �ȶ�*
----�ߺ�����
select studno, name, userid
from stud_heavy3
union 
select studno, name, userid
from stud_101;

--�ߺ����
select studno, name, userid
from stud_heavy3
union all
select studno, name, userid
from stud_101;

--����
select studno, name, userid
from stud_heavy3
intersect
select studno, name, userid
from stud_101;

-- ���� A(�ڵ���, ������) - B(�ڹ̰�, ������)
select studno, name, userid
from stud_heavy3
minus
select studno, name, userid
from stud_101;

-- ���� B(�ڹ̰�, ������)-A(�ڵ���, ������)  
select studno, name, userid
from stud_101
minus
select studno, name, userid
from stud_heavy3;
-----------------------------------------------------------
--------- DML (������ ���۾�) ****
--------- 1. CRUD : SELECT / INSERT / DELETE / UPDATE
-----------------------------------------------------------------------
Insert into emp values
(1000,'���ؿ�','clerk',7902,to_date('13-07-2023','dd-mm-yyyy'),3000,200,20);
---��ü���ƴ� �Ϻ� ���� ���� ��� ��ȣ �ȿ� �÷��� ��������Ѵ�.
Insert into emp(EMPNO,ENAME,SAL,COMM,DEPTNO)values
(1100,'���Ѻ�',3500,100,10);
Insert into emp(EMPNO,ENAME,SAL,COMM,DEPTNO)values
(1200,'TEST',3500,100,10);


--������ UPDATE 
UPDATE EMP
SET    JOB = 'PRESIDENT'
      ,MGR = 7839 
WHERE  EMPNO = 1100;

---- ���� DELETE
DELETE EMP
WHERE EMPNO = 1200;
--commit�� �ؾ� �ٸ�Ʈ�����ǿ� �ݿ���
COMMIT;

