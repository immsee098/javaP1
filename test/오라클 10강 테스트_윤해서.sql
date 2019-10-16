--[ ����Ŭ 10 �� ]
--(1) 1, 2, 3 ����ȭ�� ���� �����Ͻÿ�.
-- �������� �ߺ� �������� ���� �߻��� �� �ִ� �� ȿ������ �������� �ϰ����� ������ ������ �ذ�

--(2) panmae ���̺��� ����Ͽ� �Ǹų����� ����ϵ� �Ǹ�����, �Ǹŷ�, ���� �Ǹŷ��� ����Ͻÿ�.
--�Ǹ� ���ں��� �����Ͽ� ������ ��
select * from panmae;


--(3) ��ǰ�� �԰�Ǹ� ��� ���̺��� �ڵ����� �ش� ��ǰ�� ��� ������ �ݾ��� �����Ǵ� Ʈ���Ÿ� �ۼ��Ͻÿ�.


--(4) emp2 ���̺��� ����Ͽ� ���, �̸�, �޿�, �μ���ȣ, �μ��� �޿������� ��ȸ�Ͻÿ�
select * from emp
order by empno, sal;


--(5) �а�(deptno1)�� 101���̰� 3�г�(grade) �̻��� �л��� �̸�(name), ���̵�(id), �г�(grade) ������ ��������.
select * from student
where deptno1=101 and grade>=3;
 
--(6)�������̺��� �޿�(pay)�� 300���� 400������ ������ �̸�(name), ���̵�(id), �޿�(pay) ������ ��������
select * from professor
where pay>300 and pay<400;
 
--(7)���� ���̺��� ����(position)�� ���Ӱ���, �������� �̸�(name), ���̵�(id), ����(position), �޿�(pay) �����Ͱ�������
select * from professor
where position='���Ӱ���';
 
--(8) ���� ���̺��� bonus�� ���� �ʴ� ������ �̸�(name), ���̵�(id), ����(position)������ ��������
select * from professor
where bonus is not null;

--(9) pd ���̺��� �����(regdate) ��  2019-03-07 ~ 2019-03-27 �� ������ �����͸� ��ȸ�ϱ�
--to_date �Լ� �̿��ϱ�
select * from pd;


--(10)�л����̺��� �а�(deptno1)���� �л��� ���Ű ���ϱ�
--���Ű�� �Ҽ� ���� ���ڸ��� �������� �ݿø��Ѵ�(round �Լ� �̿�)
select deptno1, round(avg(height), 1)
from student
group by deptno1
order by deptno1;



--(11) �л� �̸��� '��'�� �� �л����� �̸�(name), �г�(grade), �ֹι�ȣ(jumin), ��ȭ��ȣ(tel), ��米����(name) ������ ��������
--student , professor ���̺� ���� (inner join �̿�)

select * from student
where name like '%��%';


--(12) �������  �а�(deptno1)�� ���� �л����� �й�(studno), �̸�(name), �г�(grade), �а���ȣ(deptno1)�� ��ȸ�ϵ� �̸�(name)�� ������������ ��ȸ
--���� ���� �̿� 
select studno, name, grade, deptno1 from student
where deptno1=(select deptno1 from student where name = '�����')
order by name desc;


--(13) �� ����� (���̸� : v_student)
--�л��� �̸�(name), �г�(grade), ��米����(name),�а���(dname) �����͸� ��ȸ�ϴ� �� �����
--student , professor,department ���̺� ���� 
--��米������ ��Ī�� ���������� �ش�
--��� �л��� ��µǵ��� �Ѵ�(outer join)



--(14) ������ ���� ��(v_student)���� �а�(dname)�� ���а��� ������ �л��� ��ȸ�ϱ�



--(15) professor ���̺��� �̸��� ������������ ������ ���¿��� ���� 5���� ������ ��ȸ�ϱ�
--������ȣ(profno), �̸�(name), ����(position), �а���ȣ(deptno) ��ȸ
select * from professor
where rownum<=5
order by name;



--(16) ���̺� �����
--[1] �����ȣ ���̺� ����� - zipcode1
/*zipcode  �����ȣ
sido �õ�
gugun ����
dong ��
bunji ����
seq -��ȣ, �⺻Ű
*/
create table zipcode2
(
    zipcode number not null,
    sido    varchar2(30) not null,
    gugun   varchar2(40),
    dong    varchar2(20),
    bunji   varchar2(30),
    seq     number primary key
       
);

--[2] ȸ�����̺� ����� - member1
/*
no - ��ȣ, �⺻Ű
userid  ���̵�, unique, �ݵ�� �� �Էµǵ���
name   �̸�, �ݵ�� �� �Էµǵ���
pwd    ��й�ȣ , �ݵ�� �� �Էµǵ���
hp �޴�����ȣ
zipcodeno   �ݵ�� �� �Էµǵ���, �����ȣ ���̺���  ��ȣ(seq)�� ����-�ܷ�Ű
addressDetail ���ּ�
regdate  ������, �⺻��:��������
mileage  ���ϸ���, �⺻�� :0,  0~1000000 ������ ���� ������
*/
create table member2
(
    no number primary key, --��ȣ, �⺻Ű
    userid varchar2(30) unique, --���̵�, unique, �ݵ�� �� �Էµǵ���
    name varchar2(10) not null,--�̸�, �ݵ�� �� �Էµǵ���
    pwd varchar2(20) not null,--��й�ȣ , �ݵ�� �� �Էµǵ���
    hp varchar2(13),--�޴�����ȣ
    zipcode varchar2(5),--�������
    addressDetail clob, --���ּ�
    regdate varchar2(30) default sysdate,--������, �⺻��:��������
    mileage number check(mileage>0 and mileage<1000000)--���ϸ���, �⺻�� :0, 0~1000000 ������ ���� ������
);

--[3] ������ ����� - member1_seq
--1���� �����ϰ�, 1�� �����ϴ� ������

create sequence member1_seq
start with 1
increment by 1
nocache;



--(17) �Է�,����, �����ϱ� - ó�� �� commit�Ѵ�
--[1] zipcode1 ���̺��� ��ü Į���� ������ �Է��ϱ� - 2���� �����͸� �Է��Ѵ�
--�����ȣ : 150-300, �õ�: ����, ����: ����, ��:������, ����: 500~600����, seq: 11
--�����ȣ : 150-400, �õ�: ����, ����: ����, ��:������, ����: 700~800����, seq: 12


--[2] member1 ���̺��� �ʼ� �÷��� ������ �Է��ϱ�
--member1���̺��� no �� member1_seq => sequence �̿��ؼ� �ڵ������ϵ���


--[3] student ���̺��� 3�г�(grade) �л� �� Ű(height)�� 172�̻��� �л��� ������(weight)�� 64��, Ű�� 180����  �����Ͻÿ�


--[4] professor ���̺��� ������ȣ(profno)�� 1001�� ������ pay�� ���� pay�� 20�� �߰��ǵ��� �����Ͻÿ�


--[5] student ���̺��� 1�г� �л� �� �̸��� '���'�� ����� �����Ͻÿ� - rollback �Ѵ�


--(18) student ���̺�� professor ���̺��� �����Ͽ� 101�� �а��� �ҼӵǾ� �ִ� �л��� �������� �й�(������ ������ȣ), �̸�, �а� ��ȣ�� ���



--(19) ���� ���ν��� ����� (���ν��� �̸�: memberUpdate)
--[1] member1 ���̺��� no�� �ش��ϴ� ȸ���� ������ �����ϴ� ���� ���ν��� �����
--hp, zipcodeno, addressDetail �÷��� ������ �����Ѵ�

--[2] memberUpdate ���ν����� �̿��ؼ� no�� 1�� ȸ�� ���� �����ϱ�


--(20) ������ �������� ������ �ִ���, �����ϰ�, ������ ���� �����Ͻÿ�.
--inner join�� outer join


