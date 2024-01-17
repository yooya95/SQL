---------------------------------------------------------------------------------------
-----    Package
--  ���� ����ϴ� ���α׷��� ������ ���ȭ
--  ���� ���α׷��� ���� ���� �� �� ����
--  ���α׷��� ó�� �帧�� �������� �ʾ� ���� ����� ����
--  ���α׷��� ���� �������� �۾��� ��
--  ���� �̸��� ���ν����� �Լ��� ���� �� ����

----------------------------------------------------------------------------------------
--- 1.Header -->  ���� : ���� (Interface ����) 
--     ���� PROCEDURE ���� ����  
create or replace PACKAGE emp_info AS
    PROCEDURE emp_info_main (p_deptno IN NUMBER);
    PROCEDURE all_emp_info;     -- ��� ����� ��� ����
    PROCEDURE all_sal_info;     -- �μ��� �޿� ����
    -- Ư�� �μ��� ��� ����
    PROCEDURE dept_sal_info (p_deptno IN NUMBER);

END  emp_info;

Create OR REPLACE PACKAGE BODY emp_info AS
    -----------------------------------------------------------------
    -- emp_info�� Main Procedure(�μ�����)
    -- 1. emp_info PACKAGE�� ��ü Procedure ����
     -----------------------------------------------------------------
   PROCEDURE emp_info_main (p_deptno IN NUMBER)
   IS
   BEGIN
      all_emp_info();
      all_sal_info();
      dept_sal_info(p_deptno => p_deptno );
   END emp_info_main;  
    -----------------------------------------------------------------
    -- ��� ����� ��� ����(���, �̸�, �Ի���)
    -- 1. CURSOR  : emp_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> ���� �� �ٲپ� ���,�̸�,�Ի��� 
    -- 4. EXCEPTION -> Default
    -----------------------------------------------------------------
    PROCEDURE all_emp_info
    IS
    CURSOR emp_cursor IS
          SELECT empno, ename, to_char(hiredate, 'YYYY/MM/DD') hiredate
          FROM emp
          ORDER BY hiredate;
        
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR emp IN emp_cursor LOOP
              DBMS_OUTPUT.PUT_LINE('��� : ' || emp.empno);
              DBMS_OUTPUT.PUT_LINE('���� : ' || emp.ename);
              DBMS_OUTPUT.PUT_LINE('�Ի��� : ' || emp.hiredate);
        END LOOP;
        EXCEPTION
        WHEN OTHERS THEN
              DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻� ');
    END all_emp_info;  

    -----------------------------------------------------------------------
    -- ��� ����� �μ��� �޿� ����
    -- 1. CURSOR  : empdept_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> ���� �� �ٲپ� �μ���
    ,��ü�޿���� , �ִ�޿��ݾ� , �ּұ޿��ݾ�
    -- 4. EXCEPTION -> Default  *
    -----------------------------------------------------------------------
    PROCEDURE all_sal_info
    IS
        CURSOR empdept_cursor  IS
        SELECT   d.dname dname, round(avg(e.sal),3) avg_sal, max(e.sal) max_sal, min(e.sal) min_sal
        FROM     emp e , dept d
        WHERE   e.deptno = d.deptno
        GROUP BY  d.dname
        
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR empdept IN empdept_cursor LOOP
              DBMS_OUTPUT.PUT_LINE('�μ��� : ' || empdept.dname);
              DBMS_OUTPUT.PUT_LINE('��ü�޿���� : ' || empdept.avg_sal);
              DBMS_OUTPUT.PUT_LINE('�ִ�޿��ݾ� : ' || empdept.max_sal);
              DBMS_OUTPUT.PUT_LINE('�ּұ޿��ݾ� : ' || empdept.min_sal);
        END LOOP;

        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻� ');
    END all_sal_info;

    -----------------------------------------------------------------
    -- Ư�� �μ��� �޿� ����
    -- 1. CURSOR  : emp_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> ���� �� �ٲپ� �μ��� ,��ü�޿���� , �ִ�޿��ݾ� , �ּұ޿��ݾ�
    -- 4. EXCEPTION -> Default  *
    -----------------------------------------------------------------
   PROCEDURE dept_sal_info (p_deptno IN NUMBER)
    IS
        CURSOR emp_cursor IS
        SELECT round(avg(sal),3) avg_sal, max(sal) max_sal, min(sal) min_sal
        FROM emp
        WHERE deptno = p_deptno;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR emp IN emp_cursor LOOP
             DBMS_OUTPUT.PUT_LINE('3.��ü�޿���� : ' || emp.avg_sal);
             DBMS_OUTPUT.PUT_LINE('3.�ִ�޿��ݾ� : ' || emp.max_sal);
             DBMS_OUTPUT.PUT_LINE('3.�ּұ޿��ݾ� : ' || emp.min_sal);
        END LOOP;
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻� ');
    END dept_sal_info;    


END emp_info;


