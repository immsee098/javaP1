--[ ����Ŭ 5�� ]


--(1) �������  �а�(deptno1)�� ���� �л����� �й�(studno), �̸�(name), �г�(grade), �а���ȣ(deptno1)�� ��ȸ�ϵ� �̸�(name)�� ������������ ��ȸ
--���� ���� �̿� 
select studno, name, grade, deptno1 
from student 
where deptno1 = (select deptno1 from student where name='�����');


--(2) �޿�(pay)�� ���� ��ü�� ��ձ޿����� ū ������ �̸�(name), ����(position), �޿�(pay), �Ի���(hiredate)�� ������ ��������.
--���� ���� �̿�
select name, position, pay, hiredate
from professor
where pay > (select avg(pay) from professor);


--(3) emp2 ���̺�� dept2 ���̺��� �����Ͽ� �ٹ����� 
--(dept2 ���̺��� area Į��)�� ���׺����� ��� ������� ����� �̸�, �μ���ȣ�� ����Ͻÿ�
select *
from emp2
where pay < (select min(avg(nvl(pay,0)))
                    from emp2
                    group by deptno);

--(4) loc�� CHICAGO �� �ƴ� ��� ��� ��ȸ(emp, dept)
select * from emp
where deptno!=(select deptno
                from dept
                where loc='CHICAGO');

--(5) emp2 ���̺��� ��ȸ�Ͽ� �� �μ��� ��� ������ ���ϰ� �� �߿��� 
--��� ������ ���� ���� �μ��� ��� �������� ���� �޴� �������� �μ���,������, ������ ����Ͻÿ�.
--������ �������� �̿�
select e.*, d.DNAME
from emp2 e join dept2 d
on e.DEPTNO=d.DCODE
where pay >any(select avg(nvl(pay,0))
                    from emp2
                    group by deptno);


--������ �������� �̿�
select *
from emp2
where pay > any (select min(avg(nvl(pay,0)))
                    from emp2
                    group by deptno);


--(6) professor ���̺��� ��ȸ�Ͽ� �� �а����� �Ի����� ���� ������ ������ 
--������ȣ�� �̸�, �Ի���, �а����� ����Ͻÿ�. 
--�� �а��̸������� �������� �����Ͻÿ�.
select name, hiredate,deptno
from professor a
where hiredate<=(select max(hiredate) from professor b where a.DEPTNO = b.DEPTNO group by deptno) ;


--(7) Professor ���̺��� �ɽ� ������ ���� �Ի��Ͽ� �Ի��� ���� �߿��� ������ �������� ������ ���� 
--�޴� ������ �̸��� �޿�, �Ի����� ����Ͻÿ�.
select name, pay, hiredate
from professor            
where  hiredate=(select hiredate from professor
                where name='�ɽ�') 
and pay<(select pay from professor
            where name='������'); 

--(8) employees ���̺��� ��ȸ�Ͽ� ������ �߿��� �ڽ��� �μ��� ��� �޿����� ���� �޴� ������� �̸�, �μ���ȣ, 
--����޿��� ����Ͻÿ�.
select *
from employees a
where salary<(select min(avg(salary)) from employees b where a.DEPARTMENT_ID = b.DEPARTMENT_ID group by b.department_id);


--(9) professor ���̺�� department ���̺��� ��ȸ�Ͽ� �������� ������ �а��̸��� ��ȸ
--��Į�� �������� �̿� 



--(10) �� �μ��� �ش��ϴ� ����� ���ϱ�
--departments, employees �̿�
select * 
from departments;

select *
from employees;

select (select department_name from departments d where e.department_id = d.department_id) "�μ���", department_id, count(department_id)
from employees e 
group by department_id;


--(11) exam_01 ���̺��� ������ ���� ������ 6�� ��ȸ�ϱ�
select rownum, studno, total
from exam_01
where rownum<=6
order by total desc;

--(12) job_history, jobs ���̺���  job_title�� Public Accountant �� ������� 
--job_history ���� ��ȸ
 


--(13) emp2 ���̺�� �а� p_grade ���̺��� join�Ͽ� ����̸�, ����, 
--���翬��, �ش� ������ ������ ���� �ݾװ� ���� �ݾ���  ��ȸ
--��� ����� ��µǵ���
select e.NAME, e.POSITION, e.pay, p.S_PAY, p.E_PAY, d.DNAME
from emp2 e join p_grade p
on e.POSITION=p.position
join dept2 d
on e.DEPTNO=d.DCODE;


--(14) Student, exam_01 ���̺���  ������ 90�̻��� �л����� ���� ��ȸ
--exists �̿�
select * from student s
where exists(
    select 1 from exam_01 e where total>=90 and s.studno=e.studno);


--in �̿�
select * from student
where studno in (
    select studno from exam_01 where total>=90);
