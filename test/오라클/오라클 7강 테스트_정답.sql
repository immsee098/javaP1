--[ ����Ŭ 7�� ]

--(1) professor ���̺��� �̸��� ������������ ������ ���¿��� ���� 5���� ������ ��ȸ�ϱ�
--������ȣ(profno), �̸�(name), ����(position), �а���ȣ(deptno) ��ȸ
select profno, name, position, deptno 
from (select profno, name, position, deptno from professor order by name) 
where rownum<=5;


--(2) ���̺� �����
--[1] �����ȣ ���̺� ����� - zipcode1
/*zipcode  �����ȣ
sido �õ�
gugun ����
dong ��
bunji ����
seq -��ȣ, �⺻Ű
*/

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


--drop table zipcode1 cascade constraint;
create table zipcode1
(
 zipcode varchar2(10),
 sido varchar2(30),
 gugun varchar2(30),
 dong varchar2(200),
 bunji varchar2(100),
 seq number primary key
);

select * from zipcode1;

--drop table member1 cascade constraint;
create table member1
(
    no           number        primary key,
    userid     varchar2(20)   unique not null,
    name      varchar2(20)    not null,
    pwd        varchar2(15)    not null,
    hp            varchar2(20)    null,
    zipcodeNo    number  references zipcode1(seq) not null,    
    addressDetail    varchar2(100)   null,
    regdate     date        default sysdate,
    mileage        number   default 0 check(mileage>=0 and mileage<=1000000)
);


select * from member1;


--(3) �Է�,����, �����ϱ� - ó�� �� commit�Ѵ�
--[1] zipcode ���̺��� ��ü Į���� ������ �Է��ϱ� - 2���� �����͸� �Է��Ѵ�
--�����ȣ : 120-100, �õ�: ����, ����: ����, ��:���ﵿ, ����: 100~200����, seq: 1
--�����ȣ : 120-200, �õ�: ����, ����: ����, ��:��赿, ����: 300~400����, seq: 2

insert into zipcode1
values('120-100','����','����','���ﵿ','100~200����',1);
insert into zipcode1
values('120-200','����','����','��赿','300~400����',2);
commit;

--[2] member1 ���̺��� �ʼ� �÷��� ������ �Է��ϱ�
insert into member1(no, userid, name, pwd, zipcodeno)
values(1, 'hong','ȫ�浿','1234',1);
commit;

select * from zipcode1;
select * from member1;

--[3] student ���̺��� 4�г�(grade) �л� �� Ű(height)�� 170������ �л��� ������(weight)�� 50����, 
--Ű�� 166����  �����Ͻÿ�
select * from student where grade=4 and height<=170;

update student
set weight=50, height=166 
where grade=4 and height<=170;

rollback;

--[4] professor ���̺��� ������ȣ(profno)�� 1001�� ������ pay�� ���� pay�� 30�� �߰��ǵ��� �����Ͻÿ�
select * from professor where profno=1001;

update professor
set pay=pay+30 
where profno=1001;

rollback;

--[5] student ���̺��� 1�г� �л� �� �̸��� '���'�� ����� �����Ͻÿ� - rollback �Ѵ�
select * from student where grade=1 and name='���';

delete from student
where grade=1 and name='���';

rollback;


--(4) ������ �������� ������ �ִ���, �����ϰ�, ������ ���� �����Ͻÿ�.
/*
���� ����(Inner Join)-���� ���̺� ���� ������ ������ ����� ������ �������� ����
                   -join�� �����ϴ� ��� ���̺� �����Ͱ� �����ϴ� ��쿡�� ������� �����
�ܺ� ����(Outer Join)-���� ���̺��� �����Ͱ� �ְ� ���� ���̺� ���� ��쿡 �����Ͱ� �ִ� �� ���̺��� ������ ���� ����ϰ� �ϴ� ���
���� ����(Self Join)-���ϴ� �����Ͱ� �ϳ��� ���̺� �� ��� ���� ���, �ڱ� �ڽ� ���̺�� �����ϴ� ��
*/

--(5) �Խ���(board), ���� �亯(���, comments) ���̺� �����
create table board
(
    no                number        primary key,    --��ȣ
    name        varchar2(20)    not null,            --�̸�    
    pwd            varchar2(20)    not null,            --��й�ȣ
    title            varchar2(100)     not null,            --����
    email        varchar2(80)    null,            --�̸���
    regdate         date            default  sysdate,    --�ۼ���
    --regip        varchar2(15)     null,            --�ۼ�IP
    readcount    number        default 0     null,        --��ȸ��
    content        clob            null            --����
);


CREATE TABLE comments (
    no                number        primary key,    --��ȣ
    name             varchar2(20)    not null,            --�̸�    
    pwd              varchar2(20)    not null,            --��й�ȣ
    regdate         date        default  sysdate,    --�ۼ���
    content         varchar2(2000)         null,            --����
    bdNo            number references board(no) on delete cascade not null --���� �Խ��� �۹�ȣ   
);



--(6) professor ���̺��� pay �÷��� ���� ������ ���� �����Ͻÿ�.
--�μ���ȣ�� 101�̳� 102�� ������ ������� pay �÷��� ���� ������ ���������� �� ������ 
--�� �޿�(pay)�� 5%, ���������� �� �� �޿��� 10%, ���Ӱ���� �� �޿��� 15%�� �����Ͻÿ�.
select * from professor;

update professor
set pay= case position when '������' then pay*1.05
                       when '������' then pay*1.1
                       when '���Ӱ���' then pay*1.15
                       end
where deptno in (101,102); 
                           
rollback;



--(7) �� �μ��� ���ϴ� �������(�μ���ȣ, �����ȣ, ����̸�, ����, �޿�)�� ��ȸ�ϰ�, 
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

