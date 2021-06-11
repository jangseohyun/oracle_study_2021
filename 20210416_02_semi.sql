SET SERVEROUTPUT ON;

EXEC PRC_SC_LOOKUP;

SELECT *
FROM VIEW_QT;

SELECT *
FROM TBL_QT;

EXEC PRC_QUIT_UPDATE('RG002','21/04/17');
EXEC PRC_QUIT_UPDATE('RG003','21/04/18');
EXEC PRC_QUIT_UPDATE('RG004','21/04/19');

EXEC PRC_QUIT_LOOKUP_T;
EXEC PRC_QUIT_LOOKUP_T2('Q002');


SELECT SUBSTR('SW����Ʈ����',1,2)
FROM DUAL;
--==> SW

SELECT ASCII(SUBSTR('SW����Ʈ����',1,1)), ASCII(SUBSTR('SW����Ʈ����',2,1))
FROM DUAL;
--==>> 83, 87

SELECT ASCII(SUBSTR('����Ʈ����',1,1)), ASCII(SUBSTR('����Ʈ����',2,1))
FROM DUAL;
--==>> 15500940	15570052


--���񰳼�----------------------------------------------------------------------

UPDATE TBL_OS
SET PR_ID = 'PR002'
WHERE OC_CD = 'A_WB001';

INSERT INTO TBL_OS(OS_CD,OC_CD,SUB_CD,PR_ID,BK_CD,RAT_CD,SUB_BD,SUB_ED)
VALUES('A_J001','A_SW001','J001','PR001','B001','RT001','21/02/01','21/03/01');
INSERT INTO TBL_OS(OS_CD,OC_CD,SUB_CD,PR_ID,BK_CD,RAT_CD,SUB_BD,SUB_ED)
VALUES('A_O001','A_WB001','O001','PR001','B002','RT001','21/07/01','21/08/01');

INSERT INTO TBL_OC(OC_CD,CRS_CD,CRS_BD,CRS_ED,CRS_RM)
VALUES('A_SW001','SW001','21/04/01','21/05/01','F���ǽ�');
INSERT INTO TBL_OC(OC_CD,CRS_CD,CRS_BD,CRS_ED,CRS_RM)
VALUES('A_O001','WB001','21/05/01','21/06/01','E���ǽ�');

INSERT INTO TBL_CRS(CRS_CD,CRS_NM) VALUES('SW001','SW����Ʈ����');
INSERT INTO TBL_CRS(CRS_CD,CRS_NM) VALUES('WB001','WB������');

INSERT INTO TBL_SUB(SUB_CD,SUB_NM) VALUES('J001','�ڹ�');
INSERT INTO TBL_SUB(SUB_CD,SUB_NM) VALUES('O001','����Ŭ');

INSERT INTO TBL_PR(PR_ID,PR_SSN,PR_FN,PR_LN,PR_DT,PR_PW)
VALUES('PR001','121212-121212','KIM','HOJIN','21/01/01','121212');
INSERT INTO TBL_PR(PR_ID,PR_SSN,PR_FN,PR_LN,PR_DT,PR_PW)
VALUES('PR002','111111-222222','HAN','HYERI','21/02/02','222222');

INSERT INTO TBL_BK(BK_CD,BK_NM) VALUES('B001','�ڹ�������');
INSERT INTO TBL_BK(BK_CD,BK_NM) VALUES('B002','����Ŭ������');

SELECT *
FROM VIEW_OS;

SELECT *
FROM TBL_OC;

EXEC PRC_OS_LOOKUP;


--------------------------------------------------------------------------------

SELECT *
FROM TBL_CRS;

DROP TABLE TBL_CRS;
DROP SEQUENCE SEQ_CRS;

EXEC PRC_CRS_INSERT('FE����Ʈ����');
/*
CRS_CD	CRS_NM
FE001	FE����Ʈ����
*/
EXEC PRC_CRS_INSERT('FE����Ʈ����');
--==>> ORA-20001: �̹� �����ϴ� �������Դϴ�.

EXEC PRC_CRS_INSERT('BE�鿣��');
/*
CRS_CD	CRS_NM
BE002	BE�鿣��
FE001	FE����Ʈ����
*/

EXEC PRC_CRS_INSERT('Ǯ����');
--==>> ORA-20007: ��ȿ���� ���� �������Դϴ�.

EXEC PRC_CRS_INSERT('WE');


SELECT ASCII('Ǯ')
FROM DUAL;


EXEC PRC_CRS_INSERT('BE�鿣��');
EXEC PRC_CRS_INSERT('BE�鿣��');

DELETE
FROM TBL_CRS
WHERE CRS_NM = 'Ǯ����';


--------------------------------------------------------------------------------


DROP VIEW VIEW_SC;

SELECT *
FROM TBL_OS;

INSERT INTO TBL_CRS(CRS_CD,CRS_NM) VALUES('SW001','SW����Ʈ����');

INSERT INTO TBL_ST(ST_ID,ST_SSN,ST_FN,ST_LN,ST_DT,ST_PW)
VALUES('ST001','212121-212121','KIM','ABYUL','21/01/01','212121');

INSERT INTO TBL_SC(SC_CD,REG_CD,OS_CD,SC_AT,SC_WT,SC_PT)
VALUES('SC001','RG001','A_J001',30,20,50);


EXEC PRC_SC_LOOKUP;


--------------------------------------------------------------------------------


SELECT *
FROM TBL_PR;

SELECT *
FROM TBL_OS;

SELECT OS_CD
FROM VIEW_OS
WHERE PR_ID = 'PR001' AND NUM = 2;
        
EXEC PRC_PR_LOOKUP('PR001');

SELECT MAX(NUM)
FROM VIEW_PR;


EXEC PRC_PR_LOOKUP_ADMIN;


SELECT TO_NUMBER(SYSDATE-TO_DATE('21/04/20','YY-MM-DD'))
FROM DUAL;


--------------------------------------------------------------------------------

SELECT *
FROM TBL_REG;

SELECT *
FROM TBL_OC;

SELECT MIN(ROWNUM),MAX(ROWNUM)
FROM TBL_REG
WHERE ST_ID = 'ST002';

--�� ���� ����
EXEC PRC_REG_LOOKUP('ST001');
/*
1.
�л��̸� : KIMABYUL
������ : SW����Ʈ����
�������� : �ڹ�
�������� ���� : 100
*/

EXEC PRC_REG_LOOKUP('ST002');
--==> ���� �߻�(ORA-20002: �������� �ʴ� �������Դϴ�.)


--------------------------------------------------------------------------------

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
    
    NOT_FOUND_ERROR     EXCEPTION;
    VCOUNT              NUMBER;
    
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
        
    ELSE RAISE NOT_FOUND_ERROR;
    END IF;
    
    -- Ŀ��
    COMMIT;
    
    EXCEPTION
        WHEN NOT_FOUND_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '�Է��Ͻ� ������ ��ġ�ϴ� �����Ͱ� �����ϴ�.');
            ROLLBACK;
        WHEN OTHERS THEN ROLLBACK;
END;

EXEC PRC_PR_LOOKUP('PR001');


--------------------------------------------------------------------------------

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
    
    NOT_FOUND_ERROR     EXCEPTION;
BEGIN
    SELECT MIN(ROWNUM),MAX(ROWNUM) INTO V_NUM,V_ROWNUM
    FROM TBL_OS
    WHERE PR_ID = V_PR_ID;
    
    IF V_NUM = 0
        THEN RAISE NOT_FOUND_ERROR;
    END IF;

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
    
    EXCEPTION
        WHEN NOT_FOUND_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '�Է��Ͻ� ������ ��ġ�ϴ� �����Ͱ� �����ϴ�.');
END;

CREATE SEQUENCE SEQ_SUB_CODE
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;

CREATE OR REPLACE PROCEDURE PRC_SUB_INSERT
(
   V_SUB_NM    IN  TBL_SUB.SUB_NM%TYPE  
)
IS
    V_SUB_CD                    TBL_SUB.SUB_CD%TYPE;
    V_COUNT                     NUMBER;
    ALREADY_REGISTERED_ERROR    EXCEPTION;
    V_CD_ASCII                  NUMBER;
    CREATE_CODE_ERROR           EXCEPTION;

BEGIN

    --������ �����ڵ��� �ִ��� üũ
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_SUB
    WHERE SUB_CD = V_SUB_CD;
      
    --ù �� ���ڰ� ���ĺ� �빮�� �� �������� Ȯ��
    V_CD_ASCII := TO_NUMBER(ASCII(SUBSTR(V_SUB_NM,1,1)));
    
    IF (V_CD_ASCII >= 65 AND V_CD_ASCII <= 90) AND (V_COUNT = 0)
        THEN
            V_SUB_CD := SUBSTR(V_SUB_NM,1,1) || LPAD(SEQ_SUB_CODE.NEXTVAL,3,'0');
            INSERT INTO TBL_SUB(SUB_CD, SUB_NM) VALUES(V_SUB_CD, V_SUB_NM);
    ELSIF (V_CD_ASCII < 65 OR V_CD_ASCII > 90)
        THEN RAISE CREATE_CODE_ERROR;
    ELSIF (V_COUNT > 0)
        THEN RAISE ALREADY_REGISTERED_ERROR;
    END IF;
    
    COMMIT;
     
    EXCEPTION
        WHEN ALREADY_REGISTERED_ERROR
             THEN RAISE_APPLICATION_ERROR(-20001, '�̹� �����ϴ� �������Դϴ�.');
             ROLLBACK;
        WHEN CREATE_CODE_ERROR
             THEN RAISE_APPLICATION_ERROR(-20004, '������� ���� �빮�ڷ� �Է��ϼ���.');
        WHEN OTHERS
             THEN ROLLBACK;
END;

SELECT *
FROM TBL_OS;

EXEC PRC_OS_INSERT('A_SW001', 'J001', 'PR001', 'B001', 'RT001', '21/02/01', '21/03/16');
EXEC PRC_OS_INSERT('A_SW001', 'O001', 'PR001', 'B002', 'RT001', '21/03/17', '21/04/19');

EXEC PRC_SC_INSERT('RG007', 'A_J001', 30, 16, 46);
EXEC PRC_SC_INSERT('RG002', 'EJ001', 28, 18, 50);

SELECT *
FROM TBL_SC;