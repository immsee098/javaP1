--5강_subquery.sql
--[2019-10-02 수]
/*
서브쿼리 - 쿼리안에 또 다른 쿼리가 담겨 있는 것

select * from 테이블  --main query
where 조건 연산자 (select 컬럼 from 테이블 where 조건); --subquery

() 안에 subquery를 넣는다
*/
--emp테이블에서 scott 보다 급여를 많이 받는 사람의 이름과 급여를 조회

--서브쿼리를 이용하지 않는 경우
--1) 먼저 scott의 급여를 구한다
select sal from emp
where ename='SCOTT';  --3000

--2) 3000보다 많이 받는 직원 조회
select * from emp
where sal > 3000;

--서브쿼리 이용
select * from emp
where sal > (select sal from emp
                where ename='SCOTT');
--서브쿼리 부분은 where절의 연산자 오른쪽에 위치해야 하며
--반드시 괄호()로 묶어야 함

/*
=> 단일행 서브쿼리 - 서브쿼리의 결과가 하나의 행인 경우

subquery를 수행한 결과가 1건만 나오고, 이 결과를 main query로 전달해서
main query를 수행하게 됨

단일행 서브쿼리일 경우 where절에서 사용되는 연산자
=, !=, >,<,>=,<=

※ 서브쿼리의 종류
1) 단일행 서브쿼리 - 서브쿼리의 결과가 1개의 행인 경우
2) 다중행 서브쿼리 - 서브쿼리의 결과가 2개 행 이상인 경우
3) 다중컬럼 서브쿼리 - 서브쿼리의 결과가 여러 컬럼인 경우
4) 연관성 있는 서브쿼리(상관관계 서브쿼리) - 메인쿼리와 서브쿼리가 서로 연관되어 있는 경우
*/

--student 테이블과 department 테이블을 사용하여 이윤나 학생과 1전공(deptno1)이 
--동일한 학생들의 이름과 1전공 이름을 출력하시오
--1) 이윤나의 1전공 조회
select deptno1
from student
where name='이윤나';  --101

--2) 조회한 전공과 같은 전공인 학생들 조회
select * from student
where deptno1=101;

--subquery 이용
select * from student
where deptno1=(select deptno1
                from student
                where name='이윤나');

--join 이용해서 학과명도 조회
select s.*, d.DNAME 
from student s join department d
on s.DEPTNO1=d.DEPTNO
and deptno1=(select deptno1
                from student
                where name='이윤나');
                
--실습) Professor 테이블에서 입사일이 송도권 교수보다 나중에 입사한 사람의 이름과 
--입사일, 학과명을 출력하시오.
--professor, department테이블 이용
select hiredate from professor
where name='송도권'; --1998-03-22

select * from professor
where hiredate>'1998-03-22';

select * from professor
where hiredate>(select hiredate from professor
                    where name='송도권');

select p.*, d.DNAME 
from professor p join department d
on p.DEPTNO = d.DEPTNO
and hiredate>(select hiredate from professor
                    where name='송도권');
                    
--실습) student 테이블에서 1전공(deptno1)이 101번인 학과의 평균 몸무게보다 
--몸무게가 많은 학생들의 이름과 몸무게를 출력하시오
select avg(nvl(weight,0))
from student
where deptno1=101; --60

select * from student
where weight>60;

select * from student
where weight>(select avg(nvl(weight,0))
                from student
                where deptno1=101);
                
--Professor 테이블에서 심슨 교수와 같은 입사일에 입사한 교수 중에서 조인형 교수보다 
--월급을 적게 받는 교수의 이름과 급여, 입사일을 출력하시오.
select hiredate from professor
where name='심슨'; --1981-10-23

select pay from professor
where name='조인형'; --550

select name, pay, hiredate
from professor            
where  hiredate='1981-10-23' and pay<550;

select name, pay, hiredate
from professor            
where  hiredate=(select hiredate from professor
                where name='심슨') 
and pay<(select pay from professor
            where name='조인형'); 

--emp2에서 월급이 가장 적은 사원 정보 조회
select * from emp2
where pay = (select min(pay) from emp2);  --2000000

--dept2와 조인해서 부서명도 조회
select e.*, d.DNAME 
from emp2 e join dept2 d
on e.DEPTNO=d.DCODE
and pay = (select min(pay) from emp2);  --2000000

--다중행 서브쿼리
/*
    - 서브쿼리의 결과가 2건 이상 출력되는 경우
    - 서브쿼리의 결과가 여러 건 출력되기 때문에 단일행 연산자를 사용할 수 없음
    
    ※ 다중행 서브쿼리 연산자
    in - 같은 값을 찾는다.(포함된 값)
    <any - 최대값을 반환함 예) sal< any(100,200,300) => 300
    >any - 최소값을 반환함 예) sal> any(100,200,300) => 100
    <all - 최소값을 반환함 예) sal< all(100,200,300) => 100
    >all - 최대값을 반환함 예) sal> all(100,200,300) => 300
    
    ( any ? 여러 개중 아무거나 하나만 조건을 만족해도 된다는 의미
      all ? 서브쿼리에서 반환되는 모든 row 값을 만족해야 함을 의미 )
*/

-- emp2 테이블과 dept2 테이블을 참조하여 근무지역 (dept2 테이블의 area 칼럼)이 서울 
--지사인 모든 사원들의 사번과 이름, 부서번호를 출력하시오
--1) 근무지역이 서울지사인 부서
select dcode
from dept2
where area='서울지사'; --1000, 1001, 1002, 1010

--2) 조회한 서울지사인 부서에 속한 사원들 조회
select *  from emp2
where deptno in (1000, 1001, 1002, 1010);

--subquery 이용
select *  from emp2
where deptno in (select dcode
                    from dept2
                    where area='서울지사');

--emp2 테이블을 사용하여 전체 직원 중 과장 직급의 최소 연봉자보다 연봉이 높은 사람의 
--이름과 직급, 연봉을 출력하시오.
--단, 연봉 출력형식은 천 단위 구분기호와 원 표시를 하시오.
--1)과장 직급의 최소 연봉 조회
select min(pay)
from emp2
where position='과장';  --49000000

--2)조회한 연봉의 최소값보다 많이 받는 사원 조회
select * from emp2
where pay > 49000000;

-- 단일행 서브쿼리 이용
select * from emp2
where pay > (select min(pay)
            from emp2
            where position='과장');
            
--1) 과장 직급의 연봉 조회
select pay from emp2
where position='과장'; --5000만, 5600만, 5100만, 4900만

--2) 조회한 연봉의 최소값보다 많이 받는 사원 조회
select * from emp2
where pay >any (50000000,56000000,51000000,49000000);            

--다중행 서브쿼리 이용
select * from emp2
where pay >any (select pay from emp2
                where position='과장'); 
                  
--emp2 테이블을 사용하여 전체 직원 중 과장 직급의 최대 연봉자보다 연봉이 높은 사람의 
--이름과 직급, 연봉을 출력하시오.
select * from emp2
where pay >all (select pay from emp2 where position='과장');
                         
select * from emp2
where pay > (select max(pay) from emp2 where position='과장');

--근무지역이 경기지사가 아닌 모든 사원들 조회(emp2, dept2)
select dcode
from dept2
where area='경기지사'; --1005, 1009

select * from emp2
where deptno not in(1005, 1009);

--다중행 subquery
select * from emp2
where deptno not in(select dcode
                from dept2
                where area='경기지사');

--부서명도 조회
select e.*, d.DNAME 
from emp2 e join dept2 d
on e.DEPTNO=d.DCODE
and deptno not in(select dcode
                from dept2
                where area='경기지사');

--loc가 DALLAS가 아닌 모든 사원 조회(EMP, DEPT)
select deptno
from dept
where loc='DALLAS'; --20

select * from emp
where deptno!=20;

--단일행 서브쿼리
select * from emp
where deptno!=(select deptno
                from dept
                where loc='DALLAS');
 
--단일행 서브쿼리에서는 != 연산자 이용
--다중행 서브쿼리에서는 not in 연산자 이용
/*
    단일행 서브쿼리의 연산자       다중행 서브쿼리의 연산자
    =                           in
    !=                          not in
    >, <                        >any, <any, >all, <all
*/                               

--실습)student 테이블을 조회하여 전체 학생 중에서 체중이 4학년 학생들의 체중에서 
--가장 적게 나가는 학생보다 몸무게가 적은 학생의 이름과 몸무게를 출력하시오.
select * from student
where weight < (select min(weight) from student where grade=4);

select * from student
where weight <all (select weight from student where grade=4);

--emp2 테이블을 조회하여 각 부서별 평균 연봉을 구하고 그 중에서 평균 연봉이 가장 적은 
--부서의 평균 연봉보다 적게 받는 직원들의 부서명,직원명, 연봉을 출력하시오.
select deptno, avg(nvl(pay,0))
from emp2
group by deptno; --13건

select *
from emp2
where pay <all (25000000, 68000000,49000000);

select *
from emp2
where pay <all (select avg(nvl(pay,0))
                    from emp2
                    group by deptno);

select e.*, d.DNAME
from emp2 e join dept2 d
on e.DEPTNO=d.DCODE
where pay <all (select avg(nvl(pay,0))
                    from emp2
                    group by deptno);
                    
--단일행
select *
from emp2
where pay < (select min(avg(nvl(pay,0)))
                    from emp2
                    group by deptno);

--employees에서 job_id별 salary합계 금액이 30000 이상인 job_id에 속하는 사원 조회
select job_id, sum(salary)
from employees
group by job_id
having sum(salary)>=30000; --7건

select * from employees
where job_id in (select job_id
                    from employees
                    group by job_id
                    having sum(salary)>=30000);

--다중 컬럼 서브쿼리(pairwise subquery)
--서브쿼리의 결과가 여러 컬럼인 경우

--student 테이블을 조회하여 각 학년별로 최대 키를 가진 학생들의 학년과 이름과 키를 출력하시오.

--학년별 최대키 구하기
select grade, max(height)
from student
group by grade;     
/*
1학년 - 179  ?
2학년 - 184
3학년 - 177
4학년 - 182
*/                                   

--1학년 최대키를 갖는 학생 정보
select * from student
where grade=1 and height=179;

--다중 컬럼 서브쿼리
select * from student
where (grade, height) in (select grade, max(height)
                            from student
                            group by grade);
                            
--professor 테이블을 조회하여 각 학과별로 입사일이 가장 오래된 교수의 교수번호와 이름, 
--입사일, 학과명을 출력하시오. 단 학과이름순으로 오름차순 정렬하시오.
select deptno, min(hiredate)
from professor
group by deptno;

select profno, name, hiredate, deptno
from professor
where (deptno, hiredate) in (select deptno, min(hiredate)
                            from professor
                            group by deptno);

--join
select profno, name, hiredate, p.deptno, d.DNAME
from professor p join department d
on p.DEPTNO = d.DEPTNO
where (d.deptno, hiredate) in (select deptno, min(hiredate)
                            from professor
                            group by deptno)
order by d.dname;
                            
--emp2 테이블을 조회하여 직급별로 해당 직급에서 최대 연봉을 받는 직원의 이름과 직급, 
--연봉을 출력하시오. 단, 연봉순으로 오름차순 정렬하시오
select name "사원명", position "직급", pay  "연봉" 
from emp2
where (position, pay) IN ( select position, MAX(pay) 
                            from emp2
                            group by position)
order by 3; 

select name "사원명", nvl(position,'인턴') "직급", pay  "연봉" 
from emp2
where (nvl(position,'인턴'), pay) IN ( select nvl(position,'인턴'), MAX(pay) 
                            from emp2
                            group by position)
order by 3; 

--부서번호별로 기본급이 최대인 사원과 기본급이 최소인 사원 조회
--employees
select department_id, max(salary)
from employees
group by department_id;

select department_id, min(salary)
from employees
group by department_id;

--subquery
select * from employees
where (department_id, salary) in (select department_id, max(salary)
                                    from employees
                                    group by department_id)
or (department_id, salary) in (select department_id, min(salary)
                                    from employees
                                    group by department_id);

select * from employees
where (nvl(department_id,0), salary) in (select nvl(department_id,0), max(salary)
                                    from employees
                                    group by department_id)
or (nvl(department_id,0), salary) in (select nvl(department_id,0), min(salary)
                                    from employees
                                    group by department_id)
order by department_id desc;

--상호연관 서브쿼리(연관성 있는 서브쿼리, 상관관계 서브쿼리)
/*
    - 서브쿼리가 메인에 독립적이지 않고, 연관관계 즉 조인을 통해 연결되어 있는 쿼리를 말함
    - 서브쿼리와 메인쿼리사이에서 조인이 사용됨
    - 메인쿼리의 컬럼이 서브쿼리의 where 조건절에 사용됨
    
    - 메인 쿼리 값을 서브쿼리에 주고 서브쿼리를 수행한 후,
      그 결과를 다시 메인 쿼리로 반환해서 수행하는 서브쿼리
*/
--emp2 테이블을 조회하여 직원들 중에서 자신의 직급의 평균 연봉과 같거나 많이 
--받는 사람들의 이름, 직급, 현재연봉을 출력하시오.
select * from emp2;

select avg(nvl(pay,0)) from emp2
where position='부장'; --71666666.6

select * from emp2
where position='부장' and pay>=71666666.6;  --2건

--서브쿼리 이용
select * from emp2 a
where pay>=(select avg(nvl(pay,0)) from emp2 b
                where b.position=a.position)
order by position;

--professor에서 자신의 학과의 평균 연봉보다 적게 받는 교수 조회
select * from professor;

select avg(nvl(pay,0))
from professor
where deptno=101; --400

select * from professor
where deptno=101 and pay<400;

--subquery 
select * from professor a
where pay < (select avg(nvl(pay,0)) from professor b
                where b.deptno=a.DEPTNO);

--exists 연산자
/*
    - 특정 컬럼값이 존재하는지 여부를 체크
    - 서브쿼리가 반환하는 결과에 메인쿼리에서 추출될 데이터들이 존재하기만 하면
      조건을 만족하게 됨
    - 성능면에서는 in 보다 exists가 월등히 우수함
    
    ※ in, exists 비교
    1) in - 어떤 값에 포함되는지 여부를 체크
       in은 ()안에 비교할 값이 올수도 있고, 서브쿼리가 올 수도 있다
    
    2) exists - 특정 컬럼값이 존재하는지 여부를 체크
       exists는 오직 서브쿼리만 올 수 있다
*/                
--dept2테이블의 pdept값이 null이 아닌 부서에 속하는 사원 추출
select * from dept2;
select * from emp2;

--in 이용
select dcode from dept2
where pdept is not null; --1000,1001,1002,...

select * from emp2
where deptno in (1000,1001,1002);    
            
select * from emp2
where deptno in (select dcode from dept2
                    where pdept is not null);  
--exists 이용
select * from emp2 a
where exists (select 1 from dept2 b 
                where a.DEPTNO=b.DCODE and b.pdept is not null); 

--join 이용
select a.*
from emp2 a join dept2 b
on a.DEPTNO=b.DCODE 
and b.PDEPT is not null;

--경기지사에 속하는 사원들의 정보 조회
--in
select dcode from dept2
where area='경기지사';  --1005,1009

select * from emp2
where deptno in (1005,1009);  --in에 특정값이 오는 경우

select * from emp2
where deptno in (select dcode from dept2
                    where area='경기지사');  --in에 서브쿼리가 오는 경우

--exists
select * from emp2 a
where exists (select 1 from dept2 b
                where b.DCODE=a.DEPTNO and area='경기지사');

--join
select a.*
from emp2 a join dept2 b
on a.DEPTNO=b.dcode
and b.area='경기지사';  

--월급이 3000달러 이상인 사원이 속한 부서 조회
--emp, dept
select deptno
from emp
where sal>=3000; --10, 20

select * from dept
where deptno in (10,20);

select * from dept
where deptno in (select deptno
                    from emp
                    where sal>=3000);  

select * from dept a
where exists ( select 1 from emp b
                where a.DEPTNO = b.DEPTNO
                and b.sal>=3000); 

select a.*, b.ENAME, b.sal
from dept a join emp b
on a.DEPTNO=b.DEPTNO
and b.sal>=3000;

--emp 테이블을 조회하여 직원들 중에서 자신의 job의 평균 연봉(sal)보다 적거나 같게 받는 사람들을 조회하시오.
select * from emp a
where sal <=(select avg(sal) from emp b where b.job = a.job);


--Student, exam_01 테이블에서 총점이 90이상인 학생들의 정보 조회
select * from student s
where exists(
    select 1 from exam_01 e where total>=90 and s.studno=e.studno);

select * from student
where studno in (
    select studno from exam_01 where total>=90);

/*
    ※ 서브쿼리 위치별 이름
    서브쿼리는 오는 위치에 따라서 그 이름이 다름
    [1] scalar subquery
        select (subquery)
        - select절에 오는 서브쿼리로 한 번에 결과를 1행씩 반환함
        
    [2] inline view
        from (subquery)
        - from 절에 오는 서브쿼리
        
    [3] subquery
        where (subquery)
        - where절에 오는 서브쿼리
*/

--emp2 테이블과 dept2 테이블을 조회하여 사원들의 이름과 부서이름을 출력하시오
--join 이용
select e.NAME, e.PAY, e.position, d.DNAME
from emp2 e left join dept2 d
on e.DEPTNO=d.DCODE;

select e.NAME, e.PAY, e.position, e.deptno,
    (select dname from dept2 d where d.DCODE=e.deptno)
from emp2 e;

select * from emp2;



--employees, departments, 사원정보, 부서명 조회
select e.FIRST_NAME, e.HIRE_DATE, e.salary, d.DEPARTMENT_NAME
from employees e join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID;  --106

select * from employees; --107

--outer join
select e.FIRST_NAME, e.HIRE_DATE, e.salary, d.DEPARTMENT_NAME
from employees e left join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID
order by d.DEPARTMENT_NAME desc; --107

--scalar subquery이용
select e.FIRST_NAME, e.HIRE_DATE, e.salary, e.department_id,
    (select d.DEPARTMENT_NAME 
        from departments d where d.DEPARTMENT_ID=e.department_id) "부서명"
from employees e
order by DEPARTMENT_id desc; --107
--=> select문에서 서브쿼리를 사용하려면 단일 서브쿼리 중에서 단일행이면서 
--단일 컬럼인 경우만 가능함
--(임의의 숫자나 문자로 인식할 수 있는 서브쿼리)

--scalar subquery 는 outer 조인과 동일
--사원정보를 모두 출력하고, 부서번호가 없는 경우 scalar subquery로 조회한 부서명은
--null 값이 됨

/*
1.job이 MANAGER인 사원들 조회(emp)
2. job이 Manager인 모든 사원들보다 입사일이 빠른(작은) 사원 데이터 조회 => 
    all 이용 (emp)
3. ALL없이 결과값 출력 <= MIN함수를 써서
4. sales부서에 근무하는 사원 데이터 조회(emp, dept)
*/

--[2019-10-04 금]
select HIREDATE from emp
where job='MANAGER';

select * from emp
where hiredate <all (select HIREDATE from emp
                        where job='MANAGER');  

select * from emp
where hiredate < (select min(HIREDATE) from emp
                        where job='MANAGER');  
                        
select * from emp;
select * from dept;
 
select deptno from dept
where dname='SALES'; --30

select * from emp
where deptno=30;

select * from emp
where deptno=(select deptno from dept
                where dname='SALES');

select * from emp a
where exists (select deptno from dept b
                where dname='SALES' and a.DEPTNO=b.DEPTNO);   

--각 부서에 해당하는 사원수 구하기
--dept, emp
select * from dept;  --main
select * from emp;
     
select count(*) from emp
where deptno=10; --3  

select deptno, dname, loc, 
    (select count(*) from emp b
        where b.deptno=a.deptno) "사원수"
from dept a; 

--학과별 교수의 인원수, 백분율 구하기
select * from professor;

select deptno, count(*), 
    round(count(*)/(select count(*) from professor)*100,2) "백분율"
from professor
group by deptno
order by deptno;

select count(*) from professor; --18

--employees에서 job_id별 salary 합계 금액이 전체 급여 금액에서 차지하는 비율 구하기
select job_id, sum(salary), 
    round(sum(salary)/(select sum(salary) from employees)*100,2) RATIO
from employees
group by job_id;

select sum(salary)
from employees; --691416

--employees에서 사원번호,이름,매니저아이디,매니저이름, 급여레벨을 조회
--매니저 이름은 manager_id가 null인 경우에는 사장으로
--급여레벨 - salary가 5000미만이면 하, 5000~10000 이면 중, 10001~20000이면 상
--나머진 특상
--case 이용
select employee_id, first_name, manager_id, salary,
    case when manager_id is null then '사장'
    else
        (select first_name from employees b 
            where a.manager_id=b.EMPLOYEE_ID) end "매니저이름",
    case when salary<5000 then '하'
         when salary between 5000 and 10000 then '중'
         when salary between 10001 and 20000 then '상'
         else '특상' end "급여레벨"             
from employees a;

--의사컬럼(pseudoColumn), 모조 컬럼, 유령컬럼
/*
    테이블에 있는 일반적인 컬럼처럼 행동하기는 하지만, 실제로 테이블에 저장되어 있지 
    않은 컬럼
    
    [1] ROWNUM : 쿼리의 결과로 나오는 각각의 row들에 대한 순서값을 가리키는 의사컬럼
    - 주로 특정 개수나 그 이하의 row를 선택할 때 사용됨
    
    [2] ROWID : 테이블에 저장된 각각의 row들이 저장된 주소값을 가진 의사컬럼
    - 모든 테이블의 모든 row들은 오직 자신만의 유일한 rowid값을 갖고 있다
*/
select rownum, empno, ename, sal, rowid as "ROW_ID"
from emp;  

--emp 테이블 전체에서 상위 5건의 데이터 조회
select rownum, empno, ename, sal
from emp
where rownum<=5;

--order by이용, emp에서 ename순으로 정렬한 상태에서 상위 5건 조회
select rownum, empno, ename, sal
from emp
order by ename;  --rownum 순서가 뒤바뀜

--inline view 이용
select rownum, A.*
from
(
    select empno, ename, sal
    from emp
    order by ename
) A
where rownum<=5; 

--student에서 height순서대로 상위 7명의 학생 조회
select rownum, studno, name, grade, height 
from student
order by height;

select rownum, studno, name, grade, height 
from(
    select studno, name, grade, height 
    from student
    order by height
)
where rownum<=7;   

--employees 에서 salary를 정렬해서 급여를 많이 받는 상위 5건만 조회
select rownum, employee_id, first_name, salary
from employees
order by salary desc; 

select rownum, A.*
from
(
    select  employee_id, first_name, salary
    from employees
    order by salary desc
)A
where rownum<=5; 

--상위에서 2~4 사이인 데이터 조회
select rownum, A.*
from
(
    select  employee_id, first_name, salary
    from employees
    order by salary desc
)A
where rownum>=2 and rownum<=4;  --결과값이 안 나옴
--=> rownum을 1부터 사용하지 않았기 때문
--rownum은 반드시 1이 포함되어야 결과가 나옴

select rownum AS RNUM, A.*
from
(
    select  employee_id, first_name, salary
    from employees
    order by salary desc
)A
where RNUM>=2 and RNUM<=4; --error

--inline view를 한번 더 사용
select A.*
from
(
    select rownum AS RNUM, employee_id, first_name, salary
    from
    (
        select  employee_id, first_name, salary
        from employees
        order by salary desc
    )
)A
where RNUM>=2 AND RNUM<=4;

/*
각 학과에 해당하는 교수의 수 구하기
각 학과에 해당하는 학생수 구하기
department , student 테이블

Professor 테이블에서 월급을 많이 
    받는 교수 순으로 10명 조회하기
    
5. 평균급여보다  급여를 많이 받는 사원 데이터 가져오기(emp)    
*/
select deptno, dname, part, 
    (select count(*) from professor b
        where b.deptno=a.deptno) "교수의 수"
from department a;

select count(*) from professor
where deptno=101;
                   
select deptno, dname, part, 
    (select count(*) from student b
        where b.deptno1=a.deptno) "학생의 수"
from department a;  

select profno, name, pay from professor
order by pay desc;

select rownum, A.*
from(
    select profno, name, pay from professor
    order by pay desc
)A
where rownum<=10;


select avg(nvl(sal,0)) from emp; --2073

select * from emp
where sal > (select avg(nvl(sal,0)) from emp);

--inline view
--employees에서 사원정보를 조회하고, job_id별 평균급여도 조회
select * from employees;    

select job_id, avg(nvl(salary,0)) "평균급여"
from employees
group by job_id; 

--테이블과 inline view간의 join
select e.*, A.평균급여
from employees e join (
    select job_id, avg(nvl(salary,0)) "평균급여"
    from employees
    group by job_id ) A
on e.JOB_ID = A.JOB_ID;   

--로그인 처리
select * from member;

select case
        ( select count(*) from member
          where id='simson' and passwd='a1234')
       when 1 then '로그인 성공'
       else '로그인 실패'
       end "로그인"
from dual;
       
--
select case
        (select count(*) from member
            where id='simson' and passwd='a1234')
       when 1 then '로그인 성공'
       else
            case (select count(*) from member
                    where id='simson')
            when 1 then '비밀번호 불일치'
            else 
                '해당 아이디가 존재하지 않음'
            end
        end "로그인"        
from dual;   

--사용자로부터 입력값 받아와서 처리하기
 select case
        (select count(*) from member
            where id=:id and passwd=:pwd)
       when 1 then '로그인 성공'
       else
            case (select count(*) from member
                    where id=:id)
            when 1 then '비밀번호 불일치'
            else 
                '해당 아이디가 존재하지 않음'
            end
        end "로그인"        
from dual;   

--decode 이용
select decode((select count(*) from member
            where id=:id and passwd=:pwd),1,'로그인 성공',
            decode((select count(*) from member
                    where id=:id),1,'비밀번호 불일치','해당 아이디 없다' ))
       "로그인" 
from dual;

--gogak 에서 10대, 30대 남자 조회
select gname, jumin,
    case when substr(jumin,7,1) in ('1','3') then '남자' else '여자' end
    "성별",
    to_char(sysdate, 'yyyy')-
    (substr(jumin,1,2) 
      + case when substr(jumin,7,1) in ('1','2') then 1900 else 2000 end)
    +1 "나이",
    trunc(to_char(sysdate, 'yyyy')-
    (substr(jumin,1,2) 
      + case when substr(jumin,7,1) in ('1','2') then 1900 else 2000 end)
    +1, -1) "연령대"
 from gogak
 where "성별"='남자' ; --error
 
 --inline view 이용
 select A.*
 from
 (
    select gname, jumin,
        case when substr(jumin,7,1) in ('1','3') then '남자' else '여자' end
        "성별",        
        trunc(to_char(sysdate, 'yyyy')-
        (substr(jumin,1,2) 
          + case when substr(jumin,7,1) in ('1','2') then 1900 else 2000 end)
        +1, -1) "연령대"
     from gogak
 ) A
 where A."성별"='남자' and A.연령대 in (10,30);
 
--gogak에서 연령대별 인원수와 백분율 조회
 select A.연령대, count(*), count(*)/(select count(*) from gogak)*100 "백분율"
 from
 (
    select gname, jumin,
        case when substr(jumin,7,1) in ('1','3') then '남자' else '여자' end
        "성별",        
        trunc(to_char(sysdate, 'yyyy')-
        (substr(jumin,1,2) 
          + case when substr(jumin,7,1) in ('1','2') then 1900 else 2000 end)
        +1, -1) "연령대"
     from gogak
 ) A
 group by A."연령대";
 
 
  select A.연령대, count(*), count(*)/(select count(*) from gogak)*100 "백분율"
 from
 (
    select gname, jumin,
        case when substr(jumin,7,1) in ('1','3') then '남자' else '여자' end
        "성별",        
        trunc(to_char(sysdate, 'yyyy')-
        (substr(jumin,1,2) 
          + case when substr(jumin,7,1) in ('1','2') then 1900 else 2000 end)
        +1, -1) "연령대"
     from gogak
 ) A
 group by rollup(A."연령대")
 order by A."연령대";
 
 --학과별, 성별 평균키 구하기
   --student 테이블 이용
   
   select *
   from student;
   
   select deptno1, round(avg(height), 2) "평균키", decode(grouping(case when substr(jumin,7,1) in ('1','3') then '남자' else '여자' end), 1, '평균', case when substr(jumin,7,1) in ('1','3') then '남자' else '여자' end) "성별"
   from student
   group by rollup(deptno1, case when substr(jumin,7,1) in ('1','3') then '남자' else '여자' end);
   
   
   select deptno1, A.성별, avg(height)"평균키"
   from(
    select deptno1, round(avg(height), 2) "평균키", case when substr(jumin,7,1) in ('1','3') then '남자' else '여자' end "성별"
    from student
   ) A
   
   group by deptno1, A.성별
   order by deptno1, A.성별;
   
   --job_history의 정보를 조회하되, job_id에 해당하는 job_title, 
   --department_id에 해당하는 부서명도 조회
   --job_history, jobs, department