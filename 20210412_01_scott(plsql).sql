SELECT USER
FROM DUAL;


--○ TBL_출고 테이블에서 출고 수량을 변경(수정)하는 프로시저를 작성한다.
--   프로시저 명: PRC_출고_UPDATE(출고번호, 변경할 수량);

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
(   --① 매개변수 구성
    V_출고번호     IN TBL_출고.출고번호%TYPE
,   V_출고수량     IN TBL_출고.출고수량%TYPE
)
IS
    --③ 주요 변수 선언
    V_상품코드        TBL_상품.상품코드%TYPE;
    
    --⑤ 주요 변수 추가 선언
    V_이전출고수량    TBL_출고.출고수량%TYPE;
    
    --⑧ 주요 변수 추가 선언
    V_재고수량        TBL_상품.재고수량%TYPE;
    
    --⑩ 주요 변수(사용자 정의 예외) 추가 선언
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    --④ 상품코드 파악 / ⑥ 이전출고수량 파악 → 변경 이전의 출고 내역 확인
    SELECT 상품코드,출고수량 INTO V_상품코드,V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    --⑦ 출고를 정상적으로 수행해야 하는지의 여부 판단 필요
    --   변경 이전의 출고수량 및 현재의 재고수량 확인
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    --⑨ 파악한 재고수량에 따라 데이터 변경 실시 여부 판단
    --   (『재고수량+이전출고수량 < 현재출고수량』 인 상황이라면 사용자 정의 예외 발생)
    IF ((V_재고수량+V_이전출고수량) < V_출고수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
     
    --② 수행된 쿼리문 체크(UPDATE → TBL_출고 / UPDATE → TBL_상품)
    UPDATE TBL_출고
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;
    
    UPDATE TBL_상품
    SET 재고수량 = V_재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    --11. 커밋
    COMMIT;
    
    --12. 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'재고 부족');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;


SELECT *
FROM TBL_입고;
SELECT *
FROM TBL_상품;
SELECT *
FROM TBL_출고;



--○ TBL_입고 테이블에서 입고수량을 수정(변경)하는 프로시저를 작성한다.
--   프로시저 명 : PRC_입고_UPDATE(입고번호, 변경할입고수량);
CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
(   V입고번호   IN TBL_입고.입고번호%TYPE
,   V입고수량   IN TBL_입고.입고수량%TYPE
)
IS
    V재고수량           TBL_상품.재고수량%TYPE;
    V상품코드           TBL_입고.상품코드%TYPE;
    V기존입고수량       TBL_입고.입고수량%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    SELECT 상품코드,입고수량 INTO V상품코드,V기존입고수량
    FROM TBL_입고
    WHERE 입고번호 = V입고번호;
    
    SELECT 재고수량 INTO V재고수량
    FROM TBL_상품
    WHERE 상품코드 = V상품코드;
   
    IF (V재고수량 - V기존입고수량 + V입고수량) < 0
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE TBL_입고
    SET 입고수량 = V입고수량
    WHERE 입고번호 = V입고번호;
   
    UPDATE TBL_상품
    SET 재고수량 = V재고수량 - V기존입고수량 + V입고수량
    WHERE 상품코드 = V상품코드; 
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003,'재고 부족');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;



--○ TBL_출고 테이블에서 출고수량을 삭제하는 프로시저를 작성한다.
--   프로시저 명 : PRC_출고_DELETE(출고번호)
CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
(   V출고번호 IN TBL_출고.출고번호%TYPE
)
IS
    V출고수량   TBL_출고.출고수량%TYPE;
    V상품코드   TBL_출고.상품코드%TYPE;
    V재고수량   TBL_상품.재고수량%TYPE; 
BEGIN
    SELECT 출고수량,상품코드 INTO V출고수량,V상품코드
    FROM TBL_출고
    WHERE 출고번호 = V출고번호;
    
    SELECT 재고수량 INTO V재고수량
    FROM TBL_상품
    WHERE 상품코드 = V상품코드;
    
    DELETE
    FROM TBL_출고
    WHERE 출고번호 = V출고번호;
    
    UPDATE TBL_상품
    SET 재고수량 = V재고수량 + V출고수량
    WHERE 상품코드 = V상품코드;
    
    COMMIT;
END;
        


--○ TBL_입고 테이블에서 입고수량을 삭제하는 프로시저를 작성한다.
--   프로시저 명 : PRC_입고_DELETE(입고번호)
CREATE OR REPLACE PROCEDURE PRC_입고_DELETE
(   V입고번호 IN TBL_입고.입고번호%TYPE
)
IS
    V상품코드           TBL_상품.상품코드%TYPE;
    V기존입고수량       TBL_입고.입고수량%TYPE;
    V재고수량           TBL_상품.재고수량%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    SELECT 상품코드,입고수량 INTO V상품코드,V기존입고수량
    FROM TBL_입고
    WHERE 입고번호 = V입고번호;
    
    SELECT 재고수량 INTO V재고수량
    FROM TBL_상품
    WHERE 상품코드 = V상품코드;
    
    IF (V재고수량 - V기존입고수량 < 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    DELETE 
    FROM TBL_입고
    WHERE 입고번호 = V입고번호;
    
    UPDATE TBL_상품
    SET 재고수량 = V재고수량 - V기존입고수량
    WHERE 상품코드 = V상품코드;
    
    COMMIT;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
         THEN RAISE_APPLICATION_ERROR(-20004, '입고 내역을 삭제할 수 없습니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;


--------------------------------------------------------------------------------


/*
--■■■ CURSOR (커서) ■■■

1. 오라클에서 하나의 레코드가 아닌 여러 레코드로 구성된
   작업 영역에서 SQL문을 실행하고 그 과정에서 발생한 정보를
   저장하기 위하여 커서(CURSOR)를 사용하며,
   커서에는 암시적 커서와 명시적 커서가 있따.

2. 암시적 커서는 모든 SQL문에 존재하며,
   SQL 실행 후 오직 하나의 행(ROW)만 출력하게 된다.
   그러나 SQL문을 실행한 결과물(RESULT SET)이
   여러 행(ROW)으로 구성된 경우
   커서(CURSOR)를 명시적으로 선언해야 여러 행(ROW)을 다룰 수 있다.
*/


--○ 커서 이용 전 상황
SET SERVEROUTPUT ON;

DECLARE
    VNAME   TBL_INSA.NAME%TYPE;
    VTEL    TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO VNAME, VTEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(VNAME || VTEL);
END;
--==>> 홍길동011-2356-4528


--○ 커서 이용 전 상황(다중 행 접근 시)
DECLARE
    VNAME   TBL_INSA.NAME%TYPE;
    VTEL    TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO VNAME, VTEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(VNAME || VTEL);
END;
--==>> 에러 발생(ORA-01422: exact fetch returns more than requested number of rows)


--○ 커서 이용 전 상황(다중 행 접근 시-반복문 활용하는 경우)
DECLARE
    VNAME   TBL_INSA.NAME%TYPE;
    VTEL    TBL_INSA.TEL%TYPE;
    VNUM    TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO VNAME, VTEL
        FROM TBL_INSA
        WHERE NUM = VNUM;
    
        DBMS_OUTPUT.PUT_LINE(VNAME || VTEL);
        VNUM := VNUM + 1;
        
        EXIT WHEN VNUM >= 1061;
    END LOOP;
END;
/*
홍길동011-2356-4528
이순신010-4758-6532
이순애010-4231-1236
김정훈019-5236-4221
한석봉018-5211-3542
이기자010-3214-5357
장인철011-2345-2525
김영년016-2222-4444
나윤균019-1111-2222
김종서011-3214-5555
유관순010-8888-4422
정한국018-2222-4242
조미숙019-6666-4444
황진이010-3214-5467
이현숙016-2548-3365
이상헌010-4526-1234
엄용수010-3254-2542
이성길018-1333-3333
박문수017-4747-4848
유영희011-9595-8585
홍길남011-9999-7575
이영숙017-5214-5282
김인수
김말자011-5248-7789
우재옥010-4563-2587
김숙남010-2112-5225
김영길019-8523-1478
이남신016-1818-4848
김말숙016-3535-3636
정정해019-6564-6752
지재환019-5552-7511
심심해016-8888-7474
김미나011-2444-4444
이정석011-3697-7412
정영희
이재영011-9999-9999
최석규011-7777-7777
손인수010-6542-7412
고순정010-2587-7895
박세열016-4444-7777
문길수016-4444-5555
채정희011-5125-5511
양미옥016-8548-6547
지수환011-5555-7548
홍원신011-7777-7777
허경운017-3333-3333
산마루018-0505-0505
이기상
이미성010-6654-8854
이미인011-8585-5252
권영미011-5555-7548
권옥경010-3644-5577
김싱식011-7585-7474
정상호016-1919-4242
정한나016-2424-4242
전용재010-7549-8654
이미경016-6542-7546
김신제010-2415-5444
임수봉011-4151-4154
김신애011-4151-4444
*/


--○ 커서 이용
DECLARE
    VNAME   TBL_INSA.NAME%TYPE;
    VTEL    TBL_INSA.TEL%TYPE;
    VNUM    TBL_INSA.NUM%TYPE := 1001;
    
    --커서 이용을 위한 커서변수 선언(→ 커서 정의)
    CURSOR CUR_INSA_SELECT
    IS
    SELECT NAME, TEL
    FROM TBL_INSA;
BEGIN
    --커서 오픈
    OPEN CUR_INSA_SELECT;
    
    --커서 오픈 시 쏟아져나오는 데이터들 처리(잡아내기)
    LOOP
        --한 행 한 행 끄집어내어 가져오는 행위: FETCH
        FETCH CUR_INSA_SELECT INTO VNAME,VTEL;
        
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
        
        --출력
        DBMS_OUTPUT.PUT_LINE(VNAME || VTEL);
    END LOOP;
    
    --커서 클로즈
    CLOSE CUR_INSA_SELECT;
END;
/*
홍길동011-2356-4528
이순신010-4758-6532
이순애010-4231-1236
김정훈019-5236-4221
한석봉018-5211-3542
이기자010-3214-5357
장인철011-2345-2525
김영년016-2222-4444
나윤균019-1111-2222
김종서011-3214-5555
유관순010-8888-4422
정한국018-2222-4242
조미숙019-6666-4444
황진이010-3214-5467
이현숙016-2548-3365
이상헌010-4526-1234
엄용수010-3254-2542
이성길018-1333-3333
박문수017-4747-4848
유영희011-9595-8585
홍길남011-9999-7575
이영숙017-5214-5282
김인수
김말자011-5248-7789
우재옥010-4563-2587
김숙남010-2112-5225
김영길019-8523-1478
이남신016-1818-4848
김말숙016-3535-3636
정정해019-6564-6752
지재환019-5552-7511
심심해016-8888-7474
김미나011-2444-4444
이정석011-3697-7412
정영희
이재영011-9999-9999
최석규011-7777-7777
손인수010-6542-7412
고순정010-2587-7895
박세열016-4444-7777
문길수016-4444-5555
채정희011-5125-5511
양미옥016-8548-6547
지수환011-5555-7548
홍원신011-7777-7777
허경운017-3333-3333
산마루018-0505-0505
이기상
이미성010-6654-8854
이미인011-8585-5252
권영미011-5555-7548
권옥경010-3644-5577
김싱식011-7585-7474
정상호016-1919-4242
정한나016-2424-4242
전용재010-7549-8654
이미경016-6542-7546
김신제010-2415-5444
임수봉011-4151-4154
김신애011-4151-4444
*/


--------------------------------------------------------------------------------


/*
--■■■ TRIGGER (트리거) ■■■

사전적 의미: 방아쇠, 촉발시키다, 야기하다, 유발하다


1. TRIGGER(트리거)란 DML 작업 즉, INSERT, UPDATE, DELETE와 같은 작업이 일어날 때
   자동적으로 실행되는(유발되는, 촉발되는) 객체로
   이와 같은 특징을 강조하여(부각시켜) DML TRIGGER라고 부르기도 한다.
   TRIGGER는 데이터 무결성뿐 아니라 다음과 같은 작업에도 널리 사용된다.
   
   -자동으로 파생된 열 값 생성
   -잘못된 트랜잭션 방지
   -복잡한 보안 권한 강제 수행
   -분산 데이터베이스 노드 상에서 참조 무결성 강제 수행
   -복잡한 업무 규칙 강제 적용
   -투명한 이벤트 로깅 제공
   -복잡한 감사 제공
   -동기 테이블 복제 유지관리
   -테이블 액세스 통계 수집

2. TRIGGER 내에서는 COMMIT, ROLLBACK 문을 사용할 수 없다.

3. 특징 및 종류
   -BEFORE STATEMENT TRIGGER
    : SQL 구문이 실행되기 전에 그 문장에 대해 한 번 실행
   -BEFORE ROW TRIGGER
    : SQL 구문이 실행되기 전에(DML 작업을 수행하기 전에)
      각 행(ROW)에 대해 한 번씩 실행
   -AFTER STATEMENT TRIGGER
    : SQL 구문이 실행된 후 그 문장에 대해 한 번 실행
   -AFTER ROW TRIGGER
    : SQL 구문이 실행된 후에(DML 작업을 수행한 후에)
      각 행(ROW)에 대해 한 번씩 실행

4. 형식 및 구조
    CREATE [OR REPLACE] TRIGGER 트리거명
        [BEFORE] | [AFTER]
        이벤트1 [OR 이벤트2 [OR 이벤트3]] ON 테이블명
        [FOR EACH ROW [WHEN TRIGGER 조건]]
    [DECLARE]
        --선언 구문;
    BEGIN
        --실행 구문;
    END;
*/


--■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■
--※ DML 작업에 대한 이벤트 기록

--○ TRIGGER(트리거) 생성(TRG_EVENTLOG)
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
DECLARE
BEGIN
    --이벤트 종류 구분(조건문을 통한 분기)
    --구분에 대한 키워드
    IF (INSERTING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
             VALUES('INSERT 쿼리문이 수행되었습니다.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
             VALUES('UPDATE 쿼리문이 수행되었습니다.');
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
             VALUES('DELETE 쿼리문이 수행되었습니다.');
    END IF;
    
    --※ TRIGGER 내에서는 COMMIT 구문 사용 금지
END;
--==>> Trigger TRG_EVENTLOG이(가) 컴파일되었습니다.


--■■■ BEFORE STATEMENT TRIGGER 상황 실습 ■■■
--※ DML 작업 수행 전에 작업 가능여부 확인
--   (보안 정책 적용 / 업무 규칙 적용)

--○ TRIGGER(트리거) 작성(TRG_TEST1_DML)
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
    BEFORE
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF (TO_NUMBER(TO_CHAR(SYSDATE,'HH24')) < 8
        OR TO_NUMBER(TO_CHAR(SYSDATE,'HH24')) > 17)
        THEN RAISE_APPLICATION_ERROR(-20003,'작업은 8~18시까지만 가능합니다.');
    END IF;
END;
--==>> 에러 발생(Trigger TRG_TEST1_DML이(가) 컴파일되었습니다.)


--■■■ BEFORE ROW TRIGGER 상황 실습 ■■■
--※ 참조 관계가 설정된 데이터(자식) 삭제를 먼저 수행하는 모델
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE
    BEFORE
    DELETE ON TBL_TEST2
    FOR EACH ROW
DECLARE
BEGIN
    DELETE
    FROM TBL_TEST3
    WHERE CODE = :OLD.CODE;
END;
--==>> Trigger TRG_TEST2_DELETE이(가) 컴파일되었습니다.

--※ :OLD
--   참조 전 열의 값
--   (INSERT: 입력하기 이전 자료, DELETE: 삭제하기 이전 자료-즉, 삭제할 자료)

--※ UPDATE → DELETE 그리고 INSERT가 결합된 상태
--             이 과정에서 UPDATE하기 이전의 자료는 :OLD
--             이 과정에서 UPDATE한   이후의 자료는 :NEW


/*
--■■■ AFTER LOW TRIGGER 상황 실습 ■■■
--※ 참조 테이블 관련 트랜잭션 처리
-- TBL_상품, TBL_입고, TBL_출고
*/


--○ TBL_입고 테이블의 데이터 입력 시(입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량 변동 트리거 작성
CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER
    INSERT ON TBL_입고
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + 새로 입고되는 입고수량
             WHERE 상품코드 = 새로입고되는 상품코드         
    END IF;
END;

CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER
    INSERT ON TBL_입고
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;        
    END IF;
END;
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.


--○ TBL_상품, TBL_입고, TBL_출고의 관계에서
--   입고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--   TRG_IBGO 트리거를 수정한다
CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER
    INSERT ON TBL_입고
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
            SET 재고수량 = 재고수량 + :NEW.입고수량
            WHERE 상품코드 = :NEW.상품코드;
    ELSIF (UPDATING)
        THEN UPDATE TBL_상품
            SET 재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량
            WHERE 상품코드 = :NEW.상품코드;
    ELSIF (DELETING)
        THEN UPDATE TBL_상품
            SET 재고수량 = 재고수량 - :OLD.입고수량
            WHERE 상품코드 = :OLD.상품코드;
    END IF;
END;


--○ TBL_상품, TBL_입고, TBL_출고의 관계에서
--   출고수량, 재고수량의 트랜잭션 처리가 이루어질 수 있도록
--   TRG_CHULGO 트리거를 수정한다
CREATE OR REPLACE TRIGGER TRG_CHULGO
    AFTER
    INSERT ON TBL_출고
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
            SET 재고수량 = 재고수량 - :NEW.출고수량
            WHERE 상품코드 = :NEW.상품코드;
    ELSIF (UPDATING)
        THEN UPDATE TBL_상품
            SET 재고수량 = 재고수량 + :OLD.출고수량 - :NEW.출고수량
            WHERE 상품코드 = :NEW.상품코드;
    ELSIF (DELETING)
        THEN UPDATE TBL_상품
            SET 재고수량 = 재고수량 + :OLD.출고수량
            WHERE 상품코드 = :OLD.상품코드;
    END IF;
END;