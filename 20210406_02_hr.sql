SELECT USER
FROM DUAL;
--==>> HR


/*
--□□□ 팀별 실습 과제 □□□

HR 샘플 스키마 ERD를 이용한 테이블 재구성

팀별로 HR 스키마에 있는 기본 테이블(7개)
(COUNTRIES / DEPARTMENTS / EMPLOYEES / JOBS / JOB_HISTORY / LOCATIONS / REGIONS)
을 똑같이 새로 구성한다.

단, 생성하는 테이블 이름은 『테이블명+팀 번호』 (ex. COUNTRIES04)
와 같이 구성한다.


1. 기존 테이블의 정보 수집: 컬럼, 데이터타입, 제약조건 등
2. 테이블 생성(CREATE): 컬럼 이름, 자료형, DEFAULT 표현식, NOT NULL 등
   제약조건 설정(PK, UK, FK, CK, ... NN)
3. 작성 후 데이터 입력(INSERT INTO)
4. 제출 항목
   - 20210406_03_hr_팀별실습과제_4조.sql
   - 후기_4조.txt
5. 제출 기한: 금일 오후 5시 40분
*/


SELECT *
FROM DEPARTMENTS;
--27
--DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID

SELECT *
FROM EMPLOYEES;
--107
--EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID,
--SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID

SELECT *
FROM JOBS;
--19
--JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY

SELECT *
FROM JOB_HISTORY;
--10
--EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID

SELECT *
FROM COUNTRIES;
--25
--COUNTRY_ID, COUNTRY_NAME, REGION_ID

SELECT *
FROM LOCATIONS;
--23
--LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID

SELECT *
FROM REGIONS;
--4
--REGION_ID, REGION_NAME

/*
1. DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID
2. EMPLOYEES.JOB_ID = JOBS.JOB_ID
3. COUNTRIES.COUNTRY_ID = LOCATIONS.COUNTRY_ID
4. COUNTRIES.REGION_ID = REGIONS.REGION_ID
*/

/*
OWNER   CONSTRAINT_NAME           TABLE_NAME   CONSTRAINT_TYPE       COLUMN_NAME       SEARCH_CONDITION               DELETE_RULE
HR       COUNTRY_ID_NN           COUNTRIES   C                   COUNTRY_ID       "COUNTRY_ID" IS NOT NULL   
HR       COUNTRY_C_ID_PK           COUNTRIES   P                   COUNTRY_ID      
HR       COUNTR_REG_FK           COUNTRIES   R                   REGION_ID                                      NO ACTION

HR       DEPT_NAME_NN           DEPARTMENTS   C                   DEPARTMENT_NAME   "DEPARTMENT_NAME" IS NOT NULL   
HR       DEPT_ID_PK               DEPARTMENTS   P                   DEPARTMENT_ID      
HR       DEPT_LOC_FK               DEPARTMENTS   R                   LOCATION_ID                                      NO ACTION
HR       DEPT_MGR_FK               DEPARTMENTS   R                   MANAGER_ID                                      NO ACTION

HR       EMP_LAST_NAME_NN       EMPLOYEES   C                   LAST_NAME       "LAST_NAME" IS NOT NULL   
HR       EMP_EMAIL_NN           EMPLOYEES   C                   EMAIL           "EMAIL" IS NOT NULL   
HR       EMP_HIRE_DATE_NN       EMPLOYEES   C                   HIRE_DATE       "HIRE_DATE" IS NOT NULL   
HR       EMP_JOB_NN               EMPLOYEES   C                   JOB_ID           "JOB_ID" IS NOT NULL   
HR       EMP_SALARY_MIN           EMPLOYEES   C                   SALARY           salary > 0   
HR       EMP_EMAIL_UK           EMPLOYEES   U                   EMAIL      
HR       EMP_EMP_ID_PK           EMPLOYEES   P                   EMPLOYEE_ID      
HR       EMP_DEPT_FK               EMPLOYEES   R                   DEPARTMENT_ID                                  NO ACTION
HR       EMP_JOB_FK               EMPLOYEES   R                   JOB_ID                                          NO ACTION
HR       EMP_MANAGER_FK           EMPLOYEES   R                   MANAGER_ID                                      NO ACTION

HR       JOB_TITLE_NN           JOBS   C                       JOB_TITLE       "JOB_TITLE" IS NOT NULL   
HR       JOB_ID_PK               JOBS   P                       JOB_ID      

HR       JHIST_EMPLOYEE_NN       JOB_HISTORY   C                   EMPLOYEE_ID       "EMPLOYEE_ID" IS NOT NULL   
HR       JHIST_START_DATE_NN       JOB_HISTORY   C                   START_DATE       "START_DATE" IS NOT NULL   
HR       JHIST_END_DATE_NN       JOB_HISTORY   C                   END_DATE       "END_DATE" IS NOT NULL   
HR       JHIST_JOB_NN           JOB_HISTORY   C                   JOB_ID           "JOB_ID" IS NOT NULL   
HR       JHIST_DATE_INTERVAL       JOB_HISTORY   C                   START_DATE       end_date > start_date   
HR       JHIST_DATE_INTERVAL       JOB_HISTORY   C                   END_DATE       end_date > start_date   
HR       JHIST_EMP_ID_ST_DATE_PK   JOB_HISTORY   P                   EMPLOYEE_ID      
HR       JHIST_EMP_ID_ST_DATE_PK   JOB_HISTORY   P                   START_DATE      
HR       JHIST_JOB_FK           JOB_HISTORY   R                   JOB_ID                                          NO ACTION
HR       JHIST_EMP_FK           JOB_HISTORY   R                   EMPLOYEE_ID                                      NO ACTION
HR       JHIST_DEPT_FK           JOB_HISTORY   R                   DEPARTMENT_ID                                  NO ACTION

HR       LOC_CITY_NN               LOCATIONS   C                   CITY           "CITY" IS NOT NULL   
HR       LOC_ID_PK               LOCATIONS   P                   LOCATION_ID      
HR       LOC_C_ID_FK               LOCATIONS   R                   COUNTRY_ID                                      NO ACTION

HR       REGION_ID_NN           REGIONS       C                   REGION_ID       "REGION_ID" IS NOT NULL   
HR       REG_ID_PK               REGIONS       P                   REGION_ID      
*/


DESC DEPARTMENTS;
/*
이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)    
*/

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='DEPARTMENTS';
/*
OWNER	CONSTRAINT_NAME	        TABLE_NAME	CONSTRAINT_TYPE	COLUMN_NAME	    SEARCH_CONDITION	                DELETE_RULE
HR	    DEPT_NAME_NN            	DEPARTMENTS	C	            DEPARTMENT_NAME	"DEPARTMENT_NAME" IS NOT NULL	
HR	    DEPT_ID_PK	            DEPARTMENTS	P	            DEPARTMENT_ID		
HR	    DEPT_LOC_FK	            DEPARTMENTS	R	            LOCATION_ID		                                NO ACTION
HR	    DEPT_MGR_FK	            DEPARTMENTS	R	            MANAGER_ID		                                NO ACTION
*/

DESC EMPLOYEES;
/*
이름             널?       유형           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)    
*/

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='EMPLOYEES';
/*
OWNER   CONSTRAINT_NAME       TABLE_NAME   CONSTRAINT_TYPE   COLUMN_NAME       SEARCH_CONDITION           DELETE_RULE
HR       EMP_DEPT_FK           EMPLOYEES   R               DEPARTMENT_ID                          NO ACTION
HR       EMP_MANAGER_FK       EMPLOYEES   R               MANAGER_ID                              NO ACTION
*/

CREATE TABLE EMPLOYEES04
( EMPLOYEE_ID       NUMBER(6)         
, FIRST_NAME        VARCHAR2(20)
, LAST_NAME         VARCHAR2(25) 
, EMAIL             VARCHAR2(25) [EMP04_EMAIL_NN] NOT NULL
, PHONE_NUMBER      VARCHAR2(20) 
, HIRE_DATE         VARCHAR2(20)
, JOB_ID            VARCHAR2(10) 
, SALARY            NUMBER(8,2)  
, COMMISSION_PCT    NUMBER(2,2)
, MANAGER_ID        NUMBER(6) 
, DEPARTMENT_ID     NUMBER(4) 
, CONSTRAINT EMP04_EMP_ID_PK PRIMARY KEY(EMPLOYEE_ID)
, CONSTRAINT EMP04_LAST_NAME_NN CHECK(LAST_NAME IS NOT NULL)
, CONSTRAINT EMP04_EMAIL_NN CHECK(EMAIL IS NOT NULL)
, CONSTRAINT EMP04_EMAIL_UK UNIQUE(EMAIL)
, CONSTRAINT EMP04_HIRE_DATE_NN CHECK(HIRE_DATE IS NOT NULL)
, CONSTRAINT EMP04_JOB_NN CHECK(JOB_ID IS NOT NULL)
, CONSTRAINT EMP04_JOB_FK FOREIGN KEY(JOB_ID)
                          REFERENCES JOBS(JOB_ID)
, CONSTRAINT EMP04_SALARY_MIN CHECK(SALARY > 0)
, CONSTRAINT EMP04_MANAGER_FK FOREIGN KEY(MANAGER_ID)
                          REFERENCES JOBS04(MANAGER_ID)
, CONSTRAINT EMP04_DEPT_FK FOREIGN KEY(DEPARTMENT_ID)
                          REFERENCES DEPARTMENTS04(DEPARTMENT_ID)
);