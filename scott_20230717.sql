CREATE OR REPLACE PROCEDURE Emp_Info2
( p_empno  IN emp.empno%TYPE, 
  p_ename OUT emp.ename%TYPE,
  p_sal   OUT emp.sal%TYPE 
)
IS
        -- %TYPE �������� ���� ����
        v_empno emp.empno%TYPE;
BEGIN
        DBMS_OUTPUT.ENABLE;
        --%TYPE �������� ���� ���
        SELECT empno,  ename,  sal
        INTO   v_empno, p_ename, p_sal --�������� ������ into���� ����.
        FROM   emp
        WHERE  empno = p_empno ;
        --����� ���
        DBMS_OUTPUT.PUT_LINE( '�����ȣ : ' || v_empno || CHR(10) || CHR(13) || '�ٹٲ�');
        DBMS_OUTPUT.PUT_LINE( '����̸� : ' || p_ename ) ;
        DBMS_OUTPUT.PUT_LINE( '�����ȣ : ' || p_sal );
END;




create or replace Function func_sal
   (p_empno in number) 
  RETURN number
IS
    vsal emp.sal%type; --emp table�� sal�� ���� Ÿ��
BEGIN
    UPDATE emp SET sal=sal*1.1
    WHERE empno=p_empno;
    commit;
    SELECT sal INTO vsal
    FROM emp
    WHERE empno=p_empno;
    RETURN vsal;
END;

SELECT func_sal(1000)
FROM   dual;

