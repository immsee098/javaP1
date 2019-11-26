select * from board order by no desc;

insert into board(no, name, pwd, title, email, regdate, readcount, content)
select board_seq.nextval,
name, pwd, title, email, sysdate, readcount, content
from board;

commit;