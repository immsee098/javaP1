--�����ȣ 5�ڸ�

--drop table zipcode cascade constraint;

create table zipcode
(
 zipcode varchar2(5),
 sido varchar2(100),
 gugun varchar2(100),
 dong varchar2(200),
 startbunji varchar2(100),
 endbunji varchar2(100),
 seq number primary key
);

select * from zipcode;