--------------------------------------------------------
--  DDL for Table BOARD
--------------------------------------------------------

  CREATE TABLE "SCOTT"."BOARD" 
   (	"NUM" NUMBER, 
	"WRITER" VARCHAR2(20 BYTE), 
	"SUBJECT" VARCHAR2(50 BYTE), 
	"CONTENT" VARCHAR2(500 BYTE), 
	"EMAIL" VARCHAR2(30 BYTE), 
	"READCOUNT" NUMBER DEFAULT 0, 
	"PASSWD" VARCHAR2(12 BYTE), 
	"REF" NUMBER, 
	"RE_STEP" NUMBER, 
	"RE_LEVEL" NUMBER, 
	"IP" VARCHAR2(20 BYTE), 
	"REG_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;

   COMMENT ON COLUMN "SCOTT"."BOARD"."REF" IS '�亯�۳��� �׷�';
   COMMENT ON COLUMN "SCOTT"."BOARD"."RE_STEP" IS 'ref���� ����';
   COMMENT ON COLUMN "SCOTT"."BOARD"."RE_LEVEL" IS '�鿩����';
REM INSERTING into SCOTT.BOARD
SET DEFINE OFF;
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (1,'����','�Խ��� ù��','ù ���̳׿�
�Խ��� ���ø� �̷缼��','aa@naver.com',0,'111',1,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (2,'�浿1','����ִ� Jsp 1','��� �� ������ �� ~ 1','kk1@k.com',0,'1',2,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (39,'�縸��','�Խ��� ù��','�츮�� 
��������
�����Ѵ�','kk18@k.com',8,'1',39,0,0,'0:0:0:0:0:0:0:1',to_date('16/04/09','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (4,'�浿3','����ִ� Jsp 3','��� �� ������ �� ~ 3','kk3@k.com',4,'1',4,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (36,'������','[�亯]�����Ǳ�','������ ������ �Ź��߽���
���� �Ǿ�� �Ͽ�
�̹���� ����Ͻÿ�','jung@k.com',2,'1',6,1,1,'0:0:0:0:0:0:0:1',to_date('16/03/02','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (6,'�̼���','�����Ǳ�5','��ȭ�� ȸ�� �̾߱�','Lee@k.com',13,'1',6,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (37,'������','���� �־��','���� �ƾ��
���� �� ����� �ڱ��� ^^','kim@k.com',6,'1',37,0,0,'0:0:0:0:0:0:0:1',to_date('16/03/02','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (8,'�浿7','����ִ� Jsp 7','��� �� ������ �� ~ 7','kk7@k.com',8,'1',8,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (38,'������','[�亯] ���� �־��  ����','�ƽ�����','kk18@k.com',5,'1',37,1,1,'0:0:0:0:0:0:0:1',to_date('16/03/02','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (10,'�浿9','����ִ� Jsp 9','��� �� ������ �� ~ 9','kk9@k.com',0,'1',10,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (11,'�浿10','����ִ� ������',' ��� �� ������ �� ~ 10
                                 ','kk10@k.com',2,'1',11,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (12,'�浿11','����ִ� Jsp 11','��� �� ������ �� ~ 11','kk11@k.com',0,'1',12,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (40,'����� ','[�亯] ���� ����','���� ���� �Ѱ���','kk18@k.com',2,'1',30,6,2,'0:0:0:0:0:0:0:1',to_date('16/04/09','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (14,'�浿13','����ִ� Jsp 13','��� �� ������ �� ~ 13','kk13@k.com',0,'1',14,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (15,'�浿14','����ִ� Jsp 14','��� �� ������ �� ~ 14','kk14@k.com',2,'1',15,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (16,'�浿15','����ִ� Jsp 15','��� �� ������ �� ~ 15','kk15@k.com',2,'1',16,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (17,'�浿16','����ִ� Jsp 16','��� �� ������ �� ~ 16','kk16@k.com',3,'1',17,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (18,'�浿17','����ִ� Jsp 17','��� �� ������ �� ~ 17','kk17@k.com',3,'1',18,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (19,'����','����ִ�  18',' ��� �� ������ �� ~ 18
                                 ','kk18@k.com',6,'1',19,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (20,'�浿19','����ִ� Jsp 19111','   ��� �� ������ �� ~ 19
����ֳ�
                                 
                                 
                                 ','kk19@k.com',21,'1',20,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (21,'������','20���� ��������','  ���� �������� �� �̷��
 ���� ^^      ','kim20@k.com',52,'1234',21,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (22,'�縸��','�Ƚô�ø',' ��� �Ƚü� ��                  
                                 
                                 ','kk21@k.com',6,'1',22,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (23,'�浿22','����ִ� Jsp 22','��� �� ������ �� ~ 22','kk22@k.com',7,'1',23,0,0,'0:0:0:0:0:0:0:1',to_date('16/02/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (24,'���','[�亯] 111','����','aa@naver.com',2,'111',23,1,1,'0:0:0:0:0:0:0:1',to_date('16/02/28','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (25,'������','[�亯] ��������','���屺
�����մϱ�?','aa@naver.com',3,'111',21,2,1,'0:0:0:0:0:0:0:1',to_date('16/02/29','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (26,'���','[�亯]����','��ճ�          ','kim20@k.com',1,'111',20,1,1,'0:0:0:0:0:0:0:1',to_date('16/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (27,'������','[�亯]18���','�� ������ �Դϴ�','kim20@k.com',0,'111',19,1,1,'0:0:0:0:0:0:0:1',to_date('16/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (28,'���ؼ�','���ť�� ',' ���ť�� ���־��
��  �̳�....
1000���� ���','kim20@k.com',8,'1234',28,0,0,'0:0:0:0:0:0:0:1',to_date('16/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (29,'������','[�亯]�� ����� �����µ�..',' �ް��� ���� ~
���տ� �����ѵ�  ���̷���~
�� �ٶ��� �Ҿ���� ......    ','jung@k.com',6,'1234',28,1,1,'0:0:0:0:0:0:0:1',to_date('16/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (30,'������','����ũ������','���� ��ǰ �̾����','kim20@k.com',29,'111',30,0,0,'0:0:0:0:0:0:0:1',to_date('16/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (31,'�ż���','[�亯]�츮��� ������','�ⷷ�Ÿ���','sin@k.com',2,'111',30,5,1,'0:0:0:0:0:0:0:1',to_date('16/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (32,'������','[�亯]�Ƿ��� �뷡',' ������,�������� �ִٱ�   
                                 ','kim20@k.com',9,'111',30,4,1,'0:0:0:0:0:0:0:1',to_date('16/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (33,'������','[�亯]�� �˾ƿ�','�� �̱⸦ ..
�׷��� ��Ÿ�� ..','um@k.comum',3,'111',30,3,1,'0:0:0:0:0:0:0:1',to_date('16/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (34,'�ȿ��� ','[�亯]������',' �̽�Ÿ �̽��׸�','kim20@k.com',2,'111',11,1,1,'0:0:0:0:0:0:0:1',to_date('16/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (35,'����','[�亯]��ƼĿ',' ���ǹ߷� �ɾ���
�� ���峵��
                                 ','kim20@k.com',2,'111',11,2,2,'0:0:0:0:0:0:0:1',to_date('16/03/01','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (41,'���','[�亯] ������ ���','�뷡 �Ƿ��ؿ�','kkk@com',1,'1234',30,1,1,'0:0:0:0:0:0:0:1',to_date('16/04/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (42,'����','[�亯] ��ī','���߾� �װ� ���� ���� Ȳ���̾�������','kkk@com',1,'1234',21,3,2,'0:0:0:0:0:0:0:1',to_date('16/04/27','RR/MM/DD'));
Insert into SCOTT.BOARD (NUM,WRITER,SUBJECT,CONTENT,EMAIL,READCOUNT,PASSWD,REF,RE_STEP,RE_LEVEL,IP,REG_DATE) values (43,'�����ҹ�','[�亯] ����','�̰͵���
���� ��� �ִ��� �����','kkk@com',1,'1234',21,1,1,'0:0:0:0:0:0:0:1',to_date('16/04/27','RR/MM/DD'));
--------------------------------------------------------
--  DDL for Index SYS_C007041
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCOTT"."SYS_C007041" ON "SCOTT"."BOARD" ("NUM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table BOARD
--------------------------------------------------------

  ALTER TABLE "SCOTT"."BOARD" ADD PRIMARY KEY ("NUM")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("REG_DATE" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("IP" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("RE_LEVEL" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("RE_STEP" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("REF" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("PASSWD" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("CONTENT" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("SUBJECT" NOT NULL ENABLE);
  ALTER TABLE "SCOTT"."BOARD" MODIFY ("WRITER" NOT NULL ENABLE);
