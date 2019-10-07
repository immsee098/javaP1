--7강 테이브블 제약조건

create table char_exam1
(
    name1 char(3), --불변
    name2 varchar2(3) --가변
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
    names6 clob ---4gb까지 저장
);

insert into char_exam1
values('AAA', '가', 'ABCDEF', 'ABCDEFG','AB', null); --error
--names4 -> 6개 문자만 입력

insert into char_exam1
values('AAA', '가', 'ABCDEF', '가나다라마바','AB', null); --error
--names4 -> 6개 문자만 입력