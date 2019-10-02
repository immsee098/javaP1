--[ ����Ŭ 3�� ]

--(1)���� ���̺��� ����(position)�� ���Ӱ���, �������� �̸�(name), ���̵�(id), ����(position), �޿�(pay) �����Ͱ�������
select name, id, position, pay
from professor
where position in ('���Ӱ���','������');
 
--(2) pd ���̺��� �����(regdate) ��  2019-09-07 ~ 2019-09-27 �� ������ �����͸� ��ȸ�ϱ�
--to_date �Լ� �̿��ϱ�
select * from pd
where regdate>='2019-09-07' 
and regdate<to_date('2019-09-27')+1;

--(3)�������̺��� ������ �̸�(name), ����(position),�޿�(pay), ���ʽ�(bonus), ����(pay*12+bonus)  ������ ��������
--bonus�� null�̸� 0���� ���ǵ��� ó���Ѵ� -  nvl �Լ� ����ϱ�
select name, position, pay, bonus, pay*12+nvl(bonus,0)  as ���� from professor;

--(4)�л� ���̺��� �л��� ���Ű�� ����ūŰ, ��������Ű, ��ü �л� �� ���ϱ�
select avg(nvl(height,0)),max(height),min(height),count(*) from student;

--(5)�л����̺��� �а�(deptno1)���� �л��� ���Ű ���ϱ�
--���Ű�� �Ҽ� ���� ���ڸ��� �������� �ݿø��Ѵ�(round �Լ� �̿�)
select deptno1,avg(height), round(avg(nvl(height,0)),1) from student 
group by deptno1;

--(6) �������̺��� �а�(deptno)��, ����(position)���� �޿�(pay)�� �� ���ϱ�
select deptno, position,sum(pay) from professor
group by deptno, position;


--(7) student���� grade�� 1�̸� 1�г�, 2�̸� 2�г�, 3�̸� 3�г�,4�̸� 4�г��̶�� ���
--decode() �̿�
select name, grade, decode(grade, 1, '1�г�', 
                                  2, '2�г�',
                                  3, '3�г�',
                                  4, '4�г�') as "�г�",
 decode(grade, 1, '1�г�', 2,'2�г�',3,'3�г�','4�г�') 
    as "�г�2"                                    
from student;


--(8) gogak���� jumin�� �̿��Ͽ� ������ ��� (1, 3 �̸� ��,  2, 4�̸� ��)
--case �̿�

select gname, jumin, substr(jumin, 7, 1),
    case substr(jumin,7,1) when '1' then '��'
                           when '3' then '��'
                           else '��'
    end as "����",
    case when substr(jumin, 7, 1) in ('1','3') then '��'
         else '��'
    end as "����2"
 from gogak;


--(9) panmae ���̺��� ��ǰ�ڵ�(p_code)���� �Ǹűݾ�(p_total)�� �հ�, ����(p_qty)�� �հ�, �Ǽ�, �Ǹűݾ�(p_total)�� ��� ���ϱ�
--�� ������� �Ǹűݾ�(p_total)�� �հ谡 10000 �̻��̰�, ����(p_qty)�� �հ谡 15 �̻��� �����͸� ��ȸ
select p_code, sum(p_total), sum(p_qty), count(*) , avg(nvl(p_total, 0)) 
from panmae
group by p_code
having  sum(p_total)>=10000 and sum(p_qty) >= 15
order by p_code;

--(10) Professor ���̺��� ��ȸ�Ͽ� ������ �޿��׼�(pay)�� �������� 
--200 �̸��� 4��, 201~300�� 3��, 301~400�� 2��, 401 �̻��� 1������ ǥ���Ͽ� ������ ��ȣ(profno), �����̸�(name), �޿�(pay), ����� ����ϼ���. 
--��, pay Į���� ������������ �����ϼ���.
select profno, name, pay,
    CASE WHEN pay<200 THEN '4��'
          WHEN pay BETWEEN 201 AND 300 THEN  '3��'
          WHEN pay BETWEEN 301 AND 400 THEN '2��'
        ELSE '1��'
    END "���"
from professor order by pay desc;

--(11) panmae ���̺��� �Ǹ���(p_date)���� �Ǹűݾ�(p_total)�� �հ� ���ϱ�
select p_date, sum(p_total) from panmae
group by p_date;

--(12) panmae ���̺��� ����(p_qty)�� 3�� �̻��� �����Ϳ� ���� �Ǹ���(p_date)��, �Ǹ���(p_store)���� 
--�Ǹűݾ�(p_total)�� �հ�, �Ǽ� ���ϱ�
--�� ������� �Ǽ��� 2 �̻��� �����͸� ��ȸ
select p_date, p_store, sum(p_total), count(*) from panmae
where p_qty>=3
group by p_date, p_store
having count(*) >=2;

--(13) panmae ���̺��� �Ǹ���(p_store)��, ��ǰ�ڵ�(p_code)���� �Ǹűݾ�(p_total)�� �հ�, ��� ���ϱ�
select p_store, p_code, sum(p_total), avg(nvl(p_total, 0)) from panmae
group by p_store, p_code
order by p_store, p_code;



--(14) professor ���̺��� ��ȸ�Ͽ� �� �а����� �Ի����� ���� ������(�ּҰ�) ���� ��ȸ�ϱ�
select deptno, min(hiredate) 
from professor 
group by deptno
order by deptno;


--(15) exam_01 ���̺��� total�� �̿��ؼ� ���� ���ϱ�
--90�̻��̸� A, 80�̻��̸� B, 70�̻��̸� C, 60�̻��̸� D, �������� F
--case �̿�

 select studno, total, trunc(total/10), trunc(total, -1),
    decode( trunc(total/10), 10, 'A',9,'A',8,'B',7,'C',6,'D','F') "����",
    case trunc(total, -1) when 100 then 'A'
                                  when  90 then 'A'
                                  when 80 then 'B'
                                  when 70 then 'C'
                                  when 60 then 'D'
                                  else 'F'
     end "����"                               
 from exam_01;
 
 --(16) gogak���̺��� jumin�� �̿��ؼ� ���� ���ϱ�

 select gname, jumin, 
    to_char(sysdate, 'yyyy'), 
    substr(jumin, 1,2),
    substr(jumin,7,1), 
    case when substr(jumin,7,1) in ('1','2') then 1900
            else 2000
    end,
    to_char(sysdate, 'yyyy')- 
    (substr(jumin, 1,2)+case when substr(jumin,7,1) in ('1','2') then 1900
                                          else 2000
                                   end)  +1   "����"     
 from gogak;
 

 --(17) select sql���� ��������� ���ÿ�.
    
    5. select �÷�
    1. from ���̺�
    2. where ����
    3. group by �׷����� �÷�
    4. having ����
    6. order by �÷�    

--(18) professor ���̺��� �а���, ���޺� ��� �⺻���� ���Ͻÿ�.
--roll up, cube�� ���� �̿�

select deptno "�а�", position "����", round(avg(nvl(pay,0)),1) "��ձ⺻��"
from professor
group by deptno, position
order by deptno, position;

select deptno "�а�", position "����", round(avg(nvl(pay,0)),1) "��ձ⺻��"
from professor
group by rollup(deptno, position)
order by deptno, position;

--cube
select deptno "�а�", position "����", round(avg(nvl(pay,0)),1) "��ձ⺻��"
from professor
group by cube(deptno, position)
order by deptno, position;

