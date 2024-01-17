---------------------------------------------------------------------------------------
-----    Package
--  자주 사용하는 프로그램과 로직을 모듈화
--  응용 프로그램을 쉽게 개발 할 수 있음
--  프로그램의 처리 흐름을 노출하지 않아 보안 기능이 좋음
--  프로그램에 대한 유지보수 작업이 편리
--  같은 이름의 프로시저와 함수를 여러 개 생성

----------------------------------------------------------------------------------------
--- 1.Header -->  역할 : 선언 (Interface 역할) 
--     여러 PROCEDURE 선언 가능  
create or replace PACKAGE emp_info AS
    PROCEDURE emp_info_main (p_deptno IN NUMBER);
    PROCEDURE all_emp_info;     -- 모든 사원의 사원 정보
    PROCEDURE all_sal_info;     -- 부서별 급여 정보
    -- 특정 부서의 사원 정보
    PROCEDURE dept_sal_info (p_deptno IN NUMBER);

END  emp_info;

Create OR REPLACE PACKAGE BODY emp_info AS
    -----------------------------------------------------------------
    -- emp_info의 Main Procedure(부서정보)
    -- 1. emp_info PACKAGE의 전체 Procedure 수행
     -----------------------------------------------------------------
   PROCEDURE emp_info_main (p_deptno IN NUMBER)
   IS
   BEGIN
      all_emp_info();
      all_sal_info();
      dept_sal_info(p_deptno => p_deptno );
   END emp_info_main;  
    -----------------------------------------------------------------
    -- 모든 사원의 사원 정보(사번, 이름, 입사일)
    -- 1. CURSOR  : emp_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> 각각 줄 바꾸어 사번,이름,입사일 
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
              DBMS_OUTPUT.PUT_LINE('사번 : ' || emp.empno);
              DBMS_OUTPUT.PUT_LINE('성명 : ' || emp.ename);
              DBMS_OUTPUT.PUT_LINE('입사일 : ' || emp.hiredate);
        END LOOP;
        EXCEPTION
        WHEN OTHERS THEN
              DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
    END all_emp_info;  

    -----------------------------------------------------------------------
    -- 모든 사원의 부서별 급여 정보
    -- 1. CURSOR  : empdept_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> 각각 줄 바꾸어 부서명
    ,전체급여평균 , 최대급여금액 , 최소급여금액
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
              DBMS_OUTPUT.PUT_LINE('부서명 : ' || empdept.dname);
              DBMS_OUTPUT.PUT_LINE('전체급여평균 : ' || empdept.avg_sal);
              DBMS_OUTPUT.PUT_LINE('최대급여금액 : ' || empdept.max_sal);
              DBMS_OUTPUT.PUT_LINE('최소급여금액 : ' || empdept.min_sal);
        END LOOP;

        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
    END all_sal_info;

    -----------------------------------------------------------------
    -- 특정 부서의 급여 정보
    -- 1. CURSOR  : emp_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> 각각 줄 바꾸어 부서명 ,전체급여평균 , 최대급여금액 , 최소급여금액
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
             DBMS_OUTPUT.PUT_LINE('3.전체급여평균 : ' || emp.avg_sal);
             DBMS_OUTPUT.PUT_LINE('3.최대급여금액 : ' || emp.max_sal);
             DBMS_OUTPUT.PUT_LINE('3.최소급여금액 : ' || emp.min_sal);
        END LOOP;
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
    END dept_sal_info;    


END emp_info;


