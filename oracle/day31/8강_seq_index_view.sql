--8강_seq_index_view.sql
--[2019-10-10 목]
--sequence
/*
    - 연속적인 숫자를 생성해내는 객체
    - 기본 키가 각각의 입력되는 row를 식별할 수 있기만 하면 된다고 할 때, 
      시퀀스에 의해 생성된 값을 사용
    - 테이블에 있는 기본키 값을 생성하기 위해 사용되는 독립적인 객체
    - 테이블에 종속되지 않음 => 하나의 시퀀스를 여러 개의 테이블에 동시에 사용할 수 있다.
    
    create sequence 시퀀스명
    minvalue    --시퀀스의 최소값
    maxvalue    --시퀀스의 최대값
    start with  --시작값
    increment by    --증가치
    nocache         --cache 사용하지 않겠다
    cycle           --생성된 시퀀스 값이 최대치 혹은 최소치에 다다랐을 때
                      초기값부터 다시 시작할 찌 여부
    order           --요청되는 순서대로 값을 생성
    
    ※ 시퀀스 사용
    nextval, currval 의사컬럼
    1) nextval - 바로 다음에 생성될 시퀀스를 가지고 있다
    2) currval - 현재 시퀀스값을 가지고 있다
*/
select * from pd;

create table pd_temp1
as
select * from pd
where 1=0;

select * from user_constraints
where table_name='PD_TEMP1';

alter table pd_temp1
add constraint pk_pd_temp1_no primary key(no);

--시퀀스 생성
create sequence pd_temp1_seq
minvalue 1
maxvalue 9999999999999  --9가 13개
increment by 1
start with 50  --50부터 시작해서 1씩 증가
nocache;

--사용자가 생성한 sequence 조회
select * from user_sequences;

select * from pd_temp1;

insert into pd_temp1(no, pdname, price, regdate)
values(pd_temp1_seq.nextval, '컴퓨터',1500000, sysdate); --seq:50

--
select pd_temp1_seq.currval from dual; --현재 시퀀스 번호 조회 50
select pd_temp1_seq.nextval from dual; --다음 시퀀스 번호 조회 51
--값이 증가되어 버림=> 이후 사용하면 그 다음값부터 처리됨
 
insert into pd_temp1(no, pdname, price, regdate)
values(pd_temp1_seq.nextval, '컴퓨터2',1600000, sysdate); --seq:52

--
create table pd2
(
    no      number  primary key,
    pdcode  char(3) not null,
    pdname  varchar2(100),
    price   number(10)  check(price>=0),
    company varchar2(100),
    regdate date default sysdate
);

--1부터 시작해서 1씩 증가하는 시퀀스 객체 생성
create sequence pd2_seq
increment by 1
start with 1
nocache;

--데이터 입력
insert into pd2(no, pdcode, pdname, price, company)
values(pd2_seq.nextval, 'A01','삼성노트북',2500000, '삼성');

insert into pd2(no, pdcode, pdname, price)
values(pd2_seq.nextval, 'B01','키보드',37000);

select * from pd2;

select * from user_sequences;

create sequence test_seq
increment by 1
start with 1;  --default값: 1~1*10의 28승, nocycle, noorder, cache
 
--시퀀스 삭제
--drop sequence 시퀀스명;

drop sequence test_seq;

--index
/*
인덱스
- 테이블의 데이터를 빨리 찾기 위한 꼬리표
- 인덱스가 없다면 특정한 값을 찾기 위해 모든 데이터 페이지를 다 뒤져야 함 
    => table full scan
- index seek
  : 인덱스를 사용하는 것이 더 효과적이라면, 오라클은 모든 페이지를 뒤지지 않고 
  인덱스 페이지를 찾아서 쉽게 데이터를 가져옴 
- 한 테이블에 여러 개의 인덱스를 생성할 수 있음
 
  create [unique] index 인덱스명
  on 테이블명(컬럼명1, 컬럼명2, ...)
*/
--primary key나 unique 제약조건을 주면 자동으로 unique index가 생성됨

select * from pd2;

--상품 코드 인덱스
create unique index idx_pd2_pdcode
on pd2(pdcode);

--상품명 인덱스
create index idx_pd2_pdname
on pd2(pdname);

--상품등록일, 회사 복합키 인덱스
create index idx_pd2_regdate_company
on pd2(regdate, company);

--인덱스 조회
select * from user_indexes where table_name='PD2';
select * from user_ind_columns where table_name='PD2';

select * from user_constraints where table_name='PD2';

select * from pd2
where pdcode='B01';

select * from pd2
where pdname='키보드';

select * from pd2
where regdate >= '2019-10-10' and company='삼성';

--인덱스 삭제
--drop index 인덱스명
drop index idx_pd2_pdcode;

--뷰 (view)
/*
- VIEW는 테이블에 있는 데이터를 보여주는 형식을 정의하는 
  SELECT문장의 덩어리라고 할 수 있음
  
- VIEW는 실제로 데이터를 가지고 있지는 않지만 
  뷰를 통해 데이터를 조회할 수 있고 또 데이터를 입력 수정 삭제할 수 있으며 
  다른 테이블과 조인도 할 수 있기 때문에 가상의 논리적인 테이블이라고 함

- 뷰에는 실제 데이터가 존재하지 않는다
  실제 데이터는 원 테이블에만 존재하고 뷰는 이를 보여주는 창문이라고 생각

    create [or replace] view 뷰이름
    as
    select문장;
    
    ※ 뷰를 사용하는 목적
    [1] 보안성
    [2] 편의성
*/
--testuser 사용자는 emp의 영업부 사원들의 기본정보(이름, job, 입사일)를 검색할 수 있어야 한다면?
--=> hr 사용자가 emp 테이블의 일부 컬럼만 볼 수 있는 뷰를 만들어서
--testuser가 해당 뷰를 볼 수 있게 한다
select * from emp;

--1) hr계정에게 뷰 생성 권한을 부여해야 함
--sys 관리자 계정에서 권한 부여를 해야 함
--grant create view to hr;

--view 생성 권한 제거하기
--revoke create view from hr;

--2) hr 사용자가 뷰를 만든다
create or replace view v_emp
as
select ename, job, hiredate
from emp
where deptno=30;

--select * from 테이블 또는 뷰
select * from v_emp;  --생성한 뷰 조회

--3) testuser에게 해당 뷰를 select할 수 있는 권한을 부여한다
/*
    -sys계정에서 testuser 사용자 계정 만들기
    
    create user testuser
    identified by testuser123
    default tablespace users;
    
    -권한 부여하기
    grant resource, connect to testuser;
    
    -접속하기
    conn testuser/testuser123
*/

grant select on v_emp to testuser; --hr계정의 뷰이므로 select권한부여가 가능

--권한제거
--revoke select on v_emp from testuser;

--4) testuser계정에서 뷰 select 하기
--select * from hr.v_emp; --스키마이름.데이터베이스오브젝트명

--뷰 변경하기
--testuser 사용자가 research부서의 사원정보도 조회해야 한다면?
create or replace view v_emp
as
select ename, job, hiredate
from emp
where deptno in (20,30);

select * from dept;
select * from emp;

--testuser에서 확인
select * from v_emp;

--영업부, research부에 속하는 사원들 중에
--1982년 이전에 입사한 사람의 정보(이름,직무,입사일)을 조회하려면?
--1) v_emp 뷰 이용
select * from v_emp
where hiredate<'1982-01-01'; 

--2) emp 테이블 이용
select * from emp
where deptno in (20,30) and hiredate<'1982-01-01';

--조인을 이용하는 경우나 복잡한 쿼리문의 경우 뷰를 만들어서 사용
--employees, departments 조인
create or replace view v_employees
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME as name,
    e.HIRE_DATE, e.DEPARTMENT_ID, d.DEPARTMENT_name,
    nvl2(e.COMMISSION_PCT, e.SALARY+e.SALARY*e.COMMISSION_PCT, e.SALARY)
    as pay    
from employees e join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--
select * from v_employees;

--해당 뷰에서 급여가 10000 이상인 사원 조회하기
select * from v_employees
where pay>=10000;

--gogak 에서 고객 정보와 고객의 성별(gender), 나이(age) 정보를 view로 만들기
--v_gogak_info
create or replace view v_gogak_info
as
select gno, gname, jumin, point,
    case when substr(jumin,7,1) in ('1','3') then '남'
         else '여' end gender,
    extract(year from sysdate) - (substr(jumin,1,2)
        +case when substr(jumin,7,1) in ('1','2') then 1900 else 2000 end
        ) + 1 as age     
from gogak;

--해당 뷰를 이용하여 20대, 30대 여자만 조회하기
select * from v_gogak_info
where trunc(age, -1) in (20,30) and gender='여';

--cf. inline view 이용
select *
from
(
    select gno, gname, jumin, point,
    case when substr(jumin,7,1) in ('1','3') then '남'
         else '여' end gender,
    extract(year from sysdate) - (substr(jumin,1,2)
        +case when substr(jumin,7,1) in ('1','2') then 1900 else 2000 end
        ) + 1 as age     
    from gogak
)
where trunc(age, -1) in (20,30) and gender='여';

--뷰를 통한 데이터 수정
/*
    1. 뷰를 통한 조회도 가능하고, 입력,수정,삭제도 가능함 => updatable view
    2. 조회만 가능한 뷰도 있음 => read only view
*/
--updatable view 만들기
/*
    create or replace view 뷰이름
    as
    select문
*/

--read only view 만들기
/*
    create or replace view 뷰이름
    as
        select문
    with read only;
*/

create or replace view v_emp_readonly
as
    select ename, job, hiredate
    from emp
    where deptno in (20,30)
with read only;

select * from v_emp_readonly; --readonly view
select * from v_emp; --updatable view

update v_emp_readonly
set ename='SMITH2'
where ename='SMITH';  --ERROR: readonly view는 수정 불가

update v_emp
set ename='SMITH2'
where ename='SMITH';  --updatable view는 입력,수정,삭제 가능

insert into v_emp(ename, job, hiredate)
values('홍길동','CLERK', sysdate);  --error:null을 empno에 넣을 수 없다
--=> 뷰를 통한 입력을 하는 경우, 뷰에 없는 컬럼은 null을 허용하거나
--default값이 있어야 함. 그렇지 않으면 에러 발생

select * from v_emp;
select * from emp;

create or replace view v_emp_2
as
select empno, ename, job, hiredate
from emp
where deptno in (20,30);

insert into v_emp_2(empno,ename, job, hiredate)
values(9999,'홍길동','CLERK', sysdate);  --입력 가능
--뷰의 조건을 벗어나는 범위이지만 입력 가능함

select * from v_emp_2
where empno=9999; --입력은 되었지만 뷰의 조건을 벗어나므로, 뷰에서는 조회 불가
select * from emp
where empno=9999;  --테이블에서는 조회 가능

delete from v_emp_2
where empno=9999; --뷰의 조건을 벗어나므로, 조회도 안되고 삭제도 안됨

select * from emp
where empno=8888;
delete from emp
where empno=8888;

/*
    기본적으로 뷰를 만들때 뷰의 조건을 벗어나는 범위로 데이터를 수정할 수 있으며
    이를 허용하지 않고자 할때는 with check option을 사용
*/
create or replace view v_emp_3
as
select empno, ename, job, hiredate
from emp
where deptno in (20,30)
with check option; --뷰의 조건을 벗어나는 범위로는 데이터 변경 불가

select * from v_emp_3;

insert into v_emp_3(empno,ename, job, hiredate)
values(9997,'김길동','SALESMAN', sysdate);  --error: with check option위배

select * from v_emp_3
where empno=9999; 

select * from user_views;

--분석함수
/*
[1] 순위함수
rank, dense_rank, row_number
- partition 절에 있는 각 행의 순위를 리턴해 주는 함수

rank | dense_rank | row_number(expr)
OVER ( <partition  by 컬럼>
	<order by 컬럼> )
*/
--예) 급여가 높은 순서대로 순위를 부여하여 출력하시오
select * from employees;

select employee_id, first_name, salary, department_id, 
    rank() over(order by salary desc) as "전체순위-rank",
    rank() over(partition by department_id order by salary desc) 
        as "부서내순위-rank",
    dense_rank() over(order by salary desc) as "전체순위 dense_rank",
    dense_rank() over(partition by department_id order by salary desc) 
        as "부서내순위 dense_rank",
    row_number() over(order by salary desc) as "전체순위 row_number",
    row_number() over(partition by department_id order by salary desc) 
        as "부서내순위 row_number"        
from employees
order by department_id;   

--급여가 가장 많은 사원 5명 (1~5위)만 조회하기
--rank 이용
select employee_id, first_name, salary, 
    rank() over(order by salary desc)
from employees
where rank() over(order by salary desc)<=5;  --error
--rank등 분석함수는 where절에 올 수 없다
--=> inline 뷰 이용

select *
from
(
    select employee_id, first_name, salary, 
        rank() over(order by salary desc) RANK
    from employees
)A
where A.RANK<=5;

--top-n 분석
--입사일 기준으로 정렬한 후 조회하기 - emp
select row_number() over(order by hiredate desc) NO, empno, ename, hiredate
from emp;

select rownum NO, empno, ename, hiredate
from
(
    select * from emp order by hiredate desc
);

select rownum NO, empno, ename, hiredate from emp;

select row_number() over (order by empno) NO,
empno, ename, hiredate from emp;

--최근에 입사한 7명을 순서대로 조회
--1)rownum이용
select rownum NO, empno, ename, hiredate
from
(
    select * from emp order by hiredate desc
)
where rownum<=7;

select row_number() over(order by hiredate desc) NO, empno, ename, hiredate
from emp;
--where row_number() over(order by hiredate desc)<=7; --error

select *
from
(
    select row_number() over(order by hiredate desc) NO, empno, ename, hiredate
    from emp
)
where NO<=7;

--2)row_number() 이용


/*) professor 테이블에서 교수들의 교수번호와 이름, 급여, 급여 순위
를 조회하시오
? 2) 1번 예제에서 급여를 가장 많이 받는 3명만 조회하시오
? 3) emp 테이블을 사용하여 사번, 이름, 급여, 부서번호, 부서 내 job별
로 급여순위를 조회하시오
? 4) 2번 예제를 뷰로 만드시오.
*/

/*
? 장바구니 테이블과 상품 테이블을 이용하여 장바
구니 내용을 조회
? 아이디, 상품명, 가격, 수량, 합계(가격*수량) 컬럼 조회
? 게시판과 한줄 답변 테이블을 이용하여 게시판번
호, 작성자, 제목, 내용, 한줄답변 번호, 작성자, 내
용, 작성일을 조회(조인)
? 각각 뷰 만들기
*/