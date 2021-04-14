SELECT USER
FROM DUAL;
--==>> SCOTT


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


SELECT *
FROM TBL_INSA;
/*
NUM	NAME	    SSN	            IBSADATE    	CITY TEL	        BUSEO	JIKWI	BASICPAY	SUDANG
1001	ȫ�浿	771212-1022432	1998-10-11	����	 011-2356-4528	��ȹ��	����	2610000	200000
1002	�̼���	801007-1544236	2000-11-29	���	 010-4758-6532	�ѹ���	���	1320000	200000
1003	�̼���	770922-2312547	1999-02-25	��õ	 010-4231-1236	���ߺ�	����	2550000	160000
*/


--�� ������ �Լ�(FN_GENDER())�� ����� �۵��ϴ����� ���� Ȯ��
SELECT '980709-2123456' "�ֹι�ȣ", FN_GENDER('980709-2123456') "����Ȯ��"
FROM DUAL;
/*
980709-2123456	����
*/


SELECT NAME, SSN, FN_GENDER(SSN) "�Լ�ȣ����"
FROM TBL_INSA;
/*
ȫ�浿	771212-1022432	����
�̼���	801007-1544236	����
�̼���	770922-2312547	����
...
*/

SELECT FN_POW(10,3) "�Լ�ȣ����"
FROM DUAL;


SELECT FN_PAY(BASICPAY,SUDANG) "�Լ�ȣ����"
FROM TBL_INSA;

SELECT FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;


--�� ���ν��� �ǽ� ���ణ ���̺� ���� �� ������ �Է�

--�� INSERT ���� ������ ���ν����� �ۼ� (INSERT ���ν���)
-- �ǽ� ���̺� ����(TBL_STUDENTS)
CREATE TABLE TBL_STUDENTS
( ID    VARCHAR2(10)
, NAME  VARCHAR2(40)
, TEL   VARCHAR2(20)
, ADDR  VARCHAR2(100)
);
--==>> Table TBL_STUDENTS��(��) �����Ǿ����ϴ�.


CREATE TABLE TBL_IDPW
( ID    VARCHAR2(10)
, PW    VARCHAR2(20)
, CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_IDPW��(��) �����Ǿ����ϴ�.

--�� ���� �л� ���� ��� �� �� ���̺� ������ �Է�
INSERT INTO TBL_STUDENTS(ID,NAME,TEL,ADDR)
VALUES('superman','������','010-1111-1111','���ֵ� ��������');
INSERT INTO TBL_IDPW(ID,PW)
VALUES('superman','java006$');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

SELECT *
FROM TBL_STUDENTS;
/*
ID	    NAME    	TEL	            ADDR
superman	������	010-1111-1111	���ֵ� ��������
*/

SELECT *
FROM TBL_IDPW;
/*
ID	    PW
superman	java006$
*/


--���� ������ ���ν���(INSERT ���ν���, �Է� ���ν���)�� �����ϰ� �Ǹ�
EXEC PRC_STUDENTS_INSERT('happyday','java006$','�輭��','010-2222-2222','���� ������');
--�̿� ���� ���� �� �ٷ� ���� ���̺� �����͸� ��� ����� �Է��� �� �ִ�.


--�� ������ ���ν���(PRC_STUDENTS_INSERT)�� ����� �۵��ϴ����� ���� Ȯ��
EXEC PRC_STUDENTS_INSERT('happyday','java006$','�輭��','010-2222-2222','���� ������');
/*
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


SELECT *
FROM TBL_STUDENTS;
/*
ID	    NAME    	TEL	            ADDR
superman	������	010-1111-1111	���ֵ� ��������
happyday	�輭��	010-2222-2222	���� ������
*/

SELECT *
FROM TBL_IDPW;
/*
ID	    PW
superman	java006$
happyday	java006$
*/


--�� �й�, �̸�, ��������, ��������, �������� �����͸�
--   �Է¹��� �� �ִ� �ǽ� ���̺� ����(TBL_SUNGJUK)
CREATE TABLE TBL_SUNGJUK
( HAKBUN    NUMBER
, NAME      VARCHAR2(40)
, KOR       NUMBER(3)
, ENG       NUMBER(3)
, MAT       NUMBER(3)
, CONSTRAINT SUNGJUK_HAKBUN_PK PRIMARY KEY(HAKBUN)
);
--==>> Table TBL_SUNGJUK��(��) �����Ǿ����ϴ�.


--�� ������ ���̺� �÷� ���� �߰�
--   (����: TOT, ���: AVG, ���: GRADE)
ALTER TABLE TBL_SUNGJUK
ADD(TOT NUMBER(3), AVG NUMBER(4,1), GRADE CHAR);
--==>> Table TBL_SUNGJUK��(��) ����Ǿ����ϴ�.


--�� ���⼭ �߰��� �÷��� ���� �׺�����
--   ���ν��� �ǽ��� ���� �߰��ϴ� ���� ��
--   ���� ���̺� ������ ����������, �ٶ��������� ���� �����̴�.


--�� ����� ���̺� ���� Ȯ��
DESC TBL_SUNGJUK;
/*
�̸�     ��?       ����           
------ -------- ------------ 
HAKBUN NOT NULL NUMBER       
NAME            VARCHAR2(40) 
KOR             NUMBER(3)    
ENG             NUMBER(3)    
MAT             NUMBER(3)    
TOT             NUMBER(3)    
AVG             NUMBER(4,1)  
GRADE           CHAR(1) 
*/


--�� ������ ���ν���(PRC_SUNGJUK_INSERT)�� ����� �۵��ϴ����� ���� Ȯ��
--���ν��� ȣ��
EXEC PRC_SUNGJUK_INSERT(1,'�̻�ȭ',90,80,70);

SELECT *
FROM TBL_SUNGJUK;
--==>> 1	�̻�ȭ	90	80	70	240	80	B


--�� ������ ���ν���(PRC_SUNGJUK_UPDATE)�� ����� �۵��ϴ����� ���� Ȯ��
--���ν��� ȣ��
EXEC PRC_SUNGJUK_UPDATE(1,50,50,50);

SELECT *
FROM TBL_SUNGJUK;
--==>> 1	�̻�ȭ	50	50	50	150	50	F


--�� ������ ���ν���(PRC_STUDENTS_UPDATE)�� ����� �۵��ϴ����� ���� Ȯ��
--���ν��� ȣ��
EXEC PRC_STUDENTS_UPDATE('superman','net006$','010-8888-8888','��� �ϻ�');
--==>> PW�� Ʋ���� ������ ���� ������ ����� ������� ����
EXEC PRC_STUDENTS_UPDATE('superman','java006$','010-9999-9999','��� �ϻ�');
SELECT *
FROM TBL_STUDENTS;
/*
superman	������	010-9999-9999	��� �ϻ�
happyday	�輭��	010-2222-2222	���� ������
*/
