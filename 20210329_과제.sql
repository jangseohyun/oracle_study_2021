--�� ����
--   ������ �¾�� �������
--   �󸶸�ŭ�� ��, �ð�, ��, �ʸ� ��Ҵ���
--   ��ȸ�ϴ� �������� �����Ѵ�.
SELECT SYSDATE "����ð�"
     , TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS') "�¾ �ð�"
     , TRUNC(SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS')) "��"
     , TRUNC(MOD((SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS')),1)*24) "�ð�"
     , TRUNC(MOD((SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS'))*24,1)*60) "��"
     , TRUNC(MOD((SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS'))*24*60,1)*60) "��"
FROM DUAL;
--==>> 2021-03-29 16:24:30   1998-07-09 10:49:00   8299   5   35   30
