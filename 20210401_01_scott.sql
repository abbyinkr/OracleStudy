SELECT USER
FROM DUAL;
--==>> SCOTT


--■■■ JOIN(조인) ■■■--

-- 1. SQL 1992 CODE 
SELECT *
FROM EMP, DEPT;
--> 수학에서 말하는 데카르트 곱(Catersian Product)
-- 두 테이블을 합친(결합한) 모든 경우의 수

-- Equi join : 서로 정확히 일치하는 데이터들끼리 연결시키는 결합

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- Non Equi join : 【범위】 안에 적합한 데이터들끼리 연결시키는 결합

SELECT *
FROM SALGRADE;
SELECT *
FROM EMP;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- Equi Join  시 『+』를 활용한 결합 방법

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 총 14건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호를 갖지 못한 사원들(5인)은 모두 누락~!!!

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--    E를 먼저 퍼올리고 ----- D를 추가로 붙인다!
--  총 19건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호를 갖지 못한 사원들(5인)도 모두 조회된 상황~!!!

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> 총 16건의 데이터가 결합되어 조회된 상황
-- 즉, 부서에 소속된 사원이 아무도 없는 부서도 모두 조회된 상황~!!!

--※ (+)가 없는 쪽 테이블의 데이터를 모두 메모리에 적재한 후
--   (+)가 있는 쪽 테이블의 데이터를 하나하나 확인하여 결합시키는 형태로
--   JOIN이 이루어진다.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--==>> 에러 발생 (둘 다 추가데이터면 메인데이터는 어디에?)
--> 위와 같은 이유로 이러한 형식의 JOIN 구문은 존재하지 않는다.


-- 1. SQL 1999 CODE → 『JOIN』 키워드 등장 → JOIN 유형 명시
--                      결합 조건은 『WHERE』 대신 『ON』 (WHERE에 쓰면 헷갈리니까)

-- CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;
--> 데카르트 곱(모든 경우의 수)

-- INNER JOIN 

SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--※ INNER JOIN 시 INNER 는 생략 가능
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

--Equi, Non Equi 모두 INNER JOIN 으로 들어옴

-- OUTER JOIN
--> qui join (+) 결합  
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D 
ON E.DEPTNO = D.DEPTNO;
--(+)쓰면 헷갈리니까 없애고 메인을 FROM 절 왼쪽, 오른쪽으로 정하기 

--※ 방향이 지정된 쪽 테이블(→ LEFT)의 데이터를 모두 메모리에 적재한 후
--   방향이 지정되지 않은 쪽의 테이블들의 데이터를 각각 확인하여 결합시키는 형태로
--   JOIN이 이루어진다.

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
-- 둘 다 메인~!

--※ OUTER JOIN에서 OUTER 는 생략 가능

SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D     -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D    -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D     -- OUTER JOIN
ON E.DEPTNO = D.DEPTNO;


SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D          -- INNER JOIN
ON E.DEPTNO = D.DEPTNO;


--------------------------------------------------------------------------------
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--  이 결과에서 ... 직종이 CLERK 인 사원들만 조회

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
-- 이렇게 쿼리문을 구성해도 조회하는데는 문제가 없다.

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
-- 하지만, 이와 같이 구성하여 조회할 수 있도록 권장한다.
-- ON이 등장한 이유.. 결합조건 ON 과 선택조건 WHERE 를 구분해서 써야한다.

--------------------------------------------------------------------------------

--○ EMP 테이블과 DEPT 테이블을 대상으로 
--   직종이 MANAGER 와 CLERK 인 사원들만
--   부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.
SELECT *
FROM EMP;
SELECT *
FROM DEPT;

SELECT E.DEPTNO"부서번호", D.DNAME"부서명", E.ENAME"사원명"
     , E.JOB"직종명", E.SAL"급여"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB IN ('MANAGER', 'CLERK');


--[선생님 풀이]

--○ EMP 테이블과 DEPT 테이블을 대상으로 
--   직종이 MANAGER 와 CLERK 인 사원들만
--   부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.
--   --------  ------  ------  ------  ----
--   DEPTNO    DNAME    ENAME   JOB     SAL
--   -------   -----   -------  ----    ---
---   E,D        D        E      E       E
--> 제일 먼저, 데이터 위치 확인

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==> 에러 발생
/*
ORA-00918: column ambiguously defined
00918. 00000 -  "column ambiguously defined"
*Cause:    
*Action:
180행, 8열에서 오류 발생
*/
--> 두 테이블 간 중복되는 컬럼에 대한 소속 테이블을
--  정해줘야(명시해줘야) 한다.

SELECT DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 두 테이블 간 중복되는 컬럼이 존재하지 않는 조회 구문은
-- 에러 발생하지 않는다.
--==>>
/*
ACCOUNTING	CLARK	MANAGER	    2450
ACCOUNTING	KING	PRESIDENT	5000
ACCOUNTING	MILLER	CLERK	    1300
RESEARCH	JONES	MANAGER	    2975
RESEARCH	FORD	ANALYST	    3000
RESEARCH	ADAMS	CLERK	    1100
RESEARCH	SMITH	CLERK	    800
RESEARCH	SCOTT	ANALYST	    3000
SALES	    WARD	SALESMAN	1250
SALES	    TURNER	SALESMAN	1500
SALES	    ALLEN	SALESMAN	1600
SALES	    JAMES	CLERK	    950
SALES	    BLAKE	MANAGER	    2850
SALES	    MARTIN	SALESMAN	1250
*/

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--  부서(DEPT), 사원(EMP) 중 어떤 테이블을 지정해도
--  쿼리문 수행에 대한 결과 반환에 문제가 없다.

-- ※ 하지만...
-- 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
-- 부모 테이블의 컬럼을 참조할 수 있도록 해야 한다.

SELECT *
FROM DEPT;      -- 부모 테이블
SELECT *
FROM EMP;       -- 자식 테이블

--※ 부모 자식 테이블 관계를 명확히 정리할 수 있도록 한다.

--        연결고리

--        DEPTNO
-- EMP ------------ DEPT 

-- 연결고리 값이 중복되는 테이블이 자식~~


SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--> 자식테이블 컬럼쓰면 부서번호 40번 누락

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;


-- 최종 쿼리
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 두 테이블 간 중복된 컬럼이 아니더라도..
--  소속 테이블을 명시할 수 있도록 권장한다.
--  오라클이 두 개 테이블을 둘러보는 수고를 하지않게 하기 위해!

--○ SELF JOIN (자기 조인)
-- EMP 테이블의 정보를 다음과 같이 조회 할 수 있도록 한다.
--     E      E      E        E         E           E
--  EMPNO   ENAME   JOB      MGR                               --① → E1
--                           EMPNO     ENAME       JOB         --② → E2
-----------------------------------------------------------------
-- 사원번호 사원명 직종명 관리자번호 관리자명 관리자직종명 
-----------------------------------------------------------------
--    7369  SMITH  CLERK     7902     FORD      ANALYST
SELECT *
FROM EMP;

SELECT E1.EMPNO"사원번호", E1.ENAME"사원명", E1.JOB"직종", E1.MGR"관리자번호"
     , E2.ENAME"관리자명", E2.JOB"관리자직종명"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;


--[선생님 풀이]

SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명" -- E1.MGR "관리자번호"
     , E2.EMPNO "관리자번호", E2.ENAME "관리자명", E2.JOB "관리자직종명"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;

SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명" -- E1.MGR "관리자번호"
     , E2.EMPNO "관리자번호", E2.ENAME "관리자명", E2.JOB "관리자직종명"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;

