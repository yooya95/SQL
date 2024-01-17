CREATE TABLE SALGRADE
        (GRADE NUMBER(2)  CONSTRAINT PK_GRADE  PRIMARY KEY,
         LOSAL NUMBER(5),
         HISAL NUMBER(5));
         
--나는 ADMIN TBL 조회 가능X
SELECT * FROM system.systemTBL;

---USERTEST04에 있는 SYSTEMTBL에 READ권한 USERTEST 03 주세요 -> USERTEST04에서 수행
GRANT SELECT   ON  system.systemTBL to usertest03;
         
--나는 ADMIN TBL 조회 가능
SELECT * FROM system.systemTBL;

---USERTEST03에 있는 SYSTEMTBL에 READ권한 USERTEST 02 주세요 -> USERTEST03에서 수행
GRANT SELECT   ON  system.systemTBL to usertest02;

--권한 회수 후 안됨

--usertest04에서 권한부여를 한거를 복붙한 내용----
-- 당연히 안됨 scott 이 student 테이블은 with  grand option 을 같이 주지 않았음.
GRANT SELECT ON scott.student TO usertest03;
-- 됨  scott 이 권한을 줄때 권한부여 옵션도 같ㅇ ㅣ주었기 때문에 03에게 줄 수 있음
GRANT SELECT ON scott.emp TO usertest03 WITH GRANT OPTION;
------------------------------------------------

SELECT * FROM scott.emp; -- 권한 ㅇ
SELECT * FROM scott.dept; --권한 x
SELECT * FROM scott.student; --권한 x

SELECT * FROM scott.emp;  --x

