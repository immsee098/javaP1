--7�� ���̺�� ��������

create table char_exam1
(
    name1 char(3), --�Һ�
    name2 varchar2(3) --����
);

insert into char_exam1
values('AA', 'AA');

select name1, name2, length(name1), length(name2),
replace(name1, ' ', '*'), replace(name2, ' ', '*')
from char_exam1;

--

drop table char_exam1;
select * from char_exam1;
create table char_exam1
(
    names1 char(3),
    names2 varchar(3),
    names3 char(6 byte),
    names4 char(6 char),
    names5 char(6),
    names6 clob ---4gb���� ����
);

insert into char_exam1
values('AAA', '��', 'ABCDEF', 'ABCDEFG','AB', null); --error
--names4 -> 6�� ���ڸ� �Է�

insert into char_exam1
values('AAA', '��', 'ABCDEF', '�����ٶ󸶹�','AB', null); --error
--names4 -> 6�� ���ڸ� �Է�