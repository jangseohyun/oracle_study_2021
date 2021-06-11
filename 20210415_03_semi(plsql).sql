--�� �����ڵ� ������ ������ ����
CREATE SEQUENCE SEQ_SCORE
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;


--�� ���� �Է� ���ν��� ����
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
    --�����ڵ� �ߺ� ���� Ȯ��
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_SC
    WHERE SC_CD = V_SC_CD;
    
    --�ߺ��� �ƴ� ��� ������ �Է�
    IF V_COUNT = 0
        THEN
            --�ߵ�Ż���ڵ� ����
            V_SC_CD := 'SC' || LPAD(SEQ_SCORE.NEXTVAL,3,'0');
    --�ߺ��� ��� ���� �߻�
    ELSE RAISE DUPLICATE_ERROR;
    END IF;
    
    --���� ����
    SELECT RAT_CD INTO V_RAT_CD
    FROM TBL_OS
    WHERE OS_CD = V_OS_CD;

    IF (SELECT RAT_AT FROM TBL_RAT WHERE RAT_CD = V_RAT_CD) > V_SC_AT
        THEN RAISE SCORE_ERROR;
    --ELSIF SC_WT
    --ELSIF SC_PT
    END IF;
    
    --Ŀ��
    COMMIT;
    
    --����ó��
    EXCEPTION
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'�̹� �����ϴ� �������Դϴ�.');
                 ROLLBACK;
        WHEN SCORE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'���� ������ ����Ͽ� �Է��Ͽ� �ֽʽÿ�.');
        WHEN OTHERS
            THEN ROLLBACK;
END;


