--[ ����Ŭ 8�� ]
--(1) dept ���̺��� deptno�÷��� �⺻Ű ���������� �߰��Ͻÿ�. 

alter table dept
add constraint fk_dept_deptno primary key(deptno);


--(2) emp ���̺��� �̿��ؼ� �� ���̺�(emp_temp)�� ����ÿ�.
create table emp_temp as
SELECT * FROM emp;


--(3) �ý��� �並 �̿��ؼ� emp_temp ���̺��� ���������� ��ȸ�Ͻÿ�
select * from user_constraints order by emp_temp;



--(4) ������ ���̺��� emp_temp�� primary key(empno), foreign key(deptno), 
--check(sal�� 0 �̻� ������) ���������� �߰��Ͻÿ�.
alter table emp_temp
add constraint fk_emp_empno primary key(empno);

alter table emp_temp
add constraint fk_emp_sal check(sal>0);


--(5) emp_temp ���̺� tel �÷��� �߰��Ͻÿ�
alter table emp_temp 
add(tel varchar2(13));


--(6) tel�÷��� ������ũ�⸦ varchar2(30)���� �����Ͻÿ�.
alter table emp_temp 
modify(tel varchar2(30));


--(7) tel�÷��� �̸��� hp�� �����Ͻÿ�.
alter table emp_temp
rename column tel to hp;


--(8) hp�÷��� �����Ͻÿ�.

alter table emp_temp 
drop column hp;


--(9) �������� ���ڸ� �����س��� �����ͺ��̽� ��ü�� ���̺� �ִ� �⺻Ű ���� �����ϱ� ���� ���Ǵ� 
--�������� ��ü�� �����ΰ�?
--������


--(10) emp_temp���̺��� empno�� �ڵ����� 1�� �����ϴ� ���� �Է��� �� �ֵ��� sequence�� �����Ͻÿ�.
--8000���� �����ϰ� 1�� �����ϵ��� (emp_temp_seq)
create sequence emp_temp_seq
increment by 1
start with 8000;


--(11) �ý��� �並 �̿��Ͽ� ����ڰ� ������ �������� ��ȸ�Ͻÿ�.
select * from user_sequences;
select * from emp_temp;

--(12) ������ �������� �̿��Ͽ� emp_temp���̺� ���� �Է��Ͻÿ�.

alter table emp_temp 
add(no number);

insert into emp_temp values(7423, 'KIM', 'SALESMAN', 7902, sysdate, 1300, 1000, 20, emp_temp_seq.nextval);


--(13) index��? 
--���̺��� �����͸� ���� ã�� ���� ����ǥ 

--(14)  emp_temp���̺��� ename�� �̿��Ͽ� ���� ��ȸ�� �� �ֵ��� �ε����� �����Ͻÿ�.  
create index emp_temp_idx on emp_temp(ename);

--(15) �ý��� �並 �̿��Ͽ� ����ڰ� ������ �ε����� ��ȸ�Ͻÿ�.
select * from user_indexes;

 
--(16) ��(View)��?
--VIEW�� ���̺� �ִ� �����͸� �����ִ� ������ �����ϴ� SELECT������ ������ �� �� ���� 
--���� ���̺�


--(17) student ���̺�� exam_01 ���̺��� ��ȸ�Ͽ� �л����� �й�, �̸�, ����, ������ ����ϴ� �並 ����ÿ�.
--(������ dcode�� case�̿�- 90 �̻��̸�'A', 80�̻��̸� 'B', 70�̻��̸� 'C', 60�̻��̸�'D' 
--60�̸��̸� 'F' )


--(18) �ش� �並 �̿��Ͽ� ������ A�� B�� C�� �л��� ��ȸ�Ͻÿ�.


--(19)  �ý��� �並 �̿��Ͽ� ����ڰ� ������ �並 ��ȸ�Ͻÿ�.


--(20) employees ���̺��� �޿��� ���� ������ 5�� ��ȸ�ϴ� �並 �ۼ��Ͻÿ�.


--(21) professor ���̺��� �ٺ��  ������(position) ���� �������� ������ ��ȸ�ϵ� �̸�(name)�� 
--������������ ��ȸ�ϴ� �並 �ۼ��Ͻÿ�




--[ ����Ŭ 9�� ]
--(1) SQL�� �Ϲ� ���α׷��� ����� Ư���� ������ ���� ����, ��� ����, ���ǹ�, �ݺ��� ����� ������ �� 
--�����̶�� �ϴ°�?
    PL/SQL

--(2) ( �����  ), ( ����� ), (  ����ó����  )�� �ϳ��� PL/SQL ����� �����ϰ�,
--����Ŭ�� �� ��� ������ ó���Ѵ�.

--(3) PL/SQL�� �̿��Ͽ� 1~20������ ���� ���Ͻÿ� - for�� �̿�


--(4) PL/SQL�� �̿��Ͽ� ���� ���� �б⸦ ���Ͻÿ� - if �� �̿�  
/*1~3 => 1��б�
4~6 => 2��б�
7~9 => 3��б�
10~12 => 4��б�*/



--(5) PL/SQL ���� ���α׷��� �����ͺ��̽� ��ü�� �����ؼ� �ʿ��� ������ ȣ���Ͽ� ����� �� �ִ� PL/SQL ���
--�� ���Ѵ�. PL/SQL ���� ���α׷��� �Լ��� ���� ���ν����� ���� �� �ִµ�, 
--Ư�� ����� ������ ��, ������� ��ȯ�ϴ� �������α׷��� (        )��� �ϰ�, 
--������� ��ȯ���� �ʴ� �������α׷��� (            )��� �Ѵ�.
    