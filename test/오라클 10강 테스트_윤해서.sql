--[ 오라클 10 강 ]
--(1) 1, 2, 3 정규화에 대해 설명하시오.
-- 데이터의 중복 저장으로 인해 발생할 수 있는 비 효율성과 데이터의 일관성이 깨지는 현상을 해결

--(2) panmae 테이블을 사용하여 판매내역을 출력하되 판매일자, 판매량, 누적 판매량을 출력하시오.
--판매 일자별로 정렬하여 누적할 것
select * from panmae;


--(3) 상품이 입고되면 재고 테이블에서 자동으로 해당 상품의 재고 수량과 금액이 증가되는 트리거를 작성하시오.


--(4) emp2 테이블을 사용하여 사번, 이름, 급여, 부서번호, 부서별 급여순위를 조회하시오
select * from emp
order by empno, sal;


--(5) 학과(deptno1)가 101번이고 3학년(grade) 이상의 학생의 이름(name), 아이디(id), 학년(grade) 데이터 가져오기.
select * from student
where deptno1=101 and grade>=3;
 
--(6)교수테이블에서 급여(pay)가 300에서 400사이인 교수의 이름(name), 아이디(id), 급여(pay) 데이터 가져오기
select * from professor
where pay>300 and pay<400;
 
--(7)교수 테이블에서 직급(position)이 전임강사, 조교수인 이름(name), 아이디(id), 직급(position), 급여(pay) 데이터가져오기
select * from professor
where position='전임강사';
 
--(8) 교수 테이블에서 bonus을 받지 않는 교수의 이름(name), 아이디(id), 직급(position)데이터 가져오기
select * from professor
where bonus is not null;

--(9) pd 테이블에서 등록일(regdate) 이  2019-03-07 ~ 2019-03-27 일 사이의 데이터만 조회하기
--to_date 함수 이용하기
select * from pd;


--(10)학생테이블에서 학과(deptno1)별로 학생의 평균키 구하기
--평균키는 소수 이하 한자리만 나오도록 반올림한다(round 함수 이용)
select deptno1, round(avg(height), 1)
from student
group by deptno1
order by deptno1;



--(11) 학생 이름에 '신'이 들어간 학생들의 이름(name), 학년(grade), 주민번호(jumin), 전화번호(tel), 담당교수명(name) 데이터 가져오기
--student , professor 테이블 조인 (inner join 이용)

select * from student
where name like '%신%';


--(12) 김재수와  학과(deptno1)가 같은 학생들의 학번(studno), 이름(name), 학년(grade), 학과번호(deptno1)를 조회하되 이름(name)의 내림차순으로 조회
--서브 쿼리 이용 
select studno, name, grade, deptno1 from student
where deptno1=(select deptno1 from student where name = '김재수')
order by name desc;


--(13) 뷰 만들기 (뷰이름 : v_student)
--학생의 이름(name), 학년(grade), 담당교수명(name),학과명(dname) 데이터를 조회하는 뷰 만들기
--student , professor,department 테이블 조인 
--담당교수명은 별칭을 교수명으로 준다
--모든 학생이 출력되도록 한다(outer join)



--(14) 위에서 만든 뷰(v_student)에서 학과(dname)가 공학과로 끝나는 학생만 조회하기



--(15) professor 테이블에서 이름의 오름차순으로 정렬한 상태에서 상위 5명의 교수만 조회하기
--교수번호(profno), 이름(name), 직급(position), 학과번호(deptno) 조회
select * from professor
where rownum<=5
order by name;



--(16) 테이블 만들기
--[1] 우편번호 테이블 만들기 - zipcode1
/*zipcode  우편번호
sido 시도
gugun 구군
dong 동
bunji 번지
seq -번호, 기본키
*/
create table zipcode2
(
    zipcode number not null,
    sido    varchar2(30) not null,
    gugun   varchar2(40),
    dong    varchar2(20),
    bunji   varchar2(30),
    seq     number primary key
       
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
create table member2
(
    no number primary key, --번호, 기본키
    userid varchar2(30) unique, --아이디, unique, 반드시 값 입력되도록
    name varchar2(10) not null,--이름, 반드시 값 입력되도록
    pwd varchar2(20) not null,--비밀번호 , 반드시 값 입력되도록
    hp varchar2(13),--휴대폰번호
    zipcode varchar2(5),--우편번허
    addressDetail clob, --상세주소
    regdate varchar2(30) default sysdate,--가입일, 기본값:현재일자
    mileage number check(mileage>0 and mileage<1000000)--마일리지, 기본값 :0, 0~1000000 사이의 값만 들어가도록
);

--[3] 시퀀스 만들기 - member1_seq
--1부터 시작하고, 1씩 증가하는 시퀀스

create sequence member1_seq
start with 1
increment by 1
nocache;



--(17) 입력,수정, 삭제하기 - 처리 후 commit한다
--[1] zipcode1 테이블의 전체 칼럼에 데이터 입력하기 - 2건의 데이터를 입력한다
--우편번호 : 150-300, 시도: 서울, 구군: 마포, 동:대현동, 번지: 500~600번지, seq: 11
--우편번호 : 150-400, 시도: 서울, 구군: 서초, 동:논현동, 번지: 700~800번지, seq: 12


--[2] member1 테이블의 필수 컬럼에 데이터 입력하기
--member1테이블의 no 는 member1_seq => sequence 이용해서 자동증가하도록


--[3] student 테이블에서 3학년(grade) 학생 중 키(height)가 172이상인 학생의 몸무게(weight)를 64로, 키를 180으로  수정하시오


--[4] professor 테이블에서 교수번호(profno)가 1001인 교수의 pay를 기존 pay에 20이 추가되도록 수정하시오


--[5] student 테이블에서 1학년 학생 중 이름이 '허우'인 사람을 삭제하시오 - rollback 한다


--(18) student 테이블과 professor 테이블을 참조하여 101번 학과에 소속되어 있는 학생과 교수들의 학번(교수는 교수번호), 이름, 학과 번호를 출력



--(19) 저장 프로시저 만들기 (프로시저 이름: memberUpdate)
--[1] member1 테이블에서 no에 해당하는 회원의 정보를 수정하는 저장 프로시저 만들기
--hp, zipcodeno, addressDetail 컬럼의 정보를 수정한다

--[2] memberUpdate 프로시저를 이용해서 no가 1인 회원 정보 수정하기


--(20) 조인의 종류에는 무엇이 있는지, 나열하고, 각각에 대해 설명하시오.
--inner join과 outer join


