--[ ����Ŭ 9�� ]
--(1) SQL�� �Ϲ� ���α׷��� ����� Ư���� ������ ���� ����, ��� ����, ���ǹ�, �ݺ��� ����� ������ �� 
--�����̶�� �ϴ°�?

--pl/sql


--(2) exam_01 ���̺��� ������ ���� ������ 10�� ��ȸ�ϴ� �並 �ۼ��Ͻÿ�.

select * from exam_01
where rownum <=10
order by total;


--(3) (  �����  ), (  ����� ), (  ����ó���� )�� �ϳ��� PL/SQL ����� �����ϰ�,
--����Ŭ�� �� ��� ������ ó���Ѵ�.



--(4) PL/SQL ���� ���α׷��� �����ͺ��̽� ��ü�� �����ؼ� �ʿ��� ������ ȣ���Ͽ� ����� �� �ִ� PL/SQL ���
--�� ���Ѵ�. PL/SQL ���� ���α׷��� �Լ��� ���� ���ν����� ���� �� �ִµ�, 
--Ư�� ����� ������ ��, ������� ��ȯ�ϴ� �������α׷��� ( fuction )��� �ϰ�, 
--������� ��ȯ���� �ʴ� �������α׷��� (  procedure  )��� �Ѵ�.
    
--(5) �ֹι�ȣ�� ������ ������ �����ϴ� �Լ��� �����, �Լ��� ������Ѽ� gogak ���̺��� ������ ���Ͻÿ�.
create or replace function getG_function
(p_jumin varchar2)
return varchar2
is 
    v_gender varchar2(20);
begin
    select case when substr(p_jumin, 7, 1) in ('1', '3')then '��'
        else '��'
        end
        into v_gender
        from dual;
        
        return v_gender;
end;

select * from gogak;

select getG_function(jumin) from gogak;

--(6) gogak ���̺��� gno�÷��� �⺻Ű ���������� �߰��Ͻÿ�. 
alter table gogak
add constraint fk_gno primary key(gno);


--(7) gogak���̺��� gno�� �ڵ����� 1�� �����ϴ� ���� �Է��� �� �ֵ��� sequence�� �����Ͻÿ�.
--20010033���� �����ϰ� 1�� �����ϵ��� (gogak_seq)
create sequence gogak_seq
minvalue 20010033
maxvalue 99999999999
increment by 1
start with 20010033
nocache;


--(8) ������ �������� �̿��Ͽ� gogak���̺� ���� �Է��ϴ� ���ν����� �ۼ��Ͻÿ�.
insert into gogak
values(gogak_seq.nextval, '���ؼ�',9504222035229, 85000);

--(9) �ۼ��� ���ν����� ������� ���� �Է��Ͻÿ�.    


--(10) gogak���̺��� ����ȣ�� �����ڵ带 �����ϴ� delete ���ν����� �ۼ��ϰ�, �������
--Ư�� �����ڵ带 �����Ͻÿ�

create or replace procedure del_gogak
(
    g_gno   gogak.gno%type
)
is
begin

    delete from gogak
    where gno = g_gno;
    
    exception when others then
        raise_application_error(-20001, '����!');
end;
select * from gogak;

select del_gogak('20010033') from dual;


--(11) exam10�̶�� �̸��� ���̺����̽��� �����ϰ�, 
--������ ���Ͽ� ���� ������ ���̺����̽��� ���� ������ ��ȸ�Ͻÿ�.
create tablespace exam10
datafile 'D:\myoracle\data\exam10.dbf' size 48M
autoextend on next 100M;

select tablespace_name, file_name from dba_data_files;
select * from dba_tablespaces;

--(12) exam10 ���̺����̽��� ����ϴ� ����ڰ����� �����ϰ�, ����� ���� ������ ��ȸ�Ͻÿ�.
--id: user1, pwd : u1234
create user user1
identified by u1234
default tablespace exam10;

select * from dba_sys_privs where grantee='user1';
select * from dba_users;

--(13) ������ ����ڿ��� Resource, Connect ����(��)�� �ο��Ͻÿ�.
grant connect, resource to user1;


--(14) ������� ���Ѱ� ���� ��ȸ�Ͻÿ�
select * from dba_sys_privs where grantee='user1';


--(15) ��� ���� ����
alter user user1 account unlock;

--(16) ���� ������ ��ȣ �����ϱ� (USER1�� ��ȣ�� USER123���� ����)
alter user user1 identified by user123;

--(17) ������ ����ڰ����� �����Ͻÿ�.
drop user user1;

--(18) ������ ���̺����̽��� �����ϵ�, �������� ���������ϱ��� �����Ͻÿ�.
drop tablespace exam10
including contents and datafiles;


--(19) panmae ���̺��� ����Ͽ� �Ǹų����� ����ϵ� �Ǹ�����, �Ǹŷ�, ���� �Ǹŷ��� ����Ͻÿ�.
--�Ǹ� ���ں��� �����Ͽ� ������ ��


--(20) emp2 ���̺��� ����Ͽ� ���, �̸�, �޿�, �μ���ȣ, �μ��� �޿������� ��ȸ�Ͻÿ�
 

