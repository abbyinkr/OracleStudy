SELECT USER
FROM DUAL;
--==>> SCOTT

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.



SELECT *
FROM TBL_�԰�;
--==>>
/*
1	H001	2021-04-09	20	400
2	H002	2021-04-09	30	500
3	H003	2021-04-09	40	600
4	H004	2021-04-09	50	700
5	H005	2021-04-09	60	800
6	H006	2021-04-09	70	900
7	H007	2021-04-09	80	1000
8	C001	2021-04-09	30	800
9	C002	2021-04-09	40	900
10	C003	2021-04-09	50	1000
11	C004	2021-04-09	60	1100
12	C005	2021-04-09	70	1200
13	C006	2021-04-09	80	1300
14	C007	2021-04-09	90	1400
15	E001	2021-04-09	80	990
16	E002	2021-04-09	70	880
17	E003	2021-04-09	60	770
18	E004	2021-04-09	50	660
19	E005	2021-04-09	40	550
20	E006	2021-04-09	30	440
21	E007	2021-04-09	20	330
*/

SELECT *
FROM TBL_���;
--==>>
/*
1	H001	2021-04-09	1	1100
2	H002	2021-04-09	2	1200
3	H003	2021-04-09	3	1300
4	H004	2021-04-09	4	1400
5	H005	2021-04-09	5	1500
6	H006	2021-04-09	6	1600
7	H007	2021-04-09	7	1700
8	C001	2021-04-09	2	1900
9	C002	2021-04-09	3	1910
10	C003	2021-04-09	4	1920
11	C004	2021-04-09	5	1930
12	C005	2021-04-09	6	1940
13	C006	2021-04-09	7	1950
14	C007	2021-04-09	8	1960
*/

SELECT *
FROM TBL_��ǰ;
--==>>
/*
H001	Ȩ����	1500	19
H002	�����	1200	28
H003	�ڰ�ġ	1000	37
H004	���ڱ�	900	    46
H005	������	1100	55
H006	����Ĩ	2000	64
H007	������	1700	73
C001	������	2000	28
C002	��극	1800	37
C003	���̽�	1700	46
C004	���͸�	1900	55
C005	���̺�	1700	64
C006	���Ͻ�	1200	73
C007	������	1900	82
E001	������	600	    80
E002	������	500	    70
E003	�˵��	300	    60
E004	��Ʋ��	600	    50
E005	������	800	    40
E006	���׸�	900	    30
E007	��ī��	900	    20
*/

--�� ������ ���ν��� ���� �۵����� Ȯ��
--   �� ���ν��� ȣ��
-- �����19 / ���1�� �� Ȩ���� ����� ����
EXEC PRC_���_UPDATE(1, 21);
--==>> ���� �߻�
/*
ORA-20002: ������~!!!
*/

EXEC PRC_���_UPDATE(1, 20);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	0

SELECT *
FROM TBL_���;
--==>> 1	H001	2021-04-09	20	1100

--------------------------------------------------------------------------------

--�� Ʈ���� �ǽ� ���� ���̺� ���� (TBL_TEST1)
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
);
--==>> Table TBL_TEST1��(��) �����Ǿ����ϴ�.

--�� ������ ���̺� �������� �߰�
-- ID �÷��� PK �������� ����

ALTER TABLE TBL_TEST1
ADD CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID);
--==>> Table TBL_TEST1��(��) ����Ǿ����ϴ�.

--�� Ʈ���� �ǽ� ���� ���̺� ���� (TBL_EVENTLOG)

CREATE TABLE TBL_EVENTLOG
( MEMO VARCHAR2(200)
, INJA DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG��(��) �����Ǿ����ϴ�.


SELECT *
FROM TBL_TEST1;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_EVENTLOG;
--==>> ��ȸ ��� ����

--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� TBL_TEST1 �������Է�

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '�谡��', '010-1111-1111');

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '�輭��', '010-2222-2222');

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '������', '010-3333-3333');


--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 3

--�� TBL_TEST1 ������ ����
UPDATE TBL_TEST1
SET NAME = '�質��'
WHERE ID = 1;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.


UPDATE TBL_TEST1
SET NAME = '��ٿ�'
WHERE ID = 1;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

UPDATE TBL_TEST1
SET NAME = '�赿��'
WHERE ID = 2;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.


--�� TBL_TEST1 ���̺��� ������ ����

DELETE
FROM TBL_TEST1
WHERE ID = 3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_TEST1
WHERE ID = 2;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_TEST1
WHERE ID = 1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST1;
--==>> ��ȸ ��� ����

--�� TBL_EVENTLOG ���̺� ��ȸ

SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT �������� ����Ǿ����ϴ�.	2021-04-12 15:22:56
INSERT �������� ����Ǿ����ϴ�.	2021-04-12 15:22:56
INSERT �������� ����Ǿ����ϴ�.	2021-04-12 15:22:56
UPDATE �������� ����Ǿ����ϴ�.	2021-04-12 15:23:31
UPDATE �������� ����Ǿ����ϴ�.	2021-04-12 15:23:54
UPDATE �������� ����Ǿ����ϴ�.	2021-04-12 15:24:13
DELETE �������� ����Ǿ����ϴ�.	2021-04-12 15:25:08
DELETE �������� ����Ǿ����ϴ�.	2021-04-12 15:25:24
DELETE �������� ����Ǿ����ϴ�.	2021-04-12 15:25:52
*/

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(4, '�ڹ���', '010-4444-4444');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. 
UPDATE TBL_TEST1
SET TEL = '010-4141-4141'
WHERE ID = 4;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
DELETE
FROM TBL_TEST1
WHERE ID = 4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST1;

--�� BEFORE ROW TRIGGER �ǽ� ������ ���� ���̺� ����(TBL_TEST2) �� �θ� ���̺�

CREATE TABLE TBL_TEST2
( CODE NUMBER
, NAME VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2��(��) �����Ǿ����ϴ�.

--�� BEFORE ROW TRIGGER �ǽ� ������ ���� ���̺� ����(TBL_TEST3) �� �ڽ� ���̺�

CREATE TABLE TBL_TEST3
( SID   NUMBER
, CODE  NUMBER
, SU    NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
             REFERENCES TBL_TEST2(CODE) 
);
--==>> Table TBL_TEST3��(��) �����Ǿ����ϴ�.

--�� �θ����̺� ������ �Է�
INSERT INTO TBL_TEST2(CODE, NAME) VALUES (1, '�����');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES (2, '��Ź��');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES (3, '������');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	�����
2	��Ź��
3	������
*/

COMMIT;
--==>> Ŀ�� �Ϸ�. 

--�� �ڽ����̺� ������ �Է�
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES (1, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES (2, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES (3, 1, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES (4, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES (5, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES (6, 2, 40);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES (7, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES (8, 2, 20);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 8

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	20
2	1	30
3	1	40
4	2	20
5	2	30
6	2	40
7	1	20
8	2	20
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


SELECT C.SID, P.CODE, P.NAME, C.SU
FROM TBL_TEST2 P JOIN TBL_TEST3 C
ON P.CODE = C.CODE;
--==>>
/*
1	1	�����	20
2	1	�����	30
3	1	�����	40
4	2	��Ź��	20
5	2	��Ź��	30
6	2	��Ź��	40
7	1	�����	20
8	2	��Ź��	20
*/

DELETE 
FROM TBL_TEST2
WHERE CODE = 2;
--==>> ���� �߻�
/*
ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found
*/


DELETE 
FROM TBL_TEST2
WHERE CODE = 3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� Ʈ���� �ۼ� ���� �ٽ� �׽�Ʈ
DELETE 
FROM TBL_TEST2
WHERE CODE =1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST2;

SELECT *
FROM TBL_TEST3;

COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� Ʈ���� �ǽ� ���� ���̺� ����

TRUNCATE TABLE TBL_�԰�;
--==>> Table TBL_�԰���(��) �߷Ƚ��ϴ�.

TRUNCATE TABLE TBL_���;
--==>> Table TBL_�����(��) �߷Ƚ��ϴ�.

UPDATE TBL_��ǰ
SET ������ = 0;
--==>> 21�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� �԰� ���̺� �԰� �̺�Ʈ �߻�
INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
VALUES (1, 'H001', SYSDATE, 100, 1000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_�԰�;
--==>> 1	H001	2021-04-12 17:16:28	100	1000

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	100

COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� �ۼ��� Ʈ����(TRG_IBGO) �׽�Ʈ
-- �԰� ���̺� ������Ʈ �̺�Ʈ �߻� (�԰���� ����)
UPDATE TBL_�԰�
SET �԰���� = 50
WHERE �԰��ȣ = 1; 
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_�԰�;
--==>> 1	H001	21/04/12	50	1000

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	50

-- �԰� ���̺� ���� �̺�Ʈ �߻�
DELETE
FROM TBL_�԰�
WHERE �԰��ȣ = 1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�

SELECT *
FROM TBL_�԰�
WHERE �԰��ȣ = 1;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_��ǰ;
--==>> H001	Ȩ����	1500	0

--�� �ۼ��� Ʈ����(TRG_CHULGO) �׽�Ʈ
-- �׽�Ʈ �� ������

SELECT *
FROM TBL_���;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_��ǰ;

-- ��� ���̺� ��� �̺�Ʈ �߻�

INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, �������, ������, ���ܰ�)
VALUES(1, 'H001', SYSDATE, 100, 1000);

SELECT *
FROM TBL_���;

SELECT *
FROM TBL_��ǰ;

UPDATE TBL_���
SET ������ = 50
WHERE ����ȣ = 1;

DELETE
FROM TBL_���
WHERE ����ȣ = 1;

ROLLBACK;
-- �׽�Ʈ �� ���·� ����