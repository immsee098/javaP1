--9��_PL_SQL.sql
--[2019-10-11 ��]
--PL/SQL
/*
    - Procedural language extension to Structured Query Language
    - SQL�� �Ϲ� ���α׷��� ����� Ư���� ������ ���
    - ����, ��� ���� ����
    - ���ǹ�, �ݺ��� ��� ����
*/
/*
    �����
        - declare Ű���� ���
        - ������ ����� �����ϴ� �κ�
        
    �����
        - begin ~ end Ű���� ���
        - ������ �� �Ҵ�, ���ǹ�, �ݺ���, sql���� ���� ó��
        - �����ؾ��� ������ �ִ� �κ�
    
    ����ó����
        - exception Ű���� ���
        - ����ο��� ���ܰ� �߻����� �� ó���ϴ� �κ�    
*/
--�����,�����,����ó���ΰ� �ϳ��� PL/SQL ����� �����ϰ�,
--����Ŭ�� �� ��ϴ����� ó����

declare  --����� - ������ �����ϴ� �κ�
    counter number;
begin  --�����-ó���� ������ �ִ� �κ�
    --������ �� �Ҵ�
    counter := 1;
    
    --���� ó��
    counter:=counter/0;
    
    if counter is not null then
        dbms_output.put_line('counter=>' || counter);
    end if;
    
    --exception when others then  --����ó����
    exception when ZERO_DIVIDE then
        dbms_output.put_line('0���� ������ �ȵ˴ϴ�.');
end;    

--1~10 ���� for�� �̿��Ͽ� �ݺ�ó��
declare
    i   number;
    result  number;
begin
    for i in 1..10 loop
        result := i*2;
        dbms_output.put_line(result);
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--while�� �̿�
declare
    i   number;
    result  number;
begin
    i:=1;
    while i<=10 loop
        result := i*3;
        dbms_output.put_line(i || '*3 => ' || result);
        
        i:=i+1;
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--����, ��� ����
/*
    ������ ������Ÿ��;  --���� ����
    ������ constant ������Ÿ��;  --��� ����
    ������ ���̺��.�÷���%type;  --���� ����
        => �ش� ���̺��� �ش� �÷��� ������ Ÿ���� ���� ����
    
    ��) name varchar2(30);
       curYear  constant    number := 2019;
       empNo    employees.employee_id%type;       
*/
select * from employees;

--���ǹ�
/*
    1) if��
        if ����1 then
            ����1;
        elsif ����2 then
            ����2;
        else
            ����3;
        end if;
            
    2) case��
        case
        when ���� then
            ����1;
        else
            ����2;
        end case;
*/
--if�� �̿�
declare
    grade   char;
    result  varchar2(50);
begin
    grade:='B';
    
    if grade='A' then
        result:='Excellent';
    elsif grade='B' then
        result:='Good';
    elsif grade='C' then
        result:='Fair';
    elsif grade='D' then
        result:='Poor';
    else
        result:='Not found!';        
    end if;
    
    dbms_output.put_line(grade || '=>' || result);
            
    exception when others then
        dbms_output.put_line('error!');
end;

--case�� �̿�
declare
    grade   char;
    result  varchar2(50);
begin
    grade:='C';
    
    case grade
        when 'A' then
            result:='Excellent';
        when 'B' then
            result:='Good';
        when 'C' then
            result:='Fair';
        when 'D' then
            result:='Poor';
        else
            result:='not found!';
    end case;
        
    dbms_output.put_line('case�� : ' || grade || '=>' || result);
                       
    exception when others then
        dbms_output.put_line('error!');
end;    

--�ݺ���
/*
1) 
    loop
        exit when ����;
        
    end loop;

2)
    for ���� in [reverse] �ʱⰪ..���ᰪ loop
        ó���� ����;
    end loop;

3)
    while ���� loop
        ó���� ����;
    end loop;
*/
--loop�� �̿�
declare
    i   number;
    result  number;
begin
    i:=1;
    
    loop
        result:=i*2; --2,...20,22
        
        exit when result>20;  --������ �����ϸ� �ݺ��� Ż��
        dbms_output.put_line(result); --2,...20
        
        i:=i+1; --10,11
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--for��
declare
    i   number;
    result  number;
begin
    for i in 1..10 loop
        result:=i*5;
        
        dbms_output.put_line('i=' || i || ', result=' || result);
    end loop;
    
    dbms_output.put_line('---------for�� reverse�̿�-------------');
    result:=0;
    
    for i in reverse 1..10 loop
        result:=i*4;
        
        dbms_output.put_line('i=' || i || ', result=' || result);
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--while��
declare
    i   number;
    result  number;
begin
    i:=1;
    result:=0;
    
    while result<20 loop
        result:=i*2; --2,..18,20
        dbms_output.put_line(result); --2..18,20
        
        i:=i+1; --2,..9,10,11
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--PL/SQL ���� ���α׷�
/*
    - �����ͺ��̽� ��ü�� �����ؼ� �ʿ��� ������ ȣ���Ͽ� ����� �� �ִ� PL/SQL���
    
    1) �Լ� (function) - ������� ��ȯ��
        ����� ���� �Լ��� ����
        Ư�� ����� ������ ��, ������� ��ȯ�ϴ� �������α׷�
    2) ���� ���ν���, ���� ���ν���(stored procedure) - ������� ��ȯ���� ����
*/
--�Լ�
/*
    create or replace function �Լ���
    (�Ķ����1  ������Ÿ��,
     �Ķ����2  ������Ÿ��, ...)
        return ������Ÿ��
    
    is �Ǵ� (as)
        ���� ����
    begin
        ó���� ����
        
        exception when others then
            ����ó���� ����
    end;        
*/
--�ֹι�ȣ�� ������ ������ �����ϴ� �Լ� �����
create or replace function get_gender
(
    --�Ķ����
    p_ssn   varchar2
)
return  varchar2  --��ȯŸ��
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
        dbms_output.put_line('error');    
end;

--�Լ� �����Ű��
select get_gender('1207093334444') from dual; --����� ���� �Լ�
select length('java') from dual;  --����Ŭ �Լ�

select studno, name, jumin, get_gender(jumin) from student;
select studno, name, jumin, length(name) from student;

--�ֹι�ȣ�� �̿��ؼ� ���̸� ���ϴ� �Լ� �����
--get_age
create or replace function get_age
(
    --�Ķ����
    p_ssn   varchar2
)
return number   --��ȯŸ��
is
    --��������
    v_age  number;
begin
    --ó���� ����
    select extract(year from sysdate)-
        (substr(p_ssn,1,2) + case when substr(p_ssn,7,1) in ('1','2')
            then 1900 else 2000 end
        ) + 1 into v_age
    from dual;
    
    return v_age;
    
    exception when others then
        dbms_output.put_line('error');    
end;

select get_age('1301054447777') from dual;
select jumin, get_age(jumin) "����", get_gender(jumin) "����",
    trunc(get_age(jumin),-1)  "���ɴ�"
 from gogak;

--stored procedure(���� ���ν���, ���� ���ν���)
--Ư�� ����� ���������� ���� ��ȯ������ �ʴ� ���� ���α׷�
/*
    create or replace procedure ���ν�����
    (
        �Ķ����1   ������Ÿ��,
        �Ķ����2   ������Ÿ��,
        ...
    )
    is[as]
        ���� �����
    begin
        ó���� ����
        
        exception when others then
            ����ó��
    end;
*/
select * from pd2;
select * from user_sequences;

--pd2 ���̺� �Է��ϴ� ���ν���
create or replace procedure pd2_insert
(
    --�Ķ����
    --pd2 ���̺� insert�Ҷ� �ʿ��� �Ķ���͵�
    p_pdcode    char,
    p_pdname    varchar2,
    p_price     number,
    p_company   varchar2
)
is
    --���� �����
begin
    insert into pd2(no, pdcode, pdname, price, company)
    values(pd2_seq.nextval, p_pdcode,p_pdname, p_price, p_company);
    
    commit;  --�����ϸ� Ŀ��
    
    exception when others then
        dbms_output.put_line('pd2 ���̺� insert error!');
        rollback; --�����ϸ� �ѹ�
end;

--���� ���ν��� �����Ű��
/*
    execute ���ν����̸�(�Ķ����);
    �Ǵ�
    exec ���ν����̸�(�Ķ����);
*/
execute pd2_insert('C01','���콺',34000,'�Ｚ');

exec pd2_insert('C02','�����',470000,'LG');

select * from pd2 order by no desc;

--pd2 ���̺� �÷��� �����ϴ� ���ν��� �����
create or replace procedure pd2_update
(
    --�Ķ����
    p_no    pd2.no%type, --���̺��.�÷���%type => �ش� ���̺��� �ش� �÷��� ������
                         --������ Ÿ��
                         --=> pd2���̺��� no �÷��� ������ Ÿ��
    p_pdcode    pd2.pdcode%type,
    p_pdname    pd2.pdname%type,
    p_price    pd2.price%type,
    p_company    pd2.company%type                     
)
is
    --���� �����
    v_cnt   number(3);
begin
    select count(*) into v_cnt
    from pd2
    where no=p_no;
    
    --�ش� �����Ͱ� �����ϸ� update
    if v_cnt>0 then
        update pd2
        set pdcode=p_pdcode, pdname=p_pdname, price=p_price,
            company=p_company
        where no=p_no;
    end if;
    
    commit;
    
    exception when others then
        dbms_output.put_line('pd2 ���̺� update error!');
        rollback;
end;

exec pd2_update(4,'B03','��ǻ��',1500000,'hp');

select * from pd2 order by no desc;

--���� ���ν���,�Լ� Ȯ��
select * from user_source
where name='PD2_UPDATE';

--exists �̿��� update
create or replace procedure pd2_update2
(
    --�Ķ����
    p_no    pd2.no%type,
    p_pdcode    pd2.pdcode%type,
    p_pdname    pd2.pdname%type,
    p_price    pd2.price%type,
    p_company    pd2.company%type  
)
is
begin
    update pd2 a
    set pdcode=p_pdcode, pdname=p_pdname, price=p_price,
        company=p_company
    where exists (select 1 from pd2 b where b.no=a.no
                    and b.no=p_no);
    commit;
    
    exception when others then
        raise_application_error(-20001, 'pd2 update �� ���ܹ߻�!');
        --����� ���� ���ܹ�ȣ�� -20001 ~ 20999����
        
        rollback;        
end;

exec pd2_update2(4, 'B04', '��Ʈ��', -50, 'LG'); --error

exec pd2_update2(4, 'B04', '��Ʈ��', 2000000, 'LG'); 

select * from pd2 order by no desc;

select * from user_constraints
where table_name ='PD2';
select * from user_cons_columns
where table_name ='PD2';

--%rowtype
/*
    - %type�� �����ϳ�, �� �� �̻��� ���� ���� ����
    - �ο�Ÿ�� ������ ������ ���̺� �ִ� row ���� ����
*/
create or replace procedure prof_info
(
    p_profno    professor.profno%type
)
is
    --���� ����
    v_prof_row  professor%rowtype; --professor ���̺��� �� ����
                                --row(���ڵ�) ������ ���� �� �ִ� Ÿ��
    v_result    varchar2(2000);                            
begin
    select *  into v_prof_row 
    from professor
    where profno=p_profno;
    
    v_result:=v_prof_row.profno || ' ' ||
            v_prof_row.name || ' ' ||
            v_prof_row.position || ' ' ||
            nvl(v_prof_row.pay+v_prof_row.bonus,
                v_prof_row.pay);
    
    dbms_output.put_line(v_result);
    
    exception when others then
        raise_application_error(-20002, 'professor���̺� ��ȸ����');            
end;

exec prof_info(1001);

select * from professor
where profno=1001;

--����� ���� ����
select * from member;

select * from user_sequences;

create sequence member_seq
start with 1005
increment by 1
nocache;

create or replace procedure member_insert
(
    --�Ķ����
    p_name  member.name%type,
    p_jumin  member.jumin%type,
    p_passwd  member.passwd%type,
    p_id  member.id%type
)
is
    --��������
    system_check_insert_fail    exception;  --����� ���� ����    
begin
    --�Ͽ��� 23:00:00 ~ 23:59:59 ���̿��� �ý��� �۾����� ���� �Է� �Ұ�
    /*if to_char(sysdate, 'd')=1 and to_char(sysdate,'hh24')=23 then
        raise system_check_insert_fail;  --������ ����� ���� ���� �߻���Ű��
    end if;*/
    
    if to_char(sysdate, 'd')=6 and to_char(sysdate,'hh24')=18 then
        raise system_check_insert_fail;  --������ ����� ���� ���� �߻���Ű��
    end if;
    
    --�Ͽ��� 23�� �ð��밡 �ƴϸ� �Է� ����
    insert into member(no, name, jumin, passwd, id)
    values(member_seq.nextval,p_name, p_jumin, p_passwd, p_id );
    
    commit;
    
    exception when system_check_insert_fail then
        raise_application_error(-20990, 
        '�Ͽ��� 23:00:00~23:59:59 ���̿��� �ý��� �����۾����� ���� �̿�Ұ�!');
        rollback;
end;

exec member_insert('ȫ�浿2','9707051112222','1234','hong2');

select * from member;


--[2019-10-14 ��]
--out �Ű�����(�Ķ����)
--����� ����ϴ� �뵵�� �Ű�����

--in �Ű����� - �Ϲ����� �Ű�����, �Է¿� �Ű�����
--�����ϸ� in �Ű�����

create or replace procedure proc_prof
(
    p_profno    in  PROFESSOR.PROFNO%type,  --in �Ű�����
    o_name      out professor.name%type,    --out �Ű�����
    o_pay      out professor.pay%type    --out �Ű�����
)
is
begin
    select name, pay into o_name, o_pay
    from professor
    where profno=p_profno;
    
    exception when others then
        raise_application_error(-20003, 'professor ��ȸ ����');
end;

--out �Ű������� �ִ� ���ν��� �����ϱ�
declare
    v_name  professor.name%type;
    v_pay   professor.pay%type;
begin
    proc_prof(1001, v_name, v_pay);
    dbms_output.put_line('�̸�:' || v_name || ',�޿�:'||v_pay);
    
    exception when others then
        dbms_output.put_line('error!');
end;

--select procedure
create or replace procedure proc_pd2_select
is
begin
    select * from pd2;  --error
    --an INTO clause is expected in this SELECT statement
    
    exception when others then
        dbms_output.put_line('error!');
end;

--PL/SQL Ŀ��
/*
Ŀ��
- ������ ���� ��ȯ�Ǵ� ����� �޸� �� ��ġ�ϰ� �Ǵµ�, 
  PL/SQL������ Ŀ���� ����Ͽ� �� ������տ� ������ �� �ִ�.
- Ŀ���� ����ϸ� ��������� �� ���� �����Ϳ� ������ �����ϴ�.

����� Ŀ��
- ����ڰ� ���� ������ ����� �����ؼ� �̸� ����ϱ� ���� ��������� ������ Ŀ��

����� Ŀ���� ����ϱ� ���� ����
[1] Ŀ�� ���� ? ���� ����
cursor Ŀ���� is select ����;

[2] Ŀ�� ����(open) - ���� ����
open Ŀ����;

[3] ��ġ(fetch) - ������ ����� ����, ������ ���� ���� ���鿡 ����
fetch Ŀ���� is ����...;

[4] Ŀ�� �ݱ�(close) - �޸𸮻� �����ϴ� ������ ����� �Ҹ��Ŵ
close Ŀ����;
*/
create or replace procedure proc_pd2_select
is
    --[1] Ŀ�� ����
    cursor pd2_csr is
        select no, pdcode, pdname, price from pd2;
    
    --���� ����
    pd2_rcd pd2%rowtype;
           
begin
    --[2] Ŀ�� ����
    open pd2_csr;
    
    --[3] ��ġ(fetch) - ������ ����� ����, ������ ���� ���� ���鿡 ����
    loop
        fetch pd2_csr into pd2_rcd.no, pd2_rcd.pdcode,
            pd2_rcd.pdname, pd2_rcd.price;
        
        exit when pd2_csr %notfound;
        
        dbms_output.put_line(pd2_rcd.no|| ' ' || pd2_rcd.pdcode
            || ' ' || pd2_rcd.pdname || ' ' || pd2_rcd.price);
    end loop;
    
    --[4] Ŀ�� �ݱ�
    close pd2_csr;
    
    exception when others then
        raise_application_error(-20003, 'pd2��ȸ ����');
end;

exec proc_pd2_select();

select * from pd2;
/*
    %notfound - Ŀ�������� ��� ������ �Ӽ�
    - �� �̻� ��ġ(�Ҵ�)�� �ο찡 ������ �ǹ�
    - ������ ������ ������� ��ġ�� �Ŀ� �ڵ����� ������ ���������� ��
*/

--for loop cursor ��
/*
    Ŀ���� for loop���� ����ϸ� Ŀ���� open, fetch, close�� �ڵ�������
    �߻��Ǿ����� ������ open, fetch, close ���� ����� �ʿ䰡 ����
    
    ����
    for ������(���ڵ� ������ ���� ����) in Ŀ���� loop
        ���� ����
    end loop;
*/
create or replace procedure proc_pd2_select2
is
    --Ŀ�� ����
    cursor pd2_csr is
        select no,pdcode,pdname,price from pd2;
begin
    for pd2_row in pd2_csr loop
        dbms_output.put_line(pd2_row.no || ' ' || pd2_row.pdcode
            || ' ' || pd2_row.pdname || ' ' || pd2_row.price);
    end loop;

    exception when others then
        raise_application_error(-20007, 'pd2 select error!');
end;

exec proc_pd2_select2;

--sys_refcursor
/*
���� ���ν����� select ������� JAVA ���� �б� ���ؼ��� SYS_REFCURSOR Ÿ���� 
����ؾ� ��
*/
create or replace procedure proc_pd2_select3
(
    pd2_cursor  out sys_refcursor
)
is
begin
    open pd2_cursor for
        select no, pdcode, pdname, price, company, regdate
        from pd2;
        
    exception when others then
        raise_application_error(-20004, 'pd2 ���̺� ��ȸ�� ����!');
end;

--���� �հ� ���ϱ�
--��ǰ �ڵ庰, ��¥�� ���� �Ǹŷ�
select * from panmae;

select p_code ��ǰ�ڵ�, p_date �Ǹ�����, p_qty �Ǹŷ�,
sum(p_qty) over(partition by p_code order by p_date) �����Ǹŷ�
from panmae
order by p_code, p_date; 

--��ǰ�ڵ庰, �Ǹ����ں�, �Ǹŷ��� �հ踦 ���� ���Ѵ�
select p_code, p_date, sum(p_qty) as qty_total
from panmae
group by p_code, p_date
order by p_code, p_date;

--inline view �̿�
select p_code, p_date,qty_total �Ǹŷ�,
    sum(qty_total) over(partition by p_code order by p_date) �����Ǹŷ�
from
(
    select p_code, p_date, sum(p_qty) as qty_total
    from panmae
    group by p_code, p_date
);

--�� �����
create or replace view v_panmae
as
select p_code, p_date,qty_total �Ǹŷ�,
    sum(qty_total) over(partition by p_code order by p_date) �����Ǹŷ�
from
(
    select p_code, p_date, sum(p_qty) as qty_total
    from panmae
    group by p_code, p_date
);

select * from v_panmae;

--panmae ���̺��� ����Ͽ� �Ǹų����� ����ϵ� �Ǹ�����, �Ǹŷ�,�Ǹűݾ�,���� �Ǹŷ�,
--���� �Ǹűݾ��� ���
select p_date, p_qty, p_total,
    sum(p_qty) over(order by p_Date) �����Ǹŷ�,
    sum(p_total) over(order by p_Date) �����Ǹűݾ�
from panmae;    

select p_date, sum(p_qty) qty_tot, sum(p_total) price_tot
from panmae
group by p_date
order by p_date;

select p_date, qty_tot, price_tot, 
    sum(qty_tot) over(order by p_date) "���� �Ǹŷ�",
    sum(price_tot) over(order by p_date) "���� �Ǹűݾ�"
from
(
    select p_date, sum(p_qty) qty_tot, sum(p_total) price_tot
    from panmae
    group by p_date
);

--p_store��, p_date�� ���� �Ǹűݾ� ���ϱ�

select * from panmae;

select p_date, p_store, sum(p_qty) qty_tot, sum(p_total) price_tot
from panmae
group by p_date, p_store
order by p_date, p_store;

select p_date, p_store, qty_tot, price_tot,
    sum(qty_tot) over(partition by p_store order by p_date) "���� �Ǹŷ�",
    sum(price_tot) over(partition by p_store order by p_date) "���� �Ǹűݾ�"
from
(
select p_date, p_store, sum(p_qty) qty_tot, sum(p_total) price_tot
from panmae
group by p_date, p_store
order by p_date, p_store

);