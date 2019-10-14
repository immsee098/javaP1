--10��_Ʈ����.sql
--[2019-10-14 ��]
/*
    Ʈ����
    - ���� ���α׷� ������ �ϳ��� Ʈ���Ŵ� ���̺�, ��, ��Ű�� �Ǵ� �����ͺ��̽��� 
    ���õ� PL/SQL ���(�Ǵ� ���ν���)���� ���õ� Ư�� ���(event)�� �߻��� ������ 
    �ڵ����� �ش� PL/SQL ����� �����
    
    - insert, update, delete�� DML���̳� DDL���� ������ �����ͺ��̽������� 
    Ư�� �̺�Ʈ�� �߻��Ǿ��ٰ� �ϴµ�, 
    �̷� �̺�Ʈ�� �߻��ϸ� �ڵ����� ������ ������ �����ϴ� �����ͺ��̽� ��ü�� 
    Ʈ���Ŷ�� ��
    
    �ֿ� Ʈ���� ����
    [1] DML Ʈ����
    1) ���� Ʈ���� - ������ �޴� ���� ���� ������ Ʈ���Ű� �ѹ��� �����
    2) �� Ʈ���� - ���̺��� Ʈ���� �̺�Ʈ�� ������ ���� ������ ����ǰ�,
        Ʈ���� �̺�Ʈ�� ������ �޴� ���� ���� ��쿡�� ������� ����
    
    [2] DML�� �ƴ� Ʈ����
    1) DDL �̺�Ʈ Ʈ����
    - DML Ʈ���ſ� ���� ���������� Ʈ���Ÿ� Ȱ���Ͽ� DDL�۾��� �ϴ� �͸� �ٸ�
    
    2) �����ͺ��̽� �̺�Ʈ Ʈ����
    - �����ͺ��̽� ������ ����� �ϵ��� �����ϱ� ���ؼ� �����ϴ� Ʈ����    
*/

/*
    create or replace trigger Ʈ���� �̸�
        Ʈ���� ������� [before | after]
        �̺�Ʈ [insert | update | delete]
        on {���̺��̸� | ���̸� | ��Ű�� | �����ͺ��̽�}
    [for each row]
    begin
        Ʈ���� ��ü
    end;    
*/

--[1] �μ� ���̺�(dept)�� insert�� ���� �� �޽����� ����ϴ� Ʈ����(���� ���� Ʈ����)
create or replace trigger tr_dept_insert
after insert on dept
begin
    dbms_output.put_line('���������� �ԷµǾ����ϴ�.');
end;

select * from user_triggers; --����ڰ� ���� Ʈ���� ���� ��ȸ

select * from dept;

insert into dept(deptno, dname, loc)
values(50, 'TEST', 'seoul'); --dept ���̺� insert �̺�Ʈ�� �߻��� �Ŀ�
--tr_dept_insert Ʈ���Ű� �����

--[2] ���̺� �����͸� �Է��� �� �ִ� �ð� �����ϱ�(���� ���� Ʈ����)
create table t_order(
    no number,
    ord_code    varchar2(10),
    ord_date    date
);

--�Է½ð��� 17:40 ~ 17:50 �� ��츸 �Է��� ����ϰ�, 
--�� �� �ð��� ���� ������ �߻���Ű�� Ʈ����
drop trigger tr_check_time;

create or replace trigger tr_check_time
before insert on t_order
begin
    if to_char(sysdate, 'HH24:mi') not between '18:40' and '18:50' then
        raise_application_error(-20009, '17:40~17:50�� ��쿡�� �Է°���!');
    end if;
end;

insert into t_order(no, ord_code, ord_date)
values(3, 'A03', sysdate);

select * from t_order;

--[3] ���̺� �Էµ� ������ ���� �����ϰ�, �� �� �ܿ��� ������ �߻���Ű�� Ʈ����
--(�� ���� Ʈ����)
--��ǰ �ڵ尡 'C100'�� ��ǰ�� �Էµ� ��� �Է��� ����ϰ�, 
--������ ��ǰ�� ��� ������ �߻���Ű�� Ʈ����
create or replace trigger tr_code_check
before insert on t_order
for each row  --�� ���� Ʈ����
begin
    if :new.ord_code != 'C100' then
        raise_application_error(-20010, '��ǰ�ڵ尡 C100�� ��ǰ�� �Է� ����!');
    end if;
end;

insert into t_order(no, ord_code, ord_date)
values(4, 'C100', sysdate);  --�Է� ����

insert into t_order(no, ord_code, ord_date)
values(5, 'C200', sysdate);  --error

/*
old - ������ �� ���� ���� ���� ������ ����
new - �����Ͱ� �߰� Ȥ�� ����Ǹ� new �����ڷ� ���� ���� ���� ���� �� ����
user - ���� �������� ����ڸ� ��Ÿ��
*/

--[4] ���� ���̺�(t_test1)�� �����Ͱ� ������Ʈ�� �� ���� ������ 
--��� ���̺�(t_test1_bak)�� �̵���Ű�� Ʈ����
create table t_test1(
    no number,
    name    varchar2(10)
);

create table t_test1_bak
as 
select * from t_test1;

insert into t_test1 values(1, 'AAA'); 
insert into t_test1 values(2, 'BBB'); 
commit;


create or replace trigger tr_backup_t_test1
after update on t_test1
for each row --�� ���� Ʈ����
begin
    insert into t_test1_bak(no, name)
    values(:old.no, :old.name);
end;

update t_test1
set name='CCC'
where no=1;

select * from t_test1;
select * from t_test1_bak;

update t_test1 
set name='DDD';  --2���� ���� update�� => 2�� �෹�� Ʈ���Ű� �����

--