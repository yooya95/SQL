----------------------------------------------------------------------------------------
-------                     Trigger 
--  1. 정의 : 어떤 사건이 발생했을 때 내부적으로 실행되도록 데이터베 이스에 저장된 프로시저
--              트리거가 실행되어야 할 이벤트 발생시 자동으로 실행되는 프로시저 
--              트리거링 사건(Triggering Event), 즉 오라클 DML 문인 INSERT, DELETE, UPDATE이 
--              실행되면 자동으로 실행
--  2. 오라클 트리거 사용 범위
--    1) 데이터베이스 테이블 생성하는 과정에서 참조 무결성과 데이터 무결성 등의 복잡한 제약 조건 생성하는 경우 
--    2) 데이터베이스 테이블의 데이터에 생기는 작업의 감시, 보완 
--    3) 데이터베이스 테이블에 생기는 변화에 따라 필요한 다른 프로그램을 실행하는 경우 
--    4) 불필요한 트랜잭션을 금지하기 위해 
--    5) 컬럼의 값을 자동으로 생성되도록 하는 경우 
-------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER triger_test
BEFORE
UPDATE ON dept
FOR EACH ROW -- 각각의 행에old(변경전), new(변경후) 사용하기 위해
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('변경 전 컬럼 값 : ' || : old.dname);
    DBMS_OUTPUT.PUT_LINE('변경 후 컬럼 값 : ' || : new.dname);
    
END;

UPDATE dept
SET    dname= '회계3팀'
WHERE  deptno = 61;
commit;

UPDATE dept
SET    dname= '인사1팀'
WHERE  deptno = 62;

----------------------------------------------------------
--현장WORK ) emp Table의 급여가 변화시
--       화면에 출력하는 Trigger 작성( emp_sal_change)
--       emp Table 수정전
--      조건 : 입력시는 empno가 0보다 커야함

--출력결과 예시
--     이전급여  : 10000
--     신  급여  : 15000
 --    급여 차액 :  5000
 --    DELCARE   sal_diff number;
----------------------------------------------------------
create or replace TRIGGER emp_sal_change
BEFORE
UPDATE ON emp
FOR EACH ROW -- 각각의 행에old(변경전), new(변경후) 사용하기 위해
    WHEN (new.empno > 0)
    DECLARE
        sal_diff    number;
BEGIN
    sal_diff  := :new.sal - :old.sal;

    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('이전 급여 : ' || :old.sal);
    DBMS_OUTPUT.PUT_LINE('신   급여 : ' || :new.sal);
    DBMS_OUTPUT.PUT_LINE('급여 차액 : ' || sal_diff);
END;

UPDATE emp
SET    sal = 100
WHERE  empno = 7369;

create or replace TRIGGER emp_sal_change
BEFORE UPDATE ON emp
FOR EACH ROW -- 각각의 행에old(변경전), new(변경후) 사용하기 위해
    WHEN (new.empno > 0)
    DECLARE
        sal_diff    number;
BEGIN
    sal_diff  := :new.sal - :old.sal;

    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('이전 급여 : ' || :old.sal);
    DBMS_OUTPUT.PUT_LINE('신   급여 : ' || :new.sal);
    DBMS_OUTPUT.PUT_LINE('급여 차액 : ' || sal_diff);
END;

UPDATE emp
SET    sal = 25300
WHERE  empno = 5003;

DELETE emp
WHERE  empno = 5003;

commit;

-----------------------------------------------------------
--  EMP 테이블에 INSERT,UPDATE,DELETE문장이 하루에 몇 건의 ROW가 발생되는지 조사
--  조사 내용은 EMP_ROW_AUDIT에 
--  ID ,사용자 이름, 작업 구분,작업 일자시간을 저장하는 
--  트리거를 작성
-----------------------------------------------------------

--1.SEQUENCE
--DROP SEQUENCE emp_row_seq;
CREATE SEQUENCE emp_row_seq;
--2. Audit Table
--DROP TABLE emp_row_audit;
CREATE TABLE emp_row_audit (
    e_id   NUMBER(6)        CONSTRAINT emp_row_pk PRIMARY KEY,
    e_name VARCHAR2(30),
    e_gubun VARCHAR2(10),
    e_date  DATE
 );

CREATE OR REPLACE TRIGGER emp_row_aud
    AFTER insert OR update OR delete ON emp
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
     INSERT INTO emp_row_audit
        VALUES(emp_row_seq.NEXTVAL,:new.ename, 'inserting', SYSDATE);
    ELSIF UPDATING THEN
     INSERT INTO emp_row_audit
        VALUES(emp_row_seq.NEXTVAL,:old.ename, 'updating', SYSDATE);
    ELSIF DELETING THEN
     INSERT INTO emp_row_audit
        VALUES(emp_row_seq.NEXTVAL,:old.ename, 'deleting', SYSDATE);
    END IF;
END;
--------------------트리거 시행 후 행 정보 삭제, 입력 ------------------------------------
delete 
from emp
where empno=3000;
delete 
from emp
where empno=3100;
delete 
from emp
where empno=3300;

INSERT INTO emp(empno, ename, sal, deptno)
        values(3000, '김용빈', 3500 ,51);

INSERT INTO emp(empno, ename, sal, deptno)
        values(3100, '김찬하', 3500 ,51);
INSERT INTO emp(empno, ename, sal, deptno)
        values(3300, '이이이', 3600 ,51);

-----------------------------------------------
---   데이터베이스 보안
---  1. 다중 사용자 환경(multi-user environment)
---     1) 사용자는 자신이 생성한 객체에 대해 소유권을 가지고 데이터에 대한 조작이나 조회 가능
---     2) 다른 사용자가 소유한 객체는 소유자로부터 접근 권한을 부여받지 않는 접근 불가
---     3) 다중 사용자 환경에서는 데이터베이스 관리자의 암호를 철저하게 관리
---  2. 중앙 집중적인 데이터 관리
---  3. 시스템 보안
---     1) 데이터베이스 관리자는 사용자 계정, 암호 관리, 사용자별 허용 가능한 디스크공간 할당
---     2) 시스템 관리 차원에서 데이터베이스 자체에 대한 접근 권한을 관리
---  4. 데이터 보안
---     1) 사용자별로 객체를 조작하기 위한 동작 관리
---     2) 데이터베이스 객체에 대한 접근 권한을 관리
-----------------------------------------------


----------------------------------------------------------------------
---  권한(Privilege) 부여
---    1. 정의 : 사용자가 데이터베이스 시스템을 관리하거나 객체를 이용할 수 있는 권리
---    2. 유형 
---         1) 시스템 권한 : 시스템 차원의 자원 관리나 사용자 스키마 객체 관리 등과 같은 
---                               데이터베이스 관리 작업을 할 수 있는 권한
---             [1]  데이터베이스 관리자가 가지는 시스템 권한
---                   CREATE USER     :  사용자를 생성할 수 있는 권한
---                   DROP    USER     : 사용자를 삭제할 수 있는 권한
---                   DROP ANY TABLE : 임의의 테이블을 삭제할 수 있는 권한
---                   QUERY REWRITE  : 함수 기반 인덱스를 생성하기 위한 권한
---             [2]  일반사용자가 가지는 시스템 권한
---                   CREATE SESSION      : DB에 접속할 수 있는 권한
---                   CREATE TABLE          : 사용자 스키마에서 테이블을 생성할 수 있는 권한
---                   CREATE SEQUENCE   : 사용자 스키마에서 시퀀스를 생성할 수 있는 권한
---                   CREATE VIEW            : 사용자 스키마에서 뷰를 생성할 수 있는 권한
---                   CREATE PROCEDURE : 사용자 스키마에서 프로시저, 함수, 패키지를 생성할 수 있는 권한
---         2) 객체 권한    : 테이블, 뷰, 시퀀스, 함수 등과 같은 객체를 조작할 수 있는 권한

---------------------------------------------------------------------------------------------
---  롤(role)
---  1. 개념 : 다수 사용자와 다양한 권한을 효과적으로 관리하기 위하여 서로 관련된 권한을 그룹화한 개념
---              일반 사용자가 데이터베이스를 이용하기 위한 공통적인 권한
--               (데이터베이스 접속권한, 테이블 생성, 수정, 삭제, 조회 권한, 뷰 생성 권한)을 그룹화
-- 사전에 정의된 롤
-- 1. CONNECT 롤
--     1) 사용자가 데이터베이스에 접속하여 세션을 생성할 수 있는 권한
--     2) 테이블 또는 뷰와 같은 객체를 생성할 수 있는 권한
-- 2. RESOURCE 롤
--     1) 사용자에게 자신의 테이블, 시퀀스, 프로시져, 트리거 객체 생성 할 수 있는 권한
--     2) 사용자 생성시 : CONNECT 롤과 RESOURCE 롤을 부여
-- 3.  DBA 롤
--     1) 시스템 자원의 무제한적인 사용이나 시스템 관리에 필요한 모든 권한
--     2) DBA 권한을 다른 사람에게 부여할 수 있음
--     3) 모든 사용자 소유의 CONNECT, RESOURCE, DBA 권한을 포함한 모든 권한을 부여 및 철회 가능

---------------------------------------------------------------------------------------------

---------------------------------------------------
-- 동의어(synonym)
-- 1. 정의 : 하나의 객체에 대해 다른 이름을 정의하는 방법
--      동의어와 별명(Alias) 차이점
--      동의어는 데이터베이스 전체에서 사용
--      별명은 해당 SQL 명령문에서만 사용
-- 2. 동의어의 종류
--   1) 전용 동의어(private synonym) 
--      객체에 대한 접근 권한을 부여 받은 사용자가 정의한 동의어로 해당 사용자만 사용
--
--   2) 공용 동의어(public sysnonym)
--      권한을 주는 사용자가 정의한 동의어로 누구나 사용
--      DBA 권한을 가진 사용자만 생성 (예 : 데이터 딕셔너리)
 
---------------------------------------------------
-- 당근 권한 존재
SELECT * FROM scott.emp;
SELECT * FROM scott.student;

-- 3. scott에 있는 student TBL에 Read 권한 usertest04 주세요
GRANT SELECT ON scott.student TO usertest04;

--  2-3.현EMP select 권한 부여 개발자 권한 부여 -->usertest04 니가 해라 권한부여 
GRANT SELECT ON scott.emp TO usertest04 WITH GRANT OPTION;
--  2-4.현dept select 권한 부여 개발자 권한 부여 -->usertest04 니가 해라 권한부여 
GRANT SELECT ON scott.dept TO usertest04 WITH GRANT OPTION;

---------------------------------------------------
---  권한 회수
---------------------------------------------------
-- 1. 원래 권한 준 계정(USER04) 아니면 권한 회수 안 됨
REVOKE SELECT ON scott.emp FROM USERTEST03;
-- 원래 권한을 준 계정(USER04)으로부터 권한 회수 후 user04가 다른 계정에 부여(with grant option)한 모던 권한까지 전부 회수!
REVOKE SELECT ON scott.emp FROM USERTEST04;
