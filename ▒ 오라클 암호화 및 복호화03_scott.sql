SELECT USER
FROM DUAL;
--==>> SCOTT


--■■■ 작성한 암호화/복호화 패키지 테스트 ■■■--

--○ 실습 테이블 생성
CREATE TABLE TBL_EXAM
( ID    NUMBER
, PW    VARCHAR2(30)
);


--○ 데이터 입력
INSERT INTO TBL_EXAM(ID,PW) VALUES(1, '0611');


--○ 확인
SELECT *
FROM TBL_EXAM;
--==>> 1	0611


--○ 롤백
ROLLBACK;


--○ 암호화/복호화 패키지의 암호화 함수를 활용한 데이터 입력
INSERT INTO TBL_EXAM(ID,PW) VALUES(1,CRYPTPACK.ENCRYPT('0611','SUPERMAN'));


--○ 확인
SELECT *
FROM TBL_EXAM;
--==>> 1	x��@+


--○ 커밋
COMMIT;


SELECT ID, CRYPTPACK.DECRYPT(PW,'batman')
FROM TBL_EXAM;
--==>> 1	x��@+


SELECT ID, CRYPTPACK.DECRYPT(PW,'superman')
FROM TBL_EXAM;
--==>> 1	 0611