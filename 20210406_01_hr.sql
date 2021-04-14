SELECT USER
FROM DUAL;
--==>> HR


/*
--���� CHECK(CK:C) ����

1. �÷����� ��� ������ �������� ������ ������ �����ϱ� ���� ��������
   �÷��� �ԷµǴ� �����͸� �˻��Ͽ� ���ǿ� �´� �����͸� �Էµ� �� �ֵ���
   ó���ϸ�, �����Ǵ� ������ ���� �˻��Ͽ� ���ǿ� �´� �����ͷ� �����Ǵ� �͸�
   ����ϴ� ����� �����ϰ� �ȴ�.
   
2. ���� �� ����
   �� �÷� ������ ����
      �÷��� ������Ÿ�� [CONSTRAINT COSNTRAINT��] CHECK(�÷� ����)
      
   �� ���̺� ������ ����
      �÷��� ������Ÿ��,
      �÷��� ������Ÿ��,
      COSNTRAINT CONSTRAINT�� CHECK(�÷� ����)
      
      
�� ���� �� �ִ� �ִ밪
   NUMBER(38) �� ���̸� ������� ���� ��� �ִ밪���� �޾���
   CHAR(2000) �� ���̸� ������� ���� ��� 1���� �޾���
   VARCHAR2(4000) 
   NCHAR(1000)
   NVARCHAR(2000)
*/


--�� CK ���� �ǽ� (�� �÷� ������ ����)
--���̺� ����
CREATE TABLE TBL_TEST8
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)        CHECK (COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST8��(��) �����Ǿ����ϴ�.


--�� ������ �Է�
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '����', 100);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '����', 101);
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(3, '����', -1);
--==>> ���� �߻� (check constraint (HR.SYS_C007125) violated) * 2

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(4, '����', 80);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� Ȯ��
SELECT *
FROM TBL_TEST8;
/*
1	����	100
4	����	80
*/


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION	       DELETE_RULE
HR	    SYS_C007125	    TBL_TEST8	C	            COL3	    COL3 BETWEEN 0 AND 100 (null)
HR	    SYS_C007126	    TBL_TEST8	P	            COL1		(null)                 (null)
*/


--�� CK ���� �ǽ� (�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST9
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, COL3  NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST9��(��) �����Ǿ����ϴ�.


--�� ������ �Է�
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '����', 100);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '����', 101);
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(3, '����', -1);
--==>> ���� �߻� (check constraint (HR.SYS_C007125) violated) * 2

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(4, '����', 80);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� Ȯ��
SELECT *
FROM TBL_TEST9;
/*
1	����	100
4	����	80
*/


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION        	DELETE_RULE
HR	    TEST9_COL3_CK	TBL_TEST9	C	            COL3	    COL3 BETWEEN 0 AND 100	(null)
HR	    TEST9_COL1_PK	TBL_TEST9	P	            COL1		(null)                  (null)
*/


--�� CK ���� �ǽ� (�� ���̺� ���� ���� �������� �߰� �� CK �������� �߰�)
--���̺� ����
CREATE TABLE TBL_TEST10
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
);
--==>> Table TBL_TEST10��(��) �����Ǿ����ϴ�.


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>> ��ȸ ��� ����


--�� ���� ���̺� �������� �߰�
ALTER TABLE TBL_TEST10
ADD (CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
   , CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100));
--==>> Table TBL_TEST10��(��) ����Ǿ����ϴ�.


--�� �������� ��Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>> ��ȸ ��� ����
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION	        DELETE_RULE
HR	    TEST10_COL1_PK	TBL_TEST10	P	            COL1		(null)                  (null)
HR	    TEST10_COL3_CK	TBL_TEST10	C	            COL3	    COL3 BETWEEN 0 AND 100	(null)
*/


--�� �ǽ� ����
-- ������ ���� TBL_TESTMEMBER ���̺��� �����Ͽ�
-- SSN �÷�(�ֹι�ȣ �÷�)����
-- ������ �Է� �� ������ ��ȿ�� �����͸� �Էµ� �� �ֵ���
-- üũ ���������� �߰��� �� �ֵ��� �Ѵ�.
-- �� �ֹι�ȣ Ư�� �ڸ��� �Է� ������ �����ͷ� 1,2,3,4 �� ����
-- ����, SID �÷����� PRIMARY KEY ���������� ������ �� �ֵ��� �Ѵ�.

-- ���̺� ����
CREATE TABLE TBL_TESTMEMBER
( SID   NUMBER    
, NAME  VARCHAR2(30)
, SSN   CHAR(14)        --�Է� ���� �� 'YYMMDD-NNNNNNN'
, TEL   VARCHAR2(40)
);
--==>> Table TBL_TESTMEMBER��(��) �����Ǿ����ϴ�.

--DROP TABLE TBL_TESTMEMBER;


--�� �������� �߰�
ALTER TABLE TBL_TESTMEMBER
ADD (CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
   , CONSTRAINT TESTMEMBER_SSN_CK CHECK(TO_NUMBER(SUBSTR(SSN,8,1)) BETWEEN 1 AND 4));


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';


--�� ������ �Է� �׽�Ʈ
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL) VALUES(1, '�Ҽ���', '940718-2234567', '010-1111-1111');
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL) VALUES(2, '������', '961031-1234567', '010-2222-2222');
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL) VALUES(3, '������', '060125-4234567', '010-3333-3333');
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL) VALUES(4, '������', '071006-3234567', '010-4444-4444');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL) VALUES(5, '�̻�ȭ', '940514-5234567', '010-5555-5555');
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL) VALUES(6, '������', '971224-6234567', '010-6666-6666');
--==>> ���� �߻� (check constraint (HR.TESTMEMBER_SSN_CK) violated)


SELECT *
FROM TBL_TESTMEMBER;


--------------------------------------------------------------------------------


/*
--���� FOREIGN KEY ����

1. ���� Ű �Ǵ� �ܷ� Ű(FK)��
   �� ���̺��� ������ �� ������ �����ϰ�
   ���� �����Ű�� �� ���Ǵ� ���̴�.
   �� ���̺��� �⺻ Ű ���� �ִ� ����
   �ٸ� ���̺� �߰��ϸ� ���̺� �� ������ ������ �� �ִ�.
   �̶�, �� ��° ���̺� �߰��Ǵ� ���� �ܷ� Ű�� �ȴ�.
   
2. �θ� ���̺�(�����޴� �÷��� ���Ե� ���̺�)�� ���� ������ ��
   �ڽ� ���̺�(�����ϴ� �÷��� ���Ե� ���̺�)�� �����Ǿ�� �Ѵ�.
   �̶�, �ڽ� ���̺� FOREIGN KEY ���������� �����ȴ�.

3. ���� �� ����
   �� �÷� ������ ����
      �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��]
                        REFERENCES �������̺��(�����÷���)
                        [ON DELETE CASCADE | ON DELETE SET NULL]
      
   �� ���̺� ������ ����
      �÷��� ������Ÿ��,
      �÷��� ������Ÿ��,
      CONSTRAINT CONSTRAINT�� FOREIGN KEY(�÷���)
                 REFERENCES �������̺��(�����÷���)
                 [ON DELETE CASCADE | ON DELETE SET NULL]
                 --�߰����� �ɼ�(�������� �� �Ǵ� ����� ������ �� �ֱ� ������ ����)

�� FOREIGN KEY ���������� �����ϴ� �ǽ��� �����ϱ� ���ؼ���
   �������� �ϳ��� ���̺��� �����Ͽ� ó���ϴ� ���� �ƴ϶�
   �θ� ���̺� ���� �۾��� ���� �����ؾ� �Ѵ�.
   �׸��� �̶�, �θ� ���̺��� �ݵ�� PK �Ǵ� UK ����������
   ������ �÷��� �����ؾ� �Ѵ�.
*/


--�� �θ� ���̺� ����
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>> Table TBL_JOBS��(��) �����Ǿ����ϴ�.


--�� ������ �θ� ���̺� ������ �Է�
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1,'���');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2,'�븮');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3,'����');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4,'����');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
3	����
4	����
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� FK ���� �ǽ� (�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_EMP1
( SID       NUMBER          PRIMARY KEY
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER          REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP1��(��) �����Ǿ����ϴ�.


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION  DELETE_RULE
HR	    SYS_C007138	    TBL_EMP1	    P	            SID         (null)            (null)
HR	    SYS_C007139	    TBL_EMP1    	R	            JIKWI_ID    (null)            NO ACTION
*/


--�� �ڽ� ���̺� ������ �Է�
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1,'������',1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2,'�輭��',2);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3,'�̻�ȭ',3);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4,'������',4);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5,'�弭��',5);
--==>> ���� �߻� (integrity constraint (HR.SYS_C007139) violated - parent key not found)

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5,'�弭��',1);
INSERT INTO TBL_EMP1(SID, NAME) VALUES(6,'������');
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(7,'������',NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 3


--�� Ȯ��
SELECT *
FROM TBL_EMP1;
/*
1	������	1
2	�輭��	2
3	�̻�ȭ	3
4	������	4
5	�弭��	1
6	������	(null)
7	������	(null)
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� FK ���� �ǽ� (�� ���̺� ������ ����)
CREATE TABLE TBL_EMP2
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
             REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP2��(��) �����Ǿ����ϴ�.


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
/*
OWNER	CONSTRAINT_NAME	    TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION  DELETE_RULE
HR	    EMP2_SID_PK	        TBL_EMP2	    P	            SID         (null)            (null)
HR	    EMP2_JIKWI_ID_FK	    TBL_EMP2    	R	            JIKWI_ID    (null)            NO ACTION
*/


--�� FK ���� �ǽ� (�� ���̺� ���� ���� �������� �߰� �� FK �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_EMP3
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==>> Table TBL_EMP3��(��) �����Ǿ����ϴ�.


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> ��ȸ ��� ����


--�� �������� �߰�
ALTER TABLE TBL_EMP3
ADD (CONSTRAINT EMP3_SID_PK PRIMARY KEY(SID)
   , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                REFERENCES TBL_JOBS(JIKWI_ID));
--==>> Table TBL_EMP3��(��) ����Ǿ����ϴ�.


--�� �������� ��Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
/*
OWNER	CONSTRAINT_NAME	    TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION  DELETE_RULE
HR	    EMP3_SID_PK	        TBL_EMP3	    P	            SID         (null)            (null)
HR	    EMP3_JIKWI_ID_FK	    TBL_EMP3    	R	            JIKWI_ID    (null)            NO ACTION
*/


/*
--4. FOREIGN KEY ������ ���ǻ���
     �����ϰ��� �ϴ� �θ� ���̺��� ���� �����ؾ� �Ѵ�.
     �����ϰ��� �ϴ� �÷��� PRIMARY KEY�� UNIQUE ���������� �־�� �Ѵ�.
     ���̺� ���̿� PRIMARY KEY �� FOREIGN KEY �� ���ǵǾ� ������
     PRIMARY KEY ���������� ������ �÷��� ������ ���� ��
     FOREIGN KEY �÷��� �� ���� �ԷµǾ� �ִ� ��� �������� �ʴ´�.
     (��, FK ���� �������� ��ON DELETE CASCADE����
      ��ON DELETE SET NULL�� �ɼ��� ����Ͽ� ������ ��쿡�� ������ �����ϴ�.)
     �θ� ���̺��� �����ϱ� ���ؼ��� �ڽ� ���̺��� ���� �����ؾ� �Ѵ�.
*/


--�� �θ� ���̺�
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
3	����
4	����
*/


--�� �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
/*
1	������	1
2	�輭��	2
3	�̻�ȭ	3
4	������	4
5	�弭��	1
6	������	(null)
7	������	(null)
*/


--�� ������ ������ ������ ������� ����
UPDATE TBL_EMP1
SET JIKWI_ID = 1
WHERE SID = 4;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_EMP1;
/*
1	������	1
2	�輭��	2
3	�̻�ȭ	3
4	������	1
5	�弭��	1
6	������	(null)
7	������	(null)
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �θ� ���̺�(TBL_JOBS)�� ���� �����͸� �����ϰ� �ִ�
--   �ڽ� ���̺�(TBL_EMP1)�� �����Ͱ� �������� �ʴ� ��Ȳ.
--   �̿� ���� ��Ȳ���� �θ� ���̺�(TBL_JOBS)��
--   ���� ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
3	����
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �θ� ���̺�(TBL_JOBS)�� ��� �����͸� �����ϰ� �ִ�
--   �ڽ� ���̺�(TBL_EMP1)�� �����Ͱ� 3�� �����ϴ� ��Ȳ.
--   �̿� ���� ��Ȳ���� �θ� ���̺�(TBL_JOBS)��
--   ��� ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> ���� �߻� (integrity constraint (HR.SYS_C007139) violated - child record found)


--�� �θ� ���̺�(TBL_JOBS) ����
DROP TABLE TBL_JOBS;
--==>> ���� �߻� (unique/primary keys in table referenced by foreign keys)

--�� �����ϰ� �ִ� �ڽ� ���̺��� ���ڵ尡 �����ϴ� ��Ȳ�ӿ��� �ұ��ϰ�
--   �θ� ���̺��� �����͸� �����Ӱ� �����ϱ� ���ؼ���
--   ��ON DELETE CASCADE�� �ɼ� ������ �ʿ��ϴ�.

-- �� TBL_EMP1 ���̺�(�ڽ� ���̺�)���� FK ���������� ������ ��
-- CASCADE �ɼ��� �����Ͽ� �ٽ� FK ���������� �����Ѵ�.


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION  DELETE_RULE
HR	    SYS_C007138	    TBL_EMP1	    P	            SID         (null)            (null)
HR	    SYS_C007139	    TBL_EMP1    	R	            JIKWI_ID    (null)            NO ACTION
*/


--�� �������� ����
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007139;
--==>> Table TBL_EMP1��(��) ����Ǿ����ϴ�.


--�� �������� ��Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION DELETE_RULE
HR	    SYS_C007138	    TBL_EMP1	    P	            SID		    (null)           (null)
*/


--�� ��ON DELETE CASCADE�� �ɼ��� ���Ե� �������� �������� ������
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWIID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID)
               ON DELETE CASCADE;
--==>> Table TBL_EMP1��(��) ����Ǿ����ϴ�.


--�� �������� ��Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION DELETE_RULE
HR	    SYS_C007138	    TBL_EMP1	    P	            SID		    (null)           (null)
HR	    EMP1_JIKWIID_FK	TBL_EMP1    	R	            JIKWI_ID	(null)           CASCADE
*/


--�� CASCADE �ɼ��� ������ �Ŀ���
--   �����ް� �ִ� �θ� ���̺��� �����͸�
--   �������� �����Ӱ� �����ϴ� ���� �����ϴ�.
--   ��... �θ� ���̺��� �����Ͱ� ������ ���
--   �̸� �����ϴ� �ڽ� ���̺��� �����͵� ��� �Բ� �����ȴ�.


--�� �θ� ���̺�
SELECT *
FROM TBL_JOBS;


--�� �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;


--�� TBL_JOBS(�θ� ���̺�)�� ��� ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� �θ� ���̺� ��Ȯ��
SELECT *
FROM TBL_JOBS;
/*
2	�븮
3	����
*/


--�� �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
/*
2	�輭��	2
3	�̻�ȭ	3
6	������	(null)
7	������	(null)
*/


--------------------------------------------------------------------------------


/*
--���� NOT NULL(NN:CK:C) ����

1. ���̺��� ������ �÷��� �����Ͱ� NULL�� ���� ���ϵ��� �ϴ� ��������

2. ���� �� ����
   �� �÷� ������ ����
      �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] NOT NULL
      
   �� ���̺� ������ ����
      �÷��� ������Ÿ��,
      �÷��� ������Ÿ��,
      CONSTRAINT CONSTRAINT�� CHECK(�÷��� IS NOT NULL)

3. ������ �����Ǿ� �ִ� ���̺� NOT NULL ���������� �߰��� ���
   ADD ���� MODIFY���� �� ���� ���ȴ�.

   ALTER TABLE ���̺��
   MODIFY �÷��� ������Ÿ�� NOT NULL;
   
4. ���� ���̺� �����Ͱ� �̹� ������� ���� �÷�(�� NULL�� ����)��
   NOT NULL ���������� ���Բ� �����ϴ� ��쿡�� ���� �߻��Ѵ�.
*/


--�� NOT NULL ���� �ǽ� (�� �÷� ������ ����)
--���̺� ����
CREATE TABLE TBL_TEST11
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)     NOT NULL
);
--==>> Table TBL_TEST11��(��) �����Ǿ����ϴ�.


--�� ������ �Է�
INSERT INTO TBL_TEST11(COL1,COL2) VALUES(1,'TEST');
INSERT INTO TBL_TEST11(COL1,COL2) VALUES(2,'ABCD');
INSERT INTO TBL_TEST11(COL1,COL2) VALUES(3,'NULL');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 3

INSERT INTO TBL_TEST11(COL1,COL2) VALUES(4,NULL);
INSERT INTO TBL_TEST11(COL1) VALUES(5);
--==>> ���� �߻� (cannot insert NULL into ("HR"."TBL_TEST11"."COL2"))


--�� Ȯ��
SELECT *
FROM TBL_TEST11;
/*
1	TEST
2	ABCD
3	NULL
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST11';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION	    DELETE_RULE
HR	    SYS_C007145	    TBL_TEST11	C	            COL2	        "COL2" IS NOT NULL	(null)
HR	    SYS_C007146	    TBL_TEST11	P	            COL1		(null)              (null)
*/


--�� NOT NULL ���� �ǽ� (�� ���̺� ������ ����)
--���̺� ����
CREATE TABLE TBL_TEST12
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST12_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==>> Table TBL_TEST12��(��) �����Ǿ����ϴ�.


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST12';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION	    DELETE_RULE
HR	    TEST12_COL2_NN	TBL_TEST12	C	            COL2	        "COL2" IS NOT NULL	(null)
HR	    TEST12_COL1_PK	TBL_TEST12	P	            COL1		(null)              (null)
*/


--�� NOT NULL ���� �ǽ� (�� ���̺� ���� ���� �������� �߰� �� NN �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_TEST13
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST13��(��) �����Ǿ����ϴ�.


--�� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> ��ȸ ��� ����


--�� �������� �߰�
ALTER TABLE TBL_TEST13
ADD (CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
   , CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL));
--==>> Table TBL_TEST13��(��) ����Ǿ����ϴ�.


--�� �������� ��Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
/*
OWNER	CONSTRAINT_NAME	TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	SEARCH_CONDITION	    DELETE_RULE
HR	    TEST13_COL1_PK	TBL_TEST13	P	            COL1	    (null)              	(null)
HR	    TEST13_COL2_NN	TBL_TEST13	C	            COL2    		COL2 IS NOT NULL     (null)
*/


--�� NOT NULL �������Ǹ� �߰��ϴ� ��� ������ ���� ����� �����ϴ�.
-- ���̺� ����
CREATE TABLE TBL_TEST14
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, CONSTRAINT TEST14_COL1_PK PRIMARY KEY(COL1)
);
--==>> Table TBL_TEST14��(��) �����Ǿ����ϴ�.


--�� �������� �߰�
ALTER TABLE TBL_TEST14
MODIFY COL2 NOT NULL;
--==>> Table TBL_TEST14��(��) ����Ǿ����ϴ�.


--�� �÷� �������� NOT NULL ���������� ������ ���̺�
DESC TBL_TEST11;
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
--> DESC�� ���� COL2 �÷��� NOT NULL�� ������ Ȯ�εǴ� ��Ȳ


--�� ���̺� �������� NOT NULL ���������� ������ ���̺�
DESC TBL_TEST12;
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/
--> DESC�� ���� COL2 �÷��� NOT NULL�� ������ Ȯ�ε��� �ʴ� ��Ȳ
--> ���� ���̺� �������� �÷� ������ �����ϴ� ���� ����


--�� ���̺� ���� ���� ADD ���� ���� NOT NULL ���������� �߰��� ���̺�
DESC TBL_TEST13;
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/
--> DESC�� ���� COL2 �÷��� NOT NULL�� ������ Ȯ�ε��� �ʴ� ��Ȳ


--�� ���̺� ���� ���� MODIFY ���� ���� NOT NULL ���������� �߰��� ���̺�
DESC TBL_TEST14;
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
--> DESC�� ���� COL2 �÷��� NOT NULL�� ������ Ȯ�εǴ� ��Ȳ
--> ���� ADD ������ MODIFY ���� ���������� �߰��ϴ� ���� ����