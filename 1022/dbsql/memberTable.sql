--1. ȸ�����̺�
--drop table member cascade constraints;

create table member
(
	no			number  primary key,	--�Ϸù�ȣ
	userid		varchar2(20)	not null,   --���̵�
	name		varchar2(20)	not null,	--�̸�
	pwd			varchar2(15)	not null,	--��й�ȣ	
	email		varchar2(50)	null,		--�̸���
	hp			varchar2(20)	null,		--�޴���
	zipcode		varchar2(5)		null,		--�����ȣ
	address1		varchar2(50)	null,		--�ּ�1
	address2		varchar2(50)	null,		--�ּ�2(���ּ�)
	regDate 		date		default  sysdate  null	--�����
);

create sequence member_seq
start with 1
increment by 1
nocache;


select * from user_sequences;

select * from member;

insert into member(no, userid, name, pwd,  email, hp, zipcode, address1, address2)
values(member_seq.nextval, 'hong',  'ȫ�浿', '1', 'hong@nate.com',
'010-100-1000', '06041', '����� ���ʱ�','420����');

commit;