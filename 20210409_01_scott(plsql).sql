SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;
--==>> �۾��� �Ϸ�Ǿ����ϴ�.
-- ����Ұ� ������ �����൵ ��..

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
(
 V_ID   IN  TBL_STUDENTS.ID%TYPE
,V_PW   IN  TBL_IDPW.PW%TYPE
,V_TEL  IN  TBL_STUDENTS.TEL%TYPE
,V_ADDR IN  TBL_STUDENTS.ADDR%TYPE
)
IS

BEGIN
    -- update ������ ����
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND V_PW = ( SELECT PW
                                 FROM TBL_IDPW
                                 WHERE ID = V_ID);
    COMMIT;

END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.

EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-9999-9999', '��� �ϻ�');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

SELECT *
FROM TBL_STUDENTS;


--[������ Ǯ��]


CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(
 V_ID   IN  TBL_STUDENTS.ID%TYPE
,V_PW   IN  TBL_IDPW.PW%TYPE
,V_TEL  IN  TBL_STUDENTS.TEL%TYPE
,V_ADDR IN  TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- UPDATE ������ ����
    /*
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
        FROM TBL_IDPW I JOIN TBL_STUDENTS S
        ON I.ID = S.ID) T 
    SET T.TEL = �Է¹�����ȭ��ȣ, T.ADDR = �Է¹��� �ּ�
    WHERE T.ID = �Է¹������̵� AND T.PW = �Է¹����н�����;
    */
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
        FROM TBL_IDPW I JOIN TBL_STUDENTS S
        ON I.ID = S.ID) T 
    SET T.TEL = V_TEL, T.ADDR = V_ADDR
    WHERE T.ID = V_ID AND T.PW = V_PW;
    
    -- Ŀ��
    COMMIT;

END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.

--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
--   NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--   ������ ���� �ִ� ��� ���̺� ������ �Է� ��
--   NUM �׸�(�����ȣ)�� ����
--   ���� �ο��� �����ȣ ������ ��ȣ�� �� ���� ��ȣ��
--   �ڵ����� �Է� ó���� �� �ִ� ���ν����� �����Ѵ�.
--   ���ν��� �� : PRC_INSA_INSERT(NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
/*
���� ��)
EXEC PRC_INSA_INSERT('������', '971006-2234567', SYSDATE, '����', '010-5555-5555'
                    , '������', '�븮', 5000000, 500000)

���ν��� ȣ��� ó���� ���)

1061 ������ 971006-2234567 2021-04-09 ���� 010-5555-5555 ������ �븮 5000000 500000
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
     
       --V_NUM := TBL_INSA���̺��� ���� ū NUM �� + 1; 
     SELECT MAX(NUM)+1 INTO V_NUM
      FROM TBL_INSA;

    INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES( V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL
           , V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
           
    -- Ŀ��
    COMMIT;
    
END;

--[������ Ǯ��]

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
    -- INSERT ������ ���࿡ �ʿ��� ���� �߰� ����
    -- �� NUM
    V_NUM    NUMBER;
 

BEGIN
    -- ������ ����(V_NUM)�� �� ��Ƴ���
    SELECT MAX(NUM)+1 INTO V_NUM
    FROM TBL_INSA;

    -- ISNERT ������ ����
    INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES( V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL
           , V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
           
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.

-- ����
/*
21/6      PLS-00103: Encountered the symbol "SELECT" when expecting one of the following:     ( - + case mod new not null <an identifier>    <a double-quoted delimited-identifier> <a bind variable>    continue avg count current exists max min prior sql stddev    sum variance execute forall merge time timestamp interval    date <a string literal with character set specification>    <a number> <a single-quoted SQL string> pipe    <an alternatively-quoted string literal with character set specification>    <an alternat
22/18     PLS-00103: Encountered the symbol ")" when expecting one of the following:     . , @ ; for <an identifier>    <a double-quoted delimited-identifier> group having intersect    minus order partition start subpartition union where connect    sample 
32/4      PLS-00103: Encountered the symbol "end-of-file" when expecting one of the following:     end not pragma final instantiable order overriding static    member constructor map 
����: �����Ϸ� �α׸� Ȯ���Ͻʽÿ�.

*/

--> �ذ� ���
-- SELECT ~FROM �� ��ȣ ���°� Ǫ�ϱ� �ذ��

-- �ھϱ��
-- SELECT �� ���� ���� INTO �� �־���� �Ѵ�.
-- SELECT �� ���� ���� := ���Կ����ڷ� ��Ƴ� ������.(����Ŀ���� ���ư���..) 
-- EXEC ������ �� �ٷ� ��� �Ѵ�.


--�� TBL_��ǰ, TBL_�԰� ���̺��� �������...
--   TBL_�԰� ���̺� ������ �Է� �� (��, �԰� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� �Բ� ������ �� �ִ� ����� ����
--   ���ν����� �ۼ��Ѵ�.
--   ��, �� �������� �԰��ȣ�� �ڵ� ���� ó���Ѵ�. (������ ��� X)
--   TBL_�԰� ���̺� ���� �÷�
--   �� �԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�
--   ���ν��� �� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)


--[���� Ǯ��]
CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ� IN TBL_�԰�.��ǰ�ڵ�%TYPE
, V_�԰���� IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ� IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
--�ֿ亯������
V_�԰��ȣ  TBL_�԰�.�԰��ȣ%TYPE;
V_������  TBL_��ǰ.������%TYPE;
BEGIN
-- ���� �� ó��
/*

SELECT MAX(�԰��ȣ)+1 INTO V_�԰��ȣ
FROM TBL_�԰�
--> �����߻�
ORA-01400: cannot insert NULL into ("SCOTT"."TBL_�԰�"."�԰��ȣ")
ORA-06512: at "SCOTT.PRC_�԰�_INSERT", line 17
ORA-06512: at line 1
01400. 00000 -  "cannot insert NULL into (%s)"
*Cause:    An attempt was made to insert NULL into previously listed objects.
*Action:   These objects cannot accept NULL values.
--> TBL_�԰� ���̺� �ƹ��͵� ������� �ʱ� ������ MAX(�԰��ȣ)+1 = NULL �̴�.

*/
    --NVL2(SELECT MAX(�԰��ȣ)
    --FROM TBL_�԰�, SELECT MAX(�԰��ȣ)+1 INTO V_�԰��ȣ
    --FROM TBL_�԰�, 1)
    
    --> ���� �߻�~!!!
    --> SELECT �� �ȿ����� �����Ӱ� �Լ��� ����� �� ������.. 
    -- ȣ���� ���̺�(SELECT ~ FROM) �ۿ��� �Լ��� ���°� ������ ���� �ʴ�.
    
    IF
        (SELECT �԰��ȣ
        FROM TBL_�԰�;)
        IS NULL
    THEN
        V_�԰��ȣ := 1;
    ELSE
        SELECT MAX(�԰��ȣ)+1 INTO V_�԰��ȣ
        FROM TBL_�԰�;
        
    END IF;
    --> ���� �߻�~!!!
    --> ���������� IF�� �������� ���°� ������ ���� �ʴ�.
    
    
-- INSERT (TBL_�԰� ���̺�)
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
    VALUES (V_�԰��ȣ, V_��ǰ�ڵ�, SYSDATE, V_�԰����, V_�԰�ܰ�);
-- UPDATE (TBL_��ǰ ���̺�)

    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;


END;
--> �ٽ� Ǯ��!!!


--[������ Ǯ��]

--�� TBL_�԰� ���̺� �԰� �̺�Ʈ �߻� ��...
--   �������̺��� ����Ǿ�� �ϴ� ����
--   �� INSERT �� TBL_�԰�
--      INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
--      VALUES (1, 'H001', SYSDATE, 20, 900)

--   �� UPDATE TBL_��ǰ
--      SET ������ = ���������� + 20(�� �԰����)
--      WHERE ��ǰ�ڵ� = 'H001';


CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ� IN TBL_��ǰ.��ǰ�ڵ�%TYPE -- ��ǰ���̺��� �θ����̺��̴� ��ǰ���̺� ����
, V_�԰���� IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ� IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    -- �Ʒ��� �������� �����ϱ� ���� �ʿ��� ������ ������ ����
    V_�԰��ȣ TBL_�԰�.�԰��ȣ%TYPE;
BEGIN

    -- ������ ����(V_�԰��ȣ)�� �� ��Ƴ���
    SELECT NVL(MAX(�԰��ȣ), 0) INTO V_�԰��ȣ
    FROM TBL_�԰�;


    -- ������ ����
    --   �� INSERT �� TBL_�԰�
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�)
    VALUES ((V_�԰��ȣ+1), V_��ǰ�ڵ�,  V_�԰����, V_�԰�ܰ�);
    
    --   �� UPDATE TBL_��ǰ
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- Ŀ��
    COMMIT;
    
    -- ���� ó��
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
    
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.


--���� ���ν��� �������� ���� ó�� ����--

--�� �ǽ� ���̺� ����(TBL_MEMBER) �� 20210409_02_scott.sql ���� ����

--�� TBL_MEMBER ���̺� �����͸� �Է��ϴ� ���ν����� ����
--   ��, �� ���ν����� ���� �����͸� �Է��� ���
--   CITY(����) �׸� '����', '���', '��õ'�� �Է��� �����ϵ��� �����Ѵ�.
--   �� ���� ���� ������ ���ν��� ȣ���� ���� �Է��Ϸ��� ���
--   ���� ó���� �Ϸ��� �Ѵ�.
--   ���ν��� �� : PRC_MEMBER_INSERT(�̸�, ��ȭ��ȣ, ����)

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN TBL_MEMBER.NAME%TYPE
, V_TEL     IN TBL_MEMBER.TEL%TYPE
, V_CITY    IN TBL_MEMBER.CITY%TYPE
)
IS
    -- ���� ������ ������ ������ ���� �ʿ��� ������ ���� ����
    V_NUM   TBL_MEMBER.NUM%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ����~!!!
    USER_DEFINE_ERROR   EXCEPTION;
    --������   ������Ÿ��, �Ϲ����� ���� ����� ���� ���� CHECK~!!!

BEGIN

    -- ���ν����� ���� �Է� ó���� ���������� �����ؾ� �� ����������
    -- �ƴ����� ���θ� ���� ���� Ȯ���� �� �ֵ��� �ڵ� ����
    
    IF ((V_CITY) NOT IN ('����','���','��õ'))   -- '����', '��õ', '���' �� �ϳ��� ������� �ʴٸ�...
        -- ���� �߻�~!!! CHECK~!!! = JAVA THROW
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(NUM),0) INTO V_NUM   -- 0 OR �ִ밪
    FROM TBL_MEMBER;
    

    -- ������ ����(INSERT)
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM+1), V_NAME, V_TEL, V_CITY);
    
    -- Ŀ��
    COMMIT;
    
    --���� ó��
    /*
    EXCEPTION
        WHEN �̷� ���ܶ��...
            THEN �̷��� ó���ϰ�
        WHEN ���� ���ܶ��...
            THEN ������ ó���ض�...
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-�����ڵ�, ����������);
        WHEN ���� ���ܶ��...
            THEN ������ ó���ض�...
    */
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '����,��õ,��⸸ �Է� �����մϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;

END;
--==>> Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.

--�� EXCEPTION - RAISE_APPLICATION_ERROR(-�����ڵ�, ����������)
--> �����ڵ� 20000 �� ������ ����Ŭ�� ����
--  ������Ʈ �����Ҷ��� 20001 ������ �����ڵ� ���� �ȴ�.


--�� TBL_��� ���̺� ������ �Է� �� (��, ��� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� �����Ǵ� ���ν����� �ۼ��Ѵ�.
--   ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ� ����.
--   ����, ��� ������ ��� �������� ���� ���...
--   ��� �׼��� ����� �� �ֵ��� ó���Ѵ�. (��� �̷������ �ʵ���...)
--   ���ν��� �� : PRC_���_INSERT(��ǰ�ڵ�, ������, ���ܰ�)

CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�    TBL_��ǰ.��ǰ�ڵ�%TYPE
, V_������    TBL_���.�԰����%TYPE
, V_���ܰ�    TBL_���.�԰�ܰ�%TYPE
)
IS
-- ���� ����
V_����ȣ  TBL_���.�԰��ȣ%TYPE;
V_������  TBL_��ǰ.������%TYPE;
-- ����ó�� ���� ����
USER_DEFINE_ERROR   EXCEPTION;

BEGIN
    -- TBL_��ǰ ���̺��� �������� ���������� ���
    SELECT NVL(������, 0) INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ����ó�� ����
    IF (V_������ > V_������)
    THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ����ȣ ���� ó��
    SELECT NVL(MAX(����ȣ), 0) INTO V_����ȣ
    FROM TBL_���;
    

    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
    VALUES((V_����ȣ+1), V_��ǰ�ڵ�, V_������, V_���ܰ�);
    
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20001, '�������� ���������� �����մϴ�.');
             ROLLBACK;
    WHEN OTHERS
        THEN ROLLBACK;
END;
--==>> Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.


--[������ Ǯ��]
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�    TBL_��ǰ.��ǰ�ڵ�%TYPE
, V_������    TBL_���.������%TYPE
, V_���ܰ�    TBL_���.���ܰ�%TYPE
)
IS
    --  �ֿ� ���� ����
    V_����ȣ  TBL_���.����ȣ%TYPE;
    V_������  TBL_��ǰ.������%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;      -- ����� ���� ����
BEGIN
    -- ������ ���� ������ ���� ���� Ȯ�� �� ���� ��� Ȯ�� �� ��� ������ ��
    
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

    
    -- ��� ���������� ������ �� �������� ���� ���� Ȯ��
    -- (�ľ��� ���������� �������� ������... ���� �߻�~!!!)
    
    IF (V_������ > V_������)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
 
    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(����ȣ), 0) INTO V_����ȣ
    FROM TBL_���;

    -- ������ ����(INSERT �� TBL ���)
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
    VALUES((V_����ȣ+1), V_��ǰ�ڵ�, V_������, V_���ܰ�);
    
    -- ������ ����(UPDATE �� TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --Ŀ��
    COMMIT;
    
    -- ���� ó��
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '������~!!!');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;       
END;
--==>> Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��� ���̺��� �������� ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_���_UPDATE(����ȣ, ������ ����)

CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( V_����ȣ    TBL_���.����ȣ%TYPE
, V_�������    TBL_��ǰ.������%TYPE
)
IS 
    V_������  TBL_��ǰ.������%TYPE;
    V_������  TBL_���.������%TYPE;
    V_��ǰ�ڵ�  TBL_��ǰ.��ǰ�ڵ�%TYPE;
    
    -- ���� ó�� ����
    USER_DEFINE_ERROR   EXCEPTION;

BEGIN

    -- ������ ������ �� ��Ƴ���(������ ��)
    SELECT ������ INTO V_������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
     
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;

    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;


    -- ������� ���������� ��������� ������ ���� Ȯ��
    
    IF ((V_������+V_������) < V_�������)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- UPDATE (TBL_��ǰ-������)
    UPDATE TBL_��ǰ
    SET ������ = (V_������+V_������) - V_�������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- UPDATE (TBL_���-������)
    UPDATE TBL_���
    SET ������ = V_�������
    WHERE ����ȣ = V_����ȣ;
    
    -- Ŀ��
    COMMIT;
    
    --����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '������� ����� �����մϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;

END;
--==>> Procedure PRC_���_UPDATE��(��) �����ϵǾ����ϴ�.




