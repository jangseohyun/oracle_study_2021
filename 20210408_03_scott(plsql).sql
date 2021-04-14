SELECT USER
FROM DUAL;
--==>> SCOTT


--�� SCOTT.TBL_INSA ���̺��� ���� ���� ������ ���� ���� ������ ����
--   (�ݺ��� Ȱ�� ���)
DECLARE
    VEMP   TBL_INSA%ROWTYPE;
    VNUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL, BUSEO
               INTO VEMP.NAME, VEMP.TEL, VEMP.BUSEO
        FROM TBL_INSA
        WHERE NUM = VNUM;
        
        DBMS_OUTPUT.PUT_LINE(VEMP.NAME || ' - ' || NVL(VEMP.TEL,'             ') || ' - ' || VEMP.BUSEO);
        EXIT WHEN VNUM >= 1060;
        VNUM := VNUM + 1;
    END LOOP;
END;
/*
...
���� - 017-3333-3333 - �ѹ���
�긶�� - 018-0505-0505 - ������
�̱�� -               - ���ߺ�
�̹̼� - 010-6654-8854 - ���ߺ�
...


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


/*
-- ���� FUNCTION(�Լ�) ����

1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
   �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ�ϴ� �� ���ȴ�.
   ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
   ���� ������ �Լ��� ���� �� �ִ�. (�� ����� ���� �Լ�)
   �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
   ���� ���ν���ó�� EXECUTE ���� ���� ������ �� �ִ�.

2. ���� �� ����
   CREATE [OR REPLACE] FUNCTION �Լ���
   [(
      �Ű�����1 �ڷ���
      �Ű�����2 �ڷ���
   )]
   RETURN ������Ÿ��
   IS --(DECLARE)
      --�ֿ� ���� ����(��������)
   BEGIN
      --���๮;
      ...
      RETURN ��;
      
      [EXCEPTION]
         --����ó�� ����;
   END;
   

--�� ����� ���� �Լ�(������ �Լ�)��
     IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
     �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN ���� �����ؾ� �ϰ�,
     FUNCTION�� �ݵ�� ���� ���� ��ȯ�Ѵ�.
*/


--�� TBL_INSA ���̺��� �������
--   �ֹι�ȣ�� ������ ������ ��ȸ�Ѵ�.
SELECT NAME, SSN, DECODE(SUBSTR(SSN,8,1),'1','����','2','����','Ȯ�κҰ�') "����"
FROM TBL_INSA;

--�� FUNCTION ����
--   �Լ���: FN_GENDER()
--   SSN(�ֹε�Ϲ�ȣ) �� 'YYMMDD-NNNNNNN'
CREATE OR REPLACE FUNCTION FN_GENDER
(
    VSSN  VARCHAR2  --�Ű�����: �ڸ���(����) ���� �� ��
)
RETURN VARCHAR2     --��ȯ�ڷ���: �ڸ���(����) ���� �� ��
IS
    --�ֿ� ���� ����
    VRESULT VARCHAR2(20);
BEGIN
    --���� �� ó��
    IF (SUBSTR(VSSN,8,1) IN ('1','3'))
       THEN VRESULT := '����';
    ELSIF (SUBSTR(VSSN,8,1) IN ('2','4'))
       THEN VRESULT := '����';
    ELSE
       VRESULT := '����Ȯ�κҰ�';
    END IF;
    
    --���� ����� ��ȯ
    RETURN VRESULT;
END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.


--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾�
--   A�� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�.
--   �Լ���: FN_POW()
/*
��� ��)
SELECT FN_POW(0,3)
FROM DUAL;
--==>> 1000
*/
--LOOP ��
CREATE OR REPLACE FUNCTION FN_POW
(
    NUM1 NUMBER
  , NUM2 NUMBER
)
RETURN NUMBER
IS
   VRESULT NUMBER;
   N NUMBER;
BEGIN
    VRESULT :=1;
    N := 1;
    
    LOOP 
        VRESULT := VRESULT * NUM1;
        EXIT WHEN N = NUM2;
        N := N+1;
    END LOOP;    
    
    RETURN VRESULT;
END;

/*
--WHILE LOOP ��
BEGIN
    VRESULT :=1;
    N := 1;
    
    WHILE N <= NUM2 LOOP 
        VRESULT := VRESULT * NUM1;
        N := N+1;
    END LOOP;   
*/

/*
--FOR LOOP ��

BEGIN
    VRESULT :=1;
    
    FOR N IN 1 .. NUM2 LOOP         -- 1 ~ 3
        VRESULT := VRESULT * NUM1;  -- 1 * 10 * 10 * 10
    END LOOP;    
    
    RETURN VRESULT;
*/


--�� ����

--�� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
--   �޿��� (�⺻��*12)+���� ������� ������ �����Ѵ�.
--   �Լ���: FN_PAY(�⺻��, ����)
CREATE OR REPLACE FUNCTION FN_PAY
(
    VBP    NUMBER
  , VSU    NUMBER
)
RETURN NUMBER
IS
    VSAL   NUMBER;
BEGIN
    VSAL := (VBP*12)+VSU;
    RETURN VSAL;
END;


--�� TBL_INSA ���̺��� �Ի����� ��������
--   ��������� �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
--   ��, �ٹ������ �Ҽ��� ���� �� �ڸ����� ����Ѵ�.
--   �Լ���: FN_WORKYEAR(�Ի���)
CREATE OR REPLACE FUNCTION FN_WORKYEAR
(
    VDATE   DATE
)
RETURN NUMBER
IS
    VMONTH  NUMBER;
    VYEAR   NUMBER;
BEGIN
    VMONTH := MONTHS_BETWEEN(SYSDATE,VDATE);
    VYEAR := TRUNC((VMONTH/12),1);
    RETURN VYEAR;
END;


/*------------------------------------------------------------------------------

�� ����

1. INSERT, UPDATE, DELETE, (MERGE)
   - DML(Data Manipulation Language)
   - COMMIT / ROLLBACK �� �ʿ��ϴ�.

2. CREATE, DROP, ALTER, (TRUNCATE)
   - DDL(Data Definition Language)
   - �����ϸ� �ڵ����� COMMIT �ȴ�.

3. GRANT, REVOKE
   - DCL(Data Control Language)
   - �����ϸ� �ڵ����� COMMIT �ȴ�.

4. COMMIT, ROLLBACK
   - TCL(Transaction Control Language)
   
- ���� PL/SQL�� �� DML��, TCL���� ��� �����ϴ�.
- ���� PL/SQL�� �� DML��, DDL��, DCL��, TCL�� ��� �����ϴ�.


�� ���� SQL(���� PL/SQL)

- �⺻������ ����ϴ� SQL ������
  PL/SQL ���� �ȿ� SQL ������ ���� �����ϴ� ���.
- �ۼ��� ���� ������ ����.


�� ���� SQL(���� PL/SQL) �� EXECUTE IMMEDIATE
- �ϼ����� ���� SQL ������ �������
  ���� �� ���� ������ ���ڿ� ���� �Ǵ� ���ڿ� ����� ����
  SL ������ �������� �ϼ��Ͽ� �����ϴ� ���.
- ������ ���ǵ��� ���� SQL�� ������ �� �ϼ�/Ȯ���Ͽ� ������ �� �ִ�.
  DML, TCL �ܿ��� DDL, DCL, TCL ����� �����ϴ�.

------------------------------------------------------------------------------*/


/*
--���� PROCEDURE(���ν���) ����

1. PL/SQL���� ���� ��ǥ���� ������ ������ ���ν�����
   �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
   �̸� �ۼ��Ͽ� �����ͺ��̽� ���� �����صξ��ٰ�
   �ʿ��� ������ ȣ���Ͽ� ������ �� �ֵ��� ó�����ִ� �����̴�.

2. ���� �� ����
   CREATE [OR REPLACE] PROCEDURE ���ν�����
   [( �Ű����� IN ������Ÿ��
    , �Ű����� OUT ������Ÿ��
    , �Ű����� INOUT ������Ÿ��
   )]
   IS
      [--�ֿ� ���� ����;]
   BEGIN
      --���� ����;
      ...
      [EXCEPTION
            --���� ó�� ����;]
   END;


--�� FUNCTION�� ������ ��
--   ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--   ��RETURN���� ��ü�� �������� ������,
--   ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������
--   IN, OUT, INOUT ���� ���еȴ�.


3. ����(ȣ��)
   EXEC[UTE] ���ν�����[(�μ�1,�μ�2)];
*/


--�� INSERT ���� ������ ���ν����� �ۼ� (INSERT ���ν���)
-- �ǽ� ���̺� ����(TBL_STUDENTS) �� 20210408_04_scott.sql ���� 
-- �ǽ� ���̺� ����(TBL_IDPW) �� 20210408_04_scott.sql ���� 

-- ���ν��� ����
-- ���ν��� ��: PRC_STUDENTS_INSERT(���̵�, �н�����, �̸�, ��ȭ��ȣ, �ּ�);
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    --TBL_IDPW ���̺� ������ �Է�
    INSERT INTO TBL_IDPW(ID,PW) VALUES(V_ID,V_PW);
    
    --TBL_STUDENTS ���̺� ������ �Է�
    INSERT INTO TBL_STUDENTS(ID,NAME,TEL,ADDR) VALUES(V_ID,V_NAME,V_TEL,V_ADDR);
    
    --Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_INSERT��(��) �����ϵǾ����ϴ�.


--�� �ǽ� ���̺� ����(TBL_SUNGJUK) �� 20210408_04_scott.sql ���� 

--�� ������ �Է� ��
--   Ư�� �׸��� ������(�й�, �̸�, ��������, ��������, ��������)�� �Է��ϸ�
--   ���������� ����, ���, ��� �׸��� �Բ� �Է� ó���� �� �ֵ��� �ϴ�
--   ���ν����� �ۼ��Ѵ�(�����Ѵ�).
--   ���ν�����: PRC_SUNGJUK_INSERT()
/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1,'������',90,80,70);

���ν��� ȣ��� ó���� ���)
�й� �̸�    �������� �������� �������� ���� ��� ���
1    ������  90       80       70        240  80   B
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    --INSERT �������� �����ϴ� �� �ʿ��� �ֿ� ���� ����
    V_TOT     TBL_SUNGJUK.TOT%TYPE;
    V_AVG     TBL_SUNGJUK.AVG%TYPE;
    V_GRADE   TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    --�Ʒ��� ������ ������ ���ؼ���
    --������ �����鿡 ���� ��Ƴ��� �Ѵ�.  (V_TOT, V_AVG, V_GRADE)
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    --INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN,NAME,KOR,ENG,MAT,TOT,AVG,GRADE) VALUES(V_HAKBUN,V_NAME,V_KOR,V_ENG,V_MAT,V_TOT,V_AVG,V_GRADE);
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_SUNGJUK ���̺���
--   Ư�� �л��� ����(�й�, ��������, ��������, ��������)
--   ������ ���� �� ����, ���, ��ޱ��� �����ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� ��: PRC_SUNGJUK_UPDATE
/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(1,50,50,50);

���ν��� ȣ��� ó���� ���)
--==>> 1	������	50	50	50	150	50	F
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAK  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR  IN TBL_SUNGJUK.KOR%TYPE
, V_ENG  IN TBL_SUNGJUK.ENG%TYPE
, V_MAT  IN TBL_SUNGJUK.MAT%TYPE
)
IS
    --UPDATE �������� �����ϴ� �� �ʿ��� �ֿ� ���� ����
    V_TOT     TBL_SUNGJUK.TOT%TYPE;
    V_AVG     TBL_SUNGJUK.AVG%TYPE;
    V_GRADE   TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    --�Ʒ��� ������ ������ ���ؼ���
    --������ �����鿡 ���� ��Ƴ��� �Ѵ�.  (V_TOT, V_AVG, V_GRADE)
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    --UPDATE ������ ����
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT, TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAK;
    
    COMMIT;
END;


--�� TBL_STUDENTS ���̺���
--   ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�) ���ν����� �ۼ��Ѵ�.
--   ��, ID�� PW�� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� �Ѵ�.
--   ���ν��� ��: PRC_STUDENTS_UPDATE
/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('superman','java006$','010-9999-9999','��� �ϻ�');

���ν��� ȣ��� ó���� ���)
superman	������	010-9999-9999	��� �ϻ�
*/
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( VID   IN TBL_IDPW.ID%TYPE
, VPW   IN TBL_IDPW.PW%TYPE
, VTEL  IN TBL_STUDENTS.TEL%TYPE
, VADDR IN TBL_STUDENTS.TEL%TYPE
)
IS
BEGIN
    UPDATE (SELECT T1.ID "ID", T1.PW "PW", T2.TEL "TEL", T2.ADDR "ADDR"
            FROM TBL_IDPW T1, TBL_STUDENTS T2
            WHERE T1.ID = T2.ID) T
    SET T.TEL = VTEL, T.ADDR = VADDR
    WHERE T.ID = VID AND T.PW = VPW;
    
    COMMIT;
END;

/*
--�� �ٸ� ���1
BEGIN
    UPDATE TBL_STUDENTS
    SET TEL = VTEL, ADDR = VADDR
    WHERE VID = ID AND VPW = (SELECT PW
                             FROM TBL_IDPW
                             WHERE VID = ID);

--�� �ٸ� ���2
BEGIN
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
            FROM TBL_IDPW I JOIN TBL_STUDENTS S
            ON I.ID = S.ID) T
    SET T.TEL = VTEL, T.ADDR = VADDR
    WHERE T.ID = VID AND T.PW = VPW;
*/
