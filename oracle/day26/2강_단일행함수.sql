--2��_�������Լ�.sql
--[2019-09-26 ��]
/*
�� ������ �Լ� - �ԷµǴ� �������� ������ ����
[1] �����Լ� - �ԷµǴ� ��(�Ű�����)�� ������ �Լ�
[2] �����Լ�
[3] ��¥�Լ�
[4] ����ȯ�Լ�
[5] �Ϲ� �Լ�(��Ÿ�Լ�)
*/
--[1] �����Լ�
--initcap() - ���� ù���ڸ� �빮�ڷ� �ٲ۴�
select id, initcap(id) from student;

select 'pretty girl', initcap('pretty girl') from dual;
--���� ���� ���ڵ� �빮�ڷ� �ٲ���

--upper() : �빮�ڷ� ��ȯ����
--lower() : �ҹ��ڷ� ��ȯ����
select id, initcap(id), upper(id), lower(id)
from student;

select lower('JAVA') from dual;

select * from emp
where ename='SCOTT';

/*select * from emp
where upper(ename)='SCOTT';*/

select * from emp
where lower(ename)='scott'; --

--length(), lengthb() - ���ڿ��� ���̸� �������ִ� �Լ�
--lengthb() - ���ڿ��� ����Ʈ���� ����
--(�ѱ� 1���ڴ� 2����Ʈ�� 3����Ʈ�� ó��)
select name, id, length(name) "�̸��� ����", lengthb(name) "�̸��� ����Ʈ��",
    length(id) "id ����", lengthb(id) "id ����Ʈ��"
from student;    

--concat('','') - �� ���ڿ��� �������ִ� �Լ�
--3�� �̻��� ���ڿ��� �����Ϸ��� || ������ �̿�

select name || position as "���� �̸�",
    concat(name, position) "concat �̿�",
    name || '-' || position "||������ �̿�"
from professor;

select concat(name,'-',position)
from professor;  --error
    
--substr()- ���ڿ����� Ư�� ������ ���ڿ��� ������ �� ���
--substr('���ڿ�',������ġ, ������ ���ڼ�)
--������ġ�� - �� �ϸ� �ڿ������� �ڸ����� �����

select substr('abcdefghi',2,3),
    substr('abcdefghi', 6),
    substr('abcdefghi', -5,2) from dual;
--bcd, fghi, ef
--2��° ��ġ���� 3�� ����
--6��° ��ġ���� ������ ����
--�ڿ��� 5��° ��ġ���� 2�� ����

select substr('java����Ŭ',5,2),
    substr('java����Ŭ',3,3),
    substr('java����Ŭ',6),
    substr('java����Ŭ',-3,1) from dual;
--����, va��, ��Ŭ, ��
    
--ĳ���ͼ� Ȯ��
select parameter, value from nls_database_parameters
where parameter like '%CHAR%';  --AL32UTF8

--student ���̺��� JUMIN Į���� ����Ͽ� 1������ 101���� �л����� 
--�̸��� ��������� ���
select name, jumin, substr(jumin, 1, 6) "�������"
from student
where deptno1=101;

--student ���̺��� JUMIN Į���� ����Ͽ� �¾ ���� 8���� ����� �̸��� 
--��������� ���
select name, jumin, substr(jumin, 1, 6) "�������"
from student
where substr(jumin, 3, 2)='08';

--instr() - �־��� ���ڿ��̳� �÷����� Ư�� ������ ��ġ�� ã���ִ� �Լ�
--instr('���ڿ�','ã�±���',������ġ, ���°����)
--���°�� �⺻���� 1

select 'A*B*C*', instr('A*B*C*','*'),
    instr('A*B*C*', '*',3), instr('A*B*C*','*',3,2)
from dual;
--2, 4, 6
--�տ������� ���� ó�� ������ *�� ��ġ(����Ŭ������ ��ġ���� 1���� ����)
--3��° ��ġ ���Ŀ� ó�� ������ *�� ��ġ
--3��° ��ġ ���Ŀ� 2��°�� ������ *�� ��ġ

select 'A*B*C*', instr('A*B*C*','*',-1),
    instr('A*B*C*','*',-2), instr('A*B*C*','*',-2,2),
    instr('A*B*C*','*',-3,2),instr('A*B*C*','*',-3,4)
from dual;
--6, 4,2,2,0
--�ڿ��� ù��° ��ġ ���� ó�� ������ *�� ��ġ
--�ڿ��� 2��° ��ġ ���� ó�� ������ *�� ��ġ
--�ڿ��� 2��° ��ġ ���� 2��°�� ������ *�� ��ġ
--�ڿ��� 3��° ��ġ ���� 2��°�� ������ *�� ��ġ
--�ڿ��� 3��° ��ġ ���� 4��°�� ������ *�� ��ġ => ������ 0�� ������

--student ���̺��� TEL Į���� ����Ͽ� �л��� �̸��� ��ȭ��ȣ, ')'�� ������ ��ġ�� ���
select name, tel, instr(tel,')')
from student;

--�ǽ� ) student ���̺��� �����ؼ� 1������ 101���� �л��� �̸��� ��ȭ��ȣ�� 
--������ȣ�� ���. ��, ������ȣ�� ���ڸ� ���;� ��
select name, tel, instr(tel,')'), 
    substr(tel, 1, instr(tel,')')-1) ������ȣ
from student
where deptno1=101;

--substrb() - �Ϻ� ���ڿ��� ����Ʈ���� ����
select name, substr(name,1,1), substrb(name,1,3),
    substr(name,1,2), substrb(name,1,6)
from student;

--
select 'c:\test\js\example.txt',
    'd:\css\sample\temp\abc.java' from dual;
--=> ���� ����  c:\test\js, d:\css\sample\temp
--���ϸ� ���� example.txt, abc.java
--Ȯ���ڸ� ���� txt, java
--���� ���ϸ� ����  example, abc

create table test_file(
    no  number,
    filepath    varchar2(100)
);

insert into test_file
values(1, 'c:\test\js\example.txt');

insert into test_file
values(2, 'd:\css\sample\temp\abc.java');

select * from test_file;

--1234567890123456789012345
--c:\test\js\example.txt

--1) ���ϸ� ���� => example.txt, abc.java
select filepath, instr(filepath, '\',-1), 
    substr(filepath, instr(filepath, '\',-1)+1)
 from test_file;

--2) Ȯ���ڸ� ����=> txt, java
select filepath, instr(filepath, '.',-1), 
    substr(filepath, instr(filepath, '.',-1)+1)
 from test_file;

--3) ���� ����=> c:\test\js, d:\css\sample\temp
select filepath, instr(filepath, '\',-1), 
    substr(filepath, 1, 
        instr(filepath, '\',-1)-1)
 from test_file;

--4) ���� ���ϸ� ����=> example, abc
select filepath, instr(filepath, '.',-1), instr(filepath, '\',-1), 
    substr(filepath, instr(filepath, '\',-1)+1, 
        instr(filepath, '.',-1)-instr(filepath, '\',-1)-1)
 from test_file;

--LPAD('���ڿ�' �Ǵ� �÷���, �ڸ���, 'ä�﹮��')
--���ڿ��� ���� �ڸ����� ä�﹮�ڷ� ä���. ���ʺ��� ä����
--RPAD() - �����ʺ��� ä����
 
--student ���̺��� 1������ 101���� �а� �л����� ID�� �� 10�ڸ��� ����ϵ� 
--���� �� �ڸ��� '$'��ȣ�� ä�켼��
select id, lpad(id, 10, '$')
from student
where deptno1=101;

--�ǽ�) DEPT2 ���̺��� ����Ͽ� DNAME�� ���� ����� �������� ���� �ۼ��ϱ�
--dname�� �� 10����Ʈ�� ����ϵ� ���� dname�� ������ ������ �� �ڸ��� �ش� �ڸ��� 
--���ڰ� ������ ��. ��, ������� �̸��� �� 6����Ʈ�̹Ƿ� ���ڰ� 1234���� ����
select dname, lpad(dname, 10, '1'),
    lpad(dname, 10, '1234567890')
from dept2;

--student ���̺��� ID�� 12�ڸ��� ����ϵ� ������ �� �ڸ����� '*'��ȣ�� ä�켼��
select id, rpad(id, 12, '*')
from student;

--ltrim('���ڿ�' �Ǵ� �÷���, '������ ����')
--���ʿ��� �ش� ���ڸ� �����Ѵ�
--������ ���ڸ� �����ϸ� ������ �����Ѵ�.

--rtrim() - �����ʿ��� �ش� ���ڸ� �����Ѵ�

select ltrim('javaoracle', 'abcdefghijvw'),
    ltrim('javaoracle', 'java'), rtrim('javaoracle','oracle'),
    rtrim('javaoracle', 'abcelmnopqr'),
    '|' || ltrim('       javaoracle'),
    rtrim('javaoracle    ') || '|'
from dual; 
--oracle, oracle, jav, java

--DEPT2 ���̺��� DNAME�� ����ϵ� ���ʿ� '��'�̶� ���ڸ� ��� �����ϰ� ���
select dname, ltrim(dname, '��')
from dept2;

--DEPT2 ���̺��� DNAME�� ����ϵ� ������ ���� '��'��� ���ڴ� �����ϰ� ���
select dname, rtrim(dname, '��')
from dept2;

--replace('���ڿ�' �Ǵ� �÷���, '����1','����2')
--���ڿ����� ����1�� ������ ����2�� �ٲپ� ����ϴ� �Լ�
select replace('javajsp','j','J'),
    replace('javajsp','jsp','spring') from dual;
    
--student ���̺��� �л����� �̸��� ����ϵ� �� �κ��� '#'���� ǥ�õǰ� ���
select name, replace(name, '��', '#'), substr(name, 1,1),
    replace(name,  substr(name, 1,1), '#')
from student;   

--�ǽ�) student ���̺��� 1������ 101���� �л����� �̸��� ����ϵ� ��� ���ڸ� '#'���� ǥ�õǰ� ���
--�ǽ�) student ���̺��� 1������ 101���� �л����� �̸��� �ֹι�ȣ�� ����ϵ� 
--�ֹι�ȣ�� �� 7�ڸ��� '*'�� ǥ�õǰ� ���
--�ǽ�) student ���̺��� 1������ 102���� �л����� �̸��� ��ȭ��ȣ, ��ȭ��ȣ���� 
--���� �κи� '#' ó���Ͽ� ���. ��, ��� ������ 3�ڸ��� ������

select replace(name, substr(name, 2, 1), '#') as "replace"
from student
where deptno1 = 101;

select name, replace(jumin, substr(jumin,  7, 7), '*******') as "replace2"
from student
where deptno1 = 102;

select name, tel, replace(tel, substr(tel, instr(tel, ')')+1, 3), '###') as "replace3"
from student
where deptno1 = 102;

--[2019-09-27 ��]
--[2] �����Լ�
--round(����, ���ϴ� �ڸ���) - �ݿø�
select 12345.457, round(12345.457), round(12345.457, 1),
    round(12345.457, 2),
    round(12345.457, -1), round(12345.457, -2),
    round(12345.457, -3)
from dual;
--12345, 12345.5, 12345.46, 12350, 12300, 12000
/*
    �ڸ����� �� �ذ�� : ������ �ݿø�(�Ҽ����� 1° �ڸ����� �ݿø�)
    1: �Ҽ����� 1�ڸ��� ����� (�Ҽ����� 2° �ڸ����� �ݿø�)
    2: �Ҽ����� 2�ڸ��� �����
    -1: 1�� �ڸ����� �ݿø�(�ڸ����� ������ ��쿡�� �Ҽ� �̻󿡼� ó��)
    -2: 10�� �ڸ����� �ݿø�
    -3: 100�� �ڸ����� �ݿø�
*/

--trunc(����, ���ϴ� �ڸ���) - ����
select 12345.457, trunc(12345.457), trunc(12345.457, 1),
    trunc(12345.457, 2),
    trunc(12345.457, -1), trunc(12345.457, -2),
    trunc(12345.457, -3)
from dual;
--12345.457, 12345, 12345.4, 12345.45, 12340, 12300, 12000

--employees���� salary�� 100�� �ڸ����� �ݿø�, ����
select first_name, salary, round(salary, -3) �ݿø�, 
    trunc(salary, -3) "����"
from employees;

--mod(����, ������ ��) - �������� ���ϴ� �Լ�
--ceil(�Ҽ����� �ִ� �Ǽ�) - �ø�(�־��� ���ڿ� ���� ������ ū ���� ���)
--floor(�Ǽ�) - ����(���� ������ ���� ����)
--power(����1, ����2) - ����1�� ����2�� (������)
select mod(13,3), ceil(12.3), floor(17.85),
    power(3,4) from dual;
--1,13,17,81

--[3] ��¥ �Լ�
--sysdate : �������ڿ� �ð��� �����ϴ� �Լ�
select sysdate from dual;

--��ĥ ��/��ĥ ��, �� ��¥ ������ ����� �ϼ� 

--1) ��ĥ ��, ��ĥ ��
/*
���ú��� 100�� ��, 100����
2019-09-27 + 100 => ��¥
2019-09-27 - 100 => ��¥

=> ���ϰ� ���� ������ �ϼ�
*/

select sysdate as "���� ����", sysdate+100 "100�� ��",
    sysdate-100 "100�� ��",
    sysdate+1 "�Ϸ� ��", sysdate-1 "�Ϸ� ��" from dual;

--2�� 1�ð� 5�� 10�� �� ��¥ ���ϱ�
select sysdate, sysdate+2+1/24+5/(24*60)+10/(24*60*60) 
from dual;

--3���� ��, 3���� �� ��¥ ���ϱ�
--add_months(��¥, ������) : �ش� ��¥�κ��� ��������ŭ ���ϰų� �� ��¥�� ���Ѵ�
--=> �� ������, �� �������� �ش��ϴ� ��¥�� ���� �� �ִ�
select sysdate, add_months(sysdate,3) as "3���� ��",
    add_months(sysdate,-3) as "3���� ��"
from dual;

--1�� ��, 1�� �� ��¥
select sysdate, add_months(sysdate, 12) "1�� ��", 
    add_months(sysdate, -12) "1�� ��"
from dual;

--2�� 4���� 1�� 3�ð� 10�� 20�� ���� ��¥ ���ϱ�
select sysdate, 
    add_months(sysdate, 28) + 1+3/24+10/(24*30)+20/(24*60*60)
    as "2�� 4���� 1�� 3:10:20 ��"
from dual;

--to_yminterval() : ��/�� interval
--to_dsinterval() : ��/�ú��� interval

select sysdate, sysdate + to_yminterval('02-04') "2�� 4���� ��",
    sysdate + to_dsinterval('1 03:10:20') "1�� 3�ð� 10�� 20�� ��",
    sysdate + to_yminterval('02-04')+ to_dsinterval('1 03:10:20')
    as "2�� 4���� 1�� 3:10:20 ��"
from dual;

--2) �� ��¥ ������ ����� �ð�(�ϼ�)
--���� 1�� 1�Ϻ��� ��ĥ ����Ǿ�����
--2019-09-27 - 2019-01-01 => ����

select sysdate - '2019-01-01'  
from dual;  --error

select sysdate - to_date('2019-01-01')   
from dual;  --��¥�� ��ȯ�ؼ� ó���ؾ� ��
--to_date(����) => ���ڸ� ��¥ ���·� ��ȯ���ִ� �Լ�

--�������� ���ñ��� ����� �ϼ�, ���ú��� ���ϱ��� ���� �ϼ�
select to_date('2019-09-27') - to_date('2019-09-26') "������ ����",
    to_date('2019-09-28') - to_date('2019-09-27') "���ϰ� ����"
from dual;

select sysdate - to_date('2019-09-26') "������ ����",
    to_date('2019-09-28') - sysdate "���ϰ� ����"
from dual;
--=> to_date('2019-09-28') => 2019-09-28 00:00:00 - ���糯¥�� �ú���
--=> 1���� ���� ���� ����

--�ð��� ������ �� ��¥ ������ ���� ���ϴ� ���
select sysdate, trunc(sysdate),
    to_date('2019-09-28') - trunc(sysdate) "���ϰ� ����"
from dual;

--�� ��¥ ������ ������
--months_between() - �� ��¥ ������ �������� ������
select months_between('2019-09-27', '2019-06-27') from dual;
select months_between(sysdate, '2019-06-27') from dual;
select months_between('2019-09-27', '2019-06-01') from dual;
select months_between('2019-09-27', '2019-06-30') from dual;

--next_day() �Լ�
/*
  �־��� ��¥�� �������� ���ƿ��� ���� �ֱ� ������ ��¥�� ��ȯ
  ���ϸ� ��� ���ڸ� �Է��� ���� �ִ�
  1:�� 2:��...7:��  
*/
select sysdate, next_day(sysdate, '��'),
    next_day(sysdate,'ȭ����'),
    next_day(sysdate,1),
    next_day('2019-10-20','��')
from dual;

--last_day() �Լ�
--�־��� ��¥�� ���� ���� ���� ������ ���� ����
select sysdate, last_day(sysdate),
    last_day('2019-10-17'), last_day('2019-02-23'),
    last_day('2020-02-05') from dual;
    
--round() - ���� �������� �� �������� ���� ��¥�� �����ϰ�, �� ���Ŀ��� 
--�� ���� ��¥�� ������

--trunc() - ������ ���� ��¥�� ������
--=> ��� �ð��� ���ܵ�
select sysdate, round(sysdate), trunc(sysdate),
    round(to_Date('2019-10-01 15:20:45', 'yyyy-mm-dd hh24:mi:ss'))
from dual;    


--emp���̺��� ����� �Ի��� 90�� ���� ��¥?
select ename, hiredate, hiredate+90 from emp; 

--emp���̺��� ����� �Ի��� 1���� �Ǵ� ��¥?
select ename,hiredate,add_months(hiredate,12) from emp;

--?���ú��� ũ������������ ���� �ϼ���?
select to_date('2019-12-25') - sysdate from dual;
select to_date('2019-12-25') - trunc(sysdate) from dual;

--���ú��� ũ������������ ���� �޼���? (months_between)
select months_between('2019-12-25',sysdate) from dual;

--emp���̺��� �Ի����� ���ñ��� ���� �Ǿ���?
select ename,hiredate,sysdate - hiredate from emp;
?
--emp���̺��� �Ի����� ���ñ��� ��� �Ǿ���?
select ename,hiredate, months_between(sysdate, hiredate) from emp;
?
--emp���̺��� �Ի����� ���ñ��� �� ���� �Ǿ���?
select ename,hiredate,months_between(sysdate,hiredate) /12 from emp;


--���� ��¥�� �ش��ϴ� ���� ������ ��¥��? (last_day)
select last_day(sysdate) from dual;

--?2016-02-13�� �ش��ϴ� ���� ������ ��¥��?
select last_day('2016-02-13') from dual; 

--[4] ����ȯ �Լ�
/*
�� ����Ŭ�� �ڷ���
1) ���� - char(���� ������), varchar2(���� ������)
2) ���� - number
3) ��¥ - date

�� ����ȯ
1) �ڵ� ����ȯ
2) ����� ����ȯ
to_char() : ����, ��¥�� ���ڷ� ��ȯ
to_number() : ���ڸ� ���ڷ�
to_date() : ���ڸ� ��¥��
*/

--�ڵ� ����ȯ
select 1+'2', 2+'003', '004'
from dual;
--=> ���������� ���ڸ� �����ϸ� �ش� ���ڸ� ���ڷ� �ڵ� ����ȯ�� �� ������
    
select 1+to_number(2), 2+to_number('003') from dual;

select * from student
where birthday>='1978-01-01';

select * from student
where birthday>=to_Date('1978-01-01');

--(1-1) to_char(��¥, ����) - ��¥�� ���ڷ� ��ȯ�Ѵ�
select sysdate, to_char(sysdate, 'yyyy'),
    to_char(sysdate, 'mm'), to_char(sysdate, 'dd'),
    to_char(sysdate, 'd'),  --���� (1:��, 2:��...7:��)
    to_char(sysdate, 'year'),
    to_char(sysdate, 'mon'), to_char(sysdate, 'month'),
    to_char(sysdate, 'ddd'), --1�� �� ��ĥ���� 
    to_char(sysdate, 'day'), --������ �ѱ۷�(������, ȭ����...)
    to_char(sysdate, 'dy'), --����(��,ȭ,��)
    to_char(sysdate, 'q') --�б�
from dual;

select extract(year from sysdate) "�⵵",
    extract(month from sysdate) "��",
    extract(day from sysdate) "��" from dual;
    
select sysdate, to_char(sysdate, 'yyyy-mm-dd'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss am'),
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss pm day'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss d')
from dual;    

select * from nls_session_parameters;

--�ǽ�) STUDENT ���̺��� birthday Į���� �����Ͽ� ������ 3���� �л��� �̸���
-- birthday�� ���
select name, birthday from student
where to_char(birthday, 'MM') ='03';

select name, birthday from student
where extract(month from birthday) =3;

--(1-2) to_char(����, ����) - ���ڸ� ������ ����� ���ڷ� ��ȯ
/*
9 : ���� �ڸ��� �������� ä��
0 : ���� �ڸ��� 0���� ä��
*/
select 1234, to_char(1234, '99999'),
    to_char(1234, '099999'), to_char(1234, '$99999'),
    to_char(1234, 'L99999'), to_char(1234.56, '9999.9'),
    to_char(1234, '99999.99'), to_char(1234, '99999.00'),
    to_char(1234, '99,999'),
    to_char(123456789, '999,999,999'),
    to_char(1234.56, '9999')
from dual;

--Professor ���̺��� �����Ͽ� 101�� �а� �������� �̸��� pay, ������ ����Ͻÿ�. 
--�� ������ (pay*12)+bonus �� ����ϰ� õ ���� ���б�ȣ�� ǥ���Ͻÿ�.
select * from professor;

select to_char(pay*12+bonus,'999,999') as "����", 
to_char(pay,'99,999') �޿�, pay, bonus, name from professor;

--(2) to_date(����, ����) - ���ڸ� ��¥�� ��ȯ
select to_date('2019-10-11'), 
    to_date('2019-09-01', 'yyyy-mm-dd'),
    to_date('2019-09-20 16:03:50', 'yyyy-mm-dd hh24:mi:ss')
from dual; 

select * from professor where hiredate>='1995-01-01';  --�ڵ�����ȯ

select '2019-09-27' - '2019-09-26' from dual;  --error

select to_date('2019-09-27') - to_date('2019-09-26') from dual;

--9/07 ~ 9/27 ������ ������ ��ȸ
select * from pd order by regdate;

select * from pd 
where regdate >= '2019-09-07' 
and regdate < '2019-09-27'
order by regdate; --2019-09-27 00:00:00 �����̹Ƿ�
--9/27 ��¥�� �����Ͱ� ��ȸ���� ����

--=> �Ϸ� ���� ��¥���� ���� �����͸� ��ȸ�ϰų�
select * from pd 
where regdate >= '2019-09-07' 
and regdate < to_date('2019-09-27')+1
order by regdate;
/*
select * from pd 
where regdate between '2019-09-07' 
    and to_date('2019-09-27')+1
order by regdate;*/

--�����Ͽ� 23:59:59 �� �����ؼ� ��ȸ
select * from pd 
where regdate >= '2019-09-07' 
and regdate < to_date('2019-09-27 23:59:59', 'yyyy-mm-dd hh24:mi:ss')
order by regdate;

--������� �� �ð��� �������� ��ȸ
select no, pdname, regdate,
    sysdate-regdate "����� �ϼ�",
    (sysdate-regdate)*24 "����� �ð�"
from pd;

--(3) to_number(����) - ���ڸ� ���ڷ� ��ȯ
select '10' as "����", 10 as "����1",
    to_number('10') as ����2, to_number('003')+20 as ����3,
    '005'+30 as ����4
from dual;    

--[�ǽ�]Professor ���̺��� ����Ͽ� 1990�� ������ �Ի��� ������� �Ի���, 
--���� ������ 10% �λ� �� ������ ����Ͻÿ�.
--������ �󿩱�(bonus)�� ������ (pay*12)�� ����ϰ� ������ �λ� �� ������ 
--õ ���� ���� ��ȣ�� �߰��Ͽ� ����Ͻÿ�.

select name, hiredate as "�Ի���", 
to_char(pay*12, '99,999') as "����", 
to_char(pay*12*1.1, '99,999') as "10% �λ� �� ����" 
from professor
where hiredate < '1990-01-01';

--[5] �Ϲ��Լ�
--nvl(�÷�, ġȯ�� ��) - �ش� �÷��� null�̸� ġȯ�� ������ �ٲٴ� �Լ�

select name, bonus, hpage, nvl(bonus, 0), nvl(hpage, 'Ȩ������ ����')
from professor;

--Professor ���̺��� 101�� �а� �������� �̸��� �޿�, bonus, ������ ����Ͻÿ�. 
--��, ������ (pay*12+bonus)�� ����ϰ� bonus�� ���� ������ 0���� ����Ͻÿ�.
select name, pay, bonus, pay*12+bonus, 
    pay*12+nvl(bonus,0), 
    nvl(pay*12+bonus, pay*12)
from professor
where deptno=101;

--nvl2(col1, col2, col3) : col1�� null�� �ƴϸ� col2�� null�̸� col3�� ���
select name, bonus, hpage, 
    nvl2(bonus, bonus, 0), nvl2(hpage, hpage,'Ȩ������ ����') 
from professor;

select name, pay, bonus, pay*12+bonus, 
    pay*12+nvl(bonus,0), 
    nvl(pay*12+bonus, pay*12),
    nvl2(bonus, pay*12+bonus, pay*12)
from professor
where deptno=101;

--employees ���̺��� ������̵�, �̸� - ��(�� : Steven-King), �Ի���, 
--�⺻��(salary), 
--����(salary*commission_pct), �޿�(salary+����),
--����(�޿�*12) ��ȸ�ϱ�
--��� �÷��� ��Ī�� ����Ѵ�
--nvl, nvl2 �̿� - null�� ��쵵 ���ǵ���

select employee_id, first_name || '-' || last_name �̸�, hire_date, 
    salary,   commission_pct,  
    salary*nvl(commission_pct,0) ����, 
    nvl(salary+salary*commission_pct, salary) �޿�, 
    (salary+salary*commission_pct)*12 ����,
    (salary+salary*nvl(commission_pct,0))*12 ����,
    nvl((salary+salary*commission_pct)*12, salary*12) ����,
    nvl2(commission_pct,(salary+salary*commission_pct)*12,salary*12) ���� 
from employees;

--decode() �Լ�
/*
- if���� ����ϴ� �Լ�

  decode(A, B, ��, ����) 
  - A�� B�� ������ ���� ó���ϰ�, �׷��� ������ ������ ó���Ѵ�
*/

--student���� grade�� 1�̸� 1�г�, 2�̸� 2�г�, 3�̸� 3�г�, 4�̸� 4�г� ���
select name, grade, decode(grade, 1, '1�г�',
                                  2, '2�г�',
                                  3, '3�г�',
                                  4, '4�г�') as "�г�",
                    decode(grade, 1, '1�г�',
                                  2, '2�г�',
                                  3, '3�г�',
                                     '4�г�') as "�г�2"                                  
from student;

--Professor ���̺��� ������, �а���ȣ, �а����� ����ϵ� deptno�� 
--101���� ������ ��ǻ�� ���а��� ����ϰ� 101���� �ƴ� �������� �а��� �ƹ��͵� 
--������� ������.
select name, deptno, decode(deptno, 101, '��ǻ�� ���а�') �а� 
from professor;

--Professor ���̺��� ������, �а���ȣ, �а����� ����ϵ� deptno�� 101���� ������ 
--��ǻ�� ���а��� ����ϰ� 101���� �ƴ� �������� �а��� ����Ÿ�а����� ����ϼ���.
select name, deptno, decode(deptno, 101, '��ǻ�� ���а�', '��Ÿ�а�') "�а�"
from professor;

--Professor ���̺��� ������, �а����� ����ϵ� deptno�� 101���̸� ����ǻ�� ���а���, 
--102���̸� ����Ƽ�̵�� ���а���, 103���̸� ������Ʈ���� ���а���, �������� ����Ÿ�а����� ����ϼ���.
select name, deptno, decode(deptno, 101, '��ǻ�� ���а�',
                                    102, '��Ƽ�̵��',
                                    103, '����Ʈ����',
                                         '��Ÿ�а�') 
from professor;

--Professor ���̺��� ������, �μ���ȣ�� ����ϰ�, deptno�� 101���� �μ� �߿��� 
--�̸��� �������� �������� �����±��� �ĺ������ ����ϼ���. �������� null �� ���.
select name, deptno, decode(deptno, 101, decode(name,'������','���±����ĺ�'))
from professor;

--Professor ���̺��� ������, �μ���ȣ�� ����ϰ�, deptno�� 101���� �μ� �߿��� 
--�̸��� �������� �������� ������ �����±��� �ĺ������ ����ϼ���. 
--101�� �а��� ������ ���� �ܿ��� ������ ���ĺ��ƴԡ��� ����ϰ� 
--101�� ������ �ƴ� ���� ������ ������ �ǵ��� ���.
select name, deptno, 
    decode(deptno, 101, decode(name, '������','���±����ĺ�','�ĺ��ƴ�'))
from professor;

/*
CLERK - �繫��
SALESMAN - �Ǹſ�
MANAGER-������
�� �̿� - ��Ÿ
*/
select * from emp; --job

select ename, job, 
    decode(job,'CLERK','�繫��','SALESMAN','�Ǹſ�', 'MANAGER','������','��Ÿ')
    "����"
from emp;

--Student ���̺��� ����Ͽ� �� 1����(deptno1)�� 101���� �а� �л����� �̸�(name)�� 
--�ֹι�ȣ(jumin), ������ ����ϵ� ������ �ֹι�ȣ Į���� �̿��Ͽ� 7��° ���ڰ� 
--1�� ��� �����ڡ�, 2�� ��� �����ڡ��� ����ϼ���
select * from student;

select name, jumin, 
DECODE(SUBSTR(jumin, 7, 1), '1','����','2','����') "����"
from student
where deptno1=101;

select name, jumin, 
DECODE(SUBSTR(jumin, 7, 1), '1','����', '3','����','����') "����"
from student
where deptno1=101;

--Student ���̺��� �� 1����(deptno1)�� 101���� �л����� �̸�(name)�� ��ȭ��ȣ(tel),
--�������� ����ϼ���. �������� ������ȣ�� 02�� ����, 031�� ���, 051�� �λ�,
--052�� ���, 055�� �泲���� ����ϼ���

select name, tel, 
    DECODE(SUBSTR(tel, 1, INSTR(tel, ')')-1), '02', '����',
	'031', '���', '051','�λ�','052','���','055','�泲') "������"
from student
where deptno1=101;

--[2019-09-30 ��]
--���� ���
select sysdate, to_char(sysdate, 'd'),
    decode(to_char(sysdate, 'd'), 1,'��',2,'��',3,'ȭ',4,'��',5,'��',
                                  6,'��',7,'��') ����
from dual;

--case�Լ� - if���� ����ϴ� �Լ�, ������ �������� ���� ���� ��� ����
/*
[1] ���ϰ� �񱳽� (= �� ���ϴ� ���)
    case ���� when ���1 then ���1
             when ���1 then ���2
             else ���3
             end "��Ī"
[2] ������ �񱳽�
    case when ����1 then ���1
         when ����2 then ���2
         else ���3
         end "��Ī"
*/
--�г� ����ϱ�
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

--����
select sysdate, to_char(sysdate, 'd'),
    case to_char(sysdate, 'd') when '1' then '��'
                               when '2' then '��'
                               when '3' then 'ȭ'
                               when '4' then '��'
                               when '5' then '��'
                               when '6' then '��'
                               else '��'
                               end "����"
from dual;

--Student ���̺��� �л����� �̸��� ��ȭ��ȣ, �������� ����ϼ���. 
--��, ������ȣ�� 02�� ����, 031�� ���, 051�� �λ�,052�� ���, 055�� �泲, 
--�������� ��Ÿ�� ����ϼ���
select name, tel, substr(tel, 1, instr(tel, ')')-1),
    case substr(tel, 1, instr(tel, ')')-1) when '02' then '����'
                                           when '031' then '���'
                                           when '051' then '�λ�'
                                           when '052' then '���'
                                           when '055' then '�泲'
                                           else '��Ÿ'
                                           end "������ȣ"                                            
from student;

--������
--professor���� pay�� 400�ʰ�, 300~400����, 300�̸����� ����
select name, pay,
    case when pay>400 then '400�ʰ�'
         when pay between 300 and 400 then '300~400����'
         else '300�̸�'
    end "�޿�����"
from professor;

--Student ���̺��� JUMIN Į���� �����Ͽ� �л����� �̸��� �¾ ��, �б⸦ ����ϼ���. 
--�¾ ���� 01~03���� 1/4�б�, 04~06���� 2/4�б�, 07~09���� 3/4�б�, 
--10~12���� 4/4�б�� ����ϼ���
select name,jumin, substr(jumin, 3, 2) "�¾ ��", 
    case when substr(jumin, 3, 2) between '01' and '03' then '1/4�б�'
         when substr(jumin, 3, 2) between '04' and '06' then '2/4�б�'
         when substr(jumin, 3, 2) between '07' and '09' then '3/4�б�'
         else '4/4�б�'
    end "�б�"     
from student;

--gogak, ����
select gname, jumin, substr(jumin, 7,1),
    case when substr(jumin, 7,1) in ('1','3') then '��'
         else '��'
    end "����"     
from gogak;

--exam_01, total�� �̿��� ���� ���ϱ�
--90�̻��̸� A, 80�̻��̸� B, 70�̻��̸� C, 60�̻��̸� D, �������� F
--decode(), case �̿�
select studno, total, total/10, trunc(total/10), trunc(total,-1),
    decode(trunc(total/10), 10, 'A', 9,'A',8,'B',7,'C',6,'D','F')
    "����",
    case trunc(total,-1) when 100 then 'A'
                         when 90 then 'A'
                         when 80 then 'B'
                         when 70 then 'C'
                         when 60 then 'D'
                         else 'F'
                         end "����"
from exam_01;

--gogak, ���� ���ϱ�
select gname, jumin, sysdate, extract(year from sysdate),
    to_char(sysdate, 'yyyy'), substr(jumin, 1, 2),
    case when substr(jumin, 7, 1) in ('1','2') then 1900 else 2000 end,
    to_char(sysdate, 'yyyy')
    - (substr(jumin, 1, 2)+case when substr(jumin, 7, 1) in ('1','2') 
                                     then 1900 else 2000 end)+1 as "����"
from gogak;

--�ſ� ������ ���޳�, ���޳��� ������̸� ������ �ݿ��Ͽ�
--�Ͽ����̸� �������� �ݿ��Ͽ� ������ �޴´�
--���޳� ���ϱ�
select sysdate, last_day(sysdate), to_char(last_day(sysdate), 'd'),
    decode(to_char(last_day(sysdate), 'd'), '7', last_day(sysdate)-1, 
                                            '1', last_day(sysdate)-2,
                                                 last_day(sysdate)) "���޳�"
from dual;

select last_day('2019-11-02'), to_char(last_day('2019-11-02'), 'd'),
    decode(to_char(last_day('2019-11-02'), 'd'), 
                        '7', last_day('2019-11-02')-1, 
                        '1', last_day('2019-11-02')-2,
                             last_day('2019-11-02')) "���޳�"
from dual;

select last_day('2019-06-13'), to_char(last_day('2019-06-13'), 'd'),
    decode(to_char(last_day('2019-06-13'), 'd'), 
                        '7', last_day('2019-06-13')-1, 
                        '1', last_day('2019-06-13')-2,
                             last_day('2019-06-13')) "���޳�"
from dual;


--�ǽ� ? Professor ���̺��� ��ȸ�Ͽ� ������ �޿��׼�(pay)�� �������� 200 �̸��� 4��, 
--201~300�� 3��, 301~400�� 2��, 401 �̻��� 1������ ǥ���Ͽ� ������ ��ȣ(profno), 
--�����̸�(name), �޿�(pay), ����� ����ϼ���. ��, pay Į���� ������������ �����ϼ���.
select profno, name, pay,
	CASE WHEN pay<200 THEN '4��'
		  WHEN pay BETWEEN 201 AND 300 THEN  '3��'
		  WHEN pay BETWEEN 301 AND 400 THEN '2��'
		ELSE '1��'
	END "���"
from professor order by pay desc;

--emp ���̺��� sal �� 2000 ���� ũ�� ���ʽ��� 1000, 1000���� ũ�� 500, 
--�������� 0 ���� ǥ���ϼ���
select ename, sal, 
    case when sal>2000 then 1000
        when sal>1000 then 500
        else 0
    end as "bonus"
from emp;

--emp���� job�� clerk�̸� �繫��, manager�̸� ������, salesman �̸� �Ǹſ�
--�������� ��Ÿ�� ǥ��
select ename, job, 
    case job when 'CLERK' then '�繫��'
             when 'SALESMAN' then '�Ǹſ�'
             when 'MANAGER' then '������'
             else '��Ÿ'
             end "����"    
from emp;

--decode
select ename, job, 
    decode(job,'CLERK','�繫��','SALESMAN','�Ǹſ�', 'MANAGER','������','��Ÿ')
    "����"
from emp;