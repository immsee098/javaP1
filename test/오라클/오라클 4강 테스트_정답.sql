--[ ����Ŭ 4�� ]


--(1) employees , jobs ���̺��� first_name, salary, job_title ��ȸ�ϱ�

select e.first_name, e.salary, j.job_title 
from employees e join jobs j
on e.job_id = j.job_id;

--(2) employees , departments, locations  ���̺��� city, department_name, job_id, salary ��ȸ�ϱ�
select c.city, b.department_name, a.job_id, a.salary
from employees a, departments b, locations c
where a.department_id=b.department_id
and b.location_id=c.location_id;


select c.city, b.department_name, a.job_id, a.salary
from employees a  join departments b
on a.department_id=b.department_id
 join locations c
on b.location_id=c.location_id;

--(3) employees , departments, locations  ���̺��� city��, department_name ��, job_id ���� 
--�׷�ȭ�Ͽ� city, department_name, job_id, �ο���, �޿�(salary)�հ�  ���ϱ�
select c.city, b.department_name, a.job_id, count(*) "�ο���", 
sum(salary) "�޿��հ�"
from employees a, departments b, locations c
where a.department_id=b.department_id
and b.location_id=c.location_id
group by city, department_name, job_id
order by city, department_name, job_id;

select c.city, b.department_name, a.job_id, count(*) "�ο���", 
sum(salary) "�޿��հ�"
from employees a join departments b
on a.department_id=b.department_id
left join locations c
on b.location_id=c.location_id
group by city, department_name, job_id
order by city, department_name, job_id;

--(4) professor, department ���̺��� �����ؼ� profno(������ȣ), name(�̸�), hiredate(�Ի���), dname(�а���) ��ȸ�ϱ�
select p.profno, p.name, p.hiredate, d.dname
from professor p, department d
where p.deptno=d.deptno;

--(5) emp2, dept2 ���̺��� �����ؼ� dname(�μ���), name(�̸�), pay(����) ��ȸ�ϵ�, pay�� 6000���� �̻��� �����͸� ��ȸ�ϱ�
select d.dname, e.name, e.pay
from emp2 e, dept2 d
where e.deptno=d.dcode
and e.pay >= 60000000;


--(6) �л� �̸��� '��'�� �� �л����� �̸�(name), �г�(grade), �ֹι�ȣ(jumin), ��ȭ��ȣ(tel), ��米����(name) ������ ��������
--student , professor ���̺� ���� (inner join �̿�)
select s.name, s.grade, s.jumin,s.tel, p.name
from student s, professor p 
where s.profno = p.profno
and s.name like '%��%'; 

select s.name, s.grade, s.jumin,s.tel, p.name
from student s join professor p 
on s.profno = p.profno
and s.name like '%��%'; 



--(7) �л��� �̸�(name), �г�(grade), ��米����(name),�а���(dname) �����͸� ��ȸ
--student , professor,department ���̺� ���� 
--��米������ ��Ī�� ���������� �ش�
--��� �л��� ��µǵ��� �Ѵ�(outer join)

select s.name,s.grade,p.name as ������, d.dname 
from student s, professor p, department d
where s.profno=p.profno(+)
and s.deptno1 = d.deptno(+);

select s.name,s.grade,p.name as ������, d.dname 
from student s left outer join professor p
on s.profno=p.profno
left join department d
on s.deptno1 = d.deptno;

--(8) emp2 ���̺�� �а� p_grade ���̺��� join�Ͽ� ����̸�, ����, 
--���翬��, �ش� ������ ������ ���� �ݾװ� ���� �ݾ���  ��ȸ
--��� ����� ��µǵ���
select e.name "����̸�", e.position "����", 
    e.pay "���翬��", p.s_pay "���ѱݾ�", p.e_pay "���ѱݾ�" 
from emp2 e, p_grade p
where e.position=p.position(+);

--[ANSI join]
select e.name "����̸�", e.position "����", 
    e.pay "���翬��", p.s_pay "���ѱݾ�", p.e_pay "���ѱݾ�" 
from emp2 e left join p_grade p
on e.position=p.position;

--(9) emp, dept ���̺��� �μ��̸��� sal�� ��� ���ϱ�
select d.dname "�μ��̸�", avg(nvl(e.sal,0)) "��տ���"
from emp e, dept d
where e.deptno=d.deptno
group by d.dname
order by d.dname;

select * from emp;
select * from dept;

--[ANSI join]
select d.dname "�μ��̸�", avg(nvl(e.sal,0)) "��տ���"
from emp e join dept d
on e.deptno=d.deptno
group by d.dname
order by d.dname;

--(10) student ���̺�� exam_01 ���̺��� ��ȸ�Ͽ� �л����� �й�, �̸�, ����, ������ ����Ͻÿ�
--(������ dcode�� case�̿�- 90 �̻��̸�'A', 80�̻��̸� 'B', 70�̻��̸� 'C', 60�̻��̸�'D' 
--60�̸��̸� 'F' )

select s.studno, s.name, e.total,
 decode(trunc(total,-1), 100, 'A',90,'A',80,'B',70,'C',60,'D','F') "����" 
from student s join exam_01 e
on s.studno = e.studno;

select s.studno, s.name, e.total,
 case trunc(total,-1) when 100 then 'A'
                      when 90 then 'A' 
                      when 80 then 'B'
                      when 70 then 'C'
                      when 60 then 'D'
                      else 'F' end "����" 
from student s join exam_01 e
on s.studno = e.studno;


--(11) EMP Table�� �ִ� EMPNO�� MGR�� �̿��Ͽ� ������ ���踦 ������ ���� ����϶�. 
--��FORD�� �Ŵ����� JONES��
SELECT a.ename "����̸�", b.ename "�Ŵ��� �̸�"
          FROM emp a, emp b
          WHERE a.mgr = b.empno;  


--(12)�л����̺��� �а�(deptno1)���� �л��� ���Ű ���ϱ�
--���Ű�� �Ҽ� ���� ���ڸ��� �������� �ݿø��Ѵ�(round �Լ� �̿�)
select deptno1,avg(height), round(avg(nvl(height,0)),1) from student 
group by deptno1;


--(13) �������̺��� �а�(deptno)��, ����(position)���� �޿�(pay)�� �� ���ϱ�
select deptno, position,sum(pay) from professor
group by deptno, position;
 

 
--(14) ������ �������� ������ �ִ���, �����ϰ�, ������ ���� �����Ͻÿ�.
���� ����(Inner Join)-���� ���̺� ���� ������ ������ ����� ������ �������� ����
-join�� �����ϴ� ��� ���̺� �����Ͱ� �����ϴ� ��쿡�� ������� �����
�ܺ� ����(Outer Join)-���� ���̺��� �����Ͱ� �ְ� ���� ���̺� ���� ��쿡 �����Ͱ� �ִ� �� ���̺��� ������ ���� ����ϰ� �ϴ� ���
���� ����(Self Join)-���ϴ� �����Ͱ� �ϳ��� ���̺� �� ��� ���� ���, �ڱ� �ڽ� ���̺�� �����ϴ� ��

--(15) panmae ���̺��� �Ǹ���(p_date)���� �Ǹűݾ�(p_total)�� �հ� ���ϱ�
select p_date, sum(p_total) from panmae
group by p_date;


--(16) panmae ���̺��� ����(p_qty)�� 3�� �̻��� �����Ϳ� ���� �Ǹ���(p_date)��, �Ǹ���(p_store)���� �Ǹűݾ�(p_total)�� �հ�, �Ǽ� ���ϱ�
�� ������� �Ǽ��� 2 �̻��� �����͸� ��ȸ

select p_date, p_store, sum(p_total), count(*) from panmae
where p_qty>=3
group by p_date, p_store
having count(*) >=2;

--(17) panmae ���̺��� ��ǰ�ڵ�(p_code)���� �Ǹűݾ�(p_total)�� �հ�, ����(p_qty)�� �հ�, �Ǽ�, �Ǹűݾ�(p_total)�� ��� ���ϱ�
�� ������� �Ǹűݾ�(p_total)�� �հ谡 10000 �̻��̰�, ����(p_qty)�� �հ谡 15 �̻��� �����͸� ��ȸ

select p_code, sum(p_total), sum(p_qty), count(*) , avg(nvl(p_total, 0)) from panmae
group by p_code
having  sum(p_total)>=10000 and sum(p_qty) >= 15
order by p_code;


--(18) panmae ���̺��� �Ǹ���(p_store)��, ��ǰ�ڵ�(p_code)���� �Ǹűݾ�(p_total)�� �հ�, ��� ���ϱ�
select p_store, p_code, sum(p_total), sum(p_qty), avg(nvl(p_total, 0)) from panmae
group by p_store, p_code
order by p_store, p_code;

