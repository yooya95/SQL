-- LAST_DAY, NEXT_DAY
-- LAST_DAY �Լ��� �ش� ��¥�� ���� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
-- NEXT_DAY �Լ��� �ش� ���� �������� ��õ� ������ ���� ��¥�� ��ȯ�ϴ� �Լ�

-- ������ ���� ���� ������ ��¥�� �ٰ����� �Ͽ����� ��¥�� ����Ͽ���
SELECT SYSDATE , LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE, '��')
FROM DUAL
;
-- ROUND, TRUNC �Լ�
SELECT TO_CHAR(HIREDATE, 'YY/MM/DD HH24:MI:SS') HIREDATE,
       TO_CHAR(ROUND(HIREDATE, 'dd'), 'YY/MM/DD') round_dd,
       TO_CHAR(ROUND(HIREDATE, 'mm'), 'YY/MM/DD') round_mm,
       TO_CHAR(ROUND(HIREDATE, 'yy'), 'YY/MM/DD') round_yy,
       TO_CHAR(TRUNC(HIREDATE, 'DD'), 'YY/MM/DD') TRUNC_DD,
       TO_CHAR(TRUNC(HIREDATE, 'MM'), 'YY/MM/DD') TRUNC_MM,
       TO_CHAR(TRUNC(HIREDATE, 'YY'), 'YY/MM/YY ') TRUNC_YY
FROM   professor;

-- TO_CHAR �Լ� ���ڿ��� ����ȯ 
-- TO_CHAR �Լ��� ��¥�� ���ڸ� ���ڷ� ��ȯ�ϱ� ���� ���   **
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') YYMMDD,
       TO_CHAR(SYSDATE, 'YY/MM/DD') YYMMDDHH,
        TO_CHAR(SYSDATE, 'YYYY') YYYY,
       TO_CHAR(SYSDATE, 'MM') MM,
       TO_CHAR(SYSDATE, 'DD') DD
FROM   DUAL;


-- �л� ���̺��� ������ �л��� �й�(STUDNO)�� �������(BIRTHDATE) �߿��� ����� ����Ͽ���
SELECT STUDNO, TO_CHAR(BIRTHDATE, 'YY/MM')BIRTHDATE
FROM STUDENT
WHERE NAME = '������'
;

-- 1.���ڸ� ���� �������� ��ȯ
-- 2.���������� �޴� �������� �̸�, �޿�, ��������, 
-- 3.�׸��� �޿��� ���������� ���� ���� 12�� ���� ����� anual_sal(����)���� ���
-- 4. �� ��������� '9,999' (���ڿ� ���� �������) 

SELECT NAME,SAL,COMM, TO_CHAR((SAL+NVL(COMM,0))*12,'9,999') anual_sal
FROM PROFESSOR
where comm is not null
;

SELECT TO_NUMBER('123') --, TO_NUMBER('a123') �����߻�
FROM DUAL
;

--* REVIEW
--  student Table���� �ֹε�Ϲ�ȣ���� ��������� �����Ͽ� ��YY/MM/DD�� ���·� ����Ͽ���
SELECT  IDNUM, SUBSTR(IDNUM,1,6)
        ,IDNUM, TO_DATE(SUBSTR(IDNUM,1,6), 'YYMMDD')
        ,TO_CHAR(TO_DATE(SUBSTR(IDNUM,1,6), 'YYMMDD'),'YY/MM/DD') BIRTHDATE --�̰� ���ٸ� ������ ��
        ,TO_CHAR(TO_DATE(SUBSTR(IDNUM,1,6), 'YY/MM/DD')) BIRTHDATE2
FROM STUDENT
;
-- NVL �Լ��� NULL�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϱ� ���� �Լ�
-- 101�� �а� ������ �̸�, ����, �޿�, ��������, �޿��� ���������� �հ踦 ����Ͽ���. 
-- ��, ���������� NULL�� ��쿡�� ���������� 0���� ����Ѵ�

SELECT NAME, POSITION, SAL, COMM, SAL+NVL(COMM,0)
FROM PROFESSOR
WHERE DEPTNO = 101
;

-- NVL2 �Լ�
-- NVL2 �Լ��� ù ��° �μ� ���� NULL�� �ƴϸ� �� ��° �μ� ���� ����ϰ�,
-- ù ��° �μ� ���� NULL�̸� �� ��° �μ� ���� ����ϴ� �Լ�
-- 102�� �а� �����߿��� ���������� �޴»���� �޿��� ���������� ���� ���� �޿� �Ѿ����� ����Ͽ���. 
-- ��, ���������� ���� �ʴ� ������ �޿��� �޿� �Ѿ����� ����Ͽ�

SELECT NAME, POSITION, SAL, COMM,
        NVL2(COMM, sal+comm,sal) TOTAL --COMM���� NULL �̸�(FALSE) SAL, �ƴϸ�(TRUE) SAL+COMM
FROM   PROFESSOR
WHERE  DEPTNO = 102;

-- NULLIF �Լ�
-- NULLIF �Լ��� �� ���� ǥ������ ���Ͽ� ���� �����ϸ� NULL�� ��ȯ�ϰ�,
--  ��ġ���� ������ ù ��° ǥ������ ���� ��ȯ
-- ��) ���� ���̺��� �̸��� ����Ʈ ���� ����� ���̵��� ����Ʈ ���� ���ؼ�
--      ������ NULL�� ��ȯ�ϰ� 
--      ���� ������ �̸��� ����Ʈ ���� ��ȯ

SELECT NAME, userid, LENGTHB(NAME), LENGTHB(userid),POSITION, SAL, COMM,
       NULLIF(LENGTHB(NAME), LENGTHB(userid) ) NULLIF_RESULT
FROM   PROFESSOR
;

--DECODE �Լ� ***** (���Ǳ��ؼӼ�, ����1, ���1, ����2, ���2, ����3,���3, �⺻���) 
--DECODE �Լ��� ���� ���α׷��� ���� IF���̳� CASE ������ ǥ���Ǵ� ������ �˰����� 
--�ϳ��� SQL ��ɹ����� �����ϰ� ǥ���� �� �ִ� ������ ��� 
--DECODE �Լ����� �� �����ڴ� ��=���� ����

--���� ���̺��� ������ �Ҽ� �а� ��ȣ�� �а� �̸����� ��ȯ�Ͽ� ����Ͽ���. 
--�а� ��ȣ�� 101�̸� ����ǻ�Ͱ��а���, 102�̸� ����Ƽ�̵���а���, 201�̸� �����ڰ��а���, 
--������ �а� ��ȣ�� �������а���(default)�� ��ȯ
SELECT NAME, DEPTNO, 
       DECODE(DEPTNO, 101,'��ǻ�Ͱ��а�', 
                      102,'��Ƽ�̵���а�', 
                      201,'���ڰ��а�', 
                           '�����а�')
FROM PROFESSOR
;

-- CASE �Լ� WHEN ����1 THEN '���' .... ELSE'���' END 
-- CASE �Լ��� DECODE �Լ��� ����� Ȯ���� �Լ� 
-- DECODE �Լ��� ǥ���� �Ǵ� Į�� ���� ��=�� �񱳸� ���� ���ǰ� ��ġ�ϴ� ��쿡�� �ٸ� ������ ��ġ�� �� ������
-- , CASE �Լ������� ��� ����, ���� ����, �� ����� ���� �پ��� �񱳰� ����
-- ���� WHEN ������ ǥ������ �پ��ϰ� ����
-- 8.1.7�������� �����Ǿ�����, 9i���� SQL, PL/SQL���� �Ϻ��� ���� 
-- DECODE �Լ��� ���� �������� ����ü��� �پ��� �� ǥ���� ���

SELECT NAME, DEPTNO,
       CASE WHEN DEPTNO = 101 THEN '��ǻ�Ͱ��а�'
            WHEN DEPTNO = 102 THEN '��Ƽ�̵���а�'
            WHEN DEPTNO = 201 THEN '���ڰ��а�'
            ELSE                   '�����а�'
       END  DEPTNAME
FROM PROFESSOR
;

-- ���� ���̺��� name , deptno , sal , bonus ���
-- �Ҽ� �а��� ���� ���ʽ��� �ٸ��� ����Ͽ� ����Ͽ���. (���� --> bonus)
-- �а� ��ȣ���� ���ʽ��� ������ ���� ����Ѵ�.
-- �а� ��ȣ�� 101�̸� ���ʽ��� �޿��� 10%, 102�̸� 20%, 201�̸� 30%, ������ �а��� 0
SELECT NAME, DEPTNO, SAL ,
       CASE WHEN DEPTNO = 101 THEN SAL * 0.1 
            WHEN DEPTNO = 102 THEN SAL * 0.2 
            WHEN DEPTNO = 201 THEN SAL * 0.3
            ELSE                    0
       END BONUS
FROM PROFESSOR
;

---------------------------------------------------------
---   8��. �׷��Լ� **
---- ���̺��� ��ü ���� �ϳ� �̻��� �÷��� �������� �׷�ȭ�Ͽ�
---   �׷캰�� ����� ����ϴ� �Լ�
---------------------------------------------------------
-- 1) COUNT �Լ�
-- ���̺��� ������ �����ϴ� ���� ������ ��ȯ�ϴ� �Լ�
-- ��1) 101�� �а� �����߿��� ���������� �޴� ������ ���� ����Ͽ���
SELECT COUNT(COMM) --NULL���� ���� ���
FROM   PROFESSOR
WHERE  DEPTNO = 101;
--��2) 101�� �а� �����߿��� ������ ���� ����Ͽ���

SELECT COUNT(*)
FROM  PROFESSOR
WHERE DEPTNO = 101;

--102�� �а� �л����� ������ ��հ� �հ踦 ����Ͽ��� / NULL���� ������ ���� ����
SELECT AVG(WEIGHT), SUM(WEIGHT)
FROM STUDENT
WHERE DEPTNO = 102;

-- ���� ���̺��� �޿��� ǥ�������� �л��� ���
SELECT STDDEV(SAL), VARIANCE(SAL)
FROM PROFESSOR
;
--*�а��� �л����� �ο���, ������ ��հ� �հ踦 ����Ͽ���
SELECT  DEPTNO, COUNT(*) , AVG(WEIGHT), SUM(WEIGHT)
FROM    STUDENT
GROUP BY DEPTNO
;
-- ���� ���̺��� �а����� ���� ���� ���������� �޴� ���� ���� ����Ͽ���
SELECT DEPTNO, COUNT(*)�а���_����_��, COUNT(COMM)��������_����_��
FROM PROFESSOR
GROUP BY DEPTNO
;

-- ���� ���̺��� �а����� ���� ���� ���������� �޴� ���� ���� ����Ͽ���
-- �� �а����� ���� ���� 2�� �̻��� �а��� ���
SELECT DEPTNO, COUNT(*), COUNT(COMM)
FROM PROFESSOR
GROUP BY DEPTNO
HAVING COUNT(*) > 1
;

-- �л� ���� 4���̻��̰� ���Ű�� 168�̻���  �г⿡ ���ؼ� �г�, �л� ��, ��� Ű, ��� �����Ը� ���
-- ��, ��� Ű�� ��� �����Դ� �Ҽ��� �� ��° �ڸ����� �ݿø� �ϰ�, 
-- ��¼����� ��� Ű�� ���� ������ ������������ ����ϰ� 
--   �� �ȿ��� ��� �����԰� ���� ������ ������������ ���
-- + �����߰� 1�г� �̻� 

SELECT GRADE, COUNT(*),
              ROUND(AVG(HEIGHT),1) avg_height,
              ROUND(AVG(WEIGHT),1) avg_weight
FROM STUDENT
WHERE GRADE>1
GROUP BY GRADE
HAVING COUNT(*)>=2 AND AVG(HEIGHT)>=168
ORDER BY  avg_height DESC, avg_weight DESC
;
SELECT grade, COUNT(*), ROUND(AVG(height),1), ROUND(AVG(weight),1)
FROM student
WHERE grade >1
GROUP BY GRADE
HAVING  COUNT(*)>3 AND AVG(height) >167
ORDER BY  ROUND(AVG(HEIGHT),1), ROUND(AVG(WEIGHT),1) DESC
;

-- ROLLUP ������
-- GROUP BY ���� �׷� ���ǿ� ���� ��ü ���� �׷�ȭ�ϰ� �� �׷쿡 ���� �κ����� ���ϴ� ������

-- ��1) �Ҽ� �а����� ���� �޿� �հ�� ��� �а� �������� �޿� �հ踦 ����Ͽ���

SELECT DEPTNO, SUM(SAL)
FROM  PROFESSOR
GROUP BY ROLLUP(DEPTNO)
;
--��2) ROLLUP �����ڸ� �̿��Ͽ� �а� �� ���޺� ���� ��, �а��� ���� ��, ��ü ���� ���� ����Ͽ���
SELECT DEPTNO, POSITION, COUNT(*)
FROM PROFESSOR
GROUP BY ROLLUP (DEPTNO, POSITION)
;

-- CUBE ������ --��ü���� ���� ������
-- ROLLUP�� ���� �׷� ����� GROUP BY ���� ����� ���ǿ� ���� �׷� ������ ����� ������
-- ��1) CUBE �����ڸ� �̿��Ͽ� �а� �� ���޺� ���� ��, �а��� ���� ��, ��ü ���� ���� ����Ͽ���.
SELECT DEPTNO, POSITION, COUNT(*)
FROM   PROFESSOR
GROUP BY CUBE(DEPTNO, POSITION)
;

--------------         Home Work           --------------------
--1. emp Table �� �̸��� �빮��, �ҹ���, ù���ڸ� �빮�ڷ� ���
SELECT upper(ename), lower(ename), INITCAP(ename)
FROM   emp 
;

--2. emp Table ��  �̸�, ����, ������ 2-5���� ���� ��� 
select ename, substr(job,2,4)
from emp
;
--3. emp Table �� �̸�, �̸��� 10�ڸ��� �ϰ� ���ʿ� #���� ä���
select ename, lpad(ename,10,'#')
from emp
;

--4. emp Table ��  �̸�, ����, ������ MANAGER�� �����ڷ� ��� replace ��
select ename, REPLACE(JOB, 'MANAGER','������')
from emp
;
--5. emp Table ��  �̸�, �޿�/7�� ���� ����, �Ҽ��� 1�ڸ�. 10������   �ݿø��Ͽ� ���
SELECT ENAME, SAL/7,ROUND(SAL/7,0), ROUND(SAL/7,1),ROUND(SAL/7,-1)
FROM EMP
;
--6.  emp Table ��  �̸�, �޿�/7�� ���� �����Ͽ� ���
SELECT ENAME, SAL/7, TRUNC(SAL/7), TRUNC(SAL/7,1), TRUNC(SAL/7,-1)
FROM EMP
;
--7. emp Table ��  �̸�, �޿�/7�� ����� �ݿø�,����,ceil,floor
SELECT ENAME, SAL/7, ROUND(SAL/7), TRUNC(SAL/7), CEIL(SAL/7), FLOOR(SAL/7)
FROM EMP
;
--8. emp Table ��  �̸�, �޿�, �޿�/7�� ������
SELECT ENAME, SAL, MOD(SAL,7)
FROM EMP
;
--9. emp Table �� �̸�, �޿�, �Ի���, �Ի�Ⱓ(���� ��¥,��)���,  �Ҽ��� ���ϴ� �ݿø�
SELECT ENAME, SAL, HIREDATE, 
       ROUND(SYSDATE-HIREDATE),
       ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE),0)WORKING_dAY
       
FROM EMP
;

--10.emp Table ��  job �� 'CLERK' �϶� 10% ,'ANALYSY' �϶� 20%  
--'MANAGER' �϶� 30% ,'PRESIDENT' �϶� 40%
--'SALESMAN' �϶� 50% 
--�׿��϶� 60% �λ� �Ͽ� 
-- empno, ename, job, sal, �� �� �޿��λ� ����ϼ���(CASE/Decode�� ���)****
SELECT EMPNO, ENAME, JOB, SAL,
      CASE JOB WHEN  'CLERK'    THEN   SAL*1.1
               WHEN  'ASALYSY'   THEN  SAL*1.2
               WHEN 'MANAGER'    THEN  SAL*1.3
               WHEN  'PRESIDENT' THEN  SAL*1.4
               WHEN  'SALESMAN'  THEN  SAL*1.6
           
           ELSE                        SAL*1.6
      END �޿��λ�
FROM EMP
;

SELECT EMPNO, ENAME, JOB, SAL,
    DECODE (JOB, 'CLERK'  ,    SAL*1.1,
                 'ASALYSY',    SAL*1.2,
                 'MANAGER',    SAL*1.3,
                 'PRESIDENT',  SAL*1.4,
                 'SALESMAN',   SAL*1.5,
                               SAL*1.6
           )�޿��λ�
FROM EMP
;
-----------  Home Work   Group �Լ�   --------------------
-- 1. �ֱ� �Ի� ����� ���� ������ ����� �Ի��� ��� (emp)
SELECT MAX(HIREDATE), MIN(HIREDATE)
FROM EMP
;

-- 2. �μ��� �ֱ� �Ի� ����� ���� ������ ����� �Ի��� ��� (emp)
SELECT DEPTNO, MAX(HIREDATE), MIN(HIREDATE)
FROM EMP
GROUP BY DEPTNO
;

-- 3. �μ���, ������ count & sum[�޿�] , ��¼��� --> �μ���, ������    (emp)
SELECT DEPTNO, JOB, COUNT(*), SUM(SAL)
FROM EMP
GROUP BY DEPTNO , JOB
ORDER BY DEPTNO, JOB
;
-- 4. �μ��� �޿��Ѿ� 3000�̻� �μ���ȣ,�μ��� �ִ�޿�   (emp)
SELECT DEPTNO,  MAX(SAL)�ִ�޿�
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL)>=3000
;

-- 5. ��ü �л��� �Ҽ� �а����� ������, ���� �а� �л��� �ٽ� �г⺰�� �׷����Ͽ�, 
--   �а��� �г⺰ �ο���, ��� �����Ը� ���, 
--  (��, ��� �����Դ� �Ҽ��� ���� ù��° �ڸ����� �ݿø� )  STUDENT
select deptno, grade, count(*), round(avg(weight))
from student
group by deptno, grade
;


-----------  Home Work   Group �Լ� END -------------------



------------------------------------------------------------------------------------
----    9-0.    DeadLock       �������� ���μ������� ������ ����ϰ� �Ǵ� ����    ��ȣ ����..
--------- 
-------------------------------------------------------------------------------------

------- Transaction A (Developer)
----1) Smith
UPDATE  EMP
SET     SAL = SAL *1.1
WHERE   EMPNO =7369
;
--king
UPDATE  EMP
SET     SAL = SAL *1.1
WHERE   EMPNO =7839
;
------- Transaction B (SQL-PLUS)
UPDATE EMP
SET    COMM = 500
WHERE  EMPNO = 7839  
;

UPDATE  EMP
SET     comm = 300
WHERE   EMPNO =7369
;