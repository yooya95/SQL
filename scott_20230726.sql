------------------------------------------------------------------------
---    PL/SQL�� ����
---   1. Oracle���� �����ϴ� ���α׷��� ����� Ư���� ������ SQL�� Ȯ��
---   2. PL/SQL Block������ SQL�� DML(������ ���۾�)���� Query(�˻���)��, 
---      �׸��� ������ ���(IF, LOOP) ���� ����Ͽ� ���������� ���α׷����� �����ϰ� 
---      �� ������  Ʈ����� ���
---
---   1) ���� 
---      ���α׷� ������ ���ȭ : ������ ���α׷��� �ǹ��ְ� �� ���ǵ� ���� Block ����
---      ��������  : ���̺�� Į���� ������ Ÿ���� ������� �ϴ� �������� ������ ����
---      ����ó��  : Exception ó�� ��ƾ�� ����Ͽ� Oracle ���� ������ ó��
---      �̽ļ�    : Oracle�� PL/SQL�� �����ϴ¾ ȣ��Ʈ�ε� ���α׷� �̵� ����
---      ���� ��� : ���� ���α׷��� ������ ���
 
------------------------------------------------------------------------
create or replace Function func_sal
   (p_empno in number) 
  RETURN number ----��MUST �ʼ���!
-- �Լ��� return ���� �־����, return ���� ������ �Ѱ�!
-- ������ ���� (FUCTION�� DML�� ���� ���� �� : �ϱ��� �ʿ� ���� ������ٴϸ鼭 ������
IS
    vsal emp.sal%type; --emp table�� sal�� ���� Ÿ��
BEGIN
    UPDATE emp SET sal=sal*1.1 --10%�λ�
    WHERE empno=p_empno;
    commit;
    SELECT sal INTO vsal --��ȸ�ϱ� ���� ������ ��ȯ�ϴ� ��Ŀ����
    FROM emp
    WHERE empno=p_empno;
    RETURN vsal;
END;
------------------------------------------------------------------------
--  Function  :  �ϳ��� ���� ������� �Ǵ� ��쿡 Function�� ����
--  ��1) Ư���� ���� ������ 7%�� ����ϴ� Function�� �ۼ�
---   ���� 1: Function  -->   tax 
---   ���� 2: parameter   -->   p_num  (�޿�)
---   ���� 3: ����� ���� 7% ���� ������

CREATE OR REPLACE FUNCTION tax
    (p_num in number)
RETURN number
IS
    v_tax number ;
BEGIN 
    v_tax := p_num * 0.07 ;  --:= =�� ������
    RETURN(v_tax) ;
END ;

SELECT tax(100) FROM dual;
SELECT tax(200) FROM dual;

--emp ���̺� tax �Լ� ����
SELECT empno, ename, sal, tax(sal)
FROM emp
;

------------------------------------------------------------
--  EMP ���̺��� ����� �Է¹޾� �ش� ����� �޿��� ���� ������ ����.
-- �޿��� 2000 �̸��̸� �޿��� 6%, 
-- �޿��� 3000 �̸��̸� 8%, 
-- 5000 �̸��̸� 10%, 
-- �� �̻��� 15%�� ����
--- FUNCTION  emp_tax3
-- 1) Parameter : ��� p_empno
--      ����     :   v_sal(�޿�)
--                     v_pct(������갪)
-- 2) ����� ������ �޿��� ����
-- 3) �޿��� ������ ���� ��� 
-- 4) ��� �� �� Return   number
-------------------------------------------------------------
-- %TYPE Attribute�� ���̺��� Į���� ���� ������ Ÿ���� ��Ȯ�� ��
--���ų�, Į���� ���� ������ Ÿ���� �߰��� ����Ǵ� ��쿡 ������
--�ϴ�
CREATE OR REPLACE FUNCTION emp_tax3
(p_empno    IN        emp.empno%TYPE)  --1)PARAMETER : ���
 RETURN     number
IS 
 v_sal          emp.sal%TYPE;
 v_pct          NUMBER(5,2); -- ��ü�� 5�ڸ� �Ҽ��� 2�ڸ�
 
BEGIN
--2) ����� ������ �޿��� ����
SELECT sal
INTO   v_sal
FROM   emp
WHERE  empno = p_empno;

-- 3) �޿��� ������ ���� ���

IF      v_sal < 2000 THEN
        v_pct := (v_sal*0.06) ;
ELSIF   v_sal < 3000 THEN
        v_pct := (v_sal*0.08) ;
ELSIF   v_sal < 5000 THEN
        v_pct := (v_sal*0.10) ;
ELSE    v_pct := (v_sal* 0.15);
END IF;
    RETURN(v_pct);
    --  v_tax := v_sal * v_pct;
    -- RETURN (v_tax);
END emp_tax3
;
    
SELECT  ename, sal, EMP_TAX3(empno)emp_rate
FROM    emp;
    
-----------------------------------------------------
--  Procedure up_emp ���� ���
-- SQL> EXECUTE up_emp(1200);  -- ��� 
-- ���       : �޿� �λ� ����
--               ���۹���
--   ����     :   v_job(����)
--                  v_pct(����)

-- ���� 1) job = SALE����         v_pct : 10
--           IF              v_job LIKE 'SALE%' THEN
--     2)            MAN              v_pct : 7  
--     3)                                v_pct : 5
--   job�� ���� �޿� �λ��� ����  sal = sal+sal*v_pct/100
-- UPDATE
-- Ȯ�� : DB -> TBL
-----------------------------------------------------
CREATE OR REPLACE PROCEDURE up_emp
    (p_empno    IN  emp.empno%TYPE)
    
IS
    v_job    emp.job%TYPE;
    v_pct    number(3);
    
BEGIN
    SELECT          JOB
    INTO            v_job
    FROM            emp
    WHERE           empno = p_empno ;

    IF          v_job LIKE 'SALE%' THEN
                v_pct := 10;
    ELSIF       v_job LIKE 'MAN%' THEN
                v_pct := 7;
    ELSE
                v_pct :=5;
    END IF;
    
    UPDATE      emp
    SET         sal = sal+sal*v_pct/100
    WHERE       empno = p_empno;
END up_emp;

--TURNER
-- SELECT up_emp(7844) FROM dual; --> ���� ���� ���ν������� �ؾ���


---------------------------------------------------------
-- PROCEDURE Delete_emp
-- SQL> EXECUTE Delete_emp(5555);
-- �����ȣ : 5001,5002,5003
-- ����̸� : 55
-- �� �� �� : 81/12/03
-- ������ ���� ����
--  1. Parameter : ��� �Է�
--  2. ��� �̿��� �����ȣ ,����̸� , �� �� �� ���
--  3. ��� �ش��ϴ� ������ ���� 
----------------------------------------------------------
CREATE OR REPLACE PROCEDURE delte_emp
(p_empno emp.empno%TYPE)

IS
v_empno     emp.empno%TYPE;
v_ename     emp.ename%TYPE;
v_hiredate  emp.hiredate%TYPE;

BEGIN
SELECT empno, ename, hiredate
INTO v_empno, v_ename, v_hiredate
FROM emp
WHERE empno = p_empno ;
DELETE 
FROM emp
WHERE empno = p_empno ;
END;


---------------------------------------------------------
-- �ൿ���� : �μ���ȣ �Է� �ش� emp ����  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch(70);
--  ��ȸȭ�� :    ���    : 5555
--              �̸�    : ȫ�浿


CREATE OR REPLACE PROCEDURE DeptEmpSearch1
    (p_deptno    IN  emp.deptno%TYPE)   --�μ���ȣ�� �Է�

IS
    v_empno  emp.empno%type;        --���
     v_ename emp.ename%type;        --��

BEGIN 
    DBMS_OUTPUT.ENABLE;
    SELECT       empno, ename
    INTO         v_empno, v_ename
    FROM         emp
    WHERE        deptno = p_deptno ;
    DBMS_OUTPUT.PUT_LINE('��� : ' || v_empno);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || v_ename);
END DeptEmpSearch1;


EXECUTE DeptEmpSearch1(40);


---------------------------------------------------------
-- �ൿ���� : �μ���ȣ �Է� �ش� emp ����  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch2(75);
--  ��ȸȭ�� :    ���    : 5555
--              �̸�    : ȫ�浿
-- %ROWTYPE�� �̿��ϴ� ���

CREATE OR REPLACE PROCEDURE DeptEmpSearch2
    (p_deptno    IN  emp.deptno%TYPE)   --�μ���ȣ�� �Է�

IS
    v_empno  emp%ROWTYPE ;    
--  v_empno emp.empno%type;
--  v_ename emp.ename%type;
      
BEGIN 
    DBMS_OUTPUT.ENABLE;
    SELECT    *
    INTO      v_emp
    FROM      emp
    WHERE     deptno = p_deptno ;
    DBMS_OUTPUT.PUT_LINE('��� : ' || v_emp.empno);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || v_emp.ename);
END DeptEmpSearch2;

---------------------------------------------------------
-- �ൿ���� : �μ���ȣ �Է� �ش� emp ����  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch3(10);
--  ��ȸȭ�� :    ���    : 5555
--              �̸�    : ȫ�浿
-- %ROWTYPE�� �̿��ϴ� ���
-- EXCEPTION �̿��ϴ� ���

CREATE OR REPLACE PROCEDURE DeptEmpSearch3
    (p_deptno IN emp.deptno%type)
IS
    v_emp  emp%ROWTYPE ;    
--  v_empno emp.empno%type;
--  v_ename emp.ename%type;
      
BEGIN 
    DBMS_OUTPUT.ENABLE;
    SELECT empno, ename
    INTO v_emp
    FROM emp
    WHERE deptno = p_deptno;
    DBMS_OUTPUT.PUT_LINE('��� : ' || v_emp.empno);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || v_emp.ename);

-- MULTI ROW EROOR --> ���� ������ �䱸�� �ͺ��� ���� ���� ���� ����
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERR OCDE1 : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('ERR CODE2 : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERR MESSAGE: ' || SQLERRM);

END  DeptEmpSearch3;

--------------------------------------------------------------------------------
----  ***    cursor    ***
--- 1.���� : Oracle Server�� SQL���� �����ϰ� ó���� ������ �����ϱ� ���� 
--        "Private SQL Area" �̶�� �ϴ� �۾������� �̿�
--       �� ������ �̸��� �ο��ϰ� ����� ������ ó���� �� �ְ� ���ִµ� �̸� CURSOR
-- 2. ����  :    Implicit(��������) CURSOR -> DML���� SELECT���� ���� ���������� ���� 
--                 Explicit(�������) CURSOR -> ����ڰ� �����ϰ� �̸��� �����ؼ� ��� 
-- 3.attribute
--   1) SQL%ROWCOUNT : ���� �ֱ��� SQL���� ���� ó���� Row ��
--   2) SQL%FOUND    : ���� �ֱ��� SQL���� ���� ó���� Row�� ������ �� ���̻��̸� True
--   3) SQL%NOTFOUND : ���� �ֱ��� SQL���� ���� ó���� Row�� ������ ������True
-- 4. 4�ܰ� ** 
--     1) DECLARE �ܰ� : Ŀ���� �̸��� �ο��ϰ� Ŀ�������� ������ SELECT���� ���������ν� CURSOR�� ����
--     2) OPEN �ܰ� : OPEN���� �����Ǵ� ������ �����ϰ�, SELECT���� ����
--     3) FETCH �ܰ� : CURSOR�κ��� Pointer�� �����ϴ� Record�� ���� ������ ����
--     4) CLOSE �ܰ� : Record�� Active Set�� �ݾ� �ְ�, �ٽ� ���ο� Active Set������� OPEN�� �� �ְ� ����
--------------------------------------------------------------------------------
---------------------------------------------------------
-- EXECUTE ���� �̿��� �Լ��� �����մϴ�.
-- SQL>EXECUTE show_emp3(7900);
---------------------------------------------------------

CREATE OR REPLACE PROCEDURE show_emp3
(p_empno   IN  emp.empno%TYPE)

IS
    --1. DECLARE �ܰ�
    CURSOR emp_cursor IS
    SELECT ename, job, sal
    FROM   emp
    WHERE  empno LIKE p_empno||'%';
    
    v_ename emp.ename%TYPE;
    v_sal   emp.sal%TYPE;
    v_job   emp.job%TYPE;

BEGIN
   --2. open �ܰ�
   OPEN emp_cursor;
    DBMS_OUTPUT.PUT_LINE('�̸�    ' || '����' || '�޿�');
    DBMS_OUTPUT.PUT_LINE('-------------------------');
  LOOP
   --3. FETCH �ܰ� --> �ϳ��� ����
   FETCH emp_cursor INTO v_ename, v_job, v_sal;
   EXIT WHEN emp_cursor%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE(v_ename ||'   '|| v_job||'  '||v_sal);
  END LOOP;
    DBMS_OUTPUT.PUT_LINE(emp_cursor%ROWCOUNT||'���� �� ����.');
    --4. CLOSE �ܰ�
  CLOSE emp_cursor;
END;

-----------------------------------------------------
-- Fetch ��    ***
-- SQL> EXECUTE  Cur_sal_Hap (5);
-- CURSOR �� �̿� ���� 
-- �μ���ŭ �ݺ� 
-- 	�μ��� : �λ���
-- 	�ο��� : 5
-- 	�޿��� : 5000
--  
-----------------------------------------------------
CREATE OR REPLACE PROCEDURE Cur_sal_Hap
(p_depno   IN  emp.deptno%TYPE)
-- p_deptno��� �Է� �Ķ���ʹ� emp ���̺��� deptno �÷��� ���� Ÿ���� ������ �Ѵ�

IS
 -- �Ʒ� Ŀ���� �μ��� ��� ������ ��ȸ�ϰ� �׷�ȭ�� ����� ��� ����
 CURSOR     dept_sum IS -- DEPT_SUM �̶�� �̸��� CURSOR ���� CURSRO�� ������ ��ȸ �����
            SELECT     dname, count(*) cnt, sum(sal) sumsal
            FROM       emp e, dept d
            WHERE      e.deptno=d.deptno
            AND        e.deptno LIKE p_deptno||'%'
            -- e.deptno LIKE p_deptno||'%' ������ �Է����� ���� p_deptno�� �������� �μ� ��ȣ�� ���͸��մϴ�. ||�� ���ڿ� ���� ������
            GROUP BY   dname;
 
    vdname      dept.dname%type; --ept.dname%TYPE�� dept ���̺��� dname �÷��� ������ ������ Ÿ���� ���� ������ ���� (�μ��� ���忡 ���)
    vcnt        number; --NUMBERŸ���� ������ ������ ����
    vsumsal     number;
 
BEGIN
-- ���ν��� ����
    DBMS_OUTPUT.ENABLE;
    --DBMS_OUTPUT.PUT_LINE�� ����Ͽ� ����� ����ϱ� ���� ����� Ȱ��ȭ
    --�̷��� �ؾ� DBMS_OUTPUT.PUT_LINE���� ����� ������ �ֿܼ� ��Ÿ��
    
    OPEN dept_sum;
    -- CURSOR dept_sum�� ��
    LOOP
    --dept_sum CURSOR���� ��ȸ�� ����� ��ȸ�ϴ� �ݺ���
     FETCH  dept_sum INTO vdname, vcnt, vsumsal;
     -- dept_sum CURSOR���� �����͸� �о�� vdname, vcnt, vsumsal ������ ����
     EXIT WHEN dept_sum%NOTFOUND;
     --CURSOR�� ���� �����ϸ� �ݺ����� ����
       DBMS_OUTPUT.PUT_LINE('�μ��� : ' ||vdname);
       --DBMS_OUTPUT.PUT_LINE�� ����Ͽ� �μ����� ����մϴ�.
       DBMS_OUTPUT.PUT_LINE('�ο��� : ' ||vcnt);
       DBMS_OUTPUT.PUT_LINE('�޿��� : ' ||vsumsal);
 END LOOP;    
    
CLOSE dept_sum;
END Cur_sal_Hap;

------------------------------------------------------------------------
-- FOR���� ����ϸ� Ŀ���� OPEN, FETCH, CLOSE�� �ڵ� �߻��ϹǷ� 
-- ���� ����� �ʿ䰡 ����, ���ڵ� �̸��� �ڵ�
-- ����ǹǷ� ���� ������ �ʿ䰡 ����.
-- �ǹ� ���� ���
-----------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ForCursor_sal_Hap
IS
--1. DECLARE �ܰ� -->CURSOR ����
CURSOR dept_sum IS
      SELECT b.dname, COUNT(a.empno)cnt, suma(a.sal)salary
      From EMP a, dept b
      WHERE a.deptno = b.deptno
      GROUP BY b.dname;
BEGIN 
    DBMS_OUTPUT.ENABLE;
    --CURSOR�� FORM������ �����Ų�� --> OPEN, FETCH, CLOSE�� �ڵ� �߻�
    FOR empDept_Row IN dept_sum Loop
         DBMS_OUTPUT.PUT_LINE('�μ��� : '||empDept_Row.dname);
         DBMS_OUTPUT.PUT_LINE('����� : '||empDept_Row.cnt);
         DBMS_OUTPUT.PUT_LINE('�޿��հ� : '||empDept_Row.salary);
    
    END LOOP;
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻� ');
END;
        
-----------------------------------------------------------
--����Ŭ PL/SQL�� ���� �Ͼ�� ��� ���ܸ� �̸� ������ ��������, 
--�̷��� ���ܴ� �����ڰ� ���� ������ �ʿ䰡 ����.
--�̸� ���ǵ� ������ ����
-- NO_DATA_FOUND : SELECT���� �ƹ��� ������ ���� ��ȯ���� ���� ��
-- DUP_VAL_ON_INDEX : UNIQUE ������ ���� �÷��� �ߺ��Ǵ� ������ INSERT �� ��
-- ZERO_DIVIDE : 0���� ���� ��
-- INVALID_CURSOR : �߸��� Ŀ�� ����
-----------------------------------------------------------
CREATE OR REPLACE PROCEDURE PreException
(v_deptno IN emp.deptno%TYPE)
IS
    v_emp emp%ROWTYPE;

BEGIN
    DBMS_OUTPUT.ENABLE;

    SELECT empno,      ename,       deptno
    INTO   v_emp.empno, v_emp.ename, v_emp.deptno
    FROM emp
    WHERE deptno = v_deptno ;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || v_emp.empno);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || v_emp.ename);
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || v_emp.deptno);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('�ߺ� �����Ͱ� ���� �մϴ�.');
            DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX ���� �߻�');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS ���� �߻�');
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND ���� �߻�');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('��Ÿ ���� �߻�');
END;

-----------------------------------------------------------
----   Procedure :  in_emp
----   Action    : emp Insert
----   1. Error ����
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle ���� Error
---      2) User Defind Error :  lowsal_err (�����޿� ->1500)  
-----------------------------------------------------------
CREATE OR REPLACE PROCEDURE in_emp
    (p_name     IN  emp.ename%TYPE, --1) DUP_VAL_ON_INDEX
     P_SAL      IN  emp.sal%TYPE,   --2) ������ Defind ERROR : LOWSAL_ERR 
     P_job      IN  emp.job%TYPE
     )
IS
    v_empno     emp.empno%TYPE;
    --������ Defind Error
    lowsal_err EXCEPTION;

BEGIN
    SELECT MAX(empno)+1
    INTO    v_empno
    FROM    emp ;
    
    IF p_sal >= 1500 THEN
       INSERT INTO emp(empno,ename,sal,job,deptno,hiredate)
       VALUES(v_empno,p_name,p_sal,p_job,10,SYSDATE);
    ELSE
        RAISE lowsal_err ;
    END IF ;
    EXCEPTION
     --Oracle PreDefined ERROR
     WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('�ߺ� ������ ename�� ���� �մϴ�.');
        DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX ���� �߻�');
    --������ Defined Error
    WHEN lowsal_err THEN
        DBMS_OUTPUT.PUT_LINE('ERRORR!!!- ������ �޿��� �ʹ� �����ϴ�. 1500�̻����� �ٽ� �Է��ϼ���.');
END in_emp;
       

-----------------------------------------------------------
----   Procedure :  in_emp3
----   Action    : emp Insert
----   1. Error ����
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle ���� Error
---      2) User Defind Error :  highsal_err (�ְ�޿� ->9000 �̻� ���� �߻�)  
---   2. ��Ÿ����
---      1) emp.ename�� Unique ���������� �ɷ� �ִٰ� ���� 
---      2) parameter : p_name, p_sal, p_job
---      3) PK(empno) : Max ��ȣ �Է� 
---      3) hiredate     : �ý��� ��¥ �Է� 
---      4) emp(empno,ename,sal,job,hiredate)  --> 5 Column�Է��Ѵ� ���� 
-----------------------------------------------------------
CREATE OR REPLACE PROCEDURE in_emp3
    (p_ename     IN emp.ename%TYPE,
     p_sal      IN emp.sal%TYPE,
     P_job      IN emp.job%TYPE
    )
IS
    v_empno  emp.empno%TYPE;
    
    highsal_err EXCEPTION;

BEGIN
    SELECT MAX(empno)+1
    INTO v_empno
    FROM emp ;
    
    IF p_sal <=9000 THEN
        INSERT INTO emp(empno,ename,sal,job,hiredate)
        VALUES(v_empno,p_name,p_sal,p_job,SYSDATE);
    ELSE   
        RAISE highsal_err;
    END IF ;
    EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('�ߺ� ������ ename�� �����մϴ�.');
        DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX ���� �߻�');
    WHEN highsal_err THEN
        DBMS_OUTPUT.PUT_LINE('ERRORR!!!- ������ �޿��� �ʹ� �����ϴ� 9000�Ʒ��� �ٽ� �Է��ϼ���.');
END in_emp3;

-------------------------------------------------------------
--  HW2
-- 1. �Ķ��Ÿ : (p_empno, p_ename  , p_job,p_MGR ,p_sal,p_DEPTNO )
-- 2. emp TBL��  Insert_emp Procedure 
-- 3. v_job =  'MANAGER' -> v_comm  := 1000;
--              �ƴϸ�                  150; 
-- 4. Insert -> emp 
-- 5. �Ի����� ��������
--------------------------------------------------------------
create or replace PROCEDURE Insert_emp
(p_empno  emp.empno%type,
 p_ename  emp.ename%type,
 p_job    emp.job%type,
 p_MGR    emp.MGR%TYPE,
 p_sal    emp.sal%TYPE,
 p_deptno emp.deptno%TYPE )
 IS
    v_comm  emp.comm%type;

 BEGIN 

 IF     p_job = 'manager' THEN v_comm :=1000;
 ELSE                           v_comm :=150;

 END IF;

    INSERT INTO emp(empno,    ename,   job,   mgr,   hiredate, sal,   comm,   deptno)
    Values          (p_empno, p_ename, p_job, p_mgr, sysdate,  p_sal, v_comm, p_deptno);

END Insert_emp;

 
 


    