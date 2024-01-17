----------------------------------
-- SEQUENCE ***
-- 유일한 식별자
-- 기본 키 값을 자동으로 생성하기 위하여 일련번호 생성 객체
-- 예를 들면, 웹 게시판에서 글이 등록되는 순서대로 번호를 하나씩 할당하여 기본키로 지정하고자 할때 
-- 시퀀스를 편리하게 이용
-- 여러 테이블에서 공유 가능  -- > 일반적으로는 개별적 사용 
----------------------------------
-- 1) SEQUENCE 형식
--CREATE SEQUENCE sequence
--[INCREMENT BY n]
--[START WITH n]
--[MAXVALUE n | NOMAXVALUE]
--[MINVALUE n | NOMINVALUE]
--[CYCLE | NOCYCLE]
--[CACHE n | NOCACHE];
--INCREMENT BY n : 시퀀스 번호의 증가치로 기본은 1,  일반적으로 ?1 사용
--START WITH n : 시퀀스 시작번호, 기본값은 1
--MAXVALUE n : 생성 가능한 시퀀스의 최대값
--MAXVALUE n : 시퀀스 번호를 순환적으로 사용하는 cycle로 지정한 경우, MAXVALUE에 도달한 후 새로 시작하는 시퀀스값
--CYCLE | NOCYCLE : MAXVALUE 또는 MINVALUE에 도달한 후 시퀀스의 순환적인 시퀀스 번호의 생성 여부 지정
--CACHE n | NOCACHE : 시퀀스 생성 속도 개선을 위해 메모리에 캐쉬하는 시퀀스 개수, 기본값은 20

-- 2) SEQUENCE sample 예시1
CREATE SEQUENCE sample_seq
INCREMENT BY 1
START WITH 10000;
-- 이 시퀸스로부터 가져올 값
SELECT sample_seq.NEXTVAL FROM dual;
-- 이 시퀸스로부터 가져온 값을 다시한번 조회 (현재 값)
SELECT sample_seq.CURRVAL FROM dual;


-- 3) SEQUENCE sample 예시2 --> 실 사용 예시
CREATE SEQUENCE dept_dno_seq
INCREMENT BY 1
START WITH 10
;

-- 4) SEQUENCE dept_dno_seq를 이용 dept_second 입력 --> 실 사용 예시
INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL, 'Accfounting' , 'NEW YORK')
;

SELECT dept_dno_seq.CURRVAL FROM dual;

INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL, '회계' , '이대')
;

SELECT dept_dno_seq.CURRVAL FROM dual;

INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL, '인사팀' , '당산')
;

SELECT dept_dno_seq.CURRVAL FROM dual;

--max 전환 (시퀸스와 섞어쓰면 값을 잃어버림)
INSERT INTO dept_second
VALUES((SELECT MAX(DEPTNO)+1 FROM dept_second)
            , '경영팀'
            , ' 대림'
      );
 -- MAX값 쓴 후 시퀸스 오류 보고  ORA-00001: unique constraint (SCOTT.DEPT_SECOND_PK) violated    
INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL, '인사3팀' , '당산3')
;

--5) Data 사전에서 정보 조회
SELECT sequence_name, min_value, max_value, increment_by
FROM   user_sequences;

--6) 시퀸스 삭제
DROP SEQUENCE SAMPLE_SEQ;

------------------------------------------------------
----                               Table 조작                             ----
------------------------------------------------------
-- 1.Table 생성
CREATE TABLE address
(   id              NUMBER(3)    ,
    Name            VARCHAR2(50) ,
    addr            VARCHAR2(100),
    phone           VARCHAR2(30) ,
    email           VARCHAR2(100)
);

INSERT INTO ADDRESS
VALUES (1,'HGDNG','SEOUL','123-4567','gbhong@naver.com')
;

------------------------------------------------------
----                   HW                         ----
------------------------------------------------------
-- 문1) address스키마/Data 유지하며     addr_second Table 생성 
CREATE TABLE addr_second
AS SELECT ID, NAME, ADDR, PHONE, EMAIL
    FROM   address
;
CREATE TABLE addr_second (ID, NAME, ADDR, PHONE, EMAIL)
AS  SELECT * FROM address;


-- 문2) address스키마 유지하며  Data 복제 하지 않고   addr_seven Table 생성 
CREATE TABLE addr_seven (ID, NAME, ADDR, PHONE, EMAIL)
AS SELECT *
   FROM address
   WHERE 0=1;
-- 문3) address(주소록) 테이블에서 id, name 칼럼만 복사하여 addr_third 테이블을 생성하여라    
CREATE TABLE addr_third
AS SELECT ID, NAME
   FROM  ADDRESS
   ;
-- 문4) addr_second 테이블 을 addr_tmp로 이름을 변경 하시요
RENAME ADDR_SECOND TO addr_tmp;

------------------------------------------------------
----                   HW END                         ----
-----------------------------------------------------

------------------------------------------------------------------
-----     데이터 사전
-- 1. 사용자와 데이터베이스 자원을 효율적으로 관리하기 위한 다양한 정보를 저장하는 시스템 테이블의 집합
-- 2. 사전 내용의 수정은 오라클 서버만 가능
-- 3. 오라클 서버는 데이타베이스의 구조, 감사, 사용자 권한, 데이터 등의 변경 사항을 반영하기 위해
--    지속적 수정 및 관리
-- 4. 데이타베이스 관리자나 일반 사용자는 읽기 전용 뷰에 의해 데이터 사전의 내용을 조회만 가능
-- 5. 실무에서는 테이블, 칼럼, 뷰 등과 같은 정보를 조회하기 위해 사용

------------------------------------------------------------------
------------------------------------------------------------------
-----     데이터 사전 관리 정보
-- 1.데이터베이스의 물리적 구조와 객체의 논리적 구조
-- 2. 오라클 사용자 이름과 스키마 객체 이름
-- 3. 사용자에게 부여된 접근 권한과 롤
-- 4. 무결성 제약조건에 대한 정보
-- 5. 칼럼별로 지정된 기본값
-- 6. 스키마 객체에 할당된 공간의 크기와 사용 중인 공간의 크기 정보
-- 7. 객체 접근 및 갱신에 대한 감사 정보
-- 8.데이터베이스 이름, 버전, 생성날짜, 시작모드, 인스턴스 이름 정보
------------------------------------------------------------------
-------     데이터 사전 종류
-- 1. USER_ : 객체의 소유자만 접근 가능한 데이터 사전 뷰
-- user_tables는 사용자가 소유한 테이블에 대한 정보를 조회할 수 있는 데이터 사전 뷰.

SELECT table_name    -- *
FROM   user_tables;

SELECT *
FROM user_catalog;

-- 2. ALL_    : 자기 소유 또는 권한을 부여 받은 객체만 접근 가능한 데이터 사전 뷰
SELECT owner, table_name
FROM all_tables;

-- 3. DBA_   : 데이터베이스 관리자만 접근 가능한 데이터 사전 뷰
SELECT owner, table_name
FROM dba_Tables;

------------------------------------------------------------
------------            제약조건(Constraint)        ***          ------------
--  정의  : 데이터의 정확성과 일관성을 보장
-- 1. 테이블 생성시 무결성 제약조건을 정의 가능
-- 2. 테이블에 대해 정의, 데이터 딕셔너리에 저장되므로 응용 프로그램에서 입력된 
--     모든 데이터에 대해 동일하게 적용
-- 3. 제약조건을 활성화, 비활성화 할 수 있는 융통성
-------------------------------------------------------------

-------------------------------------------------------------
------------            제약조건(Constraint)   종류      ***  ------------
-- 1 .NOT NULL  : 열이 NULL을 포함할 수 없음
-- 2. 기본키(primary key) : UNIQUE +  NOT NULL + 최소성  제약조건을 결합한 형태
-- 3. 참조키(foreign key) :  테이블 간에 외래 키 관계를 설정 ***
-- 4. CHECK : 해당 칼럼에 저장 가능한 데이터 값의 범위나 조건 지정
-------------------------------------------------------------
-- 1.  제약조건(Constraint) 적용 위한 강좌(subject) 테이블 인스턴스

CREATE TABLE subject (
    subno       NUMBER(5)    CONSTRAINT subject_no_pk PRIMARY KEY,
    subname     VARCHAR2(20) CONSTRAINT subject_name_nn NOT NULL,
    term        VARCHAR2(1)  CONSTRAINT subject_term_ck CHECK(term IN('1','2')),
    typeGubun   Varchar2(1)
);

COMMENT ON COLUMN subject.subno     IS  '수강번호';
COMMENT ON COLUMN subject.subname   IS  '수강과목';
COMMENT ON COLUMN subject.term      IS  '학기';

INSERT INTO subject(subno, subname, term, typeGubun)
                    values(1000, '컴퓨터개론','1','1');
                    
--INSERT INTO subject(subno, subname, term, typeGubun)
--                    values(1000, ' ',' ','1'); 오류덩어리

INSERT INTO subject(subno, subname, term, typeGubun)
                    values(1001, 'DB개론',   '2','1');
INSERT INTO subject(subno, subname, term, typeGubun)
                    values(1002, 'JSP개론',  '1','1');                    
        
-- PK Constraint   --> Unique
INSERT INTO subject(subno, subname, term, typeGubun)
                    values(1001, 'spring개론', '1','1');
-- PK Constraint   --> NN
INSERT INTO subject(subno, subname, term, typeGubun)
                    values( '','spring개론2', '1','1');          
-- subname NN
INSERT INTO subject(subno, subname, term, typeGubun)
                    values( 1003 ,'',  '1','1');                   
-- Check  Constraint   --> term
INSERT INTO subject(subno, subname, term, typeGubun)
                    values( 1003 , 'spring개론3', '5','1');
                    
-- Table 선언시 못한것을 추후 정의 가능
-- Student Table 의 idnum을 unique로 선언
ALTER TABLE student
ADD CONSTRAINT stud_idnum_uk UNIQUE(idnum); --ADD는 UNIQUE

--idunum ---->ok
INSERT INTO student(studno, name, idnum)
            values(30101,   '대조영','8012301036613');
--idunum ----> unique constraint         
INSERT INTO student(studno, name, idnum)
            values(30102,   '강감찬','8012301036613');
            
-- student table의 name을 NN으로 선언
ALTER table student
MODIFY (name CONSTRAINT stud_name_nn NOT NULL); --MODIFY 는 NOT NULL

-- NAME --> NN constraint
INSERT INTO student(studno, name, idnum)
            values(30103,   ,'8012301036614');
            
--constratint조회
SELECT CONSTRAINT_name, CONSTRAINT_Type
FROM user_CONSTRAINTS
WHERE table_name IN('SUBJECT','STUDENT','ADDRESS');

---------------------------------------------------------------
-----      INDEX      ***
--  인덱스는 SQL 명령문의 처리 속도를 향상(*) 시키기 위해 칼럼에 대해 생성하는 객체
--  인덱스는 포인트를 이용하여 테이블에 저장된 데이터를 랜덤 액세스하기 위한 목적으로 사용
--  [1]인덱스의 종류
--   1)고유 인덱스 : 유일한 값을 가지는 칼럼에 대해 생성하는 인덱스로 모든 인덱스 키는
--           테이블의 하나의 행과 연결
CREATE UNIQUE INDEX idx_dept_name
ON     department(dname);
--   2)비고유 인덱스, 성능에만 영향을 미치고 제약조건에는 영향이 없음
-- 문) 학생 테이블의 birthdate 칼럼을 비고유 인덱스로 생성하여라
CREATE INDEX idx_stud_birthdate
ON student(birthdate);

INSERT INTO student( studno, name, idnum,             birthdate)
            values(30102 , '김유신','8012301036614' , '84/09/16');
            
--   3)단일 인덱스
--   4)결합 인덱스 :  두 개 이상의 칼럼을 결합하여 생성하는 인덱스
--     문) 학생 테이블의 deptno, grade 칼럼을 결합 인덱스로 생성
--          결합 인덱스의 이름은 idx_stud_dno_grade 로 정의
CREATE INDEX idx_stud_dno_grade
ON     student(deptno, grade);

SELECT *
FROM   student
WHERE  deptno =101
AND    grade = 2
;

--- Optimizer
--- 1) RBO  2) CBO
-- RBO 변경
ALTER SESSION SET OPTIMIZER_MODE=RULE;

--SESSION 상에서 변경할때
ALTER SESSION SET optimizer_mode= rule
ALTER SESSION SET optimizer_mode= CHOOSE
ALTER SESSION SET optimizer_mode= first_rows
ALTER SESSION SET optimizer_mode= ALL_Rows

--   5)함수 기반 인덱스(FBI) function based index
--      오라클 8i 버전부터 지원하는 새로운 형태의 인덱스로 칼럼에 대한 연산이나 함수의 계산 결과를 
--      인덱스로 생성 가능
--      UPPER(column_name) 또는 LOWER(column_name) 키워드로 정의된
--      함수 기반 인덱스를 사용하면 대소문자 구분 없이 검색

CREATE INDEX lowercase_idx ON emp (LOWER(ename));
 
SELECT *
FROM emp
WHERE lower(ename) = 'king' ;

--학생 테이블에 생성된 PK_STUDNO 인덱스를 재구성
ALTER INDEX PK_STUDNO REBUILD;

--1. Index 정보 조회;
SELECT index_name, table_name, column_name
FROM user_ind_columns;

--2. Index 생성 emp(job)
CREATE INDEX idx_emp_job ON emp(job);

--3. 조회
SELECT * FROM emp WHERE JOB = 'MANAGER';
SELECT * FROM emp WHERE JOB <>'MANAGER'; --부정형은 인덱스를 타지 않는당!
SELECT * FROM emp WHERE JOB LIKE 'MA%';
SELECT * FROM emp WHERE JOB LIKE '%MA%'; --인덱스를 타지 않음
SELECT * FROM emp WHERE UPPER(JOB) = 'MANAGER';


--SQL Optimizer
--Hint 문법 --> /*+  +/
SELECT /* + first_row*/ ename From emp;

SELECT /*+ rule */ ename From emp;

--OPTIMIZER 모드 확인
SELECT NAME, VALUE, ISDEFAULT, ISMODIFIED, DESCRIPTION
FROM V$SYSTEM_PARAMETER
WHERE NAME LIKE '%optimizer_mode%'




