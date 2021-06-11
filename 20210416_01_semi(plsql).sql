--�� �ƺ���� �ڵ� (��ȸ �� ��)
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
        THEN RAISE_APPLICATION_ERROR(-20002, '�Է��Ͻ� ������ ��ġ�ϴ� �����Ͱ� �����ϴ�.');
             ROLLBACK;
    WHEN OTHERS
        THEN ROLLBACK;
END;


--�� ��ü ��ȸ ���ø� ���� VIEW_QT ����
CREATE OR REPLACE VIEW VIEW_QT
AS
SELECT T.*
FROM
(
    SELECT ROWNUM "NUM", QT_CD "QT_CD", QT_DT "QT_DT"
    FROM TBL_QT
)T;


--�� ��ü ��ȸ ����
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


--�� ���ǿ� �ش��ϴ� ��ü �� ��� ����
CREATE OR REPLACE PROCEDURE PRC_QUIT_LOOKUP_T2
(   V_QT_CD    IN TBL_QT.QT_CD%TYPE   --����� �Է°��̶�� ����
)
IS
    V_QT_DT     TBL_QT.QT_DT%TYPE;
    V_NUM       NUMBER := 1;
    V_COUNT    NUMBER;
BEGIN
    --�Է°��� ��ġ�ϴ� �� ���� V_COUNT�� ���
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_QT
    WHERE QT_CD = V_QT_CD;

    LOOP
        --�Է°��� ��ġ�ϸ� V_QT_DT�� ���
        SELECT QT_DT INTO V_QT_DT
        FROM TBL_QT
        WHERE QT_CD = V_QT_CD;
        
        --���
        DBMS_OUTPUT.PUT_LINE(V_QT_DT);
                
        V_NUM := V_NUM + 1;
                                      
        EXIT WHEN V_NUM > V_COUNT;
    END LOOP;
END;


--���񰳼�----------------------------------------------------------------------


--�� ���񰳼� ���̺� ����
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

--�� ���� ���� ���̺� ����
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

--�� ���� ���̺� ����
CREATE TABLE TBL_CRS
( CRS_CD    VARCHAR2(10)
, CRS_NM    VARCHAR2(50)    CONSTRAINT CRS_NM_NN NOT NULL
--, CONSTRAINT CRS_CD_PK PRIMARY KEY(CRS_CD)
);

--�� ���� ���̺� ����
CREATE TABLE TBL_SUB
( SUB_CD VARCHAR2(10)
, SUB_NM VARCHAR2(50) CONSTRAINT SUB_NM_NN NOT NULL
--, CONSTRAINT SUB_CD_PK PRIMARY KEY(SUB_CD)
);

--�� ���� ���̺� ����
CREATE TABLE TBL_PR
( PR_ID     VARCHAR2(10)    
, PR_SSN    CHAR(14)       CONSTRAINT PR_SSN_NN NOT NULL
, PR_FN     VARCHAR2(5)    CONSTRAINT PR_FN_NN NOT NULL
, PR_LN     VARCHAR2(5)    CONSTRAINT PR_LN_NN NOT NULL
, PR_DT     DATE                DEFAULT SYSDATE
, PR_PW     VARCHAR2(10)   CONSTRAINT PR_PW_NN NOT NULL
--, CONSTRAINT PR_ID_PK PRIMARY KEY (PR_ID)
);

--�� ���� ���̺� ����
CREATE TABLE TBL_BK
( BK_CD VARCHAR2(10)
, BK_NM VARCHAR2(50) CONSTRAINT BK_NM_NN  NOT NULL
--, CONSTRAINT BK_CD_PK PRIMARY KEY(BK_CD)
);


--�� ���񰳼� ��ȸ ���ν����� VIEW ����
CREATE OR REPLACE VIEW VIEW_OS
AS
SELECT T.*
FROM
(
    SELECT ROWNUM "NUM", OS_CD "OS_CD", OC_CD "OC_CD", SUB_CD "SUB_CD", PR_ID "PR_ID"
          ,BK_CD "BK_CD", RAT_CD "RAT_CD", SUB_BD "SUB_BD", SUB_ED "SUB_ED"
    FROM TBL_OS
)T;



--�� ���񰳼� ��ü ��ȸ ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_OS_LOOKUP
IS
    V_CRS_NM    TBL_CRS.CRS_NM%TYPE;    --������
    V_CRS_RM    TBL_OC.CRS_RM%TYPE;     --���ǽ�
    V_SUB_NM    TBL_SUB.SUB_NM%TYPE;    --�����
    V_SUB_BD    TBL_OS.SUB_BD%TYPE;     --�������
    V_SUB_ED    TBL_OS.SUB_ED%TYPE;     --��������
    V_BK_NM     TBL_BK.BK_NM%TYPE;      --�����
    V_PR_FN     TBL_PR.PR_FN%TYPE;      --������
    V_PR_LN     TBL_PR.PR_LN%TYPE;      --�����̸�
    
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
        DBMS_OUTPUT.PUT_LINE('������: ' || V_CRS_NM);
        DBMS_OUTPUT.PUT_LINE('���ǽ�: ' || V_CRS_RM);
        DBMS_OUTPUT.PUT_LINE('�����: ' || V_SUB_NM);
        DBMS_OUTPUT.PUT_LINE('����Ⱓ: ' || V_SUB_BD || ' ~ ' || V_SUB_ED);
        DBMS_OUTPUT.PUT_LINE('�����: ' || V_BK_NM);
        DBMS_OUTPUT.PUT_LINE('������: ' || V_PR_FN || ' ' || V_PR_LN);
        
        V_NUM := V_NUM+1;
        
        EXIT WHEN V_NUM > V_ROWNUM;
    END LOOP;
END;


--------------------------------------------------------------------------------


-- ������ ����
CREATE SEQUENCE SEQ_CRS
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;
--==> Sequence SEQ_CRS��(��) �����Ǿ����ϴ�.


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
    --������ �ߺ� ���� Ȯ��
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_CRS
    WHERE CRS_NM = V_CRS_NM;
    
    --�ߺ��� ���� �߻�
    IF V_COUNT >= 1
        THEN RAISE DUPLICATE_ERROR;
    END IF;
    
    --ù �� ���ڰ� ���ĺ� �빮�� �� �������� Ȯ��
    V_CD_ASCII := TO_NUMBER(ASCII(SUBSTR(V_CRS_NM,1,1))) + TO_NUMBER(ASCII(SUBSTR(V_CRS_NM,2,1)));
    
    IF (V_CD_ASCII >= 130 AND V_CD_ASCII <= 180)
        THEN
            V_CRS_CD := SUBSTR(V_CRS_NM,1,2) || LPAD(SEQ_CRS.NEXTVAL,3,'0');
            INSERT INTO TBL_CRS(CRS_CD, CRS_NM) VALUES (V_CRS_CD, V_CRS_NM);
    ELSE
        RAISE CREATE_CODE_ERROR;
    END IF;
    
    -- Ŀ��
    COMMIT;
    
    EXCEPTION
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '�̹� �����ϴ� �������Դϴ�.');
                 ROLLBACK;
        WHEN CREATE_CODE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20007,'��ȿ���� ���� �������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;


--����--------------------------------------------------------------------------


--�л� ���̺� ����
CREATE TABLE TBL_ST
( ST_ID     VARCHAR2(10)   
, ST_SSN    CHAR(14)       CONSTRAINT ST_SSN_NN NOT NULL
, ST_FN     VARCHAR2(5)    CONSTRAINT ST_FN_NN NOT NULL
, ST_LN     VARCHAR2(5)    CONSTRAINT ST_LN_NN NOT NULL
, ST_DT     DATE           DEFAULT SYSDATE
, ST_PW     VARCHAR2(10)   CONSTRAINT ST_PW_NN NOT NULL
--, CONSTRAINT ST_ID_PK PRIMARY KEY(ST_ID) 
);

-- ���� ��ȸ �� ���� 
CREATE OR REPLACE VIEW VIEW_SC
AS
SELECT T.*
FROM
(
    --����
    SELECT ROWNUM "NUM", SC_CD "SC_CD", REG_CD "REG_CD", OS_CD "OS_CD"
         , SC_AT "SC_AT", SC_WT "SC_WT", SC_PT "SC_PT"
    FROM TBL_SC
)T; 
   
/*
��� ������ �л� �̸�, ������, �����, ���� �Ⱓ(���� ������, �� ������), ���� ��,
���, �Ǳ�, �ʱ�, ����, ����� ��µǾ�� �Ѵ�.
*/
-- ���� ��ȸ ���ν��� �ۼ� 
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
    V_SC_TT     NUMBER; --����
    V_SC_RK     NUMBER; --���
    
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
        --�߰�
        SELECT REG_CD,OS_CD,SC_CD INTO V_REG_CD,V_OS_CD,V_SC_CD
        FROM VIEW_SC
        WHERE NUM = V_NUM;
        
        SELECT ST_FN, ST_LN INTO V_ST_FN, V_ST_LN
        FROM TBL_ST
        WHERE ST_ID = (SELECT ST_ID FROM TBL_REG WHERE REG_CD = V_REG_CD);
        
        --�߰�
        SELECT CRS_CD INTO V_CRS_CD
        FROM TBL_OC
        WHERE OC_CD = (SELECT OC_CD FROM TBL_OS WHERE OS_CD = V_OS_CD);
        
        SELECT CRS_NM INTO V_CRS_NM
        FROM TBL_CRS
        WHERE CRS_CD = V_CRS_CD;
        
        --�߰�
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
        ��� ������ �л� �̸�, ������, �����, ���� �Ⱓ(���� ������, �� ������), ���� ��,
        ���, �Ǳ�, �ʱ�, ����, ����� ��µǾ�� �Ѵ�.
        */

        DBMS_OUTPUT.PUT_LINE(V_NUM || '.');
        DBMS_OUTPUT.PUT_LINE('��: ' || V_ST_FN);
        DBMS_OUTPUT.PUT_LINE('�̸�: ' || V_ST_LN);
        DBMS_OUTPUT.PUT_LINE('������: ' || V_CRS_NM);
        DBMS_OUTPUT.PUT_LINE('�����: ' || V_SUB_NM);
        DBMS_OUTPUT.PUT_LINE('����Ⱓ: ' || V_SUB_BD || ' ~ ' || V_SUB_ED);
        DBMS_OUTPUT.PUT_LINE('�����: ' || V_BK_NM);
        DBMS_OUTPUT.PUT_LINE('���: ' || V_SC_AT);
        DBMS_OUTPUT.PUT_LINE('�ʱ�: ' || V_SC_WT);
        DBMS_OUTPUT.PUT_LINE('�Ǳ�: ' || V_SC_PT);
        DBMS_OUTPUT.PUT_LINE('����: ' || V_SC_TT);
        DBMS_OUTPUT.PUT_LINE('���: ' || V_SC_RK);
        
        V_NUM := V_NUM+1;
        
        EXIT WHEN V_NUM > V_ROWNUM;
    END LOOP;
END;


--�� ���� �Է� ���ν��� �ۼ�
CREATE OR REPLACE PROCEDURE PRC_SC_INSERT
(
    V_REG_CD    IN TBL_REG.REG_CD%TYPE   -- ������û �ڵ� 
,   V_OS_CD     IN TBL_OS.OS_CD%TYPE    -- �������� �ڵ� 
,   V_SC_AT     IN TBL_SC.SC_AT%TYPE    -- ��� 
,   V_SC_WT     IN TBL_SC.SC_WT%TYPE    -- �ʱ� 
,   V_SC_PT     IN TBL_SC.SC_PT%TYPE    -- �Ǳ� 
)
IS
    V_SC_CD             TBL_SC.SC_CD%TYPE;      -- ���� �ڵ� 
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
        

         -- ���̺� ������ �Է� 
    INSERT INTO TBL_SC(SC_CD, REG_CD, OS_CD, SC_AT, SC_WT, SC_PT)
    VALUES (V_SC_CD, V_REG_CD, V_OS_CD, V_SC_AT, V_SC_WT, V_SC_PT);
    
    DBMS_OUTPUT.PUT_LINE(SC_AT+SC_WT+SC_PT);
    COMMIT;
    
    EXCEPTION
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'�̹� �����ϴ� �������Դϴ�.');
                 ROLLBACK;
        WHEN TOTAL_SC_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'���� ������ ����Ͽ� �Է��Ͽ� �ֽʽÿ�.');
        WHEN QUIT_STUDENT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20007,'�ߵ�Ż���� �л��Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==> Procedure PRC_SC_INSERT��(��) �����ϵǾ����ϴ�.


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
--==>> View VIEW_PR��(��) �����Ǿ����ϴ�.


--�� Ư�� ������ ��ü ���Ǹ�� ��ȸ
CREATE OR REPLACE PROCEDURE PRC_PR_LOOKUP
(
    V_PR_ID      IN TBL_PR.PR_ID%TYPE   -- �������̵�
)
IS
    V_SUB_NM     TBL_SUB.SUB_NM%TYPE; -- ������ �����
    V_SUB_BD     TBL_OS.SUB_BD%TYPE;  -- ���� ������
    V_SUB_ED     TBL_OS.SUB_ED%TYPE;  -- ���� ������
    V_BK_CD      TBL_BK.BK_CD%TYPE;   -- �����ڵ�
    V_BK_NM      TBL_BK.BK_NM%TYPE;   -- �����
    V_OC_CD      TBL_OC.OC_CD%TYPE;   -- ���ǽ��ڵ�
    V_CRS_RM     TBL_OC.CRS_RM%TYPE;  -- ���ǽ�
    
    V_OS_CD      TBL_OS.OS_CD%TYPE;
    V_SUB_CD     TBL_SUB.SUB_CD%TYPE;
    
    V_ING        VARCHAR(50);         -- ���� ���� ����
    V_DATE1      NUMBER;              -- ��¥ ���� ����
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
        
        -- ���� ���� ���� VING
        V_DATE1 := TO_NUMBER(SYSDATE - V_SUB_BD);
        V_DATE2 := TO_NUMBER(SYSDATE - V_SUB_ED);
        
        IF (V_DATE1 > 0 AND V_DATE2 < 0) 
            THEN V_ING := '���� ��';
        ELSIF (V_DATE1 < 0 AND V_DATE2 < 0) 
            THEN V_ING := '���� ����';
        ELSIF (V_DATE1 > 0 AND V_DATE2 > 0)
            THEN V_ING := '���� ����';
        ELSE V_ING := 'Ȯ�κҰ�';
        END IF;
        
        -- ���� ���� ���        
        DBMS_OUTPUT.PUT_LINE(V_NUM || '.');
        DBMS_OUTPUT.PUT_LINE('����ID : ' || V_PR_ID);
        DBMS_OUTPUT.PUT_LINE('������ ����� : ' || V_OS_CD  );
        DBMS_OUTPUT.PUT_LINE('���� �Ⱓ : ' || V_SUB_BD || '~' || V_SUB_ED );
        DBMS_OUTPUT.PUT_LINE('����� : ' || V_BK_NM );
        DBMS_OUTPUT.PUT_LINE('���ǽ� : ' || V_CRS_RM );
        DBMS_OUTPUT.PUT_LINE('���� ���� ���� : ' || V_ING );
        
        V_NUM := V_NUM+1;
        
        EXIT WHEN V_NUM > V_ROWNUM;
    END LOOP;
END;


--�� ��ü ������ ��ü ���Ǹ�� ��ȸ
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
    V_REG_CD    IN TBL_REG.REG_CD%TYPE   -- ������û �ڵ� 
,   V_OS_CD     IN TBL_OS.OS_CD%TYPE    -- �������� �ڵ� 
,   V_SC_AT     IN TBL_SC.SC_AT%TYPE    -- ��� 
,   V_SC_WT     IN TBL_SC.SC_WT%TYPE    -- �ʱ� 
,   V_SC_PT     IN TBL_SC.SC_PT%TYPE    -- �Ǳ� 
)
IS
    V_SC_CD             TBL_SC.SC_CD%TYPE;      -- ���� �ڵ� 
    V_COUNT_RCD         NUMBER;             -- ����ó���� ������û�ڵ�1
    V_COUNT_OCD         NUMBER;             -- ����ó���� ���������ڵ�1
    V_COUNT_REG         NUMBER;             -- ����ó���� ������û�ڵ�2
    V_COUNT_OS          NUMBER;             -- ����ó���� ���������ڵ�2
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

    -- ��Ȯ���� ���� �ڵ� �Է����� �� 
    IF (V_COUNT_RCD = 1) AND (V_COUNT_OCD = 1)
        THEN
        V_SC_CD := 'SC' || LPAD(SEQ_ST_CODE.NEXTVAL,3,'0'); 
    ELSE RAISE INCORRECT_ERROR;
    END IF;
    
    -- �̹� �Է��� �����϶� 
    IF V_COUNT_REG > 0
        THEN RAISE DUPLICATE_ERROR;
    END IF;
        
    IF V_COUNT_OS > 0
        THEN RAISE DUPLICATE_ERROR;
    END IF;
        
    IF (V_SC_AT + V_SC_WT + V_SC_PT) > 100
            THEN RAISE TOTAL_SC_ERROR;
    END IF;

         -- ���̺� ������ �Է� 
    INSERT INTO TBL_SC(SC_CD, REG_CD, OS_CD, SC_AT, SC_WT, SC_PT)
    VALUES (V_SC_CD, V_REG_CD, V_OS_CD, V_SC_AT, V_SC_WT, V_SC_PT);
        
    DBMS_OUTPUT.PUT_LINE('���� : ' || V_SC_AT + V_SC_WT + V_SC_PT);    
    
    COMMIT;
    
    EXCEPTION
        WHEN INCORRECT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'�������� �ʴ� �������Դϴ�.');
                 ROLLBACK;
        WHEN TOTAL_SC_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'���� ������ ����Ͽ� �Է��Ͽ� �ֽʽÿ�.');
                 ROLLBACK;
        WHEN QUIT_STUDENT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20008,'�ߵ�Ż���� �л��Դϴ�.');
                  ROLLBACK;
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '�̹� �����ϴ� �������Դϴ�.');
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
    V_REG_CD    IN TBL_REG.REG_CD%TYPE          -- ������û �ڵ� 
,   V_OS_CD     IN TBL_OS.OS_CD%TYPE            -- �������� �ڵ� 
,   V_SC_AT     IN TBL_SC.SC_AT%TYPE            -- ��� 
,   V_SC_WT     IN TBL_SC.SC_WT%TYPE            -- �ʱ� 
,   V_SC_PT     IN TBL_SC.SC_PT%TYPE            -- �Ǳ� 
)
IS
    V_SC_CD             TBL_SC.SC_CD%TYPE;      -- ���� �ڵ� 
    V_COUNT_RCD         NUMBER;                 -- ����ó���� ������û�ڵ�1
    V_COUNT_OCD         NUMBER;                 -- ����ó���� ���������ڵ�1
    V_COUNT_REG         NUMBER;                 -- ����ó���� ������û�ڵ�2
    V_COUNT_OS          NUMBER;                 -- ����ó���� ���������ڵ�2
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
    
    -- �ߵ�Ż���� �л��� ��
    SELECT COUNT(*) INTO V_COUNT_QT
    FROM TBL_QT
    WHERE REG_CD = V_REG_CD;
    
    IF V_COUNT_QT > 0
        THEN RAISE QUIT_STUDENT_ERROR;
    END IF;
    
    -- ��Ȯ���� ���� �ڵ� �Է����� �� 
    IF (V_COUNT_RCD = 1) AND (V_COUNT_OCD = 1)
        THEN
        V_SC_CD := 'SC' || LPAD(SEQ_SC_CODE.NEXTVAL,3,'0'); 
    ELSE RAISE INCORRECT_ERROR;
    END IF;
    
    -- �̹� �Է��� �����϶� 
    IF V_COUNT_REG > 0
        THEN RAISE DUPLICATE_ERROR;
    END IF;
        
    IF V_COUNT_OS > 0
        THEN RAISE DUPLICATE_ERROR;
    END IF;    
    
    IF (V_SC_AT + V_SC_WT + V_SC_PT) > 100
            THEN RAISE TOTAL_SC_ERROR;
    END IF;
        
    -- ���̺� ������ �Է� 
    INSERT INTO TBL_SC(SC_CD, REG_CD, OS_CD, SC_AT, SC_WT, SC_PT)
    VALUES (V_SC_CD, V_REG_CD, V_OS_CD, V_SC_AT, V_SC_WT, V_SC_PT);
        
    DBMS_OUTPUT.PUT_LINE('���� : ' || V_SC_AT + V_SC_WT + V_SC_PT);    
    
    COMMIT;
    
    EXCEPTION
        WHEN INCORRECT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'�������� �ʴ� �������Դϴ�.');
                 ROLLBACK;
        WHEN TOTAL_SC_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'���� ������ ����Ͽ� �Է��Ͽ� �ֽʽÿ�.');   
                 ROLLBACK;         
        WHEN QUIT_STUDENT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20008,'�ߵ�Ż���� �л��Դϴ�.');
                 ROLLBACK;
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '�̹� �����ϴ� �������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;