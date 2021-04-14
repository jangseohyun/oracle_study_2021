SELECT USER
FROM DUAL;
--==>> HR


/*
--���� DEFAULT ǥ���� ����

1. INSERT�� UPDATE ������
   ����ڰ� �����ϴ� Ư�� ���� �ƴ�
   �⺻ ���� �Է��ϵ��� ó���� �� �ִ�.

2. ���� �� ����
   �÷��� ������Ÿ�� DEFAULT �⺻��

3. INSERT ��� �� �ش� �÷��� �Էµ� ���� �Ҵ����� �ʰų�
   DEFAULT Ű���带 Ȱ���Ͽ� �⺻ ���� �Է��ϵ��� �� �� �ִ�.

4. DEFAULT Ű����� �ٸ� ����(NOT NULL ��) ǥ�Ⱑ ���� ���� ���
   DEFAULT Ű���带 ���� ǥ��(�ۼ�)�� ���� �����Ѵ�.
*/


--�� DEFAULT ǥ���� �ǽ�
--���̺� ����
CREATE TABLE TBL_BOARD                          --�Խ��� ���̺� ����
( SID       NUMBER          PRIMARY KEY         --�Խù� ��ȣ �� �ĺ���(�ڵ� ����)
, NAME      VARCHAR2(30)                        --�Խù� �ۼ���
, CONTENTS  VARCHAR2(2000)                      --�Խù� ����
, WRITEDATE DATE            DEFAULT SYSDATE     --�Խù� �ۼ���(���� ��¥ �ڵ� �Է�)
, COMMENTS  NUMBER          DEFAULT 0           --�Խù��� ��� ����(�⺻�� 0)
, COUNTS    NUMBER          DEFAULT 0           --�Խù� ��ȸ��(�⺻�� 0)
);


--�� SID�� �ڵ� ���� ������ ��Ϸ��� ������ ��ü�� �ʿ��ϴ�.
--   �ڵ����� �ԷµǴ� �÷��� ����ڰ� �Է��ؾ� �ϴ� �׸񿡼�
--   ���ܽ�ų �� �ִ�.


--�� ������ ����
CREATE SEQUENCE SEQ_BOARD
NOCACHE;
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.


--�� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD(SID,NAME,CONTENTS,WRITEDATE,COMMENTS,COUNTS)
VALUES(SEQ_BOARD.NEXTVAL,'�̻�ȭ','����Ŭ���� DEFAULT ǥ������ �ǽ����Դϴ�.'
     , TO_DATE('2021-04-06 11:01:13','YYYY-MM-DD HH24:MI:SS'),0,0);
INSERT INTO TBL_BOARD(SID,NAME,CONTENTS,WRITEDATE,COMMENTS,COUNTS)
VALUES(SEQ_BOARD.NEXTVAL,'�Ҽ���','��� �ǽ����Դϴ�.',SYSDATE,0,0);
INSERT INTO TBL_BOARD(SID,NAME,CONTENTS,WRITEDATE,COMMENTS,COUNTS)
VALUES(SEQ_BOARD.NEXTVAL,'������','���� �ǽ����Դϴ�.',DEFAULT,DEFAULT,DEFAULT);
INSERT INTO TBL_BOARD(SID,NAME,CONTENTS)
VALUES(SEQ_BOARD.NEXTVAL,'������','�׽�Ʈ ���������Դϴ�.');


--�� Ȯ��
SELECT *
FROM TBL_BOARD;
/*
1	�̻�ȭ	����Ŭ���� DEFAULT ǥ������ �ǽ����Դϴ�.	2021-04-06 11:01:13	0	0
2	�Ҽ���	��� �ǽ����Դϴ�.	                        2021-04-07 09:30:58	0	0
3	������	���� �ǽ����Դϴ�.	                        2021-04-07 09:32:01	0	0
4	������	�׽�Ʈ ���������Դϴ�.	                    2021-04-07 09:33:01	0	0
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� DEFAULT ǥ���� Ȯ��(��ȸ)
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'TBL_BOARD';
/*
TABLE_NAME	COLUMN_NAME	DATA_TYPE DATA_DEFAULT
TBL_BOARD	SID	        NUMBER
TBL_BOARD	NAME	    VARCHAR2
TBL_BOARD	CONTENTS	VARCHAR2
TBL_BOARD	WRITEDATE	DATE      "SYSDATE"
TBL_BOARD	COMMENTS	NUMBER    "0"
TBL_BOARD	COUNTS	    NUMBER    "0"
*/


--�� ���̺� ���� ���� DEFAULT ǥ���� �߰� / ����
ALTER TABLE ���̺��
MODIFY �÷��� [�ڷ���] DEFUALT �⺻��;


--�� ������ DEFAULT ǥ���� ����(����)
ALTER TABLE ���̺��
MODIFY �÷��� [�ڷ���] DEFAULT NULL;