CREATE TABLE ex_type
( c char(10),
  v VARCHAR2(10)
) 
;
-- Table 생성 명령어 
INSERT INTO ex_type
VALUES ('sql','sql')
;

-- 기본 SELECT 명령어
SELECT *        --보여줄 컬럼
FROM ex_type    --보여줄 테이블명 (전체 table대상)
WHERE c = 'sql' --보여줄 조건 
;

SELECT *        --보여줄 컬럼
FROM ex_type    --보여줄 테이블명 (전체 table대상)
WHERE v = 'sql' --보여줄 조건 
;
-- 면접에 가끔 나옴
SELECT *
FROM ex_type
WHERE c=v
;
 COMMENT ON COLUMN "SCOTT"."STUDENT"."STUDNO" IS '학번';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."NAME" IS '이름';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."USERID" IS 'USERID';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."GRADE" IS '학년';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."IDNUM" IS '주민번호';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."BIRTHDATE" IS '생년월일';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."TEL" IS '전화';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."HEIGHT" IS '키';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."WEIGHT" IS '몸무게';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."DEPTNO" IS '학과번호';
   COMMENT ON COLUMN "SCOTT"."STUDENT"."PROFNO" IS '교수번호';


?
--ROWID는 시스템이 내부적으로 가지고 있는 식별정보 같은 개념
--ROWNUM은 조회했을 때 순서, 숫자, 일련번호를 보여줌
--1부터 시작해야 결과값이 나옴,매우중요함. 1부터 시작하지 않으면 원하는 결과값이 나올 수 없음
-- 학생테이블로부터 모든 ROWID와 학번 출력
SELECT rownum, STUDNO, NAME
FROM student
WHERE ROWNUM = 1;
--ROWNUM은 1부터 시작해야 작동하는 제한사항이 있다*** 중요!

--
CREATE TABLE ex_time
(id            NUMBER(2), 
 basictime     TIMESTAMP,
 standardtime  TIMESTAMP WITH TIME ZONE,
 localtime     TIMESTAMP WITH LOCAL TIME ZONE
 );

--sysdate 오라클에서 가지고 있는 현재시간
 INSERT INTO ex_time
 VALUES(1,  sysdate  , sysdate  ,  systdate) 
 ;
 
 SELECT * FROM EX_TIME;
 
 
 SELECT UPPER('abc')
 FROM  dual;
 
--학생 테이블에서 1학년 학생만 검색하여 학번, 이름, 학과 번호를 출력
select studno, name, DEPTNO, grade
from   student
where  grade = '1';

--학생 테이블에서 몸무게가 70kg 이하인 학생만 검색하여 학번, 이름, 학년, 학과번호, 몸무게를 출력
select studno, name, grade, deptno, weight
from   student
where weight <= 70;

--학생 테이블에서 1학년 이면서 몸무게가 70kg 이상인 학생만 검색하여 이름, 학년, 몸무게, 학과번호를 출력
select name, grade, weight, deptno
from student
where grade='1' and weight >=70;

--학생 테이블에서 1학년이거나 몸무게가 70kg 이상인 학생만 검색하여 이름, 학년, 몸무게, 학과번호를 출력
select name, grade, weight, deptno
from student
where grade = '1' 
or weight >=70;

-- 학생 테이블에서 학과번호가 ‘101’이 아닌 학생의 학번과 이름과 학과번호를 출력
SELECT STUDNO, name, deptno
FROM student
WHERE NOT deptno = 101;

-- 몸무게가 50kg에서 70kg 사이인 학생의 학번, 이름, 몸무게를 출력
select studno, name, weight
from student
where weight >= 50 
and weight <= 70;

-- between 연산자를 사용하여 몸무게가 50kg에서 70kg 사이인 학생의 학번, 이름, 몸무게를 출력***
select studno, name, weight
from student
where weight between 50 and 70;

-- BETWEEN 학생테이블에서 81년에서 83년도에 태어난 학생의 이름과 생년월일을 출력
select name, BIRTHDATE
from student
where birthdate  between '81/01/01' and '83/12/31';

--101번 학과와 102번 학과와 201번 학과 
-- 학생의 이름, 학년, 학과번호를 출력
select name, grade, deptno
from student
where deptno = 101
or deptno = 102
or deptno = 201;

--in 연산자를 사용하여 101번 학과와 102번 학과와 201번 학과 ***
-- 학생의 이름, 학년, 학과번호를 출력
select name, grade, deptno
from student
where deptno in(101,102,201);

-- 학생 테이블에서 성이 ‘김’씨인 학생의 이름, 학년, 학과 번호를 출력 (like 'd%') 부분출력
select name, grade, deptno
from student
where name like '김%';

-- 학생 테이블에서 마지막 글자가  ‘경’인 학생의 이름, 학년, 학과 번호를 출력
select name, grade, deptno
from student
where name like '%경';

-- 학생 테이블에서 이름이 3글자, 성은 ‘김’씨고 
-- 마지막 글자가 ‘영’으로 끝나는 학생의 이름, 학년, 학과 번호를 출력
select name, grade, deptno
from student
--where name like '김%영';
where name like '김_영';

-- NULL 이해
--EMP TABLE에서 사번, 급여, 보너스 출력
select empno, sal, comm
from emp;

--EMP TABLE에서 사번, 급여, 보너스, 급여+보너스 출력
-- 문제점 : comm이 null일때 sal+comㅡ 도 null
select empno, sal, comm, sal+comm
from emp ;

--해결책 : comm이 null 일때 nvl(***) 또는 nvl2 사용 nvl(컬럼명, null값일때 대체될 값)
select empno, sal, comm, sal+nvl(comm, 0)
from emp;

-- comm이 null인것 비교
select *
from emp
where comm is null;
-- where comm =null; 잘못된 문장

-- COMM이 NULL아닌것 비교
select *
from emp
where comm is not null;

-- 교수 테이블에서 보직수당이 없는 교수의 이름, 직급, 보직수당을 출력
select  NAME, position, comm
from professor
where comm is null;
-- 교수 테이블에서 교수의 이름, 직급,급여, 급여+보직수당 --> NULL해결
--sal_com이라는 별명으로 출력
select name, position, sal, sal+nvl(comm,0) sal_com
from professor;

-- 102번 학과의 학생 중에서 
--1학년 또는 4학년 학생의 이름, 학년, 학과 번호를 출력
select name, grade, deptno
from student
where grade in( 1,4)
and deptno = 102;

select name, grade, deptno
from student
where deptno = 102
and (grade = '1' or grade = '4');

-- 1학년 이면서 몸무게가 70kg 이상인 학생의 집합--> Table stud_heavy
create table stud_heavy3
AS
    select *
    from student
    where grade = 1 
    and weight >=70;
    
-- 1학년 이면서 101번 학과에 소속된 학생 --> Table stud_101
create table stud_101
as
    select *
    from student
    where grade = 1 and deptno = 101;
    
-- 집합 연산자------------------- select 타입과 개수가 같아야 에러가 안뜸*
----중복제거
select studno, name, userid
from stud_heavy3
union 
select studno, name, userid
from stud_101;

--중복허용
select studno, name, userid
from stud_heavy3
union all
select studno, name, userid
from stud_101;

--공통
select studno, name, userid
from stud_heavy3
intersect
select studno, name, userid
from stud_101;

-- 차이 A(박동진, 서재진) - B(박미경, 서재진)
select studno, name, userid
from stud_heavy3
minus
select studno, name, userid
from stud_101;

-- 차이 B(박미경, 서재진)-A(박동진, 서재진)  
select studno, name, userid
from stud_101
minus
select studno, name, userid
from stud_heavy3;
-----------------------------------------------------------
--------- DML (데이터 조작어) ****
--------- 1. CRUD : SELECT / INSERT / DELETE / UPDATE
-----------------------------------------------------------------------
Insert into emp values
(1000,'강준우','clerk',7902,to_date('13-07-2023','dd-mm-yyyy'),3000,200,20);
---전체가아닌 일부 값만 넣을 경우 괄호 안에 컬럼을 적어줘야한다.
Insert into emp(EMPNO,ENAME,SAL,COMM,DEPTNO)values
(1100,'강한빛',3500,100,10);
Insert into emp(EMPNO,ENAME,SAL,COMM,DEPTNO)values
(1200,'TEST',3500,100,10);


--수정시 UPDATE 
UPDATE EMP
SET    JOB = 'PRESIDENT'
      ,MGR = 7839 
WHERE  EMPNO = 1100;

---- 삭제 DELETE
DELETE EMP
WHERE EMPNO = 1200;
--commit을 해야 다른트렌젝션에 반영됨
COMMIT;

