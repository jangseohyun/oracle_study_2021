CREATE TABLE TBL_AD --�����ڰ���
( AD_ID 	VARCHAR2(10)
, AD_PW 	VARCHAR2(10)	NOT NULL
, CONSTRAINT AD_ID_PK PRIMARY KEY(AD_ID)
);

CREATE TABLE TBL_QT --�ߵ�Ż��
( QT_CD 	VARCHAR2(10)
, REG_CD 	VARCHAR2(10)	NOT NULL
, QT_DT		DATE		DEFAULT SYSDATE
--, CONSTRAINT QT_CD_PK PRIMARY KEY(QT_CD)
--, CONSTRAINT QT_REG_CD_FK FOREIGN KEY(REG_CD)
--			  REFERENCES TBL_REG(REG_CD)
);

CREATE TABLE TBL_RAT --����
( RAT_CD    VARCHAR2(10)
, RAT_AT    NUMBER(3)       CONSTRAINT RAT_AT_NN NOT NULL
, RAT_WT    NUMBER(3)       CONSTRAINT RAT_WT_NN NOT NULL
, RAT_PT    NUMBER(3)       CONSTRAINT RAT_PT_NN NOT NULL
, CONSTRAINT RAT_CD_PK PRIMARY KEY(RAT_CD)
);

CREATE TABLE TBL_SC --����
( SC_CD     VARCHAR2(10)    
, REG_CD    VARCHAR2(10)    CONSTRAINT SC_REG_CD_NN NOT NULL
, OS_CD     VARCHAR2(10)    CONSTRAINT SC_OS_CD_NN NOT NULL
, SC_AT     NUMBER(3)       CONSTRAINT SC_AT_NN NOT NULL
, SC_WT     NUMBER(3)       CONSTRAINT SC_WT_NN NOT NULL
, SC_PT     NUMBER(3)       CONSTRAINT SC_PT_NN NOT NULL
--, CONSTRAINT SC_CD_PK PRIMARY KEY(SC_CD)
--, CONSTRAINT SC_REG_CD_FK FOREIGN KEY(REG_CD)
--            REFERENCES TBL_REG(REG_CD)
--, CONSTRAINT SC_OS_CD_FK FOREIGN KEY(OS_CD)
--            REFERENCES TBL_OS(OS_CD)
);



--�� ������û ���̺� ����
CREATE TABLE TBL_REG
( REG_CD    VARCHAR2(10)
, ST_ID     VARCHAR2(10)    CONSTRAINT REG_ST_ID_NN NOT NULL
, OC_CD     VARCHAR2(10)    CONSTRAINT REG_OC_CD_NN NOT NULL
, REG_DT    DATE    DEFAULT SYSDATE    
--, CONSTRAINT REG_CD_PK PRIMARY KEY(REG_CD)
--, CONSTRAINT REG_ST_ID_FK  FOREIGN KEY(ST_ID)
--             REFERENCES TBL_ST(ST_ID)
--, CONSTRAINT REG_OC_CD_FK  FOREIGN KEY(OC_CD)
--             REFERENCES TBL_OC(OC_CD)
);



INSERT INTO TBL_AD(AD_ID,AD_PW) VALUES('ADMIN', 'ADMIN');

SELECT *
FROM TBL_AD;

DESC TBL_AD;



SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;

DROP TABLE TBL_AD;
DROP TABLE TBL_QT;



----2021-04-15 20:00


--�� �ߵ�Ż���ڵ� ������ ������ ����
CREATE SEQUENCE SEQ_QUIT
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;


--�� �ߵ�Ż�� �Է� ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_QUIT_INSERT
(   V_REG_CD    IN TBL_QT.REG_CD%TYPE
,   V_QT_DT     IN TBL_QT.QT_DT%TYPE   DEFAULT SYSDATE
)
IS
    V_QT_CD             VARCHAR2(10);
    V_COUNT             NUMBER;
    DUPLICATE_ERROR     EXCEPTION;
BEGIN
    --������û�ڵ� �ߺ� ���� Ȯ��
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_QT
    WHERE REG_CD = V_REG_CD;
    
    --�ߺ��� �ƴ� ��� ������ �Է�
    IF V_COUNT = 0
        THEN
            --�ߵ�Ż���ڵ� ����
            V_QT_CD := 'Q' || LPAD(SEQ_QUIT.NEXTVAL,3,'0');
            
            --TBL_REG ���̺� ������ �Է�
            INSERT INTO TBL_QT(QT_CD,REG_CD) VALUES(V_QT_CD,V_REG_CD);
    --�ߺ��� ��� ���� �߻�
    ELSE RAISE DUPLICATE_ERROR;
    END IF;
    
    --Ŀ��
    COMMIT;
    
    --����ó��
    EXCEPTION
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'�̹� �����ϴ� �������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;


--�� �ߵ�Ż�� ���� ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_QUIT_UPDATE
(   V_REG_CD    IN TBL_QT.REG_CD%TYPE
,   V_QT_DT     IN TBL_QT.QT_DT%TYPE
)
IS
    NONEXIST_ERROR     EXCEPTION;
BEGIN
    --������û�ڵ尡 ��ġ�� ��� ������ ����
    UPDATE TBL_QT
    SET REG_CD = V_REG_CD, QT_DT = V_QT_DT
    WHERE REG_CD = V_REG_CD;
    
    --���� ������û�ڵ尡 ��ġ�ϴ� ���� ���� ��� ���� �߻�
    IF SQL%NOTFOUND
        THEN RAISE NONEXIST_ERROR;
    END IF;
    
    --Ŀ��
    COMMIT;
    
    --����ó��
    EXCEPTION
        WHEN NONEXIST_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'�������� �ʴ� �������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;


--�� �ߵ�Ż�� ���� ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_QUIT_DELETE
(   V_QT_CD    IN TBL_QT.QT_CD%TYPE
)
IS
    NONEXIST_ERROR     EXCEPTION;
BEGIN
    --������û�ڵ尡 ��ġ�� ��� ������ ����
    DELETE
    FROM TBL_QT
    WHERE QT_CD = V_REG_CD;
    
    --���� ������û�ڵ尡 ��ġ�ϴ� ���� ���� ��� ���� �߻�
    IF SQL%NOTFOUND
        THEN RAISE NONEXIST_ERROR;
    END IF;
    
    --Ŀ��
    COMMIT;
    
    --����ó��
    EXCEPTION
        WHEN NONEXIST_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'�������� �ʴ� �������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;


--�� �ߵ�Ż�� ���� ��ȸ ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_QUIT_LOOKUP
(
    V_ST_ID     IN TBL_REG.ST_ID%TYPE
,   V_REG_CD    IN TBL_QT.REG_CD%TYPE
)
IS
    V_COUNT     NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_QT
    WHERE (SELECT ST_ID FROM TBL_REG WHERE REG_CD = V_REG_CD) = V_ST_ID;
    
    IF V_COUNT = 0
        THEN DBMS_OUTPUT.PUT_LINE('�ߵ�Ż�� �л��Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('��ϵ� �л��Դϴ�.');
    END IF;
END;


--------------------------------------------------------------------------------


--�� �������ڵ� ������ ������ ����
CREATE SEQUENCE SEQ_ADMIN
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;


--�� �����ڰ��� �Է� ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_ADMIN_INSERT
(   V_AD_ID     IN TBL_AD.AD_ID%TYPE
,   V_AD_PW     IN TBL_AD.AD_PW%TYPE
)
IS
    V_AD_ID             TBL_AD.AD_ID%TYPE;
    V_COUNT             NUMBER;
    DUPLICATE_ERROR     EXCEPTION;
BEGIN
    --�������ڵ� �ߺ� ���� Ȯ��
    SELECT COUNT(*) INTO V_COUNT
    FROM TBL_AD
    WHERE AD_ID = V_AD_ID;
    
    --�ߺ��� �ƴ� ��� ������ �Է�
    IF V_COUNT = 0
        THEN
            --�������ڵ� ����
            V_AD_ID := 'AD' || LPAD(SEQ_QUIT.NEXTVAL,3,'0');
            
            --TBL_AD ���̺� ������ �Է�
            INSERT INTO TBL_AD(AD_ID,AD_PW) VALUES(V_AD_ID,V_AD_PW);
    --�ߺ��� ��� ���� �߻�
    ELSE RAISE DUPLICATE_ERROR;
    END IF;
    
    --Ŀ��
    COMMIT;
    
    --����ó��
    EXCEPTION
        WHEN DUPLICATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'�̹� �����ϴ� �������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;