SELECT USER
FROM DUAL;


--�� TRIGGER�� ���� ��ȸ
SELECT *
FROM USER_TRIGGERS;


--�� ������ ��Ű���� ��ȿ���� Ȯ��(�׽�Ʈ)
--   �� ��Ű���� �������� ������ �Լ� ȣ�� Ȯ��
SELECT INSA_PACK.FN_GENDER('751212-1234567') "ȣ�� Ȯ��"
FROM DUAL;
--==>> ����

SELECT NAME, SSN, INSA_PACK.FN_GENDER(SSN) "ȣ�� Ȯ��"
FROM TBL_INSA;
/*
ȫ�浿	771212-1022432	����
�̼���	801007-1544236	����
�̼���	770922-2312547	����
������	790304-1788896	����
�Ѽ���	811112-1566789	����
*/