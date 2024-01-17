---------  9-1. join *** ---------------------------------------------
----------------------------------------------------------------------
-- 1) ������ ����
--  �ϳ��� SQL ��ɹ��� ���� ���� ���̺� ����� �����͸� �������� �ѹ��� ��ȸ�Ҽ� �ִ� ���

-- ex1-1) �й��� 10101�� �л��� �̸��� �Ҽ� �а� ��ȣ�� ����Ͽ���
SELECT STUDNO, NAME, DEPTNO 
FROM STUDENT
WHERE STUDNO =10101
;
-- ex1-2)101�� �а���ȣ�� ������ �а��̸��� ����Ͽ���
SELECT DNAME
FROM DEPARTMENT
WHERE DEPTNO=101
;
-- ex1-3)  [ex1-1] + [ex1-2] �ѹ� ��ȸ  ---> Join
-- �й��� 10101�� �л��� �̸�, �Ҽ� �а���ȣ, �а��̸��� ����Ͽ���
SELECT STUDNO, NAME,
       STUDENT.DEPTNO, DEPARTMENT.DNAME
FROM   STUDENT, DEPARTMENT
WHERE  STUDENT.DEPTNO = DEPARTMENT.DEPTNO;

--�ָŸ�ȣ��(AMBIGUOUSLY)
SELECT STUDNO, NAME, DEPTNO, DNAME
FROM  STUDNET S, DEPARTMET D
WHERE S.DEPTNO = D.DEPTNO
;
--�ָŸ�ȣ��(AMBIGUOUSLY) --> �ذ� : ���� (alias)
SELECT s.studno, s.name, d.deptno, d.dname
FROM  student s, department d
WHERE s.deptno = d.deptno
;

-- ������ �л��� �й�, �̸�, �а� �̸� �׸��� �а� ��ġ�� ���
select s.studno,s.name,d.dname,d.loc
from student s, department d
where s.deptno = d.deptno and s.name = '������'
;

-- �����԰� 80kg�̻��� �л��� �й�, �̸�, ü��, �а� �̸�, �а���ġ�� ���
select s.studno, s.name, s.weight, d.dname, d.loc
from student s, department d
where s.deptno = d.deptno and  s.weight >= 80
;

-- īƼ�� ��  : �� �� �̻��� ���̺� ���� ���� ������ ���� ��� ����, �����ʱ� ���� data ������ ���� ���
-- student     16  department 7  >> īƼ�� ���� �ϰ� �Ǹ� �� ���̺��� �� (112), ��� ����� ���� ������
SELECT s.studno, s.name, d.dname, d.loc, s.weight, d.deptno
FROM   student s, department d
;
SELECT s.studno, s.name, d.dname, d.loc, s.weight, d.deptno
FROM   student s CROSS JOIN department d
;

-- *** equal join
-- ���� ��� ���̺��� ���� Į���� ��=��(equal) �񱳸� ���� ���� ���� ������ ���� �����Ͽ� ����� �����ϴ� ���� ���
--  SQL ��ɹ����� ���� ���� ����ϴ� ���� ���
-- �ڿ������� �̿��� EQUI JOIN
-- ����Ŭ 9i �������� EQUI JOIN�� �ڿ������̶� ���
-- WHERE ���� ������� �ʰ�  NATURAL JOIN Ű���� ���
-- ����Ŭ���� �ڵ������� ���̺��� ��� Į���� ������� ���� Į���� ���� ��, ���������� ���ι� ����

select s.studno,s.name,d.deptno,d.dname
from student s, department d
where s.deptno = d.deptno 
;

-- Natural Join Convert Error
select s.studno,s.name, s.weight, d.dname, d.loc, d.deptno
from student s
     natural join department d
;

-- Natural Join Convert Error �ذ�
select s.studno, s.name, s.weight, d.dname, d.loc, deptno
from student s
     natural join department d
;

--ANSI EQUI JOIN
select s.studno, s.name, s.weight, d.dname, d.loc, d.deptno
from student s inner join department d
on   s.deptno = d.deptno
;

-- NATURAL JOIN�� �̿��Ͽ� ���� ��ȣ, �̸�, �а� ��ȣ, �а� �̸��� ����Ͽ���
select p.profno, p.name, d.dname, deptno
from professor p
     natural join department d
;

-- NATURAL JOIN�� �̿��Ͽ� 4�г� �л��� �̸�, �а� ��ȣ, �а��̸��� ����Ͽ���
SELECT s.name, deptno, d.dname
FROM student s
     natural join department d
WHERE grade = '4'
;

-- JOIN ~ USING ���� �̿��� EQUI JOIN
-- USING���� ���� ��� Į���� ����
-- Į�� �̸��� ���� ��� ���̺��� ������ �̸����� ���ǵǾ� �־����
-- ��1) JOIN ~ USING ���� �̿��Ͽ� �й�, �̸�, �а���ȣ, �а��̸�, �а���ġ��
--       ����Ͽ���
select s.studno, s.name, deptno, dname
from   student s    join department d
                     using(deptno)
;

-- EQUI JOIN�� 4���� ����� �̿��Ͽ� ���� ���衯���� �л����� �̸�, �а���ȣ,�а��̸��� ���
-- 1) WHERE ���� ����� ���
select s.name, d.deptno, d.dname
from student s, department d
where s.deptno = d.deptno 
and s.name like '��%'
;

-- 2) natural join ���� ����� ���
select s.name, deptno, d.dname
from student s
     natural join department d
where s.name like '��%'
;

-- 3) join~using ���� ����� ���
select s.name, deptno, d.dname
from student s  join department d
                 using(deptno)
where s.name like '��%'
;

--4) ansi join (inner join ~ on) --> ���� /ǥ���۾�
select s.name, d.deptno, d.dname
from   student s inner join department d
on     s.deptno = d.deptno
where  s.name like '��%'
;

-------------------------------------------------------------
-- NON-EQUI JOIN **
-- ��<��,BETWEEN a AND b �� ���� ��=�� ������ �ƴ� ������ ���

--��1. ���� ���̺�� �޿� ��� ���̺��� NON-EQUI JOIN�Ͽ� �������� �޿� ����� ����Ͽ���

select  p.profno, p.name, p.sal, s.grade
from professor p, salgrade s
where p.sal between s.losal and s.hisal
;

---------------------------------------------------------------------------
-- OUTER JOIN  ***
-- EQUI JOIN���� ���� Į�� ������ �ϳ��� NULL ������ ���� ����� ����� �ʿ䰡 �ִ� ���
-- OUTER JOIN ���

-- �⺻����  (OUTER JOIN ��� ����) 
SELECT ENAME, JOB, SAL, E.DEPTNO, DNAME, LOC
FROM   EMP E, DEPT D
WHERE  E.DEPTNO = D.DEPTNO
;
-- ������ : ���������� �������� �л��� ���
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO = P.PROFNO
;

-- ������ : ���������� �������� �л��� ��� --> OUTER JOIN �ذ�
-- �л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, ���������� �̸�, ������ ���
-- ��, ���������� �������� ���� �л��̸��� �Բ� ����Ͽ���.

--1) LEFT OUTER JOIN
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO = P.PROFNO(+) 
;
--2) RIGHT OUTER JOIN
-- PROFESSOR(PROFNO:9901)
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO(+) = P.PROFNO 
; 
--3) FULL OUTER JOIN
-- PROFESSOR(PROFNO:9901)
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO(+) = P.PROFNO(+)
;

--- ANSI OUTER JOIN
-- 1. ANSI LEFT OUTER JOIN


SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S
     LEFT OUTER JOIN PROFESSOR P
     ON S.PROFNO = P.PROFNO 
;


-- 2. ANSI RIGHT OUTER JOIN
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S
     RIGHT OUTER JOIN PROFESSOR P
     ON S.PROFNO = P.PROFNO 
;

-- 3. ANSI FULL OUTER JOIN
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S
     FULL OUTER JOIN PROFESSOR P
     ON S.PROFNO = P.PROFNO 
;

---- <<<   FULL OUTER JOIN  >>> -------------------------------
--�л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, �������� �̸�, ������ ���
-- ��, �����л��� �������� ���� ���� �̸� �� 
--  ���������� �������� ���� �л��̸�  �Բ� ����Ͽ���
--  Oracle ���� �� ��
--1) FULL OUTER JOIN
select s. name, s.grade, p.name, p.position
FROM STUDENT S
    FULL OUTER JOIN PROFESSOR P
    ON S.PROFNO = P.PROFNO
;

--2)FULL OUTER ��� (�Ϲ� sql)--->Union
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO = P.PROFNO(+)
UNION
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO(+) = P.PROFNO
;

-------                    SELF JOIN : ������  **           ----------------       
-- �ϳ��� ���̺��� �ִ� Į������ �����ϴ� ������ �ʿ��� ��� ���
-- ���� ��� ���̺��� �ڽ� �ϳ���� �� �ܿ��� EQUI JOIN�� ����
SELECT c.deptno, c.dname, c.college, d.dname college_name
            --�а�            --�к�
FROM department c, department d
WHERE c.college = d.deptno
;

-- SELF JOIN --> �μ� ��ȣ�� 201 �̻��� �μ� �̸��� ���� �μ��� �̸��� ���
-- ��� : xxx�Ҽ��� xxx�к�
select concat(concat(c.dname,'�� �Ҽ��� '), d.dname)
from department c, department d
where c.college = d.deptno 
and c.deptno >= 201
;

select deptno.dname||'�� �Ҽ���'|| org.dname
from   department dep, department org
where dep.college = org.deptno
and dep.deptno >= 201
;

create table salgrade2
   (    grade number(2,0),
        losal number(5,0),
        hisal number(5,0)
    );

INSERT INTO SALGRADE2 VALUES(1, 800, 2000);
INSERT INTO SALGRADE2 VALUES(2, 2001,3500);
INSERT INTO SALGRADE2 VALUES(3, 3501,5500);
COMMIT;


-- 1. �̸�, �����ڸ�(emp TBL)
SELECT w.ename, m.ename ������
FROM emp w, emp m
WHERE W.MGR = M.EMPNO
;
-- 1. �̸�, �����ڸ�(emp TBL)
-- 7902	FORD	ANALYST	7566
-- 7566	JONES	MANAGER	7839
SELECT   w.empno,w.ename, m.empno, m.ename ������ 
--     7902	FORD       7566	JONES
FROM     emp w,         emp m 
WHERE    w.mgr = m.empno;

-- 2. �̸�,�޿�,�μ��ڵ�,�μ���,�ٹ���, ������ --> ��ü����(emp ,dept TBL)
SELECT e.ename, e.sal, d.deptno, d.dname, loc, m.ename
FROM emp e, emp m, dept d
WHERE e.mgr=m.empno(+)
AND   e.deptno =d.deptno
;

-- 3. �̸�,�޿�,���,�μ���,�����ڸ�, �޿��� 2000�̻��� ��� (emp, dept,salgrade2 TBL) >> ������ ��� ��Ű��?
SELECT e.ename, e.sal, s.grade, d.dname, m.ename
FROM emp e, emp m, dept d, salgrade2 s
WHERE e.mgr = m.empno(+)
AND e.deptno = d.deptno
AND e.sal > = 2000 
AND e.sal BETWEEN s.losal AND S.hisal
;

SELECT e.ename, e.sal, s.grade, d.dname, m.ename
FROM emp e, emp m, dept d, salgrade2 s
WHERE e.deptno = d.deptno
AND   e.ename = m.ename
AND  e.sal >= 2000
AND   e.sal BETWEEN s.losal AND s.hisal 
;

-- 4. ���ʽ��� �޴� ����� ���Ͽ� �̸�,comm, �μ���,��ġ�� ����ϴ� SELECT ������ �ۼ� (emp ,dept TBL)
SELECT e.ename,e.comm, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.comm is not null
;


-- 5. ���, �����, �μ��ڵ�, �μ����� �˻��϶�. ������������ ������������(emp ,dept TBL)
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY e.ename
;
-----------------------------------------------------------------
----- SUB Query   ***
-- �ϳ��� SQL ��ɹ��� ����� �ٸ� SQL ��ɹ��� �����ϱ� ���� 
-- �� �� �̻��� SQL ��ɹ��� �ϳ��� SQL��ɹ����� �����Ͽ�
-- ó���ϴ� ���
-- ���� 
-- 1) ������ ��������
-- 2) ������ ��������
-------------------------------------------------------------------
--1. ��ǥ : ���� ���̺��� '������' ������ ������ ������ ��� ������ �̸� �˻�
-- 1-1 ���� ���̺��� ���������� ������ ���� �˻� SQL ��ɹ� ����
    select position
    from professor
    where name = '������'
    ;
-- 1-2 ���� ���̺��� ���� Į������ 1���� ���� ��� ���� ������ ������ ���� ���� �˻� ��ɹ� ����
    select name, position
    from professor
    where position = '���Ӱ���'
    ;
--1. ��ǥ : ���� ���̺��� '������' ������ ������ ������ ��� ������ �̸� �˻� >> sub query
    select name, position
    from professor
    where position = (
                        select position
                        from professor
                        where name = '������' 
                      )
    ;

-- ���� 
-- 1) ������ ��������
--  ������������ �� �ϳ��� �ุ�� �˻��Ͽ� ���������� ��ȯ�ϴ� ���ǹ�
--  ���������� WHERE ������ ���������� ����� ���� ��쿡�� �ݵ�� ������ �� ������ �� 
--  �ϳ��� ����ؾ���

--  ��1) ����� ���̵� ��jun123���� �л��� ���� �г��� �л��� �й�, �̸�, �г��� ����Ͽ���
    select studno, name, grade
    from student
    where grade = ( 
                     select grade
                     from student
                     where userid = 'jun123'
                   )
    ;
    
--  ��2)  101�� �а� �л����� ��� �����Ժ��� �����԰� ���� �л��� �̸�, �г� , �а���ȣ, �����Ը�  ���
--  ���� : �а��� ���
    select name, grade, deptno, weight
    from student
    where weight < ( 
                    select  avg(weight)
                    from student
                    where deptno = '101'
                    )
    order by deptno
    ;
    
--  ��3) 20101�� �л��� �г��� ����, Ű�� 20101�� �л����� ū �л��� 
-- �̸�, �г�, Ű�� ����Ͽ���
--  ���� : �а��� ���
    select name, grade, height
    from student
    where grade = ( select grade
                    from student
                    where studno = '20101'
                )
    and height >  (
                    select height
                    from student
                    where studno = '20101'
                    )
   order by deptno
   ;
   
-- ��4) 101�� �а� �л����� ��� �����Ժ��� �����԰� ���� �л��� �̸�, �а���ȣ, �����Ը� ����Ͽ���
--  ���� : �а��� ���
    select name, deptno, weight
    from student
    where weight < (
                    select avg(weight)
                    from student
                    where deptno = '101'
                    )
    order by deptno
    ;
    
-- 2) ������ ��������
-- ������������ ��ȯ�Ǵ� ��� ���� �ϳ� �̻��� �� ����ϴ� ��������
-- ���������� WHERE ������ ���������� ����� ���� ��쿡�� ���� �� �� ������ �� ����Ͽ� ��
-- ���� �� �� ������ : IN, ANY, SOME, ALL, EXISTS
-- 1) IN               : ���� ������ �� ������ ���������� ����߿��� �ϳ��� ��ġ�ϸ� ��, ��=���񱳸� ����
-- 2) ANY, SOME  : ���� ������ �� ������ ���������� ����߿��� �ϳ��� ��ġ�ϸ� ��
-- 3) ALL             : ���� ������ �� ������ ���������� ����߿��� ��簪�� ��ġ�ϸ� ��, 
-- 4) EXISTS        : ���� ������ �� ������ ���������� ����߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��

-- 1.  IN �����ڸ� �̿��� ���� �� ��������
--"single-row subquery returns more than one row"
select name, grade, deptno
from student
where deptno = (
                select deptno
                from department
                where college = 100
               ) ;
               
select name, grade, deptno
from student
where deptno in (101,102 ) ;
               
select name, grade, deptno
from student
where deptno in (
                select deptno
                from department
                where college = 100
               ) ;

--  2. ANY �����ڸ� �̿��� ���� �� ��������
-- ��)��� �л� �߿��� 4�г� �л� �߿��� Ű�� ���� ���� �л����� Ű�� ū �л��� �й�, �̸�, Ű�� ����Ͽ���
select studno, name, height
from student
where height > any (
                    --175,176,177 -->min ����  �� �� ��ͺ��ٵ� ū�� 
                    select height
                    from student
                    where grade = '4'
                    );

-- 3. ALL �����ڸ� �̿��� ���� �� ��������
select studno, name, height
from student
where height > all (
                    --175,176,177 -->min ���� �� ��� �� ��ü���� ū ��
                    select height
                    from student
                    where grade = '4'
                    );

--4. EXISTS �����ڸ� �̿��� ���� �� ��������*
-- ���������� �˻��� ����� �ϳ��� �����ϸ� �������� �������� ���� �Ǵ� ������
SELECT PROFNO, NAME, SAL, COMM, POSITION
FROM   PROFESSOR
WHERE  EXISTS (
                SELECT POSITION
                FROM   PROFESSOR
                WHERE  COMM IS NOT NULL
              ) ;
              
              
-- ��1)  ���������� �޴� ������ �� ���̶� ������ 
--       ��� ������ ���� ��ȣ, �̸�, �������� �׸��� �޿��� ���������� ��(NULLó��)�� ���             

SELECT PROFNO, NAME, SAL, COMM, SAL+NVL(COMM,0)
FROM  PROFESSOR
WHERE EXISTS (
                SELECT PROFNO
                FROM   PROFESSOR
                WHERE  COMM IS NOT NULL
            )
;

-- ��2) �л� �߿��� ��goodstudent���̶�� ����� ���̵� ������ 1�� ����Ͽ���
SELECT 1 USERID_EXIST
FROM DUAL
WHERE NOT EXISTS (
              SELECT USERID
              FROM   STUDENT
              WHERE  USERID = 'goodstudent'
                )
;