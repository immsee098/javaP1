--1. ��ǰ���̺�
--drop table product cascade constraint;
create table product
(
	no			number  primary key,	--�Ϸù�ȣ
	productName 	varchar2(50) not null,	--��ǰ�̸�
	price 		number null,			--�Һ��ڰ�
	--company 	varchar2(50) null,		--����ȸ��
	description 	varchar2(255) null,		--����
	regDate 		date	  default sysdate	--�����
);

create sequence product_seq
start with 1
increment by 1
nocache;


select * from user_sequences;

select * from product;

insert into product(no, productname, price, description)
values(product_seq.nextval,'�󺥴�',  7000,
'��Ư�� ���� �� ������ ��� �� ���̽Ĺ��� �θ� �̿�Ǿ��');

commit;
