
         
--���� ADMIN TBL ��ȸ ����X
SELECT * FROM system.systemTBL;
--SYSTEM�� �ִ� SYSTEMTBL�� READ ���� USERTESR04 �ּ��� -->SYSTEM���� ����
GRANT SELECT ON systemTBL TO usertest04 WITH GRANT OPTION;

--���� ADMIN TBL ��ȸ���� OK
select*from system.systemTBL;

--USERTEST04�� �ִ� SYSTEMTBL�� READ���� USERTEST 03 �ּ��� -> USERTEST04���� ����
GRANT SELECT   ON  system.systemTBL to usertest03; 
-- with grant option �� ��
--���Ѹ� �ذ��� ��ο� ������ �� �� ����

--���� ȸ��
REVOKE SELECT ON system.systemTBL FROM usertest03;

--���� admin tabl ��ȸ ���� admin �������� systemtbl�� �ĵ� ������ �� �ֵ��� ���뵿�Ǿ �����ص� 
SELECT * FROM systemTBL;

--����  scott���� ����
SELECT * FROM scott.emp;
SELECT * FROM scott.student;

-- 3. scott�� �ִ� student TBL�� Read ���� usertest04 �ּ��� (scott�������� �����Ѱ��� �׳� ���ٸ� �Ѱ�)
GRANT SELECT ON scott.student TO usertest04;

--����  scott����
SELECT * FROM scott.emp; -- ���� x
SELECT * FROM scott.student; --���� O

--  2-3.scoot���� ��EMP select ���� �ο� ������ ���� �ο� -->usertest04 �ϰ� �ض� ���Ѻο�  scott�������� �����Ѱ��� �׳� ���ٸ� �Ѱ�)
GRANT SELECT ON scott.emp TO usertest04 WITH GRANT OPTION;
--  2-4.scoot����  ��dept select ���� �ο� ������ ���� �ο� -->usertest04 �ϰ� �ض� ���Ѻο�  scott�������� �����Ѱ��� �׳� ���ٸ� �Ѱ�)
GRANT SELECT ON scott.dept TO usertest04 WITH GRANT OPTION;

--����  scott����
SELECT * FROM scott.emp; -- ���� ��
SELECT * FROM scott.dept; --���� O
SELECT * FROM scott.student; --���� O

-- �翬�� �ȵ� select���Ѹ� �־��� ������ �б⸸ ����! ���� �Ұ���
UPDATE scott.student
SET userid = 'kkk'
WHERE studno = 30101;

-- �翬�� �ȵ� scott �� student ���̺��� with  grand option �� ���� ���� �ʾ���.
GRANT SELECT ON scott.student TO usertest03;
-- ��  scott �� ������ �ٶ� ���Ѻο� �ɼǵ� ���� ���־��� ������ 03���� �� �� ����
GRANT SELECT ON scott.emp TO usertest03 WITH GRANT OPTION;
GRANT SELECT ON scott.dept TO usertest03 WITH GRANT OPTION;


--���� scoot���� --> emp ���� ȸ�� �� 
SELECT * FROM scott.emp;  --x


--���� Admin TBL ��ȸ���� OK
select *FROM systemTBL;
select * FROM system.sampleTBL;

--sampleTBL �̿��� ���� ���Ǿ� ���� (USER04�� �� �� ����)
CREATE synonym free_sampleTBL FOR system.sampleTBL;

SELECT * FROM free_sampleTBL;


