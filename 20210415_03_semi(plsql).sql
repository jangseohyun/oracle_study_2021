--○ 성적코드 생성용 시퀀스 생성
CREATE SEQUENCE SEQ_SCORE
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;


--○ 성적 입력 프로시저 생성
CREATE OR REPLACE PROCEDURE PRC_SCORE_INSERT
(   V_REG_CD    IN TBL_SC.REG_CD%TYPE
,   V_OS_CD     IN TBL_SC.OS_CD%TYPE
,   V_SC_AT     IN TBL_SC.SC_AT%TYPE
,   V_SC_WT     IN TBL_SC.SC_WT%TYPE
,   V_SC_PT     IN TBL_SC.SC_PT%TYPE
)
IS
    V_SC_CD             TBL_SC.SC_CD%TYPE;
    V_RAT_CD            VARCHAR2(10);
    V_COUNT             NUMBER;
    DUPLICATE_ERROR     EXCEPTION;
    SCORE_ERROR         EXCEPTION;
BEGIN
    --성적코드 중복 여부 확인
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_SC
    WHERE SC_CD = V_SC_CD;
    
    --중복이 아닐 경우 데이터 입력
    IF V_COUNT = 0
        THEN
            --중도탈락코드 생성
            V_SC_CD := 'SC' || LPAD(SEQ_SCORE.NEXTVAL,3,'0');
    --중복일 경우 에러 발생
    ELSE RAISE DUPLICATE_ERROR;
    END IF;
    
    --배점 조건
    SELECT RAT_CD INTO V_RAT_CD
    FROM TBL_OS
    WHERE OS_CD = V_OS_CD;

    IF (SELECT RAT_AT FROM TBL_RAT WHERE RAT_CD = V_RAT_CD) > V_SC_AT
        THEN RAISE SCORE_ERROR;
    --ELSIF SC_WT
    --ELSIF SC_PT
    END IF;
    
    --커밋
    COMMIT;
    
    --예외처리
    EXCEPTION
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'이미 존재하는 데이터입니다.');
                 ROLLBACK;
        WHEN SCORE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'배점 비율을 고려하여 입력하여 주십시오.');
        WHEN OTHERS
            THEN ROLLBACK;
END;


