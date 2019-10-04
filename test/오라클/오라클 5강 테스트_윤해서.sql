--[ 오라클 5강 ]


--(1) 김재수와  학과(deptno1)가 같은 학생들의 학번(studno), 이름(name), 학년(grade), 학과번호(deptno1)를 조회하되 이름(name)의 내림차순으로 조회
--서브 쿼리 이용 
select studno, name, grade, deptno1 
from student 
where deptno1 = (select deptno1 from student where name='김재수');


--(2) 급여(pay)가 교수 전체의 평균급여보다 큰 교수의 이름(name), 직급(position), 급여(pay), 입사일(hiredate)의 데이터 가져오기.
--서브 쿼리 이용
select name, position, pay, hiredate
from professor
where pay > (select avg(pay) from professor);


--(3) emp2 테이블과 dept2 테이블을 참조하여 근무지역 
--(dept2 테이블의 area 칼럼)이 포항본사인 모든 사원들의 사번과 이름, 부서번호를 출력하시오
select *
from emp2
where pay < (select min(avg(nvl(pay,0)))
                    from emp2
                    group by deptno);

--(4) loc가 CHICAGO 가 아닌 모든 사원 조회(emp, dept)
select * from emp
where deptno!=(select deptno
                from dept
                where loc='CHICAGO');

--(5) emp2 테이블을 조회하여 각 부서별 평균 연봉을 구하고 그 중에서 
--평균 연봉이 가장 적은 부서의 평균 연봉보다 많이 받는 직원들의 부서명,직원명, 연봉을 출력하시오.
--다중행 서브쿼리 이용
select e.*, d.DNAME
from emp2 e join dept2 d
on e.DEPTNO=d.DCODE
where pay >any(select avg(nvl(pay,0))
                    from emp2
                    group by deptno);


--단일행 서브쿼리 이용
select *
from emp2
where pay > any (select min(avg(nvl(pay,0)))
                    from emp2
                    group by deptno);


--(6) professor 테이블을 조회하여 각 학과별로 입사일이 가장 오래된 교수의 
--교수번호와 이름, 입사일, 학과명을 출력하시오. 
--단 학과이름순으로 오름차순 정렬하시오.
select name, hiredate,deptno
from professor a
where hiredate<=(select max(hiredate) from professor b where a.DEPTNO = b.DEPTNO group by deptno) ;


--(7) Professor 테이블에서 심슨 교수와 같은 입사일에 입사한 교수 중에서 조인형 교수보다 월급을 적게 
--받는 교수의 이름과 급여, 입사일을 출력하시오.
select name, pay, hiredate
from professor            
where  hiredate=(select hiredate from professor
                where name='심슨') 
and pay<(select pay from professor
            where name='조인형'); 

--(8) employees 테이블을 조회하여 직원들 중에서 자신의 부서의 평균 급여보다 적게 받는 사람들의 이름, 부서번호, 
--현재급여를 출력하시오.
select *
from employees a
where salary<(select min(avg(salary)) from employees b where a.DEPARTMENT_ID = b.DEPARTMENT_ID group by b.department_id);


--(9) professor 테이블과 department 테이블을 조회하여 교수들의 정보와 학과이름을 조회
--스칼라 서브쿼리 이용 



--(10) 각 부서에 해당하는 사원수 구하기
--departments, employees 이용
select * 
from departments;

select *
from employees;

select (select department_name from departments d where e.department_id = d.department_id) "부서명", department_id, count(department_id)
from employees e 
group by department_id;


--(11) exam_01 테이블에서 점수가 높은 순으로 6명 조회하기
select rownum, studno, total
from exam_01
where rownum<=6
order by total desc;

--(12) job_history, jobs 테이블에서  job_title이 Public Accountant 인 사원들의 
--job_history 정보 조회
 


--(13) emp2 테이블과 학과 p_grade 테이블을 join하여 사원이름, 직급, 
--현재연봉, 해당 직급의 연봉의 하한 금액과 상한 금액을  조회
--모든 사원이 출력되도록
select e.NAME, e.POSITION, e.pay, p.S_PAY, p.E_PAY, d.DNAME
from emp2 e join p_grade p
on e.POSITION=p.position
join dept2 d
on e.DEPTNO=d.DCODE;


--(14) Student, exam_01 테이블에서  총점이 90이상인 학생들의 정보 조회
--exists 이용
select * from student s
where exists(
    select 1 from exam_01 e where total>=90 and s.studno=e.studno);


--in 이용
select * from student
where studno in (
    select studno from exam_01 where total>=90);
