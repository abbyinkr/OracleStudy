SELECT USER
FROM DUAL;
--==>> SCOTT

--�� ����ڷκ��� �Է¹��� �ݾ��� ȭ�� ������ ����ϴ� ���α׷��� �ۼ��Ѵ�.
--   ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� : 990

�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

SET SERVEROUTPUT ON;
--==>> �۾��� �Ϸ�Ǿ����ϴ�.


ACCEPT N PROMPT '�ݾ� �Է� : ';

DECLARE
--��������
    NUM1    NUMBER := &N;
    OBACK   NUMBER := 0;
    BACK    NUMBER := 0;
    OSIB    NUMBER := 0;
    SIB     NUMBER := 0;
BEGIN
--���� �� ó��
    OBACK := TRUNC(NUM1/500);
    BACK  := TRUNC(MOD(NUM1,500)/100);
    OSIB  := TRUNC(MOD(NUM1,100)/50);
    SIB   := TRUNC(MOD(NUM1,50)/10); 

-- ������
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || NUM1 || '��');
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || OBACK || ', ��� ' || BACK || ', ���ʿ� ' 
                         || OSIB || ', �ʿ� ' || SIB);    
END;


--[������ Ǯ��]--

ACCEPT INPUT PROMPT'�ݾ� �Է� : ';

DECLARE
    --�� �ֿ� ���� ���� �� �ʱ�ȭ
    MONEY   NUMBER := &INPUT;       -- ������ ���� ��Ƶ� ����
    MONEY2  NUMBER := &INPUT;       -- ����� ���� ��Ƶ� ���� (���� �������� ���� ���ϱ� ������...)
    M500    NUMBER;                 -- 500�� ¥�� ������ ��Ƶ� ����
    M100    NUMBER;                 -- 100�� ¥�� ������ ��Ƶ� ����
    M50     NUMBER;                 --  50�� ¥�� ������ ��Ƶ� ����
    M10     NUMBER;                 --  10�� ¥�� ������ ��Ƶ� ����
BEGIN
    --�� ���� �� ó��
    -- MONEY�� 500���� ������ ���� ���ϰ� �������� ������. �� 500���� ����
    M500 := TRUNC(MONEY/500);
    
    -- MONEY �� 500���� ������ ���� ������ �������� ���Ѵ�.
    MONEY := MOD(MONEY,500);
    
    -- MONEY �� 100���� ������ ���� ���ϰ� �������� ������. �� 100���� ����
    M100 := TRUNC(MONEY/100);
    
    -- MONEY �� 100���� ������ ���� ������ �������� ���Ѵ�.
    MONEY := MOD(MONEY,100);
    
    -- MONEY �� 50���� ������ ���� ���ϰ� �������� ������. �� 50���� ����
    M50 := TRUNC(MONEY/50)
    
    -- MONEY �� 50���� ������ ���� ������ �������� ���Ѵ�.
    MONEY := MOD(MONEY,50);
    
    -- MONEY �� 10���� ������ ���� ���ϰ� �������� ������. �� 10���� ����
    M10 := TRUNC(MONEY/10);

    --�� ��� ���
    DBMS_OUTPUT.PUT_LINE('�Է� ���� �ݾ� �Ѿ� : ' || MONEY2 || '��');
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || M500 || ', ��� ' || M100 || ', ���ʿ� ' || M50 || ', �ʿ� ' || M10 );
    
END;


--�� �⺻ �ݺ���
-- LOOP END LOOP;

-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����

/*
LOOP
    -- ���๮;
    EXIT WHEN ����;       -- ������ ���� ��� �ݺ����� ����������.
END LOOP;

*/


--�� 1 ���� 10 ������ �� ��� (LOOP �� Ȱ��)

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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� WHILE �ݺ���
-- WHILE LOOP ~ END LOOP;

-- 1. ���� ������ TRUE �� ���� �Ϸ��� ������ �ݺ��ϱ� ���� 
--    WHILE LOOP ������ ����Ѵ�.
--    ������ �ݺ��� ���۵� �� üũ�ϰ� �Ǿ�
--    LOOP ���� ������ �� ���� ������� ���� ��쵵 �ִ�.
--    LOOP �� ������ �� ������ FALSE �̸� �ݺ� ������ Ż���ϰ� �ȴ�.

-- 2. ���� �� ����
/*
WHILE ���� LOOP      -- ������ ���� ��� �ݺ� ����
    -- ���๮;
END LOOP;
*/

--�� 1 ���� 10 ������ �� ���(WHILE LOOP�� Ȱ��)

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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� FOR �ݺ���
-- FOR LOOP ~ END LOOP;

-- 1. ������ �������� 1�� �����Ͽ�
--    ������ ������ �� �� ���� �ݺ� �����Ѵ�.

-- 2. ���� �� ����
/*
FOR ī���� IN [REVERSE] ���ۼ� .. ������ LOOP
    -- ���๮
END LOOP;
*/

--�� 1 ���� 10 ������ �� ��� (FOR LOOP �� Ȱ��)

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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
--   �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
--   LOOP, WHILE LOOP, FOR LOOP �� ���� �ذ��Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� ���� �Է��ϼ��� : 2

2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
    :
2 * 9 = 18
*/


--LOOP

ACCEPT N PROMPT '���� �Է��ϼ��� : ';

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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--WHILE LOOP

ACCEPT N PROMPT '���� �Է��ϼ��� : ';

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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- FOR LOOP 
ACCEPT N PROMPT '���� �Է��ϼ��� : ';

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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

