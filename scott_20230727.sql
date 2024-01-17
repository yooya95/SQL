----------------------------------------------------------------------------------------
-------                     Trigger 
--  1. ���� : � ����� �߻����� �� ���������� ����ǵ��� �����ͺ� �̽��� ����� ���ν���
--              Ʈ���Ű� ����Ǿ�� �� �̺�Ʈ �߻��� �ڵ����� ����Ǵ� ���ν��� 
--              Ʈ���Ÿ� ���(Triggering Event), �� ����Ŭ DML ���� INSERT, DELETE, UPDATE�� 
--              ����Ǹ� �ڵ����� ����
--  2. ����Ŭ Ʈ���� ��� ����
--    1) �����ͺ��̽� ���̺� �����ϴ� �������� ���� ���Ἲ�� ������ ���Ἲ ���� ������ ���� ���� �����ϴ� ��� 
--    2) �����ͺ��̽� ���̺��� �����Ϳ� ����� �۾��� ����, ���� 
--    3) �����ͺ��̽� ���̺� ����� ��ȭ�� ���� �ʿ��� �ٸ� ���α׷��� �����ϴ� ��� 
--    4) ���ʿ��� Ʈ������� �����ϱ� ���� 
--    5) �÷��� ���� �ڵ����� �����ǵ��� �ϴ� ��� 
-------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER triger_test
BEFORE
UPDATE ON dept
FOR EACH ROW -- ������ �࿡old(������), new(������) ����ϱ� ����
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('���� �� �÷� �� : ' || : old.dname);
    DBMS_OUTPUT.PUT_LINE('���� �� �÷� �� : ' || : new.dname);
    
END;

UPDATE dept
SET    dname= 'ȸ��3��'
WHERE  deptno = 61;
commit;

UPDATE dept
SET    dname= '�λ�1��'
WHERE  deptno = 62;

----------------------------------------------------------
--����WORK ) emp Table�� �޿��� ��ȭ��
--       ȭ�鿡 ����ϴ� Trigger �ۼ�( emp_sal_change)
--       emp Table ������
--      ���� : �Է½ô� empno�� 0���� Ŀ����

--��°�� ����
--     �����޿�  : 10000
--     ��  �޿�  : 15000
 --    �޿� ���� :  5000
 --    DELCARE   sal_diff number;
----------------------------------------------------------
create or replace TRIGGER emp_sal_change
BEFORE
UPDATE ON emp
FOR EACH ROW -- ������ �࿡old(������), new(������) ����ϱ� ����
    WHEN (new.empno > 0)
    DECLARE
        sal_diff    number;
BEGIN
    sal_diff  := :new.sal - :old.sal;

    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('���� �޿� : ' || :old.sal);
    DBMS_OUTPUT.PUT_LINE('��   �޿� : ' || :new.sal);
    DBMS_OUTPUT.PUT_LINE('�޿� ���� : ' || sal_diff);
END;

UPDATE emp
SET    sal = 100
WHERE  empno = 7369;

create or replace TRIGGER emp_sal_change
BEFORE UPDATE ON emp
FOR EACH ROW -- ������ �࿡old(������), new(������) ����ϱ� ����
    WHEN (new.empno > 0)
    DECLARE
        sal_diff    number;
BEGIN
    sal_diff  := :new.sal - :old.sal;

    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('���� �޿� : ' || :old.sal);
    DBMS_OUTPUT.PUT_LINE('��   �޿� : ' || :new.sal);
    DBMS_OUTPUT.PUT_LINE('�޿� ���� : ' || sal_diff);
END;

UPDATE emp
SET    sal = 25300
WHERE  empno = 5003;

DELETE emp
WHERE  empno = 5003;

commit;

-----------------------------------------------------------
--  EMP ���̺� INSERT,UPDATE,DELETE������ �Ϸ翡 �� ���� ROW�� �߻��Ǵ��� ����
--  ���� ������ EMP_ROW_AUDIT�� 
--  ID ,����� �̸�, �۾� ����,�۾� ���ڽð��� �����ϴ� 
--  Ʈ���Ÿ� �ۼ�
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
--------------------Ʈ���� ���� �� �� ���� ����, �Է� ------------------------------------
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
        values(3000, '����', 3500 ,51);

INSERT INTO emp(empno, ename, sal, deptno)
        values(3100, '������', 3500 ,51);
INSERT INTO emp(empno, ename, sal, deptno)
        values(3300, '������', 3600 ,51);

-----------------------------------------------
---   �����ͺ��̽� ����
---  1. ���� ����� ȯ��(multi-user environment)
---     1) ����ڴ� �ڽ��� ������ ��ü�� ���� �������� ������ �����Ϳ� ���� �����̳� ��ȸ ����
---     2) �ٸ� ����ڰ� ������ ��ü�� �����ڷκ��� ���� ������ �ο����� �ʴ� ���� �Ұ�
---     3) ���� ����� ȯ�濡���� �����ͺ��̽� �������� ��ȣ�� ö���ϰ� ����
---  2. �߾� �������� ������ ����
---  3. �ý��� ����
---     1) �����ͺ��̽� �����ڴ� ����� ����, ��ȣ ����, ����ں� ��� ������ ��ũ���� �Ҵ�
---     2) �ý��� ���� �������� �����ͺ��̽� ��ü�� ���� ���� ������ ����
---  4. ������ ����
---     1) ����ں��� ��ü�� �����ϱ� ���� ���� ����
---     2) �����ͺ��̽� ��ü�� ���� ���� ������ ����
-----------------------------------------------


----------------------------------------------------------------------
---  ����(Privilege) �ο�
---    1. ���� : ����ڰ� �����ͺ��̽� �ý����� �����ϰų� ��ü�� �̿��� �� �ִ� �Ǹ�
---    2. ���� 
---         1) �ý��� ���� : �ý��� ������ �ڿ� ������ ����� ��Ű�� ��ü ���� ��� ���� 
---                               �����ͺ��̽� ���� �۾��� �� �� �ִ� ����
---             [1]  �����ͺ��̽� �����ڰ� ������ �ý��� ����
---                   CREATE USER     :  ����ڸ� ������ �� �ִ� ����
---                   DROP    USER     : ����ڸ� ������ �� �ִ� ����
---                   DROP ANY TABLE : ������ ���̺��� ������ �� �ִ� ����
---                   QUERY REWRITE  : �Լ� ��� �ε����� �����ϱ� ���� ����
---             [2]  �Ϲݻ���ڰ� ������ �ý��� ����
---                   CREATE SESSION      : DB�� ������ �� �ִ� ����
---                   CREATE TABLE          : ����� ��Ű������ ���̺��� ������ �� �ִ� ����
---                   CREATE SEQUENCE   : ����� ��Ű������ �������� ������ �� �ִ� ����
---                   CREATE VIEW            : ����� ��Ű������ �並 ������ �� �ִ� ����
---                   CREATE PROCEDURE : ����� ��Ű������ ���ν���, �Լ�, ��Ű���� ������ �� �ִ� ����
---         2) ��ü ����    : ���̺�, ��, ������, �Լ� ��� ���� ��ü�� ������ �� �ִ� ����

---------------------------------------------------------------------------------------------
---  ��(role)
---  1. ���� : �ټ� ����ڿ� �پ��� ������ ȿ�������� �����ϱ� ���Ͽ� ���� ���õ� ������ �׷�ȭ�� ����
---              �Ϲ� ����ڰ� �����ͺ��̽��� �̿��ϱ� ���� �������� ����
--               (�����ͺ��̽� ���ӱ���, ���̺� ����, ����, ����, ��ȸ ����, �� ���� ����)�� �׷�ȭ
-- ������ ���ǵ� ��
-- 1. CONNECT ��
--     1) ����ڰ� �����ͺ��̽��� �����Ͽ� ������ ������ �� �ִ� ����
--     2) ���̺� �Ǵ� ��� ���� ��ü�� ������ �� �ִ� ����
-- 2. RESOURCE ��
--     1) ����ڿ��� �ڽ��� ���̺�, ������, ���ν���, Ʈ���� ��ü ���� �� �� �ִ� ����
--     2) ����� ������ : CONNECT �Ѱ� RESOURCE ���� �ο�
-- 3.  DBA ��
--     1) �ý��� �ڿ��� ���������� ����̳� �ý��� ������ �ʿ��� ��� ����
--     2) DBA ������ �ٸ� ������� �ο��� �� ����
--     3) ��� ����� ������ CONNECT, RESOURCE, DBA ������ ������ ��� ������ �ο� �� öȸ ����

---------------------------------------------------------------------------------------------

---------------------------------------------------
-- ���Ǿ�(synonym)
-- 1. ���� : �ϳ��� ��ü�� ���� �ٸ� �̸��� �����ϴ� ���
--      ���Ǿ�� ����(Alias) ������
--      ���Ǿ�� �����ͺ��̽� ��ü���� ���
--      ������ �ش� SQL ��ɹ������� ���
-- 2. ���Ǿ��� ����
--   1) ���� ���Ǿ�(private synonym) 
--      ��ü�� ���� ���� ������ �ο� ���� ����ڰ� ������ ���Ǿ�� �ش� ����ڸ� ���
--
--   2) ���� ���Ǿ�(public sysnonym)
--      ������ �ִ� ����ڰ� ������ ���Ǿ�� ������ ���
--      DBA ������ ���� ����ڸ� ���� (�� : ������ ��ųʸ�)
 
---------------------------------------------------
-- ��� ���� ����
SELECT * FROM scott.emp;
SELECT * FROM scott.student;

-- 3. scott�� �ִ� student TBL�� Read ���� usertest04 �ּ���
GRANT SELECT ON scott.student TO usertest04;

--  2-3.��EMP select ���� �ο� ������ ���� �ο� -->usertest04 �ϰ� �ض� ���Ѻο� 
GRANT SELECT ON scott.emp TO usertest04 WITH GRANT OPTION;
--  2-4.��dept select ���� �ο� ������ ���� �ο� -->usertest04 �ϰ� �ض� ���Ѻο� 
GRANT SELECT ON scott.dept TO usertest04 WITH GRANT OPTION;

---------------------------------------------------
---  ���� ȸ��
---------------------------------------------------
-- 1. ���� ���� �� ����(USER04) �ƴϸ� ���� ȸ�� �� ��
REVOKE SELECT ON scott.emp FROM USERTEST03;
-- ���� ������ �� ����(USER04)���κ��� ���� ȸ�� �� user04�� �ٸ� ������ �ο�(with grant option)�� ��� ���ѱ��� ���� ȸ��!
REVOKE SELECT ON scott.emp FROM USERTEST04;
