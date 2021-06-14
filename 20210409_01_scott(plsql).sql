SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다.
-- 출력할게 없으면 안해줘도 됨..

--○ TBL_STUDENTS 테이블에서
--   전화번호와 주소 데이터를 수정하는(변경하는) 프로시저를 작성한다.
--   단, ID와 PW 가 일치하는 경우에만 수정을 진행할 수 있도록 한다.
--   프로시저 명 : PRC_STUDENTS_UPDATE
/*
실행 예)
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-9999-9999', '경기 일산');

프로시저 호출로 처리된 결과)
superman    박정준 010-9999-9999   경기 일산

*/

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(
 V_ID   IN  TBL_STUDENTS.ID%TYPE
,V_PW   IN  TBL_IDPW.PW%TYPE
,V_TEL  IN  TBL_STUDENTS.TEL%TYPE
,V_ADDR IN  TBL_STUDENTS.ADDR%TYPE
)
IS

BEGIN
    -- update 쿼리문 구성
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND V_PW = ( SELECT PW
                                 FROM TBL_IDPW
                                 WHERE ID = V_ID);
    COMMIT;

END;
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.

EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-9999-9999', '경기 일산');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_STUDENTS;


--[선생님 풀이]


CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(
 V_ID   IN  TBL_STUDENTS.ID%TYPE
,V_PW   IN  TBL_IDPW.PW%TYPE
,V_TEL  IN  TBL_STUDENTS.TEL%TYPE
,V_ADDR IN  TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- UPDATE 쿼리문 구성
    /*
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
        FROM TBL_IDPW I JOIN TBL_STUDENTS S
        ON I.ID = S.ID) T 
    SET T.TEL = 입력받은전화번호, T.ADDR = 입력받은 주소
    WHERE T.ID = 입력받은아이디 AND T.PW = 입력받은패스워드;
    */
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
        FROM TBL_IDPW I JOIN TBL_STUDENTS S
        ON I.ID = S.ID) T 
    SET T.TEL = V_TEL, T.ADDR = V_ADDR
    WHERE T.ID = V_ID AND T.PW = V_PW;
    
    -- 커밋
    COMMIT;

END;
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.

--○ TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다.
--   NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--   구조를 갖고 있는 대상 테이블에 데이터 입력 시
--   NUM 항목(사원번호)의 값은
--   기존 부여된 사원번호 마지막 번호의 그 다음 번호를
--   자동으로 입력 처리할 수 있는 프로시저로 구성한다.
--   프로시저 명 : PRC_INSA_INSERT(NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
/*
실행 예)
EXEC PRC_INSA_INSERT('한혜림', '971006-2234567', SYSDATE, '서울', '010-5555-5555'
                    , '영업부', '대리', 5000000, 500000)

프로시저 호출로 처리된 결과)

1061 한혜림 971006-2234567 2021-04-09 서울 010-5555-5555 영업부 대리 5000000 500000
*/
SELECT *
FROM TBL_INSA;

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
(
  V_NAME IN TBL_INSA.NAME%TYPE
, V_SSN IN TBL_INSA.SSN%TYPE
, V_IBSADATE IN TBL_INSA.IBSADATE%TYPE
, V_CITY IN TBL_INSA.CITY%TYPE
, V_TEL IN TBL_INSA.TEL%TYPE
, V_BUSEO IN TBL_INSA.BUSEO%TYPE
, V_JIKWI IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG IN TBL_INSA.SUDANG%TYPE
)
IS
 V_NUM    NUMBER;
 

BEGIN
     
       --V_NUM := TBL_INSA테이블에서 가장 큰 NUM 값 + 1; 
     SELECT MAX(NUM)+1 INTO V_NUM
      FROM TBL_INSA;

    INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES( V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL
           , V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
           
    -- 커밋
    COMMIT;
    
END;

--[선생님 풀이]

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
(
  V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    -- INSERT 쿼리문 수행에 필요한 변수 추가 선언
    -- → NUM
    V_NUM    NUMBER;
 

BEGIN
    -- 선언한 변수(V_NUM)에 값 담아내기
    SELECT MAX(NUM)+1 INTO V_NUM
    FROM TBL_INSA;

    -- ISNERT 쿼리문 구성
    INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES( V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL
           , V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
           
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.

-- 에러
/*
21/6      PLS-00103: Encountered the symbol "SELECT" when expecting one of the following:     ( - + case mod new not null <an identifier>    <a double-quoted delimited-identifier> <a bind variable>    continue avg count current exists max min prior sql stddev    sum variance execute forall merge time timestamp interval    date <a string literal with character set specification>    <a number> <a single-quoted SQL string> pipe    <an alternatively-quoted string literal with character set specification>    <an alternat
22/18     PLS-00103: Encountered the symbol ")" when expecting one of the following:     . , @ ; for <an identifier>    <a double-quoted delimited-identifier> group having intersect    minus order partition start subpartition union where connect    sample 
32/4      PLS-00103: Encountered the symbol "end-of-file" when expecting one of the following:     end not pragma final instantiable order overriding static    member constructor map 
오류: 컴파일러 로그를 확인하십시오.

*/

--> 해결 방법
-- SELECT ~FROM 문 괄호 묶는거 푸니까 해결됨

-- ★암기★
-- SELECT 로 얻어온 값은 INTO 로 넣어줘야 한다.
-- SELECT 로 얻어온 값은 := 대입연산자로 담아낼 수없다.(내부커서가 돌아가서..) 
-- EXEC 구문은 한 줄로 써야 한다.


--○ TBL_상품, TBL_입고 테이블을 대상으로...
--   TBL_입고 테이블에 데이터 입력 시 (즉, 입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 함께 변동될 수 있는 기능을 가진
--   프로시저를 작성한다.
--   단, 이 과정에서 입고번호는 자동 증가 처리한다. (시퀀스 사용 X)
--   TBL_입고 테이블 구성 컬럼
--   → 입고번호, 상품코드, 입고일자, 입고수량, 입고단가
--   프로시저 명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)


--[나의 풀이]
CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드 IN TBL_입고.상품코드%TYPE
, V_입고수량 IN TBL_입고.입고수량%TYPE
, V_입고단가 IN TBL_입고.입고단가%TYPE
)
IS
--주요변수선언
V_입고번호  TBL_입고.입고번호%TYPE;
V_재고수량  TBL_상품.재고수량%TYPE;
BEGIN
-- 연산 및 처리
/*

SELECT MAX(입고번호)+1 INTO V_입고번호
FROM TBL_입고
--> 에러발생
ORA-01400: cannot insert NULL into ("SCOTT"."TBL_입고"."입고번호")
ORA-06512: at "SCOTT.PRC_입고_INSERT", line 17
ORA-06512: at line 1
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
--> TBL_입고 테이블에 아무것도 담겨있지 않기 때문에 MAX(입고번호)+1 = NULL 이다.

*/
    --NVL2(SELECT MAX(입고번호)
    --FROM TBL_입고, SELECT MAX(입고번호)+1 INTO V_입고번호
    --FROM TBL_입고, 1)
    
    --> 에러 발생~!!!
    --> SELECT 문 안에서는 자유롭게 함수를 사용할 수 있지만.. 
    -- 호출한 테이블(SELECT ~ FROM) 밖에서 함수를 쓰는건 문법에 맞지 않다.
    
    IF
        (SELECT 입고번호
        FROM TBL_입고;)
        IS NULL
    THEN
        V_입고번호 := 1;
    ELSE
        SELECT MAX(입고번호)+1 INTO V_입고번호
        FROM TBL_입고;
        
    END IF;
    --> 에러 발생~!!!
    --> 마찬가지로 IF문 조건절에 쓰는건 문법에 맞지 않다.
    
    
-- INSERT (TBL_입고 테이블)
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
    VALUES (V_입고번호, V_상품코드, SYSDATE, V_입고수량, V_입고단가);
-- UPDATE (TBL_상품 테이블)

    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;


END;
--> 다시 풀기!!!


--[선생님 풀이]

--※ TBL_입고 테이블에 입고 이벤트 발생 시...
--   관련테이블에서 수행되어야 하는 내용
--   ① INSERT → TBL_입고
--      INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
--      VALUES (1, 'H001', SYSDATE, 20, 900)

--   ② UPDATE TBL_상품
--      SET 재고수량 = 기존재고수량 + 20(← 입고수량)
--      WHERE 상품코드 = 'H001';


CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드 IN TBL_상품.상품코드%TYPE -- 상품테이블이 부모테이블이니 상품테이블 참조
, V_입고수량 IN TBL_입고.입고수량%TYPE
, V_입고단가 IN TBL_입고.입고단가%TYPE
)
IS
    -- 아래의 쿼리문을 수행하기 위해 필요한 데이터 변수로 선언
    V_입고번호 TBL_입고.입고번호%TYPE;
BEGIN

    -- 선언한 변수(V_입고번호)에 값 담아내기
    SELECT NVL(MAX(입고번호), 0) INTO V_입고번호
    FROM TBL_입고;


    -- 쿼리문 구성
    --   ① INSERT → TBL_입고
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
    VALUES ((V_입고번호+1), V_상품코드,  V_입고수량, V_입고단가);
    
    --   ② UPDATE TBL_상품
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 커밋
    COMMIT;
    
    -- 예외 처리
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
    
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.


--■■■ 프로시저 내에서의 예외 처리 ■■■--

--○ 실습 테이블 생성(TBL_MEMBER) → 20210409_02_scott.sql 파일 참조

--○ TBL_MEMBER 테이블에 데이터를 입력하는 프로시저를 생성
--   단, 이 프로시저를 통해 데이터를 입력할 경우
--   CITY(지역) 항목에 '서울', '경기', '인천'만 입력이 가능하도록 구성한다.
--   이 지역 외의 지역을 프로시저 호출을 통해 입력하려는 경우
--   예외 처리를 하려고 한다.
--   프로시저 명 : PRC_MEMBER_INSERT(이름, 전화번호, 지역)

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN TBL_MEMBER.NAME%TYPE
, V_TEL     IN TBL_MEMBER.TEL%TYPE
, V_CITY    IN TBL_MEMBER.CITY%TYPE
)
IS
    -- 실행 영역의 쿼리문 수행을 위해 필요한 데이터 변수 선언
    V_NUM   TBL_MEMBER.NUM%TYPE;
    
    -- 사용자 정의 예외에 대한 변수 선언~!!!
    USER_DEFINE_ERROR   EXCEPTION;
    --변수명   데이터타입, 일반적인 변수 선언과 형식 같다 CHECK~!!!

BEGIN

    -- 프로시저를 통해 입력 처리를 정상적으로 진행해야 할 데이터인지
    -- 아닌지의 여부를 가장 먼저 확인할 수 있도록 코드 구성
    
    IF ((V_CITY) NOT IN ('서울','경기','인천'))   -- '서울', '인천', '경기' 중 하나가 들어있지 않다면...
        -- 예외 발생~!!! CHECK~!!! = JAVA THROW
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(NUM),0) INTO V_NUM   -- 0 OR 최대값
    FROM TBL_MEMBER;
    

    -- 쿼리문 구성(INSERT)
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM+1), V_NAME, V_TEL, V_CITY);
    
    -- 커밋
    COMMIT;
    
    --예외 처리
    /*
    EXCEPTION
        WHEN 이런 예외라면...
            THEN 이렇게 처리하고
        WHEN 저런 예외라면...
            THEN 저렇게 처리해라...
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-에러코드, 에러내용기술);
        WHEN 저런 예외라면...
            THEN 저렇게 처리해라...
    */
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '서울,인천,경기만 입력 가능합니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;

END;
--==>> Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.

--※ EXCEPTION - RAISE_APPLICATION_ERROR(-에러코드, 에러내용기술)
--> 에러코드 20000 번 까지는 오라클이 선점
--  프로젝트 진행할때는 20001 번부터 에러코드 쓰면 된다.


--○ TBL_출고 테이블에 데이터 입력 시 (즉, 출고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 변동되는 프로시저를 작성한다.
--   단, 출고번호는 입고번호와 마찬가지로 자동 증가.
--   또한, 출고 수량이 재고 수량보다 많은 경우...
--   출고 액션을 취소할 수 있도록 처리한다. (출고가 이루어지지 않도록...)
--   프로시저 명 : PRC_출고_INSERT(상품코드, 출고수량, 출고단가)

CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드    TBL_상품.상품코드%TYPE
, V_출고수량    TBL_출고.입고수량%TYPE
, V_출고단가    TBL_출고.입고단가%TYPE
)
IS
-- 변수 선언
V_출고번호  TBL_출고.입고번호%TYPE;
V_재고수량  TBL_상품.재고수량%TYPE;
-- 예외처리 변수 선언
USER_DEFINE_ERROR   EXCEPTION;

BEGIN
    -- TBL_상품 테이블의 재고수량을 지역변수에 담기
    SELECT NVL(재고수량, 0) INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 예외처리 구문
    IF (V_출고수량 > V_재고수량)
    THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 출고번호 연산 처리
    SELECT NVL(MAX(출고번호), 0) INTO V_출고번호
    FROM TBL_출고;
    

    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
    VALUES((V_출고번호+1), V_상품코드, V_출고수량, V_출고단가);
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20001, '재고수량이 출고수량보다 부족합니다.');
             ROLLBACK;
    WHEN OTHERS
        THEN ROLLBACK;
END;
--==>> Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.


--[선생님 풀이]
CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드    TBL_상품.상품코드%TYPE
, V_출고수량    TBL_출고.출고수량%TYPE
, V_출고단가    TBL_출고.출고단가%TYPE
)
IS
    --  주요 변수 선언
    V_출고번호  TBL_출고.출고번호%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;      -- 사용자 정의 예외
BEGIN
    -- 쿼리문 수행 이전에 수행 여부 확인 → 기존 재고 확인 → 출고 수량과 비교
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;

    
    -- 출고를 정상적으로 진행해 줄 것인지에 대한 여부 확인
    -- (파악한 재고수량보다 출고수량이 많으면... 예외 발생~!!!)
    
    IF (V_출고수량 > V_재고수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
 
    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(출고번호), 0) INTO V_출고번호
    FROM TBL_출고;

    -- 쿼리문 구성(INSERT → TBL 출고)
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
    VALUES((V_출고번호+1), V_상품코드, V_출고수량, V_출고단가);
    
    -- 쿼리문 구성(UPDATE → TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    --커밋
    COMMIT;
    
    -- 예외 처리
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고부족~!!!');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;       
END;
--==>> Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.


--○ TBL_출고 테이블에서 출고수량을 변경(수정)하는 프로시저를 작성한다.
--   프로시저 명 : PRC_출고_UPDATE(출고번호, 변경할 수량)

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( V_출고번호    TBL_출고.출고번호%TYPE
, V_변경수량    TBL_상품.재고수량%TYPE
)
IS 
    V_재고수량  TBL_상품.재고수량%TYPE;
    V_출고수량  TBL_출고.출고수량%TYPE;
    V_상품코드  TBL_상품.상품코드%TYPE;
    
    -- 예외 처리 변수
    USER_DEFINE_ERROR   EXCEPTION;

BEGIN

    -- 선언한 변수에 값 담아내기(변경전 값)
    SELECT 출고수량 INTO V_출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
     
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;

    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;


    -- 출고변경을 정상적으로 진행시켜줄 것인지 먼저 확인
    
    IF ((V_재고수량+V_출고수량) < V_변경수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- UPDATE (TBL_상품-재고수량)
    UPDATE TBL_상품
    SET 재고수량 = (V_재고수량+V_출고수량) - V_변경수량
    WHERE 상품코드 = V_상품코드;
    
    -- UPDATE (TBL_출고-출고수량)
    UPDATE TBL_출고
    SET 출고수량 = V_변경수량
    WHERE 출고번호 = V_출고번호;
    
    -- 커밋
    COMMIT;
    
    --예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '출고량보다 재고량이 부족합니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;

END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.




