SELECT USER
FROM DUAL;
--==>> SYS

-- 211.238.142.166 (������ ���ڸ� �����ǹ�ȣ)

-- ����Ŭ�� �ѹ� ����Ȱ�(����) �� �����ϸ� ������!
-- ����� �����ؼ� �ѹ��� ������ ��

--1�� �ּ��� ó��(������ �ּ��� ó��)

/*
������
(������)
�ּ���
ó��
*/

SHOW USER
--==>> USER��(��) "SYS"�Դϴ�.
-- SQPLUS ������ �� ����ϴ� ��ɾ�

SELECT USER
FROM DUAL;
--==>> SYS

SELECT 1+2
FROM DUAL;
--==>> 3 

select 1+2
from dual;
--==>> 3

SELECT 1 + 2
FROM DUAL;
--==>> 3

SELECT '�ֿ밭�ϱ�������F������'
FROM DUAL;
--==>> �ֿ밭�ϱ�������F������

SELECT '������ ������ ����Ŭ ����';
--==>> ���� �߻�
/*
ORA-00923: FROM keyword not found where expected
00923. 00000 -  "FROM keyword not found where expected"
*Cause:    
*Action:
38��, 23������ ���� �߻�
*/
SELECT 3.14 + 1.36
FROM DUAL;
--==>> 4.5

SELECT 1.2345 + 2.3456
FROM DUAL;
--==>> 3.5801

SELECT 10 * 5
FROM DUAL;
--==>> 50

SELECT 1000 / 23 
FROM DUAL;
--==>> 43.47826086956521739130434782608695652174

SELECT 100 - 23
FROM DUAL;
--==>> 77

SELECT '��ƺ�' + '������'
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

--�� ����Ŭ ������ �����ϴ� ����� ���� ���� ���� ��ȸ

SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
SYS         	          OPEN
SYSTEM	              	  OPEN
ANONYMOUS	          OPEN
HR	OPEN
APEX_PUBLIC_USER	  LOCKED
FLOWS_FILES	          LOCKED
APEX_040000	          LOCKED
OUTLN	EXPIRED &         LOCKED
DIP	EXPIRED &         LOCKED
ORACLE_OCM	EXPIRED & LOCKED
XS$NULL	EXPIRED &         LOCKED
MDSYS	EXPIRED &         LOCKED
CTXSYS	EXPIRED &         LOCKED
DBSNMP	EXPIRED &         LOCKED
XDB	EXPIRED &         LOCKED
APPQOSSYS	EXPIRED & LOCKED
*/

SELECT USERNAME, USER_ID, ACCOUNT_STATUS, PASSWORD, LOCK_DATE
FROM DBA_USERS;
--==>>
/*
SYS			0		OPEN		
SYSTEM			5		OPEN		
ANONYMOUS		35		OPEN		
HR			43		OPEN		
APEX_PUBLIC_USER	45		LOCKED			14/05/29
FLOWS_FILES		44		LOCKED			14/05/29
APEX_040000		47		LOCKED			14/05/29
OUTLN			9		EXPIRED & LOCKED	21/03/23
DIP			14		EXPIRED & LOCKED	14/05/29
ORACLE_OCM		21		EXPIRED & LOCKED	14/05/29
XS$NULL	21474836	38		EXPIRED & LOCKED	14/05/29
MDSYS			42		EXPIRED & LOCKED	14/05/29
CTXSYS			32		EXPIRED & LOCKED	21/03/23
DBSNMP			29		EXPIRED & LOCKED	14/05/29
XDB			34		EXPIRED & LOCKED	14/05/29
APPQOSSYS		30		EXPIRED & LOCKED	14/05/29
*/

SELECT * --����׸�
FROM DBA_USERS;

SELECT USERNAME, USER_ID
FROM DBA_USERS;

--> ��DBA_�� �� �����ϴ� Oracle Data Dictionary View ��
--   ������ ������ �������� �������� ��쿡�� ��ȸ�� �����ϴ�.
--   ������ ������ ��ųʸ� ������ ���� ���ص� �������.

--�� ��hr �� ����� ������ ��� ���·� ����
ALTER USER HR ACCOUNT LOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� �ٽ� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
//--==>>
/*
SYS	                  OPEN
SYSTEM	                  OPEN
ANONYMOUS	          OPEN
APEX_PUBLIC_USER	  LOCKED
FLOWS_FILES	          LOCKED
APEX_040000	          LOCKED
HR	                  LOCKED
OUTLN	EXPIRED &         LOCKED
DIP	EXPIRED &         LOCKED
ORACLE_OCM	EXPIRED & LOCKED
XS$NULL	EXPIRED &     	  LOCKED
MDSYS	EXPIRED &         LOCKED
CTXSYS	EXPIRED &         LOCKED
DBSNMP	EXPIRED &         LOCKED
XDB	EXPIRED &         LOCKED
APPQOSSYS	EXPIRED & LOCKED
*/

--�� hr ����� ������ ��� ���� ���·� ����
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
           :
  HR	 OPEN
           :
*/

--------------------------------------------------------------------------

--�� TABLESPACE ����

--�� TABLESPACE ��?
--   ���׸�Ʈ(���̺�, �ε���, ...)�� ��Ƶδ�(�����صδ�)
--   ����Ŭ�� ������ ���� ������ �ǹ��Ѵ�.


CREATE TABLESPACE TBS_EDUA                  -- CREATE ���� ��ü��    �� ����
DATAFILE 'C:\TESTORADATA\TBS_EDUA01.DEF'    -- ���������� ����Ǵ� ������ ����
SIZE 4M                                     -- ������ ������ ������ �뷮
EXTENT MANAGEMENT LOCAL                     -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����
SEGMENT SPACE MANAGEMENT AUTO;              -- ���׸�Ʈ ���� ������ �ڵ����� ����Ŭ ������..
--==>> TABLESPACE TBS_EDUA��(��) �����Ǿ����ϴ�.

--�� ���̺����̽� ���� ������ �����ϱ� ����
--   �������� ��ο� ���͸�(C:\TESTORADATA\) ������ ��.

--�� ������ ���̺����̽�(TBS_EDUA) ��ȸ
SELECT *
FROM DBA_TABLESPACES;
--==>>
/*
SYSTEM	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
SYSAUX	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
UNDOTBS1	8192	65536		1	2147483645	2147483645		65536	ONLINE	UNDO	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOGUARANTEE	NO	HOST	NO	
TEMP	8192	1048576	1048576	1		2147483645	0	1048576	ONLINE	TEMPORARY	NOLOGGING	NO	LOCAL	UNIFORM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
USERS	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
*/

--�� �������� ���� �̸� ��ȸ 
SELECT *
FROM DBA_DATA_FILES;
--==>>
/*
            :
C:\TESTORADATA\TBS_EDUA01.DEF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
*/


--�� ����Ŭ ����� ���� ����
CREATE USER kab IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--> kab ��� ����ڸ� ����ڴ�. (�����ϰڴ�.)
--  �н������ java006$ �� �ϰڴ�.
--  �� ������ ���� �����ϴ� ����Ŭ ��ü��(���׸�Ʈ����)
--  �⺻������(default) TBS_EDA ��� ���̺� �����̽� ������ �� �ֵ��� �����ϰڴ�.

--�� ������ ����Ŭ ����� ����(kab)�� ����
--   ������ �õ��� �������� ���� �Ұ�.
--   �� ��CREATE SESSION�� ������ ���� ������...

--�� ������ ����Ŭ ����� ����(kab)�� 
--   ���� ������ ������ �� �ֵ��� CREATE SESSION ���� �ο� �� SYS ��...
GRANT CREATE SESSION TO kab;
--==>> Grant��(��) �����߽��ϴ�.


--�� ������ ����Ŭ ����� ����(KAB)�� 
--   DEFAULT TABLESPACE ��ȸ

SELECT USERNAME, DEFAULT_TABLESPACE
FROM DBA_USERS;
--==>>
/*
SYS	                SYSTEM
SYSTEM	                SYSTEM
ANONYMOUS	        SYSAUX
HR	                USERS
KAB	                TBS_EDUA
APEX_PUBLIC_USER	SYSTEM
FLOWS_FILES     	SYSAUX
APEX_040000	        SYSAUX
OUTLN			SYSTEM
DIP			SYSTEM
ORACLE_OCM		SYSTEM
XS$NULL			SYSTEM
MDSYS			SYSAUX
CTXSYS			SYSAUX
DBSNMP			SYSAUX
XDB			SYSAUX
APPQOSSYS		SYSAUX
*/

--�� ������ ����Ŭ ����� ����(KAB)��
--   �ý��� ���� ���� ��ȸ

SELECT *
FROM DBA_SYS_PRIVS;
--==>>
/*
        :
KAB	CREATE SESSION	NO
        :
*/

--�� ������ ����Ŭ ����� ����(KAB)��
--   ���̺� ������ ������ �� �ֵ��� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO KAB;
--==>> Grant��(��) �����߽��ϴ�.


--�� ������ ����Ŭ ����� ����(KAB)��
--   ���̺����̽�(TABLE_EDUA)���� ����� �� �ִ� ����(�Ҵ緮)
--   �� ũ�⸦ ���������� ����.
ALTER USER KAB
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User KAB��(��) ����Ǿ����ϴ�.


