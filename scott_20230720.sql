---------  9-1. join *** ---------------------------------------------
----------------------------------------------------------------------
-- 1) 조인의 개념
--  하나의 SQL 명령문에 의해 여러 테이블에 저장된 데이터를 논리적으로 한번에 조회할수 있는 기능

-- ex1-1) 학번이 10101인 학생의 이름과 소속 학과 번호을 출력하여라
SELECT STUDNO, NAME, DEPTNO 
FROM STUDENT
WHERE STUDNO =10101
;
-- ex1-2)101번 학과번호를 가지고 학과이름을 출력하여라
SELECT DNAME
FROM DEPARTMENT
WHERE DEPTNO=101
;
-- ex1-3)  [ex1-1] + [ex1-2] 한방 조회  ---> Join
-- 학번이 10101인 학생의 이름, 소속 학과번호, 학과이름을 출력하여라
SELECT STUDNO, NAME,
       STUDENT.DEPTNO, DEPARTMENT.DNAME
FROM   STUDENT, DEPARTMENT
WHERE  STUDENT.DEPTNO = DEPARTMENT.DEPTNO;

--애매모호성(AMBIGUOUSLY)
SELECT STUDNO, NAME, DEPTNO, DNAME
FROM  STUDNET S, DEPARTMET D
WHERE S.DEPTNO = D.DEPTNO
;
--애매모호성(AMBIGUOUSLY) --> 해결 : 별명 (alias)
SELECT s.studno, s.name, d.deptno, d.dname
FROM  student s, department d
WHERE s.deptno = d.deptno
;

-- 전인하 학생의 학번, 이름, 학과 이름 그리고 학과 위치를 출력
select s.studno,s.name,d.dname,d.loc
from student s, department d
where s.deptno = d.deptno and s.name = '전인하'
;

-- 몸무게가 80kg이상인 학생의 학번, 이름, 체중, 학과 이름, 학과위치를 출력
select s.studno, s.name, s.weight, d.dname, d.loc
from student s, department d
where s.deptno = d.deptno and  s.weight >= 80
;

-- 카티션 곱  : 두 개 이상의 테이블에 대해 연결 가능한 행을 모두 결합, 개발초기 많은 data 생성을 위해 사용
-- student     16  department 7  >> 카티션 곱을 하게 되면 두 테이블간의 곱 (112), 모든 경우의 수를 보여줌
SELECT s.studno, s.name, d.dname, d.loc, s.weight, d.deptno
FROM   student s, department d
;
SELECT s.studno, s.name, d.dname, d.loc, s.weight, d.deptno
FROM   student s CROSS JOIN department d
;

-- *** equal join
-- 조인 대상 테이블에서 공통 칼럼을 ‘=‘(equal) 비교를 통해 같은 값을 가지는 행을 연결하여 결과를 생성하는 조인 방법
--  SQL 명령문에서 가장 많이 사용하는 조인 방법
-- 자연조인을 이용한 EQUI JOIN
-- 오라클 9i 버전부터 EQUI JOIN을 자연조인이라 명명
-- WHERE 절을 사용하지 않고  NATURAL JOIN 키워드 사용
-- 오라클에서 자동적으로 테이블의 모든 칼럼을 대상으로 공통 칼럼을 조사 후, 내부적으로 조인문 생성

select s.studno,s.name,d.deptno,d.dname
from student s, department d
where s.deptno = d.deptno 
;

-- Natural Join Convert Error
select s.studno,s.name, s.weight, d.dname, d.loc, d.deptno
from student s
     natural join department d
;

-- Natural Join Convert Error 해결
select s.studno, s.name, s.weight, d.dname, d.loc, deptno
from student s
     natural join department d
;

--ANSI EQUI JOIN
select s.studno, s.name, s.weight, d.dname, d.loc, d.deptno
from student s inner join department d
on   s.deptno = d.deptno
;

-- NATURAL JOIN을 이용하여 교수 번호, 이름, 학과 번호, 학과 이름을 출력하여라
select p.profno, p.name, d.dname, deptno
from professor p
     natural join department d
;

-- NATURAL JOIN을 이용하여 4학년 학생의 이름, 학과 번호, 학과이름을 출력하여라
SELECT s.name, deptno, d.dname
FROM student s
     natural join department d
WHERE grade = '4'
;

-- JOIN ~ USING 절을 이용한 EQUI JOIN
-- USING절에 조인 대상 칼럼을 지정
-- 칼럼 이름은 조인 대상 테이블에서 동일한 이름으로 정의되어 있어야함
-- 문1) JOIN ~ USING 절을 이용하여 학번, 이름, 학과번호, 학과이름, 학과위치를
--       출력하여라
select s.studno, s.name, deptno, dname
from   student s    join department d
                     using(deptno)
;

-- EQUI JOIN의 4가지 방법을 이용하여 성이 ‘김’씨인 학생들의 이름, 학과번호,학과이름을 출력
-- 1) WHERE 절을 사용한 방법
select s.name, d.deptno, d.dname
from student s, department d
where s.deptno = d.deptno 
and s.name like '김%'
;

-- 2) natural join 절을 사용한 방법
select s.name, deptno, d.dname
from student s
     natural join department d
where s.name like '김%'
;

-- 3) join~using 절을 사용한 방법
select s.name, deptno, d.dname
from student s  join department d
                 using(deptno)
where s.name like '김%'
;

--4) ansi join (inner join ~ on) --> 시험 /표준작업
select s.name, d.deptno, d.dname
from   student s inner join department d
on     s.deptno = d.deptno
where  s.name like '김%'
;

-------------------------------------------------------------
-- NON-EQUI JOIN **
-- ‘<‘,BETWEEN a AND b 와 같이 ‘=‘ 조건이 아닌 연산자 사용

--문1. 교수 테이블과 급여 등급 테이블을 NON-EQUI JOIN하여 교수별로 급여 등급을 출력하여라

select  p.profno, p.name, p.sal, s.grade
from professor p, salgrade s
where p.sal between s.losal and s.hisal
;

---------------------------------------------------------------------------
-- OUTER JOIN  ***
-- EQUI JOIN에서 양측 칼럼 값중의 하나가 NULL 이지만 조인 결과로 출력할 필요가 있는 경우
-- OUTER JOIN 사용

-- 기본예시  (OUTER JOIN 사용 목적) 
SELECT ENAME, JOB, SAL, E.DEPTNO, DNAME, LOC
FROM   EMP E, DEPT D
WHERE  E.DEPTNO = D.DEPTNO
;
-- 문제점 : 지도교수를 배정받은 학생만 출력
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO = P.PROFNO
;

-- 문제점 : 지도교수를 배정받은 학생만 출력 --> OUTER JOIN 해결
-- 학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수의 이름, 직급을 출력
-- 단, 지도교수가 배정되지 않은 학생이름도 함께 출력하여라.

--1) LEFT OUTER JOIN
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO = P.PROFNO(+) 
;
--2) RIGHT OUTER JOIN
-- PROFESSOR(PROFNO:9901)
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO(+) = P.PROFNO 
; 
--3) FULL OUTER JOIN
-- PROFESSOR(PROFNO:9901)
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO(+) = P.PROFNO(+)
;

--- ANSI OUTER JOIN
-- 1. ANSI LEFT OUTER JOIN


SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S
     LEFT OUTER JOIN PROFESSOR P
     ON S.PROFNO = P.PROFNO 
;


-- 2. ANSI RIGHT OUTER JOIN
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S
     RIGHT OUTER JOIN PROFESSOR P
     ON S.PROFNO = P.PROFNO 
;

-- 3. ANSI FULL OUTER JOIN
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S
     FULL OUTER JOIN PROFESSOR P
     ON S.PROFNO = P.PROFNO 
;

---- <<<   FULL OUTER JOIN  >>> -------------------------------
--학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수 이름, 직급을 출력
-- 단, 지도학생을 배정받지 않은 교수 이름 및 
--  지도교수가 배정되지 않은 학생이름  함께 출력하여라
--  Oracle 지원 안 함
--1) FULL OUTER JOIN
select s. name, s.grade, p.name, p.position
FROM STUDENT S
    FULL OUTER JOIN PROFESSOR P
    ON S.PROFNO = P.PROFNO
;

--2)FULL OUTER 모방 (일반 sql)--->Union
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO = P.PROFNO(+)
UNION
SELECT S.NAME, S.GRADE, P.NAME, P.POSITION
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO(+) = P.PROFNO
;

-------                    SELF JOIN : 조직도  **           ----------------       
-- 하나의 테이블내에 있는 칼럼끼리 연결하는 조인이 필요한 경우 사용
-- 조인 대상 테이블이 자신 하나라는 것 외에는 EQUI JOIN과 동일
SELECT c.deptno, c.dname, c.college, d.dname college_name
            --학과            --학부
FROM department c, department d
WHERE c.college = d.deptno
;

-- SELF JOIN --> 부서 번호가 201 이상인 부서 이름과 상위 부서의 이름을 출력
-- 결과 : xxx소속은 xxx학부
select concat(concat(c.dname,'의 소속은 '), d.dname)
from department c, department d
where c.college = d.deptno 
and c.deptno >= 201
;

select deptno.dname||'의 소속은'|| org.dname
from   department dep, department org
where dep.college = org.deptno
and dep.deptno >= 201
;

create table salgrade2
   (    grade number(2,0),
        losal number(5,0),
        hisal number(5,0)
    );

INSERT INTO SALGRADE2 VALUES(1, 800, 2000);
INSERT INTO SALGRADE2 VALUES(2, 2001,3500);
INSERT INTO SALGRADE2 VALUES(3, 3501,5500);
COMMIT;


-- 1. 이름, 관리자명(emp TBL)
SELECT w.ename, m.ename 관리자
FROM emp w, emp m
WHERE W.MGR = M.EMPNO
;
-- 1. 이름, 관리자명(emp TBL)
-- 7902	FORD	ANALYST	7566
-- 7566	JONES	MANAGER	7839
SELECT   w.empno,w.ename, m.empno, m.ename 관리자 
--     7902	FORD       7566	JONES
FROM     emp w,         emp m 
WHERE    w.mgr = m.empno;

-- 2. 이름,급여,부서코드,부서명,근무지, 관리자 --> 전체직원(emp ,dept TBL)
SELECT e.ename, e.sal, d.deptno, d.dname, loc, m.ename
FROM emp e, emp m, dept d
WHERE e.mgr=m.empno(+)
AND   e.deptno =d.deptno
;

-- 3. 이름,급여,등급,부서명,관리자명, 급여가 2000이상인 사람 (emp, dept,salgrade2 TBL) >> 결합을 어떻게 시키진?
SELECT e.ename, e.sal, s.grade, d.dname, m.ename
FROM emp e, emp m, dept d, salgrade2 s
WHERE e.mgr = m.empno(+)
AND e.deptno = d.deptno
AND e.sal > = 2000 
AND e.sal BETWEEN s.losal AND S.hisal
;

SELECT e.ename, e.sal, s.grade, d.dname, m.ename
FROM emp e, emp m, dept d, salgrade2 s
WHERE e.deptno = d.deptno
AND   e.ename = m.ename
AND  e.sal >= 2000
AND   e.sal BETWEEN s.losal AND s.hisal 
;

-- 4. 보너스를 받는 사원에 대하여 이름,comm, 부서명,위치를 출력하는 SELECT 문장을 작성 (emp ,dept TBL)
SELECT e.ename,e.comm, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.comm is not null
;


-- 5. 사번, 사원명, 부서코드, 부서명을 검색하라. 사원명기준으로 오름차순정열(emp ,dept TBL)
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY e.ename
;
-----------------------------------------------------------------
----- SUB Query   ***
-- 하나의 SQL 명령문의 결과를 다른 SQL 명령문에 전달하기 위해 
-- 두 개 이상의 SQL 명령문을 하나의 SQL명령문으로 연결하여
-- 처리하는 방법
-- 종류 
-- 1) 단일행 서브쿼리
-- 2) 다중행 서브쿼리
-------------------------------------------------------------------
--1. 목표 : 교수 테이블에서 '전은지' 교수와 직급이 동일한 모든 교수의 이름 검색
-- 1-1 교수 테이블에서 ‘전은지’ 교수의 직급 검색 SQL 명령문 실행
    select position
    from professor
    where name = '전은지'
    ;
-- 1-2 교수 테이블의 직급 칼럼에서 1에서 얻은 결과 값과 동일한 직급을 가진 교수 검색 명령문 실행
    select name, position
    from professor
    where position = '전임강사'
    ;
--1. 목표 : 교수 테이블에서 '전은지' 교수와 직급이 동일한 모든 교수의 이름 검색 >> sub query
    select name, position
    from professor
    where position = (
                        select position
                        from professor
                        where name = '전은지' 
                      )
    ;

-- 종류 
-- 1) 단일행 서브쿼리
--  서브쿼리에서 단 하나의 행만을 검색하여 메인쿼리에 반환하는 질의문
--  메인쿼리의 WHERE 절에서 서브쿼리의 결과와 비교할 경우에는 반드시 단일행 비교 연산자 중 
--  하나만 사용해야함

--  문1) 사용자 아이디가 ‘jun123’인 학생과 같은 학년인 학생의 학번, 이름, 학년을 출력하여라
    select studno, name, grade
    from student
    where grade = ( 
                     select grade
                     from student
                     where userid = 'jun123'
                   )
    ;
    
--  문2)  101번 학과 학생들의 평균 몸무게보다 몸무게가 적은 학생의 이름, 학년 , 학과번호, 몸무게를  출력
--  조건 : 학과별 출력
    select name, grade, deptno, weight
    from student
    where weight < ( 
                    select  avg(weight)
                    from student
                    where deptno = '101'
                    )
    order by deptno
    ;
    
--  문3) 20101번 학생과 학년이 같고, 키는 20101번 학생보다 큰 학생의 
-- 이름, 학년, 키를 출력하여라
--  조건 : 학과별 출력
    select name, grade, height
    from student
    where grade = ( select grade
                    from student
                    where studno = '20101'
                )
    and height >  (
                    select height
                    from student
                    where studno = '20101'
                    )
   order by deptno
   ;
   
-- 문4) 101번 학과 학생들의 평균 몸무게보다 몸무게가 적은 학생의 이름, 학과번호, 몸무게를 출력하여라
--  조건 : 학과별 출력
    select name, deptno, weight
    from student
    where weight < (
                    select avg(weight)
                    from student
                    where deptno = '101'
                    )
    order by deptno
    ;
    
-- 2) 다중행 서브쿼리
-- 서브쿼리에서 반환되는 결과 행이 하나 이상일 때 사용하는 서브쿼리
-- 메인쿼리의 WHERE 절에서 서브쿼리의 결과와 비교할 경우에는 다중 행 비교 연산자 를 사용하여 비교
-- 다중 행 비교 연산자 : IN, ANY, SOME, ALL, EXISTS
-- 1) IN               : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 하나라도 일치하면 참, ‘=‘비교만 가능
-- 2) ANY, SOME  : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 하나라도 일치하면 참
-- 3) ALL             : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 모든값이 일치하면 참, 
-- 4) EXISTS        : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 만족하는 값이 하나라도 존재하면 참

-- 1.  IN 연산자를 이용한 다중 행 서브쿼리
--"single-row subquery returns more than one row"
select name, grade, deptno
from student
where deptno = (
                select deptno
                from department
                where college = 100
               ) ;
               
select name, grade, deptno
from student
where deptno in (101,102 ) ;
               
select name, grade, deptno
from student
where deptno in (
                select deptno
                from department
                where college = 100
               ) ;

--  2. ANY 연산자를 이용한 다중 행 서브쿼리
-- 문)모든 학생 중에서 4학년 학생 중에서 키가 제일 작은 학생보다 키가 큰 학생의 학번, 이름, 키를 출력하여라
select studno, name, height
from student
where height > any (
                    --175,176,177 -->min 생각  이 중 어떤것보다도 큰것 
                    select height
                    from student
                    where grade = '4'
                    );

-- 3. ALL 연산자를 이용한 다중 행 서브쿼리
select studno, name, height
from student
where height > all (
                    --175,176,177 -->min 생각 이 모든 것 전체보다 큰 것
                    select height
                    from student
                    where grade = '4'
                    );

--4. EXISTS 연산자를 이용한 다중 행 서브쿼리*
-- 서브쿼리에 검색된 결과가 하나라도 존재하면 메인쿼리 조건절이 참이 되는 연산자
SELECT PROFNO, NAME, SAL, COMM, POSITION
FROM   PROFESSOR
WHERE  EXISTS (
                SELECT POSITION
                FROM   PROFESSOR
                WHERE  COMM IS NOT NULL
              ) ;
              
              
-- 문1)  보직수당을 받는 교수가 한 명이라도 있으면 
--       모든 교수의 교수 번호, 이름, 보직수당 그리고 급여와 보직수당의 합(NULL처리)을 출력             

SELECT PROFNO, NAME, SAL, COMM, SAL+NVL(COMM,0)
FROM  PROFESSOR
WHERE EXISTS (
                SELECT PROFNO
                FROM   PROFESSOR
                WHERE  COMM IS NOT NULL
            )
;

-- 문2) 학생 중에서 ‘goodstudent’이라는 사용자 아이디가 없으면 1을 출력하여라
SELECT 1 USERID_EXIST
FROM DUAL
WHERE NOT EXISTS (
              SELECT USERID
              FROM   STUDENT
              WHERE  USERID = 'goodstudent'
                )
;