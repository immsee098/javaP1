--[ ����Ŭ 2�� 2��]

--(1) test_file ���̺���  ���ϸ� �����ϱ�(example.txt, abc.java)
select substr('c:\test\js\example.txt',12),
    substr('d:\css\sample\temp\abc.java',20)
     from dual;

--(2) employees ���̺��� salary�� 100�� �ڸ����� �����Ͻÿ�.
--õ���� ���б�ȣ�� ǥ��
select TO_CHAR(TRUNC(salary,  3), '99,999') 
from employees;


--(3) �������ڿ� ���÷κ��� 4�� 5���� 6�� 7�ð� 23�� 42�� ���� ��¥ ���ϱ�
select to_char(sysdate , 'yyyy-mm-dd hh24:mi:ss') , 
to_char(add_months(sysdate, 2*12 + 3) + 1 + 2/24 + 10/(24*60) + 5/(24*60*60) ,'yyyy-mm-dd hh24:mi:ss'), 
to_char(sysdate + to_yminterval('04-05') + to_dsinterval('006 07:23:42'),
'yyyy-mm-dd hh24:mi:ss') from dual; 

--(4) professor���̺��� ������ �Ի��� 50�� ���� ��¥�� ���Ͻÿ�.
select hiredate, hiredate+50
from professor;

--(5) professor���̺��� ������ �Ի��� 3������ �Ǵ� ��¥?
select hiredate, add_months(hiredate, 3)
from professor;

--(6) professor���̺��� ������ �Ի��� 10���� �Ǵ� ��¥?
select hiredate, add_months(hiredate, 3)
from professor;

--(7) ���ú��� ������(2019-02-14)���� ���� �ϼ���?
select sysdate - to_date('2019-02-14')
from dual;

--(8) 2019-08-20 ���� ���ñ��� ����� �ϼ���?
select sysdate - to_date('2019-02-14')
from dual;

--(9) ���ú��� ũ��������(2019-12-25)���� ���� �޼���? (months_between)
select months_between(sysdate,'2019-12-25')
from dual; 

--(10) professor���̺��� �Ի����� ���ñ��� ���� �Ǿ���?

--(11) professor���̺��� �Ի����� ���ñ��� ��� �Ǿ���?

--(12) pd���̺��� ��ǰ�� ������� ��ð��� �������� ��ȸ

--(13) 2012-02-07�� �ش��ϴ� ���� ������ ��¥��?
select last_day('2012-02-07')
from dual;

--(14) �������ڸ� ���� ������ ���ڷ� ��ȯ�ؼ� ����Ͻÿ�.
--2019-03-28 14:35:27 ��
select TO_CHAR(sysdate, 'yyyy-mm-dd hh24:mi:ss day')
from dual;


--(15) emp ���̺��� hiredate Į���� �����Ͽ� �Ի����� 5���� ����� �̸��� 
--hiredate, job�� ���
select ename, hiredate, job
from emp
where to_char(hiredate, 'mm')=5;

--(16)emp ���̺��� job�� CLERK �̳� ANALYST�� ��� ��ȸ (in �̿�)
select *
from emp
where job in ('CLERK', 'ANALYST');

--(17) pd ���̺��� �����(regdate) ��  2019-09-07 ~ 2019-09-27 �� ������ �����͸� ��ȸ�ϱ�
--to_date �Լ� �̿��ϱ�
select * from pd
where regdate between to_date('2019-09-07') and to_date('2019-09-27')+1
order by regdate;


--(18) emp ���̺��� ����� �̸�, �Ի���, �޿�(sal), Ŀ�̼�(comm), ����(sal*12+comm)  ������ ��������
--comm�� null�̸� 0���� ���ǵ��� ó���Ѵ� -  nvl �Լ� ����ϱ�
select ename, hiredate, sal, comm, sal*12+nvl(comm, 0) as "����"
from emp;


--(19) gogak���� jumin�� �̿��Ͽ� ������ ��� (1, 3 �̸� ��,  2, 4�̸� ��)
select gname, jumin, case when substr(jumin, 7, 1)='1' then '��'
            when substr(jumin, 7, 1)='2' then '��'
       end "����"
from gogak; 


--(20) student���� grade�� 1�̸� 1�г�, 2�̸� 2�г�, 3�̸� 3�г�,4�̸� 4�г��̶�� ���
--decode() �̿�
select name, grade, case grade when 1 then '1�г�'
                               when 2 then '2�г�'
                               when 3 then '3�г�'
                               when 4 then '4�г�'
                        end "�г�",
                        case grade when 1 then '1�г�'
                                   when 2 then '2�г�'
                                   when 3 then '3�г�'
                                   else '4�г�'
                        end "�г�2"
from student;


--(21) emp���� �̸�, �Ի���, �޿�(sal), �μ� ������ ��ȸ�ϵ�, �޿��� ���� �ڸ����� �ݿø��Ͻÿ�. 
--�μ��� 20�̳� 30�� �����͸� ��ȸ
select ename, hiredate, round(sal, -2), deptno
from emp;


--(22) emp2 ���̺��� emp_type, position �÷��� ��ȸ�ϵ�
--�ߺ��� ��(���ڵ�)�� ����
select distinct emp_type, position
from emp2;


--(23) emp ���̺��� comm�� ���� ���� ����� �̸�(ename), job, sal, comm ������ ��������
select ename, job, sal, comm
from emp
where comm is null;

--(24) department ���̺��� deptno, dname, build �÷��� ��ȸ
--���� : �а�(dname)�� '����'�̶�� �ܾ �� �а����� ��ȸ�ϱ�
--���� : dname ������ ������������ ����
select deptno, dname, build from department
where dname like '%����%'
order by dname asc;


--(25)�������̺��� �޿�(pay)�� 350���� 500������ ������ �̸�(name), ���̵�(id), �޿�(pay) ������ ��������
select name, id, pay
from professor
where pay between 350 and 500;