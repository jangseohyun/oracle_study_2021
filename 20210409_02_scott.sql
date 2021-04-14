SELECT USER
FROM DUAL;
--==>> SCOTT


--�� ������ ���ν���(PRC_STUDENTS_UPDATE)�� ����� �۵��ϴ����� ���� Ȯ��
--���ν��� ȣ��
EXEC PRC_INSA_INSERT('������','971006-2234567',SYSDATE,'����','010-5555-5555','������','�븮',5000000,500000);
EXEC PRC_INSA_INSERT('�ڹ���','960907-2234567',SYSDATE,'����','010-6666-6666','��ȹ��','�븮',5000000,500000);

SELECT *
FROM TBL_INSA;
/*
1061	������	971006-2234567	21/04/09	����	010-5555-5555	������	�븮	5000000	500000
1062	�ڹ���	960907-2234567	21/04/09	����	010-6666-6666	��ȹ��	�븮	5000000	500000
*/


--------------------------------------------------------------------------------


--�� �ǽ� ���̺� ����(TBL_��ǰ)
CREATE TABLE TBL_��ǰ
( ��ǰ�ڵ�       VARCHAR2(20)
, ��ǰ��         VARCHAR2(100)
, �Һ��ڰ���     NUMBER
, ������       NUMBER DEFAULT 0
, CONSTRAINT ��ǰ_��ǰ�ڵ�_PK PRIMARY KEY(��ǰ�ڵ�)
);
--==>> Table TBL_��ǰ��(��) �����Ǿ����ϴ�.


--�� �ǽ� ���̺� ����(TBL_�԰�)
CREATE TABLE TBL_�԰�
( �԰��ȣ  NUMBER
, ��ǰ�ڵ�  VARCHAR2(20)
, �԰�����  DATE    DEFAULT SYSDATE
, �԰����  NUMBER
, �԰�ܰ�  NUMBER
, CONSTRAINT �԰�_�԰��ȣ_PK PRIMARY KEY(�԰��ȣ)
, CONSTRAINT �԰�_��ǰ�ڵ�_FK FOREIGN KEY(��ǰ�ڵ�)
                                          REFERENCES TBL_��ǰ(��ǰ�ڵ�)
);
--==>> Table TBL_�԰���(��) �����Ǿ����ϴ�.
--> TBL_�԰� ���̺��� �԰��ȣ�� �⺻Ű(PK) �������� ����
--> TBL_�԰� ���̺��� ��ǰ�ڵ�� TBL_��ǰ ���̺��� ��ǰ�ڵ带
--> ������ �� �ֵ��� �ܷ�Ű(FK) �������� ����


--�� TBL_��ǰ ���̺� ��ǰ ������ �Է�
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('H001','Ȩ����',1500);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('H002','�����',1200);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('H003','�ڰ�ġ',1000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('H004','���ڱ�',900);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('H005','������',1100);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('H006','����Ĩ',2000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('H007','������',1700);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 7

INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('C001','������',2000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('C002','��극',1800);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('C003','���̽�',1700);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('C004','���͸�',1900);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('C005','���Ͻ�',1200);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('C006','���Ͻ�',1200);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('C007','������',1900);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 7

INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('E001','���ؿ�',600);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('E002','������',500);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('E003','�˵��',300);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('E004','��Ʋ��',600);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('E005','������',800);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('E006','���׸�',900);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���)
VALUES('E007','��ī��',900);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 7


--�� Ŀ��
COMMIT;


--�� ������ ���ν���(PRC_�԰�_INSERT)�� ����� �۵��ϴ����� ���� Ȯ��
--���ν��� ȣ��
EXEC PRC_�԰�_INSERT('H001',20,900);

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	20
SELECT *
FROM TBL_�԰�;
--==>> 1	H001	21/04/09	20	900


EXEC PRC_�԰�_INSERT('H001',40,1000);

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	60
SELECT *
FROM TBL_�԰�;
/*
1	H001	21/04/09	20	900
2	H001	21/04/09	40	1000
*/


--���� ���ν��� �������� ���� ó�� ����

--�� �ǽ� ���̺� ����(TBL_MEMBER)
CREATE TABLE TBL_MEMBER
( NUM   NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CITY  VARCHAR2(60)
, CONSTRAINT MEMBER_NUM_PK PRIMARY KEY(NUM)
);
--==>> Table TBL_MEMBER��(��) �����Ǿ����ϴ�.


--�� ������ ���ν���(PRC_MEMBER_INSERT)�� ����� �۵��ϴ����� ���� Ȯ��
--���ν��� ȣ��
EXEC PRC_MEMBER_INSERT('������','010-1111-1111','����');
EXEC PRC_MEMBER_INSERT('�Ҽ���','010-2222-2222','���');
EXEC PRC_MEMBER_INSERT('��ƺ�','010-3333-3333','��õ');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
EXEC PRC_MEMBER_INSERT('���ϸ�','010-4444-4444','�λ�');
EXEC PRC_MEMBER_INSERT('�ڹ���','010-5555-5555','����');
--==>> ���� �߻�(ORA-20001: ����,��õ,��⸸ �Է� �����մϴ�.)

--Ȯ��
SELECT *
FROM TBL_MEMBER;
/*
1	������	010-1111-1111	����
2	�Ҽ���	010-2222-2222	���
3	��ƺ�	010-3333-3333	��õ
*/


--�� �ǽ� ���̺� ����(TBL_���)
CREATE TABLE TBL_���
( ����ȣ  NUMBER
, ��ǰ�ڵ�  VARCHAR2(20)
, �������  DATE    DEFAULT SYSDATE
, ������  NUMBER
, ���ܰ�  NUMBER
);
--==>> Table TBL_�����(��) �����Ǿ����ϴ�.


--�� TBL_��� ���̺��� ����ȣ�� PK �������� ����
ALTER TABLE TBL_���
ADD CONSTRAINT ���_����ȣ_PK PRIMARY KEY(����ȣ);
--==>> Table TBL_�����(��) ����Ǿ����ϴ�.


--�� TBL_��� ���̺��� ��ǰ�ڵ�� TBL_��ǰ ���̺��� ��ǰ�ڵ带
--   ������ �� �ֵ��� �ܷ�Ű(FK) �������� ����
ALTER TABLE TBL_���
ADD CONSTRAINT ���_��ǰ�ڵ�_FK FOREIGN KEY(��ǰ�ڵ�)
                                REFERENCES TBL_��ǰ(��ǰ�ڵ�);
--==>> Table TBL_�����(��) ����Ǿ����ϴ�.   


--�� ������ ���ν���(PRC_���_INSERT)�� ����� �۵��ϴ����� ���� Ȯ��
--���ν��� ȣ��
EXEC PRC_���_INSERT('H001', 10, 1000);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
EXEC PRC_���_INSERT('H001', 60, 1000);
--==>> ORA-20002: ��� ������ ��� �������� ���� ��� ��ҵ˴ϴ�.

--Ȯ��
SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	50
SELECT *
FROM TBL_���;
--==>> 1	H001	21/04/09	10	1000


EXEC PRC_���_INSERT('H001', 50, 1000);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

--Ȯ��
SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	0
SELECT *
FROM TBL_���;
/*
1	H001	21/04/09	10	1000
2	H001	21/04/09	50	1000
*/


TRUNCATE TABLE TBL_�԰�;
TRUNCATE TABLE TBL_���;

UPDATE TBL_��ǰ
SET ������ = 0;

SELECT *
FROM TBL_��ǰ;
SELECT *
FROM TBL_���;
SELECT *
FROM TBL_�԰�;


--�� �԰� �̺�Ʈ �߻�
EXEC PRC_�԰�_INSERT('H001',20,400);
EXEC PRC_�԰�_INSERT('H002',30,500);
EXEC PRC_�԰�_INSERT('H003',40,600);
EXEC PRC_�԰�_INSERT('H004',50,700);
EXEC PRC_�԰�_INSERT('H005',60,800);
EXEC PRC_�԰�_INSERT('H006',70,900);
EXEC PRC_�԰�_INSERT('H007',80,1000);

EXEC PRC_�԰�_INSERT('C001',30,800);
EXEC PRC_�԰�_INSERT('C002',40,900);
EXEC PRC_�԰�_INSERT('C003',50,1000);
EXEC PRC_�԰�_INSERT('C004',60,1100);
EXEC PRC_�԰�_INSERT('C005',70,1200);
EXEC PRC_�԰�_INSERT('C006',80,1300);
EXEC PRC_�԰�_INSERT('C007',90,1400);

EXEC PRC_�԰�_INSERT('E001',80,990);
EXEC PRC_�԰�_INSERT('E002',70,880);
EXEC PRC_�԰�_INSERT('E003',60,770);
EXEC PRC_�԰�_INSERT('E004',50,660);
EXEC PRC_�԰�_INSERT('E005',40,550);
EXEC PRC_�԰�_INSERT('E006',30,440);
EXEC PRC_�԰�_INSERT('E007',20,330);


--�� ��� �̺�Ʈ �߻�
EXEC PRC_���_INSERT('H001',1,1100);
EXEC PRC_���_INSERT('H002',2,1200);
EXEC PRC_���_INSERT('H003',3,1300);
EXEC PRC_���_INSERT('H004',4,1400);
EXEC PRC_���_INSERT('H005',5,1500);
EXEC PRC_���_INSERT('H006',6,1600);
EXEC PRC_���_INSERT('H007',7,1700);

EXEC PRC_���_INSERT('C001',2,1900);
EXEC PRC_���_INSERT('C002',3,1910);
EXEC PRC_���_INSERT('C003',4,1920);
EXEC PRC_���_INSERT('C004',5,1930);
EXEC PRC_���_INSERT('C005',6,1940);
EXEC PRC_���_INSERT('C006',7,1950);
EXEC PRC_���_INSERT('C007',8,1960);


--�� ������ ���ν���(PRC_���_INSERT)�� ����� �۵��ϴ����� ���� Ȯ��
--���ν��� ȣ��
EXEC PRC_���_UPDATE(1,1);