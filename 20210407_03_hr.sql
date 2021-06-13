SELECT USER
FROM DUAL;
--==>> HR

--�� EMPLOYEES ���̺��� ������ SALARY �� 10% �λ��Ѵ�.
--   ��, �μ����� 'IT'�� ���� �����Ѵ�.
--   (����� ����� Ȯ�� �� ROLLBACK)

SELECT *
FROM DEPARTMENTS;
--==>> 
/*
10	Administration	200	1700
20	Marketing	201	1800
30	Purchasing	114	1700
40	Human Resources	203	2400
50	Shipping	121	1500
60	IT	103	1400
70	Public Relations	204	2700
80	Sales	145	2500
90	Executive	100	1700
100	Finance	108	1700
110	Accounting	205	1700
120	Treasury		1700
130	Corporate Tax		1700
140	Control And Credit		1700
150	Shareholder Services		1700
160	Benefits		1700
170	Manufacturing		1700
180	Construction		1700
190	Contracting		1700
200	Operations		1700
210	IT Support		1700
220	NOC		1700
230	IT Helpdesk		1700
240	Government Sales		1700
250	Retail Sales		1700
260	Recruiting		1700
270	Payroll		1700
*/

SELECT *
FROM EMPLOYEES;

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID                  
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');


SELECT DEPARTMENT_ID"�μ���ȣ", SALARY"���� ��", SALARY * 1.1 "���� ��"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID                  
                         FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*
60	9000	9900
60	6000	6600
60	4800	5280
60	4800	5280
60	4200	4620
*/

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID                  
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 5�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- ���� �� ��ȸ
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID                  
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');


ROLLBACK;
--==>> �ѹ� �Ϸ�.

--�� EMPLOYEES ���̺��� JOBS_TITLE �� ��Sales Manager�� �� �������
--   SALARY �� �ش� ����(����)�� �ְ� �޿�(MAX_SALARY)�� �����Ѵ�.
--   ��, �Ի����� 2006�� ����(�ش� �⵵ ����) �Ի��ڿ� ���Ͽ�
--   ������ �� �ֵ��� ó���Ѵ�.
--   (������ �ۼ��Ͽ� ��� Ȯ�� �� ROLLBACK)

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager');

SELECT *
FROM JOBS;


SELECT MAX(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager');
--==>> 14000


SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND �Ի����� 2006�� ����(�ش� �⵵ ����) �Ի���;


SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;
  
UPDATE EMPLOYEES
   SET SALARY = (SELECT MAX_SALARY
                 FROM JOBS
                 WHERE JOB_TITLE = 'Sales Manager')
 WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
   AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;
--==>> 3�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
SELECT *
FROM EMPLOYEES;

ROLLBACK;
--==>> �ѹ� �Ϸ�.

--�� EMPLOYEES ���̺��� SALRARY �� 
--   �� �μ��� �̸����� �ٸ� �λ���� �����Ͽ� ������ �� �ֵ��� �Ѵ�.
--   Finance �� 10% 
--   Executive �� 15%
--   Accounting �� 20%
--   (������ �ۼ��Ͽ� ��� Ȯ�� �� ROLLBACK)
SELECT *
FROM DEPARTMENTS;

SELECT (SELECT SALARY
        FROM DEPARTMENTS
        WHERE DEPARTMENT_NAME = 'Finance') "Finance�λ� ��"
    
       ,(SELECT SALARY
        FROM DEPARTMENTS
        WHERE DEPARTMENT_NAME = 'Finance') *1.1 "Finance�λ� ��", DEPARTMENT_ID
FROM EMPLOYEES;
/*
WHERE DEPARTMENT_ID =ANY (SELECT DEPARTMENT_ID
                          FROM DEPARTMENTS
                          WHERE DEPARTMENT_NAME IN ('Finance','Executive','Accounting') );
*/

SELECT SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID =ANY (SELECT DEPARTMENT_ID
                          FROM DEPARTMENTS
                          WHERE DEPARTMENT_NAME IN ('Finance','Executive','Accounting') );
--==>> 
/*
24000	90
17000	90
17000	90
12008	100
9000	100
8200	100
7700	100
7800	100
6900	100
12008	110
8300	110
*/

--[������ Ǯ��]


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finance'�� �μ����̵�) 
                                THEN SALARY *1.1
                                WHEN ('Executive'�� �μ����̵�) 
                                THEN SALARY *1.15
                                WHEN ('Accounting'�� �μ����̵�) 
                                THEN SALARY *1.2
                                ELSE SALARY
             END;

--('Finance'�� �μ����̵�)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Finance';

--('Executive'�� �μ����̵�)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Executive';

--('Accounting'�� �μ����̵�)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Accounting';


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Finance') 
                                THEN SALARY *1.1
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                     WHERE DEPARTMENT_NAME = 'Executive') 
                                THEN SALARY *1.15
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME = 'Accounting') 
                                THEN SALARY *1.2
                                ELSE SALARY
             END;
--==>> 107�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

ROLLBACK;
--==>> �ѹ� �Ϸ�.

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Finance') 
                                THEN SALARY *1.1
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                     WHERE DEPARTMENT_NAME = 'Executive') 
                                THEN SALARY *1.15
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME = 'Accounting') 
                                THEN SALARY *1.2
             END
WHERE DEPARTMENT_ID =ANY (SELECT DEPARTMENT_ID
                          FROM DEPARTMENTS
                          WHERE DEPARTMENT_NAME IN ('Finance','Executive','Accounting') );             
--==>> 11�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

--(WHERE �������� �Ἥ �޸𸮸� �� �ۿø��°� �ٶ�����)

ROLLBACK;
--==>> �ѹ� �Ϸ�.

--���� DELETE ����--

-- 1. ���̺��� ������ ��(���ڵ�)�� �����ϴ� �� ����ϴ� ����.

-- 2. ���� �� ����
-- DELETE [FROM] ���̺��
-- [WHERE ������];


SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 198;

DELETE
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

ROLLBACK;
--==>> �ѹ� �Ϸ�

--�� EMPLOYEES ���̺��� �������� ������ �����Ѵ�.
--   ��, �μ����� 'IT'�� ���� �����Ѵ�.

--�� �����δ� EMPLOYEES ���̺��� �����Ͱ�(�����ϰ��� �ϴ� ���)
--   �ٸ� ���̺�(Ȥ�� �ڱ� �ڽ� ���̺�)�� ���� �������ϰ� �ִ� ���
--   �������� ���� �� �ִٴ� ����� �����ؾ� �ϸ�...
--   �׿� ���� ������ �˾ƾ� �Ѵ�.

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');

--==>> ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';

DELETE
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'DEPARTMENTS';

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'EMPLOYEES';

--[������ Ǯ��]

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ('IT'�� �μ���ȣ);

--('IT'�� �μ���ȣ)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';
--==>> 60

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');


DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> ���� �߻�
/*
ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*/

--���� ��(VIEW) ����--

-- 1. ��(VIEW)�� �̹� Ư���� �����ͺ��̽� ���� �����ϴ�
--    �ϳ� �̻��� ���̺��� ����ڰ� ��� ���Ѵ� �����͵鸸��
--    ��Ȯ�ϰ� ���ϰ� �������� ���Ͽ� ������ ���ϴ� �÷��鸸 ��Ƽ�
--    �������� ������ ���̺�� ���Ǽ� �� ���ȿ� ������ �ִ�.

-- ����: ����ڴ� ���̺�, �÷��� ��¥ �̸��� �� �� ����. ���ϴ� �÷��� ����ڿ��� ������ �� ����

--    ������ ���̺��̶� �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ϶�
--    �ϳ� �̻��� ���̺��� �Ļ��� �� �ٸ� ������ �� �� �ִ� ����̸�
--    �� ������ �����س��� SQL �����̶�� �� �� �ִ�.

-- 2. ���� �� ����
-- CREATE [OR REPLACE] VIEW ���̸�
-- [(ALIAS[, ALIAS, ...])]
-- AS
-- ��������(SUBQUERY)
-- [WITH CHECK OPTION]
-- [WITH READ ONLY];


--�� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME
     , D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
--==>> View VIEW_EMPLOYEES��(��) �����Ǿ����ϴ�.

--�� ��(VIEW) ��ȸ
SELECT *
FROM VIEW_EMPLOYEES;
--==>> View VIEW_EMPLOYEES��(��) �����Ǿ����ϴ�.

--�� ��(VIEW) ���� Ȯ��
DESC VIEW_EMPLOYEES;
--==>>
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY                     VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 

*/

--�� ��(VIEW) �ҽ� Ȯ��       -- CHECK~!!! �ڡ�
SELECT VIEW_NAME, TEXT        -- TEXT
FROM USER_VIEWS               -- USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';

/*
"SELECT E.FIRST_NAME, E.LAST_NAME
     , D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+)"
*/

--> �並 ������� ������ �״�� ���ͼ� �ٸ� ����� ����� Ȯ���ϱ� ������



