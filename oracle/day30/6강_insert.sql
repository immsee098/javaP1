--6��_insert.sql
--[2019-10-07 ��]
--1. insert�� - �����͸� �Է��ϴ� DML
/*
    [1] ������ �Է��ϱ�
    insert into ���̺��(�÷�1, �÷�2, �÷�3,...)
    values(��1, ��2, ��3,...);
*/
/*
��1) dept2 ���̺� �Ʒ��� ���ο� �μ� ������ �Է��Ͻÿ�
�μ���ȣ : 9000, �μ���: Ư��1��
�����μ� : 1006 (������), ���� : �ӽ�����
*/
select * from dept2;

insert into dept2(dcode, dname, pdept, area)
values('9000', 'Ư��1��','1006', '�ӽ�����');

insert into dept2(dcode, area, dname, pdept)
values('9001', '�ӽ�����', 'Ư��2��','1006');

--��� �÷��� �����͸� �Է��ϴ� ��� => �÷��� ���� ����
insert into dept2
values(9002, 'Ư��3��', 1006, '�ӽ�����');

--�Ϻ� �÷��� �Է��ϴ� ��� - not null�� �÷��� �ݵ�� ���� �Է��ؾ� ��
insert into dept2(dcode, dname)
values(9003, 'Ư��4��');

insert into dept2(dcode, pdept)
values(9004, 1006); --error
--cannot insert NULL into ("DEPT2"."DNAME")
--dname�� not null�ε� ���� �Է����� �ʾƼ� ���� �߻�

--null �Է��ϱ�
/*
1) �����͸� �Է����� ������ null�� �Էµ�
2) ���� null�� �Է��ص� null�� �Էµ�
*/
insert into dept2(dcode, dname, pdept)
values(9004, 'Ư��5��', null);

select * from dept2;

--��¥ ������ �Է��ϱ�
/*
�Ʒ� ������ professor ���̺� �Է��Ͻÿ�
������ȣ : 5001, �����̸�: �輳��
ID : kimsh, Position : ������
Pay : 510, �Ի��� : 2013�� 2�� 19��
*/
select * from professor;

insert into professor(profno, name, id, position, pay, hiredate)
values(5001,'�輳��','kimsh','������',510,'2013-02-19');

--[2] ���� �� �Է��ϱ�
/*
    insert into ���̺��(�÷�1, �÷�2, ...)
    select��
    
    => select���� �÷��� ������ ������ Ÿ���� ��ġ�ؾ� �Է� ������ 
*/
select * from pd
order by no desc;

select * from product;

insert into pd(no,pdname, price, regdate)
select p_code, p_name, p_price, sysdate
from product
where p_code in (102,103,104);

--[3] ���̺��� �����ϸ鼭 ������ �Է��ϱ�
/*
    create table �ű� ���̺��
    as
    select �����÷�1, �����÷�2, ...from ���� ���̺��;
    
    - �ű� ���̺��� ����� ���ÿ� �ٸ� ���̺��� select�� �÷��� ��� �����͸�
    insert��Ŵ
    - select���� ���̺�� �÷��� ���������� �������� �ʱ� ������
    �ű� ���̺� ���� ���̺�� �÷� ���������� �����ؾ� ��
    pk(primary key)���� �������� ����
*/
create table professor2  --professor2 ���̺��� ������
as
select * from professor;

select * from professor2;

--employees, departments ���̺��� ������ ����� imsi_tbl�� ����鼭 �Է�
create table imsi_tbl
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME as name,
    e.hire_date, 
    nvl2(commission_pct, salary+salary*commission_pct, salary) as pay,
    e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from employees e join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

select * from imsi_tbl;
/*
=> insert���� �÷�����Ʈ�� ���� ���¿��� select�� �÷� ����Ʈ�� �Լ��� ����ƴٸ�
��Ī�� �Ἥ insert�Ǵ� �������� �÷����� ��������� ��
�׷��� ������ ���� �߻�
*/

create table imsi_tbl2(emp_id, name,hiredate, pay,dept_id, dept_name)
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME,
    e.hire_date, 
    nvl2(commission_pct, salary+salary*commission_pct, salary),
    e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from employees e join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

select * from imsi_tbl2;

/*
=> create table���� �÷����� �����ϸ�
�ű� ���̺� �÷� ����Ʈ�� ���ǵǸ鼭 select���� ���� �ʿ��� �����Ͱ� insert��
*/

--2. update��
--���� �����͸� �ٸ� �����ͷ� ������ �� ����ϴ� ���
/*
    update ���̺�
    set �÷���1=��1, �÷���2=��2, ...
    where ����
*/
--[1] update
--Professor ���̺��� ������ �������� �������� bonus�� 100�������� �λ��Ͻÿ�
select * from professor
where position='������';

update professor
set bonus=100
where position='������';
 
rollback;

--student ���̺���  4�г� '�����' �л��� 2����(deptno2)�� 101�� �����Ͻÿ�.
select * from student
where grade=4 and name='�����';

update student
set deptno2=101
where grade=4 and name='�����';

--Professor ���̺���  ����ö������ ���ް� ������ ������ ���� ������ �� ���� �޿��� 
--250������ �� �Ǵ� �������� �޿��� 15% �λ��Ͻÿ�.
select *
from professor
where position = (select position from professor where name='����ö') 
    and pay<250;
    
update professor
set pay=pay*1.15
where position = (select position from professor where name='����ö') 
    and pay<250;
    
rollback;   
 
--[2] ���� ���� update - ���������� �̿��� update
/*
    ���������� ����ϸ� �� ���� update ������� ���� ���� �÷��� ������ �� �ִ�
    ���� �÷��� ���������� ����� update�ϸ� �ȴ�
    
    ���߰��� update�� �ϱ� ���ؼ��� �⺻���� update���� ���� ����ϰ�
    ���������� ������ �����͸� �����Ϸ��� �÷��� ������ ������ �����
*/
--EMP ���̺��� �����ȣ�� 7844�� ����� �μ���ȣ�� ����(JOB)�� 
--�����ȣ�� 7782�� ����� ���� ������ ���� �μ��� �����϶�                 

--cf. ���� �÷� ��������
--�г⺰ �ִ�Ű�� ���� �л��� ���� ��ȸ
select * from student
where (grade, height) in (select grade, max(height) from student
                            group by grade);

--
select job, deptno from emp  
where empno=7782; --MANAGER, 10

select * from emp
where empno=7844;

/*update emp
set job='MANAGER', deptno=10
where empno=7844; */

--subquery �̿�
update emp
set (job, deptno)=(select job, deptno from emp  
                    where empno=7782)
where empno=7844;                          

rollback;

--[3] exists�� �̿��� ���߰��� update
/*
    - ���������� �÷����� �����ϴ��� ���θ� üũ
    - ���翩�θ� üũ�ϱ� ������ �����ϸ� true, �������� ������ false�� ������
    - true�� ���ϵǸ� set �÷��� update�� �����Ű��
      false�� ���ϵǸ� update�� ������� ����
*/
select * from product;
select * from panmae;

--������ �ڵ尡 panmae ���̺� �ִٸ� ���ڵ�� update�ϱ�
select *
from product
where del_yn='Y';

select * from panmae a
where exists (select 1 from product b where b.p_code=a.p_code 
                and b.del_yn='Y');
                
update panmae a
set p_code=(select p_code_new from product b where b.p_code=a.p_code
                and b.del_yn='Y')
where exists (select 1 from product b where b.p_code=a.p_code 
                and b.del_yn='Y');                

rollback;

--subquery�̿��� update
--employees���� ������ȣ�� 100�� ������ job_id�� ������ȣ�� 101�� job_id�� �����Ͻÿ�
select job_id from employees
where employee_id=100;  --AD_PRES

select * from employees
where employee_id=101;          

/*
update employees
set job_id='AD_PRES'
where employee_id=101
*/

update employees
set job_id=(select job_id from employees
                where employee_id=100)
where employee_id=101;
      
--3. delete��
/*
    delete from ���̺�
    where ����
*/

--dept2 ���̺��� �μ���ȣ(dcode)�� 9000������ 9100�� ������ ������� �����Ͻÿ�
select * from dept2
where dcode between 9000 and 9100;

delete from dept2
where dcode between 9000 and 9100;

rollback;

--delete������ ��������
--������
--departments���� 20�� �μ��� �μ����� employees���� ����
select manager_id from departments
where department_id=20;  --201

select * from employees
where employee_id=201;

/*delete from employees
where employee_id=201;*/

delete from employees
where employee_id=(select manager_id from departments
                    where department_id=20);
--=> �ڽķ��ڵ� �߰�-���Ἲ �������� ����

create table new_employees
as
select * from employees;

create table new_employees2
as
select * from employees;

select * from new_employees;

delete from new_employees
where employee_id=(select manager_id from departments
                    where department_id=20);
                    
--���� ��
--departments���� location_id�� 1700�� ������� employees���� ����
select department_id from departments
where location_id=1700; 

select * from employees
where department_id in (10,30,90);

select * from new_employees
where department_id in (select department_id from departments
                        where location_id=1700);
                        
delete from new_employees
where department_id in (select department_id from departments
                        where location_id=1700);  

--������� ��������
--employees���� �ڽ��� job_id�� ��� �޿����� ���� �޴� ��� ����
select * from employees
where job_id='IT_PROG';

select avg(nvl(salary,0))
from employees
where job_id='IT_PROG';   --5760

select * from employees
where job_id='IT_PROG' and salary>=5760;    

select * from new_employees a
where salary>=(select avg(nvl(salary,0))
                from employees b
                where b.job_id=a.job_id); 
                 
delete from new_employees a
where salary>=(select avg(nvl(salary,0))
                from employees b
                where b.job_id=a.job_id); 


delete from new_employees2 a 
where salary>=(select avg(nvl(salary,0))
from employees b
where b.job_id = a.job_id);
--                
         --[1]�ٸ� ���̺� �Ѳ����� �Է�
select * from p_01;
select * from p_02;

insert all into p_01 values(1, 'AA')
           into p_02 values(2, 'BB')
select * from dual;

--[2]�ٸ����̺��� �����ͼ� �Է��ϱ�
insert all into p_01 values(profno, name)
           into p_02 values(profno, name)
select profno, name from professor;


select * from p_01;
select * from p_02;


--[3]�ٸ� ���̺� ���ÿ� ���� ������ �Է��ϱ�

insert all into p_01 values(profno, name)
           into p_02 values(profno, name)
select profno, name from professor
where profno between 3000 and 39999;
/*
dept => dept01 ���̺� �����
? emp => emp01 ���̺� �����
? --insert
? 1) dept01, emp01 ���̺� ������ �Է��ϱ�
? dept01 ���̺��� ��� Į�� �Է�, emp01 ���̺��� �Ϻ� Į���� �Է�
? --update
*/
create table dept01
as
select * from dept;

create table emp01
as
select * from emp;
/*
? 1) DEPT01 ���̺��� �μ���ȣ�� 30�� �μ��� ��ġ(LOC)�� '�λ�'���� ����
? 2) DEPT01 ���̺��� ������ ��� '����'�� ����
? 3) emp01 ���̺��� job�� 'MANAGER' �� ����� �޿�(sal)�� 10% �λ�
? --���������� �̿��� update
*/
select * from dept;
select * from emp01;

update dept01
set loc= '�λ�'
where deptno=30;

update dept01
set loc= '����';

update emp01
set sal = sal*1.1
where job='MANAGER';

/*
? 1) �����ȣ�� 7934�� ����� �޿���, ������ �����ȣ�� 7654�� ����� ������ �޿�
�� ����(emp01 ���̺� �̿�)
? --�ٸ� ���̺��� ������ UPDATE
? 1) DEPT01 ���̺��� �μ��̸��� SALES�� �����͸� ã�� �� �μ��� �ش�Ǵ�
EMP01 ���̺��� �������(JOB)�� 'SALSEMAN'���� ����
? 2) DEPT01 ���̺��� ��ġ(loc)�� 'DALLAS'�� �����͸� ã�� �� �μ��� �ش��ϴ�
EMP01 ���̺��� ������� ����(JOB)�� 'ANALYST'�� ���� 
*/
update emp01
set (sal, job) = (select sal, job from emp where empno=7654)
where empno=7934;

update emp01 e
set job='SALESMAN'
where e.deptno = (select d.deptno from dept01 d where d.deptno=30);

update emp01 e
set job='ANALYST'
where e.deptno = (select d.deptno from dept d where d.deptno=20);


/*
-- DELETE
? 1) EMP01���̺��� 7782�� �����ȣ�� ��������� ��� ����
? 2) EMP01���̺��� ����(JOB)�� 'CLERK'�� ������� ������ ����
? 3) EMP01���̺��� ��� ������ ���� �� rollback
*/
select * from dept;
select * from emp01;

delete from emp01
where empno=7782;

delete from emp01
where job='CLERK';

rollback;


/*
--���������� �̿��� �������� ����
? 1) 'ACCOUNTING'�μ��� ���� �μ��ڵ带 DEPT01���̺��� �˻��� ��
�ش� �μ��ڵ带 ���� ����� ������ EMP01���̺��� ����
? 2) DEPT01���̺��� �μ��� ��ġ�� 'NEW YORK'�� �μ��� ã��
EMP01���̺��� �� �μ��� �ش��ϴ� ����� ����
*/
select * from dept01;
select * from emp01;

delete from emp01
where deptno = (select deptno from dept01 where dname='ACCOUNTING');

delete from emp01
where deptno = (select deptno from dept01 where loc='NEW YORK');