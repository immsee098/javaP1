--1. 상품테이블
--drop table product cascade constraint;
create table product
(
	no			number  primary key,	--일련번호
	productName 	varchar2(50) not null,	--상품이름
	price 		number null,			--소비자가
	--company 	varchar2(50) null,		--제조회사
	description 	varchar2(255) null,		--설명
	regDate 		date	  default sysdate	--등록일
);

create sequence product_seq
start with 1
increment by 1
nocache;


select * from user_sequences;

select * from product;

insert into product(no, productname, price, description)
values(product_seq.nextval,'라벤다',  7000,
'독특한 향기와 맛 때문에 약용 및 조미식물로 널리 이용되어옴');

commit;
