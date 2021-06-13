SELECT USER
FROM DUAL;
--==>> HR

--�� �� �� �̻��� ���̺� ����(JOIN)

-- ����1(SQL 1992 CODE)

SELECT ���̺���1.�÷���, ���̺���2.�÷���, ���̺���3.�÷���
FROM ���̺���1, ���̺���2, ���̺���3
WHERE ���̺���1.�÷���1 = ���̺���2.�÷���1 
  AND ���̺���2.�÷���2 = ���̺���3.�÷���2;

-- ����2(SQL 1999 CODE)
SELECT ���̺���1.�÷���, ���̺���2.�÷���, ���̺���3.�÷���
FROM ���̺���1 JOIN ���̺���2
ON ���̺���1.�÷���1 = ���̺���2.�÷���1
        JOIN ���̺���3
        ON ���̺���2.�÷���2 = ���̺���3.�÷���2;
        
--�� HR ���� ������ ���̺� �Ǵ� �� ��� ��ȸ
SELECT *
FROM TAB;
--==>>
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS	            TABLE	
*/

--�� HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS ���̺��� �������
--   �������� FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME
--   �׸��� ��ȸ�Ѵ�.
SELECT *
FROM HR.JOBS;
-- ������� JOB_ID
SELECT *
FROM HR.EMPLOYEES;
-- ������� DEPARTMENT_ID
SELECT *
FROM HR.DEPARTMENTS;



--���1.
SELECT  E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J , EMPLOYEES E, DEPARTMENTS D
WHERE J.JOB_ID = E.JOB_ID
  AND E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--���2.
SELECT  E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J JOIN EMPLOYEES E
ON  J.JOB_ID = E.JOB_ID
            JOIN DEPARTMENTS D
            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;        
-->> 106���� �����͸� ��ȸ��, �ϳ� ����!        

--[������ Ǯ��]
SELECT  E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J , EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND  J.JOB_ID = E.JOB_ID;

SELECT  E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON  E.DEPARTMENT_ID = D.DEPARTMENT_ID
             JOIN JOBS J
             ON J.JOB_ID = E.JOB_ID;
    
--�� EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS ���̺��� �������
--   �������� �����͸� ������ ���� ��ȸ�Ѵ�.
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME
--  , CITY, COUNTRY_NAME, REGION_NAME
        
SELECT *
FROM HR.JOBS;
-- ������� JOB_ID
SELECT *
FROM HR.EMPLOYEES;
-- ������� DEPARTMENT_ID
SELECT *
FROM HR.DEPARTMENTS;
-- ������� LOCATION_ID
SELECT *
FROM LOCATIONS;
-- ������� COUNTRY_ID
SELECT *
FROM COUNTRIES; 
-- ������� REGION_ID
SELECT *
FROM REGIONS;

SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE,D.DEPARTMENT_NAME
      , L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
 AND  E.JOB_ID = J.JOB_ID 
 AND  D.LOCATION_ID = L.LOCATION_ID(+)
 AND  L.COUNTRY_ID = C.COUNTRY_ID(+)
 AND  C.REGION_ID = R.REGION_ID(+);


SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
      , L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
       JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
            LEFT JOIN LOCATIONS L
            ON D.LOCATION_ID = L.LOCATION_ID
                LEFT JOIN COUNTRIES C
                ON  L.COUNTRY_ID = C.COUNTRY_ID
                     LEFT JOIN REGIONS R
                     ON C.REGION_ID = R.REGION_ID; 
