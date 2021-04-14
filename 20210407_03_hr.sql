SELECT USER
FROM DUAL;
--==>> HR


--�� EMPLOYEES ���̺��� ������ SALARY�� 10% �λ��Ѵ�.
--   ��, �μ����� 'IT'�� ���� �����Ѵ�.
--   (����� ����� Ȯ�� �� ROLLBACK)
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID, SALARY*1.1
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (DEPARTMENTS ���̺��� IT �μ��� �μ� ID);

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID, SALARY*1.1
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME='IT');

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME='IT');

SELECT *      
FROM EMPLOYEES;

ROLLBACK;


--�� EMPLOYEES ���̺��� JOB_TITLE�� ��Sales Manager���� �������
--   SALARY�� �ش� ����(����)�� �ְ� �޿�(MAX_SALARY)�� �����Ѵ�.
--   ��, �Ի����� 2006�� ����(�ش� �⵵ ����) �Ի��ڿ� ���Ͽ�
--   ������ �� �ֵ��� ó���Ѵ�.
--   (������ �ۼ��Ͽ� ��� Ȯ�� �� ROLLBACK)
UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID IN (SELECT JOB_ID
                 FROM JOBS
                 WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE,'YYYY'))<2006;

SELECT *             
FROM JOBS;

SELECT *             
FROM EMPLOYEES
WHERE JOB_ID = 'SA_MAN';

ROLLBACK;


--�� EMPLOYEES ���̺��� SALARY��
--   �� �μ��� �̸� ���� �ٸ� �λ���� �����Ͽ� ������ �� �ֵ��� �Ѵ�.
--   Finance: 10%
--   Executive: 15%
--   Accounting: 20%
--   (������ �ۼ��Ͽ� ��� Ȯ�� �� ROLLBACK)
UPDATE EMPLOYEES
SET SALARY = CASE WHEN DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME='Finance') THEN SALARY *1.1
                  WHEN DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME='Executive') THEN SALARY *1.15
                  WHEN DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME='Accounting') THEN SALARY *1.2
                  ELSE SALARY
                  END
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance','Executive','Accounting'));
         
SELECT DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (90,100,110);
/*
--���� ��
90	24000
90	17000
90	17000
100	12008
100	9000
100	8200
100	7700
100	7800
100	6900
110	12008
110	8300

--���� ��
90	27600
90	19550
90	19550
100	13208.8
100	9900
100	9020
100	8470
100	8580
100	7590
110	14409.6
110	9960
*/

SELECT *
FROM DEPARTMENTS;

ROLLBACK;


/*
--���� DELETE ����

1. ���̺��� ������ ��(���ڵ�)�� �����ϴ� �� ����ϴ� ����

2. ���� �� ����
   DELETE [FROM] ���̺��
   [WHERE ������];
*/

DELETE
FROM EMPLOYEES
WHERE EMPLOYEE_ID=198;

ROLLBACK;


--�� EMPLOYEES ���̺��� �������� ������ �����Ѵ�.
--   ��, �μ����� 'IT'�� ���� �����Ѵ�.

--�� �����δ� EMPLOYEEES ���̺��� �����Ͱ�(�����ϰ��� �ϴ� ���)
--   �ٸ� ���̺�(Ȥ�� �ڱ� �ڽ� ���̺�)�� ���� �������ϰ� �ִ� ���
--   �������� ���� ���� �ִٴ� ����� �����ؾ� �ϸ�
--   �׿� ���� ������ �˾ƾ� �Ѵ�.
DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME='IT');
--==>> ���� �߻�(ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found)


/*
--���� ��(VIEW) ����

1. ��(VIEW)�� �̹� Ư���� �����ͺ��̽� ���� �����ϴ�
   �ϳ� �̻��� ���̺��� ����ڰ� ��� ���ϴ� �����͵鸸��
   ��Ȯ�ϰ� ���ϰ� �������� ���Ͽ� ������ ���ϴ� �÷��鸸 ��Ƽ�
   �������� ������ ���̺�� ���Ǽ� �� ���ȿ� ������ �ִ�.
   
   ������ ���̺��̶� �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ϶�
   �ϳ� �̻��� ���̺��� �Ļ��� �Ǵٸ� ������ �� �� �ִ� ����̸�
   �� ������ �����س��� SQL �����̶�� �� �� �ִ�.

2. ���� �� ����
   CREATE [OR REPLACE] VIEW ���̸�
   [(ALIAS[, ALIAS, ...])]
   AS
   �������� (SUBQUERY)
   [WITH CHECK OPTION]
   [WITH READ ONLY];
*/


--�� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
  
  
--�� ��(VIEW) ��ȸ
SELECT *
FROM VIEW_EMPLOYEES;


--�� ��(VIEW) ���� Ȯ��
DESC VIEW_EMPLOYEES;


--�� ��(VIEW) �ҽ� Ȯ��
SELECT VIEW_NAME, TEXT      --TEXT
FROM USER_VIEWS             --USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
/*
VIEW_EMPLOYEES	"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+)"
*/