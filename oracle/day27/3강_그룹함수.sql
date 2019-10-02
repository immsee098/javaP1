--3��_�׷��Լ�.sql
--[2019-09-30 ��]
--������ �Լ�
select birthday, to_char(birthday,'d'), id, length(id) 
from student;

--�������Լ�(�׷��Լ�)
select sum(pay) from professor;

select * from professor;

--count() - �ԷµǴ� �������� �Ǽ��� �����ϴ� �Լ�
--�׷� �Լ��� null�� �����ϰ� �����
select count(*), count(bonus), count(hpage), count(name)
from professor;
--bonus, hpage�� null�� ���ܵ� �Ǽ���
--count(*) - ��ü ���ڵ� ����

--sum() - �հ� ���ϴ� �Լ�
/*
����, ��¥�� sum, avg() �Լ��� ����� �� ����(���� �Ұ�)
count() �Լ��� ����, ��¥������ ��� ����
*/
select sum(pay), sum(bonus), count(pay), count(bonus), count(*)
from professor;

select sum(name) from professor;  --error

--avg() - ����� ���ϴ� �Լ�
select avg(pay), sum(pay), count(pay), count(*),
    avg(bonus), sum(bonus), count(bonus), 
    sum(bonus)/count(bonus), sum(bonus)/count(*),
    avg(nvl(bonus,0))
from professor;
/*
    �׷��Լ��� null�� �����ϰ� �����ϹǷ� avg()�� �������� ������� ������ ����
    => nvl() �Լ��� �̿��Ͽ� ó���ؾ� ��
    => avg(nvl(�÷�,0))
*/

--max() - �ִ밪�� ���ϴ� �Լ�
--min() - �ּҰ��� ���ϴ� �Լ�

select max(pay), min(pay), max(bonus), min(bonus)
from professor;

--����, ��¥�� �ִ밪, �ּҰ��� ���� �� �ִ�(��� �񱳰� �����ϹǷ�)
select max(name), min(name), max(hiredate), min(hiredate)
from professor;

--�ߺ����� ������ �Ǽ� : count(distinct �÷���)
select count(grade), count(*), count(distinct grade)
from student;

select * from student;

/*
    sum(distinct �÷���) - �ߺ����� ������ �հ�
    avg(distinct �÷���) - �ߺ����� ������ ���
    max(distinct �÷���) - �ߺ����� ������ �ִ밪
    min(distinct �÷���) - �ߺ����� ������ �ּҰ�
*/

--�׷캰 ����
--�а����� �������� ��� �޿� ���ϱ�

--cf. ��ü �������� ��� �޿�
select avg(pay) from professor;

select * from professor;

--�а����� ����
select deptno, pay from professor
order by deptno;

--group by
select deptno, avg(nvl(pay,0))
from professor
group by deptno --�а����� ���
order by deptno;

/*
group by - ���̺� ��ü�� ���� ���踦 ���ϴ� ���� �ƴ϶�,
           Ư�� ���������� ���� �����͸� ����
*/

--�а���, ���޺� �޿��� ��� ���ϱ�
select * from professor;

select deptno, position, avg(nvl(pay,0))
from professor
group by deptno, position
order by deptno, position;

--group by���� �ִ� �÷��� �׷��Լ��� select���� �� �� �ִ�
select deptno, position, name, avg(nvl(pay,0))  --error
from professor
group by deptno, position
order by deptno, position;

--
select deptno as dno, position, avg(pay)
from professor
group by dno, position  --error : group by�������� ��Ī ��� �Ұ�
order by dno, position;  --order by������ ��Ī ��� ����

--�μ��� ��ձ޿��� ���� ��, ��� �޿��� 450 �ʰ��� �μ��� �μ���ȣ�� ��� �޿��� ���Ͻÿ�.
select * from professor;

select deptno, avg(nvl(pay,0))
from professor
where avg(nvl(pay,0)) > 450  --error:group function is not allowed here
group by deptno
order by deptno;
--=> where������ �׷��Լ��� �� �� ����

select deptno, avg(nvl(pay,0))
from professor
group by deptno
--having avg(nvl(pay,0)) > 450
order by deptno;
/*
    having
    - group by�� ��������� Ư�� ������ �����ϴ� ���� ���Ϸ��� having�� �̿��Ѵ�
    - group by���� ���� ��µ� ����� ���� ������ �����Ѵ�
    - group by�� ����� �����ϰ����� �� ���
    
    group by �÷�
    having ����
*/
--student���� grade���� weight,height�� ���, �ִ밪 ���ϱ�
select grade, avg(nvl(weight, 0)), avg(nvl(height, 0)),
    max(weight), max(height)
from student
group by grade;

--���� ������� Ű�� ����� 170������ ��� ���ϱ�
select grade, avg(nvl(weight, 0)), avg(nvl(height, 0)),
    max(weight), max(height)
from student
group by grade
having  avg(nvl(height, 0))<=170;

select * from student
order by deptno1;

--student���� 201�а����� grade���� weight,height�� ���, �ִ밪 ���ϴµ�
--Ű�� ����� 175������ ��츸 ��ȸ
select grade, avg(nvl(weight, 0)), avg(nvl(height, 0)),
    max(weight), max(height)
from student
where deptno1=201
group by grade
having  avg(nvl(height, 0))<=175;

/*
1.  emp���̺��� �μ��� �޿��� ���� ���ϱ�.
     
2. emp ���̺��� job���� �޿��� �հ� ���ϱ�.

3. emp ���̺��� job���� �ְ� �޿� ���ϱ�

4. emp ���̺��� job���� ���� �޿� ���ϱ�
*/

select deptno, sum(sal)
     from emp group by deptno;

select job, sum(sal)
from emp group by job;
          
select  job, max(sal)
from emp group by job;

select job, min(sal)
from emp group by job;

/*
1. emp ���̺��� job���� �޿��� ��� ���ϱ� ? �Ҽ����� 2�ڸ��� ǥ��

2. Student ���̺��� grade���� weight, height�� ���, �ִ밪 ���ϱ�
3.  2���� ������� Ű�� ����� 170 ������ ��� ���ϱ�

4.  emp2 ���̺��� emp_type���� pay�� ����� ���� ���¿��� ��� ������ 3õ���� �̻��� 
����� emp_type �� ��� ������ �о����

5. emp2�� �ڷḦ �̿��ؼ� ����(position)���� ���(empno)�� ���� ���� ����� ���ϰ� 
�� ��� ������ ����� 1997�� �����ϴ� ��� ���ϱ�
	(����� �ִ밪), like �̿�

6. emp ���̺��� hiredate�� 1982�� ������ ����� �߿��� deptno��, job�� sal�� �հ踦 ���ϵ�
	�� ��� ������ �հ谡 2000 �̻��� ����� ��ȸ
*/
select job, round(avg(nvl(sal,0)),2)
from emp 
group by job;

select grade, avg(height), avg(weight), max(height), max(weight) 
from student
group by grade
having avg(height)<=170;

 select emp_type, avg(nvl(pay,0)) from emp2 
 group by emp_type
 having avg(pay) >=30000000;

select position, max(empno)
from emp2 group by position
having max(empno) like '1997%';

select deptno, job, sum(sal) from emp
where hiredate < '1982-01-01' 
group by  deptno, job
having sum(sal)>2000
order by  deptno, job;


--select sql�� ���� ����
/*
5. select �÷�
1. from ���̺�
2. where ����
3. group by �׷����� �÷�
4. having ����
6. order by �÷�
*/ 

--rollup,cube : group by�� �Բ� ���
--[1] rollup() - �־��� �����͵��� �Ұ踦 ������
--group by���� �־��� �������� �Ұ谪�� ������

--�а��� ��� �⺻��
select deptno, round(avg(nvl(pay,0)),1) "��ձ⺻��"
from professor
group by deptno
order by deptno;

select deptno, round(avg(nvl(pay,0)),1) "��ձ⺻��"
from professor
group by rollup(deptno)
order by deptno;

--cube
select deptno, round(avg(nvl(pay,0)),1) "��ձ⺻��"
from professor
group by cube(deptno)
order by deptno;

--group by�� �÷��� 2���� ���
--rollup
--�а���, ���޺� ��� �⺻��
select deptno, position, avg(nvl(pay,0)) "��� �⺻��"
from professor
group by deptno, position
order by deptno, position;

select deptno, position, avg(nvl(pay,0)) "��� �⺻��"
from professor
group by rollup(deptno, position)
order by deptno, position;
--�а���,��ü �Ұ谡 �߰���

--cube
select deptno, position, avg(nvl(pay,0)) "��� �⺻��"
from professor
group by cube(deptno, position)
order by deptno, position;
--�а���, ���޺�, ��ü �Ұ谡 �߰���

--group by�� �÷��� 3���� ���
select * from emp_details_view;

--������, �μ���, ������ ��� �޿� ���ϱ�
select city, department_name, job_id, 
    round(avg(nvl(salary, 0)),1) "��� �޿�"
from emp_details_view
group by city, department_name, job_id
order by city, department_name, job_id;

--rollup
select city, department_name, job_id, 
    round(avg(nvl(salary, 0)),1) "��� �޿�"
from emp_details_view
group by rollup(city, department_name, job_id)
order by city, department_name, job_id;

--rollup(�÷�) => �÷��� ���� + 1 ���� �Ұ谡 �������
--��) rollup(a,b,c) => (a,b,c), (a,b), (a), () => 3+1 => 4���� �Ұ谡 �������

--cube
select city, department_name, job_id, 
    round(avg(nvl(salary, 0)),1) "��� �޿�"
from emp_details_view
group by cube(city, department_name, job_id)
order by city, department_name, job_id;

--cube(�÷�) =>  2�� �÷��� ���� �Ұ谡 �������(��� ����� ��)
--��) cube(a,b,c) => ��� ����� ����ŭ�� �Ұ谡 �������, 2�� 3�� �� => 8��
--(a,b,c), (a,b),(a,c),(b,c), (a),(b),(c), ()

--grouping() - rollup, cube�Լ��� ���� ����
--�Ұ迡 ���� ��� ������ �� �� ���
--�׷��� �۾��� ���Ǿ����� 0, ������ �ʾ����� 1�� ������

--group by�� �÷��� 1���� ���, rollup
select deptno, round(avg(nvl(pay,0)),1) "��ձ⺻��",
    grouping(deptno)
from professor
group by rollup(deptno)
order by deptno;
    
select deptno, round(avg(nvl(pay,0)),1) "��ձ⺻��",
    grouping(deptno)
from professor
group by cube(deptno)
order by deptno;

--group by�� �÷��� 2���� ���
--rollup
select deptno, position, round(avg(nvl(pay,0)),1) "��ձ⺻��",
    grouping(deptno), grouping(position)
from professor
group by rollup(deptno, position)
order by deptno,position;

--
select decode(grouping(deptno),0, to_char(deptno),'[��ü]') "�а�",
    decode(grouping(position),0, position, '[�а��� �Ұ�]') "����", 
    round(avg(nvl(pay,0)),1) "��ձ⺻��",
    grouping(deptno), grouping(position)
from professor
group by rollup(deptno, position)
order by deptno,position;

--
select decode(grouping(deptno),0, to_char(deptno),'[��ü]') "�а�",
    decode(grouping(position),0, position, 
                decode(grouping(deptno),0,'[�а��� �Ұ�]','[���հ�]')) "����", 
    round(avg(nvl(pay,0)),1) "��ձ⺻��",
    grouping(deptno), grouping(position)
from professor
group by rollup(deptno, position)
order by deptno,position;

--cube
select deptno, position, round(avg(nvl(pay,0)),1) "��ձ⺻��",
    grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno,position;

select decode(grouping(deptno),1,  '[���޺��Ұ�]',deptno) "�а�", 
   decode(grouping(position),0,position,'[�а��� �Ұ�]') "����" 
  , round(avg(nvl(pay,0)),1) "��ձ⺻��",
    grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno,position;

--

select decode(grouping(deptno),1, 
        decode(grouping(position),0,'[���޺��Ұ�]','[��ü]'),deptno) "�а�", 
   decode(grouping(position),0,position, 
        decode(grouping(deptno),0, '[�а��� �Ұ�]','[�Ұ�]')) "����" 
  , round(avg(nvl(pay,0)),1) "��ձ⺻��",
    grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno,position;

--grouping sets - ���ϴ� ���踸 ������ �� �ִ�
--�׷��� ������ ���� ���� ��� �����ϰ� ���

--��) STUDENT ���̺��� �г⺰�� �л����� �ο��� �հ�� �а����� �ο����� �հ踦
-- ���ؾ� �ϴ� ��쿡 �������� �г⺰�� �ο��� �հ踦 ���ϰ� ������ �а����� �ο��� 
--�հ踦 ���� �� UNION ������ ����
select * from student;

--[2019-10-01 ȭ]
--union �̿�
select grade, count(*)
from student
group by grade
union
select deptno1, count(*)
from student
group by deptno1;

--cf. �г⺰, �а��� �ο���
select grade, deptno1, count(*)
from student
group by grade, deptno1
order by grade, deptno1;

--grouping sets
select grade, deptno1, count(*)
from student
group by grouping sets((grade), (deptno1))
order by grade, deptno1;

--rollup
select deptno, position, round(avg(nvl(pay,0)),1) "��ձ⺻��"
from professor
group by rollup(deptno, position)
order by deptno, position;

--grouping sets �� �̿��� rollup�� ������ ��Ȳ
select deptno, position, round(avg(nvl(pay,0)),1) "��ձ⺻��"
from professor
group by grouping sets((deptno, position),(deptno),())
order by deptno, position;


--grouping sets �� �̿��� cube�� ������ ��Ȳ
select deptno, position, round(avg(nvl(pay,0)),1) "��ձ⺻��"
from professor
group by grouping sets((deptno, position),(deptno),(position),())
order by deptno, position;

--���ϴ� ���踸
select deptno, position, round(avg(nvl(pay,0)),1) "��ձ⺻��"
from professor
group by grouping sets((deptno, position), (position))
order by deptno, position;

--emp���� �μ���, ���޺� sal�� �հ� ���ϱ�
--[1]group by �̿�
select deptno, job, sum(sal)
from emp
group by deptno, job
order by deptno, job;

--[2]���� ���
select ename, deptno, job, sal,
    decode(job, 'ANALYST', sal),
    decode(job, 'CLERK', sal),
    decode(job, 'MANAGER', sal),
    decode(job, 'PRESIDENT', sal),
    decode(job, 'SALESMAN', sal)
from emp
order by deptno, job;

--
select deptno,
sum(decode(job, 'ANALYST', sal)) "ANALYST",
sum(decode(job, 'CLERK', sal)) "CLERK",
sum(decode(job, 'MANAGER', sal)) "MANAGER",
sum(decode(job, 'PRESIDENT', sal)) "PRESIDENT",
sum(decode(job, 'SALESMAN', sal)) "SALESMAN"
from emp
group by deptno
order by deptno;

select deptno,
count(decode(job, 'ANALYST', sal)) "ANALYST",
count(decode(job, 'CLERK', sal)) "CLERK",
count(decode(job, 'MANAGER', sal)) "MANAGER",
count(decode(job, 'PRESIDENT', sal)) "PRESIDENT",
count(decode(job, 'SALESMAN', sal)) "SALESMAN"
from emp
group by deptno
order by deptno;


select deptno, 
sum(decode(job, 'ANALYST', sal)) "ANALYST",
sum(decode(job, 'CLERK', sal)) "CLERK",
sum(decode(job, 'MANAGER', sal)) "MANAGER",
sum(decode(job, 'PRESIDENT', sal)) "PRESIDENT",
sum(decode(job, 'SALESMAN', sal)) "SALESMAN"
from emp
group by rollup(deptno)
order by deptno;

--��������(������ price�� �հ� ���ϱ�)
--[1] group by �̿�
select
to_char(regdate,'mm'), sum(price) --extract(month from regdate)�� ����
from pd
group by to_char(regdate,'mm')
order by to_char(regdate,'mm');

--[2]���� ���ΰ� �ǵ��� ���
select 
sum(decode(to_char(regdate,'mm'),'01', price, 0)) "1��",
sum(decode(to_char(regdate,'mm'),'08', price)) "8��",
sum(decode(to_char(regdate,'mm'),'09', price)) "9��",
sum(price) "��ü�հ�"
from pd;

--panmae ���̺��� ����(p_qty)�� 3�� �̻��� �� ���Ϳ� ���� �Ǹ���(p_date)��, �Ǹ���(p_store) ���� �Ǹűݾ�(p_total)�� �հ� ���ϱ� ? 
--rollup, cube�̿��Ͽ� �Ұ� ��� ? 
--������ ��� grouping�Լ��� �̿��ؼ� ������� ����� ��(decode()�� �̿�)
select p_date, p_store, sum(p_total),
decode(grouping(p_date), 0, to_char(p_date),'[��ü]') "��¥",
decode(grouping(p_store), 0, to_char(p_store),'[�Ұ�]') "����"
from panmae
where p_qty>=3
group by rollup(p_date, p_store)
order by p_date, p_store;

select p_date, p_store, sum(p_total),
decode(grouping(p_date), 0, to_char(p_date),'[��ü]') "��¥",
decode(grouping(p_store), 0, to_char(p_store),'[�Ұ�]') "����"
from panmae
where p_qty>=3
group by cube(p_date, p_store)
order by p_date, p_store;


-- professor ���̺��� ����Ͽ� ���� �߿��� �޿�(pay)�� ���ʽ� (bonus)�� ��ģ �ݾ��� ���� ���� ���� ���� ���� ���, ��� �ݾ� �� ���Ͻÿ�. ? 
--��, ���ʽ��� ���� ���� ���ʽ��� 0���� ����ϰ�, ��� �ݾ��� ��� �� ���� ù° �ڸ������� ������ �Ͻÿ� ? 
--max, min, avg, round, nvl �Լ� ���
select max(pay+nvl(bonus, 0)) "�ִ밪" , min(pay+nvl(bonus, 0)) "�ּҰ�" , round(avg(pay+nvl(bonus, 0)), 1) "���"
from professor;


select decode(grouping(deptno),1, 
        decode(grouping(position),0,'[���޺��Ұ�]','[��ü]'),deptno) "�а�", 
   decode(grouping(position),0,position, 
        decode(grouping(deptno),0, '[�а��� �Ұ�]','[�Ұ�]')) "����" 
  , round(avg(nvl(pay,0)),1) "��ձ⺻��",
    grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno,position;


