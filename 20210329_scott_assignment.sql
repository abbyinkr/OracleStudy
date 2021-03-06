SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT SYSDATE
FROM DUAL;
--==>> 21/03/29

--날짜 형식 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--> Session이(가) 변경되었습니다.


--○ 과제
--   본인이 태어나서 현재까지...
--   얼마만큼의 일, 시간, 분, 초를 살았는지...(살고있는지...)
--   조회하는 쿼리문을 구성한다.

/*
--------------------------------------------------------------------------------
 현재 시각              |  태어난 시각              | 일      | 시간 | 분 | 초 |
--------------------------------------------------------------------------------
2021-03-29 14:34:27     | 1993-03-08 12:30:00       | XXXXX   | XX   | XX | XX  |
--------------------------------------------------------------------------------
*/


SELECT SYSDATE "현재 시각"
     , TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS') "태어난 시각"
     , SYSDATE - TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS') "일수"
     , ()
FROM DUAL;

-- 『일수』 → 『초』 단위로 바꾸기
SELECT (SYSDATE - TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60) "초"
FROM DUAL;
--==>> 885453074.000000000000000000000000000001


SELECT TRUNC(MOD((SYSDATE - TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60),60)) "초"
FROM DUAL;


--예시로 234134초 계산해보기
SELECT MOD(234134,60) "초"
     , MOD(TRUNC(234134/60),60) "분"
     , MOD(TRUNC(TRUNC(234134/60)/60),24)"시"
     , TRUNC(TRUNC(TRUNC(234134/60)/60)/24) "일"
FROM DUAL;
--==>>
/*
14	2	17	2
*/

-- 초 단위로 계산한 구문 234134에 대입
SELECT TRUNC(MOD((SYSDATE - TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60),60)) "초"
     , MOD(TRUNC((SYSDATE - TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60)/60),60) "분"
     , MOD(TRUNC(TRUNC((SYSDATE - TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60)/60)/60),24)"시간"
     , TRUNC(TRUNC(TRUNC((SYSDATE - TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60)/60)/60)/24) "일"
FROM DUAL;


-- 문제 예시대로 컬럼 순서 정렬
SELECT SYSDATE "현재 시각"
     , TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS') "태어난 시각"
     , TRUNC(TRUNC(TRUNC((SYSDATE - TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60)/60)/60)/24) "일"
     , MOD(TRUNC(TRUNC((SYSDATE - TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60)/60)/60),24)"시간"
     , MOD(TRUNC((SYSDATE - TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60)/60),60) "분"
     ,TRUNC(MOD((SYSDATE - TO_DATE('1993-03-08 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))*(24*60*60),60)) "초"
FROM DUAL;
--==>>
/*
2021-03-29 19:59:19	1993-03-08 12:30:00	10248	7	29	19

--------------------------------------------------------------------------------
 현재 시각              |  태어난 시각              | 일      | 시간 | 분 | 초 |
--------------------------------------------------------------------------------
2021-03-29 19:59:19     | 1993-03-08 12:30:00       | 10248   | 7   | 29 | 19  |
--------------------------------------------------------------------------------

*/





