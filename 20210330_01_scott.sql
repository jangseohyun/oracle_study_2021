SELECT USER
FROM DUAL;
--==>> SCOTT


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ����
--   TBL_SAWON ���̺��� Ȱ���Ͽ� ������ ���� �׸���� ��ȸ�Ѵ�.
--   �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���
--   ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ�

--   ��, ���糪�̴� �ѱ����� ������ ���� ������ �����Ѵ�.
--   ����, ������������ �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ��(�⵵)��
--   �� ������ �Ի� ��, �Ϸ� ������ �����Ѵ�.
--   �׸��� ���ʽ��� 1000�� �̻� 2000�� �̸� �ٹ��� �����
--   �� ����� ���� �޿� ���� 30% ����,
--   2000�� �̻� �ٹ��� �����
--   �� ����� ���� �޿� ���� 50% ������ �� �� �ֵ��� ó���Ѵ�.
SELECT *
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
     , CASE WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '��'
            ELSE '��'
       END "����"
     , CASE WHEN SUBSTR(JUBUN,1,2)<21 THEN 2021-(2000+SUBSTR(JUBUN,1,2))+1
            ELSE 2021-(1900+SUBSTR(JUBUN,1,2))+1
       END "���糪��"
     , HIREDATE "�Ի���"
     , CASE WHEN SUBSTR(JUBUN,1,2)<21 THEN TO_CHAR(SYSDATE,'YYYY')+(60-(2021-(2000+SUBSTR(JUBUN,1,2))+1)) || TO_CHAR(HIREDATE,'-MM-DD')
            ELSE TO_CHAR(SYSDATE,'YYYY')+(60-(2021-(1900+SUBSTR(JUBUN,1,2))+1)) || TO_CHAR(HIREDATE,'-MM-DD')
       END "����������"
     , TRUNC(SYSDATE-HIREDATE) "�ٹ��ϼ�"
     , CASE WHEN SUBSTR(JUBUN,1,2)<21 THEN TRUNC(TO_DATE((TO_CHAR(SYSDATE,'YYYY')+(60-(2021-(2000+SUBSTR(JUBUN,1,2))+1)) || '-' || TO_CHAR(HIREDATE,'MM-DD')),'YYYY-MM-DD')-SYSDATE)
            ELSE TRUNC(TO_DATE((TO_CHAR(SYSDATE,'YYYY')+(60-(2021-(1900+SUBSTR(JUBUN,1,2))+1)) || '-' || TO_CHAR(HIREDATE,'MM-DD')),'YYYY-MM-DD')-SYSDATE)
       END "�����ϼ�"
     , SAL "�޿�"
     , CASE WHEN SYSDATE-HIREDATE>=1000 AND SYSDATE-HIREDATE<2000 THEN SAL*0.3
            WHEN SYSDATE-HIREDATE>=2000 THEN SAL*0.5
       END "���ʽ�"
FROM TBL_SAWON;
/*
1001	�谡��	    9402252234567	��	28	2001-01-03	2053-01-03	 7391	11601	3000	1500
1002	�輭��	    9412272234567	��	28	2010-11-05	2053-11-05	 3798	11907	2000	    1000
1003	��ƺ�	    9303082234567	��	29	1999-08-16	2052-08-16	 7897	11461	5000	    2500
1004	������	    9609142234567	��	26	2008-02-02	2055-02-02	 4805   12361	4000	2000
1005	������	    9712242234567	��	25	2009-07-15	2056-07-15	 4276   12890	2000    	1000
1006	������	    9710062234567	��	25	2009-07-15	2056-07-15	 4276   12890	2000    	1000
1007	������	    0405064234567	��	18	2010-06-05	2063-06-05	 3951   15406	1000	 500
1008	������	    0103254234567	��	21	2012-07-13	2060-07-13	 3182   14349	3000	1500
1009	������	    9804251234567	��	24	2007-07-08	2057-07-08	 5014	13248	4000	2000
1010	������	    0204254234567	��	20	2008-12-10	2061-12-10	 4493	14864	2000	    1000
1011	������	    7505071234567	��	47	1990-10-10	2034-10-10	11129	 4941	3000	1500
1012	���켱	    9912122234567	��	23	2002-10-10	2058-10-10	 6746	13707	2000	    1000
1013	������	7101092234567	��	51	1991-11-11	2030-11-11	10732	 3512	1000	 500
1014	������	    0203043234567	��	20	2010-05-05	2061-05-05	 3982	14645	2000    	1000
1015	���ü�	    0512123234567	��	17	2012-08-14	2064-08-14	 3150	15842	1000	 500
1016	����	        7012121234567	��	52	1990-08-14	2029-08-14	11186	 3058   2000	    1000
*/


--�� ����� Ǯ��
--   TBL_SAWON ���̺��� �����ϴ� �������
--   �Ի���(HIREDATE) �÷����� ��, �ϸ� ��ȸ�ϱ�
SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE,'MM-DD')
FROM TBL_SAWON;
/*
�谡��	    2001-01-03	01-03
�輭��	    2010-11-05	11-05
��ƺ�	    1999-08-16	08-16
������	    2008-02-02	02-02
������	    2009-07-15	07-15
������	    2009-07-15	07-15
������	    2010-06-05	06-05
������	    2012-07-13	07-13
������	    2007-07-08	07-08
������	    2008-12-10	12-10
������	    1990-10-10	10-10
���켱	    2002-10-10	10-10
������	1991-11-11	11-11
������	    2010-05-05	05-05
���ü�	    2012-08-14	08-14
����	        1990-08-14	08-14
*/

SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE,'MM'), TO_CHAR(HIREDATE,'DD')
FROM TBL_SAWON;
/*
�谡��	2001-01-03	01	03
�輭��	2010-11-05	11	05
*/

SELECT SANAME, HIREDATE, TO_CHAR(HIREDATE,'MM') || '-' || TO_CHAR(HIREDATE,'DD')
FROM TBL_SAWON;
/*
�谡��	2001-01-03	01-03
�輭��	2010-11-05	11-05
*/

--   �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���
--   ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ�

--   �� �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���, �޿� ���� ��ȸ
SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
     --����
     , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
            ELSE '���� Ȯ�� �Ұ�'
       END "����"
     --���糪�� = ����⵵ - �¾�⵵ + 1 (1900��� �� / 2000��� ��)
     , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1899)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1999)
            ELSE -1 --���̸� ���� �������� ����ϱ� ������ �̶� '���� Ȯ�� �Ұ�' �� ���� ���ڿ� ���� ��� �Ұ�
       END "���糪��"
     --�Ի���
     , HIREDATE "�Ի���"
     --�޿�
     , SAL "�޿�"
FROM TBL_SAWON;
/*
1001	�谡��	    9402252234567	����  	28	2001-01-03	3000
1002	    �輭��	    9412272234567	����  	28	2010-11-05	2000
1003	��ƺ�	    9303082234567	����  	29	1999-08-16	5000
1004	������	    9609142234567	����  	26	2008-02-02	4000
1005	    ������	    9712242234567	����  	25	2009-07-15	2000
1006	������	    9710062234567	����  	25	2009-07-15	2000
1007	������	    0405064234567	����  	18	2010-06-05	1000
1008	������	    0103254234567	����  	21	2012-07-13	3000
1009	������	    9804251234567	����  	24	2007-07-08	4000
1010	������	    0204254234567	����  	20	2008-12-10	2000
1011	������	    7505071234567	����	    47	1990-10-10	3000
1012	    ���켱	    9912122234567	����  	23	2002-10-10	2000
1013	������	7101092234567	����  	51	1991-11-11	1000
1014	������	    0203043234567	����  	20	2010-05-05	2000
1015	    ���ü�	    0512123234567	����  	17	2012-08-14	1000
1016	����	        7012121234567	����	    52	1990-08-14	2000
*/


SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
     --����������
     --���������⵵ �� �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ��
     --EX) ���� ���� 58�� ��  2�� ��, 2021 �� 2023
     --EX) ���� ���� 35�� �� 25�� ��, 2021 �� 2046
     --TO_CHAR(ADD_MONTHS(SYSDATE, (60-T.���糪��)*12),'YYYY') �� �������� �⵵�� ����
     --TO_CHAR(T.�Ի���,'MM-DD') �� �Ի���ϸ� ����
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60-T.���糪��)*12),'YYYY') || '-' || TO_CHAR(T.�Ի���,'MM-DD') "����������"
     --�ٹ��ϼ�
     --�ٹ��ϼ� = ������ - �Ի���
     , TRUNC(SYSDATE-T.�Ի���) "�ٹ��ϼ�"
     --�����ϼ�
     --�����ϼ� = ����������-������
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60-T.���糪��)*12),'YYYY') || '-' || TO_CHAR(T.�Ի���,'MM-DD'),'YYYY-MM-DD')-SYSDATE) "�����ϼ�"
     --�޿�
     , T.�޿�
     --���ʽ�
     --�ٹ��ϼ��� 1000�� �̻� 2000�� �̸� �� ���� �޿��� 30%
     --�ٹ��ϼ��� 2000�� �̻� �� ���� �޿��� 50%
     --������ �� 0
     , CASE WHEN TRUNC(SYSDATE-T.�Ի���)>=2000 THEN T.�޿� *0.5
            WHEN TRUNC(SYSDATE-T.�Ի���)>=1000 THEN T.�޿� *0.3 
            ELSE 0
       END "���ʽ�"
FROM
(
    SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
         --����
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
                ELSE '���� Ȯ�� �Ұ�'
           END "����"
         --���糪�� = ����⵵ - �¾�⵵ + 1 (1900��� �� / 2000��� ��)
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1899)
                WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1999)
                ELSE -1 --���̸� ���� �������� ����ϱ� ������ �̶� '���� Ȯ�� �Ұ�' �� ���� ���ڿ� ���� ��� �Ұ�
           END "���糪��"
         --�Ի���
         , HIREDATE "�Ի���"
         --�޿�
         , SAL "�޿�"
    FROM TBL_SAWON
)T;
/*
1001	�谡��	    9402252234567	��	28	2001-01-03	2053-01-03	 7391	11601	3000	1500
1002	    �輭��	    9412272234567	��	28	2010-11-05	2053-11-05	 3798	11907	2000	    1000
1003	��ƺ�	    9303082234567	��	29	1999-08-16	2052-08-16	 7897	11461	5000	    2500
1004	������	    9609142234567	��	26	2008-02-02	2055-02-02	 4805   12361	4000	2000
1005	    ������	    9712242234567	��	25	2009-07-15	2056-07-15	 4276   12890	2000    	1000
1006	������	    9710062234567	��	25	2009-07-15	2056-07-15	 4276   12890	2000    	1000
1007	������	    0405064234567	��	18	2010-06-05	2063-06-05	 3951   15406	1000	 500
1008	������	    0103254234567	��	21	2012-07-13	2060-07-13	 3182   14349	3000	1500
1009	������	    9804251234567	��	24	2007-07-08	2057-07-08	 5014	13248	4000	2000
1010	������	    0204254234567	��	20	2008-12-10	2061-12-10	 4493	14864	2000	    1000
1011	������	    7505071234567	��	47	1990-10-10	2034-10-10	11129	 4941	3000	1500
1012	    ���켱	    9912122234567	��	23	2002-10-10	2058-10-10	 6746	13707	2000	    1000
1013	������	7101092234567	��	51	1991-11-11	2030-11-11	10732	 3512	1000	 500
1014	������	    0203043234567	��	20	2010-05-05	2061-05-05	 3982	14645	2000    	1000
1015	    ���ü�	    0512123234567	��	17	2012-08-14	2064-08-14	 3150	15842	1000	 500
1016	����	        7012121234567	��	52	1990-08-14	2029-08-14	11186	 3058   2000	    1000
*/

--��� ���뿡�� Ư�� �ٹ��ϼ��� ����� Ȯ���ؾ� �Ѵٰų�
--Ư�� ���ʽ� �ݾ��� �޴� ����� Ȯ���ؾ� �� ��찡 ���� �� �ִ�.
--�̿� ���� ��� �ش� �������� �ٽ� �����ϴ� ���ŷο��� ���� �� �ֵ���
--��(VIEW)�� ����� �����ص� �� �ִ�.

CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60-T.���糪��)*12),'YYYY') || '-' || TO_CHAR(T.�Ի���,'MM-DD') "����������"
     , TRUNC(SYSDATE-T.�Ի���) "�ٹ��ϼ�"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60-T.���糪��)*12),'YYYY') || '-' || TO_CHAR(T.�Ի���,'MM-DD'),'YYYY-MM-DD')-SYSDATE) "�����ϼ�"
     , T.�޿�
     , CASE WHEN TRUNC(SYSDATE-T.�Ի���)>=2000 THEN T.�޿� *0.5
            WHEN TRUNC(SYSDATE-T.�Ի���)>=1000 THEN T.�޿� *0.3 
            ELSE 0
       END "���ʽ�"
FROM
(
    SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
                ELSE '���� Ȯ�� �Ұ�'
           END "����"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1899)
                WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2))+1999)
                ELSE -1
           END "���糪��"
         , HIREDATE "�Ի���"
         , SAL "�޿�"
    FROM TBL_SAWON
)T;
--==>> View VIEW_SAWON��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_SAWON;
--���� T: 1001	�谡��	9402252234567	2001-01-03	3000

SELECT *
FROM VIEW_SAWON;
--���� V: 1001	�谡��	9402252234567	����  	28	2001-01-03	2053-01-03	7391	11601	3000	1500


--�� VIEW ���� ���� ������ ����
UPDATE TBL_SAWON
SET HIREDATE = SYSDATE, SAL = 100
WHERE SANO = 1001;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_SAWON;
--���� �� T: 1001	�谡��	9402252234567	2021-03-30	100

SELECT *
FROM VIEW_SAWON;
--���� �� V: 1001	�谡��	9402252234567	����  	28	2021-03-30	2053-03-30	0	11687	100	0


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� ����
--   ���������� Ȱ���Ͽ� TBL_SAWON ���̺��� ������ ���� ��ȸ�� �� �ֵ��� �Ѵ�.
/*
--------------------------------------------
  �����  ����  ���糪��  �޿�  ���̺��ʽ�
--------------------------------------------

��, ���̺��ʽ��� ���� ���̰� 40�� �̻��̸� �޿��� 70%
    30�� �̻� 40�� �̸��̸� �޿��� 50%
    20�� �̻� 30�� �̸��̸� �޿��� 30%�� �Ѵ�.

����, �ϼ��� ��ȸ ������ �������
VIEW_SAWON2 ��� �̸��� ��(VIEW)�� �����Ѵ�.
*/
--CREATE OR REPLACE VIEW VIEW_SAWON2
--AS
SELECT T.*
     , CASE WHEN T.���糪�� >= 40 THEN T.�޿�*0.7
            WHEN T.���糪�� >= 30 THEN T.�޿�*0.5
            WHEN T.���糪�� >= 20 THEN T.�޿�*0.3
            ELSE 0
       END "���̺��ʽ�"
FROM
(
    SELECT SANAME "�����"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '��'
                WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '��'
                ELSE '���� Ȯ�� �Ұ�'
           END "����"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') THEN 2021-(1900+TO_NUMBER(SUBSTR(JUBUN,1,2)))+1
                WHEN SUBSTR(JUBUN,7,1) IN ('3','4') THEN 2021-(2000+TO_NUMBER(SUBSTR(JUBUN,1,2)))+1
           END "���糪��"
         , SAL "�޿�"
    FROM TBL_SAWON
)T;
--==>> View VIEW_SAWON2��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_SAWON2;
/*
�谡��	    ��	28	 100	  30
�輭��	    ��	28	2000    	 600
��ƺ�	    ��	29	5000	    1500
������	    ��	26	4000	1200
������	    ��	25	2000	     600
������	    ��	25	2000	     600
������	    ��	18	1000	   0
������	    ��	21	3000	 900
������	    ��	24	4000	1200
������	    ��	20	2000	     600
������	    ��	47	3000	2100
���켱	    ��	23	2000    	 600
������	��	51	1000	 700
������	    ��	20	2000    	 600
���ü�	    ��	17	1000	   0
����	        ��	52	2000	    1400
*/


--�� RANK() �� ���(����)�� ��ȯ�ϴ� �Լ�
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP;
/*
7839	KING    	10	5000	     1
7902	    FORD	    20	3000	 2
7788	SCOTT	20	3000	 2
7566	    JONES	20	2975     4
7698	BLAKE	30	2850	     5
7782	    CLARK	10	2450	     6
7499	ALLEN	30	1600	 7
7844	TURNER	30	1500     8
7934	MILLER	10	1300	 9
7521    	WARD	    30	1250	    10
7654	    MARTIN	30	1250	    10
7876	ADAMS	20	1100	12
7900	JAMES	30	 950	    13
7369	SMITH	20	 800	14
*/

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP;
/*
7839	KING	    10	5000    	1	 1
7902    	FORD    	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	    JONES	20	2975	    3	 4
7698	BLAKE	30	2850    	1	 5
7782	    CLARK	10	2450    	2	 6
7499	ALLEN	30	1600	2	 7
7844	TURNER	30	1500	    3	 8
7934	MILLER	10	1300	3	 9
7521    	WARD	    30	1250	    4	10
7654	    MARTIN	30	1250	    4	10
7876	ADAMS	20	1100	4	12
7900	JAMES	30	 950	    6	13
7369	SMITH	20	 800	5	14
*/

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP
ORDER BY 3,4 DESC;
/*
7839	KING    	10	5000	    1	 1
7782	    CLARK	10	2450    	2	 6
7934	MILLER	10	1300	3	 9
7902	    FORD    	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	    JONES	20	2975	    3	 4
7876	ADAMS	20	1100	4	12
7369	SMITH	20	 800	5	14
7698	BLAKE	30	2850	    1	 5
7499	ALLEN	30	1600	2	 7
7844	TURNER	30	1500    	3	 8
7654    	MARTIN	30	1250    	4	10
7521    	WARD	    30	1250	    4	10
7900	JAMES	30	 950	    6	13
*/


--�� DENSE_RANK() �� ����
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
     , DENSE_RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP
ORDER BY 3,4 DESC;
/*
7839	KING	    10	5000	    1	1
7782    	CLARK	10	2450    	2	5
7934	MILLER	10	1300	3	8
7902    	FORD	    20	3000	1	2
7788	SCOTT	20	3000	1	2
7566    	JONES	20	2975    	2	3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	800	    4	12
7698	BLAKE	30	2850	    1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500	    3	7
7654    	MARTIN	30	1250    	4	9
7521	    WARD	    30	1250    	4	9
7900	JAMES	30	950	    5	11
*/


--�� EMP ���̺��� ��� ������
--   �����, �μ���ȣ, ����, �μ��� ��������, ��ü �������� �׸����� ��ȸ�Ѵ�.
SELECT T.*
     , RANK() OVER(PARTITION BY T.�μ���ȣ ORDER BY T.���� DESC) "�μ��� ��������"
     , RANK() OVER(ORDER BY T.���� DESC) "��ü ��������"
FROM 
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
    FROM EMP
)T
ORDER BY 2 ASC;
/*
KING	    10	60000	1	 1
CLARK	10	29400	2	 6
MILLER	10	15600	3	10
FORD    	20	36000	1	 2
SCOTT	20	36000	1	 2
JONES	20	35700	3	 4
ADAMS	20	13200	4	12
SMITH	20	 9600	5	14
BLAKE	30	34200	1	 5
ALLEN	30	19500	2	 7
TURNER	30	18000	3	 8
MARTIN	30	16400	4	 9
WARD	    30	15500	5	11
JAMES	30	11400	6	13
*/

--�� ����� Ǯ��
SELECT T.*
     , RANK() OVER(PARTITION BY T.�μ���ȣ ORDER BY T.���� DESC) "�μ��� ��������"
     , RANK() OVER(ORDER BY T.���� DESC) "��ü ��������"
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ"
         , SAL*12+NVL(COMM,0) "����"
    FROM EMP
)T
ORDER BY 2,3 DESC;


--�� EMP ���̺����� ��ü ���� ������ 1����� 5�������
--   �����, �μ���ȣ, ����, ��ü�������� ������ ��ȸ�Ѵ�.
SELECT T.*
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
         , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "��ü��������"
    FROM EMP
)T
WHERE T.��ü�������� <= 5;
--> RANK() OVER() �Լ��� WHERE ���������� ����� �� ����.
--> ���� INLINE VIEW�� Ȱ���Ͽ� Ǯ���ؾ� �Ѵ�.
/*
KING    	10	60000	1
SCOTT	20	36000	2
FORD    	20	36000	2
JONES	20	35700	4
BLAKE	30	34200	5
*/


--�� EMP ���̺����� �� �μ����� ���� ����� 1����� 2������� ��ȸ�Ѵ�.
--   �����ȣ, �����, �μ���ȣ, ����, �μ����������, ��ü�������
SELECT T.*
FROM
(
    SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
         , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "�μ����������"
         , DENSE_RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "��ü�������"
    FROM EMP
)T
WHERE T.�μ���������� <= 2;
/*
7839	    KING    	10	60000	1	1
7782    	CLARK	10	29400	2	5
7902	    FORD	    20	36000	1	2
7788	SCOTT	20	36000	1	2
7566	    JONES	20	35700	2	3
7698	    BLAKE	30	34200	1	4
7499	    ALLEN	30	19500	2	6
*/


--���� �׷� �Լ� ����
--SUM() ��, AVG() ���, COUNT() ī��Ʈ, MAX() �ִ밪, MIN() �ּҰ�,
--VARIANCE() �л�, STDDEVV(ǥ������)

--�� �׷� �Լ��� ���� ū Ư¡��
--   ó���ؾ� �� �����͵� �� NULL�� �����ϸ�
--   �� NULL�� �����ϰ� ������ �����Ѵٴ� ���̴�.


--�� SUM()
--   EMP ���̺��� ������� ��ü ������� �޿� ������ ��ȸ�Ѵ�.
SELECT SUM(SAL)
FROM EMP;
--==>> 29025

SELECT SUM(COMM)
FROM EMP;
--==>> 2200


--�� COUNT()
--   ���� ���� ��ȸ�Ͽ� ����� ��ȯ
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(*)
FROM EMP;
--==>> 14


--�� AVG()
--   ��� ��ȯ
SELECT SUM(SAL)/COUNT(SAL) "1", AVG(SAL) "2"
FROM EMP;
--==>> 2073.214285714285714285714285714285714286   2073.214285714285714285714285714285714286

SELECT AVG(COMM)
FROM EMP;
--==>> 550 �� �������� ���� ���

SELECT SUM(COMM)/COUNT(COMM)
FROM EMP;
--==>> 550

SELECT SUM(COMM)/COUNT(*)
FROM EMP;
--==>> 157.142857142857142857142857142857142857
--> ���� COMM�� ��հ�


--�� ǥ�������� ������ �л�
--   �л��� �������� ǥ������
SELECT AVG(SAL), VARIANCE(SAL), STDDEV(SAL) --���, �л�, ǥ������
FROM EMP;
/*
2073.214285714285714285714285714285714286
1398313.87362637362637362637362637362637
1182.503223516271699458653359613061928508
*/

SELECT POWER(STDDEV(SAL),2),VARIANCE(SAL)
FROM EMP;
/*
1398313.87362637362637362637362637362637
1398313.87362637362637362637362637362637
*/

SELECT SQRT(VARIANCE(SAL)), STDDEV(SAL)
FROM EMP;
/*
1182.503223516271699458653359613061928508
1182.503223516271699458653359613061928508
*/


--�� MAX() / MIN()
--   �ִ밪, �ּҰ� ��ȯ
SELECT MAX(SAL), MIN(SAL)
FROM EMP;
--==>> 5000   800

--�� ����
SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> ���� �߻�(not a single-group group function)
--> ���� ���ڵ�� ���� ���ڵ带 �Բ� ��ȸ�� �� ����.

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
/*
10	 8750
20	10875
30	 9400
*/

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	    8750
20	    10875
30	    9400
(null)  29025
*/


--�� ������ �Է�
INSERT INTO TBL_EMP VALUES (8001, '����', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_EMP VALUES (8002, '������', 'CLERK', 7566, SYSDATE, 1000, 0, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_EMP VALUES (8003, '������', 'SALESMAN', 7698, SYSDATE, 2000, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_EMP VALUES (8004, '������', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_EMP VALUES (8005, '������', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


SELECT *
FROM TBL_EMP;

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	     8750
20	    10875
30	     9400
(null)	 8000   --�μ���ȣ�� NULL�� �����͵鳢���� ��
(null)	37025   --��� �μ��� �޿� ��
*/


--������ ��ȸ�� ������ ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
�μ���ȣ  �޿���
-------- -------
10	       8750
20	      10875
30	       9400
���� 	   8000
���μ�	  37025
*/
SELECT NVL(T.�μ���ȣ, '���μ�') "�μ���ȣ", SUM(T.�޿���) "�޿���"
FROM(
    SELECT NVL(TO_CHAR(DEPTNO), '����') "�μ���ȣ", SUM(SAL) "�޿���"
    FROM TBL_EMP
    GROUP BY DEPTNO
) T
GROUP BY ROLLUP(T.�μ���ȣ);
/*
10	        8750
20	        10875
30	        9400
����	    8000
���μ�	37025
*/


--�� ����� Ǯ��
SELECT CASE DEPTNO WHEN NULL THEN '����'
                   ELSE DEPTNO
       END "�μ���ȣ"
FROM TBL_EMP;
--==>> ���� �߻� (inconsistent datatypes: expected CHAR got NUMBER)

SELECT CASE DEPTNO WHEN NULL THEN '����'
                   ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
FROM TBL_EMP;
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
(null)
(null)
(null)
(null)
(null)
*/


SELECT CASE WHEN DEPTNO IS NULL THEN '����'
            ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
FROM TBL_EMP;
/*
20
30
30
20
30
30
10
20
10
30
20
30
20
10
����
����
����
����
����
*/

SELECT CASE WHEN DEPTNO IS NULL THEN '����'
            ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	     8750
20	    10875
30	     9400
����	 8000
����	37025   --GROUP BY�� SELECT���� ���� ����Ǳ� ����
*/

SELECT NVL(TO_CHAR(DEPTNO),'����') "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	     8750
20	    10875
30	     9400
����	 8000
����	37025
*/

SELECT NVL2(DEPTNO,TO_CHAR(DEPTNO),'����') "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	     8750
20	    10875
30	     9400
����	 8000
����	37025
*/


--�� GROUPING()
SELECT CASE WHEN GROUPING(DEPTNO)=0 THEN NVL(TO_CHAR(DEPTNO),'����')
            WHEN GROUPING(DEPTNO)=1 THEN NVL(TO_CHAR(DEPTNO),'���μ�')
            ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	        8750
20	        10875
30	        9400
����	    8000
���μ�	37025
*/