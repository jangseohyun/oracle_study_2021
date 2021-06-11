CREATE OR REPLACE PROCEDURE PRC_REG_ST_LOOKUP_ALL
(   V_ST_ID     IN TBL_ST.ST_ID%TYPE
)
IS
    V_REG_CD      TBL_REG.REG_CD%TYPE;
    V_OS_CD       TBL_OS.OS_CD%TYPE;
    V_OC_CD       TBL_OC.OC_CD%TYPE;
    
    V_NUM        NUMBER := 1;
    V_NUM2       NUMBER := 1;
    V_MINNUM     NUMBER; 
    V_MAXNUM     NUMBER;
    V_COUNT      NUMBER;
    V_START_OS   NUMBER;
    V_END_OS     NUMBER;
BEGIN
    SELECT MIN(ROWNUM),MAX(ROWNUM) INTO V_MINNUM,V_MAXNUM
    FROM VIEW_REG_ORDER
    WHERE ST_ID = V_ST_ID;
    
    LOOP
        SELECT REG_CD,OC_CD INTO V_REG_CD,V_OC_CD
        FROM VIEW_REG_ORDER
        WHERE NUM_REG_ORDER = V_MINNUM;
        
        SELECT NUM_OS INTO V_START_OS
        FROM VIEW_OS_ORDER
        WHERE OC_CD = V_OC_CD AND SYSDATE - SUB_ED > 0 AND NUM_OS = V_NUM2;
        
        V_NUM2 := 1;
        
        SELECT COUNT(*) INTO V_COUNT
        FROM VIEW_OS
        WHERE OC_CD = V_OC_CD AND SYSDATE - SUB_ED > 0;
        
        V_END_OS := V_START_OS + V_COUNT - 1;
        
        DBMS_OUTPUT.PUT_LINE(V_MINNUM || '.');
        
        LOOP
            SELECT OS_CD INTO V_OS_CD
            FROM VIEW_OS_ORDER
            WHERE NUM_OS_ORDER = V_NUM2+V_START_O;
            
            DBMS_OUTPUT.PUT_LINE(V_NUM2 || ')');
            DBMS_OUTPUT.PUT_LINE(V_ST_ID|| ', '||V_REG_CD|| ', '||V_OS_CD|| ', '||V_START_OS);
            PRC_REG_ST_LOOKUP(V_ST_ID,V_REG_CD,V_OS_CD,V_START_OS);
            
            V_START_OS := V_START_OS + 1;
            V_NUM2 := V_NUM2 + 1;
            
            EXIT WHEN V_START_OS > V_END_OS;
        END LOOP;
        
        V_MINNUM := V_MINNUM + 1;
        
        EXIT WHEN V_MINNUM > V_MAXNUM;
    END LOOP;
END;