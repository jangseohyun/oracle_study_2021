SELECT USER
FROM DUAL;
--==>> SCOTT


--○ SCOTT.TBL_INSA 테이블의 여러 명의 데이터 여러 개를 변수에 저장
--   (반복문 활용 출력)
DECLARE
    VEMP   TBL_INSA%ROWTYPE;
    VNUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL, BUSEO
               INTO VEMP.NAME, VEMP.TEL, VEMP.BUSEO
        FROM TBL_INSA
        WHERE NUM = VNUM;
        
        DBMS_OUTPUT.PUT_LINE(VEMP.NAME || ' - ' || NVL(VEMP.TEL,'             ') || ' - ' || VEMP.BUSEO);
        EXIT WHEN VNUM >= 1060;
        VNUM := VNUM + 1;
    END LOOP;
END;
/*
...
허경운 - 017-3333-3333 - 총무부
산마루 - 018-0505-0505 - 영업부
이기상 -               - 개발부
이미성 - 010-6654-8854 - 개발부
...


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


/*
-- ■■■ FUNCTION(함수) ■■■

1. 함수란 하나 이상의 PL/SQL 문으로 구성된 서브루틴으로
   코드를 다시 사용할 수 있도록 캡슐화하는 데 사용된다.
   오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
   직접 스토어드 함수를 만들 수 있다. (→ 사용자 정의 함수)
   이 사용자 정의 함수는 시스템 함수처럼 쿼리에서 호출하거나
   저장 프로시저처럼 EXECUTE 문을 통해 실행할 수 있다.

2. 형식 및 구조
   CREATE [OR REPLACE] FUNCTION 함수명
   [(
      매개변수1 자료형
      매개변수2 자료형
   )]
   RETURN 데이터타입
   IS --(DECLARE)
      --주요 변수 선언(지역변수)
   BEGIN
      --실행문;
      ...
      RETURN 값;
      
      [EXCEPTION]
         --예외처리 구문;
   END;
   

--※ 사용자 정의 함수(스토어드 함수)는
     IN 파라미터(입력 매개변수)만 사용할 수 있으며
     반드시 반환될 값의 데이터타입을 RETURN 문에 선언해야 하고,
     FUNCTION은 반드시 단일 값만 반환한다.
*/


--○ TBL_INSA 테이블을 대상으로
--   주민번호를 가지고 성별을 조회한다.
SELECT NAME, SSN, DECODE(SUBSTR(SSN,8,1),'1','남자','2','여자','확인불가') "성별"
FROM TBL_INSA;

--○ FUNCTION 생성
--   함수명: FN_GENDER()
--   SSN(주민등록번호) → 'YYMMDD-NNNNNNN'
CREATE OR REPLACE FUNCTION FN_GENDER
(
    VSSN  VARCHAR2  --매개변수: 자릿수(길이) 지정 안 함
)
RETURN VARCHAR2     --반환자료형: 자릿수(길이) 지정 안 함
IS
    --주요 변수 선언
    VRESULT VARCHAR2(20);
BEGIN
    --연산 및 처리
    IF (SUBSTR(VSSN,8,1) IN ('1','3'))
       THEN VRESULT := '남자';
    ELSIF (SUBSTR(VSSN,8,1) IN ('2','4'))
       THEN VRESULT := '여자';
    ELSE
       VRESULT := '성별확인불가';
    END IF;
    
    --최종 결과값 반환
    RETURN VRESULT;
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.


--○ 임의의 정수 두 개를 매개변수(입력 파라미터)로 넘겨받아
--   A의 B 승의 값을 반환하는 사용자 정의 함수를 작성한다.
--   함수명: FN_POW()
/*
사용 예)
SELECT FN_POW(0,3)
FROM DUAL;
--==>> 1000
*/
--LOOP 문
CREATE OR REPLACE FUNCTION FN_POW
(
    NUM1 NUMBER
  , NUM2 NUMBER
)
RETURN NUMBER
IS
   VRESULT NUMBER;
   N NUMBER;
BEGIN
    VRESULT :=1;
    N := 1;
    
    LOOP 
        VRESULT := VRESULT * NUM1;
        EXIT WHEN N = NUM2;
        N := N+1;
    END LOOP;    
    
    RETURN VRESULT;
END;

/*
--WHILE LOOP 문
BEGIN
    VRESULT :=1;
    N := 1;
    
    WHILE N <= NUM2 LOOP 
        VRESULT := VRESULT * NUM1;
        N := N+1;
    END LOOP;   
*/

/*
--FOR LOOP 문

BEGIN
    VRESULT :=1;
    
    FOR N IN 1 .. NUM2 LOOP         -- 1 ~ 3
        VRESULT := VRESULT * NUM1;  -- 1 * 10 * 10 * 10
    END LOOP;    
    
    RETURN VRESULT;
*/


--○ 과제

--○ TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다.
--   급여는 (기본급*12)+수당 기반으로 연산을 수행한다.
--   함수명: FN_PAY(기본급, 수당)
CREATE OR REPLACE FUNCTION FN_PAY
(
    VBP    NUMBER
  , VSU    NUMBER
)
RETURN NUMBER
IS
    VSAL   NUMBER;
BEGIN
    VSAL := (VBP*12)+VSU;
    RETURN VSAL;
END;


--○ TBL_INSA 테이블의 입사일을 기준으로
--   현재까지의 근무년수를 반환하는 함수를 정의한다.
--   단, 근무년수는 소수점 이하 한 자리까지 계산한다.
--   함수명: FN_WORKYEAR(입사일)
CREATE OR REPLACE FUNCTION FN_WORKYEAR
(
    VDATE   DATE
)
RETURN NUMBER
IS
    VMONTH  NUMBER;
    VYEAR   NUMBER;
BEGIN
    VMONTH := MONTHS_BETWEEN(SYSDATE,VDATE);
    VYEAR := TRUNC((VMONTH/12),1);
    RETURN VYEAR;
END;


/*------------------------------------------------------------------------------

※ 참고

1. INSERT, UPDATE, DELETE, (MERGE)
   - DML(Data Manipulation Language)
   - COMMIT / ROLLBACK 이 필요하다.

2. CREATE, DROP, ALTER, (TRUNCATE)
   - DDL(Data Definition Language)
   - 실행하면 자동으로 COMMIT 된다.

3. GRANT, REVOKE
   - DCL(Data Control Language)
   - 실행하면 자동으로 COMMIT 된다.

4. COMMIT, ROLLBACK
   - TCL(Transaction Control Language)
   
- 정적 PL/SQL문 → DML문, TCL문만 사용 가능하다.
- 동적 PL/SQL문 → DML문, DDL문, DCL문, TCL문 사용 가능하다.


※ 정적 SQL(정적 PL/SQL)

- 기본적으로 사용하는 SQL 구문과
  PL/SQL 구문 안에 SQL 구문을 직접 삽입하는 방법.
- 작성이 쉽고 성능이 좋다.


※ 동적 SQL(동적 PL/SQL) → EXECUTE IMMEDIATE
- 완성되지 않은 SQL 구문을 기반으로
  실행 중 변경 가능한 문자열 변수 또는 문자열 상수를 통해
  SL 구문을 동적으로 완성하여 실행하는 방법.
- 사전에 정의되지 않은 SQL을 실행할 때 완성/확정하여 실행할 수 있다.
  DML, TCL 외에도 DDL, DCL, TCL 사용이 가능하다.

------------------------------------------------------------------------------*/


/*
--■■■ PROCEDURE(프로시저) ■■■

1. PL/SQL에서 가장 대표적인 구조인 스토어드 프로시저는
   개발자가 자주 작성해야 하는 업무의 흐름을
   미리 작성하여 데이터베이스 내에 저장해두었다가
   필요할 때마다 호출하여 실행할 수 있도록 처리해주는 구문이다.

2. 형식 및 구조
   CREATE [OR REPLACE] PROCEDURE 프로시저명
   [( 매개변수 IN 데이터타입
    , 매개변수 OUT 데이터타입
    , 매개변수 INOUT 데이터타입
   )]
   IS
      [--주요 변수 선언;]
   BEGIN
      --실행 구문;
      ...
      [EXCEPTION
            --예외 처리 구문;]
   END;


--※ FUNCTION과 비교했을 때
--   『RETURN 반환자료형』 부분이 존재하지 않으며,
--   『RETURN』문 자체도 존재하지 않으며,
--   프로시저 실행 시 넘겨주게 되는 매개변수의 종류는
--   IN, OUT, INOUT 으로 구분된다.


3. 실행(호출)
   EXEC[UTE] 프로시저명[(인수1,인수2)];
*/


--○ INSERT 쿼리 실행을 프로시저로 작성 (INSERT 프로시저)
-- 실습 테이블 생성(TBL_STUDENTS) → 20210408_04_scott.sql 참고 
-- 실습 테이블 생성(TBL_IDPW) → 20210408_04_scott.sql 참고 

-- 프로시저 생성
-- 프로시저 명: PRC_STUDENTS_INSERT(아이디, 패스워드, 이름, 전화번호, 주소);
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    --TBL_IDPW 테이블에 데이터 입력
    INSERT INTO TBL_IDPW(ID,PW) VALUES(V_ID,V_PW);
    
    --TBL_STUDENTS 테이블에 데이터 입력
    INSERT INTO TBL_STUDENTS(ID,NAME,TEL,ADDR) VALUES(V_ID,V_NAME,V_TEL,V_ADDR);
    
    --커밋
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_INSERT이(가) 컴파일되었습니다.


--○ 실습 테이블 생성(TBL_SUNGJUK) → 20210408_04_scott.sql 참고 

--○ 데이터 입력 시
--   특정 항목의 데이터(학번, 이름, 국어점수, 영어점수, 수학점수)만 입력하면
--   내부적으로 총점, 평균, 등급 항목이 함께 입력 처리될 수 있도록 하는
--   프로시저를 작성한다(생성한다).
--   프로시저명: PRC_SUNGJUK_INSERT()
/*
실행 예)
EXEC PRC_SUNGJUK_INSERT(1,'조은선',90,80,70);

프로시저 호출로 처리된 결과)
학번 이름    국어점수 영어점수 수학점수 총점 평균 등급
1    조은선  90       80       70        240  80   B
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    --INSERT 쿼리문을 수행하는 데 필요한 주요 변수 선언
    V_TOT     TBL_SUNGJUK.TOT%TYPE;
    V_AVG     TBL_SUNGJUK.AVG%TYPE;
    V_GRADE   TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    --아래의 쿼리문 실행을 위해서는
    --선언한 변수들에 값을 담아내야 한다.  (V_TOT, V_AVG, V_GRADE)
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    --INSERT 쿼리문 구성
    INSERT INTO TBL_SUNGJUK(HAKBUN,NAME,KOR,ENG,MAT,TOT,AVG,GRADE) VALUES(V_HAKBUN,V_NAME,V_KOR,V_ENG,V_MAT,V_TOT,V_AVG,V_GRADE);
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT이(가) 컴파일되었습니다.


--○ TBL_SUNGJUK 테이블에서
--   특정 학생의 점수(학번, 국어점수, 영어점수, 수학점수)
--   데이터 수정 시 총점, 평균, 등급까지 수정하는 프로시저를 작성한다.
--   프로시저 명: PRC_SUNGJUK_UPDATE
/*
실행 예)
EXEC PRC_SUNGJUK_UPDATE(1,50,50,50);

프로시저 호출로 처리된 결과)
--==>> 1	조은선	50	50	50	150	50	F
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAK  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR  IN TBL_SUNGJUK.KOR%TYPE
, V_ENG  IN TBL_SUNGJUK.ENG%TYPE
, V_MAT  IN TBL_SUNGJUK.MAT%TYPE
)
IS
    --UPDATE 쿼리문을 수행하는 데 필요한 주요 변수 선언
    V_TOT     TBL_SUNGJUK.TOT%TYPE;
    V_AVG     TBL_SUNGJUK.AVG%TYPE;
    V_GRADE   TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    --아래의 쿼리문 실행을 위해서는
    --선언한 변수들에 값을 담아내야 한다.  (V_TOT, V_AVG, V_GRADE)
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    --UPDATE 쿼리문 구성
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT, TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAK;
    
    COMMIT;
END;


--○ TBL_STUDENTS 테이블에서
--   전화번호와 주소 데이터를 수정하는(변경하는) 프로시저를 작성한다.
--   단, ID와 PW가 일치하는 경우에만 수정을 진행할 수 있도록 한다.
--   프로시저 명: PRC_STUDENTS_UPDATE
/*
실행 예)
EXEC PRC_STUDENTS_UPDATE('superman','java006$','010-9999-9999','경기 일산');

프로시저 호출로 처리된 결과)
superman	박정준	010-9999-9999	경기 일산
*/
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( VID   IN TBL_IDPW.ID%TYPE
, VPW   IN TBL_IDPW.PW%TYPE
, VTEL  IN TBL_STUDENTS.TEL%TYPE
, VADDR IN TBL_STUDENTS.TEL%TYPE
)
IS
BEGIN
    UPDATE (SELECT T1.ID "ID", T1.PW "PW", T2.TEL "TEL", T2.ADDR "ADDR"
            FROM TBL_IDPW T1, TBL_STUDENTS T2
            WHERE T1.ID = T2.ID) T
    SET T.TEL = VTEL, T.ADDR = VADDR
    WHERE T.ID = VID AND T.PW = VPW;
    
    COMMIT;
END;

/*
--○ 다른 방법1
BEGIN
    UPDATE TBL_STUDENTS
    SET TEL = VTEL, ADDR = VADDR
    WHERE VID = ID AND VPW = (SELECT PW
                             FROM TBL_IDPW
                             WHERE VID = ID);

--○ 다른 방법2
BEGIN
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
            FROM TBL_IDPW I JOIN TBL_STUDENTS S
            ON I.ID = S.ID) T
    SET T.TEL = VTEL, T.ADDR = VADDR
    WHERE T.ID = VID AND T.PW = VPW;
*/
