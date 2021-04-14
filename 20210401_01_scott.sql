SELECT USER
FROM DUAL;
--==>> SCOTT


--���� JOIN(����) ����

--1. SQL 1992 CODE

SELECT *
FROM EMP, DEPT;
--> ���п��� ���ϴ� ��ī��Ʈ��(Catersian Product)
--> �� ���̺��� ��ģ(������) ��� ����� ��


--Equi join: ���� ��Ȯ�� ��ġ�ϴ� �����͵鳢�� �����Ű�� ����
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;


--Non Equi join: ���� �ȿ� ������ �����͵鳢�� �����Ű�� ����
--��������δ� Eqio join�� �� ���� ���̰� �� �߿���
SELECT *
FROM SALGRADE;

SELECT *
FROM EMP;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;


--Equi join�� ��+���� Ȱ���� ���� ���
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� 14���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--> �μ���ȣ�� ���� ���� ��� 5���� ���տ��� ������

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> �� 19���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--> �μ���ȣ�� ���� ���� ��� 5�� ��� ��ȸ�� ��Ȳ

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> �� 16���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--> �μ��� �Ҽӵ� ����� �ƹ��� ���� �μ��� ��ȸ�� ��Ȳ
--> (+)�� ���߿� �ΰ��ϴ� ��, D.DEPTNO�� ���� �޸𸮿� ������

--�� (+)�� ���� �� ���̺��� �����͸� ��� �޸𸮿� ������ ��
--   (+)�� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·�
--   JOIN�� �̷������.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--==>> ���� �߻�(a predicate may reference only one outer-joined table)
--> ���� ���� ������ �̷��� ������ JOIN ������ �������� �ʴ´�.
--> (�޸𸮿� ���� �����ص� �����Ͱ� ���� ����)


--1. SQL 1999 CODE �� ��JOIN�� Ű���� ���� �� JOIN ���� ���
--                     ���� ������ ��WHERE�� ��� ��ON��

--CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;


--INNER JOIN
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--�� INNER JOIN �� INNER �� ���� ����
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;
--> Equi join�� Non Equi join ��� INNER JOIN���� ���յ� ��Ȳ


--OUTER JOIN
--> Equi join�� (+)�� ������ �Ͱ� ����
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

--�� ������ ������ �� ���̺�(�� LEFT)�� �����͸� ��� �޸𸮿� ������ ��
--   ������ �������� ���� �� ���̺���� �����͸� ���� Ȯ���Ͽ� ���ս�Ű�� ���·�
--   JOIN�� �̷������.

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
--> WHERE E.DEPTNO(+) = D.DEPTNO(+)�� �ǵ���� ����


--�� OUTER JOIN���� OUTER�� ���� ����
--   ��, OUTER�� �����ϰ� LEFT/RIGHT/FULL�� ������ INNER JOIN
SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D --OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D --OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D --OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D      --INNER JOIN
ON E.DEPTNO = D.DEPTNO;


--------------------------------------------------------------------------------


SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- �� ������� ������ CLERK�� ����鸸 ��ȸ
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
   AND JOB = 'CLERK';
--> �̷��� �������� �����ص� ��ȸ�ϴ� ���� ������ ����.

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
--> ������ �̿� ���� �����Ͽ� ��ȸ�� �� �ֵ��� �����Ѵ�.

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
      AND JOB = 'CLERK';
--> �׷��� SQL 1992 CODE ������ �̿� ���� �����ؾ� �Ѵ�.


--------------------------------------------------------------------------------
SELECT *
FROM EMP;


--�� EMP ���̺�� DEPT ���̺��� �������
--   ������ MANAGER�� CLERK�� ����鸸
--   �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.
SELECT D.DEPTNO "�μ���ȣ", D.DNAME "�μ���", E.ENAME "�����", E.JOB "������", E.SAL "�޿�"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB IN ('MANAGER','CLERK')
ORDER BY 1,4;
/*
10	ACCOUNTING	MILLER	CLERK	1300
10	ACCOUNTING	CLARK	MANAGER	2450
20	RESEARCH	ADAMS	CLERK	1100
20	RESEARCH	SMITH	CLERK	 800
20	RESEARCH	JONES	MANAGER	2975
30	SALES	    JAMES	CLERK	 950
30	SALES	    BLAKE	MANAGER	2850
*/


SELECT D.DEPTNO "�μ���ȣ", DNAME "�μ���", ENAME "�����", JOB "������", SAL "�޿�"
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺���
--> �������(��������) �Ѵ�.
--> �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--> �μ�(DEPT), ���(EMP) �� � ���̺��� �����ص�
--> ������ ���࿡ ���� ��� ��ȯ�� ������ ����

SELECT DNAME "�μ���", ENAME "�����", JOB "������", SAL "�޿�"
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� ���̺� �� �ߺ��Ǵ� �÷��� �������� �ʴ� ��ȸ ������ ���� �߻����� �ʴ´�.


--�� ������ �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--   �θ� ���̺��� �÷��� ������ �� �ֵ��� �ؾ� �Ѵ�.
SELECT *
FROM DEPT;  --�θ� ���̺�

SELECT *
FROM EMP;   --�ڽ� ���̺�


--�� �θ� �ڽ� ���̺� ���踦 ��Ȯ�� ������ �� �ֵ��� �Ѵ�.

--    DEPTNO
-- EMP------DEPT

SELECT D.DEPTNO "�μ���ȣ", DNAME "�μ���", ENAME "�����", JOB "������", SAL "�޿�"
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>> 40	OPERATIONS   (null)   (null)   (null)

SELECT E.DEPTNO "�μ���ȣ", DNAME "�μ���", ENAME "�����", JOB "������", SAL "�޿�"
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>> (null)	OPERATIONS   (null)   (null)   (null)


--���� ����
SELECT D.DEPTNO "�μ���ȣ", D.DNAME "�μ���", E.ENAME "�����", E.JOB "������", E.SAL "�޿�"
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� ���̺� �� �ߺ��� �÷��� �ƴϴ���
--> �Ҽ� ���̺��� ����� �� �ֵ��� �����Ѵ�.


--�� SELF JOIN
--   EMP ���̺��� ������ ������ ���� ��ȸ�� �� �ֵ��� �Ѵ�.
/*
   �����ȣ   �����   ������   �����ڹ�ȣ   �����ڸ�   ������������
  -------------------------------------------------------------------
      E          E        E          E           E            E
    EMPNO      ENAME     JOB        MGR                               --�� �� E1
                                    MGR        ENAME         JOB      --�� �� E2
*/
SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������", E1.MGR "�����ڹ�ȣ"
     , E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--> MGR�� ��� E1, E2 �� �� � ������ �Է��ص� �ȴ�.
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
7839	KING	PRESIDENT	(null)	(null)	(null)
*/

