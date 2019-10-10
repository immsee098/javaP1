--8��_seq_index_view.sql
--[2019-10-10 ��]
--sequence
/*
    - �������� ���ڸ� �����س��� ��ü
    - �⺻ Ű�� ������ �ԷµǴ� row�� �ĺ��� �� �ֱ⸸ �ϸ� �ȴٰ� �� ��, 
      �������� ���� ������ ���� ���
    - ���̺� �ִ� �⺻Ű ���� �����ϱ� ���� ���Ǵ� �������� ��ü
    - ���̺� ���ӵ��� ���� => �ϳ��� �������� ���� ���� ���̺� ���ÿ� ����� �� �ִ�.
    
    create sequence ��������
    minvalue    --�������� �ּҰ�
    maxvalue    --�������� �ִ밪
    start with  --���۰�
    increment by    --����ġ
    nocache         --cache ������� �ʰڴ�
    cycle           --������ ������ ���� �ִ�ġ Ȥ�� �ּ�ġ�� �ٴٶ��� ��
                      �ʱⰪ���� �ٽ� ������ �� ����
    order           --��û�Ǵ� ������� ���� ����
    
    �� ������ ���
    nextval, currval �ǻ��÷�
    1) nextval - �ٷ� ������ ������ �������� ������ �ִ�
    2) currval - ���� ���������� ������ �ִ�
*/
select * from pd;

create table pd_temp1
as
select * from pd
where 1=0;

select * from user_constraints
where table_name='PD_TEMP1';

alter table pd_temp1
add constraint pk_pd_temp1_no primary key(no);

--������ ����
create sequence pd_temp1_seq
minvalue 1
maxvalue 9999999999999  --9�� 13��
increment by 1
start with 50  --50���� �����ؼ� 1�� ����
nocache;

--����ڰ� ������ sequence ��ȸ
select * from user_sequences;

select * from pd_temp1;

insert into pd_temp1(no, pdname, price, regdate)
values(pd_temp1_seq.nextval, '��ǻ��',1500000, sysdate); --seq:50

--
select pd_temp1_seq.currval from dual; --���� ������ ��ȣ ��ȸ 50
select pd_temp1_seq.nextval from dual; --���� ������ ��ȣ ��ȸ 51
--���� �����Ǿ� ����=> ���� ����ϸ� �� ���������� ó����
 
insert into pd_temp1(no, pdname, price, regdate)
values(pd_temp1_seq.nextval, '��ǻ��2',1600000, sysdate); --seq:52

--
create table pd2
(
    no      number  primary key,
    pdcode  char(3) not null,
    pdname  varchar2(100),
    price   number(10)  check(price>=0),
    company varchar2(100),
    regdate date default sysdate
);

--1���� �����ؼ� 1�� �����ϴ� ������ ��ü ����
create sequence pd2_seq
increment by 1
start with 1
nocache;

--������ �Է�
insert into pd2(no, pdcode, pdname, price, company)
values(pd2_seq.nextval, 'A01','�Ｚ��Ʈ��',2500000, '�Ｚ');

insert into pd2(no, pdcode, pdname, price)
values(pd2_seq.nextval, 'B01','Ű����',37000);

select * from pd2;

select * from user_sequences;

create sequence test_seq
increment by 1
start with 1;  --default��: 1~1*10�� 28��, nocycle, noorder, cache
 
--������ ����
--drop sequence ��������;

drop sequence test_seq;

--index
/*
�ε���
- ���̺��� �����͸� ���� ã�� ���� ����ǥ
- �ε����� ���ٸ� Ư���� ���� ã�� ���� ��� ������ �������� �� ������ �� 
    => table full scan
- index seek
  : �ε����� ����ϴ� ���� �� ȿ�����̶��, ����Ŭ�� ��� �������� ������ �ʰ� 
  �ε��� �������� ã�Ƽ� ���� �����͸� ������ 
- �� ���̺� ���� ���� �ε����� ������ �� ����
 
  create [unique] index �ε�����
  on ���̺��(�÷���1, �÷���2, ...)
*/
--primary key�� unique ���������� �ָ� �ڵ����� unique index�� ������

select * from pd2;

--��ǰ �ڵ� �ε���
create unique index idx_pd2_pdcode
on pd2(pdcode);

--��ǰ�� �ε���
create index idx_pd2_pdname
on pd2(pdname);

--��ǰ�����, ȸ�� ����Ű �ε���
create index idx_pd2_regdate_company
on pd2(regdate, company);

--�ε��� ��ȸ
select * from user_indexes where table_name='PD2';
select * from user_ind_columns where table_name='PD2';

select * from user_constraints where table_name='PD2';

select * from pd2
where pdcode='B01';

select * from pd2
where pdname='Ű����';

select * from pd2
where regdate >= '2019-10-10' and company='�Ｚ';

--�ε��� ����
--drop index �ε�����
drop index idx_pd2_pdcode;

--�� (view)
/*
- VIEW�� ���̺� �ִ� �����͸� �����ִ� ������ �����ϴ� 
  SELECT������ ������ �� �� ����
  
- VIEW�� ������ �����͸� ������ ������ ������ 
  �並 ���� �����͸� ��ȸ�� �� �ְ� �� �����͸� �Է� ���� ������ �� ������ 
  �ٸ� ���̺�� ���ε� �� �� �ֱ� ������ ������ ������ ���̺��̶�� ��

- �信�� ���� �����Ͱ� �������� �ʴ´�
  ���� �����ʹ� �� ���̺��� �����ϰ� ��� �̸� �����ִ� â���̶�� ����

    create [or replace] view ���̸�
    as
    select����;
    
    �� �並 ����ϴ� ����
    [1] ���ȼ�
    [2] ���Ǽ�
*/
--testuser ����ڴ� emp�� ������ ������� �⺻����(�̸�, job, �Ի���)�� �˻��� �� �־�� �Ѵٸ�?
--=> hr ����ڰ� emp ���̺��� �Ϻ� �÷��� �� �� �ִ� �並 ����
--testuser�� �ش� �並 �� �� �ְ� �Ѵ�
select * from emp;

--1) hr�������� �� ���� ������ �ο��ؾ� ��
--sys ������ �������� ���� �ο��� �ؾ� ��
--grant create view to hr;

--view ���� ���� �����ϱ�
--revoke create view from hr;

--2) hr ����ڰ� �並 �����
create or replace view v_emp
as
select ename, job, hiredate
from emp
where deptno=30;

--select * from ���̺� �Ǵ� ��
select * from v_emp;  --������ �� ��ȸ

--3) testuser���� �ش� �並 select�� �� �ִ� ������ �ο��Ѵ�
/*
    -sys�������� testuser ����� ���� �����
    
    create user testuser
    identified by testuser123
    default tablespace users;
    
    -���� �ο��ϱ�
    grant resource, connect to testuser;
    
    -�����ϱ�
    conn testuser/testuser123
*/

grant select on v_emp to testuser; --hr������ ���̹Ƿ� select���Ѻο��� ����

--��������
--revoke select on v_emp from testuser;

--4) testuser�������� �� select �ϱ�
--select * from hr.v_emp; --��Ű���̸�.�����ͺ��̽�������Ʈ��

--�� �����ϱ�
--testuser ����ڰ� research�μ��� ��������� ��ȸ�ؾ� �Ѵٸ�?
create or replace view v_emp
as
select ename, job, hiredate
from emp
where deptno in (20,30);

select * from dept;
select * from emp;

--testuser���� Ȯ��
select * from v_emp;

--������, research�ο� ���ϴ� ����� �߿�
--1982�� ������ �Ի��� ����� ����(�̸�,����,�Ի���)�� ��ȸ�Ϸ���?
--1) v_emp �� �̿�
select * from v_emp
where hiredate<'1982-01-01'; 

--2) emp ���̺� �̿�
select * from emp
where deptno in (20,30) and hiredate<'1982-01-01';

--������ �̿��ϴ� ��쳪 ������ �������� ��� �並 ���� ���
--employees, departments ����
create or replace view v_employees
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME as name,
    e.HIRE_DATE, e.DEPARTMENT_ID, d.DEPARTMENT_name,
    nvl2(e.COMMISSION_PCT, e.SALARY+e.SALARY*e.COMMISSION_PCT, e.SALARY)
    as pay    
from employees e join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--
select * from v_employees;

--�ش� �信�� �޿��� 10000 �̻��� ��� ��ȸ�ϱ�
select * from v_employees
where pay>=10000;

--gogak ���� �� ������ ���� ����(gender), ����(age) ������ view�� �����
--v_gogak_info
create or replace view v_gogak_info
as
select gno, gname, jumin, point,
    case when substr(jumin,7,1) in ('1','3') then '��'
         else '��' end gender,
    extract(year from sysdate) - (substr(jumin,1,2)
        +case when substr(jumin,7,1) in ('1','2') then 1900 else 2000 end
        ) + 1 as age     
from gogak;

--�ش� �並 �̿��Ͽ� 20��, 30�� ���ڸ� ��ȸ�ϱ�
select * from v_gogak_info
where trunc(age, -1) in (20,30) and gender='��';

--cf. inline view �̿�
select *
from
(
    select gno, gname, jumin, point,
    case when substr(jumin,7,1) in ('1','3') then '��'
         else '��' end gender,
    extract(year from sysdate) - (substr(jumin,1,2)
        +case when substr(jumin,7,1) in ('1','2') then 1900 else 2000 end
        ) + 1 as age     
    from gogak
)
where trunc(age, -1) in (20,30) and gender='��';

--�並 ���� ������ ����
/*
    1. �並 ���� ��ȸ�� �����ϰ�, �Է�,����,������ ������ => updatable view
    2. ��ȸ�� ������ �䵵 ���� => read only view
*/
--updatable view �����
/*
    create or replace view ���̸�
    as
    select��
*/

--read only view �����
/*
    create or replace view ���̸�
    as
        select��
    with read only;
*/

create or replace view v_emp_readonly
as
    select ename, job, hiredate
    from emp
    where deptno in (20,30)
with read only;

select * from v_emp_readonly; --readonly view
select * from v_emp; --updatable view

update v_emp_readonly
set ename='SMITH2'
where ename='SMITH';  --ERROR: readonly view�� ���� �Ұ�

update v_emp
set ename='SMITH2'
where ename='SMITH';  --updatable view�� �Է�,����,���� ����

insert into v_emp(ename, job, hiredate)
values('ȫ�浿','CLERK', sysdate);  --error:null�� empno�� ���� �� ����
--=> �並 ���� �Է��� �ϴ� ���, �信 ���� �÷��� null�� ����ϰų�
--default���� �־�� ��. �׷��� ������ ���� �߻�

select * from v_emp;
select * from emp;

create or replace view v_emp_2
as
select empno, ename, job, hiredate
from emp
where deptno in (20,30);

insert into v_emp_2(empno,ename, job, hiredate)
values(9999,'ȫ�浿','CLERK', sysdate);  --�Է� ����
--���� ������ ����� ���������� �Է� ������

select * from v_emp_2
where empno=9999; --�Է��� �Ǿ����� ���� ������ ����Ƿ�, �信���� ��ȸ �Ұ�
select * from emp
where empno=9999;  --���̺����� ��ȸ ����

delete from v_emp_2
where empno=9999; --���� ������ ����Ƿ�, ��ȸ�� �ȵǰ� ������ �ȵ�

select * from emp
where empno=8888;
delete from emp
where empno=8888;

/*
    �⺻������ �並 ���鶧 ���� ������ ����� ������ �����͸� ������ �� ������
    �̸� ������� �ʰ��� �Ҷ��� with check option�� ���
*/
create or replace view v_emp_3
as
select empno, ename, job, hiredate
from emp
where deptno in (20,30)
with check option; --���� ������ ����� �����δ� ������ ���� �Ұ�

select * from v_emp_3;

insert into v_emp_3(empno,ename, job, hiredate)
values(9997,'��浿','SALESMAN', sysdate);  --error: with check option����

select * from v_emp_3
where empno=9999; 

select * from user_views;

--�м��Լ�
/*
[1] �����Լ�
rank, dense_rank, row_number
- partition ���� �ִ� �� ���� ������ ������ �ִ� �Լ�

rank | dense_rank | row_number(expr)
OVER ( <partition  by �÷�>
	<order by �÷�> )
*/
--��) �޿��� ���� ������� ������ �ο��Ͽ� ����Ͻÿ�
select * from employees;

select employee_id, first_name, salary, department_id, 
    rank() over(order by salary desc) as "��ü����-rank",
    rank() over(partition by department_id order by salary desc) 
        as "�μ�������-rank",
    dense_rank() over(order by salary desc) as "��ü���� dense_rank",
    dense_rank() over(partition by department_id order by salary desc) 
        as "�μ������� dense_rank",
    row_number() over(order by salary desc) as "��ü���� row_number",
    row_number() over(partition by department_id order by salary desc) 
        as "�μ������� row_number"        
from employees
order by department_id;   

--�޿��� ���� ���� ��� 5�� (1~5��)�� ��ȸ�ϱ�
--rank �̿�
select employee_id, first_name, salary, 
    rank() over(order by salary desc)
from employees
where rank() over(order by salary desc)<=5;  --error
--rank�� �м��Լ��� where���� �� �� ����
--=> inline �� �̿�

select *
from
(
    select employee_id, first_name, salary, 
        rank() over(order by salary desc) RANK
    from employees
)A
where A.RANK<=5;

--top-n �м�
--�Ի��� �������� ������ �� ��ȸ�ϱ� - emp
select row_number() over(order by hiredate desc) NO, empno, ename, hiredate
from emp;

select rownum NO, empno, ename, hiredate
from
(
    select * from emp order by hiredate desc
);

select rownum NO, empno, ename, hiredate from emp;

select row_number() over (order by empno) NO,
empno, ename, hiredate from emp;

--�ֱٿ� �Ի��� 7���� ������� ��ȸ
--1)rownum�̿�
select rownum NO, empno, ename, hiredate
from
(
    select * from emp order by hiredate desc
)
where rownum<=7;

select row_number() over(order by hiredate desc) NO, empno, ename, hiredate
from emp;
--where row_number() over(order by hiredate desc)<=7; --error

select *
from
(
    select row_number() over(order by hiredate desc) NO, empno, ename, hiredate
    from emp
)
where NO<=7;

--2)row_number() �̿�


/*) professor ���̺��� �������� ������ȣ�� �̸�, �޿�, �޿� ����
�� ��ȸ�Ͻÿ�
? 2) 1�� �������� �޿��� ���� ���� �޴� 3�� ��ȸ�Ͻÿ�
? 3) emp ���̺��� ����Ͽ� ���, �̸�, �޿�, �μ���ȣ, �μ� �� job��
�� �޿������� ��ȸ�Ͻÿ�
? 4) 2�� ������ ��� ����ÿ�.
*/

/*
? ��ٱ��� ���̺�� ��ǰ ���̺��� �̿��Ͽ� ���
���� ������ ��ȸ
? ���̵�, ��ǰ��, ����, ����, �հ�(����*����) �÷� ��ȸ
? �Խ��ǰ� ���� �亯 ���̺��� �̿��Ͽ� �Խ��ǹ�
ȣ, �ۼ���, ����, ����, ���ٴ亯 ��ȣ, �ۼ���, ��
��, �ۼ����� ��ȸ(����)
? ���� �� �����
*/