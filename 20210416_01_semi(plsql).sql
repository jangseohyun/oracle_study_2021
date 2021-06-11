--○ 아별언니 코드 (조회 안 됨)
CREATE OR REPLACE PROCEDURE PRC_SUB_LOOKUP
IS
    V_SUB_CD            TBL_SUB.SUB_CD%TYPE;
    V_SUB_NM            TBL_SUB.SUB_NM%TYPE;
    
    NOT_FOUND_ERROR     EXCEPTION;
    V_COUNT             NUMBER;
    V_NUM               NUMBER := 1;

BEGIN

    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_SUB;

    IF (V_COUNT > 0) 
        THEN 
                LOOP
                SELECT SUB_CD, SUB_NM INTO V_SUB_CD, V_SUB_NM
                FROM TBL_SUB
                WHERE ROWNUM = V_NUM;
    
                DBMS_OUTPUT.PUT_LINE(V_SUB_CD || ' ' ||V_SUB_NM);
    
                V_NUM := V_NUM + 1;
                                      
                EXIT WHEN V_NUM >= V_COUNT;
            END LOOP;
    
    ELSE RAISE NOT_FOUND_ERROR;
    END IF;
    
    EXCEPTION
    WHEN NOT_FOUND_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '입력하신 정보와 일치하는 데이터가 없습니다.');
             ROLLBACK;
    WHEN OTHERS
        THEN ROLLBACK;
END;


--○ 전체 조회 예시를 위한 VIEW_QT 생성
CREATE OR REPLACE VIEW VIEW_QT
AS
SELECT T.*
FROM
(
    SELECT ROWNUM "NUM", QT_CD "QT_CD", QT_DT "QT_DT"
    FROM TBL_QT
)T;


--○ 전체 조회 예시
CREATE OR REPLACE PROCEDURE PRC_QUIT_LOOKUP_T
IS
    V_QT_CD     TBL_QT.QT_CD%TYPE;
    V_NUM       NUMBER := 1;
    V_ROWNUM    NUMBER;
BEGIN
    SELECT MAX(ROWNUM) INTO V_ROWNUM
    FROM TBL_QT;

    LOOP
        SELECT QT_CD INTO V_QT_CD
        FROM VIEW_QT
        WHERE NUM = V_NUM;
        DBMS_OUTPUT.PUT_LINE(V_QT_CD);
                
        V_NUM := V_NUM + 1;
                                      
        EXIT WHEN V_NUM > V_ROWNUM;
    END LOOP;
END;


--○ 조건에 해당하는 전체 값 출력 예시
CREATE OR REPLACE PROCEDURE PRC_QUIT_LOOKUP_T2
(   V_QT_CD    IN TBL_QT.QT_CD%TYPE   --사용자 입력값이라는 가정
)
IS
    V_QT_DT     TBL_QT.QT_DT%TYPE;
    V_NUM       NUMBER := 1;
    V_COUNT    NUMBER;
BEGIN
    --입력값에 일치하는 값 개수 V_COUNT에 담기
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_QT
    WHERE QT_CD = V_QT_CD;

    LOOP
        --입력값에 일치하면 V_QT_DT에 담기
        SELECT QT_DT INTO V_QT_DT
        FROM TBL_QT
        WHERE QT_CD = V_QT_CD;
        
        --출력
        DBMS_OUTPUT.PUT_LINE(V_QT_DT);
                
        V_NUM := V_NUM + 1;
                                      
        EXIT WHEN V_NUM > V_COUNT;
    END LOOP;
END;


--과목개설----------------------------------------------------------------------


--○ 과목개설 테이블 생성
CREATE TABLE TBL_OS
( OS_CD     VARCHAR2(10)
, OC_CD     VARCHAR2(10) CONSTRAINT OS_OC_CD_NN  NOT NULL
, SUB_CD    VARCHAR2(10) CONSTRAINT OS_SUB_CD_NN NOT NULL
, PR_ID     VARCHAR2(10) CONSTRAINT OS_PR_ID_NN NOT NULL
, BK_CD     VARCHAR2(10)
, RAT_CD    VARCHAR2(10) CONSTRAINT OS_RAT_CD_NN NOT NULL
, SUB_BD    DATE         
, SUB_ED    DATE         
--, CONSTRAINT OS_CD_PK    PRIMARY KEY(OS_CD) 
--, CONSTRAINT OS_OC_CD_FK    FOREIGN KEY(OC_CD)  REFERENCES TBL_OC(OC_CD)
--, CONSTRAINT OS_SUB_CD_FK   FOREIGN KEY(SUB_CD) REFERENCES TBL_SUB(SUB_CD)
--, CONSTRAINT OS_PR_ID_FK    FOREIGN KEY(PR_ID)  REFERENCES TBL_PR(PR_ID)
--, CONSTRAINT OS_BK_CD_FK    FOREIGN KEY(BK_CD)  REFERENCES TBL_BK(BK_CD)
--, CONSTRAINT OS_RAT_CD_FK   FOREIGN KEY(RAT_CD) REFERENCES TBL_RAT(RAT_CD)
--, CONSTRAINT SUB_ED_CK      CHECK(SUB_ED>=SUB_BD)
);

--○ 과정 개설 테이블 생성
CREATE TABLE TBL_OC
( OC_CD     VARCHAR2(10)
, CRS_CD    VARCHAR2(10)    CONSTRAINT OC_CRS_CD_NN NOT NULL
, CRS_BD    DATE            CONSTRAINT OC_CRS_BD_NN NOT NULL
, CRS_ED    DATE            CONSTRAINT OC_CRS_ED_NN NOT NULL
, CRS_RM    VARCHAR2(10)    CONSTRAINT OC_CRS_RM_NN NOT NULL
--, CONSTRAINT OC_CD_PK PRIMARY KEY (OC_CD)
--, CONSTRAINT OC_CRS_CD_FK FOREIGN KEY(CRS_CD)
--             REFERENCES TBL_CRS(CRS_CD)
--, CONSTRAINT OC_CRS_ED_CK CHECK(CRS_ED > CRS_BD)
);

--○ 과정 테이블 생성
CREATE TABLE TBL_CRS
( CRS_CD    VARCHAR2(10)
, CRS_NM    VARCHAR2(50)    CONSTRAINT CRS_NM_NN NOT NULL
--, CONSTRAINT CRS_CD_PK PRIMARY KEY(CRS_CD)
);

--○ 과목 테이블 생성
CREATE TABLE TBL_SUB
( SUB_CD VARCHAR2(10)
, SUB_NM VARCHAR2(50) CONSTRAINT SUB_NM_NN NOT NULL
--, CONSTRAINT SUB_CD_PK PRIMARY KEY(SUB_CD)
);

--○ 교수 테이블 생성
CREATE TABLE TBL_PR
( PR_ID     VARCHAR2(10)    
, PR_SSN    CHAR(14)       CONSTRAINT PR_SSN_NN NOT NULL
, PR_FN     VARCHAR2(5)    CONSTRAINT PR_FN_NN NOT NULL
, PR_LN     VARCHAR2(5)    CONSTRAINT PR_LN_NN NOT NULL
, PR_DT     DATE                DEFAULT SYSDATE
, PR_PW     VARCHAR2(10)   CONSTRAINT PR_PW_NN NOT NULL
--, CONSTRAINT PR_ID_PK PRIMARY KEY (PR_ID)
);

--○ 교재 테이블 생성
CREATE TABLE TBL_BK
( BK_CD VARCHAR2(10)
, BK_NM VARCHAR2(50) CONSTRAINT BK_NM_NN  NOT NULL
--, CONSTRAINT BK_CD_PK PRIMARY KEY(BK_CD)
);


--○ 과목개설 조회 프로시저용 VIEW 생성
CREATE OR REPLACE VIEW VIEW_OS
AS
SELECT T.*
FROM
(
    SELECT ROWNUM "NUM", OS_CD "OS_CD", OC_CD "OC_CD", SUB_CD "SUB_CD", PR_ID "PR_ID"
          ,BK_CD "BK_CD", RAT_CD "RAT_CD", SUB_BD "SUB_BD", SUB_ED "SUB_ED"
    FROM TBL_OS
)T;



--○ 과목개설 전체 조회 프로시저 생성
CREATE OR REPLACE PROCEDURE PRC_OS_LOOKUP
IS
    V_CRS_NM    TBL_CRS.CRS_NM%TYPE;    --과정명
    V_CRS_RM    TBL_OC.CRS_RM%TYPE;     --강의실
    V_SUB_NM    TBL_SUB.SUB_NM%TYPE;    --과목명
    V_SUB_BD    TBL_OS.SUB_BD%TYPE;     --과목시작
    V_SUB_ED    TBL_OS.SUB_ED%TYPE;     --과목종료
    V_BK_NM     TBL_BK.BK_NM%TYPE;      --교재명
    V_PR_FN     TBL_PR.PR_FN%TYPE;      --교수성
    V_PR_LN     TBL_PR.PR_LN%TYPE;      --교수이름
    
    V_OC_CD     TBL_OS.OC_CD%TYPE;
    V_SUB_CD    TBL_SUB.SUB_CD%TYPE;
    V_BK_CD     TBL_BK.BK_CD%TYPE;
    V_PR_ID     TBL_PR.PR_ID%TYPE;
    V_NUM       NUMBER := 1;
    V_ROWNUM    NUMBER;
BEGIN
    SELECT MAX(NUM) INTO V_ROWNUM
    FROM VIEW_OS;
    
    LOOP
        SELECT OC_CD,SUB_CD,BK_CD,PR_ID,SUB_BD,SUB_ED INTO V_OC_CD,V_SUB_CD,V_BK_CD,V_PR_ID,V_SUB_BD,V_SUB_ED
        FROM VIEW_OS
        WHERE NUM = V_NUM;
        
        SELECT CRS_NM INTO V_CRS_NM
        FROM TBL_CRS
        WHERE CRS_CD = (SELECT CRS_CD FROM TBL_OC WHERE OC_CD = V_OC_CD);
        
        SELECT CRS_RM INTO V_CRS_RM
        FROM TBL_OC
        WHERE OC_CD = V_OC_CD;
        
        SELECT SUB_NM INTO V_SUB_NM
        FROM TBL_SUB
        WHERE SUB_CD = V_SUB_CD;
        
        SELECT BK_NM INTO V_BK_NM
        FROM TBL_BK
        WHERE BK_CD = V_BK_CD;
        
        SELECT PR_FN,PR_LN INTO V_PR_FN,V_PR_LN
        FROM TBL_PR
        WHERE PR_ID = V_PR_ID;
        
        DBMS_OUTPUT.PUT_LINE(V_NUM || '.');
        DBMS_OUTPUT.PUT_LINE('과정명: ' || V_CRS_NM);
        DBMS_OUTPUT.PUT_LINE('강의실: ' || V_CRS_RM);
        DBMS_OUTPUT.PUT_LINE('과목명: ' || V_SUB_NM);
        DBMS_OUTPUT.PUT_LINE('과목기간: ' || V_SUB_BD || ' ~ ' || V_SUB_ED);
        DBMS_OUTPUT.PUT_LINE('교재명: ' || V_BK_NM);
        DBMS_OUTPUT.PUT_LINE('교수명: ' || V_PR_FN || ' ' || V_PR_LN);
        
        V_NUM := V_NUM+1;
        
        EXIT WHEN V_NUM > V_ROWNUM;
    END LOOP;
END;


--------------------------------------------------------------------------------


-- 시퀀스 생성
CREATE SEQUENCE SEQ_CRS
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;
--==> Sequence SEQ_CRS이(가) 생성되었습니다.


CREATE OR REPLACE PROCEDURE PRC_CRS_INSERT 
(
    V_CRS_NM    IN  TBL_CRS.CRS_NM%TYPE
)
IS
    V_CRS_CD    TBL_CRS.CRS_CD%TYPE;
    V_DUP_CHAR  CHAR(1);
    V_DUP_NUM   VARCHAR2(3);
    V_CD_ASCII  NUMBER;
    V_COUNT     NUMBER;
    CREATE_CODE_ERROR EXCEPTION;
    DUPLICATE_ERROR   EXCEPTION;
BEGIN
    --과정명 중복 여부 확인
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_CRS
    WHERE CRS_NM = V_CRS_NM;
    
    --중복시 에러 발생
    IF V_COUNT >= 1
        THEN RAISE DUPLICATE_ERROR;
    END IF;
    
    --첫 두 글자가 알파벳 대문자 두 글자인지 확인
    V_CD_ASCII := TO_NUMBER(ASCII(SUBSTR(V_CRS_NM,1,1))) + TO_NUMBER(ASCII(SUBSTR(V_CRS_NM,2,1)));
    
    IF (V_CD_ASCII >= 130 AND V_CD_ASCII <= 180)
        THEN
            V_CRS_CD := SUBSTR(V_CRS_NM,1,2) || LPAD(SEQ_CRS.NEXTVAL,3,'0');
            INSERT INTO TBL_CRS(CRS_CD, CRS_NM) VALUES (V_CRS_CD, V_CRS_NM);
    ELSE
        RAISE CREATE_CODE_ERROR;
    END IF;
    
    -- 커밋
    COMMIT;
    
    EXCEPTION
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '이미 존재하는 데이터입니다.');
                 ROLLBACK;
        WHEN CREATE_CODE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20007,'유효하지 않은 과정명입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;


--성적--------------------------------------------------------------------------


--학생 테이블 생성
CREATE TABLE TBL_ST
( ST_ID     VARCHAR2(10)   
, ST_SSN    CHAR(14)       CONSTRAINT ST_SSN_NN NOT NULL
, ST_FN     VARCHAR2(5)    CONSTRAINT ST_FN_NN NOT NULL
, ST_LN     VARCHAR2(5)    CONSTRAINT ST_LN_NN NOT NULL
, ST_DT     DATE           DEFAULT SYSDATE
, ST_PW     VARCHAR2(10)   CONSTRAINT ST_PW_NN NOT NULL
--, CONSTRAINT ST_ID_PK PRIMARY KEY(ST_ID) 
);

-- 성적 조회 뷰 생성 
CREATE OR REPLACE VIEW VIEW_SC
AS
SELECT T.*
FROM
(
    --수정
    SELECT ROWNUM "NUM", SC_CD "SC_CD", REG_CD "REG_CD", OS_CD "OS_CD"
         , SC_AT "SC_AT", SC_WT "SC_WT", SC_PT "SC_PT"
    FROM TBL_SC
)T; 
   
/*
출력 정보는 학생 이름, 과정명, 과목명, 교육 기간(시작 연월일, 끝 연월일), 교재 명,
출결, 실기, 필기, 총점, 등수가 출력되어야 한다.
*/
-- 성적 조회 프로시저 작성 
CREATE OR REPLACE PROCEDURE PRC_SC_LOOKUP
IS
    V_ST_FN     TBL_ST.ST_FN%TYPE;
    V_ST_LN     TBL_ST.ST_LN%TYPE;
    V_CRS_NM    TBL_CRS.CRS_NM%TYPE;
    V_SUB_NM    TBL_SUB.SUB_NM%TYPE;
    V_SUB_BD    TBL_OS.SUB_BD%TYPE;
    V_SUB_ED    TBL_OS.SUB_ED%TYPE;
    V_BK_NM     TBL_BK.BK_NM%TYPE;
    V_SC_AT     TBL_SC.SC_AT%TYPE;
    V_SC_WT     TBL_SC.SC_WT%TYPE;
    V_SC_PT     TBL_SC.SC_PT%TYPE;
    V_SC_TT     NUMBER; --총점
    V_SC_RK     NUMBER; --등수
    
    V_SC_CD     TBL_SC.SC_CD%TYPE;
    V_REG_CD    TBL_REG.REG_CD%TYPE;
    V_OS_CD     TBL_OS.OS_CD%TYPE;
    V_CRS_CD    TBL_CRS.CRS_CD%TYPE;
    V_SUB_CD    TBL_SUB.SUB_CD%TYPE;
    V_BK_CD     TBL_BK.BK_CD%TYPE;
    V_NUM       NUMBER := 1;
    V_ROWNUM    NUMBER;
   
BEGIN
    SELECT MAX(NUM) INTO V_ROWNUM
    FROM VIEW_SC;
    
    LOOP
        --추가
        SELECT REG_CD,OS_CD,SC_CD INTO V_REG_CD,V_OS_CD,V_SC_CD
        FROM VIEW_SC
        WHERE NUM = V_NUM;
        
        SELECT ST_FN, ST_LN INTO V_ST_FN, V_ST_LN
        FROM TBL_ST
        WHERE ST_ID = (SELECT ST_ID FROM TBL_REG WHERE REG_CD = V_REG_CD);
        
        --추가
        SELECT CRS_CD INTO V_CRS_CD
        FROM TBL_OC
        WHERE OC_CD = (SELECT OC_CD FROM TBL_OS WHERE OS_CD = V_OS_CD);
        
        SELECT CRS_NM INTO V_CRS_NM
        FROM TBL_CRS
        WHERE CRS_CD = V_CRS_CD;
        
        --추가
        SELECT SUB_CD,BK_CD INTO V_SUB_CD,V_BK_CD
        FROM TBL_OS
        WHERE OS_CD = V_OS_CD;
        
        SELECT SUB_NM INTO V_SUB_NM
        FROM TBL_SUB
        WHERE SUB_CD = V_SUB_CD;
        
        SELECT SUB_BD, SUB_ED INTO V_SUB_BD, V_SUB_ED
        FROM TBL_OS
        WHERE SUB_CD = V_SUB_CD;
        
        SELECT BK_NM INTO V_BK_NM  
        FROM TBL_BK
        WHERE BK_CD = V_BK_CD;
        
        SELECT SC_AT, SC_WT, SC_PT INTO V_SC_AT, V_SC_WT, V_SC_PT
        FROM TBL_SC
        WHERE SC_CD = V_SC_CD;
        
        SELECT (SC_AT + SC_WT + SC_PT) INTO V_SC_TT
        FROM TBL_SC
        WHERE SC_CD = V_SC_CD;
        
        SELECT RANK() OVER (ORDER BY (SC_AT + SC_WT + SC_PT) DESC) INTO V_SC_RK
        FROM TBL_SC
        WHERE SC_CD = V_SC_CD;
        
        /*
        출력 정보는 학생 이름, 과정명, 과목명, 교육 기간(시작 연월일, 끝 연월일), 교재 명,
        출결, 실기, 필기, 총점, 등수가 출력되어야 한다.
        */

        DBMS_OUTPUT.PUT_LINE(V_NUM || '.');
        DBMS_OUTPUT.PUT_LINE('성: ' || V_ST_FN);
        DBMS_OUTPUT.PUT_LINE('이름: ' || V_ST_LN);
        DBMS_OUTPUT.PUT_LINE('과정명: ' || V_CRS_NM);
        DBMS_OUTPUT.PUT_LINE('과목명: ' || V_SUB_NM);
        DBMS_OUTPUT.PUT_LINE('과목기간: ' || V_SUB_BD || ' ~ ' || V_SUB_ED);
        DBMS_OUTPUT.PUT_LINE('교재명: ' || V_BK_NM);
        DBMS_OUTPUT.PUT_LINE('출결: ' || V_SC_AT);
        DBMS_OUTPUT.PUT_LINE('필기: ' || V_SC_WT);
        DBMS_OUTPUT.PUT_LINE('실기: ' || V_SC_PT);
        DBMS_OUTPUT.PUT_LINE('총점: ' || V_SC_TT);
        DBMS_OUTPUT.PUT_LINE('등수: ' || V_SC_RK);
        
        V_NUM := V_NUM+1;
        
        EXIT WHEN V_NUM > V_ROWNUM;
    END LOOP;
END;


--○ 성적 입력 프로시저 작성
CREATE OR REPLACE PROCEDURE PRC_SC_INSERT
(
    V_REG_CD    IN TBL_REG.REG_CD%TYPE   -- 수강신청 코드 
,   V_OS_CD     IN TBL_OS.OS_CD%TYPE    -- 개설과목 코드 
,   V_SC_AT     IN TBL_SC.SC_AT%TYPE    -- 출결 
,   V_SC_WT     IN TBL_SC.SC_WT%TYPE    -- 필기 
,   V_SC_PT     IN TBL_SC.SC_PT%TYPE    -- 실기 
)
IS
    V_SC_CD             TBL_SC.SC_CD%TYPE;      -- 성적 코드 
    V_COUNT_RCD         NUMBER;
    V_COUNT_OCD         NUMBER;
    DUPLICATE_ERROR     EXCEPTION;
    TOTAL_SC_ERROR      EXCEPTION;
    QUIT_STUDENT_ERROR  EXCEPTION;
    
BEGIN
    SELECT COUNT(*) INTO V_COUNT_RCD
    FROM TBL_REG
    WHERE REG_CD = V_REG_CD;     
    
    SELECT COUNT(*) INTO V_COUNT_OCD
    FROM TBL_OS
    WHERE OS_CD = V_OS_CD;     

    
    IF (V_COUNT_RCD = 0) AND (V_COUNT_OCD = 0)
        THEN
        V_SC_CD := 'SC' || LPAD(SEQ_ST_CODE.NEXTVAL,3,'0');     
           
    ELSE RAISE DUPLICATE_ERROR;
    END IF;
     
    IF (V_SC_AT + V_SC_WT + V_SC_PT) > 100
            THEN RAISE TOTAL_SC_ERROR;
    END IF;
    
    IF SQL%NOTFOUND
        THEN RAISE QUIT_STUDENT_ERROR;
    END IF;
        

         -- 테이블에 데이터 입력 
    INSERT INTO TBL_SC(SC_CD, REG_CD, OS_CD, SC_AT, SC_WT, SC_PT)
    VALUES (V_SC_CD, V_REG_CD, V_OS_CD, V_SC_AT, V_SC_WT, V_SC_PT);
    
    DBMS_OUTPUT.PUT_LINE(SC_AT+SC_WT+SC_PT);
    COMMIT;
    
    EXCEPTION
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'이미 존재하는 데이터입니다.');
                 ROLLBACK;
        WHEN TOTAL_SC_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'배점 비율을 고려하여 입력하여 주십시오.');
        WHEN QUIT_STUDENT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20007,'중도탈락한 학생입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==> Procedure PRC_SC_INSERT이(가) 컴파일되었습니다.


--------------------------------------------------------------------------------


SELECT *
FROM TBL_OS;

CREATE OR REPLACE VIEW VIEW_PR
AS
SELECT T.*
FROM
(
    SELECT ROWNUM "NUM", PR_ID "PR_ID", PR_SSN "PR_SSN", PR_FN "PR_FN", PR_LN "PR_LN", PR_DT "PR_DT", PR_PW "PR_PW"
    FROM TBL_PR
)T;
--==>> View VIEW_PR이(가) 생성되었습니다.


--○ 특정 교수의 전체 강의목록 조회
CREATE OR REPLACE PROCEDURE PRC_PR_LOOKUP
(
    V_PR_ID      IN TBL_PR.PR_ID%TYPE   -- 교수아이디
)
IS
    V_SUB_NM     TBL_SUB.SUB_NM%TYPE; -- 배정된 과목명
    V_SUB_BD     TBL_OS.SUB_BD%TYPE;  -- 과목 시작일
    V_SUB_ED     TBL_OS.SUB_ED%TYPE;  -- 과목 종료일
    V_BK_CD      TBL_BK.BK_CD%TYPE;   -- 교재코드
    V_BK_NM      TBL_BK.BK_NM%TYPE;   -- 교재명
    V_OC_CD      TBL_OC.OC_CD%TYPE;   -- 강의실코드
    V_CRS_RM     TBL_OC.CRS_RM%TYPE;  -- 강의실
    
    V_OS_CD      TBL_OS.OS_CD%TYPE;
    V_SUB_CD     TBL_SUB.SUB_CD%TYPE;
    
    V_ING        VARCHAR(50);         -- 강의 진행 여부
    V_DATE1      NUMBER;              -- 날짜 연산 변수
    V_DATE2      NUMBER;
    
    V_NUM        NUMBER;
    V_ROWNUM     NUMBER;
    
BEGIN
    SELECT MIN(ROWNUM),MAX(ROWNUM) INTO V_NUM,V_ROWNUM
    FROM TBL_OS
    WHERE PR_ID = V_PR_ID;

    LOOP    
        SELECT OS_CD,SUB_BD,SUB_ED,BK_CD,OC_CD INTO V_OS_CD,V_SUB_BD,V_SUB_ED,V_BK_CD,V_OC_CD
        FROM TBL_OS
        WHERE PR_ID = V_PR_ID;
        
        SELECT SUB_NM INTO V_SUB_NM
        FROM TBL_SUB
        WHERE SUB_CD = (SELECT SUB_CD FROM TBL_OS WHERE OS_CD = V_OS_CD);
        
        SELECT BK_NM INTO V_BK_NM
        FROM TBL_BK
        WHERE BK_CD = V_BK_CD;

        SELECT CRS_RM INTO V_CRS_RM
        FROM TBL_OC
        WHERE OC_CD = V_OC_CD;
        
        -- 강의 진행 여부 VING
        V_DATE1 := TO_NUMBER(SYSDATE - V_SUB_BD);
        V_DATE2 := TO_NUMBER(SYSDATE - V_SUB_ED);
        
        IF (V_DATE1 > 0 AND V_DATE2 < 0) 
            THEN V_ING := '강의 중';
        ELSIF (V_DATE1 < 0 AND V_DATE2 < 0) 
            THEN V_ING := '강의 예정';
        ELSIF (V_DATE1 > 0 AND V_DATE2 > 0)
            THEN V_ING := '강의 종료';
        ELSE V_ING := '확인불가';
        END IF;
        
        -- 교수 정보 출력        
        DBMS_OUTPUT.PUT_LINE(V_NUM || '.');
        DBMS_OUTPUT.PUT_LINE('교수ID : ' || V_PR_ID);
        DBMS_OUTPUT.PUT_LINE('배정된 과목명 : ' || V_OS_CD  );
        DBMS_OUTPUT.PUT_LINE('과목 기간 : ' || V_SUB_BD || '~' || V_SUB_ED );
        DBMS_OUTPUT.PUT_LINE('교재명 : ' || V_BK_NM );
        DBMS_OUTPUT.PUT_LINE('강의실 : ' || V_CRS_RM );
        DBMS_OUTPUT.PUT_LINE('강의 진행 여부 : ' || V_ING );
        
        V_NUM := V_NUM+1;
        
        EXIT WHEN V_NUM > V_ROWNUM;
    END LOOP;
END;


--○ 전체 교수의 전체 강의목록 조회
CREATE OR REPLACE PROCEDURE PRC_PR_LOOKUP_ADMIN
IS
    V_PR_ID      TBL_PR.PR_ID%TYPE;
    V_NUM        NUMBER := 1;
    V_ROWNUM     NUMBER; 
BEGIN
    SELECT MAX(ROWNUM) INTO V_ROWNUM
    FROM TBL_PR;
    
    LOOP
        SELECT PR_ID INTO V_PR_ID
        FROM VIEW_PR
        WHERE NUM = V_NUM;
        
        PRC_PR_LOOKUP(V_PR_ID);
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM > V_ROWNUM;
    END LOOP;
END;


--------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE PRC_SC_INSERT
(
    V_REG_CD    IN TBL_REG.REG_CD%TYPE   -- 수강신청 코드 
,   V_OS_CD     IN TBL_OS.OS_CD%TYPE    -- 개설과목 코드 
,   V_SC_AT     IN TBL_SC.SC_AT%TYPE    -- 출결 
,   V_SC_WT     IN TBL_SC.SC_WT%TYPE    -- 필기 
,   V_SC_PT     IN TBL_SC.SC_PT%TYPE    -- 실기 
)
IS
    V_SC_CD             TBL_SC.SC_CD%TYPE;      -- 성적 코드 
    V_COUNT_RCD         NUMBER;             -- 예외처리용 수강신청코드1
    V_COUNT_OCD         NUMBER;             -- 예외처리용 개설과목코드1
    V_COUNT_REG         NUMBER;             -- 예외처리용 수강신청코드2
    V_COUNT_OS          NUMBER;             -- 예외처리용 개설과목코드2
    INCORRECT_ERROR     EXCEPTION;
    DUPLICATE_ERROR     EXCEPTION;
    TOTAL_SC_ERROR      EXCEPTION;
    QUIT_STUDENT_ERROR  EXCEPTION;
    
BEGIN

    SELECT COUNT(*) INTO V_COUNT_RCD
    FROM TBL_REG
    WHERE REG_CD = V_REG_CD;     
    
    SELECT COUNT(*) INTO V_COUNT_OCD
    FROM TBL_OS
    WHERE OS_CD = V_OS_CD;  
    
    SELECT COUNT(*) INTO V_COUNT_REG
    FROM TBL_SC
    WHERE REG_CD = V_REG_CD;
    
    SELECT COUNT(*) INTO V_COUNT_OS
    FROM TBL_SC
    WHERE OS_CD = V_OS_CD;

    -- 정확하지 않은 코드 입력했을 때 
    IF (V_COUNT_RCD = 1) AND (V_COUNT_OCD = 1)
        THEN
        V_SC_CD := 'SC' || LPAD(SEQ_ST_CODE.NEXTVAL,3,'0'); 
    ELSE RAISE INCORRECT_ERROR;
    END IF;
    
    -- 이미 입력한 정보일때 
    IF V_COUNT_REG > 0
        THEN RAISE DUPLICATE_ERROR;
    END IF;
        
    IF V_COUNT_OS > 0
        THEN RAISE DUPLICATE_ERROR;
    END IF;
        
    IF (V_SC_AT + V_SC_WT + V_SC_PT) > 100
            THEN RAISE TOTAL_SC_ERROR;
    END IF;

         -- 테이블에 데이터 입력 
    INSERT INTO TBL_SC(SC_CD, REG_CD, OS_CD, SC_AT, SC_WT, SC_PT)
    VALUES (V_SC_CD, V_REG_CD, V_OS_CD, V_SC_AT, V_SC_WT, V_SC_PT);
        
    DBMS_OUTPUT.PUT_LINE('총점 : ' || V_SC_AT + V_SC_WT + V_SC_PT);    
    
    COMMIT;
    
    EXCEPTION
        WHEN INCORRECT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'존재하지 않는 데이터입니다.');
                 ROLLBACK;
        WHEN TOTAL_SC_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'배점 비율을 고려하여 입력하여 주십시오.');
                 ROLLBACK;
        WHEN QUIT_STUDENT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20008,'중도탈락한 학생입니다.');
                  ROLLBACK;
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '이미 존재하는 데이터입니다.');
        WHEN OTHERS
            THEN ROLLBACK;   
END;

CREATE SEQUENCE SEQ_SC_CODE
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;

CREATE OR REPLACE PROCEDURE PRC_SC_INSERT
(
    V_REG_CD    IN TBL_REG.REG_CD%TYPE          -- 수강신청 코드 
,   V_OS_CD     IN TBL_OS.OS_CD%TYPE            -- 개설과목 코드 
,   V_SC_AT     IN TBL_SC.SC_AT%TYPE            -- 출결 
,   V_SC_WT     IN TBL_SC.SC_WT%TYPE            -- 필기 
,   V_SC_PT     IN TBL_SC.SC_PT%TYPE            -- 실기 
)
IS
    V_SC_CD             TBL_SC.SC_CD%TYPE;      -- 성적 코드 
    V_COUNT_RCD         NUMBER;                 -- 예외처리용 수강신청코드1
    V_COUNT_OCD         NUMBER;                 -- 예외처리용 개설과목코드1
    V_COUNT_REG         NUMBER;                 -- 예외처리용 수강신청코드2
    V_COUNT_OS          NUMBER;                 -- 예외처리용 개설과목코드2
    V_COUNT_QT          NUMBER;
    INCORRECT_ERROR     EXCEPTION;
    DUPLICATE_ERROR     EXCEPTION;
    TOTAL_SC_ERROR      EXCEPTION;
    QUIT_STUDENT_ERROR  EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_COUNT_RCD
    FROM TBL_REG
    WHERE REG_CD = V_REG_CD;     
    
    SELECT COUNT(*) INTO V_COUNT_OCD
    FROM TBL_OS
    WHERE OS_CD = V_OS_CD;  
    
    SELECT COUNT(*) INTO V_COUNT_REG
    FROM TBL_SC
    WHERE REG_CD = V_REG_CD;
    
    SELECT COUNT(*) INTO V_COUNT_OS
    FROM TBL_SC
    WHERE OS_CD = V_OS_CD;
    
    -- 중도탈락한 학생일 때
    SELECT COUNT(*) INTO V_COUNT_QT
    FROM TBL_QT
    WHERE REG_CD = V_REG_CD;
    
    IF V_COUNT_QT > 0
        THEN RAISE QUIT_STUDENT_ERROR;
    END IF;
    
    -- 정확하지 않은 코드 입력했을 때 
    IF (V_COUNT_RCD = 1) AND (V_COUNT_OCD = 1)
        THEN
        V_SC_CD := 'SC' || LPAD(SEQ_SC_CODE.NEXTVAL,3,'0'); 
    ELSE RAISE INCORRECT_ERROR;
    END IF;
    
    -- 이미 입력한 정보일때 
    IF V_COUNT_REG > 0
        THEN RAISE DUPLICATE_ERROR;
    END IF;
        
    IF V_COUNT_OS > 0
        THEN RAISE DUPLICATE_ERROR;
    END IF;    
    
    IF (V_SC_AT + V_SC_WT + V_SC_PT) > 100
            THEN RAISE TOTAL_SC_ERROR;
    END IF;
        
    -- 테이블에 데이터 입력 
    INSERT INTO TBL_SC(SC_CD, REG_CD, OS_CD, SC_AT, SC_WT, SC_PT)
    VALUES (V_SC_CD, V_REG_CD, V_OS_CD, V_SC_AT, V_SC_WT, V_SC_PT);
        
    DBMS_OUTPUT.PUT_LINE('총점 : ' || V_SC_AT + V_SC_WT + V_SC_PT);    
    
    COMMIT;
    
    EXCEPTION
        WHEN INCORRECT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'존재하지 않는 데이터입니다.');
                 ROLLBACK;
        WHEN TOTAL_SC_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'배점 비율을 고려하여 입력하여 주십시오.');   
                 ROLLBACK;         
        WHEN QUIT_STUDENT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20008,'중도탈락한 학생입니다.');
                 ROLLBACK;
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '이미 존재하는 데이터입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;