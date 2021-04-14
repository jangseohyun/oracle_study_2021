SELECT USER
FROM DUAL;
--==>> SCOTT


--○ 생성한 프로시저(PRC_STUDENTS_UPDATE)가 제대로 작동하는지의 여부 확인
--프로시저 호출
EXEC PRC_INSA_INSERT('한혜림','971006-2234567',SYSDATE,'서울','010-5555-5555','영업부','대리',5000000,500000);
EXEC PRC_INSA_INSERT('박민지','960907-2234567',SYSDATE,'서울','010-6666-6666','기획부','대리',5000000,500000);

SELECT *
FROM TBL_INSA;
/*
1061	한혜림	971006-2234567	21/04/09	서울	010-5555-5555	영업부	대리	5000000	500000
1062	박민지	960907-2234567	21/04/09	서울	010-6666-6666	기획부	대리	5000000	500000
*/


--------------------------------------------------------------------------------


--○ 실습 테이블 생성(TBL_상품)
CREATE TABLE TBL_상품
( 상품코드       VARCHAR2(20)
, 상품명         VARCHAR2(100)
, 소비자가격     NUMBER
, 재고수량       NUMBER DEFAULT 0
, CONSTRAINT 상품_상품코드_PK PRIMARY KEY(상품코드)
);
--==>> Table TBL_상품이(가) 생성되었습니다.


--○ 실습 테이블 생성(TBL_입고)
CREATE TABLE TBL_입고
( 입고번호  NUMBER
, 상품코드  VARCHAR2(20)
, 입고일자  DATE    DEFAULT SYSDATE
, 입고수량  NUMBER
, 입고단가  NUMBER
, CONSTRAINT 입고_입고번호_PK PRIMARY KEY(입고번호)
, CONSTRAINT 입고_상품코드_FK FOREIGN KEY(상품코드)
                                          REFERENCES TBL_상품(상품코드)
);
--==>> Table TBL_입고이(가) 생성되었습니다.
--> TBL_입고 테이블의 입고번호를 기본키(PK) 제약조건 설정
--> TBL_입고 테이블의 상품코드는 TBL_상품 테이블의 상품코드를
--> 참조할 수 있도록 외래키(FK) 제약조건 설정


--○ TBL_상품 테이블에 상품 데이터 입력
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('H001','홈런볼',1500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('H002','새우깡',1200);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('H003','자갈치',1000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('H004','감자깡',900);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('H005','꼬깔콘',1100);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('H006','꼬북칩',2000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('H007','맛동산',1700);
--==>> 1 행 이(가) 삽입되었습니다. * 7

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('C001','다이제',2000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('C002','사브레',1800);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('C003','에이스',1700);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('C004','버터링',1900);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('C005','웨하스',1200);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('C006','웨하스',1200);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('C007','오레오',1900);
--==>> 1 행 이(가) 삽입되었습니다. * 7

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('E001','엠앤엠',600);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('E002','아폴로',500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('E003','쫀드기',300);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('E004','비틀즈',600);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('E005','마이쮸',800);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('E006','에그몽',900);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES('E007','차카니',900);
--==>> 1 행 이(가) 삽입되었습니다. * 7


--○ 커밋
COMMIT;


--○ 생성한 프로시저(PRC_입고_INSERT)가 제대로 작동하는지의 여부 확인
--프로시저 호출
EXEC PRC_입고_INSERT('H001',20,900);

SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	20
SELECT *
FROM TBL_입고;
--==>> 1	H001	21/04/09	20	900


EXEC PRC_입고_INSERT('H001',40,1000);

SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	60
SELECT *
FROM TBL_입고;
/*
1	H001	21/04/09	20	900
2	H001	21/04/09	40	1000
*/


--■■■ 프로시저 내에서의 예외 처리 ■■■

--○ 실습 테이블 생성(TBL_MEMBER)
CREATE TABLE TBL_MEMBER
( NUM   NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CITY  VARCHAR2(60)
, CONSTRAINT MEMBER_NUM_PK PRIMARY KEY(NUM)
);
--==>> Table TBL_MEMBER이(가) 생성되었습니다.


--○ 생성한 프로시저(PRC_MEMBER_INSERT)가 제대로 작동하는지의 여부 확인
--프로시저 호출
EXEC PRC_MEMBER_INSERT('정주희','010-1111-1111','서울');
EXEC PRC_MEMBER_INSERT('소서현','010-2222-2222','경기');
EXEC PRC_MEMBER_INSERT('김아별','010-3333-3333','인천');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_MEMBER_INSERT('이하림','010-4444-4444','부산');
EXEC PRC_MEMBER_INSERT('박민지','010-5555-5555','대전');
--==>> 에러 발생(ORA-20001: 서울,인천,경기만 입력 가능합니다.)

--확인
SELECT *
FROM TBL_MEMBER;
/*
1	정주희	010-1111-1111	서울
2	소서현	010-2222-2222	경기
3	김아별	010-3333-3333	인천
*/


--○ 실습 테이블 생성(TBL_출고)
CREATE TABLE TBL_출고
( 출고번호  NUMBER
, 상품코드  VARCHAR2(20)
, 출고일자  DATE    DEFAULT SYSDATE
, 출고수량  NUMBER
, 출고단가  NUMBER
);
--==>> Table TBL_출고이(가) 생성되었습니다.


--○ TBL_출고 테이블의 출고번호에 PK 제약조건 지정
ALTER TABLE TBL_출고
ADD CONSTRAINT 출고_출고번호_PK PRIMARY KEY(출고번호);
--==>> Table TBL_출고이(가) 변경되었습니다.


--○ TBL_출고 테이블의 상품코드는 TBL_상품 테이블의 상품코드를
--   참조할 수 있도록 외래키(FK) 제약조건 지정
ALTER TABLE TBL_출고
ADD CONSTRAINT 출고_상품코드_FK FOREIGN KEY(상품코드)
                                REFERENCES TBL_상품(상품코드);
--==>> Table TBL_출고이(가) 변경되었습니다.   


--○ 생성한 프로시저(PRC_출고_INSERT)가 제대로 작동하는지의 여부 확인
--프로시저 호출
EXEC PRC_출고_INSERT('H001', 10, 1000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_출고_INSERT('H001', 60, 1000);
--==>> ORA-20002: 출고 수량이 재고 수량보다 많아 출고가 취소됩니다.

--확인
SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	50
SELECT *
FROM TBL_출고;
--==>> 1	H001	21/04/09	10	1000


EXEC PRC_출고_INSERT('H001', 50, 1000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--확인
SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	0
SELECT *
FROM TBL_출고;
/*
1	H001	21/04/09	10	1000
2	H001	21/04/09	50	1000
*/


TRUNCATE TABLE TBL_입고;
TRUNCATE TABLE TBL_출고;

UPDATE TBL_상품
SET 재고수량 = 0;

SELECT *
FROM TBL_상품;
SELECT *
FROM TBL_출고;
SELECT *
FROM TBL_입고;


--○ 입고 이벤트 발생
EXEC PRC_입고_INSERT('H001',20,400);
EXEC PRC_입고_INSERT('H002',30,500);
EXEC PRC_입고_INSERT('H003',40,600);
EXEC PRC_입고_INSERT('H004',50,700);
EXEC PRC_입고_INSERT('H005',60,800);
EXEC PRC_입고_INSERT('H006',70,900);
EXEC PRC_입고_INSERT('H007',80,1000);

EXEC PRC_입고_INSERT('C001',30,800);
EXEC PRC_입고_INSERT('C002',40,900);
EXEC PRC_입고_INSERT('C003',50,1000);
EXEC PRC_입고_INSERT('C004',60,1100);
EXEC PRC_입고_INSERT('C005',70,1200);
EXEC PRC_입고_INSERT('C006',80,1300);
EXEC PRC_입고_INSERT('C007',90,1400);

EXEC PRC_입고_INSERT('E001',80,990);
EXEC PRC_입고_INSERT('E002',70,880);
EXEC PRC_입고_INSERT('E003',60,770);
EXEC PRC_입고_INSERT('E004',50,660);
EXEC PRC_입고_INSERT('E005',40,550);
EXEC PRC_입고_INSERT('E006',30,440);
EXEC PRC_입고_INSERT('E007',20,330);


--○ 출고 이벤트 발생
EXEC PRC_출고_INSERT('H001',1,1100);
EXEC PRC_출고_INSERT('H002',2,1200);
EXEC PRC_출고_INSERT('H003',3,1300);
EXEC PRC_출고_INSERT('H004',4,1400);
EXEC PRC_출고_INSERT('H005',5,1500);
EXEC PRC_출고_INSERT('H006',6,1600);
EXEC PRC_출고_INSERT('H007',7,1700);

EXEC PRC_출고_INSERT('C001',2,1900);
EXEC PRC_출고_INSERT('C002',3,1910);
EXEC PRC_출고_INSERT('C003',4,1920);
EXEC PRC_출고_INSERT('C004',5,1930);
EXEC PRC_출고_INSERT('C005',6,1940);
EXEC PRC_출고_INSERT('C006',7,1950);
EXEC PRC_출고_INSERT('C007',8,1960);


--○ 생성한 프로시저(PRC_출고_INSERT)가 제대로 작동하는지의 여부 확인
--프로시저 호출
EXEC PRC_출고_UPDATE(1,1);