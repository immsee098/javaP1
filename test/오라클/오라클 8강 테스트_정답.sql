--[ 오라클 8강 ]
--(1) dept 테이블의 deptno컬럼에 기본키 제약조건을 추가하시오. 
alter table dept
add constraint pk_dept_deptno primary key(deptno);

--(2) emp 테이블을 이용해서 새 테이블(emp_temp)을 만드시오.
create table emp_temp
as 
select * from emp;

select * from emp_temp;

--(3) 시스템 뷰를 이용해서 emp_temp 테이블의 제약조건을 조회하시오
select * from user_constraints
where table_name = 'EMP_TEMP';

--(4) 복사한 테이블인 emp_temp에 primary key(empno), foreign key(deptno), 
--check(sal은 0 이상만 들어가도록) 제약조건을 추가하시오.
alter table emp_temp
add constraint pk_emp_temp_empno primary key(empno);

alter table emp_temp
add constraint fk_emp_temp_deptno foreign key(deptno)
               references dept(deptno);

alter table emp_temp
add constraint pk_emp_temp_sal check(sal>=0);

--(5) emp_temp 테이블에 tel 컬럼을 추가하시오
alter table emp_temp
add tel varchar2(20);

select * from emp_temp;

--(6) tel컬럼의 데이터크기를 varchar2(30)으로 변경하시오.
alter table emp_temp
modify tel varchar2(30);

--(7) tel컬럼의 이름을 hp로 변경하시오.
alter table emp_temp
rename column tel to hp;

--(8) hp컬럼을 삭제하시오.
alter table emp_temp
drop column hp;

select * from emp_temp;

--(9) 연속적인 숫자를 생성해내는 데이터베이스 객체로 테이블에 있는 기본키 값을 생성하기 위해 사용되는 
--독립적인 객체는 무엇인가?
--sequence

--(10) emp_temp테이블의 empno에 자동으로 1씩 증가하는 값을 입력할 수 있도록 sequence를 생성하시오.
--8000부터 시작하고 1씩 증각하도록 (emp_temp_seq)
create sequence emp_temp_seq
increment by 1
start with 8000
nocache;

--(11) 시스템 뷰를 이용하여 사용자가 생성한 시퀀스를 조회하시오.
select * from user_sequences;

--(12) 생성한 시퀀스를 이용하여 emp_temp테이블에 값을 입력하시오.
insert into emp_temp(empno, ename, job, deptno)
values(emp_temp_seq.nextval, 'hong', 'CLERK', 10);

select * from emp_temp;

--(13) index란? 
-- 테이블의 데이터를 빨리 찾기 위한 꼬리표

--(14)  emp_temp테이블에서 ename을 이용하여 빨리 조회할 수 있도록 인덱스를 생성하시오.  
create index idx_emp_temp_ename
on emp_temp(ename);

--(15) 시스템 뷰를 이용하여 사용자가 생성한 인덱스를 조회하시오.
select * from user_indexes 
where table_name='EMP_TEMP';
select * from user_ind_columns 
where table_name='EMP_TEMP';
 
--(16) 뷰(View)란?
/*
    - view는 테이블에 있는 데이터를 보여주는 형식을 정의하는
      select문장의 덩어리하고 할 수 있다
      
    - view는 실제로 데이터를 가지고 있지는 않지만,
      뷰를 통해 데이터를 조회할 수 있고, 또 데이터를 입력,수정,삭제할 수 있으며
      다른 테이블과 조인도 할 수 있기 때문에 가상의 논리적 테이블이라고 함 */

--(17) student 테이블과 exam_01 테이블을 조회하여 학생들의 학번, 이름, 점수, 학점을 출력하는 뷰를 만드시오.
--(학점은 dcode나 case이용- 90 이상이면'A', 80이상이면 'B', 70이상이면 'C', 60이상이면'D' 
--60미만이면 'F' )
create or replace view v_exam
as
select s.studno, s.name, e.total,
 decode(trunc(total,-1), 100, 'A',90,'A',80,'B',70,'C',60,'D','F') grade
from student s join exam_01 e
on s.studno = e.studno;

--(18) 해당 뷰를 이용하여 학점이 A나 B나 C인 학생만 조회하시오.
select * from v_exam
where grade in ('A','B','C');

--(19)  시스템 뷰를 이용하여 사용자가 생성한 뷰를 조회하시오.
select * from user_views;      

--(20) employees 테이블에서 급여가 높은 순으로 5명만 조회하는 뷰를 작성하시오.
create or replace view v_emp_sal
as
select *
from
(
    select first_name, hire_date, salary
    from employees
    order by salary desc
)
where rownum<=5;       

--(21) professor 테이블에서 바비와  직급이(position) 같은 교수들의 정보를 조회하되 이름(name)의 
--내림차순으로 조회하는 뷰를 작성하시오
create or replace view v_professor
as
SELECT * FROM professor
WHERE position=(SELECT position FROM professor WHERE name = '바비')
ORDER BY name desc;




--[ 오라클 9강 ]
--(1) SQL과 일반 프로그래밍 언어의 특성을 결합한 언어로 변수, 상수 선언, 조건문, 반복문 사용이 가능한 언어를 
--무엇이라고 하는가?
--PL/SQL

--(2) (선언부), (실행부), (예외처리부)가 하나의 PL/SQL 블록을 구성하고,
--오라클은 이 블록 단위로 처리한다.

--(3) PL/SQL을 이용하여 1~20까지의 합을 구하시오 - for문 이용
declare
    result  number;
    i   number;
begin
    result :=0;
    
    for i in 1..20 loop
        result := result + i;    
    end loop;
    
    dbms_output.put_line('1~20까지의 합:'||result);
        
    exception when others then
        dbms_output.put_line('error!');
end;

--(4) PL/SQL을 이용하여 월에 따른 분기를 구하시오 - if 문 이용  
/*1~3 => 1사분기
4~6 => 2사분기
7~9 => 3사분기
10~12 => 4사분기*/

declare
    mon  number;
    result  varchar2(20);
begin
    mon := 10;
    if mon >= 1 and mon<=3 then
        result:= '1사분기';
    elsif mon >= 4 and mon<=6 then
        result := '2사분기';
    elsif mon >= 7 and mon<=9 then
        result := '3사분기';    
    else
        result := '4사분기';
    end if;
    
    dbms_output.put_line(mon || '=>' || result);
    
    exception when others then
        dbms_output.put_line('error!!!');
end;

--(5) PL/SQL 서브 프로그램은 데이터베이스 객체로 저장해서 필요할 때마다 호출하여 사용할 수 있는 PL/SQL 블록
--을 말한다. PL/SQL 서브 프로그램은 함수와 내장 프로시저로 나눌 수 있는데, 
--특정 기능을 수행한 뒤, 결과값을 반환하는 서브프로그램을 (함수)라고 하고, 
--결과값을 반환하지 않는 서브프로그램을 (내장 프로시저)라고 한다.
   