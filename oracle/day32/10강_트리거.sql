--10강_트리거.sql
--[2019-10-14 월]
/*
    트리거
    - 서브 프로그램 단위의 하나인 트리거는 테이블, 뷰, 스키마 또는 데이터베이스에 
    관련된 PL/SQL 블록(또는 프로시저)으로 관련된 특정 사건(event)이 발생될 때마다 
    자동으로 해당 PL/SQL 블록이 실행됨
    
    - insert, update, delete의 DML문이나 DDL문의 실행을 데이터베이스에서는 
    특정 이벤트가 발생되었다고 하는데, 
    이런 이벤트가 발생하면 자동으로 정해진 동작을 실행하는 데이터베이스 객체를 
    트리거라고 함
    
    주요 트리거 유형
    [1] DML 트리거
    1) 문장 트리거 - 영향을 받는 행이 전혀 없더라도 트리거가 한번은 실행됨
    2) 행 트리거 - 테이블이 트리거 이벤트의 영향을 받을 때마다 실행되고,
        트리거 이벤트의 영향을 받는 행이 없을 경우에는 실행되지 않음
    
    [2] DML이 아닌 트리거
    1) DDL 이벤트 트리거
    - DML 트리거와 거의 동일하지만 트리거를 활용하여 DDL작업을 하는 것만 다름
    
    2) 데이터베이스 이벤트 트리거
    - 데이터베이스 내에서 생기는 일들을 관리하기 위해서 생성하는 트리거    
*/

/*
    create or replace trigger 트리거 이름
        트리거 실행시점 [before | after]
        이벤트 [insert | update | delete]
        on {테이블이름 | 뷰이름 | 스키마 | 데이터베이스}
    [for each row]
    begin
        트리거 몸체
    end;    
*/

--[1] 부서 테이블(dept)에 insert문 실행 후 메시지를 출력하는 트리거(문장 레벨 트리거)
create or replace trigger tr_dept_insert
after insert on dept
begin
    dbms_output.put_line('정상적으로 입력되었습니다.');
end;

select * from user_triggers; --사용자가 만든 트리거 정보 조회

select * from dept;

insert into dept(deptno, dname, loc)
values(50, 'TEST', 'seoul'); --dept 테이블에 insert 이벤트가 발생한 후에
--tr_dept_insert 트리거가 수행됨

--[2] 테이블에 데이터를 입력할 수 있는 시간 지정하기(문장 레벨 트리거)
create table t_order(
    no number,
    ord_code    varchar2(10),
    ord_date    date
);

--입력시간이 17:40 ~ 17:50 일 경우만 입력을 허용하고, 
--그 외 시간일 경우는 에러를 발생시키는 트리거
drop trigger tr_check_time;

create or replace trigger tr_check_time
before insert on t_order
begin
    if to_char(sysdate, 'HH24:mi') not between '18:40' and '18:50' then
        raise_application_error(-20009, '17:40~17:50일 경우에만 입력가능!');
    end if;
end;

insert into t_order(no, ord_code, ord_date)
values(3, 'A03', sysdate);

select * from t_order;

--[3] 테이블에 입력될 데이터 값을 지정하고, 그 값 외에는 에러를 발생시키는 트리거
--(행 레벨 트리거)
--제품 코드가 'C100'인 제품이 입력될 경우 입력을 허용하고, 
--나머지 제품은 모두 에러를 발생시키는 트리거
create or replace trigger tr_code_check
before insert on t_order
for each row  --행 레벨 트리거
begin
    if :new.ord_code != 'C100' then
        raise_application_error(-20010, '제품코드가 C100인 제품만 입력 가능!');
    end if;
end;

insert into t_order(no, ord_code, ord_date)
values(4, 'C100', sysdate);  --입력 성공

insert into t_order(no, ord_code, ord_date)
values(5, 'C200', sysdate);  --error

/*
old - 변경할 때 변경 전의 값을 가지고 있음
new - 데이터가 추가 혹은 변경되면 new 연산자로 변경 후의 값을 얻을 수 있음
user - 현재 접속중인 사용자를 나타냄
*/

--[4] 기존 테이블(t_test1)에 데이터가 업데이트될 때 기존 내용을 
--백업 테이블(t_test1_bak)로 이동시키는 트리거
create table t_test1(
    no number,
    name    varchar2(10)
);

create table t_test1_bak
as 
select * from t_test1;

insert into t_test1 values(1, 'AAA'); 
insert into t_test1 values(2, 'BBB'); 
commit;


create or replace trigger tr_backup_t_test1
after update on t_test1
for each row --행 레벨 트리거
begin
    insert into t_test1_bak(no, name)
    values(:old.no, :old.name);
end;

update t_test1
set name='CCC'
where no=1;

select * from t_test1;
select * from t_test1_bak;

update t_test1 
set name='DDD';  --2개의 행이 update됨 => 2번 행레벨 트리거가 수행됨

--