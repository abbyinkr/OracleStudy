SELECT USER
FROM DUAL;


SELECT DEPTNO"�μ���ȣ", SUM(SAL)"�޿���", GROUPING(DEPTNO)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN DEPTNO
            ELSE '���μ�'
        END "�μ���ȣ"
      , SUM(SAL)"�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
00932. 00000 -  "inconsistent datatypes: expected %s got %s"
*Cause:    
*Action:
11��, 18������ ���� �߻�
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
            ELSE '���μ�'
        END "�μ���ȣ"
      , SUM(SAL)"�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
(null)       8000
���μ�	37025
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '���μ�'
        END "�μ���ȣ"
      , SUM(SAL)"�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	        8750
20	        10875
30	        9400
����	    8000
���μ�	37025
*/


--�� TBL_SAWON ���̺��� ������ ���� ��ȸ�� �� �ֵ��� �������� �ۼ��Ѵ�.
/*
--------------------------------
     ����          �޿���
--------------------------------
      ��           XXXXXX
      ��           XXXXXX
    �����       XXXXXX
--------------------------------
*/

SELECT *
FROM TBL_SAWON;


SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','3') THEN '��'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4') THEN '��'
            ELSE '����Ȯ�κҰ�'
        END "����" 
FROM TBL_SAWON;



--[���� Ǯ��]
SELECT  CASE WHEN GROUPING(T.����) = 1 THEN '�����'
             ELSE T.����
        END "����"
        ,SUM(T.SAL)"�޿���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','3') THEN '��'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4') THEN '��'
                ELSE '����Ȯ�κҰ�'
            END "����" 
            ,SAL
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);


--[������ Ǯ��]
SELECT T.����"����"
       , SUM(T.�޿�)"�޿���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','3') THEN '��'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4') THEN '��'
                ELSE '����Ȯ�κҰ�'
            END "����"
         , SAL "�޿�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
��	12000
��	24100
(null)	36100
*/

SELECT CASE GROUPING(T.����) WHEN 0 THEN T.����
            ELSE '�����'
        END "����"
       , SUM(T.�޿�)"�޿���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','3') THEN '��'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4') THEN '��'
                ELSE '����Ȯ�κҰ�'
            END "����"
         , SAL "�޿�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
��	        12000
��	        24100
�����	36100
*/


SELECT *
FROM VIEW_SAWON;


--�� TBL_SAWON ���̺��� ������ ���� ���ɴ뺰 �ο��� ���·� 
--   ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
---------------------------
    ���ɴ�      �ο���
---------------------------
     10           X
     20           X
     30           X
     40           X 
     50           X
     ��ü         X
---------------------------

*/

SELECT CASE GROUPING(T.���ɴ�) WHEN 1 THEN '��ü'
             ELSE T.���ɴ�
        END"���ɴ�"
    , COUNT(T.���ɴ�)"�ο���"
FROM
(
    SELECT CASE WHEN ���糪��<20 THEN '1O'
                WHEN ���糪��<30 THEN '20'
                WHEN ���糪��<40 THEN '30'
                WHEN ���糪��<50 THEN '40'
                WHEN ���糪��<60 THEN '50'
                ELSE '0'
            END "���ɴ�"
            
    FROM VIEW_SAWON
) T
GROUP BY ROLLUP(T.���ɴ�);


SELECT CASE WHEN ���糪��<20 THEN '1O'
            WHEN ���糪��<30 THEN '20'
            WHEN ���糪��<40 THEN '30'
            WHEN ���糪��<50 THEN '40'
            WHEN ���糪��<60 THEN '50'
            ELSE '0'
        END "���ɴ�"
        
FROM VIEW_SAWON;
    
    
    
SELECT CASE GROUPING(T2.���ɴ�) WHEN 1 THEN '��ü'
             ELSE (T2.���ɴ�)
        END"���ɴ�"
    , COUNT(T2.���ɴ�)"�ο���"
FROM    
(    
    SELECT CASE WHEN T1.���糪��<20 THEN '1O'
                WHEN T1.���糪��<30 THEN '20'
                WHEN T1.���糪��<40 THEN '30'
                WHEN T1.���糪��<50 THEN '40'
                WHEN T1.���糪��<60 THEN '50'
                ELSE '0'
            END "���ɴ�"
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','2') THEN TO_CHAR(SYSDATE, 'YYYY') - SUBSTR(JUBUN, 1, 2) - 1899
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3','4') THEN TO_CHAR(SYSDATE, 'YYYY') - SUBSTR(JUBUN, 1, 2) - 1999
                    ELSE -1
                END"���糪��"
        FROM TBL_SAWON
    ) T1
) T2
GROUP BY ROLLUP(T2.���ɴ�);


--[������ Ǯ��]

--��� 1. (INLINE VIEW�� �ι� ��ø)


SELECT CASE GROUPING(Q.���ɴ�) WHEN 1 THEN '��ü'
             ELSE (Q.���ɴ�)
        END"���ɴ�"
    , COUNT(Q.���ɴ�)"�ο���"
FROM    
(    
    SELECT CASE WHEN T.����>=50 AND T.���� < 60 THEN '5O'
                WHEN T.����>=40 THEN '40'
                WHEN T.����>=30 THEN '30'
                WHEN T.����>=20 THEN '20'
                WHEN T.����>=10 THEN '10'
                ELSE '0'
            END "���ɴ�"
    FROM
    (
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','2') 
                THEN (EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1899))
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3','4') 
                THEN (EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1999))
                ELSE -1
            END"����"
    FROM TBL_SAWON
    ) T
)Q
GROUP BY ROLLUP(Q.���ɴ�);
--==>>
/*
10	    2
20	    11
40	    1
5O	    2
��ü	16
*/

--��� 2. (INLINE VIEW�� �� ���� ���)


SELECT TRUNC(CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE 0
        END, -1)"���ɴ�"
        
FROM TBL_SAWON
--> �������� INLINE VIEW

--�׽�Ʈ
SELECT TRUNC(20, -1)"Ȯ��1", TRUNC(30, -1)"Ȯ��2", TRUNC(39, -1)"Ȯ��3"
FROM DUAL;


--�� ROLLUP Ȱ�� �� CUBE
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
10	    (null)	    8750        -- 1O�� �μ� ��� ������ �޿���
20	    ANALYST 	6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    (null)	    10875       -- 2O�� �μ� ��� ������ �޿���
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    (null)	    9400        -- 3O�� �μ� ��� ������ �޿���
(null)	(null)	    29025       -- ��� �μ� ��� ������ �޿���
*/


--�� CUBE() �� ROLLUP() ���� �� �ڼ��� ����� ��ȯ���� �� �ִ�.

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (null)	    8750        -- 1O�� �μ� ��� ������ �޿���
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    (null)	   10875        -- 2O�� �μ� ��� ������ �޿���
30	    CLERK	     950
30	    MANAGER	    2850
30	    SALESMAN	5600
30		(null)      9400        -- 3O�� �μ� ��� ������ �޿���
(null)	ANALYST	    6000        -- ��� �μ� ANALYST ������ �޿���
(null)	CLERK	    4150        -- ��� �μ� CLERK ������ �޿���
(null)	MANAGER	    8275        -- ��� �μ� MANAGER ������ �޿���
(null)	PRESIDENT	5000        -- ��� �μ� PRESIDENT ������ �޿���
(null)	SALESMAN	5600        -- ��� �μ� SALESMAN ������ �޿���
(null)	(null)	   29025        -- ��� �μ� ��� ������ �޿���
*/

--�� ROLLUP() �� CUBE() �� 
--   �׷��� �����ִ� ����� �ٸ���. (����)

-- ROLLUP(A, B, C)
-- �� (A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- �� (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> ���� ó�� ������ ���ϴ� ����� ���� ���ϰų� �ʹ� ���� ������� ��µǱ� ������
--     ������ ���� ���¸� �� ���� ����Ѵ�.
--     ���� �ۼ��ϴ� ������ ��ȸ�ϰ��� �ϴ� �׷츸 ��GROUPING SETS����
--     �̿��Ͽ� �����ִ� ����̴�.

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
        END "�μ���ȣ"
      , CASE GROUPING(JOB)WHEN 0 THEN JOB
            ELSE '��ü����'
        END"����"
      , SUM (SAL)"�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    ��ü����	8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    ��ü����	10875
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    ��ü����	9400
����	CLERK	    2500
����	SALESMAN	5500
����	��ü����	8000
(null)	��ü����	37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
        END "�μ���ȣ"
        
      , CASE GROUPING(JOB)WHEN 0 THEN JOB
            ELSE '��ü����'
        END"����"
      , SUM (SAL)"�޿���"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    ��ü����	8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    ��ü����   10875
30	    CLERK	     950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    ��ü����	9400
����	CLERK	    2500
����	SALESMAN	5500
����	��ü����	8000
(null)	ANALYST	    6000
(null)	CLERK	    6650
(null)	MANAGER	    8275
(null)	PRESIDENT	5000
(null)	SALESMAN   11100
(null)	��ü����   37025
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
        END "�μ���ȣ"
      , CASE GROUPING(JOB)WHEN 0 THEN JOB
            ELSE '��ü����'
        END"����"
      , SUM (SAL)"�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ()) -- ROLLUP() �� ���� ���
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    ��ü����	8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    ��ü����	10875
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    ��ü����	9400
����	CLERK	    2500
����	SALESMAN	5500
����	��ü����	8000
(null)	��ü����	37025
*/



SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
        END "�μ���ȣ" 
      , CASE GROUPING(JOB)WHEN 0 THEN JOB
            ELSE '��ü����'
        END"����"
      , SUM (SAL)"�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ()) -- CUBE() �� ���� ���
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    ��ü����	8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    ��ü����   10875
30	    CLERK	     950
30	    MANAGER	    2850
30	    SALESMAN	5600
30	    ��ü����	9400
����	CLERK	    2500
����	SALESMAN	5500
����	��ü����	8000
(null)	ANALYST	    6000
(null)	CLERK	    6650
(null)	MANAGER	    8275
(null)	PRESIDENT	5000
(null)	SALESMAN   11100
(null)	��ü����   37025
*/

--�� TBL_EMP ���̺��� �Ի�⵵�� �ο����� ��ȸ�Ѵ�.

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.



/*
--------------------------
  �Ի�⵵      �ο���
--------------------------
   1980            1
   1981           10
   1982            1
   1987            2
   2021            5
   ��ü           19
--------------------------
*/

SELECT CASE GROUPING(T.�Ի�⵵) WHEN 1 THEN '��ü'
             ELSE TO_CHAR(T.�Ի�⵵)
        END"�Ի�⵵"
    , COUNT(T.�Ի�⵵)"�ο���"
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE)"�Ի�⵵"
    FROM TBL_EMP
    
)T
GROUP BY ROLLUP(T.�Ի�⵵)
ORDER BY 1;

--GROUPING SETS ���

SELECT CASE GROUPING(T.�Ի�⵵) WHEN 1 THEN '��ü'
             ELSE TO_CHAR(T.�Ի�⵵)
        END"�Ի�⵵"
    , COUNT(T.�Ի�⵵)"�ο���"
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE)"�Ի�⵵"
    FROM TBL_EMP
    
)T
GROUP BY GROUPING SETS((T.�Ի�⵵), ())
ORDER BY 1;

--[������ Ǯ��]

SELECT EXTRACT(YEAR FROM HIREDATE)"�Ի�⵵"
      , COUNT(*)"�ο���"
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

SELECT EXTRACT(YEAR FROM HIREDATE)"�Ի�⵵"
      , COUNT(*)"�ο���"
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

SELECT EXTRACT(YEAR FROM HIREDATE)"�Ի�⵵"
      , COUNT(*)"�ο���"
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

SELECT EXTRACT(YEAR FROM HIREDATE)"�Ի�⵵"
      , COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
580��, 26������ ���� �߻�
*/

SELECT EXTRACT(YEAR FROM HIREDATE)"�Ի�⵵"
      , COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> ���� �߻�
/*
ORA-00979: not a GROUP BY expression
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
580��, 26������ ���� �߻�
*/

SELECT TO_CHAR(HIREDATE, 'YYYY')"�Ի�⵵"   -- Ÿ��
      , COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))   -- ����
ORDER BY 1;


SELECT TO_CHAR(HIREDATE, 'YYYY')"�Ի�⵵"     -- Ÿ��
      , COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))   -- ����
ORDER BY 1;
--==>> �����߻� 

-->> SELECT �� GROUP BY�� ������� �� �°� �޾Ƽ� �� �� Ÿ�� ���� �ʿ� ��



--------------------------------------------------------------------------------

--���� HAVING ����--

--�� EMP ���̺��� �μ���ȣ�� 20, 30�� �μ��� �������
--   �μ��� �� �޿��� 10000 ���� ���� ��츸 �μ��� �� �޿��� ��ȸ�Ѵ�.


SELECT *
FROM EMP
WHERE DEPTNO IN (20,30)

SELECT CASE GROUPING(DEPTNO) WHEN 1 THEN '��ü�μ�'
            ELSE TO_CHAR(DEPTNO)
       END"�μ�"
    ,SUM(SAL)"�޿���"
FROM EMP
WHERE DEPTNO IN (20,30)
GROUP BY ROLLUP(DEPTNO);


SELECT CASE GROUPING(DEPTNO) WHEN 1 THEN '��ü�μ�'
            ELSE TO_CHAR(DEPTNO)
       END"�μ�"
    ,SUM(SAL)"�޿���"
FROM EMP
WHERE DEPTNO IN (20,30) AND SUM(SAL)<10000
GROUP BY ROLLUP(DEPTNO);
-->> ���� �߻�


--[������ Ǯ��]


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
ORA-00934: group function is not allowed here           ->  WHERE���� �׷��Լ��� ���� ���Ѵ�. ��
00934. 00000 -  "group function is not allowed here"
*Cause:    
*Action:
653��, 4������ ���� �߻�
*/


SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000;
--==>> 30	9400

-- ������ WHERE �������̶� ����, HAVING�� GROUP BY�� ���� ������


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO IN (20,30)
   AND SUM(SAL) < 10000;
--==>> 30	9400
-- BUT. WHERE �������� ���°��� �� �ٶ����� ��
-- 1�������� WHERE �������� ���� �޸𸮿� �ۿø��� ������...
-- �Ⱦ��� ��ü�� �ۿø��ϱ� WHERE�� ���� ���� �����̶� �޸𸮸� �� �� �� �ִ�.

--------------------------------------------------------------------------------

--���� ��ø �׷��Լ� / �м��Լ� ����--

-- �׷� �Լ� 2 LEVEL ���� ��ø�ؼ� ����� �� �ִ�.
-- �� ������ MS-SQL�� �Ұ����ϴ�.

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;

-- RANK()
-- DENSE_RANK() 
--> ORACLE 9i ���� ����... MSSQL 2005 ���� ����

--�� ���� ���������� RANK() �� DENSE_RANK()�� ����� �� ���� ������
--   �̸� ��ü�Ͽ� ������ ������ �� �ִ� ����� �����ؾ� �Ѵ�.


-- ���� ���, �޿��� ������ ���ϰ��� �Ѵٸ�...
-- �ش� ����� �޿����� �� ū ���� �� ������ Ȯ���� ��
-- �� Ȯ���� ���ڿ� + 1 �� �߰� �������ָ� �װ��� �� ����� �ȴ�.
SELECT ENAME, SAL, 1
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;     -- SMITH �� �޿�
--==>> 14 �� SMITH �� �޿� ���


SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;    -- ALLEN �� �޿�
--==>> 7 �� SMITH �� �޿� ��� 

SELECT ENAME, SAL, 1
FROM EMP;


--�� ���� ��� ���� (��� ���� ����)
--   ���� ������ �ִ� ���̺��� �÷���
--   ���� ������ ������(WHERE��, HAVING��)�� ���Ǵ� ���
--   �츮�� �� �������� ���� ��� ���� ��� �θ���.

SELECT ENAME "�����", SAL "�޿�", 1 "�޿����"
FROM EMP;


SELECT ENAME "�����", SAL "�޿�", (1) "�޿����"
FROM EMP;


SELECT ENAME "�����", SAL "�޿�"
     , (SELECT COUNT(*) +1
          FROM EMP 
          WHERE SAL > 800) "�޿����"
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


SELECT ENAME "�����", SAL "�޿�"
     , (SELECT COUNT(*) +1
          FROM EMP E2 
          WHERE SAL > 800) "�޿����"
FROM EMP E1;


SELECT ENAME "�����", SAL "�޿�"
     , (SELECT COUNT(*) +1
          FROM EMP E2 
          WHERE E2.SAL > E1.SAL) "�޿����"
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


SELECT ENAME "�����", SAL "�޿�"
     , (SELECT COUNT(*) +1
          FROM EMP E2 
          WHERE E2.SAL > E1.SAL) "�޿����"
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

--�� EMP ���̺��� �������
--   �����, �޿�, �μ���ȣ, �μ����޿����, ��ü�޿���� �׸��� ��ȸ�Ѵ�.
--   ��, RANK() �Լ��� ������� �ʰ�, ���� ��� ������ Ȱ���� �� �ֵ��� �Ѵ�.

SELECT *
FROM EMP;


SELECT ENAME "�����"
      , SAL "�޿�"
      , DEPTNO "�μ���ȣ"
FROM EMP E1;


SELECT ENAME "�����"
      , SAL "�޿�"
      , DEPTNO "�μ���ȣ"
      , (SELECT  COUNT(*) + 1
         FROM EMP E2
         WHERE E2.SAL > E1.SAL
        ) "��ü�޿����"
FROM EMP E1
ORDER BY 3;


SELECT ENAME "�����"
      , SAL "�޿�"
      , DEPTNO "�μ���ȣ"
      , (SELECT COUNT(*) + 1
         FROM EMP E2
         WHERE E2.SAL > E1.SAL AND E1.DEPTNO = E2.DEPTNO
        ) "�μ����޿����"
      , (SELECT  COUNT(*) + 1
         FROM EMP E2
         WHERE E2.SAL > E1.SAL
        ) "��ü�޿����"
FROM EMP E1
ORDER BY 3, 4;


--[������ Ǯ��]


SELECT ENAME "�����"
      , SAL "�޿�"
      , DEPTNO "�μ���ȣ"
      , (SELECT COUNT(*) + 1
         FROM EMP E2 
         WHERE E2.DEPTNO = E1.DEPTNO AND E2.SAL > E1.SAL) "�μ����޿����"
      , (SELECT COUNT(*) + 1
         FROM EMP E2
         WHERE E2.SAL > E1.SAL) "��ü�޿����"
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

--�� EMP ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
--------------------------------------------------------------------------
   �����      �μ���ȣ     �Ի���      �޿�       �μ����Ի纰�޿�����
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


SELECT EMPNO "�����"
       , DEPTNO "�μ���ȣ"
       , HIREDATE "�Ի���"
       , SAL "�޿�"
       ,(SELECT SUM(E2.SAL)
         FROM EMP E2
         WHERE E1.DEPTNO = E2.DEPTNO 
           AND E2.HIREDATE <= E1.HIREDATE) "�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY DEPTNO, HIREDATE;


--[������ Ǯ��]

SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL"�޿�"
      , 1 "�μ����Ի纰�޿�����"
FROM EMP
ORDER BY 2, 3;


SELECT E1.ENAME "�����", E1.DEPTNO "�μ���ȣ", E1.HIREDATE "�Ի���", E1.SAL"�޿�"
      , (SELECT SUM(E2.SAL)
         FROM EMP E2) "�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY 2, 3;


SELECT E1.ENAME "�����", E1.DEPTNO "�μ���ȣ", E1.HIREDATE "�Ի���", E1.SAL"�޿�"
      , (SELECT SUM(E2.SAL)
         FROM EMP E2
         WHERE E2.DEPTNO = E1.DEPTNO
          AND E2.HIREDATE <= E1.HIREDATE) "�μ����Ի纰�޿�����"
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


--�� TBL_EMP ���̺��� �Ի��� ����� ���� ���� ������ ����
--   �Ի����� �ο����� ��ȸ�� �� �ִ� �������� �����Ѵ�.

/*
-----------------------
 �Ի���      �ο���
-----------------------
  XXXX-XX       XX 
-----------------------
*/

SELECT *
FROM TBL_EMP
ORDER BY 2;


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
        ,(SELECT COUNT(*)
          FROM TBL_EMP E2
          WHERE (TO_CHAR(E2.HIREDATE, 'YYYY-MM') = TO_CHAR(E1.HIREDATE, 'YYYY-MM'))
          ) "�ο���"
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

--������� ǰ

--[������ Ǯ��]

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
����	2021-03-30
������	2021-03-30
������	2021-03-30
������	2021-03-30
������	2021-03-30
*/

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
       , COUNT(*)"�ο���"
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


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
       , COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = 5; -- 5 �� �ο��� Ȯ��~!!
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
--HAVING�� GROUP BY�� ���� ������

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
       , COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (); -- 5 �� �ο��� Ȯ��~!!

-- ���� ����ֱ� 
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
       , COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                    FROM TBL_EMP
                    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')); -- 5 �� �ο��� Ȯ��~!!

--==>> 2021-03	5

--------------------------------------------------------------------------------

--���� ROW_NUMBER() ����--

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "����" 
    , ENAME "�����", SAL"�޿�", HIREDATE"�Ի���"
FROM EMP;


SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "����" 
    , ENAME "�����", SAL"�޿�", HIREDATE"�Ի���"
FROM EMP
ORDER BY ENAME;

--�� �Խ����� �Խù� ��ȣ��
--   SQUENCE �� IDENTITY �� ����ϰ� �Ǹ�
--   �Խù��� �������� ���, ������ �Խù��� �ڸ���
--   ���� ��ȣ�� ���� �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰ� �ȴ�.
--   �̴�, �������鿡����... �̰���.. �ٶ������� ���� ��Ȳ�� �� �ֱ� ������
--   ROW_NUMBER() �� ����� ����غ� �� �ִ�.
--   ������ �������� ����� ������ SEQUENCE �� IDENTITY �� ���������
--   �ܼ��� �Խù��� ���ȭ�Ͽ� ����ڿ��� ����Ʈ �������� ������ ������
--   ������� �ʴ� ���� ����.

--�� ����

CREATE TABLE TBL_AAA
( NO    NUMBER
, NAME  VARCHAR2(40)
, GRADE CHAR
);
--==>> Table TBL_AAA��(��) �����Ǿ����ϴ�.

INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(1, '������', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(2, '�̻�ȭ', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(3, '������', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(4, '�ڹ���', 'C');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(5, '�̻�ȭ', 'A');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(6, '������', 'B');
INSERT INTO TBL_AAA(NO, NAME, GRADE) VALUES(7, '������', 'B');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT *
FROM TBL_AAA;
--==>>
/*
1	������	A
2	�̻�ȭ	B
3	������	B
4	�ڹ���	C
5	�̻�ȭ	A
6	������	B
7	������	B
*/

--�� SEQUENCE ���� (������, �ֹ���ȣ)
--   �� �������� �ǹ� : 1. (�Ϸ���) �������� ��ǵ� 2. (���, �ൿ ����) ����

CREATE SEQUENCE SEQ_BOARD -- ������ �⺻ ���� ����(MSSQL �� IDENTITTY �� ������ ����)
START WITH 1              -- ���۰�
INCREMENT BY 1            -- ������
NOMAXVALUE                -- �ִ밪 ���� ����
NOCACHE;                  -- ĳ�� ��� ����(����)
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.


--�� ���̺� ����(TBL_BOARD)

CREATE TABLE TBL_BOARD              -- TBL_BOARD �̸��� ���̺� ���� �� �Խ���
( NO        NUMBER                  -- �Խù� ��ȣ        �� 
, TITLE     VARCHAR2(50)            -- �Խù� ����        ��
, CONTENTS  VARCHAR2(2000)          -- �Խù� ����        ��
, NAME      VARCHAR2(20)            -- �Խù� �ۼ���      ��
, PW        VARCHAR2(20)            -- �Խù� �н�����    ��
, CREATED   DATE DEFAULT SYSDATE    -- �Խù� �ۼ���      ��
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.


--�� ������ �Է� �� �Խ��ǿ� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ѽ�~1��', '���� 1��������~', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ǰ�����', '�ٵ� �ǰ� ì��ô�', '�̻�ȭ', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '���� �� ����...', '�ڹ���', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '�̼����� ����?', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����ϰ������', '���̳ʹ��־��', '��ƺ�', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����ֽ��ϴ�', '������ �ϸ� �ȵǳ���', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����ֽ��ϴ�', '�������� �ٽ� �����Ҳ���', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	�ѽ�~1��	    ���� 1��������~	            ������	JAVA006$	2021-03-31
2	�ǰ�����	    �ٵ� �ǰ� ì��ô�	        �̻�ȭ	JAVA006$	2021-03-31
3	������	        ���� �� ����...	            �ڹ���	JAVA006$	2021-03-31
4	������	        �̼����� ����?	            ������	JAVA006$	2021-03-31
5	�����ϰ������	���̳ʹ��־��	            ��ƺ�	JAVA006$	2021-03-31
6	�����ֽ��ϴ�	������ �ϸ� �ȵǳ���	    ������	JAVA006$	2021-03-31
7	�����ֽ��ϴ�	�������� �ٽ� �����Ҳ���	������	JAVA006$	2021-03-31
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �Խù� ����
SELECT *
FROM TBL_BOARD
WHERE NO=4;

DELETE
FROM TBL_BOARD
WHERE NO=4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '�� �׳� �߷���', '�̻���', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=2;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO=8;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���¿�', '�� ������ �ֽ��ϴ�', '�弭��', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
/*
1	�ѽ�~1��	    ���� 1��������~	            ������	JAVA006$	2021-03-31
3	������	        ���� �� ����...	            �ڹ���	JAVA006$	2021-03-31
5	�����ϰ������	���̳ʹ��־��	            ��ƺ�	JAVA006$	2021-03-31
6	�����ֽ��ϴ�	������ �ϸ� �ȵǳ���	    ������	JAVA006$	2021-03-31
7	�����ֽ��ϴ�	�������� �ٽ� �����Ҳ���	������	JAVA006$	2021-03-31
9	���¿�	        �� ������ �ֽ��ϴ�	        �弭��	JAVA006$	2021-03-31
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
    , TITLE"����", NAME"�ۼ���", CREATED"�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
6	���¿�	        �弭��	2021-03-31
5	�����ֽ��ϴ�	������	2021-03-31
4	�����ֽ��ϴ�	������	2021-03-31
3	�����ϰ������	��ƺ�	2021-03-31
2	������	        �ڹ���	2021-03-31
1	�ѽ�~1��	    ������	2021-03-31
*/

--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ܷο���', '���۵� ���� �ȿ��', '������', 'JAVA006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
    , TITLE"����", NAME"�ۼ���", CREATED"�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;

--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO = 7;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
    , TITLE"����", NAME"�ۼ���", CREATED"�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*  
6	�ܷο���	    ������	2021-03-31
5	���¿�	        �弭��	2021-03-31
4	�����ֽ��ϴ�	������	2021-03-31
3	�����ϰ������	��ƺ�	2021-03-31
2	������	        �ڹ���	2021-03-31
1	�ѽ�~1��	    ������	2021-03-31
*/


