CREATE OR REPLACE PROCEDURE Emp_Info2
( p_empno  IN emp.empno%TYPE, 
  p_ename OUT emp.ename%TYPE,
  p_sal   OUT emp.sal%TYPE 
)
IS
        -- %TYPE 데이터형 변수 선언
        v_empno emp.empno%TYPE;
BEGIN
        DBMS_OUTPUT.ENABLE;
        --%TYPE 데이터형 변수 사용
        SELECT empno,  ename,  sal
        INTO   v_empno, p_ename, p_sal --변수값을 담을때 into절을 쓴다.
        FROM   emp
        WHERE  empno = p_empno ;
        --결과값 출력
        DBMS_OUTPUT.PUT_LINE( '사원번호 : ' || v_empno || CHR(10) || CHR(13) || '줄바뀜');
        DBMS_OUTPUT.PUT_LINE( '사원이름 : ' || p_ename ) ;
        DBMS_OUTPUT.PUT_LINE( '사원번호 : ' || p_sal );
END;




create or replace Function func_sal
   (p_empno in number) 
  RETURN number
IS
    vsal emp.sal%type; --emp table에 sal와 같은 타입
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

