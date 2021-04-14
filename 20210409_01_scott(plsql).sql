SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
-- NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
-- ������ ���� �ִ� ��� ���̺� ������ �Է� ��
-- NUM �׸�(�����ȣ)�� ����
-- ���� �ο��� �����ȣ ������ ��ȣ�� �� ���� ��ȣ��
-- �ڵ����� �Է� ó���� �� �ִ� ���ν����� �����Ѵ�.
-- ���ν��� ��: PRC_INSA_INSERT(NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
/*
���� ��)
EXEC PRC_INSA_INSERT('������','971006-2234567',SYSDATE,'����','010-5555-5555',
                      '������','�븮',5000000,500000);

���ν��� ȣ��� ó���� ���)
1061
*/
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( VNAME         IN TBL_INSA.NAME%TYPE
, VSSN          IN TBL_INSA.SSN%TYPE
, VIBSADATE     IN TBL_INSA.IBSADATE%TYPE
, VCITY         IN TBL_INSA.CITY%TYPE
, VTEL          IN TBL_INSA.TEL%TYPE
, VBUSEO        IN TBL_INSA.BUSEO%TYPE
, VJIKWI        IN TBL_INSA.JIKWI%TYPE
, VBASICPAY     IN TBL_INSA.BASICPAY%TYPE
, VSUDANG       IN TBL_INSA.SUDANG%TYPE
)
IS
    --INSERT ������ ���࿡ �ʿ��� ���� �߰� ����
    --�� V_NUM
    VNUM    TBL_INSA.NUM%TYPE;
BEGIN
    --������ ����(V_NUM)�� �� ��Ƴ���
    SELECT MAX(NUM)+1 INTO VNUM
    FROM TBL_INSA;
    
    --INSERT ������ ����
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES (VNUM, VNAME, VSSN, VIBSADATE, VCITY, VTEL, VBUSEO, VJIKWI, VBASICPAY, VSUDANG);
    
    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��ǰ, TBL_�԰� ���̺��� �������
--   TBL_�԰� ���̺� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� �Բ� ������ �� �ִ� ����� ����
--   ���ν����� �ۼ��Ѵ�.
--   ��, �� �������� �԰��ȣ�� �ڵ� ���� ó���Ѵ�. (������ ��� X)
--   TBL_�԰� ���̺� ���� �÷�
--   �� �԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�
--   ���ν��� ��: PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)

--�� TBL_�԰� ���̺� �԰� �̺�Ʈ �߻� �� ���� ���̺��� ����Ǿ�� �ϴ� ����
--   �� INSERT �� TBL_�԰�
--      INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
--      VALUES(1,'H001',SYSDATE,20,900)
--   �� UPDATE �� TBL_��ǰ
--      UPDATE TBL_��ǰ
--      SET ������ = ������ + �԰����(20)
--      WHERE ��ǰ�ڵ� = 'H001';

CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V��ǰ�ڵ�     IN TBL_�԰�.��ǰ�ڵ�%TYPE
, V�԰����     IN TBL_�԰�.�԰����%TYPE
, V�԰�ܰ�     IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    --�Ʒ��� �������� �����ϱ� ���� �ʿ��� ������ ������ ����
    V�԰��ȣ   TBL_�԰�.�԰��ȣ%TYPE;
BEGIN
    SELECT NVL(MAX(�԰��ȣ),0) INTO V�԰��ȣ
    FROM TBL_�԰�;
    
    --������ ����
    --�� INSERT �� TBL_�԰�
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
    VALUES((V�԰��ȣ+1), V��ǰ�ڵ�, SYSDATE, V�԰����, V�԰�ܰ�);
    
    --�� UPDATE �� TBL_��ǰ
    UPDATE TBL_��ǰ
    SET ������ = ������ + V�԰����
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --Ŀ��
    COMMIT;
    
    --����ó��
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
    -- INSERT�� UPDATE �� �ϳ� ó�� �ȵǸ� ROLLBACK �϶�� ����
    -- �� �� �� ó���ؾ���
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.


/*
--�� �ٸ� ���
    SELECT MAX(�԰��ȣ) INTO V�԰��ȣ
    FROM TBL_�԰�;
    
    IF V�԰��ȣ IS NULL THEN V�԰��ȣ := 1;
    END IF;
*/


--���� ���ν��� �������� ���� ó�� ����


--�� TBL_MEMBER ���̺� �����͸� �Է��ϴ� ���ν����� ���� �� 20210409_02_scott.sql ���� ����
--   ��, �� ���ν����� ���� �����͸� �Է��� ���
--   CITY(����) �׸� '����','���','��õ'�� �Է��� �����ϵ��� �����Ѵ�.
--   �� ���� ���� ������ ���ν��� ȣ���� ���� �Է��Ϸ��� ���
--   ����ó���� �Ϸ��� �Ѵ�.
--   ���ν��� ��: PRC_MEMBER_INSERT(�̸�, ��ȭ��ȣ, ����)
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( VNAME    IN TBL_MEMBER.NAME%TYPE
, VTEL     IN TBL_MEMBER.TEL%TYPE
, VCITY    IN TBL_MEMBER.CITY%TYPE
)
IS
    --���� ������ ������ ������ ���� �ʿ��� ������ ���� ����
    VNUM   TBL_MEMBER.NUM%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ����
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    --���ν����� ���� �Է� ó���� ���������� �����ؾ� �� ����������
    --�ƴ����� ���θ� ���� ���� Ȯ���� �� �ֵ��� �ڵ� ����
    IF (VCITY NOT IN ('����','���','��õ'))
        --����, ��õ, ��� �� �ش��ϴ� ���� ���ٸ� ���� �߻�
        --�̶��� �ٷ� ���� ó�� �������� �̵���
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --������ ������ �� ��Ƴ���
    SELECT NVL(MAX(NUM),0) INTO VNUM   -- 0 OR �ִ밪
    FROM TBL_MEMBER;
    
    --������ ����(INSERT)
    INSERT INTO TBL_MEMBER(NUM,NAME,TEL,CITY)
    VALUES((VNUM+1),VNAME,VTEL,VCITY);
    
    --Ŀ��
    COMMIT;
    
    --���� ó��(JAVA������ throws)
    /*
    EXCEPTION
        WHEN �̷� ���ܶ��
            THEN �̷��� ó���ϰ�
                 --RAISE_APPLICATION_ERROR(-�����ڵ�, ����������)
                 --�����ڵ� 1~20000������ ����Ŭ���� �̹� ��� ��
        WHEN ���� ���ܶ��
            THEN ������ ó���ض�
    */
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '����,��õ,��⸸ �Է� �����մϴ�.');
                 ROLLBACK;  --INSERT �������� ���������� ������� �ʵ���
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��� ���̺� ������ �Է� ��(��, ��� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� �����Ǵ� ���ν����� �ۼ��Ѵ�.
--   ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ� ����.
--   ����, ��� ������ ���������� ���� ���
--   ��� �׼��� ����� �� �ֵ��� ó���Ѵ�. (��� �̷������ �ʵ���)
--   ���ν��� ��: PRC_���_INSERT(��ǰ�ڵ�, ������, ���ܰ�)
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V��ǰ�ڵ�     IN TBL_���.��ǰ�ڵ�%TYPE
, V������     IN TBL_���.������%TYPE
, V���ܰ�     IN TBL_���.���ܰ�%TYPE
)
IS
    --�ֿ� ���� ����
    V����ȣ           TBL_���.����ȣ%TYPE;
    V������           TBL_��ǰ.������%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    --������ ���� ������ ���� ���� Ȯ�� �� ���� ��� Ȯ�� �� ��� ������ ��
    SELECT ������ INTO V������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --��� ���������� �������� �������� ���� ���� Ȯ��
    --(�ľ��� ���������� �������� ������ ���� �߻�)
    IF (V������ > V������)
        THEN RAISE USER_DEFINE_ERROR; 
    END IF;
    
    --������ ������ �� ��Ƴ���
    SELECT NVL(MAX(����ȣ),0) INTO V����ȣ
    FROM TBL_���;
    
    --������ ����(INSERT �� TBL_���)
    INSERT INTO TBL_���(����ȣ,��ǰ�ڵ�,������,���ܰ�)
    VALUES((V����ȣ+1),V��ǰ�ڵ�,V������,V���ܰ�);
    
    --������ ����(UPDATE �� TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = ������ - V������
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --Ŀ��
    COMMIT;
    
    --����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '��� ������ ��� �������� ���� ��� ��ҵ˴ϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��� ���̺��� ��� ������ ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� ��: PRC_���_UPDATE(����ȣ, ������ ����);
CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( V����ȣ     IN TBL_���.����ȣ%TYPE
, V�������     IN TBL_���.������%TYPE
)
IS
    V��ǰ�ڵ�           TBL_���.��ǰ�ڵ�%TYPE;
    V����������       TBL_���.������%TYPE;
    V����������       TBL_��ǰ.������%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    SELECT ��ǰ�ڵ�, ������ INTO V��ǰ�ڵ�, V����������
    FROM TBL_���
    WHERE ����ȣ = V����ȣ;
    
    SELECT ������ INTO V����������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    IF (V������� > V���������� + V����������)
        THEN RAISE USER_DEFINE_ERROR; 
    END IF;
    
    UPDATE TBL_���
    SET ������ = V�������
    WHERE ����ȣ = V����ȣ;
    
    UPDATE TBL_��ǰ
    SET ������ = V���������� + V���������� - V�������
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '������ ������ ��� �������� �����ϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_���_UPDATE��(��) �����ϵǾ����ϴ�.