--�� ���� ���� ��ȸ ���ν���
CREATE OR REPLACE PROCEDURE PRC_PR_LOOKUP
( VPR_ID    IN TBL_PR.PR_ID%TYPE
)
IS
    VOS_CD      TBL_OS.OS_CD%TYPE;   -- ������ �����
    VSUB_BD     TBL_OS.SUB_BD%TYPE;  -- ���� ������
    VSUB_ED     TBL_OS.SUB_ED%TYPE;  -- ���� ������
    VBK_CD    TBL_BK.BK_CD%TYPE;   -- �����ڵ�
    VBK_NM      TBL_BK.BK_NM%TYPE;   -- �����
    VOC_CD      TBL_OC.OC_CD%TYPE;   -- ���ǽ��ڵ�
    VCRS_RM     TBL_OC.CRS_RM%TYPE;  -- ���ǽ�
    
    VING        VARCHAR(50);         -- ���� ���� ����
    VDATE1      NUMBER;                -- ��¥ ���� ����
    VDATE2      NUMBER;
    
BEGIN
    -- ������ ����� VOS_CD����
    SELECT OS_CD INTO VOS_CD
    FROM TBL_OS
    WHERE PR_ID = VPR_ID;
    
    -- ���� �Ⱓ VSUB_BD, VSUB_ED
    SELECT SUB_BD INTO VSUB_BD
    FROM TBL_OS
    WHERE PR_ID = VPR_ID;    
    
    SELECT SUB_ED INTO VSUB_ED
    FROM TBL_OS
    WHERE PR_ID = VPR_ID;   
    
    -- ����� VBK_NM
    SELECT BK_CD INTO VBK_CD
    FROM TBL_OS
    WHERE PR_ID = VPR_ID;
    
    SELECT BK_NM INTO VBK_NM
    FROM TBL_BK
    WHERE BK_CD = VBK_CD;
    
    -- ���ǽ� VCRS_RM
    SELECT OC_CD INTO VOC_CD
    FROM TBL_OS
    WHERE PR_ID = VPR_ID;
    
    SELECT CRS_RM INTO VCRS_RM
    FROM TBL_OC
    WHERE OC_CD = VCRS_RM;
    
    -- ���� ���� ���� VING
    VDATE1 := TO_NUMBER(SYSDATE - VSUB_BD);
    VDATE2 := TO_NUMBER(SYSDATE - VSUB_ED);
    
    IF (VDATE1 >0 AND VDATE2 <0) 
        THEN VING := '���� ��';
    ELSIF (VDATE1 >0 AND VDATE2 >0) 
        THEN VING := '���� ����';
    ELSIF (VDATE1 <0 AND VDATE2 <0)
        THEN VING := '���� ����';
    ELSE VING := 'Ȯ�κҰ�';
    END IF;
    
    -- ���� ���� ���
    DBMS_OUTPUT.PUT_LINE('����ID : ' || VPR_ID || '������ ����� : ' || VOS_CD ||
                '��������� : ' || VSUB_BD || '���������� : ' || VSUB_ED || 
                '����� : ' || VBK_NM || '���ǽ� : ' || VCRS_RM ||
                '���� ���� ����' || VING );
END;