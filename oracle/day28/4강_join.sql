--[2010-10-01]
--�л� ���̺� (student)�� �а� ���̺� (department)�� ����Ͽ� �л��̸�, 1���� �а���ȣ (deptno1), 1���� �а��� ���� ����Ͻÿ�.

--����Ŭ ����
select * from student;
select * from department;

select student.name, student.deptno1, department.dname
from student, department
where student.deptno1 = department.deptno;

select s.name, s.deptno1, d.dname
from student s , department d --��Ī�̿�
where s.deptno1 = d.deptno;

select s.name, s.deptno1, d.dname
from student s join department d --��Ī�̿�
on s.deptno1 = d.deptno;

select s.name, s.deptno1, d.dname
from student s inner join department d --��Ī�̿� --inner�� ���� ����
on s.deptno1 = d.deptno;

--4�г� �л����� ������ ��ȸ, �а��� ���
select s.name, s.deptno1, d.dname, s.grade
from student s, department d --��Ī�̿� --inner�� ���� ����
where s.deptno1 = d.deptno
and s.grade=4;

--ansi
select s.name, s.deptno1, d.dname, s.grade
from student s join department d --��Ī�̿� --inner�� ���� ����
on s.deptno1 = d.deptno
and s.grade=4;

--�л� ���̺�(student)�� ���� ���̺�(professor)�� join�Ͽ� 
--�л��̸�, �������� ��ȣ, �������� �̸��� ����Ͻÿ�
select * from student;
select *from professor;

select s.name, s.profno, p.name
from student s join professor p
on s.profno = p.profno;
--> profno�� null�� ���� �� ���´�


select * from employees;
select* from jobs;

select e.first_name, e.job_id, j.job_title 
from employees e join jobs j
on e.job_id = j.job_id;

select e.first_name, e.job_id, j.job_title 
from employees e, jobs j
where e.job_id = j.job_id;

--ansi join
select s.name, d.dname, p.name
from student s join department d 
on s.deptno1 = d.deptno
join professor p
on s.profno=p.profno;


-- emp2 ���̺�� �а� p_grade ���̺��� join�Ͽ� ����̸�, �� ��, ���翬��, �ش� ������ ������ ���� �ݾװ� ���� �ݾ��� ����Ͻ� ��
select * from emp2;
select * from p_grade;
select * from dept2;

select e.name, e.emp_type, e.pay, p.s_pay, p.e_pay
from emp2 e join p_grade p
on e.position = p.position;

select e.name, e.emp_type, e.pay, p.s_pay, p.e_pay, d.area
from emp2 e join p_grade p
on e.position = p.position
join dept2 d
on d.dcode = e.deptno;

--�������, ����� �μ�����, �μ��� ��������, ������ �������� ��ȸ
select * from employees;
select * from departments;
select *from locations;
select * from countries;

select e.first_name, e.salary, d.department_name, l.city, c.country_name
from employees e, departments d, locations l, countries c 
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id;


--1����(depton1)�� 101���� �л����� �л��̸��� �������� �̸��� ����Ͻÿ�.
select * from student;
select * from professor;

select s.NAME, p.NAME
from student s, professor p
where s.profno=p.profno
and deptno1=101;

select e.name, e.pay, e.position, d.dname
from emp2 e, dept2 d
where e.deptno=d.dcode;

select e.name, e.pay, e.position, d.dname
from emp2 e join dept2 d
on e.deptno=d.dcode;

select * from emp2;
select * from dept2;

select deptno, avg(pay)
from emp2
group by deptno;

select d.dname, avg(nvl(pay,0))
from emp2 e join dept2 d
on e.deptno = d.dcode
group by d.dname
having d.dname like '%����%';

--emp, dept ���̺��� �μ���ȣ,�����,����,�μ���,���� ��ȸ ��, ����(job)�� CLERK�� ��� �����͸� ��ȸ
select * from emp;
select * from dept;

select e.empno, e.ename, e.job, d.deptno, d.loc
from emp e join dept d
on e.deptno = d.deptno
where e.job='CLERK';

--student ���̺�� exam_01 ���̺��� ��ȸ�Ͽ� �л����� �й�, �̸�, ����, ������ ����Ͻÿ� 
--(������ dcode�� case�̿�- 90 �̻��̸� 'A', 80�̻��̸� 'B', 70�̻��̸� 'C', 60�̻��̸�'D' 60�̸��̸� 'F' )
select * from student;
select * from exam_01;

select s.NAME, s.studno, e.studno, e.total,
decode((e.total/10), 9, 'A', 8, 'B', 7, 'C', 6, 'D', 'F')  
from student s join exam_01 e
on s.studno = e.STUDNO;

--employees , departments, locations  ���̺��� city��, department_name ��, 
--job_id ���� �׷�ȭ�Ͽ� city, department_name, job_id, �ο���, �޿� (salary)�հ� ���ϱ�
select * from employees;
select * from departments;
select * from locations;

select l.city, d.department_name, e.job_id, count(*), sum(salary)
from employees e join departments d
on e.department_id = d.department_id
join locations l
on l.location_id = d.location_id
group by l.city, d.department_name, e.job_id;


--student ���̺�� professor ���̺��� �����Ͽ� �л��̸��� �������� �̸��� ����Ͻÿ�. 
--��, ���������� �������� ���� �� ���� ��ܵ� �Բ� ����Ͻÿ�

select s.*, p.name
from student s, professor p
where s.profno=p.profno; --inner join

select s.*, p.name
from student s, professor p
where s.profno=p.profno(+); --outer join

select s.*, p.name
from student s right join professor p
on s.profno=p.profno; --outer join

-------------
select s.*, p.name
from student s, professor p
where s.profno=p.profno(+)
union
select s.*, p.name
from student s, professor p
where s.profno(+)=p.profno;

select s.*, p.name
from student s full outer join professor p
on s.profno=p.profno;


select s.*, d.DNAME, p.name
from student s, department d, professor p
where s.deptno1=d.deptno
and s.profno=p.profno;

select * from employees;
select * from departments;
select * from locations;

select e.*, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and l.location_id(+) = d.department_id;

select e.*, d.department_name, l.city, c.country_name
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id(+)
and l.location_id(+) = d.department_id
and l.country_id = c.country_id(+)
order by e.department_id desc;

--employees, departments, locations ���̺���
--city��, department_name��, job_id���� �׷�ȭ�Ͽ� �ȿ���, �޿��հ� ���ϱ�

select l.city, d.department_name, e.job_id, count(*), sum(e.salary)
from employees e, departments d, locations l
where e.department_id=d.department_id(+)
and d.location_id = l.location_id(+)
group by l.city, d.department_name, e.job_id
order by l.city, d.department_name, e.job_id;

select l.city, d.department_name, e.job_id, count(*), sum(e.salary)
from employees e left join departments d
on e.department_id=d.department_id
left join locations l
on d.location_id = l.location_id
group by l.city, d.department_name, e.job_id
order by l.city, d.department_name, e.job_id;

--
select a.*, b.dname "�����μ���"
from dept2 a, dept2 b
where a.pdept=b.dcode
order by a.dcode;
--> ����� ���ڵ� ����

select a.*, b.dname "�����μ���"
from dept2 a left join dept2 b
on a.pdept=b.dcode
order by a.dcode;
--> ����� ���ڵ� ����

--��������� �ش� ����� ���� ����� �̸��� ���
select e.*, m.first_name "���� ���"
from employees e, employees m
where e.employee_id(+) = m.manager_id
order by e.employee_id;

--
select * from emp; --14
select * from dept; --4

select e.*, d.*
from emp e, dept d;

select e.*, d.*
from emp e, dept d
order by e.empno; --14*4 = 56

/*
1. emp2, p_grade ���̺��� name(����̸�),  position(����), ���ۿ��� (s_year), ������(e_year)�� ��ȸ ? 
   ��, emp2 ���̺��� �����ʹ� ���� ��µǵ��� �� ��

2. EMP Table�� �ִ� EMPNO�� MGR�� �̿��Ͽ� ������ ���踦 ������ ���� ����϶�. 
  ��FORD�� �Ŵ����� JONES��
*/

select *
from emp2 e, 
