CREATE OR REPLACE PROCEDURE PRC_REG_ST_LOOKUP
(
    V_ST_ID       IN TBL_ST.ST_ID%TYPE    -- �л����̵�
,   V_REG_CD      IN TBL_REG.REG_CD%TYPE  -- �������� �ڵ�
,   V_OS_CD       IN TBL_OS.OS_CD%TYPE
,   V_NUM         NUMBER    DEFAULT 1
)
IS
    V_ST_FN       TBL_ST.ST_FN%TYPE;    -- �л� ��
    V_ST_LN       TBL_ST.ST_LN%TYPE;    -- �л� �̸�
    V_CRS_NM      TBL_CRS.CRS_NM%TYPE;  -- ������
    V_SUB_NM      TBL_SUB.SUB_NM%TYPE;  -- �����
    V_SC_AT       TBL_SC.SC_AT%TYPE;    -- ���
    V_SC_WT       TBL_SC.SC_WT%TYPE;    -- �ʱ�
    V_SC_PT       TBL_SC.SC_PT%TYPE;    -- �Ǳ�
    V_SUB_BD      TBL_OS.SUB_BD%TYPE;
    V_SUB_ED      TBL_OS.SUB_ED%TYPE;
    V_BK_NM       TBL_BK.BK_NM%TYPE;

    V_CRS_CD      TBL_CRS.CRS_CD%TYPE;  -- �����ڵ�
    V_SUB_CD      TBL_SUB.SUB_CD%TYPE;  -- �����ڵ�
    V_SC_CD       TBL_SC.SC_CD%TYPE;
    V_OC_CD       TBL_OC.OC_CD%TYPE;
    V_BK_CD       TBL_BK.BK_CD%TYPE;
    
    V_SC_TOT       NUMBER;             -- �������� ����
    V_SC_RK        NUMBER;             --���
    
    V_COUNT         NUMBER;
    V_COUNT_QT      NUMBER;
    V_MINNUM        NUMBER;
    V_MAXNUM        NUMBER;
    
    NONEXIST_ERROR  EXCEPTION;
BEGIN
    --�ߵ�Ż�� ���� ��ȸ
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_QT
    WHERE REG_CD = V_REG_CD;
            
    -- �л� �̸�
    SELECT ST_FN, ST_LN INTO V_ST_FN, V_ST_LN
    FROM TBL_ST
    WHERE ST_ID = V_ST_ID;
        
    -- �������� - ���������ڵ�
    SELECT OC_CD INTO V_OC_CD
    FROM TBL_REG
    WHERE REG_CD = V_REG_CD;
        
    -- �������� - ���������ڵ� �� �����ڵ�
    SELECT CRS_CD INTO V_CRS_CD
    FROM TBL_OC
    WHERE OC_CD = V_OC_CD;
                    
    -- ���� - �����ڵ� / �������� - �����ڵ� �� ������
    SELECT CRS_NM INTO V_CRS_NM
    FROM TBL_CRS
    WHERE CRS_CD = V_CRS_CD;
                    
    -- ���񰳼� - ���������ڵ� / �������� - ���������ڵ� �� �����ڵ�
		SELECT SUB_CD INTO V_SUB_CD
    FROM VIEW_OS
    WHERE OS_CD = V_OS_CD;
                    
    -- ���� - �����ڵ� / ���񰳼� - �����ڵ� �� �����
    SELECT SUB_NM INTO V_SUB_NM
    FROM TBL_SUB
    WHERE SUB_CD = V_SUB_CD;
                    
    -- �Ⱓ 
    SELECT SUB_BD, SUB_ED INTO V_SUB_BD, V_SUB_ED
    FROM TBL_OS
    WHERE SUB_CD = V_SUB_CD;
                    
    -- ���� -> �����ڵ� 
		SELECT BK_CD INTO V_BK_CD
    FROM VIEW_OS_ORDER
    WHERE OS_CD = V_OS_CD;
                    
    -- ����� 
    SELECT BK_NM INTO V_BK_NM  
    FROM TBL_BK
    WHERE BK_CD = V_BK_CD;
                     
    IF (V_COUNT = 0)
        THEN 
            -- �����ڵ� 
            SELECT SC_CD INTO V_SC_CD
            FROM TBL_SC
            WHERE REG_CD = V_REG_CD AND OS_CD = V_OS_CD;
                            
            -- ��, ��, ��
            SELECT SC_AT, SC_WT, SC_PT INTO V_SC_AT, V_SC_WT, V_SC_PT
            FROM TBL_SC
            WHERE REG_CD = V_REG_CD AND OS_CD = V_OS_CD;
                            
            -- ����
            SELECT (SC_AT + SC_WT + SC_PT) INTO V_SC_TOT
            FROM TBL_SC
            WHERE SC_CD = V_SC_CD;
                            
            -- ���
            SELECT RANK() OVER (ORDER BY (SC_AT + SC_WT + SC_PT) DESC) INTO V_SC_RK
            FROM TBL_SC
            WHERE SC_CD = V_SC_CD;
            
            DBMS_OUTPUT.PUT_LINE('�л���: ' || V_ST_FN || V_ST_LN);
            DBMS_OUTPUT.PUT_LINE('������: ' || V_CRS_NM);
            DBMS_OUTPUT.PUT_LINE('�����: ' || V_SUB_NM);
            DBMS_OUTPUT.PUT_LINE('����Ⱓ: ' || V_SUB_BD || ' ~ ' || V_SUB_ED);
            DBMS_OUTPUT.PUT_LINE('�����: ' || V_BK_NM);
            DBMS_OUTPUT.PUT_LINE('���: ' || V_SC_AT);
            DBMS_OUTPUT.PUT_LINE('�ʱ�: ' || V_SC_WT);
            DBMS_OUTPUT.PUT_LINE('�Ǳ�: ' || V_SC_PT);
            DBMS_OUTPUT.PUT_LINE('����: ' || V_SC_TOT);
            DBMS_OUTPUT.PUT_LINE('���: ' || V_SC_RK);
    ELSIF V_COUNT > 0 
        THEN 
            DBMS_OUTPUT.PUT_LINE('�л���: ' || V_ST_FN || V_ST_LN);
            DBMS_OUTPUT.PUT_LINE('������: ' || V_CRS_NM);
            DBMS_OUTPUT.PUT_LINE('�����: ' || V_SUB_NM);
            DBMS_OUTPUT.PUT_LINE('����Ⱓ: ' || V_SUB_BD || ' ~ ' || V_SUB_ED);
            DBMS_OUTPUT.PUT_LINE('�����: ' || V_BK_NM);
            DBMS_OUTPUT.PUT_LINE('�� �� ������ �ߵ�Ż���Ͽ� ��ȸ�� ������ �����ϴ�. ��');
    END IF;
        
    -- ���� ó��
    EXCEPTION
        WHEN NONEXIST_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '�������� �ʴ� �������Դϴ�.');
END;