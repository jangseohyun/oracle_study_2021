
CREATE TABLE TEST_CC_P
(   TESTPK  VARCHAR2(10)
,   CONSTRAINT CC_TESTPK_PK PRIMARY KEY(TESTPK)
);

CREATE TABLE TEST_CC_F
(   TESTFK   VARCHAR2(10)
,   TESTFK2  VARCHAR2(10)
,   CONSTRAINT CC_TESTFK_FK FOREIGN KEY(TESTFK) REFERENCES TEST_CC_P(TESTPK)
);


INSERT INTO TEST_CC_P(TESTPK) VALUES('TEST');
INSERT INTO TEST_CC_P(TESTPK) VALUES('TEST2');
INSERT INTO TEST_CC_F(TESTFK,TESTFK2) VALUES('TEST','��');
INSERT INTO TEST_CC_F(TESTFK,TESTFK2) VALUES('TEST2','����');

DROP TABLE TEST_CC_P CASCADE CONSTRAINTS;

SELECT *
FROM TEST_CC_F;


--------------------------------------------------------------------------------


CREATE OR REPLACE VIEW VIEW_OS
AS
SELECT T.*
FROM
(   SELECT ROWNUM "NUM_OS", OS_CD "OS_CD", OC_CD "OC_CD", SUB_CD "SUB_CD", PR_ID "PR_ID"
         , BK_CD "BK_CD", RAT_CD "RAT_CD", SUB_BD "SUB_BD", SUB_ED "SUB_ED"
    FROM TBL_OS
)T;

CREATE OR REPLACE VIEW VIEW_REG
AS
SELECT T.*
FROM
(   SELECT ROWNUM "NUM_REG", REG_CD "REG_CD", ST_ID "ST_ID", OC_CD "OC_CD", REG_DT "REG_DT"
    FROM TBL_REG
)T;

CREATE OR REPLACE VIEW VIEW_SC
AS
SELECT T.*
FROM
(   SELECT ROWNUM "NUM_SC", SC_CD "SC_CD", REG_CD "REG_CD", OS_CD "OS_CD", SC_AT "SC_AT"
         , SC_WT "SC_WT", SC_PT "SC_PT", SC_AT+SC_WT+SC_PT "SC_TT"
         , RANK() OVER (ORDER BY (SC_AT+SC_WT+SC_PT) DESC) "SC_RK"
    FROM TBL_SC
)T;

--�� �л� �������� ���
CREATE OR REPLACE PROCEDURE PRC_PR_SC_LOOKUP
(
    V_PR_ID      IN TBL_PR.PR_ID%TYPE   -- �������̵�
)
IS
    V_SUB_NM     TBL_SUB.SUB_NM%TYPE; -- ������ �����
    V_SUB_BD     TBL_OS.SUB_BD%TYPE;  -- ���� ������
    V_SUB_ED     TBL_OS.SUB_ED%TYPE;  -- ���� ������
    V_BK_CD      TBL_BK.BK_CD%TYPE;   -- �����ڵ�
    V_BK_NM      TBL_BK.BK_NM%TYPE;   -- �����
    
    V_OS_CD      TBL_OS.OS_CD%TYPE;   -- ���񰳼��ڵ�
    V_SUB_CD     TBL_SUB.SUB_CD%TYPE; -- �����ڵ�
    
    V_REG_CD     TBL_REG.REG_CD%TYPE; -- ���������ڵ�
    V_ST_ID      TBL_ST.ST_ID%TYPE;
    
    V_SC_CD      TBL_SC.SC_CD%TYPE;   -- �����ڵ�
    V_SC_AT      TBL_SC.SC_AT%TYPE;   -- ���
    V_SC_WT      TBL_SC.SC_WT%TYPE;   -- �ʱ�
    V_SC_PT      TBL_SC.SC_PT%TYPE;   -- �Ǳ�
    
    V_SC_TT     NUMBER; --����
    V_SC_RK     NUMBER; --���
    
    V_OC_CD      TBL_OC.OC_CD%TYPE;   -- ���������ڵ�
    V_CRS_CD     TBL_OC.CRS_CD%TYPE;  -- �����ڵ�
    VCRS_NM      TBL_CRS.CRS_NM%TYPE; -- ������
    
    V_ST_FN      TBL_ST.ST_FN%TYPE;   -- �л� ��
    V_ST_LN      TBL_ST.ST_LN%TYPE;   -- �л� �̸�
    
    V_NUM        NUMBER;   
    V_ROWNUM     NUMBER;
    V_NUM2       NUMBER;
    V_NUM3       NUMBER := 1;
    V_ROWNUM2    NUMBER;
    V_COUNT      NUMBER;
BEGIN
    SELECT MIN(ROWNUM),MAX(ROWNUM) INTO V_NUM,V_ROWNUM
    FROM VIEW_OS
    WHERE PR_ID = V_PR_ID AND SYSDATE > SUB_ED;

    LOOP
        SELECT OS_CD,SUB_BD,SUB_ED,BK_CD,OC_CD INTO V_OS_CD,V_SUB_BD,V_SUB_ED,V_BK_CD,V_OC_CD
        FROM VIEW_OS
        WHERE PR_ID = V_PR_ID AND NUM_OS = V_NUM;
        
        SELECT SUB_NM INTO V_SUB_NM
        FROM TBL_SUB
        WHERE SUB_CD = (SELECT SUB_CD FROM TBL_OS WHERE OS_CD = V_OS_CD);
        
        SELECT BK_NM INTO V_BK_NM
        FROM TBL_BK
        WHERE BK_CD = V_BK_CD;
        
        -- ���� �����ڵ� ã��
        SELECT CRS_CD INTO V_CRS_CD
        FROM TBL_OC
        WHERE OC_CD = V_OC_CD;
        
        -- ���� ������ ã��
        SELECT CRS_NM INTO VCRS_NM
        FROM TBL_CRS
        WHERE CRS_CD = V_CRS_CD;
        
        -- �л��� ��ȣ ����
        SELECT MIN(ROWNUM),MAX(ROWNUM) INTO V_NUM2,V_ROWNUM2
        FROM TBL_REG
        WHERE OC_CD = V_OC_CD;
        
        --���ǰ��� ���� ���
        DBMS_OUTPUT.PUT_LINE(V_NUM || '.');
        DBMS_OUTPUT.PUT_LINE('������ : '|| VCRS_NM );
        DBMS_OUTPUT.PUT_LINE('����� : ' || V_SUB_NM  );
        DBMS_OUTPUT.PUT_LINE('���� �Ⱓ : ' || V_SUB_BD || '~' || V_SUB_ED );
        DBMS_OUTPUT.PUT_LINE('����� : ' || V_BK_NM );
        DBMS_OUTPUT.PUT_LINE('');
        
        LOOP
            --�ߵ�Ż�� �л� ���� ���� Ȯ��
            SELECT COUNT(*) INTO V_COUNT
            FROM TBL_QT
            WHERE REG_CD = V_REG_CD;
            
            -- ���������ڵ� ����
            SELECT REG_CD INTO V_REG_CD
            FROM VIEW_REG
            WHERE OC_CD = V_OC_CD AND NUM_REG = V_NUM2;
            
            -- �л� �ڵ� ����
            SELECT ST_ID INTO V_ST_ID
            FROM VIEW_REG
            WHERE REG_CD = V_REG_CD AND NUM_REG = V_NUM2;
            
            -- �л� �� ��������
            SELECT ST_FN INTO V_ST_FN
            FROM TBL_ST
            WHERE ST_ID = V_ST_ID;
            
            -- �л� �̸� ��������
            SELECT ST_LN INTO V_ST_LN
            FROM TBL_ST
            WHERE ST_ID = V_ST_ID;
            
            --�ߵ�Ż������ �ʾ��� ���
            IF V_COUNT = 0
                THEN
                    -- ���� �ڵ� ��������
                    SELECT SC_CD INTO V_SC_CD
                    FROM TBL_SC
                    WHERE REG_CD = V_REG_CD;
                    
                    -- ���
                    SELECT SC_AT INTO V_SC_AT
                    FROM TBL_SC
                    WHERE REG_CD = V_REG_CD;
                    
                    -- �ʱ�
                    SELECT SC_WT INTO V_SC_WT
                    FROM TBL_SC
                    WHERE REG_CD = V_REG_CD;
                    
                    -- �Ǳ�
                    SELECT SC_PT INTO V_SC_PT
                    FROM TBL_SC
                    WHERE REG_CD = V_REG_CD; 
                    
                    -- ����
                    SELECT SC_TT INTO V_SC_TT
                    FROM VIEW_SC
                    WHERE SC_CD = V_SC_CD;
                    
                    -- ���
                    SELECT SC_RK INTO V_SC_RK
                    FROM VIEW_SC
                    WHERE SC_CD = V_SC_CD;
                    
                    -- ������ �л� ���� ���� ���        
                    DBMS_OUTPUT.PUT_LINE(V_NUM3 || ')');
                    DBMS_OUTPUT.PUT_LINE('�л� �̸� : ' || V_ST_FN || V_ST_LN );
                    DBMS_OUTPUT.PUT_LINE('��� : ' || V_SC_AT  || '��, �ʱ� : ' || V_SC_WT  || '��, �Ǳ� : ' || V_SC_PT );
                    DBMS_OUTPUT.PUT_LINE('���� : ' || V_SC_TT || '��');
                    DBMS_OUTPUT.PUT_LINE('��� : ' || V_SC_RK || '��');
            --�ߵ�Ż���� ���
            ELSIF V_COUNT > 0
                THEN 
                    DBMS_OUTPUT.PUT_LINE(V_NUM3 || ')');
                    DBMS_OUTPUT.PUT_LINE('�л� �̸� : ' || V_ST_FN || V_ST_LN );
                    DBMS_OUTPUT.PUT_LINE('�� �� ������ �ߵ�Ż���Ͽ� ��ȸ�� ������ �����ϴ�. ��');
            END IF;
        
            V_NUM2 := V_NUM2+1;
            V_NUM3 := V_NUM3+1;
            
            EXIT WHEN V_NUM2 > V_ROWNUM2;
        END LOOP;
        
        V_NUM := V_NUM+1;
        
        EXIT WHEN V_NUM > V_ROWNUM;
    END LOOP;
END;

SELECT *
FROM TBL_QT;

SELECT *
FROM TBL_OS;

SELECT *
FROM TBL_REG;

INSERT INTO TBL_QT(QT_CD, REG_CD, QT_DT) VALUES('QT002','RG005','21/02/14');
INSERT INTO TBL_REG(REG_CD, ST_ID, OC_CD, REG_DT)
VALUES('RG005','ST005','A-FS001','21/01/02');
INSERT INTO TBL_ST(ST_ID,ST_SSN,ST_FN,ST_LN,ST_DT,ST_PW)
VALUES('ST005','121212-1212121','TE','ST','21/01/01','1212121');

EXEC PRC_PR_LOOKUP('PR001');