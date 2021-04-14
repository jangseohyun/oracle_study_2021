SELECT USER
FROM DUAL;
--==>> SCOTT


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


SELECT *
FROM TBL_INSA;
/*
NUM	NAME	    SSN	            IBSADATE    	CITY TEL	        BUSEO	JIKWI	BASICPAY	SUDANG
1001	홍길동	771212-1022432	1998-10-11	서울	 011-2356-4528	기획부	부장	2610000	200000
1002	이순신	801007-1544236	2000-11-29	경기	 010-4758-6532	총무부	사원	1320000	200000
1003	이순애	770922-2312547	1999-02-25	인천	 010-4231-1236	개발부	부장	2550000	160000
*/


--○ 생성한 함수(FN_GENDER())가 제대로 작동하는지의 여부 확인
SELECT '980709-2123456' "주민번호", FN_GENDER('980709-2123456') "성별확인"
FROM DUAL;
/*
980709-2123456	여자
*/


SELECT NAME, SSN, FN_GENDER(SSN) "함수호출결과"
FROM TBL_INSA;
/*
홍길동	771212-1022432	남자
이순신	801007-1544236	남자
이순애	770922-2312547	여자
...
*/

SELECT FN_POW(10,3) "함수호출결과"
FROM DUAL;


SELECT FN_PAY(BASICPAY,SUDANG) "함수호출결과"
FROM TBL_INSA;

SELECT FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;


--※ 프로시저 실습 진행간 테이블 생성 및 데이터 입력

--○ INSERT 쿼리 실행을 프로시저로 작성 (INSERT 프로시저)
-- 실습 테이블 생성(TBL_STUDENTS)
CREATE TABLE TBL_STUDENTS
( ID    VARCHAR2(10)
, NAME  VARCHAR2(40)
, TEL   VARCHAR2(20)
, ADDR  VARCHAR2(100)
);
--==>> Table TBL_STUDENTS이(가) 생성되었습니다.


CREATE TABLE TBL_IDPW
( ID    VARCHAR2(10)
, PW    VARCHAR2(20)
, CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_IDPW이(가) 생성되었습니다.

--한 명의 학생 정보 등록 → 두 테이블에 데이터 입력
INSERT INTO TBL_STUDENTS(ID,NAME,TEL,ADDR)
VALUES('superman','박정준','010-1111-1111','제주도 서귀포시');
INSERT INTO TBL_IDPW(ID,PW)
VALUES('superman','java006$');
--==>> 1 행 이(가) 삽입되었습니다. * 2

SELECT *
FROM TBL_STUDENTS;
/*
ID	    NAME    	TEL	            ADDR
superman	박정준	010-1111-1111	제주도 서귀포시
*/

SELECT *
FROM TBL_IDPW;
/*
ID	    PW
superman	java006$
*/


--위의 업무를 프로시저(INSERT 프로시저, 입력 프로시저)를 생성하게 되면
EXEC PRC_STUDENTS_INSERT('happyday','java006$','김서현','010-2222-2222','서울 마포구');
--이와 같은 구문 한 줄로 양쪽 테이블에 데이터를 모두 제대로 입력할 수 있다.


--○ 생성한 프로시저(PRC_STUDENTS_INSERT)가 제대로 작동하는지의 여부 확인
EXEC PRC_STUDENTS_INSERT('happyday','java006$','김서현','010-2222-2222','서울 마포구');
/*
1 행 이(가) 삽입되었습니다.
1 행 이(가) 삽입되었습니다.

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


SELECT *
FROM TBL_STUDENTS;
/*
ID	    NAME    	TEL	            ADDR
superman	박정준	010-1111-1111	제주도 서귀포시
happyday	김서현	010-2222-2222	서울 마포구
*/

SELECT *
FROM TBL_IDPW;
/*
ID	    PW
superman	java006$
happyday	java006$
*/


--○ 학번, 이름, 국어점수, 영어점수, 수학점수 데이터를
--   입력받을 수 있는 실습 테이블 생성(TBL_SUNGJUK)
CREATE TABLE TBL_SUNGJUK
( HAKBUN    NUMBER
, NAME      VARCHAR2(40)
, KOR       NUMBER(3)
, ENG       NUMBER(3)
, MAT       NUMBER(3)
, CONSTRAINT SUNGJUK_HAKBUN_PK PRIMARY KEY(HAKBUN)
);
--==>> Table TBL_SUNGJUK이(가) 생성되었습니다.


--○ 생성된 테이블에 컬럼 구조 추가
--   (총점: TOT, 평균: AVG, 등급: GRADE)
ALTER TABLE TBL_SUNGJUK
ADD(TOT NUMBER(3), AVG NUMBER(4,1), GRADE CHAR);
--==>> Table TBL_SUNGJUK이(가) 변경되었습니다.


--※ 여기서 추가한 컬럼에 대한 항복들은
--   프로시저 실습을 위해 추가하는 것일 뿐
--   실제 테이블 구조에 적합하지도, 바람직하지도 않은 내용이다.


--○ 변경된 테이블 구조 확인
DESC TBL_SUNGJUK;
/*
이름     널?       유형           
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


--○ 생성한 프로시저(PRC_SUNGJUK_INSERT)가 제대로 작동하는지의 여부 확인
--프로시저 호출
EXEC PRC_SUNGJUK_INSERT(1,'이상화',90,80,70);

SELECT *
FROM TBL_SUNGJUK;
--==>> 1	이상화	90	80	70	240	80	B


--○ 생성한 프로시저(PRC_SUNGJUK_UPDATE)가 제대로 작동하는지의 여부 확인
--프로시저 호출
EXEC PRC_SUNGJUK_UPDATE(1,50,50,50);

SELECT *
FROM TBL_SUNGJUK;
--==>> 1	이상화	50	50	50	150	50	F


--○ 생성한 프로시저(PRC_STUDENTS_UPDATE)가 제대로 작동하는지의 여부 확인
--프로시저 호출
EXEC PRC_STUDENTS_UPDATE('superman','net006$','010-8888-8888','경기 일산');
--==>> PW가 틀리기 때문에 변경 사항이 제대로 적용되지 않음
EXEC PRC_STUDENTS_UPDATE('superman','java006$','010-9999-9999','경기 일산');
SELECT *
FROM TBL_STUDENTS;
/*
superman	박정준	010-9999-9999	경기 일산
happyday	김서현	010-2222-2222	서울 마포구
*/
