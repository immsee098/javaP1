select * from board order by no desc;

--[����¡ ó�� ���� ������]

--1������ 
select * 
from(
    select * from board
    order by no desc
)where rownum>0 and rownum<=0+5;

--2������  -- ���ϴ� ����� �� ���� (rownum�� 1�� ���ԵǾ�� �ϹǷ�)
select * 
from(
    select * from board
    order by no desc
)where rownum>5 and rownum<=5+5;

--> inline view�� �ѹ� �� �̿�
select *
from(
    select rownum as ROW_NUM, A.* 
    from(
        select * from board
        order by no desc
    ) A
) where ROW_NUM>5 and ROW_NUM<=5+5;

--3������
select *
from(
    select rownum as ROW_NUM, A.* 
    from(
        select * from board
        order by no desc
    ) A
) where ROW_NUM>10 and ROW_NUM<=10+5;


--�˻��� ���
select *
from(
    select rownum as ROW_NUM, A.*, (sysdate-regdate)*24 as newImgTerm 
    from(
        select * from board
        where name like '%ȫ%'
        order by no desc
    ) A
) where ROW_NUM>10 and ROW_NUM<=10+5;

