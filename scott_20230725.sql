-- FK  ***
-- 1. Restrict : 자식 존재 삭제 안됨  (연관 관계 때문)
--    1) 선언   Emp Table에서  REFERENCES DEPT (DEPTNO) 
--    2) 예시   integrity constraint (SCOTT.FK_DEPTNO) violated - child record found

DELETE dept WHERE deptno = 10;


-- 2. Cascading Delete : 같이 죽자
--    1)종속삭제 선언 : Emp Table에서 REFERENCES DEPT (DEPTNO) ON DELETE CASCADE
DELETE dept WHERE deptno = 73;

-- 3.  SET NULL    (
--    1) 종속 NULL 선언 : Emp Table에서 REFERENCES DEPT (DEPTNO)  ON DELETE SET NULL
DELETE dept WHERE deptno = 63;

---------------------------------------------------
--                            Backup Dir 생성 
---------------------------------------------------
-- Oracle 부분 Backup후  부분 Restore  (scott)
--실행 - cmd 작업
--C:\Users\admin>cd C:\oraclexe\mdbackup
--C:\oraclexe\mdbackup>exp scott/tiger@xe file=address.dmp tables=address

--2) Oracle 부분 Restore  (scott)
--C:\oraclexe\mdbackup>imp scott/tiger@xe file=address.dmp full=y
--C:\oraclexe\mdbackup>imp scott/tiger@xe file=address.emp full=y
--------------------------------------------------------------
--전체백업/복구
----------------------------------------------------------------
--1)Admin 권한
--    [1] Backup Dir 생성
--    [2] 권한부여
--CREATE OR REPLACE Directory mdbackup as 'C:\oraclexe\mdbackup';
--GRANT read,write ON DIRECTORY mdbackup TO scott;

--2) scott 전체 Backup 
--   C:\oraclexe\mdbackup>EXPDP scott/tiger DIRECTORY=mdbackup DUMPFILE=scott.dmp

--3)  scott 전체 Restore
--    C:\oraclexe\mdbackup> IMPDP scott/tiger DIRECTORY=mdbackup DUMPFILE=scott.dmp

-----------------------------------------------------------------------------------------
--   11. View 
------------------------------------------------------------------------------
-- View : 하나 이상의 기본 테이블이나 다른 뷰를 이용하여 생성되는 가상 테이블
--        뷰는 데이터딕셔너리 테이블에 뷰에 대한 정의만 저장
--       장점 :   보안 
--       단점 :   Performance(성능)은 더 저하

CREATE OR REPLACE VIEW VIEW_PROFESSOR AS
SELECT profno, name, userid, position, hiredate, deptno
FROM   professor;

CREATE OR REPLACE VIEW VIEW_PROFESSOR2 AS
SELECT name, userid, position, hiredate, deptno
FROM   professor;

-- 조회하는 순간 professor가 받아서 전체적으로 실행
SELECT*FROM VIEW_PROFESSOR ;
-- 특성 1. 원래 table [professor]에 입력 가능, 하지만 제약조건은 그대로 따름!
-- 제약조건에 걸리지 않는다면 뷰를 통한 입력 가능

INSERT INTO view_professor
VALUES(2000, 'view', 'userid','position',sysdate,101);

INSERT INTO view_professor (profno, userid, position, hiredate, deptno)
VALUES(2001, 'userid','position',sysdate,101);

INSERT INTO view_professor (profno, userid, position, hiredate, deptno)
VALUES(2002, 'userid','position',sysdate,101);

---- VIEW 이름 v_emp_sample  : emp(empno , ename , job, mgr,deptno)
CREATE OR REPLACE VIEW v_emp_sample 
AS
SELECT empno, ename, job, mgr, deptno
FROM emp;

--- 복합 View  / 통계뷰 -->insert 안됨
CREATE OR REPLACE VIEW v_emp_complex
AS
SELECT *
FROM emp NATURAL JOIN dept;

SELECT*FROM v_emp_complex;

INSERT INTO v_emp_compelex (empno, ename, deptno)
            VALUES         (1500,     '홍길동',20);
INSERT INTO v_emp_compelex (deptno, dname, loc)
            VALUES         (77,     '공무팀','낙성대');     
INSERT INTO v_emp_compelex (empno, ename, deptno, dname, loc)
            VALUES         (1500,'홍길동', 77, '공무팀','낙성대');

------------     View  HomeWork     ----------------------------------------------------
---문1)  학생 테이블에서 101번 학과 학생들의 학번, 이름, 학과 번호로 정의되는 단순 뷰를 생성
---     뷰 명 :  v_stud_dept101
CREATE OR REPLACE VIEW v_stud_dept101
AS
SELECT studno, name, deptno
FROM student 
WHERE deptno = 101
;



--문2) 학생 테이블과 부서 테이블을 조인하여 102번 학과 학생들의 학번, 이름, 학년, 학과 이름으로 정의되는 복합 뷰를 생성
--      뷰 명 :   v_stud_dept102
CREATE OR REPLACE VIEW v_stud_dept102
AS
SELECT s.studno, s.name, s.grade, d.dname
FROM student s, department d
WHERE s.deptno = d. deptno 
AND  s.deptno = 102 ;


--문3)  교수 테이블에서 학과별 평균 급여와     총계로 정의되는 뷰를 생성
--  뷰 명 :  v_prof_avg_sal       Column 명 :   avg_sal      sum_sal

CREATE OR REPLACE VIEW v_stud_dept102
AS
SELECT s.studno, s.name, s.grade, d.dname
FROM student s, department d
WHERE s.deptno = d. deptno 
AND  s.deptno = 102 ;

--view 삭제
DROP VIEW v_stud_dept102;

SELECT view_name, text
FROM USER_VIEWS;


-------------------------------------
---- 계층적 질의문*
-------------------------------------
-- 1. 관계형 데이터 베이스 모델은 평면적인 2차원 테이블 구조
-- 2. 관계형 데이터 베이스에서 데이터간의 부모 관계를 표현할 수 있는 칼럼을 지정하여 
--    계층적인 관계를 표현
-- 3. 하나의 테이블에서 계층적인 구조를 표현하는 관계를 순환관계(recursive relationship)
-- 4. 계층적인 데이터를 저장한 칼럼으로부터 데이터를 검색하여 계층적으로 출력 기능 제공

-- 사용법
-- SELECT 명령문에서 START WITH와 CONNECT BY 절을 이용
-- 계층적 질의문에서는 계층적인 출력 형식과 시작 위치 제어
-- 출력 형식은  top-down 또는 bottom-up
-- 참고) CONNECT BY PRIOR 및 START WITH절은 ANSI SQL 표준이 아님

-- 문1) 계층적 질의문을 사용하여 부서 테이블에서 학과,학부,단과대학을 검색하여 단대,학부
-- 학과순으로 top-down 형식의 계층 구조로 출력하여라. 단, 시작 데이터는 10번 부서

SELECT          deptno, dname, college
FROM            department
START WITH      deptno = 10
CONNECT BY PRIOR deptno = college; --자식이 먼저 부모가 나중에(top-down)

-- 문2)계층적 질의문을 사용하여 부서 테이블에서 학과,학부,단과대학을 검색하여 학과,학부
-- 단대 순으로 bottom-up 형식의 계층 구조로 출력하여라. 단, 시작 데이터는 102번 부서이다
SELECT deptno, dname, college
FROM   department
START WITH deptno = 102
CONNECT BY PRIOR college = deptno;

--- 문3) 계층적 질의문을 사용하여 부서 테이블에서 부서 이름을 검색하여 단대, 학부, 학과순의
---         top-down 형식으로 출력하여라. 단, 시작 데이터는 ‘공과대학’이고,
---        각 LEVEL(레벨)별로 우측으로 2칸 이동하여 출력

SELECT LEVEL, LPAD(' ', (LEVEL-1*2)) || dname 조직도--deptno, dname, college
FROM   department
START WITH dname = '공과대학'
CONNECT BY PRIOR deptno = college;

---      TableSpace  
---  정의  :데이터베이스 오브젝트 내 실제 데이터를 저장하는 공간
--           이것은 데이터베이스의 물리적인 부분이며, 세그먼트로 관리되는 모든 DBMS에 대해 
--           저장소(세그먼트)를 할당
-------------------------------------------------------
-- 1. TableSpace 생성
CREATE Tablespace user1 Datafile 'C:\oraclexe\tableSpace/user1.ora' SIZE 100M;
CREATE Tablespace user2 Datafile 'C:\oraclexe\tableSpace/user2.ora' SIZE 100M;
CREATE Tablespace user3 Datafile 'C:\oraclexe\tableSpace/user3.ora' SIZE 100M;
CREATE Tablespace user4 Datafile 'C:\oraclexe\tableSpace/user4.ora' SIZE 100M;

-- 2. 테이블의 테이블 스페이스 변경
--    1) 테이블의 NDEX와 Table의  테이블 스페이스 조회
SELECT INDEX_NAME, TABLE_NAME,TABLESPACE_NAME
FROM USER_INDEXES; 

SELECT TABLE_NAME,TABLESPACE_NAME
FROM USER_Tables;

--   2) 각 테이블 별로 Tablespace 를 변경 
--      해당 Index 먼저 변경 후 Table 의 Tablespace 변경

ALTER INDEX PK_RELIGIONNO3 REBUILD TABLESPACE user1;
ALTER TABLE RELIGION MOVE TABLESPACE user1;

--   3) 테이블 스페이스 Size 변경
ALTER Database Datafile 'C:\oraclexe\tableSpace/user4.ora' RESIZE 200M;

------------------------------------------------------------------------------------
--1) Admin 권한 TableSpace Begin
------------------------------------------------------------------------------------
--1. TABLESPACE 생성
CREATE Tablespace user5 Datafile 'C:\oraclexe\tableSpace/user5.ora' SIZE 100M;
CREATE Tablespace user6 Datafile 'C:\oraclexe\tableSpace/user6.ora' SIZE 100M;

CREATE Tablespace user6 Datafile 'C:\oraclexe\tableSpace/user6.ora' SIZE 100M;
--   2.  USER 생성-- scott2 / tiger (SYSTEM 계정)
CREATE USER scott2 IDENTIFIED BY tiger
DEFAULT TABLESPACE user6;
GRANT DBA TO scott2;
------------------------------------------------------------------------------------
--1) Admin 권한 TableSpace END
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--2) Scott2 권한 TableSpace END
------------------------------------------------------------------------------------
--scott2 테이블 생성

CREATE TABLE DEPT3
        ( DEPTNO number(2)   PRIMARY KEY,
          DNAME  VARCHAR2(14) ,
          LOC    VARCHAR2(13) );




