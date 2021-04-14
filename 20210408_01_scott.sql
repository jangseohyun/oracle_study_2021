SELECT USER
FROM DUAL;
--==>> SCOTT


--○ 기본 반복문
--   LOOP ~ END LOOP;

/*
1. 조건과 상관없이 무조건 반복하는 구문

2. 형식 및 구조
   LOOP
        --실행문;
        EXIT WHEN 조건;   --조건이 참인 경우 반복문을 빠져나간다.
   END LOOP;
*/


--○ 1부터 10까지의 수 출력 (LOOP문 활용)
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ WHILE 반복문
--   WHILE LOOP ~ END LOOP;

/*
1. 제어 조건이 TRUE인 동안 일련의 문장을 반복하기 위해
   WHILE LOOP 문장을 사용한다.
   조건은 반복이 시작될 때 체크하게 되어
   LOOP 내의 문장이 한 번도 수행되지 않을 경우도 있다.
   LOOP 를 시작할 때 조건이 FALSE이면 반복 문장을 탈출하게 된다.
   
2. 형식 및 구조
   WHILE 조건 LOOP    --조건이 참인 경우 반복 수행
        --실행문;
   END LOOP;
*/


--○ 1부터 10까지의 수 출력 (WHILE LOOP문 활용)
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ FOR 반복문
--   FOR LOOP ~ LOOP END;
--   FOR EACH 문과 유사

/*
1. 『시작 수』에서 1씩 증가하여
-- 『끝냄 수』가 될 때까지 반복 수행한다.

2. 형식 및 구조
   FOR 카운터 IN [REVERSE] 시작수 .. 끝냄수 LOOP
        -- 실행문;
   END LOOP;
*/


--○ 1부터 10까지의 수 출력 (FOR LOOP 문 활용)
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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 사용자로부터 임의의 단(구구단)을 입력받아
--   해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요: 2

2 * 1 = 2
...
2 * 9 = 18
*/

--LOOP 문
ACCEPT D PROMPT '단을 입력하세요: ';

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

--WHILE LOOP 문
ACCEPT D PROMPT '단을 입력하세요: ';

DECLARE
    DAN   NUMBER := &D;
    N     NUMBER := 1;
BEGIN
    WHILE N<9 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
    END LOOP;
END;

--FOR LOOP 문
ACCEPT D PROMPT '단을 입력하세요: ';

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


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/