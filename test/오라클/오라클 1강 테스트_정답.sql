[ ����Ŭ 1�� ]

1. �����ͺ��̽�(Database, DB)��?
���� ����ý��۵��� ������ �� �ֵ��� ����,����� �������� ����
�ߺ��� �ּ�ȭ�ϰ�, �ټ��� ����ڰ� ������ �� �ֵ��� �����͵��� ��Ƶ� �ý���
�ܼ��� �����Ͱ� �� �ִ� ���� �ǹ��ϴ� ���� �ƴ϶� ����� �䱸�� ���� �ʿ��� 
�����͸� �ż��ϰ� �˻��� �� �־�� �ϰ� �����͸� �߰�, ����, ������ �� �ֵ��� 
������ �������� ����ü

2. �����ͺ��̽� �����ý��� (DataBase Mamanagement System, DBMS)�̶�?
��� �������α׷����� �����ͺ��̽��� ������ �� �ֵ��� ������ �ְ� 
�����ͺ��̽��� �����ϱ� ���� �Ϸ��� ����Ʈ���� �ý��� 
�����͸� �����ϰ� ȿ�������� �����ϱ� ���� ü������ �ý���
��) Oracle, MS SQL Server, mysql, informix, sybase ��


3. �������� �� ����?
�����ͺ��̽��� ���Ǵ� �����͵��� ������ ���İ� ��Ģ��� ����Ǿ�� �Ѵ�. 
�̵� �����͸� �����ϱ� ���� �⺻ ������ �����ϴ� ���� �ٷ� (���̺�)�̴�.

(���̺�)�� �����͸� �����ϰ� �߰�, ����, ���� �ϴ� ���� �⺻���� ������ ���� ����� �Ѵ�.


4. ���� ��ǥ���� �����ͺ��̽� �ý������� �����͵��� 2���� ������ ���� ���̺� ���·� 
�����ϴ� Ư¡�� ���� �����ͺ��̽���?

������ �����ͺ��̽�(Relational-Database)


5. �����ͺ��̽��� ��������  (�ʵ� (Field))�� ���̺��� ���� �ش�Ǵ� ������ �÷��̶�� �Ѵ�
(���ڵ�(Record))�� ���̺��� �� ��(row)�� �ǹ��Ѵ�.
(���̺�(Table))�� ���� ���� ���ڵ带 ��� �ִ� ������ ������ ���Ѵ�.


6. ����� �������� �������̴�.
 ����� �� ���̺� ���̿� �����ϸ�, ���踦 �ΰ� �ִ� �� ���̺� �� �ݵ�� �ϳ��� 
�θ� ���̺��̰� �ϳ��� �ڽ� ���̺��̴�.
 �θ� ���̺��� (�⺻Ű(Primary key))�� �ڽ� ���̺� (�ܷ�Ű(Foreign Key))�� ���� �Ǿ�����.


7. (�ܷ�Ű(Foreign key))�� ���̺�� ���� ���踦 �ΰ� ���� �� �ڽ��� ��ü(���̺�)������ 
Ű�� ������ ������ ������, �ٸ� ��ü(���̺�)�� �⺻Ű�� ������ ���� ������ �־ 
�ٸ� ��ü(���̺�)�� ������ �� ����ϴ� �ʵ��̸�,
(�⺻Ű(Primary key))�� �ϳ��� ���� �ٸ� ��� �����ϰ� ������ �� �ֵ��� �� �ִ� ���� �ǹ��Ѵ�.


8. sqlplus ������ ���� �� ������ �����Ű�� ��� �ǳ�?
SQL>alter user hr account unlock; 

=> hr ����� ��� ����

SQL>alter user hr identified by hr123; 

=> hr123���� hr�� ��й�ȣ ����


9. SERVICE_NAME, HOST, PORT �� Ȯ���ϱ� ���ؼ��� ����Ŭ ����ȭ���� Ȯ���ؾ� �Ѵ�.
� �������� � ����ȭ���� ã�ƺ��� �ұ�?

listener.ora
tnsnames.ora

C:\oraclexe\app\oracle\product\11.2.0\server\network\ADMIN\


10. cmd â���� sys ������ �����Ϸ��� � ����� �̿��ؾ� �ϳ�?

sqlplus  / as sysdba


11. SQL�� ��ҹ��� ���� (���Ѵ�).
�����ʹ� ��ҹ��� (�����Ѵ�).


12. SQL���� ���� 3������ DML, DDL, DCL�̴�.
(DML ( Data Manipulation Language))�� ������ ���۾��
�����͸� ��ȸ, ����, ������ �� ���Ǵ� SQL �����̴�.
SELECT, INSERT, UPDATE, DELETE ���� �̿� �ش�ȴ�.

(DDL ( Data Definition Language))�� ������ ���Ǿ��
�����ͺ��̽� ��ü��(���̺�, �ε���, ��, Ʈ���� ��)�� �����ϴµ� ���Ǵ� SQL �����̴�.
CREATE, DROP, ALTER, TRUNCATE ���� �̿� �ش�ȴ�.

(DCL ( Data Control Language))�� ������ ������
�����ͺ��̽��� �ִ� �����Ϳ� ������ �����ϴ� ����̴�.
GRANT, REVOKE �� �̿� �ش�ȴ�.



13. ���� �������� �ۼ��Ͻÿ�

--(1) �л� ���̺��� ��ü ������ ��ȸ�ϱ� (��ü �÷� ��������)
select * from student;

--(2)�л� ���̺��� Ű�� 175�̻��� �л��� �̸�(name), �г�(grade), Ű(height) ������ ��������,Ű�� ū ������� 
select name,grade,height
from student
where height>=175;


--(3)�а�(deptno1)�� 201���̰� 3�г�(grade) ������ �л��� �̸�(name), ���̵�(id), �г�(grade)������ ��������.
select name, id,grade
from student 
where deptno1=201 and grade <=3; 
 
--(4)�������̺��� �޿�(pay)�� 350���� 500������ ������ �̸�(name), ���̵�(id), �޿�(pay) ������ ��������
select name,id,pay
from professor
where pay between 350 and 500;
 
--(5)���� ���̺��� ����(position)�� ������, �������� �̸�(name), ���̵�(id), ����(position), �޿�(pay) �����Ͱ�������
select name, id, position, pay
from professor
where position in ('������','������');
 
--(6) ���� ���̺��� bonus�� ���� �ʴ� ������ �̸�(name), ���̵�(id), ����(position)������ ��������
select name, id, position
from professor
where bonus is null; 


--(7) department ���̺��� deptno, dname, build �÷��� ��ȸ
--���� : �а�(dname)�� '����'��� �ܾ �� �а����� ��ȸ�ϱ�
--���� : dname ������ ������������ ����

select deptno, dname, build from department
where dname like '%����%';


--(8) emp2 ���̺��� emp_type, position �÷��� ��ȸ�ϵ� �ߺ��� ��(���ڵ�)�� ����
 
 select distinct emp_type, position from  emp2;


--(9)�������̺��� ������ �̸�(name), ����(position),�޿�(pay), ���ʽ�(bonus), ����(pay*12+bonus)  
--������ ��������
--��� �÷��� �̸�, ����, �޿�, ���ʽ�, �������� ��Ī�� �����Ͽ� ����Ѵ�
select name �̸�, position ����, pay �޿�, bonus ���ʽ�, pay*12+bonus  as ���� 
from professor;

--(10) emp2 ���̺��� ����Ͽ� ��� ������� '���ϵ� ������ ������ 50000000���Դϴ�.'�� ���� ��������
--��µǵ��� ���ͷ� ���ڸ� �߰��ϰ�, Į���̸��� "����� ����"�̶�� �������� ����ϱ�

select name || ' ' || position || '�� ������ ' || pay || '���Դϴ�.' as "����� ����" 
from emp2;

--(11) professor ���̺��� �����Ͽ� ������ ���Ӱ����� �������� ������ȣ, �̸�, 
--�Ի���, �а� ��ȣ, ������ ����Ͻÿ�.

select profno, name, hiredate, deptno, position from professor
where position='���Ӱ���';

--(12) emp2���� ������ 1985/01/25�� ����� ����Ͻÿ�
select * from emp2
where birthday='1985-01-25';

--(13) emp2���� �̸��� �� ~ �� ������ ����� ��ȸ�Ͻÿ�.
select * from emp2
where name >= '��' and name<= '��';

select * from emp2
where name between '��' and '��';

--(14) emp2���� ������ 1980~1985 ���̰� �ƴ� ����� ����Ͻÿ�
select * from emp2
where birthday <'1980-01-01' or birthday>'1985-12-31';

select * from emp2
where birthday not between '1980-01-01' and '1985-12-31';


--(15) emp2���� �������� �ƴ� ����� ����Ͻÿ�.
select * from emp2
where emp_type != '������';


--(16) employees���� email�� O �տ�  2����, O �ڿ� 3 ���ڰ� ���� �͸� ��ȸ 
select * from employees
where email like '__O___';



--(17) employees ���� ������̵�, �̸� - ��(Steven-King), �Ի���, 
--�⺻��(salary),����(�⺻��*commission_pct), �޿�(salary+����) ���
--��� �÷��� ��Ī�� ����Ѵ�

select employee_id as "������̵�", 
first_name || '-' || last_name as "����̸�",
hire_date as "�Ի���", salary as "�⺻��",
salary*commission_pct as "����", 
salary+salary*commission_pct as "�޿�" 
from employees;


--(18) student ���̺��� ����Ͽ� 2�г��̰ų� �Ǵ� �����԰� 75kg �̻��� 
--�л����� �̸��� �г�, Ű, �����Ը� ��ȸ
select name, grade, height, weight from student
where grade=2 or weight>=75;


--(19)�л� ���̺��� Ű�� 180������ �л��� �̸�(name), �г�(grade), Ű(height), ������  ������ ��������,
--Ű�� ū �������, Ű�� �������� �����԰� ���� ������� 
select name,grade,height, weight
from student
where height<=180
order by height desc, weight;

--(20) department ���̺��� deptno, dname, build �÷��� ��ȸ
--���� : �а�(dname)�� '����'�̶�� �ܾ �� �а����� ��ȸ�ϱ�
--���� : dname ������ ������������ ����
select deptno, dname, build from department
where dname like '%����%'
order by dname;

--(21) emp ���̺��� comm�� ���� ���� ����� �̸�(ename), job, sal, comm ������ ��������
select ename, job, sal, comm from emp
where comm is null; 

--(22) emp ���̺��� comm�� ���� �ִ� ����� ������ ��������
select * from emp
where comm is not null; 

--(23) employees���� job_id�� PR_ �� ���Ե� �� ��ȸ
select * from employees
where job_id like '%PR\_%' escape '\';


--(24) emp2 ���̺��� emp_type, position �÷��� ��ȸ�ϵ�
--�ߺ��� ��(���ڵ�)�� ����

select distinct emp_type, position from  emp2;

--select emp_type, position from  emp2;

--(25) student ���̺��� �����ؼ� 1������ 201���� �л��� �̸��� ��ȭ��ȣ�� ������ȣ�� ���. 
--��, ������ȣ�� ���ڸ� ���;� ��

select name, tel, instr(tel, ')') as ")��ġ", 
    substr(tel, 1, instr(tel, ')')-1) ������ȣ from student
where deptno1=201;

--(26) student ���̺�� professor ���̺��� �����Ͽ� 301�� �а��� �ҼӵǾ� �ִ� �л��� �������� �й�(������ ������ȣ), 
--�̸�, �а� ��ȣ�� ���

select '[����]' as "����", 
    profno, name, id, hiredate, deptno from professor
where deptno=301
union
select '[�л�]' as "����", 
    studno, name, id, birthday, deptno1 from student
where deptno1=301;

--(27) ���� ������ ���� ���ǻ���
1) (�÷��� ����)�� ��ġ�ؾ� ��
2) (�÷��� �ڷ���)�� ��ġ�ؾ� ��

--(28) student ���̺��� 1������ 201���� �л����� �̸��� �г�, �ֹι�ȣ�� ����ϵ� 
--�ֹι�ȣ�� �� 7�ڸ��� '#'�� ǥ�õǰ� ���
select name, grade, jumin,
    replace(jumin, substr(jumin,  7), '#######') 
    as "replace2"
from student
where deptno1 = 201;


--(29) test_file ���̺���  ���ϸ� �����ϱ�(example.txt, abc.java)
select filepath, 
substr(filepath, instr(filepath, '\', -1)+1) ���ϸ�
from test_file;