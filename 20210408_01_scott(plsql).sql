SELECT USER
FROM DUAL;
--==>> SCOTT

--○ 사용자로부터 입력받은 금액을 화폐 단위로 출력하는 프로그램을 작성한다.
--   단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 : 990

입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다.


ACCEPT N PROMPT '금액 입력 : ';

DECLARE
--변수설정
    NUM1    NUMBER := &N;
    OBACK   NUMBER := 0;
    BACK    NUMBER := 0;
    OSIB    NUMBER := 0;
    SIB     NUMBER := 0;
BEGIN
--연산 및 처리
    OBACK := TRUNC(NUM1/500);
    BACK  := TRUNC(MOD(NUM1,500)/100);
    OSIB  := TRUNC(MOD(NUM1,100)/50);
    SIB   := TRUNC(MOD(NUM1,50)/10); 

-- 결과출력
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || NUM1 || '원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || OBACK || ', 백원 ' || BACK || ', 오십원 ' 
                         || OSIB || ', 십원 ' || SIB);    
END;


--[선생님 풀이]--

ACCEPT INPUT PROMPT'금액 입력 : ';

DECLARE
    --○ 주요 변수 선언 및 초기화
    MONEY   NUMBER := &INPUT;       -- 연산을 위해 담아둔 변수
    MONEY2  NUMBER := &INPUT;       -- 출력을 위해 담아둘 변수 (연산 과정에서 값이 변하기 때문에...)
    M500    NUMBER;                 -- 500원 짜리 갯수를 담아둘 변수
    M100    NUMBER;                 -- 100원 짜리 갯수를 담아둘 변수
    M50     NUMBER;                 --  50원 짜리 갯수를 담아둘 변수
    M10     NUMBER;                 --  10원 짜리 갯수를 담아둘 변수
BEGIN
    --○ 연산 및 처리
    -- MONEY를 500으로 나눠서 몫을 취하고 나머지는 버린다. → 500원의 갯수
    M500 := TRUNC(MONEY/500);
    
    -- MONEY 를 500으로 나눠서 몫은 버리고 나머지는 취한다.
    MONEY := MOD(MONEY,500);
    
    -- MONEY 를 100으로 나눠서 몫을 취하고 나머지는 버린다. → 100원의 갯수
    M100 := TRUNC(MONEY/100);
    
    -- MONEY 를 100으로 나눠서 몫은 버리고 나머지는 취한다.
    MONEY := MOD(MONEY,100);
    
    -- MONEY 를 50으로 나눠서 몫을 취하고 나머지는 버린다. → 50원의 갯수
    M50 := TRUNC(MONEY/50)
    
    -- MONEY 를 50으로 나눠서 몫은 버리고 나머지는 취한다.
    MONEY := MOD(MONEY,50);
    
    -- MONEY 를 10으로 나눠서 몫을 취하고 나머지는 버린다. → 10원의 갯수
    M10 := TRUNC(MONEY/10);

    --○ 결과 출력
    DBMS_OUTPUT.PUT_LINE('입력 받은 금액 총액 : ' || MONEY2 || '원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || M500 || ', 백원 ' || M100 || ', 오십원 ' || M50 || ', 십원 ' || M10 );
    
END;


--○ 기본 반복문
-- LOOP END LOOP;

-- 1. 조건과 상관없이 무조건 반복하는 구문.

-- 2. 형식 및 구조

/*
LOOP
    -- 실행문;
    EXIT WHEN 조건;       -- 조건이 참인 경우 반복문을 빠져나간다.
END LOOP;

*/


--○ 1 부터 10 까지의 수 출력 (LOOP 문 활용)

DECLARE
    N   NUMBER;
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        EXIT WHEN N>= 10;
        N := N + 1;              -- N++;    N+=1;
    END LOOP;
END;
--==>>
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
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 TRUE 인 동안 일련의 문장을 반복하기 위해 
--    WHILE LOOP 문장을 사용한다.
--    조건은 반복이 시작될 때 체크하게 되어
--    LOOP 내의 문장이 한 번도 수행되지 않을 경우도 있다.
--    LOOP 를 시작할 때 조건이 FALSE 이면 반복 문장을 탈출하게 된다.

-- 2. 형식 및 구조
/*
WHILE 조건 LOOP      -- 조건이 참인 경우 반복 수행
    -- 실행문;
END LOOP;
*/

--○ 1 부터 10 까지의 수 출력(WHILE LOOP문 활용)

DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
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
-- FOR LOOP ~ END LOOP;

-- 1. 『시작 수』에서 1씩 증가하여
--    『끝냄 수』가 될 때 까지 반복 수행한다.

-- 2. 형식 및 구조
/*
FOR 카운터 IN [REVERSE] 시작수 .. 끝냄수 LOOP
    -- 실행문
END LOOP;
*/

--○ 1 부터 10 까지의 수 출력 (FOR LOOP 문 활용)

DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
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
--   LOOP, WHILE LOOP, FOR LOOP 를 통해 해결한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요 : 2

2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
    :
2 * 9 = 18
*/


--LOOP

ACCEPT N PROMPT '단을 입력하세요 : ';

DECLARE
    NUM1    NUMBER := &N;
    NUM2    NUMBER;
BEGIN
    NUM2 := 1;
    LOOP
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' * ' || NUM2 || ' = ' || NUM1*NUM2);
    EXIT WHEN NUM2 >= 9;
    NUM2 := NUM2 + 1;
    END LOOP;
END;
--==>>
/*
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--WHILE LOOP

ACCEPT N PROMPT '단을 입력하세요 : ';

DECLARE
    NUM1    NUMBER := &N;
    NUM2    NUMBER;
BEGIN
    NUM2 := 1;
   
    WHILE NUM2 <10 LOOP
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' * ' || NUM2 || ' = ' || NUM1*NUM2);
    NUM2 := NUM2 + 1; 
    END LOOP;
END;
--==>>
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

-- FOR LOOP 
ACCEPT N PROMPT '단을 입력하세요 : ';

DECLARE
    NUM1    NUMBER := &N;
    NUM2    NUMBER;
    
BEGIN
    FOR NUM2 IN 1 .. 9 LOOP
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' * ' || NUM2 || ' = ' || NUM1*NUM2);
    END LOOP;

END;
--==>>
/*
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

