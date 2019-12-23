--ÆäÀÌÂ¡ Ã³¸® Äõ¸®¹®
select * from board order by no desc;

--1page

select * from board order by no desc
where rownum>0 and rownum<=5;


--2page
select * 
from
(
    select * from board order by no desc
)
where rownum>0 and rownum<=5; --°á°ú°¡ ¾È ³ª¿È
--=> rownumÀº 1ÀÌ Æ÷ÇÔµÅ¾ßÇÔ

select rownum as RNUM, A.*
from
(
    select * from board order by no desc
)A
where RNUM>0+5 and RNUM<=5+5;