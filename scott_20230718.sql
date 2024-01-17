-- �л� ���̺��� �г��� ������(������)������ �����Ͽ� �̸�, �г�, ��ȭ��ȣ�� ���
SELECT name, grade , tel
FROM   student
-- ORDER BY grade ASC   -- Default ASC
ORDER BY grade DESC  
;
-- ��� ����� �̸��� �޿� �� �μ���ȣ�� ����ϴµ�,  
-- �μ� ��ȣ�� ����� ������ ���� �޿��� ���ؼ��� ������������ ����
SELECT    ename, sal , deptno
FROM      emp
ORDER BY  deptno, sal desc;

-- �μ� 10�� 30�� ���ϴ� ��� ����� �̸��� �μ���ȣ�� �̸��� ���ĺ� ������ 
-- ���ĵǵ��� ���ǹ�(emp) 
-- Remind
SELECT     ename,deptno
FROM       emp
WHERE      deptno IN (10,30)
ORDER BY   ename;

-- HW1
-- 1982�⿡ �Ի��� ��� ����� �̸��� �Ի����� ���ϴ� ���ǹ�
SELECT ename,hiredate
FROM   emp
--WHERE  hiredate LIKE '82%';
--WHERE  TO_CHAR(hiredate,'yymmdd') LIKE '82%';
--WHERE hiredate BETWEEN '82/01/01' AND '82/12/31'
WHERE   SUBSTR(hiredate,1,2) = 82;

SELECT ename, hiredate
FROM emp
WHERE hiredate LIKE '82%'
;

-- HW2
-- ���ʽ��� �޴� ��� ����� ���ؼ� �̸�, �޿� �׸��� ���ʽ��� ����ϴ� ���ǹ��� ����. 
-- �� �޿��� ���ʽ��� ���ؼ� �޿�/���ʽ������� �������� ����
SELECT ename,sal, comm
FROM   emp
WHERE  ( comm is not null AND comm <> 0)
ORDER BY sal DESC, comm DESC;

-- HW3
-- ���ʽ��� �޿��� 20% �̻��̰� �μ���ȣ�� 30�� ��� ����� ���ؼ� 
-- �̸�, �޿� �׸��� ���ʽ�, �μ���ȣ�� ����ϴ� ���ǹ��� �����϶�
SELECT ename,sal, comm,deptno
FROM   emp
WHERE  comm >= sal*0.2 AND deptno=30;



-----------------------------------------------------
---    07. �Լ�(�����Լ�)
-----------------------------------------------------
-- ��ҹ��� ��ȯ
SELECT ename , UPPER(ENAME),LOWER(ENAME), INITCAP(ENAME)
FROM EMP;
--�ҹ��ڷ� �����ֱ�
SELECT ename , SAL, DEPTNO
FROM EMP
--WHERE LOWER(ename) = 'scott'
WHERE UPPER(ename) = 'SCOTT' 
;
-- �л� ���̺��� �й��� ��20101���� �л��� ����� ���̵� 
-- �ҹ��ڿ� �빮�ڷ� ��ȯ�Ͽ� ���
SELECT userid , LOWER(userid) , UPPER(userid)
FROM   student
WHERE studno = 20101
;
-- ���ڿ� ���� 
-- UTF-8 --> 3��
-- ���� �λ�1�� --> �ѱ� 3(3Byte��) + 1(1Byte)
SELECT DNAME , LENGTH (DNAME), LENGTHB(DNAME)
FROM DEPT;

--�ѱ� ���ڿ� ����  Test   --> Insert �� �� ǥ�� utf-8
INSERT INTO DEPT VALUES (59,'�濵������','������');

----------------------------------------------------------
-------               �����Լ�               --------------
----------------------------------------------------------
-- * concat
SELECT concat(name, '�� ��å�� ')
FROM professor
;
SELECT name||'�� ��å�� '
FROM professor
;
SELECT concat(concat(name, '�� ��å�� '),position)
FROM professor
;

--- �л� ���̺��� 1�г� �л��� �ֹε�� ��ȣ���� ������ϰ� �¾ ���� �����Ͽ� 
--- �̸�, �ֹι�ȣ, �������, �¾ ���� ����Ͽ���
---  SUBSTR ***
SELECT name , idnum , SUBSTR(idnum , 1,6) birth_date  , SUBSTR(idnum ,3,2) birth_mon
FROM   student
WHERE grade = 1;

-- INSTR �Լ� *
-- ���ڿ��߿��� ����ڰ� ������ Ư�� ���ڰ� ���Ե� ��ġ�� ��ȯ�ϴ� �Լ�
-- �а�  ���̺��� �μ� �̸� Į������ ������ ������ ��ġ�� ����Ͽ���
SELECT  dname , INSTR(dname , '��')
FROM    department; 

-- LPAD, RPAD �Լ� *
-- LPAD�� RPAD �Լ��� ���ڿ��� ������ ũ�Ⱑ �ǵ��� ���� �Ǵ� �����ʿ� ������ ���ڸ� �����ϴ� �Լ�
-- �������̺��� ���� Į���� ���ʿ� ��*�� ���ڸ� �����Ͽ� 10����Ʈ�� ����ϰ� 
-- ���� ���̵� Į���� �����ʿ� ��+�����ڸ� �����Ͽ� 12����Ʈ�� ���
SELECT position , LPAD(position , 10,'*') lpad_position,
        userid ,  RPAD(userid,12,'+')     rpad_userid
FROM    professor;

SELECT position , LPAD(position , 10,'-') lpad_position,
        userid ,  RPAD(userid,12,'%')     rpad_userid
FROM    professor;

--LTRIM, RTRIM �Լ� *
--LTRIM�� RTRIM �Լ��� ���ڿ����� Ư�� ���ڸ� �����ϱ� ���� ���
--�Լ��� �μ����� ������ ���ڸ� �������� ������ ���ڿ��� �յ� �κп� �ִ� ���� ���ڸ� ����
SELECT LTRIM('  abcdefg  ',' ') FROM dual;
SELECT RTRIM('  abcdefg  ',' ') FROM dual;
SELECT LTRIM('**abcdefg  ','*') FROM dual;

--  �а� ���̺��� �μ� �̸��� ������ ������ �������� �����Ͽ� ����Ͽ���
SELECT dname , RTRIM(dname, '��')
FROM   department;


---------------------------------------------------------
-------- ���� �Լ� *** ------------------------------------
---------------------------------------------------------
--1) ROUND �Լ�
--   ������ �ڸ� ���Ͽ��� �ݿø��� ��� ���� ��ȯ�ϴ� �Լ�
-- ���� ���̺��� 101�а� ������ �ϱ��� ���(�� �ٹ����� 22��)�Ͽ� �Ҽ��� ù° �ڸ��� 
-- ��° �ڸ����� �ݿø� �� ���� �Ҽ��� ���� ù° �ڸ����� �ݿø��� ���� ����Ͽ���
SELECT name ,sal ,sal/22,ROUND(sal/22) ,ROUND(sal/22, 2) , ROUND(sal/22, -1)
FROM    professor
WHERE  deptno = 101;

-- 2)TRUNC �Լ�
-- ������ �Ҽ��� �ڸ��� ���ϸ� ������ ��� ���� ��ȯ�ϴ� �Լ�
-- ���� ���̺��� 101�а� ������ �ϱ��� ���(�� �ٹ����� 22��)�Ͽ�
-- �Ҽ��� ù° �ڸ��� ��° �ڸ����� ���� �� ���� 
-- �Ҽ��� ���� ù° �ڸ����� ������ ���� ���
SELECT name , sal , sal/22 , TRUNC(sal/22) , TRUNC(sal/22,2) , TRUNC(sal/22,-1)
FROM    professor
WHERE deptno = 101; 

-- 3) MOD �Լ� 
--    MOD �Լ��� ������ �����Ŀ� �������� ����ϴ� �Լ� 
-- ���� ���̺��� 101�� �а� ������ �޿��� ������������ ���� �������� ����Ͽ� ����Ͽ���
SELECT   name , sal , comm , MOD(sal , comm)
FROM     professor
WHERE   deptno = 101;

-- 4) CEIL, FLOOR �Լ�
-- CEIL �Լ��� ������ ���ں��� ũ�ų� ���� ���� �߿��� �ּ� ���� ����ϴ� �Լ�
-- FLOOR�Լ��� ������ ���ں��� �۰ų� ���� ���� �߿��� �ִ� ���� ����ϴ� �Լ�
-- 19.7���� ū ���� �߿��� ���� ���� ������ 12.345���� ���� ���� �߿��� ���� ū ������ ����Ͽ���
SELECT CEIL(19.7) , FLOOR(12.345), FLOOR(-12.345)
FROM    dual;


---------------------------------------------------------
-------- ���� �Լ� *** ------------------------------------
---------------------------------------------------------
-- 1) ��¥ + ���� = ��¥ (��¥�� �ϼ��� ����)
-- ���� ��ȣ�� 9908�� ������ �Ի����� �������� �Ի� 30�� �Ŀ� 60�� ���� ��¥�� ���
SELECT name , hiredate , hiredate+30 , hiredate+60
FROM   professor
WHERE profno = 9908;
-- 2) ��¥ - ���� = ��¥ (��¥�� �ϼ��� ����)
-- 3) ��¥ - ��¥=  �ϼ� (��¥�� ��¥�� ����)
-- 4) SYSDATE �Լ�
--     SYSDATE �Լ��� �ý��ۿ� ����� ���� ��¥�� ��ȯ�ϴ� �Լ��μ�, �� �������� ��ȯ
SELECT sysdate 
FROM    dual;

-- 5) MONTHS_BETWEEN : date1�� date2 ������ ���� ���� ���
--     ADD_MONTHS        : date�� ���� ���� ���� ��¥ ���
--     MONTHS_BETWEEN�� ADD_MONTHS �Լ��� �� ������ ��¥ ������ �ϴ� �Լ� 
--     �Ի����� 120���� �̸��� ������ ������ȣ, �Ի���, �Ի��Ϸ� ���� �����ϱ����� ���� ��,
--     �Ի��Ͽ��� 6���� ���� ��¥�� ����Ͽ���
SELECT profno , hiredate,
       MONTHS_BETWEEN(SYSDATE,hiredate)   working_day,
       ADD_MONTHS(hiredate , 6)  hire_6after
FROM   professor
WHERE MONTHS_BETWEEN(SYSDATE,hiredate)  < 120
;

---------------------------------------------------------
----   HW  10
----------------------------------------------------------
--1. salgrade ������ ��ü ����
SELECT  * FROM  salgrade;
--2. scott���� ��밡���� ���̺� ����
SELECT * FROM tab;
--3. emp Table���� ��� , �̸�, �޿�, ����, �Ի��� ��ȸ
SELECT empno,ename,sal,job,hiredate 
FROM    emp;
--4. emp Table���� �޿��� 2000�̸��� ��� �� ���� ���, �̸�, �޿� �׸� ��ȸ
 SELECT empno,ename,sal 
 FROM    emp 
 WHERE  sal<2000;
--5. emp Table���� 80/02���Ŀ� �Ի��� ����� ����  ���,�̸�,����,�Ի��� 
SELECT  empno,ename,job,hiredate
FROM     emp 
WHERE   hiredate > '80/02/01';
--  WHERE  hiredate BETWEEN '80/02/01' AND sysdate;

SELECT ename, HIREDATE
FROM   emp 
Where  TO_CHAR(hiredate , 'MM') = '02';

--6. emp Table���� �޿��� 1500�̻��̰� 3000���� ���, �̸�, �޿�  ��ȸ
--    ( AND   &    BETWEEN)
SELECT  empno,ename,sal
FROM    emp 
WHERE   sal >= 1500 
AND     sal <= 3000; 

SELECT  empno,ename,sal
FROM    emp 
WHERE   sal BETWEEN  1500 AND  3000; 

--7. emp Table���� ���, �̸�, ����, �޿� ��ȸ [ �޿��� 2500�̻��̰�  ������ MANAGER�� ���]
SELECT empno, ename,job, sal 
FROM   emp 
WHERE  sal>=2500 
AND    job='MANAGER'
;
--8. emp Table���� �̸�, �޿�, ���� ��ȸ 
   -- [�� ������  ���� = (�޿�+��) * 12  , null�� 0���� ����]
SELECT ename,sal,(sal+nvl(comm,0))*12 ����
FROM   emp;   
--9. emp Table����  81/02 ���Ŀ� �Ի��ڵ��� xxx�� �Ի����� xxX
--  [ ��ü Row ��� ] --> 2���� ��� ��
SELECT ename||'�� �Ի����� '||hiredate||'�̴�'
FROM    emp 
WHERE  hiredate >='81/02/01';

SELECT CONCAT(CONCAT(ename, '�� �Ի�����   '),hiredate)
FROM    emp 
WHERE  hiredate >='81/02/01';

--10.emp Table���� �̸��ӿ� T�� �ִ� ���,�̸� ���
SELECT empno , ename 
FROM   emp 
WHERE  ename like '%T%';



















