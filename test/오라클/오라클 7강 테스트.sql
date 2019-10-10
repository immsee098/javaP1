--[ ����Ŭ 7�� ]

--(1) professor ���̺��� �̸��� ������������ ������ ���¿��� ���� 5���� ������ ��ȸ�ϱ�
--������ȣ(profno), �̸�(name), ����(position), �а���ȣ(deptno) ��ȸ
select profno, name, position, deptno 
from professor
where rownum <=5
order by name;


--(2) ���̺� �����
--[1] �����ȣ ���̺� ����� - zipcode1
/*zipcode  �����ȣ
sido �õ�
gugun ����
dong ��
bunji ����
seq -��ȣ, �⺻Ű
*/
create table zipcode1
(
    zipcode varchar2(5), --�����ȣ
    sido varchar2(40),--�õ�
    gugun varchar2(50),--����
    dong varchar2(50),--��
    bunji varchar2(30),--����
    seq number primary key, --��ȣ, �⺻Ű 
    constraint pl_zipcode_zipcode foreign key(zipcode) references member1(zipcodeno)
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

drop table member1;
create table member1
(
    no number primary key, --��ȣ, �⺻Ű
    userid varchar2(30) unique, --���̵�, unique, �ݵ�� �� �Էµǵ���
    name varchar2(10) not null,--�̸�, �ݵ�� �� �Էµǵ���
    email varchar2(50),--�̸���
    hp varchar2(13),--�޴�����ȣ
    zipcodeno varchar2(5) unique,--�����ȣ
    address clob,--�ּ�(�õ�, ����, ��)
    addressDetail clob, --���ּ�
    regdate varchar2(30) default sysdate,--������, �⺻��:��������
    mileage number check(mileage>0 and mileage<1000000)--���ϸ���, �⺻�� :0, 0~1000000 ������ ���� ������
);



--(3) �Է�,����, �����ϱ� - ó�� �� commit�Ѵ�
--[1] zipcode ���̺��� ��ü Į���� ������ �Է��ϱ� - 2���� �����͸� �Է��Ѵ�
--�����ȣ : 120-100, �õ�: ����, ����: ����, ��:���ﵿ, ����: 100~200����, seq: 1
--�����ȣ : 120-200, �õ�: ����, ����: ����, ��:��赿, ����: 300~400����, seq: 2


--[2] member1 ���̺��� �ʼ� �÷��� ������ �Է��ϱ�


--[3] student ���̺��� 4�г�(grade) �л� �� Ű(height)�� 170������ �л��� ������(weight)�� 50����, 
--Ű�� 166����  �����Ͻÿ�


--[4] professor ���̺��� ������ȣ(profno)�� 1001�� ������ pay�� ���� pay�� 30�� �߰��ǵ��� �����Ͻÿ�
update professor
set pay=pay+30
where profno=1001;


--[5] student ���̺��� 1�г� �л� �� �̸��� '���'�� ����� �����Ͻÿ� - rollback �Ѵ�
delete from student 
where grade=1 and name='���';

rollback;

select * from student;


--(4) ������ �������� ������ �ִ���, �����ϰ�, ������ ���� �����Ͻÿ�.
/*
1. �̳�����
2. �ܺ�����
3. ��������
4. ũ�ν�����
*/


--(5) �Խ���(board), ���� �亯(���, comments) ���̺� �����



--(6) professor ���̺��� pay �÷��� ���� ������ ���� �����Ͻÿ�.
--�μ���ȣ�� 101�̳� 102�� ������ ������� pay �÷��� ���� ������ ���������� �� ������ 
--�� �޿�(pay)�� 5%, ���������� �� �� �޿��� 10%, ���Ӱ���� �� �޿��� 15%�� �����Ͻÿ�.



--(7) �� �μ��� ���ϴ� �������(�μ���ȣ, �����ȣ, ����̸�, ����, �޿�)�� ��ȸ�ϰ�, 
--�μ��� ��ձ޿��� ����Ͻÿ� -emp2
--inline view �̿�

