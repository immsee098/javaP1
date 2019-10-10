--[ 오라클 7강 ]

--(1) professor 테이블에서 이름의 오름차순으로 정렬한 상태에서 상위 5명의 교수만 조회하기
--교수번호(profno), 이름(name), 직급(position), 학과번호(deptno) 조회
select profno, name, position, deptno 
from (select profno, name, position, deptno from professor order by name) 
where rownum<=5;


--(2) 테이블 만들기
--[1] 우편번호 테이블 만들기 - zipcode1
/*zipcode  우편번호
sido 시도
gugun 구군
dong 동
bunji 번지
seq -번호, 기본키
*/

--[2] 회원테이블 만들기 - member1
/*
no - 번호, 기본키
userid  아이디, unique, 반드시 값 입력되도록
name   이름, 반드시 값 입력되도록
pwd    비밀번호 , 반드시 값 입력되도록
hp 휴대폰번호
zipcodeno   반드시 값 입력되도록, 우편번호 테이블의  번호(seq)와 연결-외래키
addressDetail 상세주소
regdate  가입일, 기본값:현재일자
mileage  마일리지, 기본값 :0,  0~1000000 사이의 값만 들어가도록
*/


--drop table zipcode1 cascade constraint;
create table zipcode1
(
 zipcode varchar2(10),
 sido varchar2(30),
 gugun varchar2(30),
 dong varchar2(200),
 bunji varchar2(100),
 seq number primary key
);

select * from zipcode1;

--drop table member1 cascade constraint;
create table member1
(
    no           number        primary key,
    userid     varchar2(20)   unique not null,
    name      varchar2(20)    not null,
    pwd        varchar2(15)    not null,
    hp            varchar2(20)    null,
    zipcodeNo    number  references zipcode1(seq) not null,    
    addressDetail    varchar2(100)   null,
    regdate     date        default sysdate,
    mileage        number   default 0 check(mileage>=0 and mileage<=1000000)
);


select * from member1;


--(3) 입력,수정, 삭제하기 - 처리 후 commit한다
--[1] zipcode 테이블의 전체 칼럼에 데이터 입력하기 - 2건의 데이터를 입력한다
--우편번호 : 120-100, 시도: 서울, 구군: 강남, 동:역삼동, 번지: 100~200번지, seq: 1
--우편번호 : 120-200, 시도: 서울, 구군: 서초, 동:방배동, 번지: 300~400번지, seq: 2

insert into zipcode1
values('120-100','서울','강남','역삼동','100~200번지',1);
insert into zipcode1
values('120-200','서울','서초','방배동','300~400번지',2);
commit;

--[2] member1 테이블의 필수 컬럼에 데이터 입력하기
insert into member1(no, userid, name, pwd, zipcodeno)
values(1, 'hong','홍길동','1234',1);
commit;

select * from zipcode1;
select * from member1;

--[3] student 테이블에서 4학년(grade) 학생 중 키(height)가 170이하인 학생의 몸무게(weight)를 50으로, 
--키를 166으로  수정하시오
select * from student where grade=4 and height<=170;

update student
set weight=50, height=166 
where grade=4 and height<=170;

rollback;

--[4] professor 테이블에서 교수번호(profno)가 1001인 교수의 pay를 기존 pay에 30이 추가되도록 수정하시오
select * from professor where profno=1001;

update professor
set pay=pay+30 
where profno=1001;

rollback;

--[5] student 테이블에서 1학년 학생 중 이름이 '허우'인 사람을 삭제하시오 - rollback 한다
select * from student where grade=1 and name='허우';

delete from student
where grade=1 and name='허우';

rollback;


--(4) 조인의 종류에는 무엇이 있는지, 나열하고, 각각에 대해 설명하시오.
/*
내부 조인(Inner Join)-양쪽 테이블에 같은 조건이 존재할 경우의 값만을 가져오는 조인
                   -join에 참여하는 모든 테이블에 데이터가 존재하는 경우에만 결과값을 출력함
외부 조인(Outer Join)-한쪽 테이블에는 데이터가 있고 한쪽 테이블에 없는 경우에 데이터가 있는 쪽 테이블의 내용을 전부 출력하게 하는 방법
셀프 조인(Self Join)-원하는 데이터가 하나의 테이블에 다 들어 있을 경우, 자기 자신 테이블과 조인하는 것
*/

--(5) 게시판(board), 한줄 답변(댓글, comments) 테이블 만들기
create table board
(
    no                number        primary key,    --번호
    name        varchar2(20)    not null,            --이름    
    pwd            varchar2(20)    not null,            --비밀번호
    title            varchar2(100)     not null,            --제목
    email        varchar2(80)    null,            --이메일
    regdate         date            default  sysdate,    --작성일
    --regip        varchar2(15)     null,            --작성IP
    readcount    number        default 0     null,        --조회수
    content        clob            null            --내용
);


CREATE TABLE comments (
    no                number        primary key,    --번호
    name             varchar2(20)    not null,            --이름    
    pwd              varchar2(20)    not null,            --비밀번호
    regdate         date        default  sysdate,    --작성일
    content         varchar2(2000)         null,            --내용
    bdNo            number references board(no) on delete cascade not null --원본 게시판 글번호   
);



--(6) professor 테이블에서 pay 컬럼의 값을 다음과 같이 수정하시오.
--부서번호가 101이나 102인 교수를 대상으로 pay 컬럼의 값을 직급이 ‘정교수’ 인 교수는 
--현 급여(pay)의 5%, ‘조교수’ 는 현 급여의 10%, 전임강사는 현 급여의 15%로 수정하시오.
select * from professor;

update professor
set pay= case position when '정교수' then pay*1.05
                       when '조교수' then pay*1.1
                       when '전임강사' then pay*1.15
                       end
where deptno in (101,102); 
                           
rollback;



--(7) 각 부서에 속하는 사원정보(부서번호, 사원번호, 사원이름, 직급, 급여)를 조회하고, 
--부서별 평균급여도 출력하시오 -emp2
--inline view 이용
select * from emp2;

 select e.deptno "부서번호", 
 e.empno,  e.name,  e.position, e.pay, B."부서별 평균급여" 
 from emp2 e  left join
 (
    select deptno, 
    round(avg(nvl(pay,0)), 1) "부서별 평균급여"
    from emp2
    group by deptno
 ) B 
 on e.deptno = B.deptno
 order by 1,2;

