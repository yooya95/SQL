   -- 다중 컬럼 서브쿼리
-- 서브쿼리에서 여러 개의 칼럼 값을 검색하여 메인쿼리의 조건절과 비교하는 서브쿼리
-- 메인쿼리의 조건절에서도 서브쿼리의 칼럼 수만큼 지정
-- 종류
-- 1) PAIRWISE : 칼럼을 쌍으로 묶어서 동시에 비교하는 방식
-- 2) UNPAIRWISE : 칼럼별로 나누어서 비교한 후, AND 연산을 하는 방식

-- 1) PAIRWISE 다중 칼럼 서브쿼리
-- 문1)    PAIRWISE 비교 방법에 의해 학년별로 몸무게가 최소인 
--          학생의 이름, 학년, 몸무게를 출력하여라 

SELECT NAME, GRADE, WEIGHT
FROM STUDENT
WHERE( GRADE, WEIGHT) IN (SELECT   GRADE, MIN(WEIGHT)
                          FROM     STUDENT
                          GROUP BY GRADE)
;

--  2) UNPAIRWISE : 칼럼별로 나누어서 비교한 후, AND 연산을 하는 방식
-- UNPAIRWISE 비교 방법에 의해 학년별로 몸무게가 최소인 학생의 이름, 학년, 몸무게를 출력
SELECT name, grade, weight
FROM   student
--        1,2,3,4
WHERE grade  IN (  SELECT   grade
                   FROM     student
                   GROUP BY grade)
--                              52,42,70,72              
AND  weight  IN (  SELECT   MIN(weight)
                   FROM     student
                   GROUP BY grade)
;

-- 상호연관 서브쿼리     ***
-- 메인쿼리절과 서브쿼리간에 검색 결과를 교환하는 서브쿼리
-- 문1)  각 학과 학생의 평균 키보다 키가 큰 학생의 이름, 학과 번호, 키를 출력하여라
-- 실행 순서 1 -> select문from문 먼저 실행
-- 실행순서 3 -> 전체로 조회
SELECT deptno, name, grade, height
FROM   student s1
WHERE  height > (SELECT AVG(height)
                 FROM   student s2
                 -- WHERE S2.DEPTNO = 101
                 --                 실행순서2 - > 서브쿼리 실행
                 WHERE s2.deptno = s1.deptno
                 )
ORDER BY deptno
;

--TEST
SELECT DEPTNO, NAME, GRADE, HEIGHT
FROM  STUDENT
WHERE  HEIGHT > ( SELECT DEPTNO, AVG(HEIGHT)
                  FROM STUDENT
                  GROUP BY DEPTNO
                 )
ORDER BY DEPTNO
;

----------------------  HW  (EMP) -------------------------
-- 1. Blake와 같은 부서에 있는 모든 사원에 대해서 사원 이름과 입사일을 디스플레이하라
SELECT ename, hiredate
FROM  emp
WHERE deptno = (
                 SELECT deptno
                 FROM emp 
                 WHERE  INITCAP(ename) = 'BLAKE'
                )
;


-- 2. 평균 급여 이상을 받는 모든 사원에 대해서 사원 번호와 이름을 디스플레이하는 질의문을 생성. 
--    단 출력은 급여 내림차순 정렬하라

SELECT empno, ename, sal
FROM emp e1
WHERE sal >= (
               SELECT AVG(sal)
               FROM emp e2
               WHERE e1.deptno = e2.deptno
               )
ORDER BY sal DESC
;

SELECT empno, ename, sal
FROM   emp
WHERE  sal >  ( SELECT AVG(sal)
               FROM  emp
               )
ORDER BY sal desc;

-- 3. 보너스를 받는 어떤 사원의 부서 번호와 
--    급여에 일치하는 사원의 이름, 부서 번호 그리고 급여를 디스플레이하라.
SELECT ename, deptno ,sal
FROM emp e1
WHERE sal in (
               SELECT sal
               FROM   emp e2
               WHERE  e1.deptno = e2.deptno
               AND comm is not null
             )
;

SELECT ename, deptno, sal
FROM emp
WHERE (deptno, sal) IN
            	( SELECT deptno, sal
             	  FROM emp
            	  WHERE comm IS NOT NULL
                 );
    
--  데이터 조작어 (DML:Data Manpulation Language)  **                  ----------
-- 1.정의 : 테이블에 새로운 데이터를 입력하거나 기존 데이터를 수정 또는 삭제하기 위한 명령어
-- 2. 종류 
--  1) INSERT : 새로운 데이터 입력 명령어
--  2) UPDATE : 기존 데이터 수정 명령어
--  3) DELETE : 기존 데이터 삭제 명령어
--  4) MERGE : 두개의 테이블을 하나의 테이블로 병합하는 명령어

-- 1) Insert
--not enough values
INSERT INTO DEPT VALUES (71, '인사' );
INSERT INTO DEPT VALUES (71, '인사', '이대');
INSERT INTO DEPT (deptno, Dname) VALUES (72, '회계팀');
INSERT INTO DEPT (deptno, Dname, LOC) VALUES (75, '자재팀','신대방');
--unique constraint (SCOTT.PK_DEPT) violated (유니크 제약조건 위반)
INSERT INTO DEPT (deptno, LOC, Dname) VALUES (75, '충정로','회계팀');
INSERT INTO DEPT (deptno, LOC) VALUES (73,'홍대');
INSERT INTO DEPT (LOC, deptno) VALUES ('당산',77);

INSERT INTO PROFESSOR (profno,  name,   position, hiredate,                       deptno)
              VALUES  (9920  , '최윤식', '조교수',  TO_DATE('2006/01/01','YYYY/MM/DD'),102);
INSERT INTO PROFESSOR (profno,  name,   position, hiredate, deptno)              
              VALUES  (9910  , '백미선', '전임강사', sysdate, 101);

DROP   TABLE JOB3;

CREATE TABLE JOB3
(  jobno     NUMBER(2)     PRIMARY KEY,
   jobname   VARCHAR2(20)
) ;

INSERT INTO JOB3 (JOBNO, JOBNAME) VALUES (10,'학교');
INSERT INTO JOB3                  VALUES (11,'공무원');
INSERT INTO JOB3                  VALUES (12,'공무원');
INSERT INTO JOB3 (JOBNAME, JOBNO) VALUES ('대기업',13);
INSERT INTO JOB3 (JOBNO, JOBNAME) VALUES (14,'중소기업');

CREATE TABLE Religion
( religion_no     NUMBER(2)   CONSTRAINT PK_ReligionNO3 PRIMARY KEY,
  religion_name VARCHAR2(20)
)
;  

INSERT INTO Religion                             VALUES (10,'기독교');
INSERT INTO Religion                             VALUES (20,'가톨릭교');
INSERT INTO Religion(religion_no, religion_name) VALUES (30,'불교');
INSERT INTO Religion(religion_no, religion_name) VALUES (40,'무교');

commit;
ROLLBACK;

--------------------------------------------------
-----   다중 행 입력                                           ------
--------------------------------------------------
-- 1. 생성된 TBL이용 신규 TBL 생성 
-- 기본요소만 복사됨 pk 복사 x
create Table dept_second
AS SELECT * FROM dept;


--2. TBL 가공 생성
create Table emp20
AS 
        SELECT empno, ename, sal*12 annsal
        FROM   emp
        WHERE  deptno = 20;
        
-- 3. TBL 구조만
create Table dept30
AS  
       SELECT deptno, dname
       FROM   dept
       WHERE  0=1; -- (거짓) 
       
       --WEHRE 조건이 거짓이면 데이터 출력 X 참이면 데이터 출력 O

-- 4. Column 추가
ALTER TABLE dept30
ADD(birth Date);

INSERT INTO dept30  VALUES(10,'중앙학교',sysdate);
INSERT INTO dept30  VALUES(20,'중앙정보학교',sysdate);

--5 Column 변경 --> 기존 data보다 적게는 안됨
ALTER TABLE dept30
Modify dname varchar2(11)
;

ALTER TABLE dept30
Modify dname varchar2(30)
;

--real data 맞추기 --> 기존 데이터의 max값보다는 크게 줄여야한다. 최소한 같게 줄여야한다.
ALTER TABLE dept30
Modify dname varchar2(18)
;

--6 Column 삭제
ALTER TABLE dept30
Drop Column dname;

--7. TBL 명 변경
RENAME dept30 TO dept35;

--8. TBL 제거
DROP Table dept35;

--9. Truncate
TRUNCATE TABLE DEPT_SECOND;

CREATE TABLE height_info
( studNo        number(5),
    sname       VARCHAR2(20),
  height        number (5,2)
);

CREATE TABLE Weight_info
( studNo        number(5),
    sname       VARCHAR2(20),
  weight        number (5,2)
);

-- INSERT ALL(unconditional INSERT ALL) 명령문
-- 서브쿼리의 결과 집합을 조건없이 여러 테이블에 동시에 입력
-- 서브쿼리의 컬럼 이름과 데이터가 입력되는 테이블의 칼럼이 반드시 동일해야 함
INSERT ALL
INTO   height_info VALUES (Studno, name, height)
INTO   weight_info VALUES (Studno, name, weight)
SELECT studno, name, height, weight
FROM   student
WHERE  grade >=2
;

DELETE height_info;
DELETE weight_info;

-- INSERT ALL 
-- [WHEN 조건절1 THEN
-- INTO [table1] VLAUES[(column1, column2,…)]
-- [WHEN 조건절2 THEN
-- INTO [table2] VLAUES[(column1, column2,…)]
-- [ELSE
-- INTO [table3] VLAUES[(column1, column2,…)]
-- subquery;

-- 학생 테이블에서 2학년 이상의 학생을 검색하여 
-- height_info 테이블에는 키가 170보다 큰 학생의 학번, 이름, 키를 입력
-- weight_info 테이블에는 몸무게가 70보다 큰 학생의 학번, 이름, 몸무게를 
-- 각각 입력하여라
INSERT ALL
WHEN height > 170 Then
    INTO  height_info VALUES(studno, name, height)
WHEN weight > 70 Then
    INTO  weight_info VALUES(studno, name, weight)
SELECT studno, name, height, weight
FROM student
WHERE grade >='2'
;


-- 데이터 수정 개요
-- UPDATE 명령문은 테이블에 저장된 데이터 수정을 위한 조작어
-- WHERE 절을 생략하면 테이블의 모든 행을 수정
--- Update 
-- 문1) 교수 번호가 9903인 교수의 현재 직급을 ‘부교수’로 수정하여라
update professor 
set    position ='부교수'
where  profno = 9903
;

--  문2) 서브쿼리를 이용하여 학번이 10201인 학생의 학년과 학과 번호를
--        10103 학번 학생의 학년과 학과 번호와 동일하게 수정하여라
-- 10201  김진영  simply 2  102
-- 10103  김영균  mandu  3  101
update student
set    (grade, deptno) = (
                            select grade, deptno
                            from   student
                            where  studno = 10103 --primary 키가 where절로 들어가면 single raw로 들어가기때문에 =로 가능하다
                         )
where  studno = 10201;

-- 데이터 삭제 개요
-- DELETE 명령문은 테이블에 저장된 데이터 삭제를 위한 조작어
-- WHERE 절을 생략하면 테이블의 모든 행 삭제

-- 문1) 학생 테이블에서 학번이 20103인 학생의 데이터를 삭제
DELETE
FROM  student
WHERE studno = 20103;

---문2) 학생 테이블에서 컴퓨터공학과에 소속된 학생을 모두 삭제하여라.
DELETE
FROM student 
WHERE DEPTNO = ( 
                SELECT DEPTNO
                FROM  DEPARTMENT
                WHERE DNAME = '컴퓨터공학과'    
               )
;
ROLLBACK;

----------------------------------------------------------------------------------
---- MERGE
--  1. MERGE 개요
--     구조가 같은 두개의 테이블을 비교하여 하나의 테이블로 합치기 위한 데이터 조작어
--     WHEN 절의 조건절에서 결과 테이블에 해당 행이 존재하면 UPDATE 명령문에 의해 새로운 값으로 수정,
--     그렇지 않으면 INSERT 명령문으로 새로운 행을 삽입
------------------------------------------------------------------------------------

-- 1] MERGE 예비작업 
--  상황 
-- 1) 교수가 명예교수로 2행 Update
-- 2) 김도경 씨가 신규 Insert

CREATE Table professor_temp
AS SELECT * FROM professor
   WHERE position = '교수';

UPDATE professor_temp
SET    position = '명예교수'
WHERE  position = '교수'
;

INSERT INTO professor_temp
VALUES (9999,'유희라','arom21','전임강사',200, sysdate, 10, 101)
;

commit;

-- 2] professor MERGE 수행 
-- 목표 : professor_temp에 있는 직위   수정된 내용을 professor Table에 Update
--                         유희라 씨가 신규 Insert 내용을 professor Table에 Insert
-- 1) 교수가 명예교수로 2행 Update
-- 2) 김도경 씨가 신규 Insert

MERGE INTO professor p --기준
USING professor_temp f --merge를 사용할 테이블
ON   (p.profno = f. profno)
WHEN MATCHED THEN --pk 가 같으면 직위를 update
        UPDATE SET p.position = f.position
WHEN NOT MATCHED THEN -- pk가 없으면 신규 insert
        INSERT VALUES( f.profno, f.name, f.userid, f.position, f.sal, f.hiredate, f.comm, f.deptno)
 ;       
      
---------------------------------------------------------------------------------
-- 트랜잭션 개요  ***
-- 관계형 데이터베이스에서 실행되는 여러 개의 SQL명령문을 하나의 논리적 작업 단위로 처리하는 개념
-- COMMIT : 트랜잭션의 정상적인 종료
--               트랜잭션내의 모든 SQL 명령문에 의해 변경된 작업 내용을 디스크에 영구적으로 저장하고 
--               트랜잭션을 종료
--               해당 트랜잭션에 할당된 CPU, 메모리 같은 자원이 해제
--               서로 다른 트랜잭션을 구분하는 기준
--               COMMIT 명령문 실행하기 전에 하나의 트랜잭션 변경한 결과를
--               다른 트랜잭션에서 접근할 수 없도록 방지하여 일관성 유지
 
-- ROLLBACK : 트랜잭션의 전체 취소
--                   트랜잭션내의 모든 SQL 명령문에 의해 변경된 작업 내용을 전부 취소하고 트랜잭션을 종료
--                   CPU,메모리 같은 해당 트랜잭션에 할당된 자원을 해제, 트랜잭션을 강제 종료
---------------------------------------------------------------------------------

SELECT *
FROM TAB;

DESC student


