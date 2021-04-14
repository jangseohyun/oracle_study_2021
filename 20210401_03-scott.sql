SELECT USER
FROM DUAL;


--■■■ UNION / UNION ALL ■■■


--○ 실습 테이블 생성(TBL_JUMUN)
CREATE TABLE TBL_JUMUN              --주문 테이블 생성
( JUNO      NUMBER                  --주문 번호
, JECODE    VARCHAR2(30)            --주문된 제품 코드
, JUSU      NUMBER                  --주문 수량
, JUDAY     DATE DEFAULT SYSDATE    --주문 일자
);
--==>> Table TBL_JUMUN이(가) 생성되었습니다.
--> 고객의 주문이 발생했을 경우 주문 내용에 대한 데이터가 입력될 수 있는 테이블


--○ 데이터 입력 → 고객의 주문 발생 / 접수
INSERT INTO TBL_JUMUN VALUES(1, '쫀득초코칩', 20, TO_DATE('2001-11-01 09:05:12', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES(2, '와클', 10, TO_DATE('2001-11-01 09:23:37', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES(3, '꼬북칩', 30, TO_DATE('2001-11-01 11:41:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES(4, '칙촉', 12, TO_DATE('2001-11-02 10:22:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES(5, '홈런볼', 50, TO_DATE('2001-11-03 15:50:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES(6, '바나나킥', 40, TO_DATE('2001-11-04 11:10:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES(7, '눈을감자', 10, TO_DATE('2001-11-10 10:10:10', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES(8, '포카칩', 40, TO_DATE('2001-11-13 09:41:14', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES(9, '감자칩', 20, TO_DATE('2001-11-14 14:20:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES(10, '칸쵸', 20, TO_DATE('2001-11-20 14:17:00', 'YYYY-MM-DD HH24:MI:SS'));
--==>> 1 행 이(가) 삽입되었습니다. * 10


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--○ 확인
SELECT *
FROM TBL_JUMUN;


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 데이터 추가 입력 → 2001년부터 시작된 주문이 현재(2021년)까지 계속 발생
INSERT INTO TBL_JUMUN VALUES(938765, '홈런볼', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(938766, '빈츠', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(938767, '와클', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(938768, '홈런볼', 50, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(938769, '꼬북칩', 30, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(938770, '꼬북칩', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(938771, '꼬북칩', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(938772, '포카칩', 40, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(938773, '포카칩', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(938774, '칸쵸', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(938775, '칸쵸', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(938776, '바나나킥', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_JUMUN;
/*
1	    쫀득초코칩	20	2001-11-01 09:05:12
2	    와클	    10	2001-11-01 09:23:37
3	    꼬북칩	    30	2001-11-01 11:41:00
4	    칙촉	    12	2001-11-02 10:22:00
5	    홈런볼	    50	2001-11-03 15:50:00
6	    바나나킥	40	2001-11-04 11:10:00
7	    눈을감자	10	2001-11-10 10:10:10
8	    포카칩	    40	2001-11-13 09:41:14
9	    감자칩	    20	2001-11-14 14:20:00
10	    칸쵸	    20	2001-11-20 14:17:00
938765	홈런볼	    10	2021-04-01 14:23:28
938766	빈츠	    10	2021-04-01 14:24:18
938767	와클	    10	2021-04-01 14:25:10
938768	홈런볼	    50	2021-04-01 14:25:26
938769	꼬북칩	    30	2021-04-01 14:26:15
938770	꼬북칩	    20	2021-04-01 14:27:11
938771	꼬북칩	    10	2021-04-01 14:27:28
938772	포카칩	    40	2021-04-01 14:27:47
938773	포카칩	    20	2021-04-01 14:28:02
938774	칸쵸	    20	2021-04-01 14:28:31
938775	칸쵸	    10	2021-04-01 14:28:46
938776	바나나킥	10	2021-04-01 14:29:13
*/


--※ 유림이가 2001년도부터 과자 쇼핑몰 운영 중...
--   TBL_JUMUN 테이블이 너무 무거워진 상황
--   어플리케이션과의 연동으로 인해 주문 내역을 다른 테이블에 저장할 수 있도록
--   만드는 것은 힘든 상황
--   기존의 모든 데이터를 덮어놓고 지우는 것도 불가능한 상황
--   → 결과적으로 현재까지 누적된 주문 데이터 중
--      금일 발생한 주문 내역을 제외하고
--      나머지를 다른 테이블(TBL_JUMUNBACKUP)로
--      데이터 이관을 수행할 계획
CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY,'YYYY-MM-DD') != TO_CHAR(SYSDATE,'YYYY-MM-DD');
--==>> Table TBL_JUMUNBACKUP이(가) 생성되었습니다.


--○ 확인
SELECT *
FROM TBL_JUMUNBACKUP;
/*
1	쫀득초코칩	20	2001-11-01 09:05:12
2	와클	    10	2001-11-01 09:23:37
3	꼬북칩	    30	2001-11-01 11:41:00
4	칙촉	    12	2001-11-02 10:22:00
5	홈런볼	    50	2001-11-03 15:50:00
6	바나나킥	40	2001-11-04 11:10:00
7	눈을감자	10	2001-11-10 10:10:10
8	포카칩	    40	2001-11-13 09:41:14
9	감자칩	    20	2001-11-14 14:20:00
10	칸쵸	    20	2001-11-20 14:17:00
*/
--> TBL_JUMUN 테이블의 데이터들 중
--> 아직 발송하지 못한 금일 주문내역 이외의 데이터는
--> 모두 TBL_JUMUNBACKUP 테이블에 백업을 마친 상태 → TBL_JUMUN에서는 삭제

DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY,'YYYY-MM-DD') != TO_CHAR(SYSDATE,'YYYY-MM-DD');
--==>> 10개 행 이(가) 삭제되었습니다. (938764건의 데이터 삭제)


--○ 확인
SELECT *
FROM TBL_JUMUN;
/*
938765	홈런볼	    10	2021-04-01 14:23:28
938766	빈츠	    10	2021-04-01 14:24:18
938767	와클	    10	2021-04-01 14:25:10
938768	홈런볼	    50	2021-04-01 14:25:26
938769	꼬북칩	    30	2021-04-01 14:26:15
938770	꼬북칩	    20	2021-04-01 14:27:11
938771	꼬북칩	    10	2021-04-01 14:27:28
938772	포카칩	    40	2021-04-01 14:27:47
938773	포카칩	    20	2021-04-01 14:28:02
938774	칸쵸	    20	2021-04-01 14:28:31
938775	칸쵸	    10	2021-04-01 14:28:46
938776	바나나킥	10	2021-04-01 14:29:13
*/
--> 아직 제품 발송이 완료되지 않은 금일 주문 데이터를 제외하고
--> 이전의 모든 주문 데이터들이 삭제된 상황이므로
--> 테이블 행(레코드)의 개수가 줄어들어 매우 가벼워진 상황


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--그런데 지금까지 주문받은 내역에 대한 정보를
--제품별 총 주문량으로 나타내야 할 상황이 발생하게 되었다.
--그렇다면 TBL_JUMUNBACKUP 테이블의 레코드(행)와
--TBL_JUMUN 테이블의 레코드(행)를 합쳐서
--하나의 테이블을 조회하는 것과 같은
--결과를 확인할 수 있도록 조회해야 한다.

--컬럼과 컬럼의 관계를 고려하여 테이블을 결합하고자 하는 경우 JOIN을 사용하지만
--레코드(행)와 레코드(행)를 결합하고자 하는 경우 UNION / UNION ALL을 사용할 수 있다.

SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;


SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;

--※ UNION: 결과물의 첫 번째 컬럼 기준 자동 오름차순 정렬,
--          중복 레코드(행) 제거 후 1개 행만 반환
--   UNION ALL: 결합 순서대로 조회한 결과 반환 (정렬 없음)
--   이로 인해 UNION의 부하가 더 크다.


--○ 지금까지 주문받은 모든 데이터를 통해
--   제품별 총 주문량을 조회하는 쿼리문을 구성한다.
/*
   제품코드   총 주문량
    ...           XX
    .....        XXX
    ....         XXX 
*/

SELECT JECODE "제품코드", SUM(JUSU) "총 주문량"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
    UNION ALL
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
)T
GROUP BY T.JECODE;
/*
꼬북칩	     90
쫀득초코칩	 20
와클	         20
포카칩	    100
칙촉	         12
바나나킥    	 50
눈을감자	     10
홈런볼	    110
빈츠	     10
감자칩	     20
칸쵸	         50
*/

--UNION을 쓸 경우 조회하는 과정에서 중복 레코드가 제거되어 총 주문량에 차이가 발생한다.
SELECT JECODE "제품코드", SUM(JUSU) "총 주문량"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
    UNION
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
)T
GROUP BY T.JECODE;
/*
꼬북칩	    60
쫀득초코칩	20
와클	        10
칙촉	        12
포카칩	    60
눈을감자	    10
바나나킥    	50
감자칩	    20
빈츠	    10
홈런볼	    60
칸쵸      	30
*/
--> 따라서 이 문제를 해결하는 과정에서는 UNION을 사용해서는 안 된다.


--○ INTERSECT (교집합) / MINUS (차집합)

--TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블에서
--제품코드와 주문량의 값이 똑같은 행만 추출하고자 한다.
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
/*
꼬북칩	30
와클	    10
칸쵸	    20
포카칩	40
홈런볼	50
*/


--○ TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블에서
--   제품코드와 주문량의 값이 똑같은 행의 정보를
--   주문번호, 제품코드, 주문수량, 주문일자 항목으로 조회한다.

--가로
SELECT JB.*, J.*
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
)T
    JOIN TBL_JUMUNBACKUP JB
    ON JB.JECODE = T.JECODE AND JB.JUSU = T.JUSU
    JOIN TBL_JUMUN J
    ON J.JECODE = T.JECODE AND J.JUSU = T.JUSU
ORDER BY 3;

--세로
SELECT T1.JUNO, T1.JECODE, T1.JUSU, T1.JUDAY
FROM 
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
) T1
JOIN
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T2
ON T1.JECODE = T2.JECODE
WHERE T1.JUSU = T2.JUSU
ORDER BY 3,1;