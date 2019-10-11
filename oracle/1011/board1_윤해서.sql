create table board
(
    no number primary key,
    title varchar2(50) not null,
    content clob,
    writer varchar2(30),
    viewnum number default 0 not null
);

create table comments
(
    no number,
    b_comment clob,
    comm_no number primary key,
    constraint pk_comments_reply foreign key(no) references board(no)
);

select * from board;
select * from comments;

drop table comments;

insert into board
values(1, '테스트', '이것은 테스트 게시판', '윤해서', 1);

insert into board
values(2, '테스트2', '이것은 테스트 게시판2', '윤서라', 2);

insert into board
values(3, '테스트3', '이것은 테스트 게시판3', '윤서라', 0);

insert into comments
values(1, '가나다라마가나다라마', 1);

insert into comments
values(1, 'abcdefg', 2);

delete from comments
where comm_no=1;

update board
set content = '이것은 수정 게시글입니다'
where no = 1;

select * from board
order by no desc;

select * from board
where no =2;

update board
set viewnum = viewnum+1
where no = 2;

select * from comments
where no=(select no from board where no=1);

select * from board;
