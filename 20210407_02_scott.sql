SELECT USER
FROM DUAL;
--==>> SCOTT

--���� UPDATE ����--

-- 1. ���̺��� ���� �����͸� �����ϴ� ����.

-- 2. ���� �� ����
-- UPDATE ���̺��
-- SET �÷��� = ������ ��[, �÷���=������ ��, ...]
-- [WHERE ������]


SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	�谡��		9402252234567	21/03/30	100
1002	�輭��		9412272234567	10/11/05	2000
1003	��ƺ�		9303082234567	99/08/16	5000
1004	������		9609142234567	08/02/02	4000
1005	������		9712242234567	09/07/15	2000
1006	������		9710062234567	09/07/15	2000
1007	������		0405064234567	10/06/05	1000
1008	������		0103254234567	12/07/13	3000
1009	������		9804251234567	07/07/08	4000
1010	������		0204254234567	08/12/10	2000
1011	������		7505071234567	90/10/10	3000
1012	���켱		9912122234567	02/10/10	2000
1013	������	7101092234567	91/11/11	1000
1014	������		0203043234567	10/05/05	2000
1015	���ü�		0512123234567	12/08/14	1000
1016	����		7012121234567	90/08/14	2000
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

--�� TBL_SAWON ���̺��� �����ȣ 1003�� �����
--   �ֹι�ȣ�� ��8303082234567���� �����Ѵ�.

UPDATE TBL_SAWON
SET JUBUN = '8303082234567'
WHERE SANO = 1003; 

SELECT *
FROM TBL_SAWON;

-- ������ COMMIT �Ǵ� ROLLBACK �� �ݵ�� ���������� ����
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� TBL_SAWON ���̺��� 1005�� ����� �Ի��ϰ� �޿���
--   ���� 2018-02-22, 2200 ���� �����Ѵ�.
UPDATE TBL_SAWON
SET HIREDATE = TO_DATE('2018-02-22', 'YYYY-MM-DD')
   ,SAL = 2200
WHERE SANO = 1005;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_SAWON;

-- Ȯ���� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� TBL_INSA ���̺� ����(�����͸�)


CREATE TABLE TBL_INSABACKUP
AS
SELECT *
FROM TBL_INSA;
--==>> Table TBL_INSABACKUP��(��) �����Ǿ����ϴ�.

--�� TBL_INSABACKUP ���̺��� 
--   ������ ����� ���常 ���� 10% �λ�~!!!

SELECT NAME"�̸�", JIKWI"����", SUDANG"����", SUDANG*1.1"10%�λ�� ����"
FROM TBL_INSABACKUP
WHERE JIKWI IN ('����','����');


UPDATE TBL_INSABACKUP
SET SUDANG = SUDANG *1.1
WHERE JIKWI IN ('����','����');
--==>> 15�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_INSABACKUP;

--Ȯ�� �� Ŀ��
COMMIT;


--�� TBL_INSABACKUP ���̺��� ��ȭ��ȣ�� 016, 017, 018, 019 �� �����ϴ�
--   ��ȭ��ȣ�� ��� �̸� ��� 010 ���� �����Ѵ�.

SELECT *
FROM TBL_INSABACKUP;

SELECT TEL, SUBSTR(TEL, 1, 3) "��ȭ��ȣ ���ڸ�"
FROM TBL_INSABACKUP;

-- ������Ʈ ���� SELECT ���� ���� ���� ���� �� Ȯ���غ��� ��

SELECT TEL"������ȭ��ȣ", '010' || SUBSTR(TEL,4) "�������ȭ��ȣ"
FROM TBL_INSABACKUP
WHERE SUBSTR(TEL, 1, 3) =ANY ('016', '017', '018', '019');


UPDATE TBL_INSABACKUP
SET TEL = '010' || SUBSTR(TEL,4)
WHERE SUBSTR(TEL, 1, 3) =ANY ('016', '017', '018', '019');
--==>> 24�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_INSABACKUP;

-- Ȯ���� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.




--�� TBL_SAWON ���̺� ��� (2021-04-07 10:00:00)
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT *
FROM TBL_SAWON;
--==>> Table TBL_SAWONBACKUP��(��) �����Ǿ����ϴ�.
--> TBL_SAWON ���̺��� �����͵鸸 ����� ���� 
--  ��, �ٸ� �̸��� ���̺� ���·� ������ �� ��Ȳ

--�� Ȯ��
SELECT *
FROM TBL_SAWONBACKUP;
SELECT *
FROM TBL_SAWON;

UPDATE TBL_SAWON
SET SANAME = '�̹���';

COMMIT;

-- ���� ���� UPDATE ó�� ���Ŀ� COMMIT �� �����Ͽ��� ������
-- ROLLBACK �� �Ұ����� ��Ȳ�̴�.
-- ������, TBL_SAWONBACKUP ���̺� �����͸� ����� �ξ���.
-- SANAME �÷��� ���븸 �����Ͽ� '�̹���' ��� �־��� �� �ִٴ� ���̴�.

UPDATE TBL_SAWON
SET SANAME = '�谡��'
WHERE SANO = 1001;

UPDATE TBL_SAWON
SET SANAME = '�輭��'
WHERE SANO = 1002;
--> �̰� ���� �ʹ� ����

UPDATE TBL_SAWON
SET SANAME = TBL_SAWONBACKUP ���̺��� 1001�� ����� �����;

UPDATE TBL_SAWON
SET SANAME = (SELECT SANAME
              FROM TBL_SAWONBACKUP 
              WHERE SANO = TBL_SAWON.SANO);
--==>> 16�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_SAWONBACKUP;

SELECT *
FROM TBL_SAWON;

COMMIT;
--==>> Ŀ�� �Ϸ�.
