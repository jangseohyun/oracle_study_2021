--○ 과제
--   본인이 태어나서 현재까지
--   얼마만큼의 일, 시간, 분, 초를 살았는지
--   조회하는 쿼리문을 구성한다.
SELECT SYSDATE "현재시간"
     , TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS') "태어난 시간"
     , TRUNC(SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS')) "일"
     , TRUNC(MOD((SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS')),1)*24) "시간"
     , TRUNC(MOD((SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS'))*24,1)*60) "분"
     , TRUNC(MOD((SYSDATE-TO_DATE('1998-07-09 10:49:00','YYYY-MM-DD HH24:MI:SS'))*24*60,1)*60) "초"
FROM DUAL;
--==>> 2021-03-29 16:24:30   1998-07-09 10:49:00   8299   5   35   30
