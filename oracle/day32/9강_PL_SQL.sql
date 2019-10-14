--9강_PL_SQL.sql
--[2019-10-11 금]
--PL/SQL
/*
    - Procedural language extension to Structured Query Language
    - SQL과 일반 프로그래밍 언어의 특성을 결합한 언어
    - 변수, 상수 선언 가능
    - 조건문, 반복문 사용 가능
*/
/*
    선언부
        - declare 키워드 사용
        - 변수나 상수를 선언하는 부분
        
    실행부
        - begin ~ end 키워드 사용
        - 변수에 값 할당, 조건문, 반복문, sql문장 등을 처리
        - 실행해야할 로직을 넣는 부분
    
    예외처리부
        - exception 키워드 사용
        - 실행부에서 예외가 발생했을 때 처리하는 부분    
*/
--선언부,실행부,예외처리부가 하나의 PL/SQL 블록을 구성하고,
--오라클은 이 블록단위로 처리함

declare  --선언부 - 변수를 선언하는 부분
    counter number;
begin  --실행부-처리할 로직을 넣는 부분
    --변수에 값 할당
    counter := 1;
    
    --로직 처리
    counter:=counter/0;
    
    if counter is not null then
        dbms_output.put_line('counter=>' || counter);
    end if;
    
    --exception when others then  --예외처리부
    exception when ZERO_DIVIDE then
        dbms_output.put_line('0으로 나누면 안됩니다.');
end;    

--1~10 까지 for문 이용하여 반복처리
declare
    i   number;
    result  number;
begin
    for i in 1..10 loop
        result := i*2;
        dbms_output.put_line(result);
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--while문 이용
declare
    i   number;
    result  number;
begin
    i:=1;
    while i<=10 loop
        result := i*3;
        dbms_output.put_line(i || '*3 => ' || result);
        
        i:=i+1;
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--변수, 상수 선언
/*
    변수명 데이터타입;  --변수 선언
    변수명 constant 데이터타입;  --상수 선언
    변수명 테이블명.컬럼명%type;  --변수 선언
        => 해당 테이블의 해당 컬럼가 동일한 타입의 변수 선언
    
    예) name varchar2(30);
       curYear  constant    number := 2019;
       empNo    employees.employee_id%type;       
*/
select * from employees;

--조건문
/*
    1) if문
        if 조건1 then
            문장1;
        elsif 조건2 then
            문장2;
        else
            문장3;
        end if;
            
    2) case문
        case
        when 조건 then
            문장1;
        else
            문장2;
        end case;
*/
--if문 이용
declare
    grade   char;
    result  varchar2(50);
begin
    grade:='B';
    
    if grade='A' then
        result:='Excellent';
    elsif grade='B' then
        result:='Good';
    elsif grade='C' then
        result:='Fair';
    elsif grade='D' then
        result:='Poor';
    else
        result:='Not found!';        
    end if;
    
    dbms_output.put_line(grade || '=>' || result);
            
    exception when others then
        dbms_output.put_line('error!');
end;

--case문 이용
declare
    grade   char;
    result  varchar2(50);
begin
    grade:='C';
    
    case grade
        when 'A' then
            result:='Excellent';
        when 'B' then
            result:='Good';
        when 'C' then
            result:='Fair';
        when 'D' then
            result:='Poor';
        else
            result:='not found!';
    end case;
        
    dbms_output.put_line('case문 : ' || grade || '=>' || result);
                       
    exception when others then
        dbms_output.put_line('error!');
end;    

--반복문
/*
1) 
    loop
        exit when 조건;
        
    end loop;

2)
    for 변수 in [reverse] 초기값..종료값 loop
        처리할 문장;
    end loop;

3)
    while 조건 loop
        처리할 문장;
    end loop;
*/
--loop문 이용
declare
    i   number;
    result  number;
begin
    i:=1;
    
    loop
        result:=i*2; --2,...20,22
        
        exit when result>20;  --조건을 만족하면 반복문 탈출
        dbms_output.put_line(result); --2,...20
        
        i:=i+1; --10,11
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--for문
declare
    i   number;
    result  number;
begin
    for i in 1..10 loop
        result:=i*5;
        
        dbms_output.put_line('i=' || i || ', result=' || result);
    end loop;
    
    dbms_output.put_line('---------for문 reverse이용-------------');
    result:=0;
    
    for i in reverse 1..10 loop
        result:=i*4;
        
        dbms_output.put_line('i=' || i || ', result=' || result);
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--while문
declare
    i   number;
    result  number;
begin
    i:=1;
    result:=0;
    
    while result<20 loop
        result:=i*2; --2,..18,20
        dbms_output.put_line(result); --2..18,20
        
        i:=i+1; --2,..9,10,11
    end loop;
    
    exception when others then
        dbms_output.put_line('error!');
end;

--PL/SQL 서브 프로그램
/*
    - 데이터베이스 객체로 저장해서 필요할 때마다 호출하여 사용할 수 있는 PL/SQL블록
    
    1) 함수 (function) - 결과값을 반환함
        사용자 정의 함수를 말함
        특정 기능을 수행한 뒤, 결과값을 반환하는 서브프로그램
    2) 내장 프로시저, 저장 프로시저(stored procedure) - 결과값을 반환하지 않음
*/
--함수
/*
    create or replace function 함수명
    (파라미터1  데이터타입,
     파라미터2  데이터타입, ...)
        return 데이터타입
    
    is 또는 (as)
        변수 선언
    begin
        처리할 로직
        
        exception when others then
            예외처리할 문장
    end;        
*/
--주민번호를 넣으면 성별을 리턴하는 함수 만들기
create or replace function get_gender
(
    --파라미터
    p_ssn   varchar2
)
return  varchar2  --반환타입
is
    --변수선언
    v_gender    varchar2(10);
begin
    --처리할 로직
    select case when substr(p_ssn,7,1) in ('1','3') then '남자'
                else '여자' end
           into v_gender 
    from dual;
    
    return v_gender;
    
    exception when others then
        dbms_output.put_line('error');    
end;

--함수 실행시키기
select get_gender('1207093334444') from dual; --사용자 정의 함수
select length('java') from dual;  --오라클 함수

select studno, name, jumin, get_gender(jumin) from student;
select studno, name, jumin, length(name) from student;

--주민번호를 이용해서 나이를 구하는 함수 만들기
--get_age
create or replace function get_age
(
    --파라미터
    p_ssn   varchar2
)
return number   --반환타입
is
    --변수선언
    v_age  number;
begin
    --처리할 로직
    select extract(year from sysdate)-
        (substr(p_ssn,1,2) + case when substr(p_ssn,7,1) in ('1','2')
            then 1900 else 2000 end
        ) + 1 into v_age
    from dual;
    
    return v_age;
    
    exception when others then
        dbms_output.put_line('error');    
end;

select get_age('1301054447777') from dual;
select jumin, get_age(jumin) "나이", get_gender(jumin) "성별",
    trunc(get_age(jumin),-1)  "연령대"
 from gogak;

--stored procedure(저장 프로시저, 내장 프로시저)
--특정 기능을 수행하지만 값을 반환하지는 않는 서브 프로그램
/*
    create or replace procedure 프로시저명
    (
        파라미터1   데이터타입,
        파라미터2   데이터타입,
        ...
    )
    is[as]
        변수 선언부
    begin
        처리할 로직
        
        exception when others then
            예외처리
    end;
*/
select * from pd2;
select * from user_sequences;

--pd2 테이블에 입력하는 프로시저
create or replace procedure pd2_insert
(
    --파라미터
    --pd2 테이블에 insert할때 필요한 파라미터들
    p_pdcode    char,
    p_pdname    varchar2,
    p_price     number,
    p_company   varchar2
)
is
    --변수 선언부
begin
    insert into pd2(no, pdcode, pdname, price, company)
    values(pd2_seq.nextval, p_pdcode,p_pdname, p_price, p_company);
    
    commit;  --성공하면 커밋
    
    exception when others then
        dbms_output.put_line('pd2 테이블 insert error!');
        rollback; --실패하면 롤백
end;

--저장 프로시저 실행시키기
/*
    execute 프로시저이름(파라미터);
    또는
    exec 프로시저이름(파라미터);
*/
execute pd2_insert('C01','마우스',34000,'삼성');

exec pd2_insert('C02','모니터',470000,'LG');

select * from pd2 order by no desc;

--pd2 테이블 컬럼을 수정하는 프로시저 만들기
create or replace procedure pd2_update
(
    --파라미터
    p_no    pd2.no%type, --테이블명.컬럼명%type => 해당 테이블의 해당 컬럼과 동일한
                         --데이터 타입
                         --=> pd2테이블의 no 컬럼과 동일한 타입
    p_pdcode    pd2.pdcode%type,
    p_pdname    pd2.pdname%type,
    p_price    pd2.price%type,
    p_company    pd2.company%type                     
)
is
    --변수 선언부
    v_cnt   number(3);
begin
    select count(*) into v_cnt
    from pd2
    where no=p_no;
    
    --해당 데이터가 존재하면 update
    if v_cnt>0 then
        update pd2
        set pdcode=p_pdcode, pdname=p_pdname, price=p_price,
            company=p_company
        where no=p_no;
    end if;
    
    commit;
    
    exception when others then
        dbms_output.put_line('pd2 테이블 update error!');
        rollback;
end;

exec pd2_update(4,'B03','컴퓨터',1500000,'hp');

select * from pd2 order by no desc;

--저장 프로시저,함수 확인
select * from user_source
where name='PD2_UPDATE';

--exists 이용한 update
create or replace procedure pd2_update2
(
    --파라미터
    p_no    pd2.no%type,
    p_pdcode    pd2.pdcode%type,
    p_pdname    pd2.pdname%type,
    p_price    pd2.price%type,
    p_company    pd2.company%type  
)
is
begin
    update pd2 a
    set pdcode=p_pdcode, pdname=p_pdname, price=p_price,
        company=p_company
    where exists (select 1 from pd2 b where b.no=a.no
                    and b.no=p_no);
    commit;
    
    exception when others then
        raise_application_error(-20001, 'pd2 update 중 예외발생!');
        --사용자 정의 예외번호는 -20001 ~ 20999까지
        
        rollback;        
end;

exec pd2_update2(4, 'B04', '노트북', -50, 'LG'); --error

exec pd2_update2(4, 'B04', '노트북', 2000000, 'LG'); 

select * from pd2 order by no desc;

select * from user_constraints
where table_name ='PD2';
select * from user_cons_columns
where table_name ='PD2';

--%rowtype
/*
    - %type과 유사하나, 한 개 이상의 값에 대해 적용
    - 로우타입 변수를 선언해 테이블에 있는 row 대입 가능
*/
create or replace procedure prof_info
(
    p_profno    professor.profno%type
)
is
    --변수 선언
    v_prof_row  professor%rowtype; --professor 테이블의 한 개의
                                --row(레코드) 정보를 담을 수 있는 타입
    v_result    varchar2(2000);                            
begin
    select *  into v_prof_row 
    from professor
    where profno=p_profno;
    
    v_result:=v_prof_row.profno || ' ' ||
            v_prof_row.name || ' ' ||
            v_prof_row.position || ' ' ||
            nvl(v_prof_row.pay+v_prof_row.bonus,
                v_prof_row.pay);
    
    dbms_output.put_line(v_result);
    
    exception when others then
        raise_application_error(-20002, 'professor테이블 조회에러');            
end;

exec prof_info(1001);

select * from professor
where profno=1001;

--사용자 정의 예외
select * from member;

select * from user_sequences;

create sequence member_seq
start with 1005
increment by 1
nocache;

create or replace procedure member_insert
(
    --파라미터
    p_name  member.name%type,
    p_jumin  member.jumin%type,
    p_passwd  member.passwd%type,
    p_id  member.id%type
)
is
    --변수선언
    system_check_insert_fail    exception;  --사용자 정의 예외    
begin
    --일요일 23:00:00 ~ 23:59:59 사이에는 시스템 작업으로 인해 입력 불가
    /*if to_char(sysdate, 'd')=1 and to_char(sysdate,'hh24')=23 then
        raise system_check_insert_fail;  --강제로 사용자 정의 예외 발생시키기
    end if;*/
    
    if to_char(sysdate, 'd')=6 and to_char(sysdate,'hh24')=18 then
        raise system_check_insert_fail;  --강제로 사용자 정의 예외 발생시키기
    end if;
    
    --일요일 23시 시간대가 아니면 입력 가능
    insert into member(no, name, jumin, passwd, id)
    values(member_seq.nextval,p_name, p_jumin, p_passwd, p_id );
    
    commit;
    
    exception when system_check_insert_fail then
        raise_application_error(-20990, 
        '일요일 23:00:00~23:59:59 사이에는 시스템 점검작업으로 서비스 이용불가!');
        rollback;
end;

exec member_insert('홍길동2','9707051112222','1234','hong2');

select * from member;


--[2019-10-14 월]
--out 매개변수(파라미터)
--결과를 출력하는 용도의 매개변수

--in 매개변수 - 일반적인 매개변수, 입력용 매개변수
--생략하면 in 매개변수

create or replace procedure proc_prof
(
    p_profno    in  PROFESSOR.PROFNO%type,  --in 매개변수
    o_name      out professor.name%type,    --out 매개변수
    o_pay      out professor.pay%type    --out 매개변수
)
is
begin
    select name, pay into o_name, o_pay
    from professor
    where profno=p_profno;
    
    exception when others then
        raise_application_error(-20003, 'professor 조회 에러');
end;

--out 매개변수가 있는 프로시저 실행하기
declare
    v_name  professor.name%type;
    v_pay   professor.pay%type;
begin
    proc_prof(1001, v_name, v_pay);
    dbms_output.put_line('이름:' || v_name || ',급여:'||v_pay);
    
    exception when others then
        dbms_output.put_line('error!');
end;

--select procedure
create or replace procedure proc_pd2_select
is
begin
    select * from pd2;  --error
    --an INTO clause is expected in this SELECT statement
    
    exception when others then
        dbms_output.put_line('error!');
end;

--PL/SQL 커서
/*
커서
- 쿼리에 의해 반환되는 결과는 메모리 상에 위치하게 되는데, 
  PL/SQL에서는 커서를 사용하여 이 결과집합에 접근할 수 있다.
- 커서를 사용하면 결과집합의 각 개별 데이터에 접근이 가능하다.

명시적 커서
- 사용자가 직접 쿼리의 결과에 접근해서 이를 사용하기 위해 명시적으로 선언한 커서

명시적 커서를 사용하기 위한 절차
[1] 커서 선언 ? 쿼리 정의
cursor 커서명 is select 문장;

[2] 커서 열기(open) - 쿼리 실행
open 커서명;

[3] 패치(fetch) - 쿼리의 결과에 접근, 루프를 돌며 개별 값들에 접근
fetch 커서명 is 변수...;

[4] 커서 닫기(close) - 메모리상에 존재하는 쿼리의 결과를 소멸시킴
close 커서명;
*/
create or replace procedure proc_pd2_select
is
    --[1] 커서 선언
    cursor pd2_csr is
        select no, pdcode, pdname, price from pd2;
    
    --변수 선언
    pd2_rcd pd2%rowtype;
           
begin
    --[2] 커서 열기
    open pd2_csr;
    
    --[3] 패치(fetch) - 쿼리의 결과에 접근, 루프를 돌며 개별 값들에 접근
    loop
        fetch pd2_csr into pd2_rcd.no, pd2_rcd.pdcode,
            pd2_rcd.pdname, pd2_rcd.price;
        
        exit when pd2_csr %notfound;
        
        dbms_output.put_line(pd2_rcd.no|| ' ' || pd2_rcd.pdcode
            || ' ' || pd2_rcd.pdname || ' ' || pd2_rcd.price);
    end loop;
    
    --[4] 커서 닫기
    close pd2_csr;
    
    exception when others then
        raise_application_error(-20003, 'pd2조회 에러');
end;

exec proc_pd2_select();

select * from pd2;
/*
    %notfound - 커서에서만 사용 가능한 속성
    - 더 이상 패치(할당)할 로우가 없음을 의미
    - 쿼리의 마지막 결과까지 패치한 후에 자동으로 루프를 빠져나가게 됨
*/

--for loop cursor 문
/*
    커서의 for loop문을 사용하면 커서의 open, fetch, close가 자동적으로
    발생되어지기 때문에 open, fetch, close 문을 기술할 필요가 없다
    
    형식
    for 변수명(레코드 정보가 담기는 변수) in 커서명 loop
        실행 문장
    end loop;
*/
create or replace procedure proc_pd2_select2
is
    --커서 선언
    cursor pd2_csr is
        select no,pdcode,pdname,price from pd2;
begin
    for pd2_row in pd2_csr loop
        dbms_output.put_line(pd2_row.no || ' ' || pd2_row.pdcode
            || ' ' || pd2_row.pdname || ' ' || pd2_row.price);
    end loop;

    exception when others then
        raise_application_error(-20007, 'pd2 select error!');
end;

exec proc_pd2_select2;

--sys_refcursor
/*
저장 프로시저의 select 결과물을 JAVA 에서 읽기 위해서는 SYS_REFCURSOR 타입을 
사용해야 함
*/
create or replace procedure proc_pd2_select3
(
    pd2_cursor  out sys_refcursor
)
is
begin
    open pd2_cursor for
        select no, pdcode, pdname, price, company, regdate
        from pd2;
        
    exception when others then
        raise_application_error(-20004, 'pd2 테이블 조회중 에러!');
end;

--누적 합계 구하기
--제품 코드별, 날짜별 누적 판매량
select * from panmae;

select p_code 제품코드, p_date 판매일자, p_qty 판매량,
sum(p_qty) over(partition by p_code order by p_date) 누적판매량
from panmae
order by p_code, p_date; 

--제품코드별, 판매일자별, 판매량의 합계를 먼저 구한다
select p_code, p_date, sum(p_qty) as qty_total
from panmae
group by p_code, p_date
order by p_code, p_date;

--inline view 이용
select p_code, p_date,qty_total 판매량,
    sum(qty_total) over(partition by p_code order by p_date) 누적판매량
from
(
    select p_code, p_date, sum(p_qty) as qty_total
    from panmae
    group by p_code, p_date
);

--뷰 만들기
create or replace view v_panmae
as
select p_code, p_date,qty_total 판매량,
    sum(qty_total) over(partition by p_code order by p_date) 누적판매량
from
(
    select p_code, p_date, sum(p_qty) as qty_total
    from panmae
    group by p_code, p_date
);

select * from v_panmae;

--panmae 테이블을 사용하여 판매내역을 출력하되 판매일자, 판매량,판매금액,누적 판매량,
--누적 판매금액을 출력
select p_date, p_qty, p_total,
    sum(p_qty) over(order by p_Date) 누적판매량,
    sum(p_total) over(order by p_Date) 누적판매금액
from panmae;    

select p_date, sum(p_qty) qty_tot, sum(p_total) price_tot
from panmae
group by p_date
order by p_date;

select p_date, qty_tot, price_tot, 
    sum(qty_tot) over(order by p_date) "누적 판매량",
    sum(price_tot) over(order by p_date) "누적 판매금액"
from
(
    select p_date, sum(p_qty) qty_tot, sum(p_total) price_tot
    from panmae
    group by p_date
);

--p_store별, p_date별 누적 판매금액 구하기

select * from panmae;

select p_date, p_store, sum(p_qty) qty_tot, sum(p_total) price_tot
from panmae
group by p_date, p_store
order by p_date, p_store;

select p_date, p_store, qty_tot, price_tot,
    sum(qty_tot) over(partition by p_store order by p_date) "누적 판매량",
    sum(price_tot) over(partition by p_store order by p_date) "누적 판매금액"
from
(
select p_date, p_store, sum(p_qty) qty_tot, sum(p_total) price_tot
from panmae
group by p_date, p_store
order by p_date, p_store

);