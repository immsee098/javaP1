--5��_subquery.sql
--[2019-10-02 ��]
/*
�������� - �����ȿ� �� �ٸ� ������ ��� �ִ� ��

select * from ���̺�  --main query
where ���� ������ (select �÷� from ���̺� where ����); --subquery

() �ȿ� subquery�� �ִ´�
*/
--emp���̺��� scott ���� �޿��� ���� �޴� ����� �̸��� �޿��� ��ȸ

--���������� �̿����� �ʴ� ���
--1) ���� scott�� �޿��� ���Ѵ�
select sal from emp
where ename='SCOTT';  --3000

--2) 3000���� ���� �޴� ���� ��ȸ
select * from emp
where sal > 3000;

--�������� �̿�
select * from emp
where sal > (select sal from emp
                where ename='SCOTT');
--�������� �κ��� where���� ������ �����ʿ� ��ġ�ؾ� �ϸ�
--�ݵ�� ��ȣ()�� ����� ��

/*
=> ������ �������� - ���������� ����� �ϳ��� ���� ���

subquery�� ������ ����� 1�Ǹ� ������, �� ����� main query�� �����ؼ�
main query�� �����ϰ� ��

������ ���������� ��� where������ ���Ǵ� ������
=, !=, >,<,>=,<=

�� ���������� ����
1) ������ �������� - ���������� ����� 1���� ���� ���
2) ������ �������� - ���������� ����� 2�� �� �̻��� ���
3) �����÷� �������� - ���������� ����� ���� �÷��� ���
4) ������ �ִ� ��������(������� ��������) - ���������� ���������� ���� �����Ǿ� �ִ� ���
*/

--student ���̺�� department ���̺��� ����Ͽ� ������ �л��� 1����(deptno1)�� 
--������ �л����� �̸��� 1���� �̸��� ����Ͻÿ�
--1) �������� 1���� ��ȸ
select deptno1
from student
where name='������';  --101

--2) ��ȸ�� ������ ���� ������ �л��� ��ȸ
select * from student
where deptno1=101;

--subquery �̿�
select * from student
where deptno1=(select deptno1
                from student
                where name='������');

--join �̿��ؼ� �а��� ��ȸ
select s.*, d.DNAME 
from student s join department d
on s.DEPTNO1=d.DEPTNO
and deptno1=(select deptno1
                from student
                where name='������');
                
--�ǽ�) Professor ���̺��� �Ի����� �۵��� �������� ���߿� �Ի��� ����� �̸��� 
--�Ի���, �а����� ����Ͻÿ�.
--professor, department���̺� �̿�
select hiredate from professor
where name='�۵���'; --1998-03-22

select * from professor
where hiredate>'1998-03-22';

select * from professor
where hiredate>(select hiredate from professor
                    where name='�۵���');

select p.*, d.DNAME 
from professor p join department d
on p.DEPTNO = d.DEPTNO
and hiredate>(select hiredate from professor
                    where name='�۵���');
                    
--�ǽ�) student ���̺��� 1����(deptno1)�� 101���� �а��� ��� �����Ժ��� 
--�����԰� ���� �л����� �̸��� �����Ը� ����Ͻÿ�
select avg(nvl(weight,0))
from student
where deptno1=101; --60

select * from student
where weight>60;

select * from student
where weight>(select avg(nvl(weight,0))
                from student
                where deptno1=101);
                
--Professor ���̺��� �ɽ� ������ ���� �Ի��Ͽ� �Ի��� ���� �߿��� ������ �������� 
--������ ���� �޴� ������ �̸��� �޿�, �Ի����� ����Ͻÿ�.
select hiredate from professor
where name='�ɽ�'; --1981-10-23

select pay from professor
where name='������'; --550

select name, pay, hiredate
from professor            
where  hiredate='1981-10-23' and pay<550;

select name, pay, hiredate
from professor            
where  hiredate=(select hiredate from professor
                where name='�ɽ�') 
and pay<(select pay from professor
            where name='������'); 

--emp2���� ������ ���� ���� ��� ���� ��ȸ
select * from emp2
where pay = (select min(pay) from emp2);  --2000000

--dept2�� �����ؼ� �μ��� ��ȸ
select e.*, d.DNAME 
from emp2 e join dept2 d
on e.DEPTNO=d.DCODE
and pay = (select min(pay) from emp2);  --2000000

--������ ��������
/*
    - ���������� ����� 2�� �̻� ��µǴ� ���
    - ���������� ����� ���� �� ��µǱ� ������ ������ �����ڸ� ����� �� ����
    
    �� ������ �������� ������
    in - ���� ���� ã�´�.(���Ե� ��)
    <any - �ִ밪�� ��ȯ�� ��) sal< any(100,200,300) => 300
    >any - �ּҰ��� ��ȯ�� ��) sal> any(100,200,300) => 100
    <all - �ּҰ��� ��ȯ�� ��) sal< all(100,200,300) => 100
    >all - �ִ밪�� ��ȯ�� ��) sal> all(100,200,300) => 300
    
    ( any ? ���� ���� �ƹ��ų� �ϳ��� ������ �����ص� �ȴٴ� �ǹ�
      all ? ������������ ��ȯ�Ǵ� ��� row ���� �����ؾ� ���� �ǹ� )
*/

-- emp2 ���̺�� dept2 ���̺��� �����Ͽ� �ٹ����� (dept2 ���̺��� area Į��)�� ���� 
--������ ��� ������� ����� �̸�, �μ���ȣ�� ����Ͻÿ�
--1) �ٹ������� ���������� �μ�
select dcode
from dept2
where area='��������'; --1000, 1001, 1002, 1010

--2) ��ȸ�� ���������� �μ��� ���� ����� ��ȸ
select *  from emp2
where deptno in (1000, 1001, 1002, 1010);

--subquery �̿�
select *  from emp2
where deptno in (select dcode
                    from dept2
                    where area='��������');

--emp2 ���̺��� ����Ͽ� ��ü ���� �� ���� ������ �ּ� �����ں��� ������ ���� ����� 
--�̸��� ����, ������ ����Ͻÿ�.
--��, ���� ��������� õ ���� ���б�ȣ�� �� ǥ�ø� �Ͻÿ�.
--1)���� ������ �ּ� ���� ��ȸ
select min(pay)
from emp2
where position='����';  --49000000

--2)��ȸ�� ������ �ּҰ����� ���� �޴� ��� ��ȸ
select * from emp2
where pay > 49000000;

-- ������ �������� �̿�
select * from emp2
where pay > (select min(pay)
            from emp2
            where position='����');
            
--1) ���� ������ ���� ��ȸ
select pay from emp2
where position='����'; --5000��, 5600��, 5100��, 4900��

--2) ��ȸ�� ������ �ּҰ����� ���� �޴� ��� ��ȸ
select * from emp2
where pay >any (50000000,56000000,51000000,49000000);            

--������ �������� �̿�
select * from emp2
where pay >any (select pay from emp2
                where position='����'); 
                  
--emp2 ���̺��� ����Ͽ� ��ü ���� �� ���� ������ �ִ� �����ں��� ������ ���� ����� 
--�̸��� ����, ������ ����Ͻÿ�.
select * from emp2
where pay >all (select pay from emp2 where position='����');
                         
select * from emp2
where pay > (select max(pay) from emp2 where position='����');

--�ٹ������� ������簡 �ƴ� ��� ����� ��ȸ(emp2, dept2)
select dcode
from dept2
where area='�������'; --1005, 1009

select * from emp2
where deptno not in(1005, 1009);

--������ subquery
select * from emp2
where deptno not in(select dcode
                from dept2
                where area='�������');

--�μ��� ��ȸ
select e.*, d.DNAME 
from emp2 e join dept2 d
on e.DEPTNO=d.DCODE
and deptno not in(select dcode
                from dept2
                where area='�������');

--loc�� DALLAS�� �ƴ� ��� ��� ��ȸ(EMP, DEPT)
select deptno
from dept
where loc='DALLAS'; --20

select * from emp
where deptno!=20;

--������ ��������
select * from emp
where deptno!=(select deptno
                from dept
                where loc='DALLAS');
 
--������ �������������� != ������ �̿�
--������ �������������� not in ������ �̿�
/*
    ������ ���������� ������       ������ ���������� ������
    =                           in
    !=                          not in
    >, <                        >any, <any, >all, <all
*/                               

--�ǽ�)student ���̺��� ��ȸ�Ͽ� ��ü �л� �߿��� ü���� 4�г� �л����� ü�߿��� 
--���� ���� ������ �л����� �����԰� ���� �л��� �̸��� �����Ը� ����Ͻÿ�.
select * from student
where weight < (select min(weight) from student where grade=4);

select * from student
where weight <all (select weight from student where grade=4);

--emp2 ���̺��� ��ȸ�Ͽ� �� �μ��� ��� ������ ���ϰ� �� �߿��� ��� ������ ���� ���� 
--�μ��� ��� �������� ���� �޴� �������� �μ���,������, ������ ����Ͻÿ�.
select deptno, avg(nvl(pay,0))
from emp2
group by deptno; --13��

select *
from emp2
where pay <all (25000000, 68000000,49000000);

select *
from emp2
where pay <all (select avg(nvl(pay,0))
                    from emp2
                    group by deptno);

select e.*, d.DNAME
from emp2 e join dept2 d
on e.DEPTNO=d.DCODE
where pay <all (select avg(nvl(pay,0))
                    from emp2
                    group by deptno);
                    
--������
select *
from emp2
where pay < (select min(avg(nvl(pay,0)))
                    from emp2
                    group by deptno);

--employees���� job_id�� salary�հ� �ݾ��� 30000 �̻��� job_id�� ���ϴ� ��� ��ȸ
select job_id, sum(salary)
from employees
group by job_id
having sum(salary)>=30000; --7��

select * from employees
where job_id in (select job_id
                    from employees
                    group by job_id
                    having sum(salary)>=30000);

--���� �÷� ��������(pairwise subquery)
--���������� ����� ���� �÷��� ���

--student ���̺��� ��ȸ�Ͽ� �� �г⺰�� �ִ� Ű�� ���� �л����� �г�� �̸��� Ű�� ����Ͻÿ�.

--�г⺰ �ִ�Ű ���ϱ�
select grade, max(height)
from student
group by grade;     
/*
1�г� - 179  ?
2�г� - 184
3�г� - 177
4�г� - 182
*/                                   

--1�г� �ִ�Ű�� ���� �л� ����
select * from student
where grade=1 and height=179;

--���� �÷� ��������
select * from student
where (grade, height) in (select grade, max(height)
                            from student
                            group by grade);
                            
--professor ���̺��� ��ȸ�Ͽ� �� �а����� �Ի����� ���� ������ ������ ������ȣ�� �̸�, 
--�Ի���, �а����� ����Ͻÿ�. �� �а��̸������� �������� �����Ͻÿ�.
select deptno, min(hiredate)
from professor
group by deptno;

select profno, name, hiredate, deptno
from professor
where (deptno, hiredate) in (select deptno, min(hiredate)
                            from professor
                            group by deptno);

--join
select profno, name, hiredate, p.deptno, d.DNAME
from professor p join department d
on p.DEPTNO = d.DEPTNO
where (d.deptno, hiredate) in (select deptno, min(hiredate)
                            from professor
                            group by deptno)
order by d.dname;
                            
--emp2 ���̺��� ��ȸ�Ͽ� ���޺��� �ش� ���޿��� �ִ� ������ �޴� ������ �̸��� ����, 
--������ ����Ͻÿ�. ��, ���������� �������� �����Ͻÿ�
select name "�����", position "����", pay  "����" 
from emp2
where (position, pay) IN ( select position, MAX(pay) 
                            from emp2
                            group by position)
order by 3; 

select name "�����", nvl(position,'����') "����", pay  "����" 
from emp2
where (nvl(position,'����'), pay) IN ( select nvl(position,'����'), MAX(pay) 
                            from emp2
                            group by position)
order by 3; 

--�μ���ȣ���� �⺻���� �ִ��� ����� �⺻���� �ּ��� ��� ��ȸ
--employees
select department_id, max(salary)
from employees
group by department_id;

select department_id, min(salary)
from employees
group by department_id;

--subquery
select * from employees
where (department_id, salary) in (select department_id, max(salary)
                                    from employees
                                    group by department_id)
or (department_id, salary) in (select department_id, min(salary)
                                    from employees
                                    group by department_id);

select * from employees
where (nvl(department_id,0), salary) in (select nvl(department_id,0), max(salary)
                                    from employees
                                    group by department_id)
or (nvl(department_id,0), salary) in (select nvl(department_id,0), min(salary)
                                    from employees
                                    group by department_id)
order by department_id desc;

--��ȣ���� ��������(������ �ִ� ��������, ������� ��������)
/*
    - ���������� ���ο� ���������� �ʰ�, �������� �� ������ ���� ����Ǿ� �ִ� ������ ����
    - ���������� �����������̿��� ������ ����
    - ���������� �÷��� ���������� where �������� ����
    
    - ���� ���� ���� ���������� �ְ� ���������� ������ ��,
      �� ����� �ٽ� ���� ������ ��ȯ�ؼ� �����ϴ� ��������
*/
--emp2 ���̺��� ��ȸ�Ͽ� ������ �߿��� �ڽ��� ������ ��� ������ ���ų� ���� 
--�޴� ������� �̸�, ����, ���翬���� ����Ͻÿ�.
select * from emp2;

select avg(nvl(pay,0)) from emp2
where position='����'; --71666666.6

select * from emp2
where position='����' and pay>=71666666.6;  --2��

--�������� �̿�
select * from emp2 a
where pay>=(select avg(nvl(pay,0)) from emp2 b
                where b.position=a.position)
order by position;

--professor���� �ڽ��� �а��� ��� �������� ���� �޴� ���� ��ȸ
select * from professor;

select avg(nvl(pay,0))
from professor
where deptno=101; --400

select * from professor
where deptno=101 and pay<400;

--subquery 
select * from professor a
where pay < (select avg(nvl(pay,0)) from professor b
                where b.deptno=a.DEPTNO);

--exists ������
/*
    - Ư�� �÷����� �����ϴ��� ���θ� üũ
    - ���������� ��ȯ�ϴ� ����� ������������ ����� �����͵��� �����ϱ⸸ �ϸ�
      ������ �����ϰ� ��
    - ���ɸ鿡���� in ���� exists�� ������ �����
    
    �� in, exists ��
    1) in - � ���� ���ԵǴ��� ���θ� üũ
       in�� ()�ȿ� ���� ���� �ü��� �ְ�, ���������� �� ���� �ִ�
    
    2) exists - Ư�� �÷����� �����ϴ��� ���θ� üũ
       exists�� ���� ���������� �� �� �ִ�
*/                
--dept2���̺��� pdept���� null�� �ƴ� �μ��� ���ϴ� ��� ����
select * from dept2;
select * from emp2;

--in �̿�
select dcode from dept2
where pdept is not null; --1000,1001,1002,...

select * from emp2
where deptno in (1000,1001,1002);    
            
select * from emp2
where deptno in (select dcode from dept2
                    where pdept is not null);  
--exists �̿�
select * from emp2 a
where exists (select 1 from dept2 b 
                where a.DEPTNO=b.DCODE and b.pdept is not null); 

--join �̿�
select a.*
from emp2 a join dept2 b
on a.DEPTNO=b.DCODE 
and b.PDEPT is not null;

--������翡 ���ϴ� ������� ���� ��ȸ
--in
select dcode from dept2
where area='�������';  --1005,1009

select * from emp2
where deptno in (1005,1009);  --in�� Ư������ ���� ���

select * from emp2
where deptno in (select dcode from dept2
                    where area='�������');  --in�� ���������� ���� ���

--exists
select * from emp2 a
where exists (select 1 from dept2 b
                where b.DCODE=a.DEPTNO and area='�������');

--join
select a.*
from emp2 a join dept2 b
on a.DEPTNO=b.dcode
and b.area='�������';  

--������ 3000�޷� �̻��� ����� ���� �μ� ��ȸ
--emp, dept
select deptno
from emp
where sal>=3000; --10, 20

select * from dept
where deptno in (10,20);

select * from dept
where deptno in (select deptno
                    from emp
                    where sal>=3000);  

select * from dept a
where exists ( select 1 from emp b
                where a.DEPTNO = b.DEPTNO
                and b.sal>=3000); 

select a.*, b.ENAME, b.sal
from dept a join emp b
on a.DEPTNO=b.DEPTNO
and b.sal>=3000;

--emp ���̺��� ��ȸ�Ͽ� ������ �߿��� �ڽ��� job�� ��� ����(sal)���� ���ų� ���� �޴� ������� ��ȸ�Ͻÿ�.
select * from emp a
where sal <=(select avg(sal) from emp b where b.job = a.job);


--Student, exam_01 ���̺��� ������ 90�̻��� �л����� ���� ��ȸ
select * from student s
where exists(
    select 1 from exam_01 e where total>=90 and s.studno=e.studno);

select * from student
where studno in (
    select studno from exam_01 where total>=90);

/*
    �� �������� ��ġ�� �̸�
    ���������� ���� ��ġ�� ���� �� �̸��� �ٸ�
    [1] scalar subquery
        select (subquery)
        - select���� ���� ���������� �� ���� ����� 1�྿ ��ȯ��
        
    [2] inline view
        from (subquery)
        - from ���� ���� ��������
        
    [3] subquery
        where (subquery)
        - where���� ���� ��������
*/

--emp2 ���̺�� dept2 ���̺��� ��ȸ�Ͽ� ������� �̸��� �μ��̸��� ����Ͻÿ�
--join �̿�
select e.NAME, e.PAY, e.position, d.DNAME
from emp2 e left join dept2 d
on e.DEPTNO=d.DCODE;

select e.NAME, e.PAY, e.position, e.deptno,
    (select dname from dept2 d where d.DCODE=e.deptno)
from emp2 e;

select * from emp2;



--employees, departments, �������, �μ��� ��ȸ
select e.FIRST_NAME, e.HIRE_DATE, e.salary, d.DEPARTMENT_NAME
from employees e join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID;  --106

select * from employees; --107

--outer join
select e.FIRST_NAME, e.HIRE_DATE, e.salary, d.DEPARTMENT_NAME
from employees e left join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID
order by d.DEPARTMENT_NAME desc; --107

--scalar subquery�̿�
select e.FIRST_NAME, e.HIRE_DATE, e.salary, e.department_id,
    (select d.DEPARTMENT_NAME 
        from departments d where d.DEPARTMENT_ID=e.department_id) "�μ���"
from employees e
order by DEPARTMENT_id desc; --107
--=> select������ ���������� ����Ϸ��� ���� �������� �߿��� �������̸鼭 
--���� �÷��� ��츸 ������
--(������ ���ڳ� ���ڷ� �ν��� �� �ִ� ��������)

--scalar subquery �� outer ���ΰ� ����
--��������� ��� ����ϰ�, �μ���ȣ�� ���� ��� scalar subquery�� ��ȸ�� �μ�����
--null ���� ��

/*
1.job�� MANAGER�� ����� ��ȸ(emp)
2. job�� Manager�� ��� ����麸�� �Ի����� ����(����) ��� ������ ��ȸ => 
    all �̿� (emp)
3. ALL���� ����� ��� <= MIN�Լ��� �Ἥ
4. sales�μ��� �ٹ��ϴ� ��� ������ ��ȸ(emp, dept)

*/

                                                                