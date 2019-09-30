--단일행 함ㅅ

select birthday,  id, length(id)
from student;

select max(pay), min(pay), max(bonus), min(bonus)
from professor;

--문자 날짜도 대소 비교가 가능
--안에 distinct 넣으면 중복값도 제거 가능


--group by - 테이블 전체에 대한 집계를 구하는 것이 아니라 특정 범위내에서 구함

select deptno, avg(nvl(pay,0))
from professor
group by deptno
order by deptno;

--학과별, 직급별 급여 평균

select deptno, position,avg(nvl(pay,0))
from professor
group by deptno, position
order by deptno, position;

--group bt절에 있는 컬럼과 그룹함수만 select 절에 올릴 수 있음
--select deptno, position,avg(nvl(pay,0)), name -error
--from professor
--group by deptno, position
--order by deptno, position;


select deptno as dno, position, avg(pay)
from professor
--group by dno, position --error 별칭 사용 불가
order by dno, position; --order by 절에는 별칭 사용 ㄱ능


--부서별 평균급여를 구한 후, 평균 급여가 450 초과인 부서의 부서번호와 평균 급여를 구하시오.
select * from professor;

select deptno, avg(nvl(pay,0))
from professor
--where avg(nvl(pay,0)) > 450 --그룹바이펑션 여기오면 안됨
group by deptno
order by deptno;
--where절에는 그룹함수 올 수 없음

select deptno, avg(nvl(pay,0))
from professor
group by deptno
having avg(nvl(pay,0)) > 450 
order by deptno;

--student에서 grade별로 weight, height 평균, 최대값 구하기
select grade, avg(nvl(weight, 0))
from student
group by grade;

--위의 결과에서 키의 평균이 170 이하인 경우 구하기
select grade, avg(nvl(weight, 0)), avg(nvl(height, 0)),
max(weight), max(height)
from student
group by grade
having avg(nvl(height, 0)) <=170;

select * from student
order by deptno1;


select grade, avg(nvl(weight,0)), avg(nvl(height, 0)), max(weight), max(height)
from student
where deptno1=201
group by grade
having avg(nvl(height, 0))<180;


--1.  emp테이블의 부서별 급여의 총합 구하기.
select deptno, sum(nvl(sal,0))
from emp
group by deptno;

--2. emp 테이블의 job별로 급여의 합계 구하기.
select job, sum(nvl(sal, 0))
from emp
group by job;

--3. emp 테이블의 job별로 최고 급여 구하기
select job, max(nvl(sal, 0))
from emp
group by job;

--4. emp 테이블의 job별로 최저 급여 구하기
select job, min(sal)
from emp
group by job;

--1. emp 테이블의 job별로 급여의 평균 구하기 ? 소수이하 2자리만 표시
select job, round(avg(nvl(sal, 0)),2)
from emp
group by job;

--2. Student 테이블에서 grade별로 weight, height의 평균, 최대값 구하기 
select grade, max(weight), max(height), avg(nvl(weight,0)), avg(nvl(height,0))
from student
group by grade;

--3.  2번의 결과에서 키의 평균이 170 이하인 경우 구하기
select grade, max(weight), max(height), avg(nvl(weight,0)), avg(nvl(height,0))
from student
group by grade
having avg(nvl(height,0))<=170;


--4.  emp2 테이블에서 emp_type별로 pay의 평균을 구한 상태에서 평균 연봉이 3 천만원 이상인 경우의 emp_type 과 평균 연봉을 읽어오기
select emp_type, avg(pay)
from emp2
group by emp_type
having avg(pay)>30000000;

--5. emp2의 자료를 이용해서 직급(position)별로 사번(empno)이 제일 늦은 사람 을 구하고 그 결과 내에서 사번이 1997로 시작하는 경우 구하기 (사번의 최대값), like 이용
--6. emp 테이블에서 hiredate가 1982년 이전인 사원들 중에서 deptno별, job별 sal의 합계를 구하되 그 결과 내에서 합계가 2000 이상인 사원만 조회
select deptno, job, sum(nvl(sal, 0))
from emp
where hiredate<'1982-01-01'
group by deptno, job
having sum(nvl(sal, 0))>2000;


--select sql문 실행 순서
----------------------------------------------------
--roll up, vube는 group by랑 쓰임
select deptno, avg(nvl(pay,0)) "평균기본급"
from professor
group by deptno
order by deptno;

--cube
select deptno, round(avg(nvl(pay,0)),1) "쳥균기본급"
from professor
group by cube(deptno)
order by deptno;

select deptno, position, avg(nvl(pay,0)) "평균 기본급"
from professor
group by rollup(deptno, position)
order by deptno, position;

--칼럼이 3개인 경우
select * from emp_details_view;

select city, department_name, job_title, avg(nvl(salary, 0)) "평균급여"
from emp_details_view
group by city, department_name, job_title
order by city, department_name, job_title;


--rollup
select * from emp_details_view;

select city, department_name, job_id, avg(nvl(salary, 0)) "평균급여"
from emp_details_view
group by rollup(city, department_name, job_id)
order by city, department_name, job_id;

--cube


select decode(grouping(deptno), 1,
        decode(grouping(position),0,'[직급별 소개]', '[전체]'), deptno) "학과",
        decode(grouping(position), 0, position, '[학과별 소개]'),
        decode(grouping(deptno),0,'[학과별소계]','[소계]') "직급",
        round(avg(nvl(pay,0)),1) "평균기본급",
        grouping(deptno), grouping(position)
        from professor
        group by cube(deptno, position)
        order by deptno, position;
        
 -- STUDENT 테이블에서 학년별로 학생들의 인원수 합계와 학과별로 인 원수의 합계를 구해야 하는 경우에 
 --기존에는 학년별로 인원수 합계를 구하 고 별도로 학과별로 인원수 합계를 구한 후 UNION 연산을 했음   