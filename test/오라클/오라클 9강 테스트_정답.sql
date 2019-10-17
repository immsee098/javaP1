--[ ����Ŭ 9�� ]
--(1) SQL�� �Ϲ� ���α׷��� ����� Ư���� ������ ���� ����, ��� ����, ���ǹ�, �ݺ��� ����� ������ �� 
--�����̶�� �ϴ°�?
--PL/SQL

--(2) exam_01 ���̺��� ������ ���� ������ 10�� ��ȸ�ϴ� �並 �ۼ��Ͻÿ�.
create or replace view v_exam
as
select *
from
(
    select studno, total
    from exam_01
    order by total
)
where rownum<=10;       

select * from v_exam;

--(3) (�����), (�����), (����ó����)�� �ϳ��� PL/SQL ����� �����ϰ�,
--����Ŭ�� �� ��� ������ ó���Ѵ�.


--(4) PL/SQL ���� ���α׷��� �����ͺ��̽� ��ü�� �����ؼ� �ʿ��� ������ ȣ���Ͽ� ����� �� �ִ� PL/SQL ���
--�� ���Ѵ�. PL/SQL ���� ���α׷��� �Լ��� ���� ���ν����� ���� �� �ִµ�, 
--Ư�� ����� ������ ��, ������� ��ȯ�ϴ� �������α׷��� (�Լ�)��� �ϰ�, 
--������� ��ȯ���� �ʴ� �������α׷��� (���� ���ν���)��� �Ѵ�.
    
--(5) �ֹι�ȣ�� ������ ������ �����ϴ� �Լ��� �����, �Լ��� ������Ѽ� gogak ���̺��� ������ ���Ͻÿ�.
CREATE OR REPLACE FUNCTION get_gender
(
    --�Ķ����
    p_ssn   varchar2
)
return varchar2  --��ȯŸ��
is
    --��������
    v_gender    varchar2(10);
begin
    --ó���� ����
    select case when substr(p_ssn,7,1) in ('1','3') then '����'
                      else '����' end
             into v_gender
    from dual;
    
    return v_gender;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--�Լ� �����Ű��
select gname, jumin, get_gender(jumin) as gender
from gogak;

--(6) gogak ���̺��� gno�÷��� �⺻Ű ���������� �߰��Ͻÿ�. 
alter table gogak
add constraint pk_gogak_gno primary key(gno);

--(7) gogak���̺��� gno�� �ڵ����� 1�� �����ϴ� ���� �Է��� �� �ֵ��� sequence�� �����Ͻÿ�.
--20010033���� �����ϰ� 1�� �����ϵ��� (gogak_seq)
create sequence gogak_seq
increment by 1
start with 20010033
nocache;

--(8) ������ �������� �̿��Ͽ� gogak���̺� ���� �Է��ϴ� ���ν����� �ۼ��Ͻÿ�.
create or replace procedure gogak_insert
(
    --�Ķ����    
    p_gname    gogak.gname%type,
    p_jumin    gogak.jumin%type,
    p_point    gogak.point%type                                    
)
is   
begin    
    insert into gogak(gno, gname, jumin, point)
    values(gogak_seq.nextval, p_gname, p_jumin, p_point);
    
    commit;

    exception when others then
        dbms_output.put_line('gogak ���̺� insert error!');
        rollback;
end;

--(9) �ۼ��� ���ν����� ������� ���� �Է��Ͻÿ�.    
exec gogak_insert('ȫ�浿','9901021115555', 15000);

select * from gogak;

--(10) gogak���̺��� ����ȣ�� �����ڵ带 �����ϴ� delete ���ν����� �ۼ��ϰ�, �������
--Ư�� �����ڵ带 �����Ͻÿ�
create or replace procedure gogak_delete
(
    --�Ķ����    
    p_gno    gogak.gno%type                                  
)
is   
begin    
    delete from gogak where gno=p_gno;
    
    commit;

    exception when others then
        dbms_output.put_line('gogak ���̺� delete error!');
        rollback;
end;

exec gogak_delete(20010033);

select * from gogak;


--(11) exam10�̶�� �̸��� ���̺����̽��� �����ϰ�, 
--������ ���Ͽ� ���� ������ ���̺����̽��� ���� ������ ��ȸ�Ͻÿ�.
create tablespace exam10
datafile 'C:\oraclexe\mydata\exam10.dbf' size 48m
autoextend on next 10m;

--������ ���Ͽ� ���� ���� ��ȸ 
select * from dba_data_files;
--���̺����̽��� ���� ���� ��ȸ
select * from dba_tablespaces;


--(12) exam10 ���̺����̽��� ����ϴ� ����ڰ����� �����ϰ�, ����� ���� ������ ��ȸ�Ͻÿ�.
--id: user1, pwd : u1234
create user user1
identified by u1234
default tablespace exam10;

select * from dba_users where username = 'USER1';

--(13) ������ ����ڿ��� Resource, Connect ����(��)�� �ο��Ͻÿ�.
grant connect, resource to user1;

--(14) ������� ���Ѱ� ���� ��ȸ�Ͻÿ�
select * from dba_sys_privs where grantee='USER1';  --���� ��ȸ
select * from dba_role_privs where grantee='USER1'; --�� ��ȸ

--(15) ��� ���� ����
alter user USER1 account unlock;

--(16) ���� ������ ��ȣ �����ϱ� (USER1�� ��ȣ�� USER123���� ����)
alter user USER1 identified by USER123;

--(17) ������ ����ڰ����� �����Ͻÿ�.
drop user user1;

--(18) ������ ���̺����̽��� �����ϵ�, �������� ���������ϱ��� �����Ͻÿ�.
    drop tablespace exam10
        including contents and datafiles;      


--(19) panmae ���̺��� ����Ͽ� �Ǹų����� ����ϵ� �Ǹ�����, �Ǹŷ�, ���� �Ǹŷ��� ����Ͻÿ�.
--�Ǹ� ���ں��� �����Ͽ� ������ ��
select p_date, qty_tot, 
    sum(qty_tot) over(order by p_date) �����Ǹŷ�
from(
    select p_date, sum(p_qty) qty_tot
    from panmae
    group by p_date
);


--(20) emp2 ���̺��� ����Ͽ� ���, �̸�, �޿�, �μ���ȣ, �μ��� �޿������� ��ȸ�Ͻÿ�
 select empno, name, pay,deptno, 
    rank() over(partition by deptno order by pay desc) "RANK"
from emp2;
