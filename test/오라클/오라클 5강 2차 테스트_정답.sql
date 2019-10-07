--[ ����Ŭ 5�� 2�� ]

--(1) �а��� ������ �ο����� ����� ���ϱ�- professor ���̺� �̿�

select deptno, count(*) "�ο���", 
    round((count(*)/ ( select count(*) from professor))*100, 1) "�����"
from professor
group by deptno
order by deptno;

--(2) employees���� ��������� ���ӻ���� �̸� ���ϱ�
--��Į�󼭺����� �̿�
--���ӻ���� ��� ���ӻ���� ������ �����̶�� ���
select a.*, 
    case when manager_id is null then '����'
    else
         (select b.FIRST_NAME
         from employees b where b.EMPLOYEE_ID=a.manager_id)
    end ���ӻ���̸�
from employees a;

--(3) employees���� salary�� �������� �����ؼ� ���� 6�Ǹ� ��ȸ

select *
from
(
    select first_name, hire_date, salary
    from employees
    order by salary desc
)
where rownum<=6; 

--(4) �� 3�� �������� �������� 2~4 ������ ������ ��ȸ�ϱ�

select A.*
from
(
    select rownum as rowcnt, first_name, hire_date, salary
    from
    (
        select first_name, hire_date, salary
        from employees
        order by salary desc
    )
) A
where rowcnt>=2 and rowcnt<=4;

--(5) �а���, ���� ���Ű ���ϱ� - student ���̺�
--inline view �̿�

select S.deptno1  "�а�", S."����", 
round(avg(nvl(S.height, 0)), 1) as "���Ű" 
from
(
    select deptno1, 
     case when substr(jumin, 7, 1) in('1','3') then '��' else '��' end as "����",
     height
    from student
) S
group by S.deptno1, S."����"
order by S.deptno1, S."����";

--(6) �� �μ��� ���ϴ� �������(�μ���ȣ, �����ȣ, ����̸�, ����, �޿�)�� ��ȸ�ϰ�, 
--�μ��� ��ձ޿��� ����Ͻÿ� -emp2
--inline view �̿�

select * from emp2;

 select e.deptno "�μ���ȣ", 
 e.empno,  e.name,  e.position, e.pay, B."�μ��� ��ձ޿�" 
 from emp2 e  left join
 (
    select deptno, 
    round(avg(nvl(pay,0)), 1) "�μ��� ��ձ޿�"
    from emp2
    group by deptno
 ) B 
 on e.deptno = B.deptno
 order by 1,2;

--(7)  �������  �а�(deptno1)�� ���� �л����� �й�(studno), �̸�(name), �г�(grade), �а���ȣ(deptno1)�� ��ȸ�ϵ� �̸�(name)�� ������������ ��ȸ
--���� ���� �̿� 
SELECT studno, name, grade, deptno1 FROM student
WHERE deptno1=(SELECT deptno1 FROM student WHERE name = '�����')
ORDER BY name desc;


--(8) �޿�(pay)�� ���� ��ü�� ��ձ޿����� ū ������ �̸�(name), ����(position), �޿�(pay), �Ի���(hiredate)�� ������ ��������.
--���� ���� �̿�
select name,position,pay,hiredate from professor
where pay>(select avg(nvl(pay,0)) from professor);


--(9) emp2 ���̺�� dept2 ���̺��� �����Ͽ� �ٹ����� 
--(dept2 ���̺��� area Į��)�� ���׺����� ��� ������� ����� �̸�, �μ���ȣ�� ����Ͻÿ�
select empno, name, deptno from emp2
where deptno in (select dcode from dept2
            where  area='���׺���');

--(10) employees ���̺��� ��ȸ�Ͽ� ������ �߿��� �ڽ��� �μ��� ��� �޿����� ���� �޴� ������� �̸�, �μ���ȣ, 
--����޿��� ����Ͻÿ�.
select first_name, department_id, salary
from employees a
where salary < (select avg(salary) from employees b
                where b.department_id=a.department_id)
order by department_id;


--(11) professor ���̺�� department ���̺��� ��ȸ�Ͽ� �������� ������ �а��̸��� ��ȸ
--��Į�� �������� �̿� 
select profno, name, pay, deptno, 
    (select dname from department d where D.deptno=p.deptno) 
        as "�а��̸�"
from professor p;


--(12) �� �μ��� �ش��ϴ� ����� ���ϱ�
--departments, employees �̿�
 select DEPARTMENT_ID, DEPARTMENT_NAME,LOCATION_ID,
    (select count(*) from employees e 
        where e.DEPARTMENT_ID=d.DEPARTMENT_ID) "�����"
from departments d;


--(13) exam_01 ���̺��� ������ ���� ������ 6�� ��ȸ�ϱ�
select *
from
(
    select studno, total
    from exam_01
    order by total desc
)
where rownum<=6; 


--(14) Student, exam_01 ���̺���  ������ 90�̻��� �л����� ���� ��ȸ
--exists �̿�

select * from student s
where exists(
select 1 from exam_01 e where total>=90 and s.studno=e.studno);

--in �̿�
select * from student
where studno in (
select studno from exam_01 where total>=90);


