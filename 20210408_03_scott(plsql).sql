SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;
--==>> �۾��� �Ϸ�Ǿ����ϴ�.

--�� SCOTT.TBL_INSA ���̺��� ���� ���� ������ ���� ���� ������ ����
--   (�ݺ��� Ȱ�� ���)
DECLARE
    VINSA   TBL_INSA%ROWTYPE;
    VNUM    TBL_INSA.NUM%TYPE := 1001;
BEGIN

    LOOP
        SELECT NAME, TEL, BUSEO
          INTO VINSA.NAME, VINSA.TEL, VINSA.BUSEO
        FROM TBL_INSA
        WHERE NUM = VNUM;
        
        DBMS_OUTPUT.PUT_LINE(VINSA.NAME || ' - ' || VINSA.TEL || ' - ' || VINSA.BUSEO);
        
        EXIT WHEN VNUM >= 1060;
        
        VNUM := VNUM + 1;       -- VNUM �� 1��ŭ ����

                
    END LOOP;

END;
--==>>
/*
ȫ�浿 - 011-2356-4528 - ��ȹ��
�̼��� - 010-4758-6532 - �ѹ���
�̼��� - 010-4231-1236 - ���ߺ�
������ - 019-5236-4221 - ������
�Ѽ��� - 018-5211-3542 - �ѹ���
�̱��� - 010-3214-5357 - ���ߺ�
����ö - 011-2345-2525 - ���ߺ�
�迵�� - 016-2222-4444 - ȫ����
������ - 019-1111-2222 - �λ��
������ - 011-3214-5555 - ������
������ - 010-8888-4422 - ������
���ѱ� - 018-2222-4242 - ȫ����
���̼� - 019-6666-4444 - ȫ����
Ȳ���� - 010-3214-5467 - ���ߺ�
������ - 016-2548-3365 - �ѹ���
�̻��� - 010-4526-1234 - ���ߺ�
����� - 010-3254-2542 - ���ߺ�
�̼��� - 018-1333-3333 - ���ߺ�
�ڹ��� - 017-4747-4848 - �λ��
������ - 011-9595-8585 - �����
ȫ�泲 - 011-9999-7575 - ���ߺ�
�̿��� - 017-5214-5282 - ��ȹ��
���μ� -  - ������
�踻�� - 011-5248-7789 - ��ȹ��
����� - 010-4563-2587 - ������
����� - 010-2112-5225 - ������
�迵�� - 019-8523-1478 - �ѹ���
�̳��� - 016-1818-4848 - �λ��
�踻�� - 016-3535-3636 - �ѹ���
������ - 019-6564-6752 - �ѹ���
����ȯ - 019-5552-7511 - ��ȹ��
�ɽ��� - 016-8888-7474 - �����
��̳� - 011-2444-4444 - ������
������ - 011-3697-7412 - ��ȹ��
������ -  - ���ߺ�
���翵 - 011-9999-9999 - �����
�ּ��� - 011-7777-7777 - ȫ����
���μ� - 010-6542-7412 - ������
����� - 010-2587-7895 - ������
�ڼ��� - 016-4444-7777 - �λ��
����� - 016-4444-5555 - �����
ä���� - 011-5125-5511 - ���ߺ�
��̿� - 016-8548-6547 - ������
����ȯ - 011-5555-7548 - ������
ȫ���� - 011-7777-7777 - ������
���� - 017-3333-3333 - �ѹ���
�긶�� - 018-0505-0505 - ������
�̱�� -  - ���ߺ�
�̹̼� - 010-6654-8854 - ���ߺ�
�̹��� - 011-8585-5252 - ȫ����
�ǿ��� - 011-5555-7548 - ������
�ǿ��� - 010-3644-5577 - ��ȹ��
��̽� - 011-7585-7474 - �����
����ȣ - 016-1919-4242 - ȫ����
���ѳ� - 016-2424-4242 - ������
������ - 010-7549-8654 - ������
�̹̰� - 016-6542-7546 - �����
����� - 010-2415-5444 - ��ȹ��
�Ӽ��� - 011-4151-4154 - ���ߺ�
��ž� - 011-4151-4444 - ���ߺ�


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--------------------------------------------------------------------------------

--���� FUNTION(�Լ�) ����--

-- 1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--    �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ �ϴµ� ���ȴ�.
--    ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--    ���� ������ �Լ��� ���� �� �ִ�. (������ ���� �Լ�)
--    �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
--    ���� ���ν���ó�� EXECUTE ���� ���� ������ �� �ִ�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] FUNCTION �Լ���
[(
    �Ű�����1 �ڷ���
  , �Ű�����2 �ڷ���
)]
RETURN ������Ÿ��
IS
    -- �ֿ� ���� ����(���� ����)
    
BEGIN  
    -- ���๮;
    ...
    RETURN ��;
    
    [EXCEPTION]
        -- ����ó�� ����
END;
*/

--�� ����� �����Լ�(������ �Լ�)��
--   IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--   �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN ���� �����ؾ� �ϰ�
--   FUNCTION�� �ݵ�� ���� ���� ��ȯ�ȴ�.

--�� TBL_INSA ���̺��� �������
--   �ֹι�ȣ�� ������ ������ ��ȸ�Ѵ�.
SELECT NAME, SSN, DECODE(SUBSTR(SSN,8,1), '1', '����', '2', '����', 'Ȯ�κҰ�' ) "����"
FROM TBL_INSA;

--�� FUNCTION ����
-- �Լ��� : FN_GENDER()
--                      SSN(�ֹε�Ϲ�ȣ) �� 'YYMMDD-NNNNNNN'

CREATE OR REPLACE FUNCTION FN_GENDER
(
    VSSN  VARCHAR2      -- �Ű����� : �ڸ���(����) ���� ����
)
RETURN VARCHAR2         -- ��ȯ�ڷ��� : �ڸ���(����) ���� ����
IS
    -- �ֿ� ���� ����
    VRESULT VARCHAR2(20);
BEGIN
    -- ���� �� ó��
    IF (SUBSTR(VSSN, 8, 1) IN ('1', '3') )
        THEN VRESULT := '����';
    ELSIF (SUBSTR(VSSN, 8, 1) IN ('2', '4') )
        THEN VRESULT := '����';
    ELSE 
        VRESULT := '����Ȯ�κҰ�';
    END IF;
    
    -- ���� ����� ��ȯ
    RETURN VRESULT;

END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.

--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾�
--   A �� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�.
--   �Լ��� : FN_POW()
/*
��� ��)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/

CREATE OR REPLACE FUNCTION FN_POW
(
    A   NUMBER
  , B   NUMBER
)
RETURN NUMBER
IS
    -- �ֿ� ���� ����
    VRESULT NUMBER(10); -- ����� ��ȯ�� ����
    N       NUMBER(2);  -- ��������
BEGIN
    -- ���� �� ó��
    N := 0;
    VRESULT := A; 
    LOOP
        N := N + 1;
        EXIT WHEN N >= B;
        VRESULT := VRESULT * A;
    END LOOP;
    
    RETURN VRESULT;
    
END;
--==>> Function FN_POW��(��) �����ϵǾ����ϴ�.


SELECT FN_POW(10,3)
FROM DUAL;
--==>> 1000

-- FOR LOOP��
CREATE OR REPLACE FUNCTION FN_POW2
(
    A   NUMBER
  , B   NUMBER
)
RETURN NUMBER
IS
    -- �ֿ� ���� ����
    VRESULT NUMBER(10); -- ����� ��ȯ�� ����
    N       NUMBER(2);  -- ��������
BEGIN
    -- ���� �� ó��

    VRESULT := 1; 
    FOR N IN 1 .. B LOOP
        VRESULT := VRESULT * A;
    END LOOP;
    
    RETURN VRESULT;
    
END;

-- Ȯ��
SELECT FN_POW2(10,3)
FROM DUAL;

--==>> 1000

--[������ Ǯ��]

CREATE OR REPLACE FUNCTION FN_POW3
( A NUMBER                      -- 10
, B NUMBER                      --  3
)
RETURN NUMBER
IS
    VRESULT NUMBER := 1;        -- ������
    VNUM    NUMBER;
BEGIN
    FOR VNUM IN 1 .. B LOOP    -- 1 ~ 3
        VRESULT := VRESULT * A; -- 1 * 10 * 10 * 10
    END LOOP;
    
    RETURN VRESULT;
    
END;

--<����>
--�� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
--   �޿��� (�⺻��*12) + ���� ������� ������ �����Ѵ�.
--   �Լ��� : FN_PAY(�⺻��, ����)


CREATE OR REPLACE FUNCTION FN_PAY
(   -- �Ű����� �ڷ���
  BC  NUMBER
, SD  NUMBER
)
RETURN NUMBER
IS
    -- �ֿ亯�� ����(���� ����)
    TOTALPAY    NUMBER;
BEGIN
    -- ���๮;
    TOTALPAY := BC * 12 + SD;
    
    RETURN TOTALPAY;
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.

-- Ȯ��
SELECT NAME "�̸�", FN_PAY(BASICPAY, SUDANG) "�⺻��*12 +����"
FROM TBL_INSA;
--==>>
/*
ȫ�浿	31520000
�̼���	16040000
�̼���	30760000
        :
�Ӽ���	10782000
��ž�	10902000
*/


--�� TBL_INSA ���̺��� �Ի����� ��������
--   ��������� �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
--   ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
--   �Լ��� : FN_WORKYEAR(�Ի���)


CREATE OR REPLACE FUNCTION FN_WORKYEAR
(
  DATE   TBL_INSA.IBSADATE%TYPE
)
RETURN NUMBER
IS
    -- �ֿ� ���� ����
    YEARS   NUMBER; -- �ٹ����
BEGIN
    -- ���� �� ó�� 
    --YEARS := TRUNC(MONTHS_BETWEEN(SYSDATE, DATE)/12,1);
    YEARS := TRUNC(MONTHS_BETWEEN(TO_DATE(TO_CHAR(SYSDATE),'YYYY-MM-DD')
            , TO_DATE(TO_CHAR(DATE),'YYYY-MM-DD'))/12,1);
    
    --TO_DATE(TO_CHAR(SYSDATE),'YYYY-MM-DD')
    --TO_DATE(TO_CHAR(DATE),'YYYY-MM-DD')
    RETURN YEARS;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.

-- Ȯ��
SELECT NAME, IBSADATE, FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;
--==>>
/*
ȫ�浿	1998-10-11	22.4
�̼���	2000-11-29	20.3
           :
�����	2003-08-08	17.6
�Ӽ���	2001-10-10	19.4
��ž�	2001-10-10	19.4
*/

--------------------------------------------------------------------------------

--�� ����

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Data Manipulation Language)
-- COMMIT / ROLLBACK �� �ʿ��ϴ�.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)

-- ���� PL/SQL�� �� DML��, TCL���� ��� �����ϴ�.
-- ���� PL/SQL�� �� DML��, DDL��, DCL��, TCL�� ��밡���ϴ�.


--�� ���� SQL (����PL/SQL)
--> �⺻������ ����ϴ� SQL ������
--  PL/SQL ���� �ȿ� SQL ������ ���� �����ϴ� ���
--> �ۼ��� ���� ������ ����.

--�� ���� SQL (����PL/SQL) �� EXECUTE IMMEDIATE
--> �ϼ����� ���� SQL ������ �������
--  ���� �� ���� ������ ���ڿ� ���� �Ǵ� ���ڿ� ����� ����
--  SQL ������ �������� �ϼ��Ͽ� �����ϴ� ���
--> ������ ���ǵ��� ���� SQL �� ������ �� �ϼ�/Ȯ���Ͽ� ������ �� �ִ�.
--  DML, TCL �ܿ��� DDL, TCL ����� �����ϴ�.

--------------------------------------------------------------------------------

--���� PROCEDURE(���ν���) ����--

-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� �����صξ��ٰ�
--    �ʿ��� ������ ȣ���Ͽ� ������ �� �ֵ��� ó���� �ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( �Ű����� IN ������Ÿ��
 , �Ű����� OUT ������Ÿ��
 , �Ű����� INOUT ������Ÿ��
)]
IS
    [--�ֿ� ���� ����;]
BEGIN
    -- ���� ����;
    ...
    [EXCEPTION
        -- ���� ó�� ����;]
END;
*/

--�� FUNCTION �� ������ ��...
--   ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--   ��RETURN���� ��ü�� �������� ������,
--   ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������ 
--   IN, OUT, INOUT ���� ���еȴ�.

-- 3. ����(ȣ��)

/*
EXEC[UTE] ���ν�����[(�μ�1, �μ�2)];
*/

--�� INSERT ���� ������ ���ν����� �ۼ� (INSERT ���ν���)

-- �ǽ� ���̺� ����(TBL_STUDENTS) �� 20210408_04_scott.sql ����
-- �ǽ� ���̺� ����(TBL_IDPW) �� 20210408_04_scott.sql ����

-- ���ν��� ����
-- ���ν����� : PRC_STUDENTS_INSERT(���̵�, �н�����, �̸�, ��ȭ��ȣ, �ּ�)

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW ���̺� ������ �Է�
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES (V_ID, V_PW);
    
    -- TBL_STUDENTS ���̺� ������ �Է�
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES (V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_STUDENTS_INSERT��(��) �����ϵǾ����ϴ�.



-- �ǽ� ���̺� ����(TBL_SUNGJUK) �� 20210408_04_scott.sql ����


--�� ������ �Է½� 
--   Ư�� �׸��� ������(�й�, �̸�, ��������, ��������, ��������)�� �Է��ϸ�
--   ���������� ����, ���, ��� �׸��� �Բ� �Է� ó���� �� �ֵ��� �ϴ�
--   ���ν����� �ۼ��Ѵ�(�����Ѵ�).
--   ���ν����� : PRC_SUNGJUK_INSERT()
/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '������', 90, 80, 70);

���ν��� ȣ��� ó���� ���)
�й�   �̸�   ��������   ��������   ��������   ����   ���   ���
 1    ������     90          80         70     240     80      B

*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME IN TBL_SUNGJUK.NAME%TYPE
, V_KOR IN TBL_SUNGJUK.KOR%TYPE
, V_ENG IN TBL_SUNGJUK.ENG%TYPE
, V_MAT IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- �ֿ� ���� ����
      V_TOT TBL_SUNGJUK.TOT%TYPE;
      V_AVG TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- ���� �� ó��
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF V_AVG >= 60
        THEN V_GRADE := 'D';
    ELSE 
        V_GRADE := 'F';
    END IF;

    -- ���� ����
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE) 
    VALUES (V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.



-- CASE ����
/*
--1.
 CASE TRUNC(V_AVG/10)
    WHEN 10
    THEN V_GRADE := 'A';
 END CASE;
 
--2.    
 CASE WHEN V_AVG >= 90 THEN V_GRADE := 'A';
 END;
*/


--[������ Ǯ��]
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT2
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- INSERT �������� �����ϴµ� �ʿ��� �ֿ� ���� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �Ʒ��� ������ ������ ���ؼ���
    -- ������ �����鿡 ���� ��Ƴ��� �Ѵ�. (V_TOT, V_AVG, V_GRADE)
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE 
        V_GRADE := 'F';
    END IF;

    -- INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES (V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGJUK_INSERT2��(��) �����ϵǾ����ϴ�.


--�� TBL_SUNGJUK ���̺���
--   Ư�� �л��� ����(�й�, ��������, ��������, ��������)
--   ������ ���� �� ����, ���, ��ޱ��� �����ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_SUNGJUK_UPDATE
/*
���� ��)

EXEC PRC_SUNGJUK_UPDATE(1, 50, 50, 50);

���ν��� ȣ��� ó���� ���)
�й�   �̸�   ��������   ��������   ��������   ����   ���   ���
 1    ������     50          50         50     150     50      F
*/


CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
-- ������ ������ ���� �ֿ� ���� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
-- ������ 
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
       IF (V_GRADE >= 90)   THEN V_GRADE := 'A';
    ELSIF (V_GRADE >= 80)   THEN V_GRADE := 'B';
    ELSIF (V_GRADE >= 70)   THEN V_GRADE := 'C';
    ELSIF (V_GRADE >= 60)   THEN V_GRADE := 'D';
    ELSE V_GRADE := 'F'; 
    END IF;
    
    /*
    [CASE WHEN ����]
    CASE WHEN (V_GRADE >=90)    THEN V_GRADE := 'A';
         WHEN (V_GRADE >= 80)   THEN V_GRADE := 'B';
         WHEN (V_GRADE >= 70)   THEN V_GRADE := 'C';
         WHEN (V_GRADE >= 60)   THEN V_GRADE := 'D';
         ELSE V_GRADE := 'F';
    */
     END CASE;   
-- UPDATE ���� ����
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR
      , ENG = V_ENG
      , MAT = V_MAT
      , TOT = V_TOT
      , AVG = V_AVG
      , GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;

-- Ŀ��
COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.


--[������ Ǯ��]
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE2
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- UPDATE �������� �����ϴµ� �ʿ��� �ֿ� ���� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �Ʒ��� ������ ������ ���ؼ���
    -- ������ �����鿡 ���� ��Ƴ��� �Ѵ�. (V_TOT, V_AVG, V_GRADE)
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE 
        V_GRADE := 'F';
    END IF;

    -- UPDATE ������ ����
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR
      , ENG = V_ENG
      , MAT = V_MAT
      , TOT = V_TOT
      , AVG = V_AVG
      , GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGJUK_UPDATE2��(��) �����ϵǾ����ϴ�.

--�� TBL_STUDENTS ���̺���
--   ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�) ���ν����� �ۼ��Ѵ�.
--   ��, ID�� PW �� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� �Ѵ�.
--   ���ν��� �� : PRC_STUDENTS_UPDATE
/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-9999-9999', '��� �ϻ�');

���ν��� ȣ��� ó���� ���)
superman    ������ 010-9999-9999   ��� �ϻ�

*/

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
    -- ������ ������ ���� �ֿ亯�� ����
BEGIN

    -- UPDATE ����
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE V_ID = ID AND V_PW = (SELECT PW
                                FROM TBL_IDPW
                                WHERE ID = V_ID);                   
    -- Ŀ��
    COMMIT;

END;

