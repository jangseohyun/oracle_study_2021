SELECT USER
FROM DUAL;
--==>> HR


--○ EMPLOYEES 테이블의 직원들 SALARY를 10% 인상한다.
--   단, 부서명이 'IT'인 경우로 한정한다.
--   (변경된 결과를 확인 후 ROLLBACK)
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID, SALARY*1.1
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (DEPARTMENTS 테이블에서 IT 부서의 부서 ID);

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


--○ EMPLOYEES 테이블에서 JOB_TITLE이 『Sales Manager』인 사원들의
--   SALARY를 해당 직무(직종)의 최고 급여(MAX_SALARY)로 수정한다.
--   단, 입사일이 2006년 이전(해당 년도 제외) 입사자에 한하여
--   적용할 수 있도록 처리한다.
--   (쿼리문 작성하여 결과 확인 후 ROLLBACK)
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


--○ EMPLOYEES 테이블에서 SALARY를
--   각 부서의 이름 별로 다른 인상률을 적용하여 수정할 수 있도록 한다.
--   Finance: 10%
--   Executive: 15%
--   Accounting: 20%
--   (쿼리문 작성하여 결과 확인 후 ROLLBACK)
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
--변경 전
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

--변경 후
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
--■■■ DELETE ■■■

1. 테이블에서 지정된 행(레코드)을 삭제하는 데 사용하는 구문

2. 형식 및 구조
   DELETE [FROM] 테이블명
   [WHERE 조건절];
*/

DELETE
FROM EMPLOYEES
WHERE EMPLOYEE_ID=198;

ROLLBACK;


--○ EMPLOYEES 테이블에서 직원들의 정보를 삭제한다.
--   단, 부서명이 'IT'인 경우로 한정한다.

--※ 실제로는 EMPLOYEEES 테이블의 데이터가(삭제하고자 하는 대상)
--   다른 테이블(혹은 자기 자신 테이블)에 의해 참조당하고 있는 경우
--   삭제되지 않을 수도 있다는 사실을 염두해야 하며
--   그에 대한 이유도 알아야 한다.
DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME='IT');
--==>> 에러 발생(ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found)


/*
--■■■ 뷰(VIEW) ■■■

1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는
   하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만을
   정확하고 편하게 가져오기 위하여 사전에 원하는 컬럼들만 모아서
   만들어놓은 가상의 테이블로 편의성 및 보안에 목적이 있다.
   
   가상의 테이블이란 뷰가 실제로 존재하는 테이블(객체)이 아니라
   하나 이상의 테이블에서 파생된 또다른 정보를 볼 수 있는 방법이며
   그 정보를 추출해내는 SQL 문장이라고 볼 수 있다.

2. 형식 및 구조
   CREATE [OR REPLACE] VIEW 뷰이름
   [(ALIAS[, ALIAS, ...])]
   AS
   서브쿼리 (SUBQUERY)
   [WITH CHECK OPTION]
   [WITH READ ONLY];
*/


--○ 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
  
  
--○ 뷰(VIEW) 조회
SELECT *
FROM VIEW_EMPLOYEES;


--○ 뷰(VIEW) 구조 확인
DESC VIEW_EMPLOYEES;


--○ 뷰(VIEW) 소스 확인
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