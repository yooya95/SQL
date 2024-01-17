------------------------------------------------------------------------
---    PL/SQL의 개념
---   1. Oracle에서 지원하는 프로그래밍 언어의 특성을 수용한 SQL의 확장
---   2. PL/SQL Block내에서 SQL의 DML(데이터 조작어)문과 Query(검색어)문, 
---      그리고 절차형 언어(IF, LOOP) 등을 사용하여 절차적으로 프로그래밍을 가능하게 
---      한 강력한  트랜잭션 언어
---
---   1) 장점 
---      프로그램 개발의 모듈화 : 복잡한 프로그램을 의미있고 잘 정의된 작은 Block 분해
---      변수선언  : 테이블과 칼럼의 데이터 타입을 기반으로 하는 유동적인 변수를 선언
---      에러처리  : Exception 처리 루틴을 사용하여 Oracle 서버 에러를 처리
---      이식성    : Oracle과 PL/SQL을 지원하는어떤 호스트로도 프로그램 이동 가능
---      성능 향상 : 응용 프로그램의 성능을 향상
 
------------------------------------------------------------------------
create or replace Function func_sal
   (p_empno in number) 
  RETURN number ----ㅡMUST 필수임!
-- 함수는 return 값이 있어야함, return 값은 무조건 한개!
-- 독립성 보장 (FUCTION을 DML로 쓰고 싶을 때 : 암기할 필요 없고 가지고다니면서 쓰라함
IS
    vsal emp.sal%type; --emp table에 sal와 같은 타입
BEGIN
    UPDATE emp SET sal=sal*1.1 --10%인상
    WHERE empno=p_empno;
    commit;
    SELECT sal INTO vsal --조회하기 위해 밖으로 반환하는 매커니즘
    FROM emp
    WHERE empno=p_empno;
    RETURN vsal;
END;
------------------------------------------------------------------------
--  Function  :  하나의 값을 돌려줘야 되는 경우에 Function을 생성
--  문1) 특정한 수에 세금을 7%로 계산하는 Function을 작성
---   조건 1: Function  -->   tax 
---   조건 2: parameter   -->   p_num  (급여)
---   조건 3: 계산을 통해 7% 값을 돌려줌

CREATE OR REPLACE FUNCTION tax
    (p_num in number)
RETURN number
IS
    v_tax number ;
BEGIN 
    v_tax := p_num * 0.07 ;  --:= =과 같은뜻
    RETURN(v_tax) ;
END ;

SELECT tax(100) FROM dual;
SELECT tax(200) FROM dual;

--emp 테이블에 tax 함수 적용
SELECT empno, ename, sal, tax(sal)
FROM emp
;

------------------------------------------------------------
--  EMP 테이블에서 사번을 입력받아 해당 사원의 급여에 따른 세금을 구함.
-- 급여가 2000 미만이면 급여의 6%, 
-- 급여가 3000 미만이면 8%, 
-- 5000 미만이면 10%, 
-- 그 이상은 15%로 세금
--- FUNCTION  emp_tax3
-- 1) Parameter : 사번 p_empno
--      변수     :   v_sal(급여)
--                     v_pct(세율계산값)
-- 2) 사번을 가지고 급여를 구함
-- 3) 급여를 가지고 세율 계산 
-- 4) 계산 된 값 Return   number
-------------------------------------------------------------
-- %TYPE Attribute는 테이블의 칼럼에 대한 데이터 타입을 정확히 모
--르거나, 칼럼에 대한 데이터 타입이 중간에 변경되는 경우에 유용합
--니다
CREATE OR REPLACE FUNCTION emp_tax3
(p_empno    IN        emp.empno%TYPE)  --1)PARAMETER : 사번
 RETURN     number
IS 
 v_sal          emp.sal%TYPE;
 v_pct          NUMBER(5,2); -- 전체가 5자리 소숫점 2자리
 
BEGIN
--2) 사번을 가지고 급여를 구함
SELECT sal
INTO   v_sal
FROM   emp
WHERE  empno = p_empno;

-- 3) 급여를 가지고 세율 계산

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
--  Procedure up_emp 실행 결과
-- SQL> EXECUTE up_emp(1200);  -- 사번 
-- 결과       : 급여 인상 저장
--               시작문자
--   변수     :   v_job(업무)
--                  v_pct(세율)

-- 조건 1) job = SALE포함         v_pct : 10
--           IF              v_job LIKE 'SALE%' THEN
--     2)            MAN              v_pct : 7  
--     3)                                v_pct : 5
--   job에 따른 급여 인상을 수행  sal = sal+sal*v_pct/100
-- UPDATE
-- 확인 : DB -> TBL
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
-- SELECT up_emp(7844) FROM dual; --> 직접 실행 프로시저가서 해야함


---------------------------------------------------------
-- PROCEDURE Delete_emp
-- SQL> EXECUTE Delete_emp(5555);
-- 사원번호 : 5001,5002,5003
-- 사원이름 : 55
-- 입 사 일 : 81/12/03
-- 데이터 삭제 성공
--  1. Parameter : 사번 입력
--  2. 사번 이용해 사원번호 ,사원이름 , 입 사 일 출력
--  3. 사번 해당하는 데이터 삭제 
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
-- 행동강령 : 부서번호 입력 해당 emp 정보  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch(70);
--  조회화면 :    사번    : 5555
--              이름    : 홍길동


CREATE OR REPLACE PROCEDURE DeptEmpSearch1
    (p_deptno    IN  emp.deptno%TYPE)   --부서번호를 입력

IS
    v_empno  emp.empno%type;        --사번
     v_ename emp.ename%type;        --이

BEGIN 
    DBMS_OUTPUT.ENABLE;
    SELECT       empno, ename
    INTO         v_empno, v_ename
    FROM         emp
    WHERE        deptno = p_deptno ;
    DBMS_OUTPUT.PUT_LINE('사번 : ' || v_empno);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || v_ename);
END DeptEmpSearch1;


EXECUTE DeptEmpSearch1(40);


---------------------------------------------------------
-- 행동강령 : 부서번호 입력 해당 emp 정보  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch2(75);
--  조회화면 :    사번    : 5555
--              이름    : 홍길동
-- %ROWTYPE를 이용하는 방법

CREATE OR REPLACE PROCEDURE DeptEmpSearch2
    (p_deptno    IN  emp.deptno%TYPE)   --부서번호를 입력

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
    DBMS_OUTPUT.PUT_LINE('사번 : ' || v_emp.empno);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || v_emp.ename);
END DeptEmpSearch2;

---------------------------------------------------------
-- 행동강령 : 부서번호 입력 해당 emp 정보  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch3(10);
--  조회화면 :    사번    : 5555
--              이름    : 홍길동
-- %ROWTYPE를 이용하는 방법
-- EXCEPTION 이용하는 방법

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
    DBMS_OUTPUT.PUT_LINE('사번 : ' || v_emp.empno);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || v_emp.ename);

-- MULTI ROW EROOR --> 실제 인출은 요구된 것보다 많은 수의 행을 추출
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERR OCDE1 : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('ERR CODE2 : ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('ERR MESSAGE: ' || SQLERRM);

END  DeptEmpSearch3;

--------------------------------------------------------------------------------
----  ***    cursor    ***
--- 1.정의 : Oracle Server는 SQL문을 실행하고 처리한 정보를 저장하기 위해 
--        "Private SQL Area" 이라고 하는 작업영역을 이용
--       이 영역에 이름을 부여하고 저장된 정보를 처리할 수 있게 해주는데 이를 CURSOR
-- 2. 종류  :    Implicit(묵시적인) CURSOR -> DML문과 SELECT문에 의해 내부적으로 선언 
--                 Explicit(명시적인) CURSOR -> 사용자가 선언하고 이름을 정의해서 사용 
-- 3.attribute
--   1) SQL%ROWCOUNT : 가장 최근의 SQL문에 의해 처리된 Row 수
--   2) SQL%FOUND    : 가장 최근의 SQL문에 의해 처리된 Row의 개수가 한 개이상이면 True
--   3) SQL%NOTFOUND : 가장 최근의 SQL문에 의해 처리된 Row의 개수가 없으면True
-- 4. 4단계 ** 
--     1) DECLARE 단계 : 커서에 이름을 부여하고 커서내에서 수행할 SELECT문을 정의함으로써 CURSOR를 선언
--     2) OPEN 단계 : OPEN문은 참조되는 변수를 연결하고, SELECT문을 실행
--     3) FETCH 단계 : CURSOR로부터 Pointer가 존재하는 Record의 값을 변수에 전달
--     4) CLOSE 단계 : Record의 Active Set을 닫아 주고, 다시 새로운 Active Set을만들어 OPEN할 수 있게 해줌
--------------------------------------------------------------------------------
---------------------------------------------------------
-- EXECUTE 문을 이용해 함수를 실행합니다.
-- SQL>EXECUTE show_emp3(7900);
---------------------------------------------------------

CREATE OR REPLACE PROCEDURE show_emp3
(p_empno   IN  emp.empno%TYPE)

IS
    --1. DECLARE 단계
    CURSOR emp_cursor IS
    SELECT ename, job, sal
    FROM   emp
    WHERE  empno LIKE p_empno||'%';
    
    v_ename emp.ename%TYPE;
    v_sal   emp.sal%TYPE;
    v_job   emp.job%TYPE;

BEGIN
   --2. open 단계
   OPEN emp_cursor;
    DBMS_OUTPUT.PUT_LINE('이름    ' || '업무' || '급여');
    DBMS_OUTPUT.PUT_LINE('-------------------------');
  LOOP
   --3. FETCH 단계 --> 하나씩 꺼냄
   FETCH emp_cursor INTO v_ename, v_job, v_sal;
   EXIT WHEN emp_cursor%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE(v_ename ||'   '|| v_job||'  '||v_sal);
  END LOOP;
    DBMS_OUTPUT.PUT_LINE(emp_cursor%ROWCOUNT||'개의 행 선택.');
    --4. CLOSE 단계
  CLOSE emp_cursor;
END;

-----------------------------------------------------
-- Fetch 문    ***
-- SQL> EXECUTE  Cur_sal_Hap (5);
-- CURSOR 문 이용 구현 
-- 부서만큼 반복 
-- 	부서명 : 인사팀
-- 	인원수 : 5
-- 	급여합 : 5000
--  
-----------------------------------------------------
CREATE OR REPLACE PROCEDURE Cur_sal_Hap
(p_depno   IN  emp.deptno%TYPE)
-- p_deptno라는 입력 파라미터는 emp 테이블의 deptno 컬럼과 같은 타입을 가져야 한다

IS
 -- 아래 커서는 부서별 사원 정보를 조회하고 그룹화한 결과를 담고 있음
 CURSOR     dept_sum IS -- DEPT_SUM 이라는 이름의 CURSOR 정의 CURSRO은 데이터 조회 기능임
            SELECT     dname, count(*) cnt, sum(sal) sumsal
            FROM       emp e, dept d
            WHERE      e.deptno=d.deptno
            AND        e.deptno LIKE p_deptno||'%'
            -- e.deptno LIKE p_deptno||'%' 조건은 입력으로 받은 p_deptno를 기준으로 부서 번호를 필터링합니다. ||는 문자열 연결 연산자
            GROUP BY   dname;
 
    vdname      dept.dname%type; --ept.dname%TYPE은 dept 테이블의 dname 컬럼과 동일한 데이터 타입을 가진 변수를 선언 (부서명 저장에 사용)
    vcnt        number; --NUMBER타입을 숫자형 데이터 저장
    vsumsal     number;
 
BEGIN
-- 프로시저 시작
    DBMS_OUTPUT.ENABLE;
    --DBMS_OUTPUT.PUT_LINE을 사용하여 결과를 출력하기 위해 출력을 활성화
    --이렇게 해야 DBMS_OUTPUT.PUT_LINE으로 출력한 내용이 콘솔에 나타남
    
    OPEN dept_sum;
    -- CURSOR dept_sum을 염
    LOOP
    --dept_sum CURSOR에서 조회한 결과를 순회하는 반복문
     FETCH  dept_sum INTO vdname, vcnt, vsumsal;
     -- dept_sum CURSOR에서 데이터를 읽어와 vdname, vcnt, vsumsal 변수에 저장
     EXIT WHEN dept_sum%NOTFOUND;
     --CURSOR의 끝에 도달하면 반복문을 종료
       DBMS_OUTPUT.PUT_LINE('부서명 : ' ||vdname);
       --DBMS_OUTPUT.PUT_LINE을 사용하여 부서명을 출력합니다.
       DBMS_OUTPUT.PUT_LINE('인원수 : ' ||vcnt);
       DBMS_OUTPUT.PUT_LINE('급여합 : ' ||vsumsal);
 END LOOP;    
    
CLOSE dept_sum;
END Cur_sal_Hap;

------------------------------------------------------------------------
-- FOR문을 사용하면 커서의 OPEN, FETCH, CLOSE가 자동 발생하므로 
-- 따로 기술할 필요가 없고, 레코드 이름도 자동
-- 선언되므로 따로 선언할 필요가 없다.
-- 실무 많이 사용
-----------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ForCursor_sal_Hap
IS
--1. DECLARE 단계 -->CURSOR 선언
CURSOR dept_sum IS
      SELECT b.dname, COUNT(a.empno)cnt, suma(a.sal)salary
      From EMP a, dept b
      WHERE a.deptno = b.deptno
      GROUP BY b.dname;
BEGIN 
    DBMS_OUTPUT.ENABLE;
    --CURSOR를 FORM문에서 실행시킨다 --> OPEN, FETCH, CLOSE가 자동 발생
    FOR empDept_Row IN dept_sum Loop
         DBMS_OUTPUT.PUT_LINE('부서명 : '||empDept_Row.dname);
         DBMS_OUTPUT.PUT_LINE('사원수 : '||empDept_Row.cnt);
         DBMS_OUTPUT.PUT_LINE('급여합계 : '||empDept_Row.salary);
    
    END LOOP;
    
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
END;
        
-----------------------------------------------------------
--오라클 PL/SQL은 자주 일어나는 몇가지 예외를 미리 정의해 놓았으며, 
--이러한 예외는 개발자가 따로 선언할 필요가 없다.
--미리 정의된 예외의 종류
-- NO_DATA_FOUND : SELECT문이 아무런 데이터 행을 반환하지 못할 때
-- DUP_VAL_ON_INDEX : UNIQUE 제약을 갖는 컬럼에 중복되는 데이터 INSERT 될 때
-- ZERO_DIVIDE : 0으로 나눌 때
-- INVALID_CURSOR : 잘못된 커서 연산
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
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || v_emp.empno);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || v_emp.ename);
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || v_emp.deptno);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('중복 데이터가 존재 합니다.');
            DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX 에러 발생');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS 에러 발생');
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND 에러 발생');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('기타 에러 발생');
END;

-----------------------------------------------------------
----   Procedure :  in_emp
----   Action    : emp Insert
----   1. Error 유형
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle 선언 Error
---      2) User Defind Error :  lowsal_err (최저급여 ->1500)  
-----------------------------------------------------------
CREATE OR REPLACE PROCEDURE in_emp
    (p_name     IN  emp.ename%TYPE, --1) DUP_VAL_ON_INDEX
     P_SAL      IN  emp.sal%TYPE,   --2) 개발자 Defind ERROR : LOWSAL_ERR 
     P_job      IN  emp.job%TYPE
     )
IS
    v_empno     emp.empno%TYPE;
    --개발자 Defind Error
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
        DBMS_OUTPUT.PUT_LINE('중복 데이터 ename이 존재 합니다.');
        DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX 에러 발생');
    --개발자 Defined Error
    WHEN lowsal_err THEN
        DBMS_OUTPUT.PUT_LINE('ERRORR!!!- 지정한 급여가 너무 적습니다. 1500이상으로 다시 입력하세요.');
END in_emp;
       

-----------------------------------------------------------
----   Procedure :  in_emp3
----   Action    : emp Insert
----   1. Error 유형
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle 선언 Error
---      2) User Defind Error :  highsal_err (최고급여 ->9000 이상 오류 발생)  
---   2. 기타조건
---      1) emp.ename은 Unique 제약조건이 걸려 있다고 가정 
---      2) parameter : p_name, p_sal, p_job
---      3) PK(empno) : Max 번호 입력 
---      3) hiredate     : 시스템 날짜 입력 
---      4) emp(empno,ename,sal,job,hiredate)  --> 5 Column입력한다 가정 
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
        DBMS_OUTPUT.PUT_LINE('중복 데이터 ename이 존재합니다.');
        DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX 에러 발생');
    WHEN highsal_err THEN
        DBMS_OUTPUT.PUT_LINE('ERRORR!!!- 지정한 급여가 너무 많습니다 9000아래로 다시 입력하세요.');
END in_emp3;

-------------------------------------------------------------
--  HW2
-- 1. 파라메타 : (p_empno, p_ename  , p_job,p_MGR ,p_sal,p_DEPTNO )
-- 2. emp TBL에  Insert_emp Procedure 
-- 3. v_job =  'MANAGER' -> v_comm  := 1000;
--              아니면                  150; 
-- 4. Insert -> emp 
-- 5. 입사일은 현재일자
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

 
 


    