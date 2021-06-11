--● 교수 계정 조회 프로시저
CREATE OR REPLACE PROCEDURE PRC_PR_LOOKUP
( VPR_ID    IN TBL_PR.PR_ID%TYPE
)
IS
    VOS_CD      TBL_OS.OS_CD%TYPE;   -- 배정된 과목명
    VSUB_BD     TBL_OS.SUB_BD%TYPE;  -- 과목 시작일
    VSUB_ED     TBL_OS.SUB_ED%TYPE;  -- 과목 종료일
    VBK_CD    TBL_BK.BK_CD%TYPE;   -- 교재코드
    VBK_NM      TBL_BK.BK_NM%TYPE;   -- 교재명
    VOC_CD      TBL_OC.OC_CD%TYPE;   -- 강의실코드
    VCRS_RM     TBL_OC.CRS_RM%TYPE;  -- 강의실
    
    VING        VARCHAR(50);         -- 강의 진행 여부
    VDATE1      NUMBER;                -- 날짜 연산 변수
    VDATE2      NUMBER;
    
BEGIN
    -- 배정된 과목명 VOS_CD연산
    SELECT OS_CD INTO VOS_CD
    FROM TBL_OS
    WHERE PR_ID = VPR_ID;
    
    -- 과목 기간 VSUB_BD, VSUB_ED
    SELECT SUB_BD INTO VSUB_BD
    FROM TBL_OS
    WHERE PR_ID = VPR_ID;    
    
    SELECT SUB_ED INTO VSUB_ED
    FROM TBL_OS
    WHERE PR_ID = VPR_ID;   
    
    -- 교재명 VBK_NM
    SELECT BK_CD INTO VBK_CD
    FROM TBL_OS
    WHERE PR_ID = VPR_ID;
    
    SELECT BK_NM INTO VBK_NM
    FROM TBL_BK
    WHERE BK_CD = VBK_CD;
    
    -- 강의실 VCRS_RM
    SELECT OC_CD INTO VOC_CD
    FROM TBL_OS
    WHERE PR_ID = VPR_ID;
    
    SELECT CRS_RM INTO VCRS_RM
    FROM TBL_OC
    WHERE OC_CD = VCRS_RM;
    
    -- 강의 진행 여부 VING
    VDATE1 := TO_NUMBER(SYSDATE - VSUB_BD);
    VDATE2 := TO_NUMBER(SYSDATE - VSUB_ED);
    
    IF (VDATE1 >0 AND VDATE2 <0) 
        THEN VING := '강의 중';
    ELSIF (VDATE1 >0 AND VDATE2 >0) 
        THEN VING := '강의 예정';
    ELSIF (VDATE1 <0 AND VDATE2 <0)
        THEN VING := '강의 종료';
    ELSE VING := '확인불가';
    END IF;
    
    -- 교수 정보 출력
    DBMS_OUTPUT.PUT_LINE('교수ID : ' || VPR_ID || '배정된 과목명 : ' || VOS_CD ||
                '과목시작일 : ' || VSUB_BD || '과목종료일 : ' || VSUB_ED || 
                '교재명 : ' || VBK_NM || '강의실 : ' || VCRS_RM ||
                '강의 진행 여부' || VING );
END;