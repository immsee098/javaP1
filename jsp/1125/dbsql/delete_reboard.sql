create or replace procedure delete_reboard  --프로시저 이름 
(
--매개변수
    p_no number,
    p_groupNo number,
    p_step number

)
is

/*
exec delete_reboard(2,2,0); 넘버 그룹넘버 스탭
*/

--변수선언부
    cnt number;
begin
--처리할 내용
    --답변있는 원본글인 경우 delflag를 Y로 update, 나머지는 delete
    if p_step=0 then --원본글
        select count(*) into cnt
        from reboard
        where groupno=p_groupno;
        
        if cnt>1 then --답변이 있는 경우
            update reboard
            set delflag='Y'
            where no=p_no;
        else --답변이없는경우
            delete from reboard
            where no=p_no;
        end if;
        
    else --답변글
        delete from reboard
        where no=p_no;
    end if;

    commit;

EXCEPTION
    WHEN OTHERS THEN
	raise_application_error(-20001, ' 실패!');
        ROLLBACK;
end;
