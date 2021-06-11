
--�� PRC_����������ȸ  PRC_REG_LOOKUP

-- �л� �̸�, ������, ��������, �������� ����
CREATE OR REPLACE PROCEDURE PRC_REG_LOOKUP
(
    V_ST_ID     IN TBL_ST.ST_ID%TYPE    -- �л����̵�
,   V_OC_CD     IN TBL_OC.OC_CD%TYPE    -- ���� �ڵ�
)
IS
    V_ST_FN       TBL_ST.ST_FN%TYPE;   -- �л� ��
    V_ST_LN       TBL_ST.ST_LN%TYPE;   -- �л� �̸�
    V_CRS_NM      TBL_CRS.CRS_NM%TYPE; -- ������
    V_SUB_NM      TBL_SUB.SUB_NM%TYPE; -- �����
    V_SC_AT       TBL_SC.SC_AT%TYPE;   -- ���
    V_SC_WT       TBL_SC.SC_WT%TYPE;   -- �ʱ�
    V_SC_PT       TBL_SC.SC_PT%TYPE;   -- �Ǳ�
    
    V_OS_CD       TBL_OS.OS_CD%TYPE;
    V_CRS_CD      TBL_CRS.CRS_CD%TYPE;  -- �����ڵ�
    V_SUB_CD      TBL_SUB.SUB_CD%TYPE;  -- �����ڵ�
    V_REG_CD      TBL_REG.REG_CD%TYPE; -- ������û�ڵ�
    
    V_SC_TOT        NUMBER;             -- �������� ����
    
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
            -- �л��� ��ȸ�Ǵ� �ּ� ��ȣ(ROWNUM)���� �ִ� ��ȣ��
            SELECT MIN(ROWNUM),MAX(ROWNUM) INTO V_MINNUM,V_MAXNUM
            FROM VIEW_REG
            WHERE ST_ID = V_ST_ID AND OC_CD = V_OC_CD;
            
            -- �ش� �л��� ���� ������ ����ٸ�     
            LOOP
                --������û�ڵ�, ���������ڵ�
                SELECT REG_CD INTO V_REG_CD
                FROM VIEW_REG_ORDER
                WHERE ST_ID = V_ST_ID AND OC_CD = V_OC_CD;
                
                -- �л� �̸�
                SELECT ST_FN, ST_LN INTO V_ST_FN, V_ST_LN
                FROM TBL_ST
                WHERE ST_ID = V_ST_ID;
                
                -- �������� - ���������ڵ� / �������� - ���������ڵ� �� �����ڵ�
                SELECT CRS_CD INTO V_CRS_CD
                FROM TBL_OC
                WHERE OC_CD = V_OC_CD;
                
                -- ���� - �����ڵ� / �������� - �����ڵ� �� ������
                SELECT CRS_NM INTO V_CRS_NM
                FROM TBL_CRS
                WHERE CRS_CD = V_CRS_CD;
                
                -- ���񰳼� - ���������ڵ� / �������� - ���������ڵ� �� �����ڵ�
                SELECT OS_CD,SUB_CD INTO V_OS_CD,V_SUB_CD
                FROM VIEW_OS_ORDER
                WHERE OC_CD = V_OC_CD AND NUM_OS = V_NUM AND SYSDATE - SUB_ED > 0;
                
                -- ���� - �����ڵ� / ���񰳼� - �����ڵ� �� �����
                SELECT SUB_NM INTO V_SUB_NM
                FROM TBL_SUB
                WHERE SUB_CD = V_SUB_CD;
                
                -- �����Է� - ������û�ڵ� / �������� - ������û�ڵ� �� ����
                SELECT SC_AT, SC_WT, SC_PT INTO V_SC_AT, V_SC_WT, V_SC_PT
                FROM TBL_SC
                WHERE REG_CD = V_REG_CD AND OS_CD = V_OS_CD;
                
                
                V_SC_TOT := (V_SC_AT + V_SC_WT + V_SC_PT);   --����
                

               -- �ߵ�Ż�� �л� ���� ���� Ȯ��
		        SELECT COUNT(*) INTO Q_COUNT
		        FROM TBL_QT
		        WHERE REG_CD = V_REG_CD;
                
		        IF (Q_COUNT = 0)
                    THEN 
                        -- �л� �̸�, ������, ��������, �������� ����
                        -- �л� ���� ���
                        DBMS_OUTPUT.PUT_LINE('�л��̸� : ' || V_ST_FN || V_ST_LN);
                        DBMS_OUTPUT.PUT_LINE('������ : ' || V_CRS_NM);
                        DBMS_OUTPUT.PUT_LINE('�������� : ' || V_SUB_NM);
                        DBMS_OUTPUT.PUT_LINE('�������� ���� : ' || V_SC_TOT);
		        ELSIF (Q_COUNT > 0)
                    THEN
                        DBMS_OUTPUT.PUT_LINE('�л� �̸� : ' || V_ST_FN || V_ST_LN);
                        DBMS_OUTPUT.PUT_LINE('������ : ' || V_CRS_NM);
                        DBMS_OUTPUT.PUT_LINE('�� �� ������ �ߵ�Ż���� �л��Դϴ�.');
		        END IF;
                
                V_MINNUM := V_MINNUM+1;
                V_NUM := V_NUM + 1;
                
                EXIT WHEN V_MINNUM > V_MAXNUM;
            
            END LOOP;
            
    ELSE RAISE NONEXIST_ERROR;
        
    END IF;
    
    
    -- Ŀ��
    COMMIT;
    
    -- ���� ó��
    EXCEPTION
        WHEN NONEXIST_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '�������� �ʴ� �������Դϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    

END;
--==> Procedure PRC_REG_LOOKUP��(��) �����ϵǾ����ϴ�.



--�� �������� ��ȸ ���ν��� 2 (�������� �������� ��ü�л�)
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
--==> Procedure PRC_AD_REG_LOOKUP��(��) �����ϵǾ����ϴ�.