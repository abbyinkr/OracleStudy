SELECT USER
FROM DUAL;


SELECT DEPTNO"부서번호", SUM(SAL)"급여합", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN DEPTNO
            ELSE '모든부서'
        END "부서번호"
      , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
11행, 18열에서 오류 발생
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
            ELSE '모든부서'
        END "부서번호"
      , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
(null)       8000
모든부서	37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '모든부서'
        END "부서번호"
      , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
인턴	    8000
모든부서	37025
*/


--○ TBL_SAWON 테이블을 다음과 같이 조회될 수 있도록 쿼리문을 작성한다.
/*
--------------------------------
     성별          급여합
--------------------------------
      남           XXXXXX
      여           XXXXXX
    모든사원       XXXXXX
--------------------------------
*/

SELECT *
FROM TBL_SAWON;


SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','3') THEN '남'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4') THEN '여'
            ELSE '성별확인불가'
        END "성별" 
FROM TBL_SAWON;



--[나의 풀이]
SELECT  CASE WHEN GROUPING(T.성별) = 1 THEN '모든사원'
             ELSE T.성별
        END "성별"
        ,SUM(T.SAL)"급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4') THEN '여'
                ELSE '성별확인불가'
            END "성별" 
            ,SAL
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);


--[선생님 풀이]
SELECT T.성별"성별"
       , SUM(T.급여)"급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4') THEN '여'
                ELSE '성별확인불가'
            END "성별"
         , SAL "급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	12000
여	24100
(null)	36100
*/

SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별
            ELSE '모든사원'
        END "성별"
       , SUM(T.급여)"급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4') THEN '여'
                ELSE '성별확인불가'
            END "성별"
         , SAL "급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        12000
여	        24100
모든사원	36100
*/


SELECT *
FROM VIEW_SAWON;


--○ TBL_SAWON 테이블을 다음과 같이 연령대별 인원수 형태로 
--   조회할 수 있도록 쿼리문을 구성한다.
/*
---------------------------
    연령대      인원수
---------------------------
     10           X
     20           X
     30           X
     40           X 
     50           X
     전체         X
---------------------------

*/

SELECT CASE GROUPING(T.연령대) WHEN 1 THEN '전체'
             ELSE T.연령대
        END"연령대"
    , COUNT(T.연령대)"인원수"
FROM
(
    SELECT CASE WHEN 현재나이<20 THEN '1O'
                WHEN 현재나이<30 THEN '20'
                WHEN 현재나이<40 THEN '30'
                WHEN 현재나이<50 THEN '40'
                WHEN 현재나이<60 THEN '50'
                ELSE '0'
            END "연령대"
            
    FROM VIEW_SAWON
) T
GROUP BY ROLLUP(T.연령대);


SELECT CASE WHEN 현재나이<20 THEN '1O'
            WHEN 현재나이<30 THEN '20'
            WHEN 현재나이<40 THEN '30'
            WHEN 현재나이<50 THEN '40'
            WHEN 현재나이<60 THEN '50'
            ELSE '0'
        END "연령대"
        
FROM VIEW_SAWON;
    
    
    
SELECT CASE GROUPING(T2.연령대) WHEN 1 THEN '전체'
             ELSE (T2.연령대)
        END"연령대"
    , COUNT(T2.연령대)"인원수"
FROM    
(    
    SELECT CASE WHEN T1.현재나이<20 THEN '1O'
                WHEN T1.현재나이<30 THEN '20'
                WHEN T1.현재나이<40 THEN '30'
                WHEN T1.현재나이<50 THEN '40'
                WHEN T1.현재나이<60 THEN '50'
                ELSE '0'
            END "연령대"
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','2') THEN TO_CHAR(SYSDATE, 'YYYY') - SUBSTR(JUBUN, 1, 2) - 1899
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3','4') THEN TO_CHAR(SYSDATE, 'YYYY') - SUBSTR(JUBUN, 1, 2) - 1999
                    ELSE -1
                END"현재나이"
        FROM TBL_SAWON
    ) T1
) T2
GROUP BY ROLLUP(T2.연령대);


--[선생님 풀이]

--방법 1. (INLINE VIEW를 두번 중첩)


SELECT CASE GROUPING(Q.연령대) WHEN 1 THEN '전체'
             ELSE (Q.연령대)
        END"연령대"
    , COUNT(Q.연령대)"인원수"
FROM    
(    
    SELECT CASE WHEN T.나이>=50 AND T.나이 < 60 THEN '5O'
                WHEN T.나이>=40 THEN '40'
                WHEN T.나이>=30 THEN '30'
                WHEN T.나이>=20 THEN '20'
                WHEN T.나이>=10 THEN '10'
                ELSE '0'
            END "연령대"
    FROM
    (
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','2') 
                THEN (EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1899))
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3','4') 
                THEN (EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1999))
                ELSE -1
            END"나이"
    FROM TBL_SAWON
    ) T
)Q
GROUP BY ROLLUP(Q.연령대);
--==>>
/*
10	    2
20	    11
40	    1
5O	    2
전체	16
*/

--방법 2. (INLINE VIEW를 한 번만 사용)


SELECT TRUNC(CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE 0
        END, -1)"연령대"
        
FROM TBL_SAWON
--> 서브쿼리 INLINE VIEW

--테스트
SELECT TRUNC(20, -1)"확인1", TRUNC(30, -1)"확인2", TRUNC(39, -1)"확인3"
FROM DUAL;


--○ ROLLUP 활용 및 CUBE
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975
30	CLERK	    950
30	MANAGER	    2850
30	SALESMAN	5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (null)	    8750        -- 1O번 부서 모든 직종의 급여합
20	    ANALYST 	6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    (null)	    10875       -- 2O번 부서 모든 직종의 급여합
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    (null)	    9400        -- 3O번 부서 모든 직종의 급여합
(null)	(null)	    29025       -- 모든 부서 모든 직종의 급여합
*/


--○ CUBE() → ROLLUP() 보다 더 자세한 결과를 반환받을 수 있다.

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (null)	    8750        -- 1O번 부서 모든 직종의 급여합
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    (null)	   10875        -- 2O번 부서 모든 직종의 급여합
30	    CLERK	     950
30	    MANAGER	    2850
30	    SALESMAN	5600
30		(null)      9400        -- 3O번 부서 모든 직종의 급여합
(null)	ANALYST	    6000        -- 모든 부서 ANALYST 직종의 급여합
(null)	CLERK	    4150        -- 모든 부서 CLERK 직종의 급여합
(null)	MANAGER	    8275        -- 모든 부서 MANAGER 직종의 급여합
(null)	PRESIDENT	5000        -- 모든 부서 PRESIDENT 직종의 급여합
(null)	SALESMAN	5600        -- 모든 부서 SALESMAN 직종의 급여합
(null)	(null)	   29025        -- 모든 부서 모든 직종의 급여합
*/

--※ ROLLUP() 과 CUBE() 는 
--   그룹을 묶어주는 방식이 다르다. (차이)

-- ROLLUP(A, B, C)
-- → (A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- → (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> 위의 처리 내용은 원하는 결과를 얻지 못하거나 너무 많은 결과물이 출력되기 때문에
--     다음의 쿼리 형태를 더 많이 사용한다.
--     다음 작성하는 쿼리는 조회하고자 하는 그룹만 『GROUPING SETS』를
--     이용하여 묶어주는 방식이다.

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
        END "부서번호"
      , CASE GROUPING(JOB)WHEN 0 THEN JOB
            ELSE '전체직종'
        END"직종"
      , SUM (SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    전체직종	8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    전체직종	10875
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    전체직종	9400
인턴	CLERK	    2500
인턴	SALESMAN	5500
인턴	전체직종	8000
(null)	전체직종	37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
        END "부서번호"
        
      , CASE GROUPING(JOB)WHEN 0 THEN JOB
            ELSE '전체직종'
        END"직종"
      , SUM (SAL)"급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    전체직종	8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    전체직종   10875
30	    CLERK	     950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    전체직종	9400
인턴	CLERK	    2500
인턴	SALESMAN	5500
인턴	전체직종	8000
(null)	ANALYST	    6000
(null)	CLERK	    6650
(null)	MANAGER	    8275
(null)	PRESIDENT	5000
(null)	SALESMAN   11100
(null)	전체직종   37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
        END "부서번호"
      , CASE GROUPING(JOB)WHEN 0 THEN JOB
            ELSE '전체직종'
        END"직종"
      , SUM (SAL)"급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ()) -- ROLLUP() 과 같은 결과
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    전체직종	8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    전체직종	10875
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    전체직종	9400
인턴	CLERK	    2500
인턴	SALESMAN	5500
인턴	전체직종	8000
(null)	전체직종	37025
*/



SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
        END "부서번호" 
      , CASE GROUPING(JOB)WHEN 0 THEN JOB
            ELSE '전체직종'
        END"직종"
      , SUM (SAL)"급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ()) -- CUBE() 과 같은 결과
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    전체직종	8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    전체직종   10875
30	    CLERK	     950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    전체직종	9400
인턴	CLERK	    2500
인턴	SALESMAN	5500
인턴	전체직종	8000
(null)	ANALYST	    6000
(null)	CLERK	    6650
(null)	MANAGER	    8275
(null)	PRESIDENT	5000
(null)	SALESMAN   11100
(null)	전체직종   37025
*/

--○ TBL_EMP 테이블에서 입사년도별 인원수를 조회한다.

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.



/*
--------------------------
  입사년도      인원수
--------------------------
   1980            1
   1981           10
   1982            1
   1987            2
   2021            5
   전체           19
--------------------------
*/

SELECT CASE GROUPING(T.입사년도) WHEN 1 THEN '전체'
             ELSE TO_CHAR(T.입사년도)
        END"입사년도"
    , COUNT(T.입사년도)"인원수"
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
    FROM TBL_EMP
    
)T
GROUP BY ROLLUP(T.입사년도)
ORDER BY 1;

--GROUPING SETS 사용

SELECT CASE GROUPING(T.입사년도) WHEN 1 THEN '전체'
             ELSE TO_CHAR(T.입사년도)
        END"입사년도"
    , COUNT(T.입사년도)"인원수"
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
    FROM TBL_EMP
    
)T
GROUP BY GROUPING SETS((T.입사년도), ())
ORDER BY 1;

--[선생님 풀이]

SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
      , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2021	5
(null)	19
*/

SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
      , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2021	5
(null)	19
*/

SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
      , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY GROUPING SETS(EXTRACT(YEAR FROM HIREDATE), ())
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2021	5
(null)	19
*/

SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
      , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
580행, 26열에서 오류 발생
*/

SELECT EXTRACT(YEAR FROM HIREDATE)"입사년도"
      , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> 에러 발생
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
580행, 26열에서 오류 발생
*/

SELECT TO_CHAR(HIREDATE, 'YYYY')"입사년도"   -- 타입
      , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))   -- 통일
ORDER BY 1;


SELECT TO_CHAR(HIREDATE, 'YYYY')"입사년도"     -- 타입
      , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))   -- 통일
ORDER BY 1;
--==>> 에러발생 

-->> SELECT 는 GROUP BY가 묶어놓은 걸 승계 받아서 씀 → 타입 통일 필요 ★



--------------------------------------------------------------------------------

--■■■ HAVING ■■■--

--○ EMP 테이블에서 부서번호가 20, 30인 부서를 대상으로
--   부서의 총 급여가 10000 보다 적을 경우만 부서별 총 급여를 조회한다.


SELECT *
FROM EMP
WHERE DEPTNO IN (20,30)

SELECT CASE GROUPING(DEPTNO) WHEN 1 THEN '전체부서'
            ELSE TO_CHAR(DEPTNO)
       END"부서"
    ,SUM(SAL)"급여합"
FROM EMP
WHERE DEPTNO IN (20,30)
GROUP BY ROLLUP(DEPTNO);


SELECT CASE GROUPING(DEPTNO) WHEN 1 THEN '전체부서'
            ELSE TO_CHAR(DEPTNO)
       END"부서"
    ,SUM(SAL)"급여합"
FROM EMP
WHERE DEPTNO IN (20,30) AND SUM(SAL)<10000
GROUP BY ROLLUP(DEPTNO);
-->> 에러 발생


--[선생님 풀이]


SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
GROUP BY DEPTNO;



SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
  AND SUM(SAL) <10000
GROUP BY DEPTNO;
--==>>
/*
ORA-00934: group function is not allowed here           ->  WHERE에서 그룹함수는 쓰지 못한다. ★
00934. 00000 -  "group function is not allowed here"
*Cause:    
*Action:
653행, 4열에서 오류 발생
*/


SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000;
--==>> 30	9400

-- 문법은 WHERE 조건절이랑 같다, HAVING은 GROUP BY에 대한 조건절


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO IN (20,30)
   AND SUM(SAL) < 10000;
--==>> 30	9400
-- BUT. WHERE 조건절에 쓰는것이 더 바람직함 ★
-- 1차적으로 WHERE 조건절을 보고 메모리에 퍼올리기 때문에...
-- 안쓰면 전체를 퍼올리니까 WHERE에 쓰는 것이 조금이라도 메모리를 덜 쓸 수 있다.

--------------------------------------------------------------------------------

--■■■ 중첩 그룹함수 / 분석함수 ■■■--

-- 그룹 함수 2 LEVEL 까지 중첩해서 사용할 수 있다.
-- 이 마저도 MS-SQL은 불가능하다.

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;

-- RANK()
-- DENSE_RANK() 
--> ORACLE 9i 부터 적용... MSSQL 2005 부터 적용

--※ 하위 버전에서는 RANK() 나 DENSE_RANK()를 사용할 수 없기 때문에
--   이를 대체하여 연산을 수행할 수 있는 방법을 강구해야 한다.


-- 예를 들어, 급여의 순위를 구하고자 한다면...
-- 해당 사원의 급여보다 더 큰 값이 몇 개인지 확인한 후
-- 그 확인한 숫자에 + 1 을 추가 연산해주면 그것이 곧 등수가 된다.
SELECT ENAME, SAL, 1
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;     -- SMITH 의 급여
--==>> 14 → SMITH 의 급여 등수


SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;    -- ALLEN 의 급여
--==>> 7 → SMITH 의 급여 등수 

SELECT ENAME, SAL, 1
FROM EMP;


--※ 서브 상관 쿼리 (상관 서브 쿼리)
--   메인 쿼리에 있는 테이블의 컬럼이
--   서브 쿼리의 조건절(WHERE절, HAVING절)에 사용되는 경우
--   우리는 이 쿼리문을 서브 상관 쿼리 라고 부른다.

SELECT ENAME "사원명", SAL "급여", 1 "급여등수"
FROM EMP;


SELECT ENAME "사원명", SAL "급여", (1) "급여등수"
FROM EMP;


SELECT ENAME "사원명", SAL "급여"
     , (SELECT COUNT(*) +1
          FROM EMP 
          WHERE SAL > 800) "급여등수"
FROM EMP;
--==>>
/*
SMITH	800	    14
ALLEN	1600	14
WARD	1250	14
JONES	2975	14
MARTIN	1250	14
BLAKE	2850	14
CLARK	2450	14
SCOTT	3000	14
KING	5000	14
TURNER	1500	14
ADAMS	1100	14
JAMES	950	    14
FORD	3000	14
MILLER	1300	14
*/


SELECT ENAME "사원명", SAL "급여"
     , (SELECT COUNT(*) +1
          FROM EMP E2 
          WHERE SAL > 800) "급여등수"
FROM EMP E1;


SELECT ENAME "사원명", SAL "급여"
     , (SELECT COUNT(*) +1
          FROM EMP E2 
          WHERE E2.SAL > E1.SAL) "급여등수"
FROM EMP E1;
--==>>
/*
SMITH	800	14
ALLEN	1600	 7
WARD	1250	10
JONES	2975	 4
MARTIN	1250	10
BLAKE	2850	 5
CLARK	2450	 6
SCOTT	3000	 2
KING	5000	 1
TURNER	1500	 8
ADAMS	1100	12
JAMES	950	13
FORD	3000	 2
MILLER	1300	 9
*/


SELECT ENAME "사원명", SAL "급여"
     , (SELECT COUNT(*) +1
          FROM EMP E2 
          WHERE E2.SAL > E1.SAL) "급여등수"
FROM EMP E1
ORDER BY 3;
--==>>
/*
KING	5000	 1
FORD	3000	 2
SCOTT	3000	 2
JONES	2975	 4
BLAKE	2850	 5
CLARK	2450	 6
ALLEN	1600	 7
TURNER	1500	 8
MILLER	1300	 9
WARD	1250	10
MARTIN	1250	10
ADAMS	1100	12
JAMES	950	13
SMITH	800	14
*/

--○ EMP 테이블을 대상으로
--   사원명, 급여, 부서번호, 부서내급여등수, 전체급여등수 항목을 조회한다.
--   단, RANK() 함수를 사용하지 않고, 서브 상관 쿼리를 활용할 수 있도록 한다.

SELECT *
FROM EMP;


SELECT ENAME "사원명"
      , SAL "급여"
      , DEPTNO "부서번호"
FROM EMP E1;


SELECT ENAME "사원명"
      , SAL "급여"
      , DEPTNO "부서번호"
      , (SELECT  COUNT(*) + 1
         FROM EMP E2
         WHERE E2.SAL > E1.SAL
        ) "전체급여등수"
FROM EMP E1
ORDER BY 3;


SELECT ENAME "사원명"
      , SAL "급여"
      , DEPTNO "부서번호"
      , (SELECT COUNT(*) + 1
         FROM EMP E2
         WHERE E2.SAL > E1.SAL AND E1.DEPTNO = E2.DEPTNO
        ) "부서내급여등수"
      , (SELECT  COUNT(*) + 1
         FROM EMP E2
         WHERE E2.SAL > E1.SAL
        ) "전체급여등수"
FROM EMP E1
ORDER BY 3, 4;


--[선생님 풀이]


SELECT ENAME "사원명"
      , SAL "급여"
      , DEPTNO "부서번호"
      , (SELECT COUNT(*) + 1
         FROM EMP E2 
         WHERE E2.DEPTNO = E1.DEPTNO AND E2.SAL > E1.SAL) "부서내급여등수"
      , (SELECT COUNT(*) + 1
         FROM EMP E2
         WHERE E2.SAL > E1.SAL) "전체급여등수"
FROM EMP E1
ORDER BY 2 DESC;
--==>>
/*
KING	5000	10	1	 1
FORD	3000	20	1	 2
SCOTT	3000	20	1	 2
JONES	2975	20	3	 4
BLAKE	2850	30	1	 5
CLARK	2450	10	2	 6
ALLEN	1600	30	2	 7
TURNER	1500	30	3	 8
MILLER	1300	10	3	 9
WARD	1250	30	4	10
MARTIN	1250	30	4	10
ADAMS	1100	20	4	12
JAMES	950	    30	6	13
SMITH	800	    20	5	14
*/


SELECT *
FROM EMP
ORDER BY DEPTNO, HIREDATE;

--○ EMP 테이블을 대상으로 다음과 같이 조회할 수 있도록 쿼리문을 구성한다.
/*
--------------------------------------------------------------------------
   사원명      부서번호     입사일      급여       부서내입사별급여누적
--------------------------------------------------------------------------
   CLARK            10    1981-06-09    2450            2450
   KING             10    1981-11-17    5000            7450
   MILLER           10    1982-01-23    1300            8750
   SMITH            20    1980-12-17     800             800
   JONES            20    1981-04-02    2975            3775
                                :
                                :
--------------------------------------------------------------------------

*/


SELECT EMPNO "사원명"
       , DEPTNO "부서번호"
       , HIREDATE "입사일"
       , SAL "급여"
       ,(SELECT SUM(E2.SAL)
         FROM EMP E2
         WHERE E1.DEPTNO = E2.DEPTNO 
           AND E2.HIREDATE <= E1.HIREDATE) "부서내입사별급여누적"
FROM EMP E1
ORDER BY DEPTNO, HIREDATE;


--[선생님 풀이]

SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL"급여"
      , 1 "부서내입사별급여누적"
FROM EMP
ORDER BY 2, 3;


SELECT E1.ENAME "사원명", E1.DEPTNO "부서번호", E1.HIREDATE "입사일", E1.SAL"급여"
      , (SELECT SUM(E2.SAL)
         FROM EMP E2) "부서내입사별급여누적"
FROM EMP E1
ORDER BY 2, 3;


SELECT E1.ENAME "사원명", E1.DEPTNO "부서번호", E1.HIREDATE "입사일", E1.SAL"급여"
      , (SELECT SUM(E2.SAL)
         FROM EMP E2
         WHERE E2.DEPTNO = E1.DEPTNO
          AND E2.HIREDATE <= E1.HIREDATE) "부서내입사별급여누적"
FROM EMP E1
ORDER BY 2, 3;
--==>>
/*
CLARK	10	1981-06-09	2450	2450
KING	10	1981-11-17	5000	7450
MILLER	10	1982-01-23	1300	8750
SMITH	20	1980-12-17	800 	 800
JONES	20	1981-04-02	2975	3775
FORD	20	1981-12-03	3000	6775
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875
ALLEN	30	1981-02-20	1600	1600
WARD	30	1981-02-22	1250	2850
BLAKE	30	1981-05-01	2850	5700
TURNER	30	1981-09-08	1500	7200
MARTIN	30	1981-09-28	1250	8450
JAMES	30	1981-12-03	950	    9400
*/


--○ TBL_EMP 테이블에서 입사한 사원의 수가 제일 많았을 때의
--   입사년월과 인원수를 조회할 수 있는 쿼리문을 구성한다.

/*
-----------------------
 입사년월      인원수
-----------------------
  XXXX-XX       XX 
-----------------------
*/

SELECT *
FROM TBL_EMP
ORDER BY 2;


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
        ,(SELECT COUNT(*)
          FROM TBL_EMP E2
          WHERE (TO_CHAR(E2.HIREDATE, 'YYYY-MM') = TO_CHAR(E1.HIREDATE, 'YYYY-MM'))
          ) "인원수"
FROM TBL_EMP E1;
--==>>
/*
1980-12	1
1981-02	2
1981-02	2
1981-04	1
1981-09	2
1981-05	1
1981-06	1
1987-07	2
1981-11	1
1981-09	2
1987-07	2
1981-12	2
1981-12	2
1982-01	1
2021-03	5
2021-03	5
2021-03	5
2021-03	5
2021-03	5
*/

--여기까지 품

--[선생님 풀이]

SELECT ENAME, HIREDATE
FROM TBL_EMP
ORDER BY 2;
--==>>
/*
SMITH	1980-12-17
ALLEN	1981-02-20
WARD	1981-02-22
JONES	1981-04-02
BLAKE	1981-05-01
CLARK	1981-06-09
TURNER	1981-09-08
MARTIN	1981-09-28
KING	1981-11-17
FORD	1981-12-03
JAMES	1981-12-03
MILLER	1982-01-23
SCOTT	1987-07-13
ADAMS	1987-07-13
수지	2021-03-30
아이유	2021-03-30
정유미	2021-03-30
이제훈	2021-03-30
한지민	2021-03-30
*/

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
       , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1981-05	1
1981-12	2
1982-01	1
2021-03	5
1981-09	2
1981-02	2
1981-11	1
1980-12	1
1981-04	1
1987-07	2
1981-06	1
*/


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
       , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = 5; -- 5 → 인원수 확인~!!
--==>> 2021-03	5

SELECT COUNT(*)
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1
2
1
5
2
2
1
1
1
2
1
*/

SELECT MAX(COUNT(*))
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 5
--HAVING은 GROUP BY에 대한 조건절

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
       , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (); -- 5 → 인원수 확인~!!

-- 퐁당 집어넣기 
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
       , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                    FROM TBL_EMP
                    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')); -- 5 → 인원수 확인~!!

--==>> 2021-03	5

--------------------------------------------------------------------------------

--■■■ ROW_NUMBER() ■■■--

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "관찰" 
    , ENAME "사원명", SAL"급여", HIREDATE"입사일"
FROM EMP;


SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "관찰" 
    , ENAME "사원명", SAL"급여", HIREDATE"입사일"
FROM EMP
ORDER BY ENAME;

--※ 게시판의 게시물 번호를
--   SQUENCE 나 IDENTITY 를 사용하게 되면
--   게시물을 삭제했을 경우, 삭제한 게시물의 자리에
--   다음 번호를 가진 게시물이 등록되는 상황이 발생하게 된다.
--   이는, 보안측면에서나... 미관상.. 바람직하지 않은 상황일 수 있기 때문에
--   ROW_NUMBER() 의 사용을 고려해볼 수 있다.
--   관리의 목적으로 사용할 때에는 SEQUENCE 나 IDENTITY 를 사용하지만
--   단순히 게시물을 목록화하여 사용자에게 리스트 형식으로 보여줄 때에는
--   사용하지 않는 것이 좋다.

--※ 관찰

CREATE TABLE TBL_AAA
( NO    NUMBER
, NAME  VARCHAR2(40)
, GRADE CHAR
);
--==>> Table TBL_AAA이(가) 생성되었습니다.

INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(1, '선혜연', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(2, '이상화', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(3, '선혜연', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(4, '박민지', 'C');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(5, '이상화', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(6, '한혜림', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(7, '한혜림', 'B');
--==>> 1 행 이(가) 삽입되었습니다.

--커밋
COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_AAA;
--==>>
/*
1	선혜연	A
2	이상화	B
3	선혜연	B
4	박민지	C
5	이상화	A
6	한혜림	B
7	한혜림	B
*/

--○ SEQUENCE 생성 (시퀀스, 주문번호)
--   → 사전적인 의미 : 1. (일련의) 연속적인 사건들 2. (사건, 행동 등의) 순서

CREATE SEQUENCE SEQ_BOARD -- 시퀀스 기본 생성 구문(MSSQL 의 IDENTITTY 와 동일한 개념)
START WITH 1              -- 시작값
INCREMENT BY 1            -- 증가값
NOMAXVALUE                -- 최대값 제한 없음
NOCACHE;                  -- 캐시 사용 안함(없음)
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.


--○ 테이블 생성(TBL_BOARD)

CREATE TABLE TBL_BOARD              -- TBL_BOARD 이름의 테이블 생성 → 게시판
( NO        NUMBER                  -- 게시물 번호        Ⅹ 
, TITLE     VARCHAR2(50)            -- 게시물 제목        ○
, CONTENTS  VARCHAR2(2000)          -- 게시물 내용        ○
, NAME      VARCHAR2(20)            -- 게시물 작성자      △
, PW        VARCHAR2(20)            -- 게시물 패스워드    △
, CREATED   DATE DEFAULT SYSDATE    -- 게시물 작성일      Ⅹ
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.


--○ 데이터 입력 → 게시판에 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '앗싸~1등', '내가 1등이지롱~', '선혜연', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '건강관리', '다들 건강 챙깁시당', '이상화', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '오늘은', '저녁 뭐 먹지...', '박민지', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '오늘은', '미세먼지 없나?', '한혜림', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '공부하고싶은데', '집이너무멀어요', '김아별', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '질문있습니다', '쉬었다 하면 안되나요', '이유림', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '질문있습니다', '생각나면 다시 질문할께요', '이희주', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	앗싸~1등	    내가 1등이지롱~	            선혜연	JAVA006$	2021-03-31
2	건강관리	    다들 건강 챙깁시당	        이상화	JAVA006$	2021-03-31
3	오늘은	        저녁 뭐 먹지...	            박민지	JAVA006$	2021-03-31
4	오늘은	        미세먼지 없나?	            한혜림	JAVA006$	2021-03-31
5	공부하고싶은데	집이너무멀어요	            김아별	JAVA006$	2021-03-31
6	질문있습니다	쉬었다 하면 안되나요	    이유림	JAVA006$	2021-03-31
7	질문있습니다	생각나면 다시 질문할께요	이희주	JAVA006$	2021-03-31
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 게시물 삭제
SELECT *
FROM TBL_BOARD
WHERE NO=4;

DELETE
FROM TBL_BOARD
WHERE NO=4;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '졸려요', '전 그냥 잘래요', '이새롬', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=2;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO=8;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '저는요', '잘 지내고 있습니다', '장서현', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 확인
SELECT *
FROM TBL_BOARD;
/*
1	앗싸~1등	    내가 1등이지롱~	            선혜연	JAVA006$	2021-03-31
3	오늘은	        저녁 뭐 먹지...	            박민지	JAVA006$	2021-03-31
5	공부하고싶은데	집이너무멀어요	            김아별	JAVA006$	2021-03-31
6	질문있습니다	쉬었다 하면 안되나요	    이유림	JAVA006$	2021-03-31
7	질문있습니다	생각나면 다시 질문할께요	이희주	JAVA006$	2021-03-31
9	저는요	        잘 지내고 있습니다	        장서현	JAVA006$	2021-03-31
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
    , TITLE"제목", NAME"작성자", CREATED"작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
6	저는요	        장서현	2021-03-31
5	질문있습니다	이희주	2021-03-31
4	질문있습니다	이유림	2021-03-31
3	공부하고싶은데	김아별	2021-03-31
2	오늘은	        박민지	2021-03-31
1	앗싸~1등	    선혜연	2021-03-31
*/

--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '외로워도', '슬퍼도 나는 안울어', '박정준', 'JAVA006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
    , TITLE"제목", NAME"작성자", CREATED"작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO = 7;
--==>> 1 행 이(가) 삭제되었습니다.


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
    , TITLE"제목", NAME"작성자", CREATED"작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*  
6	외로워도	    박정준	2021-03-31
5	저는요	        장서현	2021-03-31
4	질문있습니다	이유림	2021-03-31
3	공부하고싶은데	김아별	2021-03-31
2	오늘은	        박민지	2021-03-31
1	앗싸~1등	    선혜연	2021-03-31
*/


