-- LAST_DAY, NEXT_DAY
-- LAST_DAY 함수는 해당 날짜가 속한 달의 마지막 날짜를 반환하는 함수
-- NEXT_DAY 함수는 해당 일을 기준으로 명시된 요일의 다음 날짜를 변환하는 함수

-- 오늘이 속한 달의 마지막 날짜와 다가오는 일요일의 날짜를 출력하여라
SELECT SYSDATE , LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE, '일')
FROM DUAL
;
-- ROUND, TRUNC 함수
SELECT TO_CHAR(HIREDATE, 'YY/MM/DD HH24:MI:SS') HIREDATE,
       TO_CHAR(ROUND(HIREDATE, 'dd'), 'YY/MM/DD') round_dd,
       TO_CHAR(ROUND(HIREDATE, 'mm'), 'YY/MM/DD') round_mm,
       TO_CHAR(ROUND(HIREDATE, 'yy'), 'YY/MM/DD') round_yy,
       TO_CHAR(TRUNC(HIREDATE, 'DD'), 'YY/MM/DD') TRUNC_DD,
       TO_CHAR(TRUNC(HIREDATE, 'MM'), 'YY/MM/DD') TRUNC_MM,
       TO_CHAR(TRUNC(HIREDATE, 'YY'), 'YY/MM/YY ') TRUNC_YY
FROM   professor;

-- TO_CHAR 함수 문자열로 형변환 
-- TO_CHAR 함수는 날짜나 숫자를 문자로 변환하기 위해 사용   **
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') YYMMDD,
       TO_CHAR(SYSDATE, 'YY/MM/DD') YYMMDDHH,
        TO_CHAR(SYSDATE, 'YYYY') YYYY,
       TO_CHAR(SYSDATE, 'MM') MM,
       TO_CHAR(SYSDATE, 'DD') DD
FROM   DUAL;


-- 학생 테이블에서 전인하 학생의 학번(STUDNO)과 생년월일(BIRTHDATE) 중에서 년월만 출력하여라
SELECT STUDNO, TO_CHAR(BIRTHDATE, 'YY/MM')BIRTHDATE
FROM STUDENT
WHERE NAME = '전인하'
;

-- 1.숫자를 문자 형식으로 변환
-- 2.보직수당을 받는 교수들의 이름, 급여, 보직수당, 
-- 3.그리고 급여와 보직수당을 더한 값에 12를 곱한 결과를 anual_sal(연봉)으로 출력
-- 4. 단 출력형식은 '9,999' (숫자에 대한 출력형식) 

SELECT NAME,SAL,COMM, TO_CHAR((SAL+NVL(COMM,0))*12,'9,999') anual_sal
FROM PROFESSOR
where comm is not null
;

SELECT TO_NUMBER('123') --, TO_NUMBER('a123') 오류발생
FROM DUAL
;

--* REVIEW
--  student Table에서 주민등록번호에서 생년월일을 추출하여 ‘YY/MM/DD’ 형태로 출력하여라
SELECT  IDNUM, SUBSTR(IDNUM,1,6)
        ,IDNUM, TO_DATE(SUBSTR(IDNUM,1,6), 'YYMMDD')
        ,TO_CHAR(TO_DATE(SUBSTR(IDNUM,1,6), 'YYMMDD'),'YY/MM/DD') BIRTHDATE --이거 한줄만 넣으면 됨
        ,TO_CHAR(TO_DATE(SUBSTR(IDNUM,1,6), 'YY/MM/DD')) BIRTHDATE2
FROM STUDENT
;
-- NVL 함수는 NULL을 0 또는 다른 값으로 변환하기 위한 함수
-- 101번 학과 교수의 이름, 직급, 급여, 보직수당, 급여와 보직수당의 합계를 출력하여라. 
-- 단, 보직수당이 NULL인 경우에는 보직수당을 0으로 계산한다

SELECT NAME, POSITION, SAL, COMM, SAL+NVL(COMM,0)
FROM PROFESSOR
WHERE DEPTNO = 101
;

-- NVL2 함수
-- NVL2 함수는 첫 번째 인수 값이 NULL이 아니면 두 번째 인수 값을 출력하고,
-- 첫 번째 인수 값이 NULL이면 세 번째 인수 값을 출력하는 함수
-- 102번 학과 교수중에서 보직수당을 받는사람은 급여와 보직수당을 더한 값을 급여 총액으로 출력하여라. 
-- 단, 보직수당을 받지 않는 교수는 급여만 급여 총액으로 출력하여

SELECT NAME, POSITION, SAL, COMM,
        NVL2(COMM, sal+comm,sal) TOTAL --COMM값이 NULL 이면(FALSE) SAL, 아니면(TRUE) SAL+COMM
FROM   PROFESSOR
WHERE  DEPTNO = 102;

-- NULLIF 함수
-- NULLIF 함수는 두 개의 표현식을 비교하여 값이 동일하면 NULL을 반환하고,
--  일치하지 않으면 첫 번째 표현식의 값을 반환
-- 믄) 교수 테이블에서 이름의 바이트 수와 사용자 아이디의 바이트 수를 비교해서
--      같으면 NULL을 반환하고 
--      같지 않으면 이름의 바이트 수를 반환

SELECT NAME, userid, LENGTHB(NAME), LENGTHB(userid),POSITION, SAL, COMM,
       NULLIF(LENGTHB(NAME), LENGTHB(userid) ) NULLIF_RESULT
FROM   PROFESSOR
;

--DECODE 함수 ***** (조건기준속성, 조건1, 결과1, 조건2, 결과2, 조건3,결과3, 기본결과) 
--DECODE 함수는 기존 프로그래밍 언어에서 IF문이나 CASE 문으로 표현되는 복잡한 알고리즘을 
--하나의 SQL 명령문으로 간단하게 표현할 수 있는 유용한 기능 
--DECODE 함수에서 비교 연산자는 ‘=‘만 가능

--교수 테이블에서 교수의 소속 학과 번호를 학과 이름으로 변환하여 출력하여라. 
--학과 번호가 101이면 ‘컴퓨터공학과’, 102이면 ‘멀티미디어학과’, 201이면 ‘전자공학과’, 
--나머지 학과 번호는 ‘기계공학과’(default)로 변환
SELECT NAME, DEPTNO, 
       DECODE(DEPTNO, 101,'컴퓨터공학과', 
                      102,'멀티미디어학과', 
                      201,'전자공학과', 
                           '기계공학과')
FROM PROFESSOR
;

-- CASE 함수 WHEN 조건1 THEN '결과' .... ELSE'결과' END 
-- CASE 함수는 DECODE 함수의 기능을 확장한 함수 
-- DECODE 함수는 표현식 또는 칼럼 값이 ‘=‘ 비교를 통해 조건과 일치하는 경우에만 다른 값으로 대치할 수 있지만
-- , CASE 함수에서는 산술 연산, 관계 연산, 논리 연산과 같은 다양한 비교가 가능
-- 또한 WHEN 절에서 표현식을 다양하게 정의
-- 8.1.7에서부터 지원되었으며, 9i에서 SQL, PL/SQL에서 완벽히 지원 
-- DECODE 함수에 비해 직관적인 문법체계와 다양한 비교 표현식 사용

SELECT NAME, DEPTNO,
       CASE WHEN DEPTNO = 101 THEN '컴퓨터공학과'
            WHEN DEPTNO = 102 THEN '멀티미디어학과'
            WHEN DEPTNO = 201 THEN '전자공학과'
            ELSE                   '기계공학과'
       END  DEPTNAME
FROM PROFESSOR
;

-- 교수 테이블에서 name , deptno , sal , bonus 출력
-- 소속 학과에 따라 보너스를 다르게 계산하여 출력하여라. (별명 --> bonus)
-- 학과 번호별로 보너스는 다음과 같이 계산한다.
-- 학과 번호가 101이면 보너스는 급여의 10%, 102이면 20%, 201이면 30%, 나머지 학과는 0
SELECT NAME, DEPTNO, SAL ,
       CASE WHEN DEPTNO = 101 THEN SAL * 0.1 
            WHEN DEPTNO = 102 THEN SAL * 0.2 
            WHEN DEPTNO = 201 THEN SAL * 0.3
            ELSE                    0
       END BONUS
FROM PROFESSOR
;

---------------------------------------------------------
---   8장. 그룹함수 **
---- 테이블의 전체 행을 하나 이상의 컬럼을 기준으로 그룹화하여
---   그룹별로 결과를 출력하는 함수
---------------------------------------------------------
-- 1) COUNT 함수
-- 테이블에서 조건을 만족하는 행의 갯수를 반환하는 함수
-- 문1) 101번 학과 교수중에서 보직수당을 받는 교수의 수를 출력하여라
SELECT COUNT(COMM) --NULL값을 빼고 출력
FROM   PROFESSOR
WHERE  DEPTNO = 101;
--문2) 101번 학과 교수중에서 교수의 수를 출력하여라

SELECT COUNT(*)
FROM  PROFESSOR
WHERE DEPTNO = 101;

--102번 학과 학생들의 몸무게 평균과 합계를 출력하여라 / NULL값이 있으면 빼고 계산됨
SELECT AVG(WEIGHT), SUM(WEIGHT)
FROM STUDENT
WHERE DEPTNO = 102;

-- 교수 테이블에서 급여의 표준편차와 분산을 출력
SELECT STDDEV(SAL), VARIANCE(SAL)
FROM PROFESSOR
;
--*학과별 학생들의 인원수, 몸무게 평균과 합계를 출력하여라
SELECT  DEPTNO, COUNT(*) , AVG(WEIGHT), SUM(WEIGHT)
FROM    STUDENT
GROUP BY DEPTNO
;
-- 교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라
SELECT DEPTNO, COUNT(*)학과별_교수_수, COUNT(COMM)보직수당_교수_수
FROM PROFESSOR
GROUP BY DEPTNO
;

-- 교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라
-- 단 학과별로 교수 수가 2명 이상인 학과만 출력
SELECT DEPTNO, COUNT(*), COUNT(COMM)
FROM PROFESSOR
GROUP BY DEPTNO
HAVING COUNT(*) > 1
;

-- 학생 수가 4명이상이고 평균키가 168이상인  학년에 대해서 학년, 학생 수, 평균 키, 평균 몸무게를 출력
-- 단, 평균 키와 평균 몸무게는 소수점 두 번째 자리에서 반올림 하고, 
-- 출력순서는 평균 키가 높은 순부터 내림차순으로 출력하고 
--   그 안에서 평균 몸무게가 높은 순부터 내림차순으로 출력
-- + 조건추가 1학년 이상 

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

-- ROLLUP 연산자
-- GROUP BY 절의 그룹 조건에 따라 전체 행을 그룹화하고 각 그룹에 대해 부분합을 구하는 연산자

-- 문1) 소속 학과별로 교수 급여 합계와 모든 학과 교수들의 급여 합계를 출력하여라

SELECT DEPTNO, SUM(SAL)
FROM  PROFESSOR
GROUP BY ROLLUP(DEPTNO)
;
--문2) ROLLUP 연산자를 이용하여 학과 및 직급별 교수 수, 학과별 교수 수, 전체 교수 수를 출력하여라
SELECT DEPTNO, POSITION, COUNT(*)
FROM PROFESSOR
GROUP BY ROLLUP (DEPTNO, POSITION)
;

-- CUBE 연산자 --전체합을 먼저 보여줌
-- ROLLUP에 의한 그룹 결과와 GROUP BY 절에 기술된 조건에 따라 그룹 조합을 만드는 연산자
-- 문1) CUBE 연산자를 이용하여 학과 및 직급별 교수 수, 학과별 교수 수, 전체 교수 수를 출력하여라.
SELECT DEPTNO, POSITION, COUNT(*)
FROM   PROFESSOR
GROUP BY CUBE(DEPTNO, POSITION)
;

--------------         Home Work           --------------------
--1. emp Table 의 이름을 대문자, 소문자, 첫글자만 대문자로 출력
SELECT upper(ename), lower(ename), INITCAP(ename)
FROM   emp 
;

--2. emp Table 의  이름, 업무, 업무를 2-5사이 문자 출력 
select ename, substr(job,2,4)
from emp
;
--3. emp Table 의 이름, 이름을 10자리로 하고 왼쪽에 #으로 채우기
select ename, lpad(ename,10,'#')
from emp
;

--4. emp Table 의  이름, 업무, 업무가 MANAGER면 관리자로 출력 replace 모름
select ename, REPLACE(JOB, 'MANAGER','관리자')
from emp
;
--5. emp Table 의  이름, 급여/7을 각각 정수, 소숫점 1자리. 10단위로   반올림하여 출력
SELECT ENAME, SAL/7,ROUND(SAL/7,0), ROUND(SAL/7,1),ROUND(SAL/7,-1)
FROM EMP
;
--6.  emp Table 의  이름, 급여/7을 각각 절사하여 출력
SELECT ENAME, SAL/7, TRUNC(SAL/7), TRUNC(SAL/7,1), TRUNC(SAL/7,-1)
FROM EMP
;
--7. emp Table 의  이름, 급여/7한 결과를 반올림,절사,ceil,floor
SELECT ENAME, SAL/7, ROUND(SAL/7), TRUNC(SAL/7), CEIL(SAL/7), FLOOR(SAL/7)
FROM EMP
;
--8. emp Table 의  이름, 급여, 급여/7한 나머지
SELECT ENAME, SAL, MOD(SAL,7)
FROM EMP
;
--9. emp Table 의 이름, 급여, 입사일, 입사기간(각각 날짜,월)출력,  소숫점 이하는 반올림
SELECT ENAME, SAL, HIREDATE, 
       ROUND(SYSDATE-HIREDATE),
       ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE),0)WORKING_dAY
       
FROM EMP
;

--10.emp Table 의  job 이 'CLERK' 일때 10% ,'ANALYSY' 일때 20%  
--'MANAGER' 일때 30% ,'PRESIDENT' 일때 40%
--'SALESMAN' 일때 50% 
--그외일때 60% 인상 하여 
-- empno, ename, job, sal, 및 각 급여인상를 출력하세요(CASE/Decode문 사용)****
SELECT EMPNO, ENAME, JOB, SAL,
      CASE JOB WHEN  'CLERK'    THEN   SAL*1.1
               WHEN  'ASALYSY'   THEN  SAL*1.2
               WHEN 'MANAGER'    THEN  SAL*1.3
               WHEN  'PRESIDENT' THEN  SAL*1.4
               WHEN  'SALESMAN'  THEN  SAL*1.6
           
           ELSE                        SAL*1.6
      END 급여인상
FROM EMP
;

SELECT EMPNO, ENAME, JOB, SAL,
    DECODE (JOB, 'CLERK'  ,    SAL*1.1,
                 'ASALYSY',    SAL*1.2,
                 'MANAGER',    SAL*1.3,
                 'PRESIDENT',  SAL*1.4,
                 'SALESMAN',   SAL*1.5,
                               SAL*1.6
           )급여인상
FROM EMP
;
-----------  Home Work   Group 함수   --------------------
-- 1. 최근 입사 사원과 가장 오래된 사원의 입사일 출력 (emp)
SELECT MAX(HIREDATE), MIN(HIREDATE)
FROM EMP
;

-- 2. 부서별 최근 입사 사원과 가장 오래된 사원의 입사일 출력 (emp)
SELECT DEPTNO, MAX(HIREDATE), MIN(HIREDATE)
FROM EMP
GROUP BY DEPTNO
;

-- 3. 부서별, 직업별 count & sum[급여] , 출력순서 --> 부서별, 직업별    (emp)
SELECT DEPTNO, JOB, COUNT(*), SUM(SAL)
FROM EMP
GROUP BY DEPTNO , JOB
ORDER BY DEPTNO, JOB
;
-- 4. 부서별 급여총액 3000이상 부서번호,부서별 최대급여   (emp)
SELECT DEPTNO,  MAX(SAL)최대급여
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL)>=3000
;

-- 5. 전체 학생을 소속 학과별로 나누고, 같은 학과 학생은 다시 학년별로 그룹핑하여, 
--   학과와 학년별 인원수, 평균 몸무게를 출력, 
--  (단, 평균 몸무게는 소수점 이하 첫번째 자리에서 반올림 )  STUDENT
select deptno, grade, count(*), round(avg(weight))
from student
group by deptno, grade
;


-----------  Home Work   Group 함수 END -------------------



------------------------------------------------------------------------------------
----    9-0.    DeadLock       실행중인 프로세서들이 무한히 대기하게 되는 현상    상호 점유..
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