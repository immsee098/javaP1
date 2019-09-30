--������ �Ԥ�

select birthday,  id, length(id)
from student;

select max(pay), min(pay), max(bonus), min(bonus)
from professor;

--���� ��¥�� ��� �񱳰� ����
--�ȿ� distinct ������ �ߺ����� ���� ����


--group by - ���̺� ��ü�� ���� ���踦 ���ϴ� ���� �ƴ϶� Ư�� ���������� ����

select deptno, avg(nvl(pay,0))
from professor
group by deptno
order by deptno;

--�а���, ���޺� �޿� ���

select deptno, position,avg(nvl(pay,0))
from professor
group by deptno, position
order by deptno, position;

--group bt���� �ִ� �÷��� �׷��Լ��� select ���� �ø� �� ����
--select deptno, position,avg(nvl(pay,0)), name -error
--from professor
--group by deptno, position
--order by deptno, position;


select deptno as dno, position, avg(pay)
from professor
--group by dno, position --error ��Ī ��� �Ұ�
order by dno, position; --order by ������ ��Ī ��� ����


--�μ��� ��ձ޿��� ���� ��, ��� �޿��� 450 �ʰ��� �μ��� �μ���ȣ�� ��� �޿��� ���Ͻÿ�.
select * from professor;

select deptno, avg(nvl(pay,0))
from professor
--where avg(nvl(pay,0)) > 450 --�׷������� ������� �ȵ�
group by deptno
order by deptno;
--where������ �׷��Լ� �� �� ����

select deptno, avg(nvl(pay,0))
from professor
group by deptno
having avg(nvl(pay,0)) > 450 
order by deptno;

--student���� grade���� weight, height ���, �ִ밪 ���ϱ�
select grade, avg(nvl(weight, 0))
from student
group by grade;

--���� ������� Ű�� ����� 170 ������ ��� ���ϱ�
select grade, avg(nvl(weight, 0)), avg(nvl(height, 0)),
max(weight), max(height)
from student
group by grade
having avg(nvl(height, 0)) <=170;

select * from student
order by deptno1;


select grade, avg(nvl(weight,0)), avg(nvl(height, 0)), max(weight), max(height)
from student
where deptno1=201
group by grade
having avg(nvl(height, 0))<180;


--1.  emp���̺��� �μ��� �޿��� ���� ���ϱ�.
select deptno, sum(nvl(sal,0))
from emp
group by deptno;

--2. emp ���̺��� job���� �޿��� �հ� ���ϱ�.
select job, sum(nvl(sal, 0))
from emp
group by job;

--3. emp ���̺��� job���� �ְ� �޿� ���ϱ�
select job, max(nvl(sal, 0))
from emp
group by job;

--4. emp ���̺��� job���� ���� �޿� ���ϱ�
select job, min(sal)
from emp
group by job;

--1. emp ���̺��� job���� �޿��� ��� ���ϱ� ? �Ҽ����� 2�ڸ��� ǥ��
select job, round(avg(nvl(sal, 0)),2)
from emp
group by job;

--2. Student ���̺��� grade���� weight, height�� ���, �ִ밪 ���ϱ� 
select grade, max(weight), max(height), avg(nvl(weight,0)), avg(nvl(height,0))
from student
group by grade;

--3.  2���� ������� Ű�� ����� 170 ������ ��� ���ϱ�
select grade, max(weight), max(height), avg(nvl(weight,0)), avg(nvl(height,0))
from student
group by grade
having avg(nvl(height,0))<=170;


--4.  emp2 ���̺��� emp_type���� pay�� ����� ���� ���¿��� ��� ������ 3 õ���� �̻��� ����� emp_type �� ��� ������ �о����
select emp_type, avg(pay)
from emp2
group by emp_type
having avg(pay)>30000000;

--5. emp2�� �ڷḦ �̿��ؼ� ����(position)���� ���(empno)�� ���� ���� ��� �� ���ϰ� �� ��� ������ ����� 1997�� �����ϴ� ��� ���ϱ� (����� �ִ밪), like �̿�
--6. emp ���̺��� hiredate�� 1982�� ������ ����� �߿��� deptno��, job�� sal�� �հ踦 ���ϵ� �� ��� ������ �հ谡 2000 �̻��� ����� ��ȸ
select deptno, job, sum(nvl(sal, 0))
from emp
where hiredate<'1982-01-01'
group by deptno, job
having sum(nvl(sal, 0))>2000;


--select sql�� ���� ����
----------------------------------------------------
--roll up, vube�� group by�� ����
select deptno, avg(nvl(pay,0)) "��ձ⺻��"
from professor
group by deptno
order by deptno;

--cube
select deptno, round(avg(nvl(pay,0)),1) "���ձ⺻��"
from professor
group by cube(deptno)
order by deptno;

select deptno, position, avg(nvl(pay,0)) "��� �⺻��"
from professor
group by rollup(deptno, position)
order by deptno, position;

--Į���� 3���� ���
select * from emp_details_view;

select city, department_name, job_title, avg(nvl(salary, 0)) "��ձ޿�"
from emp_details_view
group by city, department_name, job_title
order by city, department_name, job_title;


--rollup
select * from emp_details_view;

select city, department_name, job_id, avg(nvl(salary, 0)) "��ձ޿�"
from emp_details_view
group by rollup(city, department_name, job_id)
order by city, department_name, job_id;

--cube


select decode(grouping(deptno), 1,
        decode(grouping(position),0,'[���޺� �Ұ�]', '[��ü]'), deptno) "�а�",
        decode(grouping(position), 0, position, '[�а��� �Ұ�]'),
        decode(grouping(deptno),0,'[�а����Ұ�]','[�Ұ�]') "����",
        round(avg(nvl(pay,0)),1) "��ձ⺻��",
        grouping(deptno), grouping(position)
        from professor
        group by cube(deptno, position)
        order by deptno, position;
        
 -- STUDENT ���̺��� �г⺰�� �л����� �ο��� �հ�� �а����� �� ������ �հ踦 ���ؾ� �ϴ� ��쿡 
 --�������� �г⺰�� �ο��� �հ踦 ���� �� ������ �а����� �ο��� �հ踦 ���� �� UNION ������ ����   