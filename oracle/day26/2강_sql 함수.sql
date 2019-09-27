select id, initcap(id) from student; --���� ù���ڸ� �빮�ڷ�

select 'pretty girl', initcap('pretty girl') from dual; --����ڵ� �빮�ڷ�

select id, initcap(id), upper(id), lower(id)
from student;

select lower('JAVA') from dual;

select * from emp
where ename = 'SCOTT';

select * from emp
where lower(ename) = 'scott';

--length(), lengthb() --���ڿ� ���� ����
--lengthb() ����Ʈ ����
--�ѱ� 1���ڴ� 2~3����Ʈ


select name, id, length(name) "�̸��� ����", lengthb(name) "�̸��� ����Ʈ��", length(id), lengthb(id)
from student;

--contcat('','') - �� ���ڿ� ���� �Լ�. �����̻��� || ��� 

select name || position as "�����̸�",
concat(name, position) "concat �̿�",
name || '-' || position "||������ �̿�"
from professor;

select concat(name, '-', position)
from professor; --error

--substr() ���ڿ����� Ư�� ������ ���ڿ��� ������ �� ���
--substr('���ڿ�', ������ġ, ������ ���ڼ�)
--���ۿ�ġ�� -�� �ϸ� �ڿ������� �Ի�

select substr('abcdefghi', 2,3),
    substr('abcdefghi',6),
    substr('abcdefghi', -5, 2)
from dual;

select substr('java����Ŭ', 5,2),
substr('java����Ŭ',3, 3),
substr('java����Ŭ',6),
substr('java����Ŭ',-3,1)
from dual;

--ĳ���ͼ� Ȯ��
select parameter, value from nls_database_parameters
where parameter like '%CHAR%';

--student ���̺��� JUMIN Į���� ����Ͽ� 1������ 101���� �л����� �̸��� ��������� ���
select name, substr(jumin, 1, 6) as "�������" from student
where deptno1=101;

--student ���̺��� JUMIN Į���� ����Ͽ� �¾ ����8���� ����� �̸��� ��������� ���
--������� ���
select name, substr(jumin, 1, 6) as "�������" from student
where substr(jumin, 4, 1) like '8';

--instr() - �־��� ���ڿ��̳� �÷����� Ư�� ������ ��ġ�� ã���ִ� �Լ�
--instr('���ڿ�', 'ã�±���', ������ġ, ���°����)
--���°�� �⺻���� 1

select 'A*B*C', instr('A*B*C', '*'),
    instr('A*B*C', '*', 3), instr('A*B*C','*',3,2) --3��° ��ġ ���� 2��°�� ������ *��ġ
from dual;
--�̰͵� -<<���ϼ����� ��ġ�� -���̸� �ڿ��� n��°��


--student ���̺��� TEL Į���� ����Ͽ� �л��� �̸��� ��ȭ��ȣ, ')'�� ������ ��ġ�� ���
select name, tel, instr(tel,')')
from student;

--�ǽ� ) student ���̺��� �����ؼ� 1������ 101���� �л��� �̸��� ��ȭ��ȣ�� ������ȣ�� ���. ��, ������ȣ�� ���ڸ� ���;� ��
select name, tel, substr(tel, 1, 3) as "������ȣ"
from student;

select name, substrb(name, 1,3)
from student;

--

select 'c:\test\js\example.txt',
    'd:\css\sample\temp\abc.java' from dual;
    --> ���ϸ� �����غ���
   
select substr('c:\test\js\example.txt',12),
    substr('d:\css\sample\temp\abc.java',20),
    substr('c:\test\js\example.txt',20),
    substr('d:\css\sample\temp\abc.java',24)
     from dual;
     
create table test_file(
    no number,
    filepath varchar2(100)
    );
    
    insert into test_file
    values(1, 'c:\test\js\example.txt');
    
    insert into test_file
    values(2, 'd:\css\sample\temp\abc.java');
    
select * from test_file;

select
substr(filepath, instr(filepath,'\',-1, 1)+1) as "���ϸ�",
substr(filepath, instr(filepath,'.')+1) as "Ȯ���ڸ�"
from test_file;

--student ���̺��� 1������ 101���� �а� �л����� ID�� �� 10�ڸ��� ����ϵ� ���� �� �ڸ��� '$'��ȣ�� ä�켼��
select id, lpad(id, 10, '$')
from student
where deptno1=101;


select dname, lpad(dname, 10, '1'),
lpad(dname, 10, '1234567890')
from dept2;

--student ���̺��� ID�� 12�ڸ��� ����ϵ� ������ �� �ڸ����� '*'��ȣ�� ä�켼��
select id, rpad(id, 12, '*') from student;

--rtrim() �������ش繮�� ����

select ltrim('javaoracle', 'abcdefghijvw'),
ltrim('javaoracle', 'java'),rtrim('javaoracle', 'oracle'),
rtrim('javaoracle', 'abcelmnopqr'),
'|' || ltrim('              javaoracle'),
rtrim('javaoracle              ') || '|'
from dual;


--DEPT2 ���̺��� DNAME�� ����ϵ� ���ʿ� '��'�̶� ���ڸ� ��� �����ϰ� ���
select dname, ltrim(dname, '��')
from dept2;

--DEPT2 ���̺��� DNAME�� ����ϵ� ������ ���� '��'��� ���ڴ� �����ϰ� ���
select dname, rtrim(dname, '��')
from dept2;

--replace('���ڿ�' �Ǵ� �÷���, '����1', '����2')
select replace('javajsp', 'j', 'J'),
replace('javajsp', 'jsp', 'spring') from dual;

--student ���̺��� �л����� �̸��� ����ϵ� �� �κ��� '#'���� ǥ�õǰ� ���
select name, replace(name, substr(name, 1,1), '#')
from student;

--�ǽ�) student ���̺��� 1������ 101���� �л����� �̸��� ����ϵ� ��� ���ڸ� '#'���� ǥ�õǰ� ���
select name, replace(name, substr(name, 2,1), '#')
from student;

--�ǽ�) student ���̺��� 1������ 101���� �л����� �̸��� �ֹι�ȣ�� ����ϵ� �ֹι�ȣ�� �� 7�ڸ��� '*'�� ǥ�õǰ� ���
select name, substr(jumin,7,7), replace(jumin, substr(jumin, 7,7), '*******')
from student;


--�ǽ�) student ���̺��� 1������ 102���� �л����� �̸��� ��ȭ��ȣ, ��ȭ��ȣ���� ���� �κи� '#' ó���Ͽ� ���. ��, ��� ������ 3�ڸ��� ������
select tel, replace(tel,substr(tel, 5,3),'###')
from student
where deptno1=102; 


--[0927]

select 1234.457, trunc(1234.457), trunc(12345.334,1)
from dual;

select first_name, salary, round(salary, -3)
from employees;

select mod(13,4), ceil(12.3), floor(17.85),
power(3,4) from dual;

select sysdate as "��������", sysdate+100 "100�� ��",
sysdate-100 "100����", sysdate+1 "�Ϸ� ��" from dual;

select sysdate, sysdate+2+1/24,--2�� 1�ð� ��
sysdate+2+1/24/(24*60)+10/24*60*60
from dual;

--select sysdate, add_month(sysdate,3)

select sysdate, add_months(sysdate,28) + 1+3/24
from dual;--

select sysdate, sysdate+to_tminterval('02-04') "2�� 4������",
sysdate + to_dsinterval('1 03:10:20') "1�� 3���Ⱓ 10�� 20����"
from dual;

select sysdate -to_date('2019-01-01')  --todate���� '2019-01-01'�� �ϸ� String���� ��޵Ǿ� ������
from dual;

select to_date('2019-09-27') - to_date('2019-09-26') "���ϰ� ����"
from dual;

select sysdate - to_date('2019-09-26') "���ϰ� ����",
to_date('2019-09-28') - sysdate "���ϰ� ����"
from dual;
--> 1���� ���� ���� ����

--�ð��� ������ �� ����¥ ������ ���� ���ϱ�

select sysdatem trunc(sysdate),
to_date('2019-09-28') - trunc(sysdate) "���ϰ� ����"
from dual;

--�� ��¥ ������ ������
--months_between() - �� ��¥ ������ �������� ������
select months_between('2019-09-28', '2018-06-27')
from dual;

select sysdate, next_day(sysdate, '��')
from dual;

--last date
-- �־��� ��¥�� ���� ���� ���� �������� �Ƿ�
select sysdate, last_day(sysdayte)
from dual;

select sysdate, round(sysdate), trunc(sysdate),
round(to_Date('2019-10-01 15:20:45', 'yyyy-mm-dd hh24:mi:ss'))
from dual;

select to_date(hiredate)+90 from emp;
select add_months(hiredate, 12) from emp;
select to_date('2019-12-25') - sysdate from dual;
select months_between('2019-12-25', sysdate) from dual;
select trunc(sysdate) - trunc(hiredate) from emp;
select months_between(sysdate, hiredate) from emp;
select last_day('2016-02-13') from emp;


select 1+'2', 2+'003', '004'
from dual;

select 1+to_number(2), 2+to_number('003') from dual;

select * from student
where birthday>=to_Date('1978-01-01');

--(1-1) to_char(��¥, ����) - ��¥�� ���ڷ� ��ȯ
select sysdate, to_char(sysdate, 'yyyy'),
    to_char(sysdate, 'mm'), to_char(sysdate, 'dd'),
    to_char(sysdate, 'd'), --����ǥ����
    to_char(sysdate, 'year'),
    to_char(sysdate, 'mon'), to_char(sysdate, 'month'),
    to_char(sysdate, 'ddd'), -- 1���� ��ĥ?
    to_char(sysdate, 'day'), --������ �ѱ۷�
    to_char(sysdate, 'dy'), --����(��ȭ��~)
    to_char(sysdate, 'q')--�б�
    from dual;
    
 select sysdate, to_char(sysdate, 'yyyy-mm-dd'),
 to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss d') from dual;
 
 select name, birthday from student
 where to_char(birthday, 'mm')='03';
 
 --(1,2) to_char(����, ����) -���ڸ� ������ ����� ���ڷ� ��Ȳ
 select 1234, to_char(1234,'99999'), to_char(1234, '$999999'),
to_char(1234,'L99999'), to_char(1234.56, '$999999.00')
 from dual;
 
--Professor ���̺��� �����Ͽ� 101�� �а� �������� �̸��� ������ ����Ͻÿ�. �� ������
--(pay*12)+bonus �� ����ϰ� õ ���� ���б�ȣ�� ǥ���Ͻÿ�.

select name, TO_CHAR(pay, '99,999') as "�޿�", TO_CHAR((pay*12)+bonus, '99,999') as "����" from professor
where deptno=101; 

-- to_date(����, ����) - ���ڸ� ��¥�� ��ȯ
select to_date('2019-10-11'),
to_date('2019-09-01','yyyy-mm-dd'),
to_date('2019-09-01','yyyy-mm-dd hh24:mi:ss')
from dual;

select * from professor where hiredate>='1995-01-01'; --�ڵ�����ȯ

select '2019-09-27' - '2019-09-26' from dual; --error

select to_date('2019-09-27') - to_date('2019-09-26') from dual;

--0817~0927������ ������ ��ȸ
select * from pd
where regdate between to_date('2019-08-17') and to_date('2019-09-27')+1
order by regdate; 

select * from pd
where regdate >= to_date('2019-08-17') 
and regdate < to_date('2019-09-27 23:59:59', 'yyyy-mm-dd hh24:mi:ss')
order by regdate; 

--������� �� �ð� ������ ��ȸ
select (sysdate - to_date(regdate))*24 from pd;


--to_number -���ڸ� ���ڷ� ��ȯ
select '10' as "����", 10 as "����1",
to_number('10') as ����2, to_number('003')+20 as ����3,
'005'+30 as ����4
from dual;


--[�ǽ�]Professor ���̺��� ����Ͽ� 1990�� ������ �Ի��� ������� �Ի���,���� ������ 10% �λ� �� ������ ����Ͻÿ�.
--������ �󿩱�(bonus)�� ������ (pay*12)�� ����ϰ� ������ �λ� �� ������
--õ ���� ���� ��ȣ�� �߰��Ͽ� ����Ͻÿ�.

select name, hiredate, TO_CHAR(pay*12, '99,999') as "���翬��", TO_CHAR((pay*12)*1.1, '99,999') as "10% �λ� �� ����" from professor
where hiredate<'1990-01-01';


--Professor ���̺��� 101�� �а� �������� �̸��� �޿�,bonus, ������ ����Ͻÿ�. ��, ������ (pay*12+bonus)�� ���
--�ϰ� bonus�� ���� ������ 0���� ����Ͻÿ�

select name, bonus, hpage, nvl(bonus, 0), nvl(hpage, 'Ȩ�������� ����')
from professor;

select name, pay, bonus, pay*12+bonus, pay*12+nvl(bonus, 0),
nvl(pay*12+bonus, pay*12)
from professor
where deptno=101;


--nvl2(col1, col2, col3) :col1�� null�� �ƴϸ� col2��, null�̸� col3���
select name, bonus, hpage, nvl2(bonus, bonus, 0), nvl2(hpage, hpage, 'Ȩ������ ����')
from professor;

select name, pay, bonus, pay*12+bonus, pay*12+nvl(bonus, 0),
nvl2(bonus, bonus, pay*12)
from professor
where deptno=101;


-- employees ���̺��� ������̵�, �̸� - ��(�� : Steven-King), �Ի���, �⺻��(salary), ? 
--����(salary*commission_pct), �޿�(salary+����) ��ȸ�� �� / �÷� ��Ī���
-- ����(�޿�*12) ��ȸ

select employee_id as "������̵�", first_name|| '-' ||last_name as "�̸�-��", 
hire_date as "�Ի���", salary "�⺻��", salary*nvl(commission_pct, 1) as "����", 
salary+(salary*nvl(commission_pct, 1)) as "�޿�"
from employees
order by "�Ի���", "�⺻��" desc;


--student�ļ� grade�� 1�̸� 1�г� 2�̸� 2�г�, 3�̸�.. �ƹ�ư 4�г����
select name, grade, decode(grade, 1, '1�г�',
                                  2, '2�г�',
                                  3, '3�г�',
                                  4, '4�г�') as "�г�",
                    decode(grade, 1, '1�г�',
                                  2, '2�г�',
                                  3, '3�г�',
                                  4, '4�г�') as "�г�2"
                                  
from student;



--Professor ���̺��� ������, �а���ȣ, �а����� ����ϵ� deptno�� 101���� ������ ��ǻ�� ���а���
--����ϰ� 101���� �ƴ� �������� �а��� �ƹ��͵� ������� ������.



--? Professor ���̺��� ������, �а���ȣ, �а����� ����ϵ� deptno�� 101����
--������ ��ǻ�� ���а��� ����ϰ� 101���� �ƴ� �������� �а��� ����Ÿ�а����� ����ϼ���.
select name, deptno, decode(deptno, 101, '��ǻ�� ���а�', '��Ÿ�а�') "�а�"
from professor;

--Professor ���̺��� ������, �а���������ϵ� deptno�� 101���̸� ����ǻ�� ���а���, 
--102���̸� ����Ƽ�̵�� ���а���, 103���̸� ������Ʈ���� ���а���, �������� ����Ÿ�а����� ����ϼ���.
select name, deptno, decode(deptno, 101, '��ǻ�� ���а�',
                                         102, '��Ƽ�̵�� ���а�',
                                         103, '����Ʈ���� ���а�',
                                         '��Ÿ�а�') "�а�"
from professor;


--Professor ���̺��� ������, �μ���ȣ�� ����ϰ�, deptno�� 101���� �μ��߿��� 
--�̸��� �������� �������� �����±��� �ĺ������ ����ϼ���. �������� null �� ���.
select name, deptno, decode(deptno, 101, decode(name, '������', '���±����ĺ�'))
from professor;


--Professor ���̺��� ������, �μ���ȣ�� ����ϰ�, deptno�� 101���� �μ��߿��� 
--�̸��� �������� �������� ������ �����±��� �ĺ������ ����ϼ���. 101�� �а��� ������ ���� �ܿ��� ���
--���� ���ĺ��ƴԡ��� ����ϰ� 101�� ������ �ƴ� ���� ������ ������ �ǵ���
select name, deptno, decode(deptno, 101, decode(name, '������', '���±����ĺ�', '�ĺ��ƴ�'))
from professor;


--Student ���̺��� ����Ͽ� �� 1����(deptno1)�� 101���� �а� �л����� �̸�(name)�� �ֹι�ȣ(jumin), 
--������ ����ϵ� ������ �ֹι�ȣ Į���� �̿��Ͽ� 7��° ���ڰ� 1�� ��� �����ڡ�, 2�� ��� �����ڡ��� ����ϼ���
select name, jumin, decode(substr(jumin,7,1), 1, '����',
                                              2, '����') "����"
from student;


--Student ���̺��� �� 1����(deptno1)�� 101���� �л����� �̸�(name)��
--��ȭ��ȣ(tel), �������� ����ϼ���. �������� ������ȣ�� 02�� ����, 031�� ���, 
--051�� �λ�,052�� ���, 055�� �泲���� ����ϼ���

select name, tel, decode(substr(tel,1,instr(tel, ')' )-1), '02', '����',
                                          '031', '���',
                                          '051', '�λ�',
                                          '052', '���',
                                          '055', '�泲') "����"
                                          
                                          from student;

select ename, decode(job, 'CLERK', '�繫��',
                   'SALESMAN', '�Ǹſ�',
                   'MANAGER', '������',
                           '��Ÿ') "job"
from emp;

                                            