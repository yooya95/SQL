
         
--나는 ADMIN TBL 조회 가능X
SELECT * FROM system.systemTBL;
--SYSTEM에 있는 SYSTEMTBL에 READ 권한 USERTESR04 주세요 -->SYSTEM에서 수행
GRANT SELECT ON systemTBL TO usertest04 WITH GRANT OPTION;

--나는 ADMIN TBL 조회가능 OK
select*from system.systemTBL;

--USERTEST04에 있는 SYSTEMTBL에 READ권한 USERTEST 03 주세요 -> USERTEST04에서 수행
GRANT SELECT   ON  system.systemTBL to usertest03; 
-- with grant option 을 뺌
--권한만 준거지 재부여 권한은 줄 수 없음

--권한 회수
REVOKE SELECT ON system.systemTBL FROM usertest03;

--나는 admin tabl 조회 가능 admin 계정에서 systemtbl만 쳐도 공유할 수 있도록 공용동의어를 지정해둠 
SELECT * FROM systemTBL;

--현재  scott연계 없음
SELECT * FROM scott.emp;
SELECT * FROM scott.student;

-- 3. scott에 있는 student TBL에 Read 권한 usertest04 주세요 (scott계정에서 수행한거임 그냥 복붙만 한거)
GRANT SELECT ON scott.student TO usertest04;

--현재  scott연계
SELECT * FROM scott.emp; -- 권한 x
SELECT * FROM scott.student; --권한 O

--  2-3.scoot에서 현EMP select 권한 부여 개발자 권한 부여 -->usertest04 니가 해라 권한부여  scott계정에서 수행한거임 그냥 복붙만 한거)
GRANT SELECT ON scott.emp TO usertest04 WITH GRANT OPTION;
--  2-4.scoot에서  현dept select 권한 부여 개발자 권한 부여 -->usertest04 니가 해라 권한부여  scott계정에서 수행한거임 그냥 복붙만 한거)
GRANT SELECT ON scott.dept TO usertest04 WITH GRANT OPTION;

--현재  scott연계
SELECT * FROM scott.emp; -- 권한 ㅇ
SELECT * FROM scott.dept; --권한 O
SELECT * FROM scott.student; --권한 O

-- 당연히 안됨 select권한만 주었기 때문에 읽기만 가능! 변경 불가능
UPDATE scott.student
SET userid = 'kkk'
WHERE studno = 30101;

-- 당연히 안됨 scott 이 student 테이블은 with  grand option 을 같이 주지 않았음.
GRANT SELECT ON scott.student TO usertest03;
-- 됨  scott 이 권한을 줄때 권한부여 옵션도 같ㅇ ㅣ주었기 때문에 03에게 줄 수 있음
GRANT SELECT ON scott.emp TO usertest03 WITH GRANT OPTION;
GRANT SELECT ON scott.dept TO usertest03 WITH GRANT OPTION;


--현재 scoot연계 --> emp 권한 회수 후 
SELECT * FROM scott.emp;  --x


--나는 Admin TBL 조회가능 OK
select *FROM systemTBL;
select * FROM system.sampleTBL;

--sampleTBL 이용한 전용 동의어 생성 (USER04만 볼 수 있음)
CREATE synonym free_sampleTBL FOR system.sampleTBL;

SELECT * FROM free_sampleTBL;


