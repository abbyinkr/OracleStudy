SELECT USER
FROM DUAL;
--==>> HR

--제약조건
--■■■ CHECK(CK:C) ■■■--

-- 1. 컬럼에서 허용 가능한 데이터의 범위나 조건을 지정하기 위한 제약조건
--    컬럼에 입력되는 데이터를 검사하여 조건에 맞는 데이터만 입력될 수 있도록
--    처리하며, 수정되는 데이터 또한 검사하여 조건에 맞는 데이터로 수정되는 것만
--    허용하는 기능을 수행하게 된다.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] CHECK(컬럼 조건)

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRAINT명 CHECK(컬럼 조건)

--※ NUMBER(38)       까지...
--   CHAR(2000)       까지...
--   VARCHAR2(4000)   까지... ☆ 이거 기억하면 다른 거 추측가능
--   NCHAR(1000)      까지...
--   NVARCHAR2(2000)  까지...

--COL1 NUMBER     → NUMBER(38) 로 쓴거와 같다.
--COL2 CHAR       → CHAR(1)  로 쓴거와 같다.

--○ CK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성

CREATE TABLE TBL_TEST8
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)        CHECK (COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST8이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '가영', 100);
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '혜림', 101); --> 에러 발생
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(3, '서현', -1);  --> 에러 발생
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(4, '정준', 80);

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST8;
--==>>
/*
1	가영	100
4	정준	80
*/

--○ 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
--==>>
/*
HR	SYS_C007122	TBL_TEST8	C	COL3	COL3 BETWEEN 0 AND 100	
HR	SYS_C007123	TBL_TEST8	P	COL1		
*/

--○ CK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST9
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST9이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '가영', 100);
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '혜림', 101); --> 에러 발생
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(3, '서현', -1);  --> 에러 발생
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(4, '정준', 80);

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST9;
--==>>
/*
1	가영	100
4	정준	80
*/

--○ 제약조건 확인

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';
--==>> 
/*
HR	TEST9_COL3_CK	TBL_TEST9	C	COL3	COL3 BETWEEN 0 AND 100	
HR	TEST9_COL1_PK	TBL_TEST9	P	COL1		
*/

--○ CK 지정 실습(③ 테이블 생성 이후 제약조건 추가 → CK 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_TEST10
(COL1 NUMBER(5)
,COL2 VARCHAR2(30)
,COL3 NUMBER(3)
);
--==>> Table TBL_TEST10이(가) 생성되었습니다.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>> 조회 결과 없음

-- 기존 테이블에 제약조건 추가
ALTER TABLE TBL_TEST10
ADD ( CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST10_COL3_CK CHECK (COL3 BETWEEN 0 AND 100)  );
--==>> Table TBL_TEST10이(가) 변경되었습니다.


--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>>
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	COL3 BETWEEN 0 AND 100	
*/

--○ 실습문제 
-- 다음과 같이 TBL_TESTMEMBER 테이블을 생성하여
-- SSN 컬럼(주민번호 컬럼)에서
-- 데이터 입력 시 성별이 유효한 데이터만 입력될 수 있도록
-- 체크 제약조건을 추가할 수 있도록 한다.
-- → 주민번호 특정자리에 입력가능한 데이터로 1,2,3,4 를 적용
-- 또한 SID 컬럼에서는 PRIMARY KEY 제약조건을 설정할 수 있도록 한다.

-- 테이블 생성
CREATE TABLE TBL_TESTMEMBER
( SID  NUMBER
, NAME VARCHAR2(30)
, SSN  CHAR(14)         -- 입력 형태 → 'YYMMDD-NNNNNNN'
, TEL  VARCHAR2(40)
);
--==>> Table TBL_TESTMEMBER이(가) 생성되었습니다.


ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID) 
    , CONSTRAINT TESTMEMBER_SSN_CHECK CHECK(SUBSTR(SSN, 8,1) =ANY('1','2','3','4') ) );
--==>> Table TBL_TESTMEMBER이(가) 변경되었습니다.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';
--==>>
/*
HR	TESTMEMBER_SID_PK	TBL_TESTMEMBER	P	SID		
HR	TESTMEMBER_SSN_CHECK	TBL_TESTMEMBER	C	SSN	SUBSTR(SSN, 8,1) =ANY('1','2','3,','4') 	
*/

-- 데이터 입력 테스트 
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES (1, '소서현', '940718-2234567', '010-1111-1111');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES (2, '박정준', '961031-1234567', '010-2222-2222');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES (3, '안정미', '060125-4234567', '010-3333-3333');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES (4, '한혜림', '071006-3234567', '010-4444-4444');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES (5, '이상화', '071006-5234567', '010-5555-5555');
--==>> 에러 발생
/*
ORA-02290: check constraint (HR.TESTMEMBER_SSN_CHECK) violated
*/

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TESTMEMBER;
--==>>
/*
1	소서현	940718-2234567	010-1111-1111
2	박정준	961031-1234567	010-2222-2222
3	안정미	060125-4234567	010-3333-3333
4	한혜림	071006-3234567	010-4444-4444
*/

--------------------------------------------------------------------------------

--■■■ FOREIGN KEY (FR:F:R) ■■■--

-- 1. 참조 키 또는 외래 키(FK)는
--    두 테이블의 데이터 간 연결을 설정하고
--    강제 적용시키는데 사용되는 열이다.
--    한 테이블의 기본 키 값이 있는 열을
--    다른 테이블에 추가하면 테이블 간 연결을 설정할 수 있다.
--    이 때, 두 번째 테이블에 추가되는 열이 외래 키가 된다.

-- 2. 부모 테이블(참조받는 컬럼이 포함된 테이블)이 먼저 생성된 후
--    자식 테이블(참조하는 컬럼이 포함된 테이블)이 생성되어야 한다.
--    이 때, 자식 테이블에 FOREIGN KEY 제약조건이 설정된다.

-- 3. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명]
--                   REFERENCES 참조테이블명(참조컬럼명)
--                   [ON DELETE CASCADE | ON DELETE SET NULL]

--(| = OR)

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRAINT명 FOREIGN KEY(컬럼명)
--            REFERENCES 참조테이블명(참조컬럼명)
--            [ON DLETE CASCADE | ON DLETE SET NULL]

--※ FOREIGN KEY 제약조건을 설정하는 실습을 진행하기 위해서는
--   독립적인 하나의 테이블을 생성하여 처리하는 것이 아니라
--   부모 테이블 생성 작업을 먼저 수행해야 한다.
--   그리고 이 때, 부모 테이블에는 반드시 PK 또는 UK 제약조건이 
--   설정된 컬럼이 존재해야 한다.

-- 부모 테이블 생성

CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>> Table TBL_JOBS이(가) 생성되었습니다.

-- 생성된 부모 테이블에 데이터 입력
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1, '사원');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2, '대리');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3, '과장');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4, '부장');
--==>> 1 행 이(가) 삽입되었습니다. * 4 

SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
4	부장
*/

COMMIT;
--==>> 커밋 완료

--○ FK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_EMP1
( SID       NUMBER          PRIMARY KEY
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER          REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP1이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007133	TBL_EMP1	P	SID		
HR	SYS_C007134	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

-- 자식 테이블에 데이터 입력
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1, '조은선', 1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2, '김서현', 2);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3, '이상화', 3);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4, '이희주', 4);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '장서현', 5); --> 에러 발생
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '장서현', 1);
INSERT INTO TBL_EMP1(SID, NAME) VALUES(6, '이유림');
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(7, '심혜진', NULL);

SELECT *
FROM TBL_EMP1;
--==>>
/*
1	조은선	1
2	김서현	2
3	이상화	3
4	이희주	4
5	장서현	1
6	이유림	
7	심혜진	
*/

COMMIT;
--==>> 커밋 완료.

--○ FK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_EMP2
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
             REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP2이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
--==>>
/*
HR	EMP2_SID_PK	TBL_EMP2	P	SID		
HR	EMP2_JIKWI_ID_FK	TBL_EMP2	R	JIKWI_ID		NO ACTION
*/


--○ FK 지정 실습(③ 테이블 생성 이후 제약조건 추가 → FK 제약조건 추가)
-- 테이블 생성

CREATE TABLE TBL_EMP3
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==>> Table TBL_EMP3이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> 조회 결과 없음

-- 제약조건 추가

ALTER TABLE TBL_EMP3
ADD ( CONSTRAINT EMP3_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID)  );
--==>> Table TBL_EMP3이(가) 변경되었습니다.

-- 다시 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_SID_PK	TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/


-- 4. FOREIGN KEY 생성시 주의사항
--    참조하고자 하는 부모 테이블을 먼저 생성해야 한다.
--    참조하고자 하는 컬럼이 PRIMARY KEY 나 UNIQUE 제약조건이 있어야 한다.
--    테이블 사이에 PRIMARY KEY 와 FOREIGN KEY 가 정의되어 있으면
--    PRIMARY KEY 제약조건이 설정된 컬럼의 데이터 삭제 시
--    FOREIGN KEY 컬럼에 그 값이 입력되어 있는 경우 삭제되지 않는다.
--    (단, FK 설정 과정에서 『ON DELETE CASCADE』 나
--    『ON DELETE SET NULL』 옵션을 사용하여 설정한 경우에는 삭제가 가능하다.)
--    부모 테이블을 제거하기 위해서는 자식 테이블을 먼저 제거해야 한다.

-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
4	부장
*/

-- 자식 테이블 
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	조은선	1
2	김서현	2
3	이상화	3
4	이희주	4
5	장서현	1
6	이유림	
7	심혜진	
*/

-- 이희주 부장의 직위를 사원으로 변경
UPDATE TBL_EMP1
SET JIKWI_ID = 1
WHERE SID=4;
--==>> 1 행 이(가) 업데이트되었습니다.

-- 확인
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	조은선	1
2	김서현	2
3	이상화	3
4	이희주	1
5	장서현	1
6	이유림	
7	심혜진	
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- 부모 테이블(TBL_JOBS)의 부장 데이터를 참조하고 있는
-- 자식 테이블(TBL_EMP1)의 데이터가 존재하지 않는 상황

-- 이와 같은 상황에서 부모테이블(TBL_JOBS)의 
-- 부장 데이터 삭제

SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 4;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> 1 행 이(가) 삭제되었습니다.

-- 확인
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
*/

--커밋
COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_EMP1;
--==>>
/*
1	조은선	1
2	김서현	2
3	이상화	3
4	이희주	1
5	장서현	1
6	이유림	
7	심혜진	
*/

-- 부모 테이블(TBL_JOBS)의 사원 데이터를 참조하고 있는
-- 자식 테이블(TBL_EMP1)의 데이터가 3건 존재하는 상황.

-- 이와 같은 상황에서 부모 테이블(TBL_JOBS)의
-- 사원 데이터 삭제

SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 1;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 에러 발생
/*
ORA-02292: integrity constraint (HR.SYS_C007134) violated - child record found
*/

-- 부모 테이블(TBL_JOBS) 제거
DROP TABLE TBL_JOBS;
--==>> 에러 발생
/*
ORA-02449: unique/primary keys in table referenced by foreign keys
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";
*/

--※ 참조하고 있는 자식 테이블의 레코드가 존재하는 상황임에도 불구하고
--   부모 테이블의 데이터를 자유롭게 삭제하기 위해서는
--   『ON DELETE CASCADE』 옵션 지정이 필요하다.

-- TBL_EMP1 테이블(자식 테이블)에서 FK 제약조건을 제거한 후 
-- CASCADE 옵션을 포함하여 다시 FK 제약조건을 설정한다.

--○ 제약조건 확인(필수)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007133	TBL_EMP1	P	SID		
HR	SYS_C007134	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

--○ 제약조건 제거
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007134;
--==>> Table TBL_EMP1이(가) 변경되었습니다.

--○ 제약조건 제거 이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>> HR	SYS_C007133	TBL_EMP1	P	SID		

--○ 『ON DELETE CASCADE』 옵션이 포함된 내용으로 제약조건 재 지정 

ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWIID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID)
               ON DELETE CASCADE;
--==>> Table TBL_EMP1이(가) 변경되었습니다.

--○ 제약조건 다시 지정한 이후 재확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007133	TBL_EMP1	P	SID		
HR	EMP1_JIKWIID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE   -- CHECK~!!!
*/

--※ CASCADE 옵션을 지정한 후에는
--   참조받고 있는 부모 테이블의 데이터를
--   언제든지 자유롭게 삭제하는 것이 가능하다.
--   단, ... ... ... ... 부모 테이블의 데이터가 삭제될 경우
--   이를 참조하는 자식 테이블의 데이터도 모두 함께 삭제된다.
--   CHECK~!!! (많은 주의 필요)

-- 부모테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	조은선	1   V
2	김서현	2
3	이상화	3
4	이희주	1   V
5	장서현	1   V
6	이유림	
7	심혜진	
*/ 

--○ TBL_JOBS(부모테이블)의 사원 데이터 삭제
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 1;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 1 행 이(가) 삭제되었습니다.

-- 부모 테이블

SELECT *
FROM TBL_JOBS;
--==>>
/*
2	대리
3	과장
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
2	김서현	2
3	이상화	3
6	이유림	
7	심혜진	
*/

--------------------------------------------------------------------------------

--■■■ NOT NULL(NN:CK:C) ■■■--

-- 1. 테이블에서 지정한 컬럼의 데이터가 NULL 을 갖지 못하도록 하는 제약조건.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTARINT CONSTRAINT명] NOT NULL

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRAINT명 CHECK(컬럼명 IN NOT NULL)

-- 3. 기존에 생성되어 있는 테이블에 NOT NULL 제약조건을 추가할 경우
--    ADD 보다 MODIFY 절이 더 많이 사용된다.

-- ALTER TABLE 테이블명
-- MODIFY 컬럼명 데이터 타입 NOT NULL;

-- 4. 기존 테이블에 데이터가 이미 들어있지 않은 컬럼(→ NULL 인 상태)을
--    NOT NULL 제약조건을 갖게끔 수정하는 경우에는 에러 발생한다.

--○ NOT NULL 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST11
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)     NOT NULL
);
--==>> Table TBL_TEST11이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST11(COL1, COL2) VALUES (1, 'TEST');
INSERT INTO TBL_TEST11(COL1, COL2) VALUES (2, 'ABCD');
INSERT INTO TBL_TEST11(COL1, COL2) VALUES (3, 'NULL');
INSERT INTO TBL_TEST11(COL1, COL2) VALUES (4, NULL);      --> 에러 발생
INSERT INTO TBL_TEST11(COL1) VALUES (5);                  --> 에러 발생

SELECT *
FROM TBL_TEST11;
--==>>
/*
1	TEST
2	ABCD
3	NULL   ← 문자열
*/

COMMIT;
--==>> 커밋 완료.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST11';
--==>>
/*
HR	SYS_C007140	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007141	TBL_TEST11	P	COL1		
*/

--○ NOT NULL 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST12
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST12_COL2_NN CHECK (COL2 IS NOT NULL)
);
--==>> Table TBL_TEST12이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST12';
--==>>
/*
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
*/

--○ NOT NULL 지정 실습(③ 테이블 생성 이후 제약조건 추가 → NN 제약조건 추가)

CREATE TABLE TBL_TEST13
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST13이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> 조회 결과 없음

-- 제약 조건 추가

ALTER TABLE TBL_TEST13
ADD ( CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL) );
--==>> Table TBL_TEST13이(가) 변경되었습니다.

--다시 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>>
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
*/


--※ NOT NULL 제약조건만 추가하는 경우
--   다음과 같은 방법도 가능하다.
--   테이블 생성

CREATE TABLE TBL_TEST14
( COL1 NUMBER(5)
, COL2 VARCHAR(30)
, CONSTRAINT TEST14_COL1_PK PRIMARY KEY(COL1)
);
--==>> Table TBL_TEST14이(가) 생성되었습니다.

-- NOT NULL 제약조건 추가
ALTER TABLE TBL_TEST14
MODIFY COL2 NOT NULL;
--==>> Table TBL_TEST14이(가) 변경되었습니다.

-- NOT NULL 은 컬럼 레벨로 지정하길 권장한다.

--※ 컬럼 레벨에서 NOT NULL 제약조건을 지정한 테이블
DESC TBL_TEST11;
--==>>
/*

Table TBL_TEST11이(가) 생성되었습니다.


1 행 이(가) 삽입되었습니다.


1 행 이(가) 삽입되었습니다.


1 행 이(가) 삽입되었습니다.


명령의 651 행에서 시작하는 중 오류 발생 -
INSERT INTO TBL_TEST11(COL1, COL2) VALUES (4, NULL)
오류 보고 -
ORA-01400: cannot insert NULL into ("HR"."TBL_TEST11"."COL2")


명령의 652 행에서 시작하는 중 오류 발생 -
INSERT INTO TBL_TEST11(COL1) VALUES (5)
오류 보고 -
ORA-01400: cannot insert NULL into ("HR"."TBL_TEST11"."COL2")

커밋 완료.

Table TBL_TEST12이(가) 생성되었습니다.


Table TBL_TEST13이(가) 생성되었습니다.


Table TBL_TEST13이(가) 변경되었습니다.


Table TBL_TEST14이(가) 생성되었습니다.


Table TBL_TEST14이(가) 변경되었습니다.

이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/

--> 컬럼 레벨에서 생성한 경우 DESC 를 통해 COL2 컬럼이 NOT NULL 인 정보가 확인된다.

--※ 테이블 레벨에서 NOT NULL 제약조건을 지정한 테이블
DESC TBL_TEST12;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/

--> DESC 를 통해 COL2 컬럼이 NOT NULL인 정보가 확인되지 않는 상황

-- DESC만 보고 NOT NULL 판단하면 안된다!! ★

--※ 테이블 생성 이후 ADD 를 통해 NOT NULL 제약조건을 추가한 테이블
DESC TBL_TEST13;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 

*/
--> DESC 를 통해 COL2 컬럼이 NOT NULL인 정보가 확인되지 않는 상황

--※ 테이블 생성 이후 MODIFY 를 통해 NOT NULL 제약조건을 추가한 테이블
DESC TBL_TEST14;
--==>>
/*

이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/

