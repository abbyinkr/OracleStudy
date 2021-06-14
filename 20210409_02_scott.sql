SELECT USER
FROM DUAL;
--==>> SCOTT

UPDATE 테이블명
SET 수정대상=수정내용
WHERE 조건;

SELECT I.ID, I.PW, S.TEL, S.ADDR
FROM TBL_IDPW I JOIN TBL_STUDENTS S
ON I.ID = S.ID;

UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
        FROM TBL_IDPW I JOIN TBL_STUDENTS S
        ON I.ID = S.ID) T 
SET T.TEL = 입력받은전화번호, T.ADDR = 입력받은 주소
WHERE T.ID = 입력받은아이디 AND T.PW = 입력받은패스워드;


--○ 생성한 프로시저(PRC_STUDENTS_UPDATE)가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출
EXEC PRC_STUDENTS_UPDATE('superman', 'net007$', '010-9999-9999', '경기 일산');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
--> ID 와 PW 가 유효하지 않은 데이터로 테스트 한 결과... 데이터 변경 실패
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	박정준	010-1111-1111	제주도 서귀포시
happyday	김서현	010-2222-2222	서울 마포구
*/
SELECT *
FROM TBL_IDPW;
--==>>
/*
superman	java006$
happyday	java006$
*/

EXEC PRC_STUDENTS_UPDATE('superman', 'java007$', '010-9999-9999', '경기 일산');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
--> ID 와 PW 가 모두 유효한 데이터로 테스트 한 결과 ... 데이터변경 성공


SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	박정준	010-9999-9999	경기 일산
happyday	김서현	010-2222-2222	서울 마포구
*/

SELECT *
FROM TBL_IDPW;
--==>>
/*
superman	java006$
happyday	java006$
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.
SELECT *
FROM TBL_INSA;


--○ 생성한 프로시저(PRC_INSA_INSERT)가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출

-- EXEC 구문은 한 줄로 써야 한다.
EXEC PRC_INSA_INSERT('한혜림', '971006-2234567', SYSDATE, '서울', '010-5555-5555', '영업부', '대리', 5000000, 500000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
SELECT *
FROM TBL_INSA;
--==>> 1061	한혜림	971006-2234567	2021-04-09	서울	010-5555-5555	영업부	대리	5000000	500000

-- EXEC 구문은 한 줄로 써야 한다.
EXEC PRC_INSA_INSERT('박민지', '960907-2234567', SYSDATE, '서울', '010-6666-6666', '기획부', '대리', 5000000, 500000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_INSA;
--==>> 1062	박민지	960907-2234567	2021-04-09	서울	010-6666-6666	기획부	대리	5000000	500000

--------------------------------------------------------------------------------

--○ 실습 테이블 생성(TBL_상품)

CREATE TABLE TBL_상품
( 상품코드      VARCHAR2(20)
, 상품명        VARCHAR2(100)
, 소비자가격    NUMBER
, 재고수량      NUMBER      DEFAULT 0
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
-- TBL_입고 테이블의 입고번호를 기본키(PK) 제약조건 설정
-- TBL 입고 테이블의 상품코드는 TBL_상품 테이블의 상품코드를
-- 참조할 수 있도록 외래키(FK) 제약조건 설정

--○ TBL_상품테이블에 상품데이터 입력

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H001', '홈런볼', 1500);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H002', '새우깡', 1200);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H003', '자갈치', 1000);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H004', '감자깡', 900);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H005', '꼬깔콘',1100);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H006', '꼬북칩', 2000);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H007', '맛동산', 1700);
--==>> 1 행 이(가) 삽입되었습니다. * 7

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('C001', '다이제', 2000);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('C002', '사브레', 1800);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('C003', '에이스', 1700);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('C004', '버터링', 1900);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('C005', '아이비', 1700);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('C006', '웨하스', 1200);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('C007', '오레오', 1900);
--==>> 1 행 이(가) 삽입되었습니다. * 7

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E001', '엠엔엠', 600);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E002', '아폴로', 500);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E003', '쫀드기', 300);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E004', '비틀즈', 600);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E005', '마이쮸', 800);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E006', '에그몽', 900);

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E007', '차카니', 900);
--=>> 1 행 이(가) 삽입되었습니다. * 7

--○ 확인
SELECT *
FROM TBL_상품;
--=>>
/*
H001	홈런볼	1500	0
H002	새우깡	1200	0
H003	자갈치	1000	0
H004	감자깡	900	    0
H005	꼬깔콘	1100	0
H006	꼬북칩	2000	0
H007	맛동산	1700	0
C001	다이제	2000	0
C002	사브레	1800	0
C003	에이스	1700	0
C004	버터링	1900	0
C005	아이비	1700	0
C006	웨하스	1200	0
C007	오레오	1900	0
E001	엠엔엠	600	    0
E002	아폴로	500	    0
E003	쫀드기	300	    0
E004	비틀즈	600	    0
E005	마이쮸	800	    0
E006	에그몽	900	    0
E007	차카니	900	    0
*/

SELECT COUNT(*)
FROM TBL_상품;
--==>> 21

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 생성한 프로시저(PRC_입고_INSERT)가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출
EXEC PRC_입고_INSERT('H001', 20, 900);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ 확인 
SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	20
SELECT *
FROM TBL_입고;
--==>> 2	H001	2021-04-09	20	900

EXEC PRC_입고_INSERT('C007', 10, 1000);

--○ 확인 
SELECT *
FROM TBL_상품;
--==>> C007	오레오	1900	10

SELECT *
FROM TBL_입고;
--==>> 1	C007	2021-04-09	10	1000

EXEC PRC_입고_INSERT('H001', 40, 1000);

--○ 확인 
SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	60

SELECT *
FROM TBL_입고;
--==>> 3	H001	2021-04-09	40	1000


--■■■ 프로시저 내에서의 예외 처리 ■■■--

--○ 테이블 생성(TBL_MEMBER)
CREATE TABLE TBL_MEMBER
( NUM   NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CITY  VARCHAR2(60)
, CONSTRAINT MEMBER_NUM_PK PRIMARY KEY(NUM)
);
--==>> Table TBL_MEMBER이(가) 생성되었습니다.


--○ 생성한 프로시저(PRC_MEMBER_INSERT)가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출

EXEC PRC_MEMBER_INSERT('정주희', '010-1111-1111', '서울');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_MEMBER;
--==>> 1	정주희	010-1111-1111	서울

--○ 생성한 프로시저(PRC_MEMBER_INSERT)가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출
EXEC PRC_MEMBER_INSERT('소서현', '010-2222-2222', '경기');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_MEMBER_INSERT('김아별', '010-3333-3333', '인천');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.


SELECT *
FROM TBL_MEMBER;
--==>>
/*
1	정주희	010-1111-1111	서울
2	소서현	010-2222-2222	경기
3	김아별	010-3333-3333	인천
*/

--○ 생성한 프로시저(PRC_MEMBER_INSERT)가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출
EXEC PRC_MEMBER_INSERT('이하림', '010-4444-4444', '부산');
--==>> 에러 발생
/*
ORA-20001: 서울,인천,경기만 입력 가능합니다.
*/

--○ 생성한 프로시저(PRC_MEMBER_INSERT)가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출
EXEC PRC_MEMBER_INSERT('박민지', '010-5555-5555', '대전');
--==>> 에러 발생
/*
ORA-20001: 서울,인천,경기만 입력 가능합니다.
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

--○ TBL_출고 테이블의 상품코드는 TBL_상품 테이블의 상품코드를 
--   참조할 수 있도록 외래키(FK) 제약 조건 지정

ALTER TABLE TBL_출고
ADD ( CONSTRAINT 출고_출고번호_PK PRIMARY KEY(출고번호)
    , CONSTRAINT 출고_상품코드_FK FOREIGN KEY(상품코드) 
        REFERENCES TBL_상품(상품코드) );
--==>> Table TBL_출고이(가) 변경되었습니다.

--○ 생성한 프로시저(PRC_출고_INSERT)가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출
EXEC PRC_출고_INSERT('H001', 10, 1000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.


SELECT *
FROM TBL_출고;
--==>> 1	H001	2021-04-09	10	1000

SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	50


--○ 생성한 프로시저(PRC_출고_INSERT)가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출
EXEC PRC_출고_INSERT('H001', 60, 1000);
--==>> 에러 발생
/*
ORA-20002: 재고부족~!!!
*/

EXEC PRC_출고_INSERT('H001', 50, 1000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_출고;
--==>>
/*
1	H001	2021-04-09	10	1000
2	H001	2021-04-09	50	1000
*/
SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	0


-- 입고 이벤트 우루루~!!!
EXEC PRC_입고_INSERT('H001', 20, 400);
EXEC PRC_입고_INSERT('H002', 30, 500);
EXEC PRC_입고_INSERT('H003', 40, 600);
EXEC PRC_입고_INSERT('H004', 50, 700);
EXEC PRC_입고_INSERT('H005', 60, 800);
EXEC PRC_입고_INSERT('H006', 70, 900);
EXEC PRC_입고_INSERT('H007', 80, 1000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다. * 7

EXEC PRC_입고_INSERT('C001', 30, 800);
EXEC PRC_입고_INSERT('C002', 40, 900);
EXEC PRC_입고_INSERT('C003', 50, 1000);
EXEC PRC_입고_INSERT('C004', 60, 1100);
EXEC PRC_입고_INSERT('C005', 70, 1200);
EXEC PRC_입고_INSERT('C006', 80, 1300);
EXEC PRC_입고_INSERT('C007', 90, 1400);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다. * 7

EXEC PRC_입고_INSERT('E001', 80, 990);
EXEC PRC_입고_INSERT('E002', 70, 880);
EXEC PRC_입고_INSERT('E003', 60, 770);
EXEC PRC_입고_INSERT('E004', 50, 660);
EXEC PRC_입고_INSERT('E005', 40, 550);
EXEC PRC_입고_INSERT('E006', 30, 440);
EXEC PRC_입고_INSERT('E007', 20, 330);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다. * 7


-- 출고 이벤트 발생
EXEC PRC_출고_INSERT('H001', 1, 1100);
EXEC PRC_출고_INSERT('H002', 2, 1200);
EXEC PRC_출고_INSERT('H003', 3, 1300);
EXEC PRC_출고_INSERT('H004', 4, 1400);
EXEC PRC_출고_INSERT('H005', 5, 1500);
EXEC PRC_출고_INSERT('H006', 6, 1600);
EXEC PRC_출고_INSERT('H007', 7, 1700);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다. * 7

EXEC PRC_출고_INSERT('C001', 2, 1900);
EXEC PRC_출고_INSERT('C002', 3, 1910);
EXEC PRC_출고_INSERT('C003', 4, 1920);
EXEC PRC_출고_INSERT('C004', 5, 1930);
EXEC PRC_출고_INSERT('C005', 6, 1940);
EXEC PRC_출고_INSERT('C006', 7, 1950);
EXEC PRC_출고_INSERT('C007', 8, 1960);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다. * 7

SELECT *
FROM TBL_입고;
SELECT *
FROM TBL_출고;
--==>> 1	H001	2021-04-09	1	1100
SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	19

--○ 생성한 프로시저(PRC_출고_UPDATE)가 제대로 작동하는지의 여부 확인
--   → 프로시저 호출

-- 보유한 재고량 보다 많은 출고량 출고 요청
EXEC PRC_출고_UPDATE(1, 30);
--==>> 에러 발생
/*
ORA-20003: 출고량보다 재고량이 부족합니다.
*/

EXEC PRC_출고_UPDATE(1, 10);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 확인
SELECT *
FROM TBL_출고;
--==>> 1	H001	2021-04-09	10	1100
SELECT *
FROM TBL_상품;
--==>> H001	홈런볼	1500	10
--> 성공~!!

-- 테스트 전으로 복구하기
UPDATE TBL_출고
SET 출고수량 = 1
WHERE 출고번호 = 1;
--==>> 1 행 이(가) 업데이트되었습니다.

UPDATE TBL_상품
SET 재고수량 = 19
WHERE 상품코드 = 'H001';
--==>> 1 행 이(가) 업데이트되었습니다.

--커밋
COMMIT;
--==>> 커밋 완료.

-- 복구 확인
SELECT *
FROM TBL_출고;

SELECT *
FROM TBL_상품;


-- 데이터 초기화
/*
TRUNCATE TABLE TBL_입고;
TRUNCATE TABLE TBL_출고;
UPDATE TBL_상품
SET 재고수량 = 0;

SELECT *
FROM TBL_입고;
SELECT *
FROM TBL_출고;
SELECT *
FROM TBL_상품;
*/

