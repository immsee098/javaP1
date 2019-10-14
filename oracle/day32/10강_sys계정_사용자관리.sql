--10��_sys����_����ڰ���.sql
--[2019-10-14 ��]
--����� ���� ���� ��ȸ
select * from dba_users;

--���������Ͽ� ���� ���� ��ȸ
select * from dba_data_files;

--���̺����̽��� ���� ���� ��ȸ
select * from dba_tablespaces;

/*
    ����Ŭ �����ͺ��̽��� ���� ���屸��
    1) �����ͺ�(data block)-�ּ� ���� ����,
        �����ͺ��� default size: 8K
    2) �ͽ���Ʈ(extent) - 8���� �����ͺ��� �𿩼� �ϳ��� �ͽ���Ʈ�� ��
    3) ���׸�Ʈ(segment) - �ϳ� �̻��� �ͽ���Ʈ�� ����
    4) ���̺����̽�(tablespace) - ���׸�Ʈ���� �����ϴ� ������ �����̸�
    
    �ϳ��� ���̺����̽��� �ּ� 1���� ����������(������ ����)�� ������    
*/
--������ ���� size��ȸ - 8K
select value from v$parameter
where name='db_block_size';

--���̺����̽� ����
/*
    create tablespace ���̺����̽���
    datafile ������������ ��� size ũ��
    autoextend on next ũ�� -- �ڵ� ���� �ɼ�(����)
*/
create tablespace tb_test2
datafile 'D:\myoracle\data\tb_test2.dbf' size 48M
autoextend on next 10M;

select * from dba_data_files;
select * from dba_tablespaces;

--
create tablespace tb_test3
datafile 'D:\myoracle\data\tb_test3_01.dbf' size 48M
autoextend on maxsize 1000M,
         'D:\myoracle\data\tb_test3_02.dbf' size 48M
autoextend on maxsize 1000M,
         'D:\myoracle\data\tb_test3_03.dbf' size 48M
autoextend on maxsize 1000M;

--���̺����̽� ����
/*
    drop tablespace ���̺����̽���;
    
    drop tablespace ���̺����̽���
        including contents and datafiles;  --�������� ���������ϱ��� ����
*/   
drop tablespace tb_test3
including contents and datafiles;

--����� ���� �����
/*
    create user ������̸�
    identified by ��й�ȣ
    default tablespace ���̺����̽���;
*/
--tb_test2 ���̺����̽��� ����ϴ� ����ڰ��� �����
create user testuser3
identified by testuser123
default tablespace tb_test2;

select * from dba_users where username like 'TEST%';

--���� ��ȸ
select * from dba_sys_privs where grantee='TESTUSER2'; --������ȸ
select * from dba_ROLE_privs where grantee='TESTUSER2'; --������ȸ

--����ڿ��� ���� �ο��ϱ�
--create session ���� �ο�(���� ����)
grant create session to testuser2;

/*
create table tbl_test1
(
    no  number  primary key,
    name    varchar2(50)
)tablespace tb_test2;

*/

--���̺� ���� ���� �ο��ϱ�
grant create table to testuser2;
grant unlimited tablespace to testuser2;

--���� ��Ż
--revoke ���� from ����ڸ�;
revoke create session from testuser2;

--testuser3����ڿ��� resource, connect role �ο��ϱ�
grant connect, resource to testuser3;

select * from dba_sys_privs where grantee='TESTUSER3'; --������ȸ
select * from dba_ROLE_privs where grantee='TESTUSER3'; --������ȸ

select * from dba_sys_privs where grantee='RESOURCE';
select * from dba_sys_privs where grantee='CONNECT';

select * from dba_sys_privs where grantee='HR'; 
select * from dba_ROLE_privs where grantee='HR';
 
--����� ����
--DROP USER ������̸�;
drop user testuser3;

select * from dba_users where username like 'TEST%';

--��� ���� ����
--alter user �����ID account unlock;
alter user testuser2 account unlock;

--���� ��ױ�
--alter user �����ID account lock;
alter user testuser2 account lock;

--���� ������ ��ȣ �����ϱ�
--alter user �����ID identified by ���ο� ��ȣ;
alter user testuser2 identified by testuser123;

--����Ŭ�� �����ϴ� role ��ȸ
select * from dba_roles;

--���� �����ͺ��̽��� ��ȸ-xe, orcl
select * from global_name;

--object ���� �ֱ�
--�ش� object�� ������ �������� ������ �ο��ϰų� ��Ż�� �� �ִ�
--testuser3���� hr ������ employees ���̺��� ��ȸ�ϰ� ������ �� �ִ� ���� �ο�
--(hr�������� ó�� ����)
grant select on hr.employees to testuser3;

--select���� ��Ż
revoke select on hr.employees from testuser3;

--update���� �ο�
grant update on hr.employees to testuser3;

--update���� ��Ż
revoke update on hr.employees from testuser3;

/*
    testuser3 �������� ó��
    
    update hr.employees
    set salary=20000
    where employee_id=100;
*/

/*
with grant option
-������ �����ϴ� ���
�� �ٸ� ����ڿ��� ������ �Ҵ��� �� �� �ְ� ��
object ���ѿ��� ���
*/

grant resource, connect to testuser4;

revoke select on hr.employees from testuser3;

grant select on hr.employees to testuser3 with grant option;

/*
testuser3���� ó��
grant select on hr.employes to testuser4;
=> testuser3 ������ testuser4�������� hr�� employees�� select �� �� �ִ� ������ �ο���

=> testuser4�� �����ؼ� hr�� employees�� select�ϸ� ��ȸ��
*/

/*
with admin option
- ������ �����ϴ� ���
�� �ٸ� ����ڿ��� ������ �Ҵ����� �� �ְ� ��
system ���ѿ��� ���
*/

grant resource, connect to testuser5 with admin option;

/*
testuser5�� �����ؼ� testuser6���� resource, connect ���� �ο��ϱ�
grant resource, connect to testuser6;
*/

select * from user_views;
select * from hr.v_emp;

--hr������ v_emp�信 select �� �� �ִ� ������ testuser6���� �ο��ϱ�
grant select on hr.v_emp to testuser6;

--data dictionary
/*
 -�����ͺ��̽� ���� ����� ��� ��ü�� ������ �������ִ� ���̺�
 
 Data Dictionary�� ����
 1)DBA_XXX : �����ͺ��̽� ������ ���� ���� ����
 2)ALL_XXX :�ڽ��� ������ object�� �ٸ� ����ڰ� ������ object�߿� �ڽ��� �� �� �ִ� ������ ����
            -����ڰ� ���� ������ ��� ��Ű���� ������ ����
            -������ �ο��������ν� ����
 3)USER_XXX : �ڽ��� ������ object ������ ����
              ���� �����ͺ��̽����� ������ ����ڰ� ������ ��ü�� ������ ����
     
*/

--��� �ڷ��� ������ ������ ���
select * from dictionary where table_name like 'USER_%';
select * from dictionary where table_name like 'DBA_US%';

--�ڷ���� ���̺��� �� �÷��� ���� ������ ���
select * from dict_columns
where table_name='USER_CONS_COLUMNS';

select * from USER_CONS_COLUMNS;

--[1]User_XXX
select * from user_objects;
select * from user_tables;

select * from user_constraints;
select * from user_cons_columns;

select * from user_indexes;
select * from user_ind_columns;

select * from user_sequences;
select * from user_views;
select * from user_source;

--[2] all_XXX
select owner, table_name
from all_tables where table_name='EMPLOYEES';


--[3] dba_XXX
select * from dba_users;
select * from dba_data_files;
select * from dba_tablespaces;

select * from dba_roles;
select * from dba_sys_privs;
select * from dba_role_privs;