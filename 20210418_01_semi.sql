CREATE OR REPLACE PROCEDURE PRC_REG_ST_LOOKUP
(
    V_ST_ID       IN TBL_ST.ST_ID%TYPE    -- 학생아이디
,   V_REG_CD      IN TBL_REG.REG_CD%TYPE  -- 수강내역 코드
,   V_OS_CD       IN TBL_OS.OS_CD%TYPE
,   V_NUM         NUMBER    DEFAULT 1
)
IS
    V_ST_FN       TBL_ST.ST_FN%TYPE;    -- 학생 성
    V_ST_LN       TBL_ST.ST_LN%TYPE;    -- 학생 이름
    V_CRS_NM      TBL_CRS.CRS_NM%TYPE;  -- 과정명
    V_SUB_NM      TBL_SUB.SUB_NM%TYPE;  -- 과목명
    V_SC_AT       TBL_SC.SC_AT%TYPE;    -- 출결
    V_SC_WT       TBL_SC.SC_WT%TYPE;    -- 필기
    V_SC_PT       TBL_SC.SC_PT%TYPE;    -- 실기
    V_SUB_BD      TBL_OS.SUB_BD%TYPE;
    V_SUB_ED      TBL_OS.SUB_ED%TYPE;
    V_BK_NM       TBL_BK.BK_NM%TYPE;

    V_CRS_CD      TBL_CRS.CRS_CD%TYPE;  -- 과정코드
    V_SUB_CD      TBL_SUB.SUB_CD%TYPE;  -- 과목코드
    V_SC_CD       TBL_SC.SC_CD%TYPE;
    V_OC_CD       TBL_OC.OC_CD%TYPE;
    V_BK_CD       TBL_BK.BK_CD%TYPE;
    
    V_SC_TOT       NUMBER;             -- 수강과목 총점
    V_SC_RK        NUMBER;             --등수
    
    V_COUNT         NUMBER;
    V_COUNT_QT      NUMBER;
    V_MINNUM        NUMBER;
    V_MAXNUM        NUMBER;
    
    NONEXIST_ERROR  EXCEPTION;
BEGIN
    --중도탈락 여부 조회
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_QT
    WHERE REG_CD = V_REG_CD;
            
    -- 학생 이름
    SELECT ST_FN, ST_LN INTO V_ST_FN, V_ST_LN
    FROM TBL_ST
    WHERE ST_ID = V_ST_ID;
        
    -- 과정개설 - 개설과정코드
    SELECT OC_CD INTO V_OC_CD
    FROM TBL_REG
    WHERE REG_CD = V_REG_CD;
        
    -- 수강내역 - 개설과정코드 → 과정코드
    SELECT CRS_CD INTO V_CRS_CD
    FROM TBL_OC
    WHERE OC_CD = V_OC_CD;
                    
    -- 과정 - 과정코드 / 과정개설 - 과정코드 → 과정명
    SELECT CRS_NM INTO V_CRS_NM
    FROM TBL_CRS
    WHERE CRS_CD = V_CRS_CD;
                    
    -- 과목개설 - 개설과정코드 / 수강내역 - 개설과정코드 → 과목코드
		SELECT SUB_CD INTO V_SUB_CD
    FROM VIEW_OS
    WHERE OS_CD = V_OS_CD;
                    
    -- 과목 - 과목코드 / 과목개설 - 과목코드 → 과목명
    SELECT SUB_NM INTO V_SUB_NM
    FROM TBL_SUB
    WHERE SUB_CD = V_SUB_CD;
                    
    -- 기간 
    SELECT SUB_BD, SUB_ED INTO V_SUB_BD, V_SUB_ED
    FROM TBL_OS
    WHERE SUB_CD = V_SUB_CD;
                    
    -- 과정 -> 과목코드 
		SELECT BK_CD INTO V_BK_CD
    FROM VIEW_OS_ORDER
    WHERE OS_CD = V_OS_CD;
                    
    -- 교재명 
    SELECT BK_NM INTO V_BK_NM  
    FROM TBL_BK
    WHERE BK_CD = V_BK_CD;
                     
    IF (V_COUNT = 0)
        THEN 
            -- 성적코드 
            SELECT SC_CD INTO V_SC_CD
            FROM TBL_SC
            WHERE REG_CD = V_REG_CD AND OS_CD = V_OS_CD;
                            
            -- 출, 필, 실
            SELECT SC_AT, SC_WT, SC_PT INTO V_SC_AT, V_SC_WT, V_SC_PT
            FROM TBL_SC
            WHERE REG_CD = V_REG_CD AND OS_CD = V_OS_CD;
                            
            -- 총점
            SELECT (SC_AT + SC_WT + SC_PT) INTO V_SC_TOT
            FROM TBL_SC
            WHERE SC_CD = V_SC_CD;
                            
            -- 등수
            SELECT RANK() OVER (ORDER BY (SC_AT + SC_WT + SC_PT) DESC) INTO V_SC_RK
            FROM TBL_SC
            WHERE SC_CD = V_SC_CD;
            
            DBMS_OUTPUT.PUT_LINE('학생명: ' || V_ST_FN || V_ST_LN);
            DBMS_OUTPUT.PUT_LINE('과정명: ' || V_CRS_NM);
            DBMS_OUTPUT.PUT_LINE('과목명: ' || V_SUB_NM);
            DBMS_OUTPUT.PUT_LINE('과목기간: ' || V_SUB_BD || ' ~ ' || V_SUB_ED);
            DBMS_OUTPUT.PUT_LINE('교재명: ' || V_BK_NM);
            DBMS_OUTPUT.PUT_LINE('출결: ' || V_SC_AT);
            DBMS_OUTPUT.PUT_LINE('필기: ' || V_SC_WT);
            DBMS_OUTPUT.PUT_LINE('실기: ' || V_SC_PT);
            DBMS_OUTPUT.PUT_LINE('총점: ' || V_SC_TOT);
            DBMS_OUTPUT.PUT_LINE('등수: ' || V_SC_RK);
    ELSIF V_COUNT > 0 
        THEN 
            DBMS_OUTPUT.PUT_LINE('학생명: ' || V_ST_FN || V_ST_LN);
            DBMS_OUTPUT.PUT_LINE('과정명: ' || V_CRS_NM);
            DBMS_OUTPUT.PUT_LINE('과목명: ' || V_SUB_NM);
            DBMS_OUTPUT.PUT_LINE('과목기간: ' || V_SUB_BD || ' ~ ' || V_SUB_ED);
            DBMS_OUTPUT.PUT_LINE('교재명: ' || V_BK_NM);
            DBMS_OUTPUT.PUT_LINE('※ 본 과목을 중도탈락하여 조회할 성적이 없습니다. ※');
    END IF;
        
    -- 에러 처리
    EXCEPTION
        WHEN NONEXIST_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '존재하지 않는 데이터입니다.');
END;