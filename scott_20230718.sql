-- 학생 테이블에서 학년을 오름차(내림차)순으로 정렬하여 이름, 학년, 전화번호를 출력
SELECT name, grade , tel
FROM   student
-- ORDER BY grade ASC   -- Default ASC
ORDER BY grade DESC  
;
-- 모든 사원의 이름과 급여 및 부서번호를 출력하는데,  
-- 부서 번호로 결과를 정렬한 다음 급여에 대해서는 내림차순으로 정렬
SELECT    ename, sal , deptno
FROM      emp
ORDER BY  deptno, sal desc;

-- 부서 10과 30에 속하는 모든 사원의 이름과 부서번호를 이름의 알파벳 순으로 
-- 정렬되도록 질의문(emp) 
-- Remind
SELECT     ename,deptno
FROM       emp
WHERE      deptno IN (10,30)
ORDER BY   ename;

-- HW1
-- 1982년에 입사한 모든 사원의 이름과 입사일을 구하는 질의문
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
-- 보너스를 받는 모든 사원에 대해서 이름, 급여 그리고 보너스를 출력하는 질의문을 형성. 
-- 단 급여와 보너스에 대해서 급여/보너스순으로 내림차순 정렬
SELECT ename,sal, comm
FROM   emp
WHERE  ( comm is not null AND comm <> 0)
ORDER BY sal DESC, comm DESC;

-- HW3
-- 보너스가 급여의 20% 이상이고 부서번호가 30인 모든 사원에 대해서 
-- 이름, 급여 그리고 보너스, 부서번호를 출력하는 질의문을 형성하라
SELECT ename,sal, comm,deptno
FROM   emp
WHERE  comm >= sal*0.2 AND deptno=30;



-----------------------------------------------------
---    07. 함수(내장함수)
-----------------------------------------------------
-- 대소문자 변환
SELECT ename , UPPER(ENAME),LOWER(ENAME), INITCAP(ENAME)
FROM EMP;
--소문자로 맞춰주기
SELECT ename , SAL, DEPTNO
FROM EMP
--WHERE LOWER(ename) = 'scott'
WHERE UPPER(ename) = 'SCOTT' 
;
-- 학생 테이블에서 학번이 ‘20101’인 학생의 사용자 아이디를 
-- 소문자와 대문자로 변환하여 출력
SELECT userid , LOWER(userid) , UPPER(userid)
FROM   student
WHERE studno = 20101
;
-- 문자열 길이 
-- UTF-8 --> 3자
-- 예시 인사1팀 --> 한글 3(3Byte씩) + 1(1Byte)
SELECT DNAME , LENGTH (DNAME), LENGTHB(DNAME)
FROM DEPT;

--한글 문자열 길이  Test   --> Insert 안 된 표본 utf-8
INSERT INTO DEPT VALUES (59,'경영지원팀','충정로');

----------------------------------------------------------
-------               내장함수               --------------
----------------------------------------------------------
-- * concat
SELECT concat(name, '의 직책은 ')
FROM professor
;
SELECT name||'의 직책은 '
FROM professor
;
SELECT concat(concat(name, '의 직책은 '),position)
FROM professor
;

--- 학생 테이블에서 1학년 학생의 주민등록 번호에서 생년월일과 태어난 달을 추출하여 
--- 이름, 주민번호, 생년월일, 태어난 달을 출력하여라
---  SUBSTR ***
SELECT name , idnum , SUBSTR(idnum , 1,6) birth_date  , SUBSTR(idnum ,3,2) birth_mon
FROM   student
WHERE grade = 1;

-- INSTR 함수 *
-- 문자열중에서 사용자가 지정한 특정 문자가 포함된 위치를 반환하는 함수
-- 학과  테이블의 부서 이름 칼럼에서 ‘과’ 글자의 위치를 출력하여라
SELECT  dname , INSTR(dname , '과')
FROM    department; 

-- LPAD, RPAD 함수 *
-- LPAD와 RPAD 함수는 문자열이 일정한 크기가 되도록 왼쪽 또는 오른쪽에 지정한 문자를 삽입하는 함수
-- 교수테이블에서 직급 칼럼의 왼쪽에 ‘*’ 문자를 삽입하여 10바이트로 출력하고 
-- 교수 아이디 칼럼은 오른쪽에 ‘+’문자를 삽입하여 12바이트로 출력
SELECT position , LPAD(position , 10,'*') lpad_position,
        userid ,  RPAD(userid,12,'+')     rpad_userid
FROM    professor;

SELECT position , LPAD(position , 10,'-') lpad_position,
        userid ,  RPAD(userid,12,'%')     rpad_userid
FROM    professor;

--LTRIM, RTRIM 함수 *
--LTRIM와 RTRIM 함수는 문자열에서 특정 문자를 삭제하기 위해 사용
--함수의 인수에서 삭제할 문자를 지정하지 않으면 문자열의 앞뒤 부분에 있는 공백 문자를 삭제
SELECT LTRIM('  abcdefg  ',' ') FROM dual;
SELECT RTRIM('  abcdefg  ',' ') FROM dual;
SELECT LTRIM('**abcdefg  ','*') FROM dual;

--  학과 테이블에서 부서 이름의 마지막 글자인 ‘과’를 삭제하여 출력하여라
SELECT dname , RTRIM(dname, '과')
FROM   department;


---------------------------------------------------------
-------- 숫자 함수 *** ------------------------------------
---------------------------------------------------------
--1) ROUND 함수
--   지정한 자리 이하에서 반올림한 결과 값을 반환하는 함수
-- 교수 테이블에서 101학과 교수의 일급을 계산(월 근무일은 22일)하여 소수점 첫째 자리와 
-- 셋째 자리에서 반올림 한 값과 소숫점 왼쪽 첫째 자리에서 반올림한 값을 출력하여라
SELECT name ,sal ,sal/22,ROUND(sal/22) ,ROUND(sal/22, 2) , ROUND(sal/22, -1)
FROM    professor
WHERE  deptno = 101;

-- 2)TRUNC 함수
-- 지정한 소수점 자리수 이하를 절삭한 결과 값을 반환하는 함수
-- 교수 테이블에서 101학과 교수의 일급을 계산(월 근무일은 22일)하여
-- 소수점 첫째 자리와 셋째 자리에서 절삭 한 값과 
-- 소숫점 왼쪽 첫째 자리에서 절삭한 값을 출력
SELECT name , sal , sal/22 , TRUNC(sal/22) , TRUNC(sal/22,2) , TRUNC(sal/22,-1)
FROM    professor
WHERE deptno = 101; 

-- 3) MOD 함수 
--    MOD 함수는 나누기 연산후에 나머지를 출력하는 함수 
-- 교수 테이블에서 101번 학과 교수의 급여를 보직수당으로 나눈 나머지를 계산하여 출력하여라
SELECT   name , sal , comm , MOD(sal , comm)
FROM     professor
WHERE   deptno = 101;

-- 4) CEIL, FLOOR 함수
-- CEIL 함수는 지정한 숫자보다 크거나 같은 정수 중에서 최소 값을 출력하는 함수
-- FLOOR함수는 지정한 숫자보다 작거나 같은 정수 중에서 최대 값을 출력하는 함수
-- 19.7보다 큰 정수 중에서 가장 작은 정수와 12.345보다 작은 정수 중에서 가장 큰 정수를 출력하여라
SELECT CEIL(19.7) , FLOOR(12.345), FLOOR(-12.345)
FROM    dual;


---------------------------------------------------------
-------- 날자 함수 *** ------------------------------------
---------------------------------------------------------
-- 1) 날짜 + 숫자 = 날짜 (날짜에 일수를 가산)
-- 교수 번호가 9908인 교수의 입사일을 기준으로 입사 30일 후와 60일 후의 날짜를 출력
SELECT name , hiredate , hiredate+30 , hiredate+60
FROM   professor
WHERE profno = 9908;
-- 2) 날짜 - 숫자 = 날짜 (날짜에 일수를 감산)
-- 3) 날짜 - 날짜=  일수 (날짜에 날짜를 감산)
-- 4) SYSDATE 함수
--     SYSDATE 함수는 시스템에 저장된 현재 날짜를 반환하는 함수로서, 초 단위까지 반환
SELECT sysdate 
FROM    dual;

-- 5) MONTHS_BETWEEN : date1과 date2 사이의 개월 수를 계산
--     ADD_MONTHS        : date에 개월 수를 더한 날짜 계산
--     MONTHS_BETWEEN과 ADD_MONTHS 함수는 월 단위로 날짜 연산을 하는 함수 
--     입사한지 120개월 미만인 교수의 교수번호, 입사일, 입사일로 부터 현재일까지의 개월 수,
--     입사일에서 6개월 후의 날짜를 출력하여라
SELECT profno , hiredate,
       MONTHS_BETWEEN(SYSDATE,hiredate)   working_day,
       ADD_MONTHS(hiredate , 6)  hire_6after
FROM   professor
WHERE MONTHS_BETWEEN(SYSDATE,hiredate)  < 120
;

---------------------------------------------------------
----   HW  10
----------------------------------------------------------
--1. salgrade 데이터 전체 보기
SELECT  * FROM  salgrade;
--2. scott에서 사용가능한 테이블 보기
SELECT * FROM tab;
--3. emp Table에서 사번 , 이름, 급여, 업무, 입사일 조회
SELECT empno,ename,sal,job,hiredate 
FROM    emp;
--4. emp Table에서 급여가 2000미만인 사람 에 대한 사번, 이름, 급여 항목 조회
 SELECT empno,ename,sal 
 FROM    emp 
 WHERE  sal<2000;
--5. emp Table에서 80/02이후에 입사한 사람에 대한  사번,이름,업무,입사일 
SELECT  empno,ename,job,hiredate
FROM     emp 
WHERE   hiredate > '80/02/01';
--  WHERE  hiredate BETWEEN '80/02/01' AND sysdate;

SELECT ename, HIREDATE
FROM   emp 
Where  TO_CHAR(hiredate , 'MM') = '02';

--6. emp Table에서 급여가 1500이상이고 3000이하 사번, 이름, 급여  조회
--    ( AND   &    BETWEEN)
SELECT  empno,ename,sal
FROM    emp 
WHERE   sal >= 1500 
AND     sal <= 3000; 

SELECT  empno,ename,sal
FROM    emp 
WHERE   sal BETWEEN  1500 AND  3000; 

--7. emp Table에서 사번, 이름, 업무, 급여 조회 [ 급여가 2500이상이고  업무가 MANAGER인 사람]
SELECT empno, ename,job, sal 
FROM   emp 
WHERE  sal>=2500 
AND    job='MANAGER'
;
--8. emp Table에서 이름, 급여, 연봉 조회 
   -- [단 조건은  연봉 = (급여+상여) * 12  , null을 0으로 변경]
SELECT ename,sal,(sal+nvl(comm,0))*12 연봉
FROM   emp;   
--9. emp Table에서  81/02 이후에 입사자들중 xxx는 입사일이 xxX
--  [ 전체 Row 출력 ] --> 2가지 방법 다
SELECT ename||'는 입사일이 '||hiredate||'이다'
FROM    emp 
WHERE  hiredate >='81/02/01';

SELECT CONCAT(CONCAT(ename, '는 입사일이   '),hiredate)
FROM    emp 
WHERE  hiredate >='81/02/01';

--10.emp Table에서 이름속에 T가 있는 사번,이름 출력
SELECT empno , ename 
FROM   emp 
WHERE  ename like '%T%';



















