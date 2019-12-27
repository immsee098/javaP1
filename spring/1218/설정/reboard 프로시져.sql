select * from reboard;

select * from user_source;

exec delete_reboard(11,10,1);

commit;

select * from managers;
select * from member;
select * from authority;