select * from board order by no desc;

--[페이징 처리 관련 쿼리문]

--1페이지 
select * 
from(
    select * from board
    order by no desc
)where rownum>0 and rownum<=0+5;

--2페이지  -- 원하는 결과가 안 나옴 (rownum은 1이 포함되어야 하므로)
select * 
from(
    select * from board
    order by no desc
)where rownum>5 and rownum<=5+5;

--> inline view를 한번 더 이용
select *
from(
    select rownum as ROW_NUM, A.* 
    from(
        select * from board
        order by no desc
    ) A
) where ROW_NUM>5 and ROW_NUM<=5+5;

--3페이지
select *
from(
    select rownum as ROW_NUM, A.* 
    from(
        select * from board
        order by no desc
    ) A
) where ROW_NUM>10 and ROW_NUM<=10+5;


--검색의 경우
select *
from(
    select rownum as ROW_NUM, A.*, (sysdate-regdate)*24 as newImgTerm 
    from(
        select * from board
        where name like '%홍%'
        order by no desc
    ) A
) where ROW_NUM>10 and ROW_NUM<=10+5;

