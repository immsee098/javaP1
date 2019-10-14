--[ ����Ŭ 8�� ]
--(1) dept ���̺��� deptno�÷��� �⺻Ű ���������� �߰��Ͻÿ�. 
alter table dept
add constraint pk_dept_deptno primary key(deptno);

--(2) emp ���̺��� �̿��ؼ� �� ���̺�(emp_temp)�� ����ÿ�.
create table emp_temp
as 
select * from emp;

select * from emp_temp;

--(3) �ý��� �並 �̿��ؼ� emp_temp ���̺��� ���������� ��ȸ�Ͻÿ�
select * from user_constraints
where table_name = 'EMP_TEMP';

--(4) ������ ���̺��� emp_temp�� primary key(empno), foreign key(deptno), 
--check(sal�� 0 �̻� ������) ���������� �߰��Ͻÿ�.
alter table emp_temp
add constraint pk_emp_temp_empno primary key(empno);

alter table emp_temp
add constraint fk_emp_temp_deptno foreign key(deptno)
               references dept(deptno);

alter table emp_temp
add constraint pk_emp_temp_sal check(sal>=0);

--(5) emp_temp ���̺� tel �÷��� �߰��Ͻÿ�
alter table emp_temp
add tel varchar2(20);

select * from emp_temp;

--(6) tel�÷��� ������ũ�⸦ varchar2(30)���� �����Ͻÿ�.
alter table emp_temp
modify tel varchar2(30);

--(7) tel�÷��� �̸��� hp�� �����Ͻÿ�.
alter table emp_temp
rename column tel to hp;

--(8) hp�÷��� �����Ͻÿ�.
alter table emp_temp
drop column hp;

select * from emp_temp;

--(9) �������� ���ڸ� �����س��� �����ͺ��̽� ��ü�� ���̺� �ִ� �⺻Ű ���� �����ϱ� ���� ���Ǵ� 
--�������� ��ü�� �����ΰ�?
--sequence

--(10) emp_temp���̺��� empno�� �ڵ����� 1�� �����ϴ� ���� �Է��� �� �ֵ��� sequence�� �����Ͻÿ�.
--8000���� �����ϰ� 1�� �����ϵ��� (emp_temp_seq)
create sequence emp_temp_seq
increment by 1
start with 8000
nocache;

--(11) �ý��� �並 �̿��Ͽ� ����ڰ� ������ �������� ��ȸ�Ͻÿ�.
select * from user_sequences;

--(12) ������ �������� �̿��Ͽ� emp_temp���̺� ���� �Է��Ͻÿ�.
insert into emp_temp(empno, ename, job, deptno)
values(emp_temp_seq.nextval, 'hong', 'CLERK', 10);

select * from emp_temp;

--(13) index��? 
-- ���̺��� �����͸� ���� ã�� ���� ����ǥ

--(14)  emp_temp���̺��� ename�� �̿��Ͽ� ���� ��ȸ�� �� �ֵ��� �ε����� �����Ͻÿ�.  
create index idx_emp_temp_ename
on emp_temp(ename);

--(15) �ý��� �並 �̿��Ͽ� ����ڰ� ������ �ε����� ��ȸ�Ͻÿ�.
select * from user_indexes 
where table_name='EMP_TEMP';
select * from user_ind_columns 
where table_name='EMP_TEMP';
 
--(16) ��(View)��?
/*
    - view�� ���̺� �ִ� �����͸� �����ִ� ������ �����ϴ�
      select������ ����ϰ� �� �� �ִ�
      
    - view�� ������ �����͸� ������ ������ ������,
      �並 ���� �����͸� ��ȸ�� �� �ְ�, �� �����͸� �Է�,����,������ �� ������
      �ٸ� ���̺�� ���ε� �� �� �ֱ� ������ ������ ���� ���̺��̶�� �� */

--(17) student ���̺�� exam_01 ���̺��� ��ȸ�Ͽ� �л����� �й�, �̸�, ����, ������ ����ϴ� �並 ����ÿ�.
--(������ dcode�� case�̿�- 90 �̻��̸�'A', 80�̻��̸� 'B', 70�̻��̸� 'C', 60�̻��̸�'D' 
--60�̸��̸� 'F' )
create or replace view v_exam
as
select s.studno, s.name, e.total,
 decode(trunc(total,-1), 100, 'A',90,'A',80,'B',70,'C',60,'D','F') grade
from student s join exam_01 e
on s.studno = e.studno;

--(18) �ش� �並 �̿��Ͽ� ������ A�� B�� C�� �л��� ��ȸ�Ͻÿ�.
select * from v_exam
where grade in ('A','B','C');

--(19)  �ý��� �並 �̿��Ͽ� ����ڰ� ������ �並 ��ȸ�Ͻÿ�.
select * from user_views;      

--(20) employees ���̺��� �޿��� ���� ������ 5�� ��ȸ�ϴ� �並 �ۼ��Ͻÿ�.
create or replace view v_emp_sal
as
select *
from
(
    select first_name, hire_date, salary
    from employees
    order by salary desc
)
where rownum<=5;       

--(21) professor ���̺��� �ٺ��  ������(position) ���� �������� ������ ��ȸ�ϵ� �̸�(name)�� 
--������������ ��ȸ�ϴ� �並 �ۼ��Ͻÿ�
create or replace view v_professor
as
SELECT * FROM professor
WHERE position=(SELECT position FROM professor WHERE name = '�ٺ�')
ORDER BY name desc;




--[ ����Ŭ 9�� ]
--(1) SQL�� �Ϲ� ���α׷��� ����� Ư���� ������ ���� ����, ��� ����, ���ǹ�, �ݺ��� ����� ������ �� 
--�����̶�� �ϴ°�?
--PL/SQL

--(2) (�����), (�����), (����ó����)�� �ϳ��� PL/SQL ����� �����ϰ�,
--����Ŭ�� �� ��� ������ ó���Ѵ�.

--(3) PL/SQL�� �̿��Ͽ� 1~20������ ���� ���Ͻÿ� - for�� �̿�
declare
    result  number;
    i   number;
begin
    result :=0;
    
    for i in 1..20 loop
        result := result + i;    
    end loop;
    
    dbms_output.put_line('1~20������ ��:'||result);
        
    exception when others then
        dbms_output.put_line('error!');
end;

--(4) PL/SQL�� �̿��Ͽ� ���� ���� �б⸦ ���Ͻÿ� - if �� �̿�  
/*1~3 => 1��б�
4~6 => 2��б�
7~9 => 3��б�
10~12 => 4��б�*/

declare
    mon  number;
    result  varchar2(20);
begin
    mon := 10;
    if mon >= 1 and mon<=3 then
        result:= '1��б�';
    elsif mon >= 4 and mon<=6 then
        result := '2��б�';
    elsif mon >= 7 and mon<=9 then
        result := '3��б�';    
    else
        result := '4��б�';
    end if;
    
    dbms_output.put_line(mon || '=>' || result);
    
    exception when others then
        dbms_output.put_line('error!!!');
end;

--(5) PL/SQL ���� ���α׷��� �����ͺ��̽� ��ü�� �����ؼ� �ʿ��� ������ ȣ���Ͽ� ����� �� �ִ� PL/SQL ���
--�� ���Ѵ�. PL/SQL ���� ���α׷��� �Լ��� ���� ���ν����� ���� �� �ִµ�, 
--Ư�� ����� ������ ��, ������� ��ȯ�ϴ� �������α׷��� (�Լ�)��� �ϰ�, 
--������� ��ȯ���� �ʴ� �������α׷��� (���� ���ν���)��� �Ѵ�.
   