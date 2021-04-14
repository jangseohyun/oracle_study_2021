SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_SAWON ���̺��� ������ ������ �����
--   �����ȣ, �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
--   ��, SUBSTR()�Լ��� ����� �� �ֵ��� �ϸ�
--   �޿� �������� �������� ������ ������ �� �ֵ��� �Ѵ�.
SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ", SAL "�޿�"
FROM TBL_SAWON
WHERE SUBSTR(JUBUN,7,1) = '1'
   OR SUBSTR(JUBUN,7,1) = '3'
ORDER BY SAL DESC;
/*
1009	������	9804251234567	4000
1011	������	7505071234567	3000
1016	����	7012121234567	2000
1014	������	0203043234567	2000
1015	���ü�	0512123234567	1000
*/

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ", SAL "�޿�"
FROM TBL_SAWON
WHERE SUBSTR(JUBUN,7,1) IN ('1','3')
ORDER BY SAL DESC;
/*
1009	������	9804251234567	4000
1011	������	7505071234567	3000
1016	����	7012121234567	2000
1014	������	0203043234567	2000
1015	���ü�	0512123234567	1000
*/


--�� LENGTH() / LENGTHB()
SELECT ENAME "1", LENGTH(ENAME) "2", LENGTHB(ENAME) "3"
FROM TBL_EMP;
/*
SMITH	5	5
ALLEN	5	5
WARD	4	4
JONES	5	5
MARTIN	6	6
BLAKE	5	5
CLARK	5	5
SCOTT	5	5
KING	4	4
TURNER	6	6
ADAMS	5	5
JAMES	5	5
FORD	4	4
MILLER	6	6
*/
--> LENGTH()�� ���� �� ��ȯ, LENGTHB()�� ����Ʈ �� ��ȯ


--�� Ȯ��
SELECT *
FROM NLS_DATABASE_PARAMETERS;
--==>> NLS_CHARACTERSET	        AL32UTF8
--==>> NLS_NCHAR_CHARACTERSET	AL16UTF16

--�� �ѱ� �����͸� ó���� ���
--   ����Ʈ ������� ó���ؾ߸� �ϴ� ��Ȳ�̶��
--   �׻� ���ڵ� ����� �� üũ�ϰ� ����ؾ� �Ѵ�.


--�� INSTR()
SELECT 'ORACLE ORAHOME BIORA' "1"
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 1) "2"
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 2) "3"
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 1) "4"
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2) "5"
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 2) "6"
FROM DUAL;
--==>> ORACLE ORAHOME BIORA	1	8	8	8	18
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ�����(��� ���ڿ�)
--> �� ��° �Ķ���� ���� ���� �Ѱ��� ���ڿ��� �����ϴ� ��ġ�� ã�ƶ�
--> �� ��° �Ķ���� ���� ã�� �����ϴ�(��ĵ�� �����ϴ�)
--> �� ��° �Ķ���� ���� �� ��° �����ϴ� ���� ã�� �������� ���� ����


SELECT '���ǿ���Ŭ �����ο��� �մϴ�' "1"
     , INSTR('���ǿ���Ŭ �����ο��� �մϴ�', '����', 1) "2"
     , INSTR('���ǿ���Ŭ �����ο��� �մϴ�', '����', 2) "3"
     , INSTR('���ǿ���Ŭ �����ο��� �մϴ�', '����', 10) "4"
     , INSTR('���ǿ���Ŭ �����ο��� �մϴ�', '����', 11) "5"
FROM DUAL;
--==>> ���ǿ���Ŭ �����ο��� �մϴ�	 3	 3	10	0
--> ������ �Ķ����(�� ��° �Ķ����) ���� ������ ���·� ��� �� �⺻ 1


--�� REVERSE()
SELECT 'ORACLE' "1"
     , REVERSE('ORACLE') "2"
FROM DUAL;
--==>> ORACLE	ELCARO


--�� �ǽ� ��� ���̺� ����(TBL_FILES)
CREATE TABLE TBL_FILES
( FILENO    NUMBER(3)
, FILENAME  VARCHAR2(100)
);
--==>>Table TBL_FILES��(��) �����Ǿ����ϴ�.


--�� �ǽ� ������ �Է�
INSERT INTO TBL_FILES VALUES(1, 'C:\AAA\BBB\CCC\SALES.DOC');
INSERT INTO TBL_FILES VALUES(2, 'C:\AAA\PANMAE.XXLS');
INSERT INTO TBL_FILES VALUES(3, 'D:\RESEARCH.PPT');
INSERT INTO TBL_FILES VALUES(4, 'C:\DOCUMENTS\STUDY.HWP');
INSERT INTO TBL_FILES VALUES(5, 'C:\DOCUMENTS\TEMP\SQL.TXT');
INSERT INTO TBL_FILES VALUES(6, 'D:\SHARE\F\TEST.PNG');
INSERT INTO TBL_FILES VALUES(7, 'C:\USER/GUILDONG\PICTURE\PHOTO\SPRING.JPG');
INSERT INTO TBL_FILES VALUES(8, 'C:\ORACLESTUDY\20210329_01_SCOTT.SQL');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 8


--�� Ȯ��
SELECT *
FROM TBL_FILES;
/*
1	C:\AAA\BBB\CCC\SALES.DOC
2	C:\AAA\PANMAE.XXLS
3	D:\RESEARCH.PPT
4	C:\DOCUMENTS\STUDY.HWP
5	C:\DOCUMENTS\TEMP\SQL.TXT
6	D:\SHARE\F\TEST.PNG
7	C:\USER/GUILDONG\PICTURE\PHOTO\SPRING.JPG
8	C:\ORACLESTUDY\20210329_01_SCOTT.SQL
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� TBL_FILES ���̺��� ������� ���� ���� ��ȸ�� �� �ֵ���(���ϸ�.Ȯ����)
--   �������� �����Ѵ�.
SELECT FILENO "���Ϲ�ȣ"
     , REVERSE(SUBSTR(REVERSE(FILENAME),1,INSTR(REVERSE(FILENAME), '\', 1)-1)) "���ϸ�"
FROM TBL_FILES;
/*
1	SALES.DOC
2	PANMAE.XXLS
3	RESEARCH.PPT
4	STUDY.HWP
5	SQL.TXT
6	TEST.PNG
7	SPRING.JPG
8	20210329_01_SCOTT.SQL
*/


--�� LPAD()
--> Byte ������ Ȯ���Ͽ� ���ʺ��� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "1"
     , LPAD ('ORACLE', 10, '*') "2" 
FROM DUAL;
--> �� 10 Byte ������ Ȯ���Ѵ�.
--> �� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�.
--> �� �����ִ� Byte ����(4Byte)�� ���ʺ��� �� ��° �Ķ���� ������ ä���.
--> �� �̷��� ������ ���� ������� ��ȯ�Ѵ�.
--==>> ORACLE	****ORACLE


--�� RPAD()
--> Byte ������ Ȯ���Ͽ� �����ʺ��� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "1"
     , RPAD ('ORACLE', 10, '*') "2" 
FROM DUAL;
--> �� 10 Byte ������ Ȯ���Ѵ�.
--> �� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�.
--> �� �����ִ� Byte ����(4Byte)�� �����ʺ��� �� ��° �Ķ���� ������ ä���.
--> �� �̷��� ������ ���� ������� ��ȯ�Ѵ�.
--==>> ORACLE	ORACLE****


--�� LTRIM()
SELECT 'ORAORAORACLEORACLE' "1"
     , LTRIM('ORAORAORACLEORACLE', 'ORA') "2"
     , LTRIM('AAAORAORAORACLEORACLE', 'ORA') "3"
     , LTRIM('ORAoRAORACLEORACLE', 'ORA') "4"
     , LTRIM('ORA   ORAORACLEORACLE', 'ORA') "5"
     , LTRIM('      ORAORACLEORACLE', ' ') "6"
     , LTRIM('               ORACLE') "7" --���� ���� ���� �Լ��� Ȱ��(�Ķ���� ����)
FROM DUAL;
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--> ���ʺ��� ���������� �� ��° �Ķ���� ������ ������ ���ڿ� ���� ���ڰ� ������ ���
--> �̸� ������ ������� ��ȯ�Ѵ�.
--> ��, �ϼ������� ó������ �ʴ´�.
/*
ORAORAORACLEORACLE
CLEORACLE
CLEORACLE
oRAORACLEORACLE
   ORAORACLEORACLE
ORAORACLEORACLE
ORACLE
*/


--�� RTRIM()
SELECT 'ORAORAORACLEORACLE' "1"
     , RTRIM('ORAORAORACLEORACLE', 'ORA') "2"
     , RTRIM('AAAORAORAORACLEORACLE', 'ORA') "3"
     , RTRIM('ORAoRAORACLEORACLE', 'ORA') "4"
     , RTRIM('ORA   ORAORACLEORACLE', 'ORA') "5"
     , RTRIM('      ORAORACLEORACLE', ' ') "6"
     , RTRIM('               ORACLE') "7" 
     , RTRIM('ORACLE               ') "8" 
FROM DUAL;
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--> �����ʺ��� ���������� �� ��° �Ķ���� ������ ������ ���ڿ� ���� ���ڰ� ������ ���
--> �̸� ������ ������� ��ȯ�Ѵ�.
--> ��, �ϼ������� ó������ �ʴ´�.
/*
ORAORAORACLEORACLE
ORAORAORACLEORACLE
AAAORAORAORACLEORACLE
ORAoRAORACLEORACLE
ORA   ORAORACLEORACLE
      ORAORACLEORACLE
               ORACLE
ORACLE
*/

SELECT LTRIM('�̱���̱�����̽Žű��̽����̱��̱���̽Ź��̱��', '�̱��')
FROM DUAL;
--==>> ���̱��


--�� TRANSLATE()
--> 1:1 �� �ٲپ��ش�.
SELECT TRANSLATE('MY ORACLE SERVER','ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')
FROM DUAL;
--==>> my oracle server

SELECT TRANSLATE('010-4020-7429','0123456789','�����̻�����ĥ�ȱ�')
FROM DUAL;
--==>> ���Ͽ�-�翵�̿�-ĥ���̱�


--�� REPLACE()
SELECT REPLACE('MY ORACLE ORHOME','ORA','����')
FROM DUAL;
--==>> MY ����CLE ORHOME


--------------------------------------------------------------------------------


--�� ROUND() �ݿø��� ó�����ִ� �Լ�
SELECT 48.678 "1"
     , ROUND(48.678, 2) "2"     --�Ҽ��� ���� ��°�ڸ����� ǥ��(��°�ڸ����� �ݿø�)
     , ROUND(48.674, 2) "3"
     , ROUND(48.674, 1) "4"
     , ROUND(48.674, 0) "5"     --�� ��° �Ķ���� 0: ���� ���·� ǥ��
     , ROUND(48.674) "6"        --0�� ���� ����
     , ROUND(48.674, -1) "7"    --10�� �ڸ����� ��ȿ�� ǥ��
     , ROUND(48.674, -2) "8"    --������ ��� �Ҽ����� �������� ���� N��°���� �ݿø�
     , ROUND(48.674, -3) "9"
FROM DUAL;
--==>> 48.678	48.68	48.67	48.7	49	49	50	0	0


--�� TRUNC() ������ ó�����ִ� �Լ�
SELECT 48.678 "1"
     , TRUNC(48.678, 2) "2"
     , TRUNC(48.674, 2) "3"
     , TRUNC(48.674, 1) "4"
     , TRUNC(48.674, 0) "5"
     , TRUNC(48.674) "6"
     , TRUNC(48.674, -1) "7"
     , TRUNC(48.674, -2) "8"
     , TRUNC(48.674, -3) "9"
FROM DUAL;
--==>> 48.678	48.67	48.67	48.6	48	48	40	0	0


--�� MOD() �������� ��ȯ�ϴ� �Լ�
SELECT MOD(5,2)
FROM DUAL;
--==>> 1


--�� POWER() ������ ����� ��ȯ�ϴ� �Լ�
SELECT POWER(5,3)
FROM DUAL;
--==>> 125


--�� SQRT() ��Ʈ ������� ��ȯ�ϴ� �Լ�
SELECT SQRT(2)
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857


--�� LOG() �α� �Լ�
--   (�� ����Ŭ�� ���α׸� �����ϴ� �ݸ�, MSSQL�� ���α� �ڿ��α� ��� �����Ѵ�.)
SELECT LOG(10,100), LOG(10,100)
FROM DUAL;
--==>> 2	2


--�� �ﰢ �Լ�
--   ����, �ڽ���, ź��Ʈ ������� ��ȯ�Ѵ�.
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
/*
0.8414709848078965066525023216302989996233
0.5403023058681397174009366074429766037354
1.55740772465490223050697480745836017308
*/


--�� �ﰢ�Լ��� ���Լ� (����: -1 ~ 1)
--   �����, ���ڽ���, ��ź��Ʈ ������� ��ȯ�Ѵ�.
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
/*
1.04719755119659774615421446109316762805
0.52359877559829887307710723054658381405
0.4636476090008061162142562314612144020295
*/


--�� SIGN()  ����, ��ȣ, Ư¡
--> ���� ������� ����̸� 1, 0�̸� 0, �����̸� -1�� ��ȯ�Ѵ�.
SELECT SIGN(5-2), SIGN(5-5), SIGN(5-7)
FROM DUAL;
--==>> 1	0	-1
--> �����̳� ������ �����Ͽ� ���� �� ������ ������ ��Ÿ�� �� �ַ� ����Ѵ�.


--�� ASCII(), CHR() �� ���� �����ϴ� ������ �Լ�
SELECT ASCII('A'), CHR(65)
FROM DUAL;
--==>> 65   A
--> ASCII: �Ű������� �Ѱܹ��� ������ �ƽ�Ű�ڵ� ���� ��ȯ�Ѵ�.
--> CHR  : �Ű������� �Ѱܹ��� ���ڸ� �ƽ�Ű�ڵ� ������ ���ϴ� ���ڸ� ��ȯ�Ѵ�.


--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ��¥ ������ �⺻ ������ DAY(�ϼ�)
SELECT SYSDATE, SYSDATE+1, SYSDATE-2, SYSDATE+3
FROM DUAL;
/*
2021-03-29 12:03:51     --����
2021-03-30 12:03:51     --1�� ��
2021-03-27 12:03:51     --2�� ��
2021-04-01 12:03:51     --3�� ��
*/


--�� �ð� ���� ����
SELECT SYSDATE, SYSDATE+1/24, SYSDATE-2/24
FROM DUAL;
/*
2021-03-29 12:07:11
2021-03-29 13:07:11
2021-03-29 10:07:11
*/


--�� ���� �ð��� ���� �ð� ���� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ�Ѵ�.
--   2021-03-30 14:08:56
--���1
SELECT SYSDATE, SYSDATE+1+2/24+3/1440+4/86400
FROM DUAL;

--���2
SELECT SYSDATE, SYSDATE+((24*60*60)+(2*60*60)+(3*60)+4)/(24*60*60)
FROM DUAL;


--�� ��¥-��¥=�ϼ�
--   EX) (2021-07-09) - (2021-03-29)
SELECT TO_DATE('2021-07-09','YYYY-MM-DD')-TO_DATE('2021-03-29','YYYY-MM-DD')
FROM DUAL;
--==>> 102


--�� ������ Ÿ���� ��ȯ
TO_DATE('2021-07-59','YYYY-MM-DD')
FROM DUAL;
--==>> ���� ���� - �� �� ���� ���

--�� TO_DATE() �Լ��� ���� ���� Ÿ���� ��¥ Ÿ������ ��ȯ�� ��
--   ���������� �ش� ��¥�� ���� ��ȿ�� �˻簡 �̷������.


--�� ADD_MONTHS() ���� ���� �����ִ� �Լ�
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 2)
FROM DUAL;
--==>> 2021-03-29 12:28:44   2021-05-29 12:28:44

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 2), ADD_MONTHS(SYSDATE, 3), ADD_MONTHS(SYSDATE, -2), ADD_MONTHS(SYSDATE, -3)
FROM DUAL;
/*
2021-03-29 12:31:46     --����
2021-05-29 12:31:46     --2���� ��
2021-06-29 12:31:46     --3���� ��
2021-01-29 12:31:46     --2���� ��
2020-12-29 12:31:46     --3���� ��
*/


--�� ��¥ ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� MONTHS_BETWEEN()
--   ù ��° ���ڰ����� �� ��° ���ڰ��� �� �������� ��ȯ
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31','YYYY-MM-DD'))
FROM DUAL;
--==>> 225.952385379330943847072879330943847073
--> ���� ���� ���̸� ��ȯ�ϴ� �Լ�

--�� ������� ��ȣ�� ��-��(����)�� ��ȯ�Ǿ��� ��쿡��
--   ù ��° ���ڰ��� �ش��ϴ� ��¥����
--   �� ��° ���ڰ��� �ش��ϴ� ��¥�� ���̷������ �ǹ̷� Ȯ���� �� �ִ�.

SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2021-07-09','YYYY-MM-DD'))
FROM DUAL;
--==>> -3.33785767622461170848267622461170848268


--�� NEXT_DAY()
--   ù ��° ���ڰ��� ���� ��¥�� ���ƿ��� ���� ���� ���� ��ȯ
SELECT NEXT_DAY(SYSDATE,'��'),NEXT_DAY(SYSDATE,'��')
FROM DUAL;
--==>> 2021-04-03	2021-04-05


--�� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ���� ���� ������ ���� ���� �������� �ٽ� �ѹ� ��ȸ
SELECT NEXT_DAY(SYSDATE,'��'),NEXT_DAY(SYSDATE,'��')
FROM DUAL;
--==>> ���� �߻�: not a valid day of the week

SELECT NEXT_DAY(SYSDATE,'SAT'),NEXT_DAY(SYSDATE,'MON')
FROM DUAL;
--==>> 2021-04-03	2021-04-05


--�� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.
--> ALTER�� ��� ���� Ŀ���� �����


--�� LAST_DAY()
--   �ش� ��¥�� ���ԵǾ� �ִ� �� ���� ������ ���� ��ȯ�Ѵ�.
SELECT LAST_DAY(SYSDATE)
FROM DUAL;
--==>> 2021-03-31


--�� ���Դ�
--   1. �����Ⱓ 22������ �� ���� ���� ���ϱ�
--   2. ���� 3�� �Ļ縦 �ؾ� �Ѵٰ� �������� ��
--      �����ϱ��� ��� �Ծ�� ����
SELECT ADD_MONTHS(SYSDATE, 22) "��������", (ADD_MONTHS(SYSDATE, 22)-SYSDATE)*3
FROM DUAL;


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ������(2021-07-09 18:00:00) ���� ���� �Ⱓ
SELECT SYSDATE "���� �ð�", TO_DATE('2021-07-09 18:00:00','YYYY-MM-DD HH24:MI:SS') "������"
     , TRUNC(TO_DATE('2021-07-09 18:00:00','YYYY-MM-DD HH24:MI:SS')-SYSDATE) "��"
     , TRUNC(MOD((TO_DATE('2021-07-09 18:00:00','YYYY-MM-DD HH24:MI:SS')-SYSDATE),1)*24) "�ð�"
     , TRUNC(MOD((TO_DATE('2021-07-09 18:00:00','YYYY-MM-DD HH24:MI:SS')-SYSDATE)*24,1)*60) "��"
     , TRUNC(MOD((TO_DATE('2021-07-09 18:00:00','YYYY-MM-DD HH24:MI:SS')-SYSDATE)*24*60,1)*60) "��"
FROM DUAL;
--==>> 2021-03-29 14:46:30   2021-07-09 18:00:00   102   3   13   30

--����� Ǯ��
SELECT SYSDATE "���� �ð�"
     , TO_DATE('2021-07-09 18:00:00','YYYY-MM-DD HH24:MI:SS') "������"
     , TRUNC(TRUNC(TRUNC(((TO_DATE('2021-07-09 18:00:00','YYYY-MM-DD HH24:MI:SS')-SYSDATE) "��"
FROM DUAL;


--�� ����
--   ������ �¾�� �������
--   �󸶸�ŭ�� ��, �ð�, ��, �ʸ� ��Ҵ���
--   ��ȸ�ϴ� �������� �����Ѵ�.
SELECT SYSDATE "����ð�"
     , TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS') "�¾ �ð�"
     , TRUNC(SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS')) "��"
     , TRUNC(MOD((SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS')),1)*24) "�ð�"
     , TRUNC(MOD((SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS'))*24,1)*60) "��"
     , TRUNC(MOD((SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS'))*24*60,1)*60) "��"
FROM DUAL;
--==>> 2021-03-29 16:24:30   1998-07-09 10:49:00   8299   5   35   30


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ��¥ �ݿø�
SELECT SYSDATE "1"                  --2021-03-29    �� �⺻ ���� ��¥
     , ROUND(SYSDATE, 'YEAR') "2"   --2021-01-01    �� �⵵���� ��ȿ�� ������(��ݱ�, �Ϲݱ� ����)
     , ROUND(SYSDATE, 'MONTH') "3"  --2021-04-01    �� ������ ��ȿ�� ������(15�� ����)
     , ROUND(SYSDATE, 'DD') "4"     --2021-03-30    �� �ϱ��� ��ȿ�� ������(���� ����)
     , ROUND(SYSDATE, 'DAY') "5"    --2021-03-28    �� ��¥���� ��ȿ�� ������(������ ����)
FROM DUAL;


--�� ��¥ ����
SELECT SYSDATE "1"                  --2021-03-29    �� �⺻ ���� ��¥
     , TRUNC(SYSDATE, 'YEAR') "2"   --2021-01-01    �� �⵵���� ��ȿ�� ������
     , TRUNC(SYSDATE, 'MONTH') "3"  --2021-04-01    �� ������ ��ȿ�� ������
     , TRUNC(SYSDATE, 'DD') "4"     --2021-03-30    �� �ϱ��� ��ȿ�� ������
     , TRUNC(SYSDATE, 'DAY') "5"    --2021-03-28    �� ��¥���� ��ȿ�� ������(������ �Ͽ��� ����)
FROM DUAL;


--------------------------------------------------------------------------------


--���� ��ȯ �Լ� ����

-- TO_CHAR()   : ���ڳ� ��¥ �����͸� ���� Ÿ������ ��ȯ�����ִ� �Լ�
-- TO_DATE()   : ���� ������(��¥ ����)�� ��¥ Ÿ������ ��ȯ�����ִ� �Լ�
-- TO_NUMBER() : ���� ������(���� ����)�� ���� Ÿ������ ��ȯ�����ִ� �Լ�

SELECT 10 "1", TO_CHAR(10) "2"
FROM DUAL;

--�� ��¥�� ��ȭ ������ ���� ���� ���
--   ���� �������� ���� ������ �� �ֵ��� �Ѵ�.

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_CURRENCY = '\';   --ȭ�����: ��(��)
--==>> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')   --2021-03-29
     , TO_CHAR(SYSDATE, 'YYYY')         --2021
     , TO_CHAR(SYSDATE, 'YEAR')         --TWENTY TWENTY-ONE
     , TO_CHAR(SYSDATE, 'MM')           --03
     , TO_CHAR(SYSDATE, 'MONTH')        --3��
     , TO_CHAR(SYSDATE, 'MON')          --3��
     , TO_CHAR(SYSDATE, 'DD')           --29
     , TO_CHAR(SYSDATE, 'DAY')          --������
     , TO_CHAR(SYSDATE, 'DY')           --��
     , TO_CHAR(SYSDATE, 'HH24')         --16
     , TO_CHAR(SYSDATE, 'HH')           --04
     , TO_CHAR(SYSDATE, 'HH AM')        --04 ����
     , TO_CHAR(SYSDATE, 'HH PM')        --04 ����
     , TO_CHAR(SYSDATE, 'MI')           --44
     , TO_CHAR(SYSDATE, 'SS')           --51
     , TO_CHAR(SYSDATE, 'SSSSS')        --60291
     , TO_CHAR(SYSDATE, 'Q')            --1
FROM DUAL;


SELECT '04', TO_NUMBER('04')
FROM DUAL;

SELECT TO_CHAR(4), '4'
FROM DUAL;

SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) "Ȯ��"
FROM DUAL;


--�� EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY')     --2021  �� ������ �����Ͽ� ���� Ÿ������
     , TO_CHAR(SYSDATE, 'MM')       --03    �� ���� �����Ͽ� ���� Ÿ������
     , TO_CHAR(SYSDATE, 'DD')       --29    �� ���� �����Ͽ� ���� Ÿ������
     , EXTRACT(YEAR FROM SYSDATE)   --2021  �� ������ �����Ͽ� ���� Ÿ������
     , EXTRACT(MONTH FROM SYSDATE)  --3     �� ���� �����Ͽ� ���� Ÿ������
     , EXTRACT(DAY FROM SYSDATE)    --19    �� ���� �����Ͽ� ���� Ÿ������
FROM DUAL;
--> ��, ��, �� ���� �ٸ� ���� �Ұ�


--�� TO_CHAR() Ȱ�� �� ���� ���� ǥ�� ����� ��ȯ
SELECT 60000
     , TO_CHAR(60000)               --60000
     , TO_CHAR(60000, '99,999')     --60,000
     , TO_CHAR(60000, '$99,999')    --$60,000
     , TO_CHAR(60000, 'L99,999')    --��60,000
FROM DUAL;


--�� ���� �ð��� �������� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ�Ѵ�.
SELECT SYSDATE "���� �ð�"
     , SYSDATE+1+(2/24)+(3/(24*60))+(4/(24*60*60)) "1��2�ð�3��4����"
FROM DUAL;
--==>> 2021-03-29 17:17:54   2021-03-30 19:20:58


--�� ���� �ð��� �������� 1�� 2���� 3�� 4�ð� 5�� 6�� �ĸ� ��ȸ�Ѵ�.
--   TO_YMINTERVAL(), TO_DSINTERVAL()
SELECT SYSDATE "���� �ð�"
     , SYSDATE+TO_YMINTERVAL('01-02')+TO_DSINTERVAL('003 04:05:06') "���� ���"
FROM DUAL;
--==>> 2021-03-29 17:21:28   2022-06-01 21:26:34


--------------------------------------------------------------------------------


--���� CASE ����(���ǹ�, �б⹮) ����
/*
���̽��������ص屸��
CASE
WHEN
THEN
ELSE
END
*/

SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2����!' END "��� Ȯ��"
FROM DUAL;
--==>> 5+2=7

SELECT CASE 5+2 WHEN 9 THEN '5+2=9' ELSE '5+2����!' END "��� Ȯ��"
FROM DUAL;
--==>> 5+2����!

SELECT CASE 1+1 WHEN 2 THEN '1+1=2'
                WHEN 3 THEN '1+1=3'
                WHEN 4 THEN '1+1=4'
                ELSE '����'
       END "��� Ȯ��"
FROM DUAL;
--==>> 1+1=2


--�� DECODE()
SELECT DECODE(5-2,1,'5-2=1',2,'5-2=2',3,'5-2=3','5-2�� ����!') "��� Ȯ��"
FROM DUAL;
--==>> 5-2=3


--�� CASE WHEN THEN ELSE END ���� Ȱ��
SELECT CASE WHEN 5<2 THEN '5<2'
            WHEN 5>2 THEN '5>2'
            ELSE '5�� 2 �� �Ұ�'
       END "��� Ȯ��"
FROM DUAL;
--==>> 5>2

SELECT CASE WHEN 5<2 OR 3>1 AND 2=2 THEN '��������' --F OR T AND T
            WHEN 5>2 OR 2=3 THEN '���Ҹ���'         --T OR F
            ELSE '���ָ���'
       END "��� Ȯ��"
FROM DUAL;
--==>> ��������

SELECT CASE WHEN 3<1 OR 5<2 OR 3>1 AND 2=2 THEN '��������' --T OR F OR T AND T
            WHEN 5<2 OR 2=3 THEN '���Ҹ���'                --F OR F
            ELSE '���ָ���'
       END "��� Ȯ��"
FROM DUAL;
--==>> ��������

SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '��������' --T AND (F OR T) AND T
            WHEN 5<2 AND 2=2 THEN '���Ҹ���'                  --F AND T
            ELSE '���ָ���'
       END "��� Ȯ��"
FROM DUAL;
--==>> ���ָ���