SET SERVEROUTPUT ON;

SELECT *
FROM TBL_QT;

SELECT *
FROM TBL_REG;

SELECT *
FROM TBL_RAT;

EXEC PRC_QUIT_INSERT('RG001',SYSDATE);
EXEC PRC_QUIT_INSERT('RG002',SYSDATE);

EXEC PRC_QUIT_UPDATE('RG001','21/04/01');
EXEC PRC_QUIT_UPDATE('RG004','21/04/01');

EXEC PRC_QUIT_DELETE('Q003');
EXEC PRC_QUIT_DELETE('Q003');

EXEC PRC_QUIT_LOOKUP('ST001','RG001');

INSERT INTO TBL_REG(REG_CD,ST_ID,OC_CD,REG_DT) VALUES('RG001','ST001','ABC',SYSDATE);

INSERT INTO TBL_RAT(RAT_CD,RAT_AT,RAT_WT,RAT_PT) VALUES('RT001',30,20,50);

SELECT ROWNUM
FROM TBL_QT;

DROP TABLE TBL_QT;
DROP SEQUENCE SEQ_QUIT;

SELECT 9 / 10
FROM DUAL;