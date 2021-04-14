SELECT USER
FROM DUAL;
--==>> SCOTT


--�� �⺻ �ݺ���
--   LOOP ~ END LOOP;

/*
1. ���ǰ� ������� ������ �ݺ��ϴ� ����

2. ���� �� ����
   LOOP
        --���๮;
        EXIT WHEN ����;   --������ ���� ��� �ݺ����� ����������.
   END LOOP;
*/


--�� 1���� 10������ �� ��� (LOOP�� Ȱ��)
DECLARE
    N   NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        EXIT WHEN N=10;
        N := N+1;   -- N++; N+=1;
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� WHILE �ݺ���
--   WHILE LOOP ~ END LOOP;

/*
1. ���� ������ TRUE�� ���� �Ϸ��� ������ �ݺ��ϱ� ����
   WHILE LOOP ������ ����Ѵ�.
   ������ �ݺ��� ���۵� �� üũ�ϰ� �Ǿ�
   LOOP ���� ������ �� ���� ������� ���� ��쵵 �ִ�.
   LOOP �� ������ �� ������ FALSE�̸� �ݺ� ������ Ż���ϰ� �ȴ�.
   
2. ���� �� ����
   WHILE ���� LOOP    --������ ���� ��� �ݺ� ����
        --���๮;
   END LOOP;
*/


--�� 1���� 10������ �� ��� (WHILE LOOP�� Ȱ��)
DECLARE
    N   NUMBER := 0;
BEGIN
    WHILE N<10 LOOP
        N := N+1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� FOR �ݺ���
--   FOR LOOP ~ LOOP END;
--   FOR EACH ���� ����

/*
1. ������ �������� 1�� �����Ͽ�
-- ������ ������ �� ������ �ݺ� �����Ѵ�.

2. ���� �� ����
   FOR ī���� IN [REVERSE] ���ۼ� .. ������ LOOP
        -- ���๮;
   END LOOP;
*/


--�� 1���� 10������ �� ��� (FOR LOOP �� Ȱ��)
DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
--   �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� ���� �Է��ϼ���: 2

2 * 1 = 2
...
2 * 9 = 18
*/

--LOOP ��
ACCEPT D PROMPT '���� �Է��ϼ���: ';

DECLARE
    DAN   NUMBER := &D;
    N     NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
        EXIT WHEN N=9;
        N := N + 1;
    END LOOP;
END;

--WHILE LOOP ��
ACCEPT D PROMPT '���� �Է��ϼ���: ';

DECLARE
    DAN   NUMBER := &D;
    N     NUMBER := 1;
BEGIN
    WHILE N<9 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
    END LOOP;
END;

--FOR LOOP ��
ACCEPT D PROMPT '���� �Է��ϼ���: ';

DECLARE
    DAN   NUMBER := &D;
    N     NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
    END LOOP;
END;

/*
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/