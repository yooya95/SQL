-----------------------------------------------
---   Admin ����� ���� /���� �ο� 
------------------------------------------------
-- 1-1. USER ����
CREATE USER usertest01 IDENTIFIED BY tiger;
-- 1-2. USER ����
CREATE USER usertest02 IDENTIFIED BY tiger;
-- 1-3. USER ����
CREATE USER usertest03 IDENTIFIED BY tiger;
-- 1-4. USER ����
CREATE USER usertest04 IDENTIFIED BY tiger;

--2-1. session ���� �ο�
GRANT CREATE session to usertest01;
GRANT CREATE SESSION, CREATE table, CREATE VIEW to usertest02;

--2-2. ���忡�� DBA�� ������ ���� �ο�
GRANT CONNECT, RESOURCE TO usertest03;
GRANT CONNECT, RESOURCE TO usertest04;

GRANT DBA   to usertest04; --���߿� sysnonym ������ �ֱ����� admin ������ user04�� �ο���
-- ADMIN ���� 
SELECT * FROM scott.emp;

CREATE TABLE systemTBL(
    memo VARCHAR2 (50)
    );
INSERT INTO systemTBL values('���� Ǫ��');
INSERT INTO systemTBL values('����� ��������');

--���� ������ ��ȸ ����
SELECT * FROM systemTBL;

--systemt�� �ִ� systemTBL�� Read ���� usertest04 �ּ���
GRANT SELECT ON systemTBL TO usertest04 WITH GRANT OPTION;

-- ���� �ο� ������ ���ŷο� -->  Simple �ϰ� �ϱ� ����  ���� ���Ǿ�(public sysnonym) ����
CREATE PUBLIC SYNONYM systemTBL FOR systemTBL; -- �����

-- ���� ���Ǿ�(private synonym)  Test ��
CREATE TABLE sampleTBL(
     memo varchar2(50)
     );
INSERT INTO sampleTBL values('�������');
INSERT INTO sampleTBL values('�������̴�');

--system�� �ִ� sampleTBL�� Read ���� usertest04 �ּ���
GRANT SELECT ON sampleTBL TO usertest04 WITH GRANT OPTION;


