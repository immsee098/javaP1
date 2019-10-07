--6강_insert.sql
--[2019-10-07 월]
--1. insert문 - 데이터를 입력하는 DML
/*
    [1] 단일행 입력하기
    insert into 테이블명(컬럼1, 컬럼2, 컬럼3,...)
    values(값1, 값2, 값3,...);
*/
/*
예1) dept2 테이블에 아래의 새로운 부서 정보를 입력하시오
부서번호 : 9000, 부서명: 특판1팀
상위부서 : 1006 (영업부), 지역 : 임시지역
*/
select * from dept2;

insert into dept2(dcode, dname, pdept, area)
values('9000', '특판1팀','1006', '임시지역');

insert into dept2(dcode, area, dname, pdept)
values('9001', '임시지역', '특판2팀','1006');

--모든 컬럼의 데이터를 입력하는 경우 => 컬럼명 생략 가능
insert into dept2
values(9002, '특판3팀', 1006, '임시지역');

--일부 컬럼만 입력하는 경우 - not null인 컬럼은 반드시 값을 입력해야 함
insert into dept2(dcode, dname)
values(9003, '특판4팀');

insert into dept2(dcode, pdept)
values(9004, 1006); --error
--cannot insert NULL into ("DEPT2"."DNAME")
--dname이 not null인데 값을 입력하지 않아서 에러 발생

--null 입력하기
/*
1) 데이터를 입력하지 않으면 null이 입력됨
2) 직접 null을 입력해도 null이 입력됨
*/
insert into dept2(dcode, dname, pdept)
values(9004, '특판5팀', null);

select * from dept2;

--날짜 데이터 입력하기
/*
아래 정보를 professor 테이블에 입력하시오
교수번호 : 5001, 교수이름: 김설희
ID : kimsh, Position : 정교수
Pay : 510, 입사일 : 2013년 2월 19일
*/
select * from professor;

insert into professor(profno, name, id, position, pay, hiredate)
values(5001,'김설희','kimsh','정교수',510,'2013-02-19');

--[2] 여러 행 입력하기
/*
    insert into 테이블명(컬럼1, 컬럼2, ...)
    select문
    
    => select문의 컬럼의 개수와 데이터 타입이 일치해야 입력 가능함 
*/
select * from pd
order by no desc;

select * from product;

insert into pd(no,pdname, price, regdate)
select p_code, p_name, p_price, sysdate
from product
where p_code in (102,103,104);

--[3] 테이블을 생성하면서 데이터 입력하기
/*
    create table 신규 테이블명
    as
    select 선택컬럼1, 선택컬럼2, ...from 기존 테이블명;
    
    - 신규 테이블을 만들고 동시에 다른 테이블에서 select된 컬럼과 결과 데이터를
    insert시킴
    - select문의 테이블과 컬럼의 제약조건은 복제되지 않기 때문에
    신규 테이블에 대해 테이블과 컬럼 제약조건을 정의해야 함
    pk(primary key)값도 생성하지 않음
*/
create table professor2  --professor2 테이블이 생성됨
as
select * from professor;

select * from professor2;

--employees, departments 테이블을 조인한 결과를 imsi_tbl을 만들면서 입력
create table imsi_tbl
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME as name,
    e.hire_date, 
    nvl2(commission_pct, salary+salary*commission_pct, salary) as pay,
    e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from employees e join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

select * from imsi_tbl;
/*
=> insert문에 컬럼리스트가 없는 상태에서 select문 컬럼 리스트에 함수가 적용됐다면
별칭을 써서 insert되는 데이터의 컬럼명을 지정해줘야 함
그렇지 않으면 에러 발생
*/

create table imsi_tbl2(emp_id, name,hiredate, pay,dept_id, dept_name)
as
select e.EMPLOYEE_ID, e.FIRST_NAME || '-' || e.LAST_NAME,
    e.hire_date, 
    nvl2(commission_pct, salary+salary*commission_pct, salary),
    e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from employees e join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

select * from imsi_tbl2;

/*
=> create table에서 컬럼명을 지정하면
신규 테이블에 컬럼 리스트가 정의되면서 select문을 통해 필요한 데이터가 insert됨
*/

--2. update문
--기존 데이터를 다른 데이터로 변경할 때 사용하는 방법
/*
    update 테이블
    set 컬럼명1=값1, 컬럼명2=값2, ...
    where 조건
*/
--[1] update
--Professor 테이블에서 직급이 조교수인 교수들의 bonus를 100만원으로 인상하시오
select * from professor
where position='조교수';

update professor
set bonus=100
where position='조교수';
 
rollback;

--student 테이블에서  4학년 '김재수' 학생의 2전공(deptno2)을 101로 수정하시오.
select * from student
where grade=4 and name='김재수';

update student
set deptno2=101
where grade=4 and name='김재수';

--Professor 테이블에서  차범철교수의 직급과 동일한 직급을 가진 교수들 중 현재 급여가 
--250만원이 안 되는 교수들의 급여를 15% 인상하시오.
select *
from professor
where position = (select position from professor where name='차범철') 
    and pay<250;
    
update professor
set pay=pay*1.15
where position = (select position from professor where name='차범철') 
    and pay<250;
    
rollback;   
 
--[2] 다중 건의 update - 서브쿼리를 이용한 update
/*
    서브쿼리를 사용하면 한 번의 update 명령으로 여러 개의 컬럼을 수정할 수 있다
    여러 컬럼을 서브쿼리의 결과로 update하면 된다
    
    다중건의 update를 하기 위해서는 기본적인 update문의 폼을 사용하고
    서브쿼리로 추출한 데이터를 셋팅하려는 컬럼의 데이터 값으로 사용함
*/
--EMP 테이블의 사원번호가 7844인 사원의 부서번호와 직무(JOB)를 
--사원번호가 7782인 사원과 같은 직무와 같은 부서로 배정하라                 

--cf. 다중 컬럼 서브쿼리
--학년별 최대키를 갖는 학생의 정보 조회
select * from student
where (grade, height) in (select grade, max(height) from student
                            group by grade);

--
select job, deptno from emp  
where empno=7782; --MANAGER, 10

select * from emp
where empno=7844;

/*update emp
set job='MANAGER', deptno=10
where empno=7844; */

--subquery 이용
update emp
set (job, deptno)=(select job, deptno from emp  
                    where empno=7782)
where empno=7844;                          

rollback;

--[3] exists를 이용한 다중건의 update
/*
    - 서브쿼리의 컬럼값이 존재하는지 여부를 체크
    - 존재여부만 체크하기 때문에 존재하면 true, 존재하지 않으면 false를 리턴함
    - true가 리턴되면 set 컬럼의 update를 진행시키고
      false가 리턴되면 update는 진행되지 않음
*/
select * from product;
select * from panmae;

--삭제된 코드가 panmae 테이블에 있다면 새코드로 update하기
select *
from product
where del_yn='Y';

select * from panmae a
where exists (select 1 from product b where b.p_code=a.p_code 
                and b.del_yn='Y');
                
update panmae a
set p_code=(select p_code_new from product b where b.p_code=a.p_code
                and b.del_yn='Y')
where exists (select 1 from product b where b.p_code=a.p_code 
                and b.del_yn='Y');                

rollback;

--subquery이용한 update
--employees에서 직원번호가 100인 직원의 job_id로 직원번호가 101인 job_id를 수정하시오
select job_id from employees
where employee_id=100;  --AD_PRES

select * from employees
where employee_id=101;          

/*
update employees
set job_id='AD_PRES'
where employee_id=101
*/

update employees
set job_id=(select job_id from employees
                where employee_id=100)
where employee_id=101;
      
--3. delete문
/*
    delete from 테이블
    where 조건
*/

--dept2 테이블에서 부서번호(dcode)가 9000번에서 9100번 사이인 매장들을 삭제하시오
select * from dept2
where dcode between 9000 and 9100;

delete from dept2
where dcode between 9000 and 9100;

rollback;

--delete문에서 서브쿼리
--단일행
--departments에서 20번 부서의 부서장을 employees에서 삭제
select manager_id from departments
where department_id=20;  --201

select * from employees
where employee_id=201;

/*delete from employees
where employee_id=201;*/

delete from employees
where employee_id=(select manager_id from departments
                    where department_id=20);
--=> 자식레코드 발견-무결성 제약조건 위배

create table new_employees
as
select * from employees;

create table new_employees2
as
select * from employees;

select * from new_employees;

delete from new_employees
where employee_id=(select manager_id from departments
                    where department_id=20);
                    
--다중 행
--departments에서 location_id가 1700인 사원들을 employees에서 삭제
select department_id from departments
where location_id=1700; 

select * from employees
where department_id in (10,30,90);

select * from new_employees
where department_id in (select department_id from departments
                        where location_id=1700);
                        
delete from new_employees
where department_id in (select department_id from departments
                        where location_id=1700);  

--상관관계 서브쿼리
--employees에서 자신의 job_id의 평균 급여보다 많이 받는 사원 삭제
select * from employees
where job_id='IT_PROG';

select avg(nvl(salary,0))
from employees
where job_id='IT_PROG';   --5760

select * from employees
where job_id='IT_PROG' and salary>=5760;    

select * from new_employees a
where salary>=(select avg(nvl(salary,0))
                from employees b
                where b.job_id=a.job_id); 
                 
delete from new_employees a
where salary>=(select avg(nvl(salary,0))
                from employees b
                where b.job_id=a.job_id); 


delete from new_employees2 a 
where salary>=(select avg(nvl(salary,0))
from employees b
where b.job_id = a.job_id);
--                
         --[1]다른 테이블에 한꺼번에 입력
select * from p_01;
select * from p_02;

insert all into p_01 values(1, 'AA')
           into p_02 values(2, 'BB')
select * from dual;

--[2]다른테이블에서 가져와서 입력하기
insert all into p_01 values(profno, name)
           into p_02 values(profno, name)
select profno, name from professor;


select * from p_01;
select * from p_02;


--[3]다른 테이블에 동시에 같은 데이터 입력하기

insert all into p_01 values(profno, name)
           into p_02 values(profno, name)
select profno, name from professor
where profno between 3000 and 39999;
/*
dept => dept01 테이블 만들기
? emp => emp01 테이블 만들기
? --insert
? 1) dept01, emp01 테이블에 데이터 입력하기
? dept01 테이블에는 모든 칼럼 입력, emp01 테이블에는 일부 칼럼만 입력
? --update
*/
create table dept01
as
select * from dept;

create table emp01
as
select * from emp;
/*
? 1) DEPT01 테이블의 부서번호가 30인 부서의 위치(LOC)를 '부산'으로 수정
? 2) DEPT01 테이블의 지역을 모두 '서울'로 수정
? 3) emp01 테이블에서 job이 'MANAGER' 인 사원의 급여(sal)를 10% 인상
? --서브쿼리를 이용한 update
*/
select * from dept;
select * from emp01;

update dept01
set loc= '부산'
where deptno=30;

update dept01
set loc= '서울';

update emp01
set sal = sal*1.1
where job='MANAGER';

/*
? 1) 사원번호가 7934인 사원의 급여와, 직무를 사원번호가 7654인 사원의 직무와 급여
로 수정(emp01 테이블 이용)
? --다른 테이블을 참조한 UPDATE
? 1) DEPT01 테이블에서 부서이름이 SALES인 데이터를 찾아 그 부서에 해당되는
EMP01 테이블의 사원업무(JOB)를 'SALSEMAN'으로 수정
? 2) DEPT01 테이블의 위치(loc)가 'DALLAS'인 데이터를 찾아 그 부서에 해당하는
EMP01 테이블의 사원들의 직무(JOB)을 'ANALYST'로 수정 
*/
update emp01
set (sal, job) = (select sal, job from emp where empno=7654)
where empno=7934;

update emp01 e
set job='SALESMAN'
where e.deptno = (select d.deptno from dept01 d where d.deptno=30);

update emp01 e
set job='ANALYST'
where e.deptno = (select d.deptno from dept d where d.deptno=20);


/*
-- DELETE
? 1) EMP01테이블에서 7782의 사원번호인 사원정보를 모두 삭제
? 2) EMP01테이블에서 직무(JOB)이 'CLERK'인 사원들의 정보를 삭제
? 3) EMP01테이블의 모든 정보를 삭제 후 rollback
*/
select * from dept;
select * from emp01;

delete from emp01
where empno=7782;

delete from emp01
where job='CLERK';

rollback;


/*
--서브쿼리를 이용한 데이터의 삭제
? 1) 'ACCOUNTING'부서명에 대한 부서코드를 DEPT01테이블에서 검색한 후
해당 부서코드를 가진 사원의 정보를 EMP01테이블에서 삭제
? 2) DEPT01테이블에서 부서의 위치가 'NEW YORK'인 부서를 찾아
EMP01테이블에서 그 부서에 해당하는 사원을 삭제
*/
select * from dept01;
select * from emp01;

delete from emp01
where deptno = (select deptno from dept01 where dname='ACCOUNTING');

delete from emp01
where deptno = (select deptno from dept01 where loc='NEW YORK');