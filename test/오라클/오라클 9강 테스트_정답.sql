--[ 오라클 9강 ]
--(1) SQL과 일반 프로그래밍 언어의 특성을 결합한 언어로 변수, 상수 선언, 조건문, 반복문 사용이 가능한 언어를 
--무엇이라고 하는가?
--PL/SQL

--(2) exam_01 테이블에서 성적이 낮은 순으로 10명만 조회하는 뷰를 작성하시오.
create or replace view v_exam
as
select *
from
(
    select studno, total
    from exam_01
    order by total
)
where rownum<=10;       

select * from v_exam;

--(3) (선언부), (실행부), (예외처리부)가 하나의 PL/SQL 블록을 구성하고,
--오라클은 이 블록 단위로 처리한다.


--(4) PL/SQL 서브 프로그램은 데이터베이스 객체로 저장해서 필요할 때마다 호출하여 사용할 수 있는 PL/SQL 블록
--을 말한다. PL/SQL 서브 프로그램은 함수와 내장 프로시저로 나눌 수 있는데, 
--특정 기능을 수행한 뒤, 결과값을 반환하는 서브프로그램을 (함수)라고 하고, 
--결과값을 반환하지 않는 서브프로그램을 (내장 프로시저)라고 한다.
    
--(5) 주민번호를 넣으면 성별을 리턴하는 함수를 만들고, 함수를 실행시켜서 gogak 테이블에서 성별을 구하시오.
CREATE OR REPLACE FUNCTION get_gender
(
    --파라미터
    p_ssn   varchar2
)
return varchar2  --반환타입
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
        dbms_output.put_line('error!');
end;

--함수 실행시키기
select gname, jumin, get_gender(jumin) as gender
from gogak;

--(6) gogak 테이블의 gno컬럼에 기본키 제약조건을 추가하시오. 
alter table gogak
add constraint pk_gogak_gno primary key(gno);

--(7) gogak테이블의 gno에 자동으로 1씩 증가하는 값을 입력할 수 있도록 sequence를 생성하시오.
--20010033부터 시작하고 1씩 증가하도록 (gogak_seq)
create sequence gogak_seq
increment by 1
start with 20010033
nocache;

--(8) 생성한 시퀀스를 이용하여 gogak테이블에 값을 입력하는 프로시저를 작성하시오.
create or replace procedure gogak_insert
(
    --파라미터    
    p_gname    gogak.gname%type,
    p_jumin    gogak.jumin%type,
    p_point    gogak.point%type                                    
)
is   
begin    
    insert into gogak(gno, gname, jumin, point)
    values(gogak_seq.nextval, p_gname, p_jumin, p_point);
    
    commit;

    exception when others then
        dbms_output.put_line('gogak 테이블 insert error!');
        rollback;
end;

--(9) 작성한 프로시저를 실행시켜 고객을 입력하시오.    
exec gogak_insert('홍길동','9901021115555', 15000);

select * from gogak;

--(10) gogak테이블에서 고객번호로 고객레코드를 삭제하는 delete 프로시저를 작성하고, 실행시켜
--특정 고객레코드를 삭제하시오
create or replace procedure gogak_delete
(
    --파라미터    
    p_gno    gogak.gno%type                                  
)
is   
begin    
    delete from gogak where gno=p_gno;
    
    commit;

    exception when others then
        dbms_output.put_line('gogak 테이블 delete error!');
        rollback;
end;

exec gogak_delete(20010033);

select * from gogak;


--(11) exam10이라는 이름의 테이블스페이스를 생성하고, 
--데이터 파일에 대한 정보와 테이블스페이스에 대한 정보를 조회하시오.
create tablespace exam10
datafile 'C:\oraclexe\mydata\exam10.dbf' size 48m
autoextend on next 10m;

--데이터 파일에 대한 정보 조회 
select * from dba_data_files;
--테이블스페이스에 대한 정보 조회
select * from dba_tablespaces;


--(12) exam10 테이블스페이스를 사용하는 사용자계정을 생성하고, 사용자 계정 정보를 조회하시오.
--id: user1, pwd : u1234
create user user1
identified by u1234
default tablespace exam10;

select * from dba_users where username = 'USER1';

--(13) 생성한 사용자에게 Resource, Connect 권한(롤)을 부여하시오.
grant connect, resource to user1;

--(14) 사용자의 권한과 롤을 조회하시오
select * from dba_sys_privs where grantee='USER1';  --권한 조회
select * from dba_role_privs where grantee='USER1'; --롤 조회

--(15) 잠긴 계정 열기
alter user USER1 account unlock;

--(16) 기존 계정의 암호 변경하기 (USER1의 암호를 USER123으로 변경)
alter user USER1 identified by USER123;

--(17) 생성한 사용자계정을 삭제하시오.
drop user user1;

--(18) 생성한 테이블스페이스를 제거하되, 물리적인 데이터파일까지 삭제하시오.
    drop tablespace exam10
        including contents and datafiles;      


--(19) panmae 테이블을 사용하여 판매내역을 출력하되 판매일자, 판매량, 누적 판매량을 출력하시오.
--판매 일자별로 정렬하여 누적할 것
select p_date, qty_tot, 
    sum(qty_tot) over(order by p_date) 누적판매량
from(
    select p_date, sum(p_qty) qty_tot
    from panmae
    group by p_date
);


--(20) emp2 테이블을 사용하여 사번, 이름, 급여, 부서번호, 부서별 급여순위를 조회하시오
 select empno, name, pay,deptno, 
    rank() over(partition by deptno order by pay desc) "RANK"
from emp2;
