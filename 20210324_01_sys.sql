--○ 현재 오라클 서버에 접속한 자신의 계정 조회

SELECT USER
FROM DUAL;
--==>> SYS

--1줄 주석문 처리(단일행 주석문 처리)

/*
여러줄
(다중행)
주석문
처리
*/

SHOW USER
--==>> USER이(가) "SYS"입니다.
-- SQLPLUS 상태일 때 사용하는 명령어

SELECT USER
FROM DUAL;
--==>>SYS

SELECT 1+2
FROM DUAL;
--==>>3

select 1+2
from dual;
--==>>3

SELECT 1 + 2
FROM DUAL;
--==>>3

SELECT '쌍용강북교육센터F강의실'
FROM DUAL;
--==>>쌍용강북교육센터F강의실

SELECT '아직은 지루한 오라클 수업'
FROM DUAL;
--==>>아직은 지루한 오라클 수업

SELECT 3.14 + 1.36
FROM DUAL;
--==>>4.5

SELECT 1.2345 + 2.3456
FROM DUAL;
--==>>3.5801

SELECT 10 * 5
FROM DUAL;
--==>>50

SELECT 1000 / 23
FROM DUAL;
--==>>43.47826086956521739130434782608695652174

SELECT 100 - 23
FROM DUAL;
--==>>77

SELECT '김아별' + '정주희'
FROM DUAL;
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/


--○ 오라클 서버에 존재하는 사용자 계정 상태 정보 조회

SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
/*
SYS	                OPEN
SYSTEM	            OPEN
ANONYMOUS       	    OPEN
HR	                OPEN
APEX_PUBLIC_USER	    LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED &  LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
*/

SELECT USERNAME, USER_ID, ACCOUNT_STATUS, PASSWORD, LOCK_DATE
FROM DBA_USERS;

SELECT *
FROM DBA_USERS;
--==>> 질의

SELECT USERNAME,USER_ID
FROM DBA_USERS;
--> 『DBA_』로 시작하는 Oracle Data Dictionary View는
--> 오로지 관리자 권한으로 접속했을 경우에만 조회가 가능하다.
--> 아직은 데이터 딕셔너리 개념을 잡지 못해도 상관없다.


--○ 『hr』 사용자 계정을 잠금 상태로 설정

ALTER USER HR ACCOUNT LOCK;
--==>>User HR이(가) 변경되었습니다.


--○ 다시 사용자 계정 정보 조회

SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>HR	    LOCKED


--○ 『hr』 사용자 계정을 잠금 해제 상태로 설정

ALTER USER HR ACCOUNT UNLOCK;
--==>>User HR이(가) 변경되었습니다.


--○ 다시 사용자 계정 정보 조회

SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>HR	    OPEN


---------------------------------------------------


--○ TABLESPACE 생성

--※ TABLESPACE란?
--   세그먼트(테이블, 인덱스, ...)를 담아두는(저장해두는)
--   오라클의 논리적인 저장 구조를 의미한다.

CREATE TABLESPACE TBS_EDUA                 --CREATE 유형(TABLESPACE) 개체명(TBS_EDUA) → 생성
DATAFILE 'C:\TESTORADATA\TBS_EDUA01.DEF'   --물리적으로 연결되는 데이터 파일
SIZE 4M                                    --물리적 데이터 파일의 용량
EXTENT MANAGEMENT LOCAL                    --오라클 서버가 세그먼트를 알아서 관리
SEGMENT SPACE MANAGEMENT AUTO;             --세그먼트 공간 관리도 자동으로 오라클 서버가...

--==>>TABLESPACE TBS_EDUA이(가) 생성되었습니다.

--※ 테이블 스페이스 생성 구문을 실행하기 전에
--   물리적인 경로에 디렉터리(C:\TESTORADATA\) 생성할 것


--○ 생성된 테이블스페이스(TBS_EDUA) 조회

SELECT *
FROM DBA_TABLESPACES;
/*
SYSTEM	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
SYSAUX	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
UNDOTBS1	8192	65536		1	2147483645	2147483645		65536	ONLINE	UNDO	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOGUARANTEE	NO	HOST	NO	
TEMP	8192	1048576	1048576	1		2147483645	0	1048576	ONLINE	TEMPORARY	NOLOGGING	NO	LOCAL	UNIFORM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
USERS	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
*/


--○ 물리적인 파일 이름 조회

SELECT *
FROM DBA_DATA_FILES;
--==>C:\TESTORADATA\TBS_EDUA01.DEF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE


--○ 오라클 사용자 계정 생성

CREATE USER jsh IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--==>>User JSH이(가) 생성되었습니다.

--> jsh 라는 사용자를 만들겠다. (생성하겠다.)
--> 패스워드는 java006$ 로 하겠다.
--> 이 계정을 통해 생성하는 오라클 객체는(세그먼트들은)
--> 기본적으로(DEFAULT) TBS_EDUA 라는 테이블스페이스에 생성할 수 있도록 설정하겠다.


--※ 생성된 오라클 사용자 계정(jsh)을 통해
--   접속을 시도해 보았으나 접속 불가.
--   → 『CREATE SESSION』 권한이 없기 때문에...


--○ 생성된 오라클 사용자 계정(jsh)에
--   서버 접속이 가능할 수 있도록 CREATE SESSION 권한 부여 → sys가...

GRANT CREATE SESSION TO JSH;
--==>>Grant을(를) 성공했습니다.


--○ 생성된 오라클 사용자 계정(JSH)의
--   DEFAULT TABLESPACE 조회

SELECT USERNAME, DEFAULT_TABLESPACE
FROM DBA_USERS;
/*
SYS	                SYSTEM
SYSTEM	            SYSTEM
ANONYMOUS	        SYSAUX
HR	                USERS
JSH	                TBS_EDUA
APEX_PUBLIC_USER    	SYSTEM
FLOWS_FILES	        SYSAUX
APEX_040000	        SYSAUX
OUTLN	            SYSTEM
DIP	                SYSTEM
ORACLE_OCM	        SYSTEM
XS$NULL	            SYSTEM
MDSYS	            SYSAUX
CTXSYS	            SYSAUX
DBSNMP	            SYSAUX
XDB	                SYSAUX
*/


--○ 생성된 오라클 사용자 계정(JSH)의
--   시스템 관련 권한 조회

SELECT *
FROM DBA_SYS_PRIVS;
--==>>JSH	CREATE SESSION	NO
--> ADMIN_OPTION : 부여받은 시스템 권한을 다른 사용자에게 부여할 수 있음(YES일 경우)


--○ 생성된 오라클 사용자 계정(JSH)
--    테이블 생성이 가능할 수 있도록 CREATE TABLE 권한 부여

GRANT CREATE TABLE TO JSH;
--==>>Grant을(를) 성공했습니다.


-- SYS에서 CREATE TABLE TBL_ORAUSERTEST를 실행했을 경우
-- 아래 구문으로 삭제해주어야 함
-- DROP TABLE TBL_ORAUSERTEST PURGE;
--==>>Table TBL_ORAUSERTEST이(가) 삭제되었습니다.


--○ 생성된 오라클 사용자 계정(JSH)에
--   테이블스페이스(TBS_EDUA)에서 사용할 수 있는 공간(할당량)
--   의 크기를 무제한으로 지정.

ALTER USER JSH
QUOTA UNLIMITED ON TBS_EDUA;
--==>>User JSH이(가) 변경되었습니다.