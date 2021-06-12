SELECT USER
FROM DUAL;
--==>> SCOTT


--���� JOIN(����) ����--

-- 1. SQL 1992 CODE 
SELECT *
FROM EMP, DEPT;
--> ���п��� ���ϴ� ��ī��Ʈ ��(Catersian Product)
-- �� ���̺��� ��ģ(������) ��� ����� ��

-- Equi join : ���� ��Ȯ�� ��ġ�ϴ� �����͵鳢�� �����Ű�� ����

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- Non Equi join : �������� �ȿ� ������ �����͵鳢�� �����Ű�� ����

SELECT *
FROM SALGRADE;
SELECT *
FROM EMP;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- Equi Join  �� ��+���� Ȱ���� ���� ���

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� 14���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ�� ���� ���� �����(5��)�� ��� ����~!!!

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--    E�� ���� �ۿø��� ----- D�� �߰��� ���δ�!
--  �� 19���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ�� ���� ���� �����(5��)�� ��� ��ȸ�� ��Ȳ~!!!

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> �� 16���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
-- ��, �μ��� �Ҽӵ� ����� �ƹ��� ���� �μ��� ��� ��ȸ�� ��Ȳ~!!!

--�� (+)�� ���� �� ���̺��� �����͸� ��� �޸𸮿� ������ ��
--   (+)�� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·�
--   JOIN�� �̷������.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--==>> ���� �߻� (�� �� �߰������͸� ���ε����ʹ� ���?)
--> ���� ���� ������ �̷��� ������ JOIN ������ �������� �ʴ´�.


-- 1. SQL 1999 CODE �� ��JOIN�� Ű���� ���� �� JOIN ���� ���
--                      ���� ������ ��WHERE�� ��� ��ON�� (WHERE�� ���� �򰥸��ϱ�)

-- CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;
--> ��ī��Ʈ ��(��� ����� ��)

-- INNER JOIN 

SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--�� INNER JOIN �� INNER �� ���� ����
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

--Equi, Non Equi ��� INNER JOIN ���� ����

-- OUTER JOIN
--> qui join (+) ����  
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D 
ON E.DEPTNO = D.DEPTNO;
--(+)���� �򰥸��ϱ� ���ְ� ������ FROM �� ����, ���������� ���ϱ� 

--�� ������ ������ �� ���̺�(�� LEFT)�� �����͸� ��� �޸𸮿� ������ ��
--   ������ �������� ���� ���� ���̺���� �����͸� ���� Ȯ���Ͽ� ���ս�Ű�� ���·�
--   JOIN�� �̷������.

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
-- �� �� ����~!

--�� OUTER JOIN���� OUTER �� ���� ����

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
--  �� ������� ... ������ CLERK �� ����鸸 ��ȸ

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
-- �̷��� �������� �����ص� ��ȸ�ϴµ��� ������ ����.

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
-- ������, �̿� ���� �����Ͽ� ��ȸ�� �� �ֵ��� �����Ѵ�.
-- ON�� ������ ����.. �������� ON �� �������� WHERE �� �����ؼ� ����Ѵ�.

--------------------------------------------------------------------------------

--�� EMP ���̺�� DEPT ���̺��� ������� 
--   ������ MANAGER �� CLERK �� ����鸸
--   �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.
SELECT *
FROM EMP;
SELECT *
FROM DEPT;

SELECT E.DEPTNO"�μ���ȣ", D.DNAME"�μ���", E.ENAME"�����"
     , E.JOB"������", E.SAL"�޿�"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB IN ('MANAGER', 'CLERK');


--[������ Ǯ��]

--�� EMP ���̺�� DEPT ���̺��� ������� 
--   ������ MANAGER �� CLERK �� ����鸸
--   �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.
--   --------  ------  ------  ------  ----
--   DEPTNO    DNAME    ENAME   JOB     SAL
--   -------   -----   -------  ----    ---
---   E,D        D        E      E       E
--> ���� ����, ������ ��ġ Ȯ��

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==> ���� �߻�
/*
ORA-00918: column ambiguously defined
00918. 00000 -  "column ambiguously defined"
*Cause:    
*Action:
180��, 8������ ���� �߻�
*/
--> �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺���
--  �������(��������) �Ѵ�.

SELECT DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� ���̺� �� �ߺ��Ǵ� �÷��� �������� �ʴ� ��ȸ ������
-- ���� �߻����� �ʴ´�.
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
--> �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--  �μ�(DEPT), ���(EMP) �� � ���̺��� �����ص�
--  ������ ���࿡ ���� ��� ��ȯ�� ������ ����.

-- �� ������...
-- �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
-- �θ� ���̺��� �÷��� ������ �� �ֵ��� �ؾ� �Ѵ�.

SELECT *
FROM DEPT;      -- �θ� ���̺�
SELECT *
FROM EMP;       -- �ڽ� ���̺�

--�� �θ� �ڽ� ���̺� ���踦 ��Ȯ�� ������ �� �ֵ��� �Ѵ�.

--        �����

--        DEPTNO
-- EMP ------------ DEPT 

-- ����� ���� �ߺ��Ǵ� ���̺��� �ڽ�~~


SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--> �ڽ����̺� �÷����� �μ���ȣ 40�� ����

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;


-- ���� ����
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� ���̺� �� �ߺ��� �÷��� �ƴϴ���..
--  �Ҽ� ���̺��� ����� �� �ֵ��� �����Ѵ�.
--  ����Ŭ�� �� �� ���̺��� �ѷ����� ���� �����ʰ� �ϱ� ����!

--�� SELF JOIN (�ڱ� ����)
-- EMP ���̺��� ������ ������ ���� ��ȸ �� �� �ֵ��� �Ѵ�.
--     E      E      E        E         E           E
--  EMPNO   ENAME   JOB      MGR                               --�� �� E1
--                           EMPNO     ENAME       JOB         --�� �� E2
-----------------------------------------------------------------
-- �����ȣ ����� ������ �����ڹ�ȣ �����ڸ� ������������ 
-----------------------------------------------------------------
--    7369  SMITH  CLERK     7902     FORD      ANALYST
SELECT *
FROM EMP;

SELECT E1.EMPNO"�����ȣ", E1.ENAME"�����", E1.JOB"����", E1.MGR"�����ڹ�ȣ"
     , E2.ENAME"�����ڸ�", E2.JOB"������������"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;


--[������ Ǯ��]

SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������" -- E1.MGR "�����ڹ�ȣ"
     , E2.EMPNO "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;

SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������" -- E1.MGR "�����ڹ�ȣ"
     , E2.EMPNO "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;

