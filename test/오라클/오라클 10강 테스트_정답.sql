--[ ����Ŭ 10 �� ]
--(1) 1, 2, 3 ����ȭ�� ���� �����Ͻÿ�.

�� 1 ����ȭ
       - �ݺ��Ǵ� �Ӽ��̳� Group �Ӽ� �����ϰ� �⺻���̺��� �⺻Ű�� �߰��� ���ο� ���̺��� �����ϰ� 
       ������ ���̺�� 1:N�� ���踦 �����Ѵ�.
�� 2 ����ȭ
       - ����Ű( Composit Primary Key )�� ������ ��� �ش� ���̺� ���� ��� �÷����� ����Ű ��ü��
        �������̾�� �Ѵ�.
	���� ����Ű �Ϻο� �������� �÷��� �����Ѵٸ� �����ؾ� �Ѵ�.
�� 3 ����ȭ
      - �⺻Ű(Primary Key)�� �������� �ʰ� �Ϲ� �÷��� �����ϴ� �÷����� �����Ѵ�. 


--(2) panmae ���̺��� ����Ͽ� �Ǹų����� ����ϵ� �Ǹ�����, �Ǹŷ�, ���� �Ǹŷ��� ����Ͻÿ�.
--�Ǹ� ���ں��� �����Ͽ� ������ ��
select p_date, qty_tot, 
    sum(qty_tot) over(order by p_date) �����Ǹŷ�
from(
    select p_date, sum(p_qty) qty_tot
    from panmae
    group by p_date
);

--(3) ��ǰ�� �԰�Ǹ� ��� ���̺��� �ڵ����� �ش� ��ǰ�� ��� ������ �ݾ��� �����Ǵ� Ʈ���Ÿ� �ۼ��Ͻÿ�.
create or replace trigger tr_jaejo
after insert on �԰�
for each row
begin
    update ���
    set ����=����+:new.����, �ݾ�=�ݾ�+:new.�ݾ�
    where ǰ��=:new.ǰ��;           
end;

insert into �԰� values(100, 2, 1800);

--(4) emp2 ���̺��� ����Ͽ� ���, �̸�, �޿�, �μ���ȣ, �μ��� �޿������� ��ȸ�Ͻÿ�
 select empno, name, pay,deptno, 
    rank() over(partition by deptno order by pay desc) "RANK"
from emp2;

--(5) �а�(deptno1)�� 101���̰� 3�г�(grade) �̻��� �л��� �̸�(name), ���̵�(id), �г�(grade) ������ ��������.
select name, id,grade
from student 
where deptno1=101 and grade >=3; 
 
--(6)�������̺��� �޿�(pay)�� 300���� 400������ ������ �̸�(name), ���̵�(id), �޿�(pay) ������ ��������
select name,id,pay
from professor
where pay between 300 and 400;
 
--(7)���� ���̺��� ����(position)�� ���Ӱ���, �������� �̸�(name), ���̵�(id), ����(position), �޿�(pay) �����Ͱ�������
select name, id, position, pay
from professor
where position in ('���Ӱ���','������');
 
--(8) ���� ���̺��� bonus�� ���� �ʴ� ������ �̸�(name), ���̵�(id), ����(position)������ ��������
select name, id, position
from professor
where bonus is null; 

--(9) pd ���̺��� �����(regdate) ��  2019-09-01 ~ 2019-09-27 �� ������ �����͸� ��ȸ�ϱ�
--to_date �Լ� �̿��ϱ�
select * from pd
where regdate>='2019-09-01' 
and regdate<to_date('2019-09-27')+1;

--(10)�л����̺��� �а�(deptno1)���� �л��� ���Ű ���ϱ�
--���Ű�� �Ҽ� ���� ���ڸ��� �������� �ݿø��Ѵ�(round �Լ� �̿�)
select deptno1,avg(height), round(avg(nvl(height,0)),1) from student 
group by deptno1;


--(11) �л� �̸��� '��'�� �� �л����� �̸�(name), �г�(grade), �ֹι�ȣ(jumin), ��ȭ��ȣ(tel), ��米����(name) ������ ��������
--student , professor ���̺� ���� (inner join �̿�)
select s.name, s.grade, s.jumin,s.tel, p.name
from student s, professor p 
where s.profno = p.profno
and s.name like '%��%'; 

select s.name, s.grade, s.jumin,s.tel, p.name
from student s join professor p 
on s.profno = p.profno
and s.name like '%��%'; 

--(12) �������  �а�(deptno1)�� ���� �л����� �й�(studno), �̸�(name), �г�(grade), �а���ȣ(deptno1)�� ��ȸ�ϵ� �̸�(name)�� ������������ ��ȸ
--���� ���� �̿� 
SELECT studno, name, grade, deptno1 FROM student
WHERE deptno1=(SELECT deptno1 FROM student WHERE name = '�����')
ORDER BY name desc;

--(13) �� ����� (���̸� : v_student)
--�л��� �̸�(name), �г�(grade), ��米����(name),�а���(dname) �����͸� ��ȸ�ϴ� �� �����
--student , professor,department ���̺� ���� 
--��米������ ��Ī�� ���������� �ش�
--��� �л��� ��µǵ��� �Ѵ�(outer join)

create or replace view v_student
as
select s.name,s.grade,p.name as ������, d.dname 
from student s, professor p, department d
where s.profno=p.profno(+)
and s.deptno1 = d.deptno(+);

select s.name,s.grade,p.name as ������, d.dname 
from student s left outer join professor p
on s.profno=p.profno
left join department d
on s.deptno1 = d.deptno;


--(14) ������ ���� ��(v_student)���� �а�(dname)�� ���а��� ������ �л��� ��ȸ�ϱ�
select * from v_student where dname like '%���а�';

--(15) professor ���̺��� �̸��� ������������ ������ ���¿��� ���� 5���� ������ ��ȸ�ϱ�
--������ȣ(profno), �̸�(name), ����(position), �а���ȣ(deptno) ��ȸ
select profno, name, position, deptno 
from (select profno, name, position, deptno from professor order by name) 
where rownum<=5;

select profno, name, position, deptno,
    row_number() over(order by name) num
from 
(   select profno, name, position, deptno, 
    row_number() over(order by name) RNUM 
    from professor
) 
where RNUM<=5;


--(16) ���̺� �����
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

--[3] ������ ����� - member1_seq
--1���� �����ϰ�, 1�� �����ϴ� ������

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

--drop sequence member1_seq;
create sequence member1_seq
increment by 1
start with 1
nocache;

select * from member1;


--(17) �Է�,����, �����ϱ� - ó�� �� commit�Ѵ�
--[1] zipcode1 ���̺��� ��ü Į���� ������ �Է��ϱ� - 2���� �����͸� �Է��Ѵ�
--�����ȣ : 150-300, �õ�: ����, ����: ����, ��:������, ����: 500~600����, seq: 11
--�����ȣ : 150-400, �õ�: ����, ����: ����, ��:������, ����: 700~800����, seq: 12

insert into zipcode1
values('150-300','����','����','������','500~600����',11);
insert into zipcode1
values('150-400','����','����','������','700~800����',12);
commit;

--[2] member1 ���̺��� �ʼ� �÷��� ������ �Է��ϱ�
--member1���̺��� no �� member1_seq => sequence �̿��ؼ� �ڵ������ϵ���
insert into member1(no, userid, name, pwd, zipcodeno)
values(member1_seq.nextval, 'hong2','ȫ�浿2','123',11);
commit;

select * from zipcode1;
select * from member1;

--[3] student ���̺��� 3�г�(grade) �л� �� Ű(height)�� 172�̻��� �л��� ������(weight)�� 64��, Ű�� 180����  �����Ͻÿ�
select * from student where grade=3 and height>=172;

update student
set weight=64, height=180
where grade=3 and height>=172;

rollback;

--[4] professor ���̺��� ������ȣ(profno)�� 1001�� ������ pay�� ���� pay�� 20�� �߰��ǵ��� �����Ͻÿ�
select * from professor where profno=1001;

update professor
set pay=pay+20 
where profno=1001;

rollback;

--[5] student ���̺��� 1�г� �л� �� �̸��� '���'�� ����� �����Ͻÿ� - rollback �Ѵ�
select * from student where grade=1 and name='���';

delete from student
where grade=1 and name='���';

rollback;



--(18) student ���̺�� professor ���̺��� �����Ͽ� 101�� �а��� �ҼӵǾ� �ִ� �л��� �������� �й�(������ ������ȣ), 
�̸�, �а� ��ȣ�� ���

select '[����]' as "����", 
    profno, name, id, hiredate, deptno from professor
where deptno=101
union
select '[�л�]' as "����", 
    studno, name, id, birthday, deptno1 from student
where deptno1=101;


--(19) ���� ���ν��� ����� (���ν��� �̸�: memberUpdate)
--[1] member1 ���̺��� no�� �ش��ϴ� ȸ���� ������ �����ϴ� ���� ���ν��� �����
--hp, zipcodeno, addressDetail �÷��� ������ �����Ѵ�

--[2] memberUpdate ���ν����� �̿��ؼ� no�� 1�� ȸ�� ���� �����ϱ�
create or replace procedure memberUpdate
(p_no     member1.no%type,
p_hp      member1.hp%type, 
p_zipcodeno       member1.zipcodeno%type, 
p_addressDetail   member1.addressDetail%type
)
is
begin
    update member1
    set hp=p_hp, zipcodeno=p_zipcodeno, addressDetail=p_addressDetail
    where no=p_no;
    
    commit;
    
    exception when others then
        dbms_output.put_line('member1 ���� ����!!');
        rollback;    
end;

--
exec memberUpdate(1, '010-700-3000', 2, '980����')

select * from member1;
select * from zipcode1;

--(20) ������ �������� ������ �ִ���, �����ϰ�, ������ ���� �����Ͻÿ�.
���� ����(Inner Join)-���� ���̺� ���� ������ ������ ����� ������ �������� ����
			-join�� �����ϴ� ��� ���̺� �����Ͱ� �����ϴ� ��쿡�� ������� �����
�ܺ� ����(Outer Join)-���� ���̺��� �����Ͱ� �ְ� ���� ���̺� ���� ��쿡 �����Ͱ� �ִ� �� ���̺��� ������ ���� ����ϰ� �ϴ� ���
���� ����(Self Join)-���ϴ� �����Ͱ� �ϳ��� ���̺� �� ��� ���� ���, �ڱ� �ڽ� ���̺�� �����ϴ� ��
