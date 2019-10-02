--[ ����Ŭ 4�� ]


--(1) employees , jobs ���̺��� first_name, salary, job_title ��ȸ�ϱ�

select e.first_name, e.salary, j.job_title
from jobs j, employees e
where j.job_id = e.job_id;


--(2) employees , departments, locations  ���̺��� city, department_name, job_id, salary ��ȸ�ϱ�
select c.city, b.department_name, a.job_id, a.salary
from employees a  join departments b
on a.department_id=b.department_id
 join locations c
on b.location_id=c.location_id;


--(3) employees , departments, locations  ���̺��� city��, department_name ��, job_id ���� 
--�׷�ȭ�Ͽ� city, department_name, job_id, �ο���, �޿�(salary)�հ�  ���ϱ�
select c.city, b.department_name, a.job_id, count(*) "�ο���", 
sum(salary) "�޿��հ�"
from employees a  join departments b
on a.department_id=b.department_id
 join locations c
on b.location_id=c.location_id
group by city, department_name, job_id
order by city, department_name, job_id;


--(4) professor, department ���̺��� �����ؼ� profno(������ȣ), name(�̸�), hiredate(�Ի���), dname(�а���) ��ȸ�ϱ�
select p.profno, p.name, p.hiredate
from professor p, department d
where p.deptno = d.deptno;


--(5) emp2, dept2 ���̺��� �����ؼ� dname(�μ���), name(�̸�), pay(����) ��ȸ�ϵ�, pay�� 6000���� �̻��� �����͸� ��ȸ�ϱ�
select *
from emp2;

select *
from dept2;

select d.dname, e.name, e.pay
from emp2 e, dept2 d
where e.deptno = d.dcode
and e.pay>=60000000;


--(6) �л� �̸��� '��'�� �� �л����� �̸�(name), �г�(grade), �ֹι�ȣ(jumin), ��ȭ��ȣ(tel), ��米����(name) ������ ��������
--student , professor ���̺� ���� (inner join �̿�)
select *
from student;

select *
from professor;


--(7) �л��� �̸�(name), �г�(grade), ��米����(name),�а���(dname) �����͸� ��ȸ
--student , professor,department ���̺� ���� 
--��米������ ��Ī�� ���������� �ش�
--��� �л��� ��µǵ��� �Ѵ�(outer join)


--(8) emp2 ���̺�� �а� p_grade ���̺��� join�Ͽ� ����̸�, ����, 
--���翬��, �ش� ������ ������ ���� �ݾװ� ���� �ݾ���  ��ȸ
--��� ����� ��µǵ���


--(9) emp, dept ���̺��� �μ��̸��� sal�� ��� ���ϱ�

--(10) student ���̺�� exam_01 ���̺��� ��ȸ�Ͽ� �л����� �й�, �̸�, ����, ������ ����Ͻÿ�
--(������ dcode�� case�̿�- 90 �̻��̸�'A', 80�̻��̸� 'B', 70�̻��̸� 'C', 60�̻��̸�'D' 
--60�̸��̸� 'F' )
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
select *
from emp;

select a.ename, b.ename
from emp a, emp b
where a.empno = b.mgr
and a.ename='FORD';

--(12)�л����̺��� �а�(deptno1)���� �л��� ���Ű ���ϱ�
--���Ű�� �Ҽ� ���� ���ڸ��� �������� �ݿø��Ѵ�(round �Լ� �̿�)


--(13) �������̺��� �а�(deptno)��, ����(position)���� �޿�(pay)�� �� ���ϱ�
 

 
--(14) ������ �������� ������ �ִ���, �����ϰ�, ������ ���� �����Ͻÿ�.



--(15) panmae ���̺��� �Ǹ���(p_date)���� �Ǹűݾ�(p_total)�� �հ� ���ϱ�


--(16) panmae ���̺��� ����(p_qty)�� 3�� �̻��� �����Ϳ� ���� �Ǹ���(p_date)��, �Ǹ���(p_store)���� �Ǹűݾ�(p_total)�� �հ�, �Ǽ� ���ϱ�
�� ������� �Ǽ��� 2 �̻��� �����͸� ��ȸ
select p_date, p_store, sum(p_total),
decode(grouping(p_date), 0, to_char(p_date),'[��ü]') "��¥",
decode(grouping(p_store), 0, to_char(p_store),'[�Ұ�]') "����"
from panmae
where p_qty>=3
group by rollup(p_date, p_store)
order by p_date, p_store;

--(17) panmae ���̺��� ��ǰ�ڵ�(p_code)���� �Ǹűݾ�(p_total)�� �հ�, ����(p_qty)�� �հ�, �Ǽ�, �Ǹűݾ�(p_total)�� ��� ���ϱ�
�� ������� �Ǹűݾ�(p_total)�� �հ谡 10000 �̻��̰�, ����(p_qty)�� �հ谡 15 �̻��� �����͸� ��ȸ



--(18) panmae ���̺��� �Ǹ���(p_store)��, ��ǰ�ڵ�(p_code)���� �Ǹűݾ�(p_total)�� �հ�, ��� ���ϱ�
