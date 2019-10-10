--[ 오라클 7강 ]

--(1) professor 테이블에서 이름의 오름차순으로 정렬한 상태에서 상위 5명의 교수만 조회하기
--교수번호(profno), 이름(name), 직급(position), 학과번호(deptno) 조회
select profno, name, position, deptno 
from professor
where rownum <=5
order by name;


--(2) 테이블 만들기
--[1] 우편번호 테이블 만들기 - zipcode1
/*zipcode  우편번호
sido 시도
gugun 구군
dong 동
bunji 번지
seq -번호, 기본키
*/
create table zipcode1
(
    zipcode varchar2(5), --우편번호
    sido varchar2(40),--시도
    gugun varchar2(50),--구군
    dong varchar2(50),--동
    bunji varchar2(30),--번지
    seq number primary key, --번호, 기본키 
    constraint pl_zipcode_zipcode foreign key(zipcode) references member1(zipcodeno)
);

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

drop table member1;
create table member1
(
    no number primary key, --번호, 기본키
    userid varchar2(30) unique, --아이디, unique, 반드시 값 입력되도록
    name varchar2(10) not null,--이름, 반드시 값 입력되도록
    email varchar2(50),--이메일
    hp varchar2(13),--휴대폰번호
    zipcodeno varchar2(5) unique,--우편번호
    address clob,--주소(시도, 구군, 동)
    addressDetail clob, --상세주소
    regdate varchar2(30) default sysdate,--가입일, 기본값:현재일자
    mileage number check(mileage>0 and mileage<1000000)--마일리지, 기본값 :0, 0~1000000 사이의 값만 들어가도록
);



--(3) 입력,수정, 삭제하기 - 처리 후 commit한다
--[1] zipcode 테이블의 전체 칼럼에 데이터 입력하기 - 2건의 데이터를 입력한다
--우편번호 : 120-100, 시도: 서울, 구군: 강남, 동:역삼동, 번지: 100~200번지, seq: 1
--우편번호 : 120-200, 시도: 서울, 구군: 서초, 동:방배동, 번지: 300~400번지, seq: 2


--[2] member1 테이블의 필수 컬럼에 데이터 입력하기


--[3] student 테이블에서 4학년(grade) 학생 중 키(height)가 170이하인 학생의 몸무게(weight)를 50으로, 
--키를 166으로  수정하시오


--[4] professor 테이블에서 교수번호(profno)가 1001인 교수의 pay를 기존 pay에 30이 추가되도록 수정하시오
update professor
set pay=pay+30
where profno=1001;


--[5] student 테이블에서 1학년 학생 중 이름이 '허우'인 사람을 삭제하시오 - rollback 한다
delete from student 
where grade=1 and name='허우';

rollback;

select * from student;


--(4) 조인의 종류에는 무엇이 있는지, 나열하고, 각각에 대해 설명하시오.
/*
1. 이너조인
2. 외부조인
3. 셀프조인
4. 크로스조인
*/


--(5) 게시판(board), 한줄 답변(댓글, comments) 테이블 만들기



--(6) professor 테이블에서 pay 컬럼의 값을 다음과 같이 수정하시오.
--부서번호가 101이나 102인 교수를 대상으로 pay 컬럼의 값을 직급이 ‘정교수’ 인 교수는 
--현 급여(pay)의 5%, ‘조교수’ 는 현 급여의 10%, 전임강사는 현 급여의 15%로 수정하시오.



--(7) 각 부서에 속하는 사원정보(부서번호, 사원번호, 사원이름, 직급, 급여)를 조회하고, 
--부서별 평균급여도 출력하시오 -emp2
--inline view 이용

