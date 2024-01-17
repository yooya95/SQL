-----------------------------------------------
---   Admin 사용자 생성 /권한 부여 
------------------------------------------------
-- 1-1. USER 생성
CREATE USER usertest01 IDENTIFIED BY tiger;
-- 1-2. USER 생성
CREATE USER usertest02 IDENTIFIED BY tiger;
-- 1-3. USER 생성
CREATE USER usertest03 IDENTIFIED BY tiger;
-- 1-4. USER 생성
CREATE USER usertest04 IDENTIFIED BY tiger;

--2-1. session 권한 부여
GRANT CREATE session to usertest01;
GRANT CREATE SESSION, CREATE table, CREATE VIEW to usertest02;

--2-2. 현장에서 DBA가 개발자 권한 부여
GRANT CONNECT, RESOURCE TO usertest03;
GRANT CONNECT, RESOURCE TO usertest04;

GRANT DBA   to usertest04; --나중에 sysnonym 권한을 주기위해 admin 권한을 user04에 부여함
-- ADMIN 관점 
SELECT * FROM scott.emp;

CREATE TABLE systemTBL(
    memo VARCHAR2 (50)
    );
INSERT INTO systemTBL values('오월 푸름');
INSERT INTO systemTBL values('결실을 맺으리라');

--나는 스스로 조회 가능
SELECT * FROM systemTBL;

--systemt에 있는 systemTBL에 Read 권한 usertest04 주세요
GRANT SELECT ON systemTBL TO usertest04 WITH GRANT OPTION;

-- 권한 부여 했지만 번거로움 -->  Simple 하게 하기 위해  공용 동의어(public sysnonym) 생성
CREATE PUBLIC SYNONYM systemTBL FOR systemTBL; -- 현장용

-- 전용 동의어(private synonym)  Test 용
CREATE TABLE sampleTBL(
     memo varchar2(50)
     );
INSERT INTO sampleTBL values('박진기는');
INSERT INTO sampleTBL values('진기방기이다');

--system에 있는 sampleTBL에 Read 권한 usertest04 주세요
GRANT SELECT ON sampleTBL TO usertest04 WITH GRANT OPTION;


