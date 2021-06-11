
--○ PRC_수강내역조회  PRC_REG_LOOKUP

-- 학생 이름, 과정명, 수강과목, 수강과목 총점
CREATE OR REPLACE PROCEDURE PRC_REG_LOOKUP
(
    V_ST_ID     IN TBL_ST.ST_ID%TYPE    -- 학생아이디
,   V_OC_CD     IN TBL_OC.OC_CD%TYPE    -- 과정 코드
)
IS
    V_ST_FN       TBL_ST.ST_FN%TYPE;   -- 학생 성
    V_ST_LN       TBL_ST.ST_LN%TYPE;   -- 학생 이름
    V_CRS_NM      TBL_CRS.CRS_NM%TYPE; -- 과정명
    V_SUB_NM      TBL_SUB.SUB_NM%TYPE; -- 과목명
    V_SC_AT       TBL_SC.SC_AT%TYPE;   -- 출결
    V_SC_WT       TBL_SC.SC_WT%TYPE;   -- 필기
    V_SC_PT       TBL_SC.SC_PT%TYPE;   -- 실기
    
    V_OS_CD       TBL_OS.OS_CD%TYPE;
    V_CRS_CD      TBL_CRS.CRS_CD%TYPE;  -- 과정코드
    V_SUB_CD      TBL_SUB.SUB_CD%TYPE;  -- 과목코드
    V_REG_CD      TBL_REG.REG_CD%TYPE; -- 수강신청코드
    
    V_SC_TOT        NUMBER;             -- 수강과목 총점
    
    V_COUNT         NUMBER;
    Q_COUNT         NUMBER;
    V_MINNUM        NUMBER;
    V_MAXNUM        NUMBER;
    V_NUM           NUMBER := 1;
    
    NONEXIST_ERROR  EXCEPTION;
    
BEGIN
    
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_REG
    WHERE ST_ID = V_ST_ID AND OC_CD = V_OC_CD;
    
    IF (V_COUNT > 0)
        THEN 
            -- 학생이 조회되는 최소 번호(ROWNUM)부터 최대 번호값
            SELECT MIN(ROWNUM),MAX(ROWNUM) INTO V_MINNUM,V_MAXNUM
            FROM VIEW_REG
            WHERE ST_ID = V_ST_ID AND OC_CD = V_OC_CD;
            
            -- 해당 학생이 여러 과목을 들었다면     
            LOOP
                --수강신청코드, 개설과정코드
                SELECT REG_CD INTO V_REG_CD
                FROM VIEW_REG_ORDER
                WHERE ST_ID = V_ST_ID AND OC_CD = V_OC_CD;
                
                -- 학생 이름
                SELECT ST_FN, ST_LN INTO V_ST_FN, V_ST_LN
                FROM TBL_ST
                WHERE ST_ID = V_ST_ID;
                
                -- 과정개설 - 개설과정코드 / 수강내역 - 개설과정코드 → 과정코드
                SELECT CRS_CD INTO V_CRS_CD
                FROM TBL_OC
                WHERE OC_CD = V_OC_CD;
                
                -- 과정 - 과정코드 / 과정개설 - 과정코드 → 과정명
                SELECT CRS_NM INTO V_CRS_NM
                FROM TBL_CRS
                WHERE CRS_CD = V_CRS_CD;
                
                -- 과목개설 - 개설과정코드 / 수강내역 - 개설과정코드 → 과목코드
                SELECT OS_CD,SUB_CD INTO V_OS_CD,V_SUB_CD
                FROM VIEW_OS_ORDER
                WHERE OC_CD = V_OC_CD AND NUM_OS = V_NUM AND SYSDATE - SUB_ED > 0;
                
                -- 과목 - 과목코드 / 과목개설 - 과목코드 → 과목명
                SELECT SUB_NM INTO V_SUB_NM
                FROM TBL_SUB
                WHERE SUB_CD = V_SUB_CD;
                
                -- 성적입력 - 수강신청코드 / 수강내역 - 수강신청코드 → 성적
                SELECT SC_AT, SC_WT, SC_PT INTO V_SC_AT, V_SC_WT, V_SC_PT
                FROM TBL_SC
                WHERE REG_CD = V_REG_CD AND OS_CD = V_OS_CD;
                
                
                V_SC_TOT := (V_SC_AT + V_SC_WT + V_SC_PT);   --총점
                

               -- 중도탈락 학생 존재 여부 확인
		        SELECT COUNT(*) INTO Q_COUNT
		        FROM TBL_QT
		        WHERE REG_CD = V_REG_CD;
                
		        IF (Q_COUNT = 0)
                    THEN 
                        -- 학생 이름, 과정명, 수강과목, 수강과목 총점
                        -- 학생 정보 출력
                        DBMS_OUTPUT.PUT_LINE('학생이름 : ' || V_ST_FN || V_ST_LN);
                        DBMS_OUTPUT.PUT_LINE('과정명 : ' || V_CRS_NM);
                        DBMS_OUTPUT.PUT_LINE('수강과목 : ' || V_SUB_NM);
                        DBMS_OUTPUT.PUT_LINE('수강과목 총점 : ' || V_SC_TOT);
		        ELSIF (Q_COUNT > 0)
                    THEN
                        DBMS_OUTPUT.PUT_LINE('학생 이름 : ' || V_ST_FN || V_ST_LN);
                        DBMS_OUTPUT.PUT_LINE('과정명 : ' || V_CRS_NM);
                        DBMS_OUTPUT.PUT_LINE('※ 본 과정을 중도탈락한 학생입니다.');
		        END IF;
                
                V_MINNUM := V_MINNUM+1;
                V_NUM := V_NUM + 1;
                
                EXIT WHEN V_MINNUM > V_MAXNUM;
            
            END LOOP;
            
    ELSE RAISE NONEXIST_ERROR;
        
    END IF;
    
    
    -- 커밋
    COMMIT;
    
    -- 에러 처리
    EXCEPTION
        WHEN NONEXIST_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '존재하지 않는 데이터입니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    

END;
--==> Procedure PRC_REG_LOOKUP이(가) 컴파일되었습니다.



--○ 수강내역 조회 프로시저 2 (같은과정 같은과목 전체학생)
CREATE OR REPLACE PROCEDURE PRC_AD_REG_LOOKUP
IS
    V_ST_ID      TBL_ST.ST_ID%TYPE;
    V_OC_CD      TBL_OC.OC_CD%TYPE;
    V_NUM        NUMBER := 1;
    V_ROWNUM     NUMBER; 
    V_MINNUM     NUMBER;
    V_MAXNUM     NUMBER;
BEGIN
    SELECT MIN(ROWNUM),MAX(ROWNUM) INTO V_MINNUM,V_MAXNUM
    FROM VIEW_OC;
    
    LOOP
        SELECT OC_CD INTO V_OC_CD
        FROM VIEW_OC
        WHERE NUM_OC = V_MINNUM;
        
        SELECT MAX(ROWNUM) INTO V_ROWNUM
        FROM TBL_REG
        WHERE OC_CD = V_OC_CD;
    
        LOOP
            SELECT ST_ID INTO V_ST_ID
            FROM VIEW_REG_ORDER
            WHERE NUM_REG_ORDER = V_NUM;
            
            DBMS_OUTPUT.PUT_LINE(V_NUM || '.');
            PRC_REG_LOOKUP(V_ST_ID,V_OC_CD);
            V_NUM := V_NUM + 1;
            
            EXIT WHEN V_NUM > V_ROWNUM;
        END LOOP;
        
        V_MINNUM := V_MINNUM +1;
        EXIT WHEN V_MINNUM > V_MAXNUM;
    END LOOP;
END;
--==> Procedure PRC_AD_REG_LOOKUP이(가) 컴파일되었습니다.