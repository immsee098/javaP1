--1. 회원테이블
--drop table member cascade constraints;

create table member
(
	no			number  primary key,	--일련번호
	userid		varchar2(20)	not null,   --아이디
	name		varchar2(20)	not null,	--이름
	pwd			varchar2(15)	not null,	--비밀번호	
	email		varchar2(50)	null,		--이메일
	hp			varchar2(20)	null,		--휴대폰
	zipcode		varchar2(5)		null,		--우편번호
	address1		varchar2(50)	null,		--주소1
	address2		varchar2(50)	null,		--주소2(상세주소)
	regDate 		date		default  sysdate  null	--등록일
);

create sequence member_seq
start with 1
increment by 1
nocache;


select * from user_sequences;

select * from member;

insert into member(no, userid, name, pwd,  email, hp, zipcode, address1, address2)
values(member_seq.nextval, 'hong',  '홍길동', '1', 'hong@nate.com',
'010-100-1000', '06041', '서울시 서초구','420번지');

commit;