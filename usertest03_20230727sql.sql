CREATE TABLE SALGRADE
        (GRADE NUMBER(2)  CONSTRAINT PK_GRADE  PRIMARY KEY,
         LOSAL NUMBER(5),
         HISAL NUMBER(5));
         
--���� ADMIN TBL ��ȸ ����X
SELECT * FROM system.systemTBL;

---USERTEST04�� �ִ� SYSTEMTBL�� READ���� USERTEST 03 �ּ��� -> USERTEST04���� ����
GRANT SELECT   ON  system.systemTBL to usertest03;
         
--���� ADMIN TBL ��ȸ ����
SELECT * FROM system.systemTBL;

---USERTEST03�� �ִ� SYSTEMTBL�� READ���� USERTEST 02 �ּ��� -> USERTEST03���� ����
GRANT SELECT   ON  system.systemTBL to usertest02;

--���� ȸ�� �� �ȵ�

--usertest04���� ���Ѻο��� �ѰŸ� ������ ����----
-- �翬�� �ȵ� scott �� student ���̺��� with  grand option �� ���� ���� �ʾ���.
GRANT SELECT ON scott.student TO usertest03;
-- ��  scott �� ������ �ٶ� ���Ѻο� �ɼǵ� ���� ���־��� ������ 03���� �� �� ����
GRANT SELECT ON scott.emp TO usertest03 WITH GRANT OPTION;
------------------------------------------------

SELECT * FROM scott.emp; -- ���� ��
SELECT * FROM scott.dept; --���� x
SELECT * FROM scott.student; --���� x

SELECT * FROM scott.emp;  --x

