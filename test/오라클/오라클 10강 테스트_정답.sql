--[ 오라클 10 강 ]
--(1) 1, 2, 3 정규화에 대해 설명하시오.

제 1 정규화
       - 반복되는 속성이나 Group 속성 제거하고 기본테이블의 기본키를 추가해 새로운 테이블을 생성하고 
       기존의 테이블과 1:N의 관계를 형성한다.
제 2 정규화
       - 복합키( Composit Primary Key )로 구성된 경우 해당 테이블 안의 모든 컬럼들은 복합키 전체에
        의존적이어야 한다.
	만일 복합키 일부에 의존적인 컬럼이 존재한다면 제거해야 한다.
제 3 정규화
      - 기본키(Primary Key)에 의존하지 않고 일반 컬럼에 의존하는 컬럼들을 제거한다. 


--(2) panmae 테이블을 사용하여 판매내역을 출력하되 판매일자, 판매량, 누적 판매량을 출력하시오.
--판매 일자별로 정렬하여 누적할 것
select p_date, qty_tot, 
    sum(qty_tot) over(order by p_date) 누적판매량
from(
    select p_date, sum(p_qty) qty_tot
    from panmae
    group by p_date
);

--(3) 상품이 입고되면 재고 테이블에서 자동으로 해당 상품의 재고 수량과 금액이 증가되는 트리거를 작성하시오.
create or replace trigger tr_jaejo
after insert on 입고
for each row
begin
    update 재고
    set 수량=수량+:new.수량, 금액=금액+:new.금액
    where 품번=:new.품번;           
end;

insert into 입고 values(100, 2, 1800);

--(4) emp2 테이블을 사용하여 사번, 이름, 급여, 부서번호, 부서별 급여순위를 조회하시오
 select empno, name, pay,deptno, 
    rank() over(partition by deptno order by pay desc) "RANK"
from emp2;

--(5) 학과(deptno1)가 101번이고 3학년(grade) 이상의 학생의 이름(name), 아이디(id), 학년(grade) 데이터 가져오기.
select name, id,grade
from student 
where deptno1=101 and grade >=3; 
 
--(6)교수테이블에서 급여(pay)가 300에서 400사이인 교수의 이름(name), 아이디(id), 급여(pay) 데이터 가져오기
select name,id,pay
from professor
where pay between 300 and 400;
 
--(7)교수 테이블에서 직급(position)이 전임강사, 조교수인 이름(name), 아이디(id), 직급(position), 급여(pay) 데이터가져오기
select name, id, position, pay
from professor
where position in ('전임강사','조교수');
 
--(8) 교수 테이블에서 bonus을 받지 않는 교수의 이름(name), 아이디(id), 직급(position)데이터 가져오기
select name, id, position
from professor
where bonus is null; 

--(9) pd 테이블에서 등록일(regdate) 이  2019-09-01 ~ 2019-09-27 일 사이의 데이터만 조회하기
--to_date 함수 이용하기
select * from pd
where regdate>='2019-09-01' 
and regdate<to_date('2019-09-27')+1;

--(10)학생테이블에서 학과(deptno1)별로 학생의 평균키 구하기
--평균키는 소수 이하 한자리만 나오도록 반올림한다(round 함수 이용)
select deptno1,avg(height), round(avg(nvl(height,0)),1) from student 
group by deptno1;


--(11) 학생 이름에 '신'이 들어간 학생들의 이름(name), 학년(grade), 주민번호(jumin), 전화번호(tel), 담당교수명(name) 데이터 가져오기
--student , professor 테이블 조인 (inner join 이용)
select s.name, s.grade, s.jumin,s.tel, p.name
from student s, professor p 
where s.profno = p.profno
and s.name like '%신%'; 

select s.name, s.grade, s.jumin,s.tel, p.name
from student s join professor p 
on s.profno = p.profno
and s.name like '%신%'; 

--(12) 김재수와  학과(deptno1)가 같은 학생들의 학번(studno), 이름(name), 학년(grade), 학과번호(deptno1)를 조회하되 이름(name)의 내림차순으로 조회
--서브 쿼리 이용 
SELECT studno, name, grade, deptno1 FROM student
WHERE deptno1=(SELECT deptno1 FROM student WHERE name = '김재수')
ORDER BY name desc;

--(13) 뷰 만들기 (뷰이름 : v_student)
--학생의 이름(name), 학년(grade), 담당교수명(name),학과명(dname) 데이터를 조회하는 뷰 만들기
--student , professor,department 테이블 조인 
--담당교수명은 별칭을 교수명으로 준다
--모든 학생이 출력되도록 한다(outer join)

create or replace view v_student
as
select s.name,s.grade,p.name as 교수명, d.dname 
from student s, professor p, department d
where s.profno=p.profno(+)
and s.deptno1 = d.deptno(+);

select s.name,s.grade,p.name as 교수명, d.dname 
from student s left outer join professor p
on s.profno=p.profno
left join department d
on s.deptno1 = d.deptno;


--(14) 위에서 만든 뷰(v_student)에서 학과(dname)가 공학과로 끝나는 학생만 조회하기
select * from v_student where dname like '%공학과';

--(15) professor 테이블에서 이름의 오름차순으로 정렬한 상태에서 상위 5명의 교수만 조회하기
--교수번호(profno), 이름(name), 직급(position), 학과번호(deptno) 조회
select profno, name, position, deptno 
from (select profno, name, position, deptno from professor order by name) 
where rownum<=5;

select profno, name, position, deptno,
    row_number() over(order by name) num
from 
(   select profno, name, position, deptno, 
    row_number() over(order by name) RNUM 
    from professor
) 
where RNUM<=5;


--(16) 테이블 만들기
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

--[3] 시퀀스 만들기 - member1_seq
--1부터 시작하고, 1씩 증가하는 시퀀스

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

--drop sequence member1_seq;
create sequence member1_seq
increment by 1
start with 1
nocache;

select * from member1;


--(17) 입력,수정, 삭제하기 - 처리 후 commit한다
--[1] zipcode1 테이블의 전체 칼럼에 데이터 입력하기 - 2건의 데이터를 입력한다
--우편번호 : 150-300, 시도: 서울, 구군: 마포, 동:대현동, 번지: 500~600번지, seq: 11
--우편번호 : 150-400, 시도: 서울, 구군: 서초, 동:논현동, 번지: 700~800번지, seq: 12

insert into zipcode1
values('150-300','서울','마포','대현동','500~600번지',11);
insert into zipcode1
values('150-400','서울','서초','논현동','700~800번지',12);
commit;

--[2] member1 테이블의 필수 컬럼에 데이터 입력하기
--member1테이블의 no 는 member1_seq => sequence 이용해서 자동증가하도록
insert into member1(no, userid, name, pwd, zipcodeno)
values(member1_seq.nextval, 'hong2','홍길동2','123',11);
commit;

select * from zipcode1;
select * from member1;

--[3] student 테이블에서 3학년(grade) 학생 중 키(height)가 172이상인 학생의 몸무게(weight)를 64로, 키를 180으로  수정하시오
select * from student where grade=3 and height>=172;

update student
set weight=64, height=180
where grade=3 and height>=172;

rollback;

--[4] professor 테이블에서 교수번호(profno)가 1001인 교수의 pay를 기존 pay에 20이 추가되도록 수정하시오
select * from professor where profno=1001;

update professor
set pay=pay+20 
where profno=1001;

rollback;

--[5] student 테이블에서 1학년 학생 중 이름이 '허우'인 사람을 삭제하시오 - rollback 한다
select * from student where grade=1 and name='허우';

delete from student
where grade=1 and name='허우';

rollback;



--(18) student 테이블과 professor 테이블을 참조하여 101번 학과에 소속되어 있는 학생과 교수들의 학번(교수는 교수번호), 
이름, 학과 번호를 출력

select '[교수]' as "구분", 
    profno, name, id, hiredate, deptno from professor
where deptno=101
union
select '[학생]' as "구분", 
    studno, name, id, birthday, deptno1 from student
where deptno1=101;


--(19) 저장 프로시저 만들기 (프로시저 이름: memberUpdate)
--[1] member1 테이블에서 no에 해당하는 회원의 정보를 수정하는 저장 프로시저 만들기
--hp, zipcodeno, addressDetail 컬럼의 정보를 수정한다

--[2] memberUpdate 프로시저를 이용해서 no가 1인 회원 정보 수정하기
create or replace procedure memberUpdate
(p_no     member1.no%type,
p_hp      member1.hp%type, 
p_zipcodeno       member1.zipcodeno%type, 
p_addressDetail   member1.addressDetail%type
)
is
begin
    update member1
    set hp=p_hp, zipcodeno=p_zipcodeno, addressDetail=p_addressDetail
    where no=p_no;
    
    commit;
    
    exception when others then
        dbms_output.put_line('member1 수정 에러!!');
        rollback;    
end;

--
exec memberUpdate(1, '010-700-3000', 2, '980번지')

select * from member1;
select * from zipcode1;

--(20) 조인의 종류에는 무엇이 있는지, 나열하고, 각각에 대해 설명하시오.
내부 조인(Inner Join)-양쪽 테이블에 같은 조건이 존재할 경우의 값만을 가져오는 조인
			-join에 참여하는 모든 테이블에 데이터가 존재하는 경우에만 결과값을 출력함
외부 조인(Outer Join)-한쪽 테이블에는 데이터가 있고 한쪽 테이블에 없는 경우에 데이터가 있는 쪽 테이블의 내용을 전부 출력하게 하는 방법
셀프 조인(Self Join)-원하는 데이터가 하나의 테이블에 다 들어 있을 경우, 자기 자신 테이블과 조인하는 것
