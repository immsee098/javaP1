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