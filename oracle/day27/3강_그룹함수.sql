--3강_그룹함수.sql
--[2019-09-30 월]
--단일행 함수
select birthday, to_char(birthday,'d'), id, length(id) 
from student;

--복수행함수(그룹함수)
select sum(pay) from professor;

select * from professor;

--count() - 입력되는 데이터의 건수를 리턴하는 함수
--그룹 함수는 null을 제외하고 계산함
select count(*), count(bonus), count(hpage), count(name)
from professor;
--bonus, hpage는 null이 제외된 건수임
--count(*) - 전체 레코드 개수

--sum() - 합계 구하는 함수
/*
문자, 날짜는 sum, avg() 함수를 사용할 수 없다(연산 불가)
count() 함수는 문자, 날짜에서도 사용 가능
*/
select sum(pay), sum(bonus), count(pay), count(bonus), count(*)
from professor;

select sum(name) from professor;  --error

--avg() - 평균을 구하는 함수
select avg(pay), sum(pay), count(pay), count(*),
    avg(bonus), sum(bonus), count(bonus), 
    sum(bonus)/count(bonus), sum(bonus)/count(*),
    avg(nvl(bonus,0))
from professor;
/*
    그룹함수는 null을 제외하고 연산하므로 avg()는 정상적인 결과값이 나오지 않음
    => nvl() 함수를 이용하여 처리해야 함
    => avg(nvl(컬럼,0))
*/

--max() - 최대값을 구하는 함수
--min() - 최소값을 구하는 함수

select max(pay), min(pay), max(bonus), min(bonus)
from professor;

--문자, 날짜도 최대값, 최소값은 구할 수 있다(대소 비교가 가능하므로)
select max(name), min(name), max(hiredate), min(hiredate)
from professor;

--중복값을 제외한 건수 : count(distinct 컬럼명)
select count(grade), count(*), count(distinct grade)
from student;

select * from student;

/*
    sum(distinct 컬럼명) - 중복값을 제외한 합계
    avg(distinct 컬럼명) - 중복값을 제외한 평균
    max(distinct 컬럼명) - 중복값을 제외한 최대값
    min(distinct 컬럼명) - 중복값을 제외한 최소값
*/

--그룹별 집계
--학과별로 교수들의 평균 급여 구하기

--cf. 전체 교수들의 평균 급여
select avg(pay) from professor;

select * from professor;

--학과별로 정렬
select deptno, pay from professor
order by deptno;

--group by
select deptno, avg(nvl(pay,0))
from professor
group by deptno --학과별로 묶어서
order by deptno;

/*
group by - 테이블 전체에 대한 집계를 구하는 것이 아니라,
           특정 범위에서의 집계 데이터를 구함
*/

--학과별, 직급별 급여의 평균 구하기
select * from professor;

select deptno, position, avg(nvl(pay,0))
from professor
group by deptno, position
order by deptno, position;

--group by절에 있는 컬럼과 그룹함수만 select절에 올 수 있다
select deptno, position, name, avg(nvl(pay,0))  --error
from professor
group by deptno, position
order by deptno, position;

--
select deptno as dno, position, avg(pay)
from professor
group by dno, position  --error : group by절에서는 별칭 사용 불가
order by dno, position;  --order by절에는 별칭 사용 가능

--부서별 평균급여를 구한 후, 평균 급여가 450 초과인 부서의 부서번호와 평균 급여를 구하시오.
select * from professor;

select deptno, avg(nvl(pay,0))
from professor
where avg(nvl(pay,0)) > 450  --error:group function is not allowed here
group by deptno
order by deptno;
--=> where절에는 그룹함수가 올 수 없다

select deptno, avg(nvl(pay,0))
from professor
group by deptno
--having avg(nvl(pay,0)) > 450
order by deptno;
/*
    having
    - group by의 결과내에서 특정 조건을 만족하는 것을 구하려면 having을 이용한다
    - group by절에 의해 출력된 결과에 대한 조건을 정의한다
    - group by된 결과를 제한하고자할 때 사용
    
    group by 컬럼
    having 조건
*/
--student에서 grade별로 weight,height의 평균, 최대값 구하기
select grade, avg(nvl(weight, 0)), avg(nvl(height, 0)),
    max(weight), max(height)
from student
group by grade;

--위의 결과에서 키의 평균이 170이하인 경우 구하기
select grade, avg(nvl(weight, 0)), avg(nvl(height, 0)),
    max(weight), max(height)
from student
group by grade
having  avg(nvl(height, 0))<=170;

select * from student
order by deptno1;

--student에서 201학과에서 grade별로 weight,height의 평균, 최대값 구하는데
--키의 평균이 175이하인 경우만 조회
select grade, avg(nvl(weight, 0)), avg(nvl(height, 0)),
    max(weight), max(height)
from student
where deptno1=201
group by grade
having  avg(nvl(height, 0))<=175;

/*
1.  emp테이블의 부서별 급여의 총합 구하기.
     
2. emp 테이블의 job별로 급여의 합계 구하기.

3. emp 테이블의 job별로 최고 급여 구하기

4. emp 테이블의 job별로 최저 급여 구하기
*/

select deptno, sum(sal)
     from emp group by deptno;

select job, sum(sal)
from emp group by job;
          
select  job, max(sal)
from emp group by job;

select job, min(sal)
from emp group by job;

/*
1. emp 테이블의 job별로 급여의 평균 구하기 ? 소수이하 2자리만 표시

2. Student 테이블에서 grade별로 weight, height의 평균, 최대값 구하기
3.  2번의 결과에서 키의 평균이 170 이하인 경우 구하기

4.  emp2 테이블에서 emp_type별로 pay의 평균을 구한 상태에서 평균 연봉이 3천만원 이상인 
경우의 emp_type 과 평균 연봉을 읽어오기

5. emp2의 자료를 이용해서 직급(position)별로 사번(empno)이 제일 늦은 사람을 구하고 
그 결과 내에서 사번이 1997로 시작하는 경우 구하기
	(사번의 최대값), like 이용

6. emp 테이블에서 hiredate가 1982년 이전인 사원들 중에서 deptno별, job별 sal의 합계를 구하되
	그 결과 내에서 합계가 2000 이상인 사원만 조회
*/
select job, round(avg(nvl(sal,0)),2)
from emp 
group by job;

select grade, avg(height), avg(weight), max(height), max(weight) 
from student
group by grade
having avg(height)<=170;

 select emp_type, avg(nvl(pay,0)) from emp2 
 group by emp_type
 having avg(pay) >=30000000;

select position, max(empno)
from emp2 group by position
having max(empno) like '1997%';

select deptno, job, sum(sal) from emp
where hiredate < '1982-01-01' 
group by  deptno, job
having sum(sal)>2000
order by  deptno, job;


--select sql문 실행 순서
/*
5. select 컬럼
1. from 테이블
2. where 조건
3. group by 그룹핑할 컬럼
4. having 조건
6. order by 컬럼
*/ 

--rollup,cube : group by와 함께 사용
--[1] rollup() - 주어진 데이터들의 소계를 구해줌
--group by절에 주어진 조건으로 소계값을 구해줌

--학과별 평균 기본급
select deptno, round(avg(nvl(pay,0)),1) "평균기본급"
from professor
group by deptno
order by deptno;

select deptno, round(avg(nvl(pay,0)),1) "평균기본급"
from professor
group by rollup(deptno)
order by deptno;

--cube
select deptno, round(avg(nvl(pay,0)),1) "평균기본급"
from professor
group by cube(deptno)
order by deptno;

--group by한 컬럼이 2개인 경우
--rollup
--학과별, 직급별 평균 기본급
select deptno, position, avg(nvl(pay,0)) "평균 기본급"
from professor
group by deptno, position
order by deptno, position;

select deptno, position, avg(nvl(pay,0)) "평균 기본급"
from professor
group by rollup(deptno, position)
order by deptno, position;
--학과별,전체 소계가 추가됨

--cube
select deptno, position, avg(nvl(pay,0)) "평균 기본급"
from professor
group by cube(deptno, position)
order by deptno, position;
--학과별, 직급벼, 전체 소계가 추가됨

--group by한 컬럼이 3개인 경우
select * from emp_details_view;

--지역별, 부서별, 직군별 평균 급여 구하기
select city, department_name, job_id, 
    round(avg(nvl(salary, 0)),1) "평균 급여"
from emp_details_view
group by city, department_name, job_id
order by city, department_name, job_id;

--rollup
select city, department_name, job_id, 
    round(avg(nvl(salary, 0)),1) "평균 급여"
from emp_details_view
group by rollup(city, department_name, job_id)
order by city, department_name, job_id;

--rollup(컬럼) => 컬럼의 개수 + 1 개의 소계가 만들어짐
--예) rollup(a,b,c) => (a,b,c), (a,b), (a), () => 3+1 => 4개의 소계가 만들어짐

--cube
select city, department_name, job_id, 
    round(avg(nvl(salary, 0)),1) "평균 급여"
from emp_details_view
group by cube(city, department_name, job_id)
order by city, department_name, job_id;

--cube(컬럼) =>  2의 컬럼승 개의 소계가 만들어짐(모든 경우의 수)
--예) cube(a,b,c) => 모든 경우의 수만큼의 소계가 만들어짐, 2의 3승 개 => 8개
--(a,b,c), (a,b),(a,c),(b,c), (a),(b),(c), ()

--grouping() - rollup, cube함수와 같이 사용됨
--소계에 대한 요약 정보를 줄 때 사용
--그룹핑 작업에 사용되었으면 0, 사용되지 않았으면 1을 리턴함

--group by한 컬럼이 1개인 경우, rollup
select deptno, round(avg(nvl(pay,0)),1) "평균기본급",
    grouping(deptno)
from professor
group by rollup(deptno)
order by deptno;
    
select deptno, round(avg(nvl(pay,0)),1) "평균기본급",
    grouping(deptno)
from professor
group by cube(deptno)
order by deptno;

--group by한 컬럼이 2개인 경우
--rollup
select deptno, position, round(avg(nvl(pay,0)),1) "평균기본급",
    grouping(deptno), grouping(position)
from professor
group by rollup(deptno, position)
order by deptno,position;

--
select decode(grouping(deptno),0, to_char(deptno),'[전체]') "학과",
    decode(grouping(position),0, position, '[학과별 소계]') "직급", 
    round(avg(nvl(pay,0)),1) "평균기본급",
    grouping(deptno), grouping(position)
from professor
group by rollup(deptno, position)
order by deptno,position;

--
select decode(grouping(deptno),0, to_char(deptno),'[전체]') "학과",
    decode(grouping(position),0, position, 
                decode(grouping(deptno),0,'[학과별 소계]','[총합계]')) "직급", 
    round(avg(nvl(pay,0)),1) "평균기본급",
    grouping(deptno), grouping(position)
from professor
group by rollup(deptno, position)
order by deptno,position;

--cube
select deptno, position, round(avg(nvl(pay,0)),1) "평균기본급",
    grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno,position;

select decode(grouping(deptno),1,  '[직급별소계]',deptno) "학과", 
   decode(grouping(position),0,position,'[학과별 소계]') "직급" 
  , round(avg(nvl(pay,0)),1) "평균기본급",
    grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno,position;

--

select decode(grouping(deptno),1, 
        decode(grouping(position),0,'[직급별소계]','[전체]'),deptno) "학과", 
   decode(grouping(position),0,position, 
        decode(grouping(deptno),0, '[학과별 소계]','[소계]')) "직급" 
  , round(avg(nvl(pay,0)),1) "평균기본급",
    grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno,position;

--grouping sets - 원하는 집계만 수행할 수 있다
--그룹핑 조건이 여러 개일 경우 유용하게 사용

--예) STUDENT 테이블에서 학년별로 학생들의 인원수 합계와 학과별로 인원수의 합계를
-- 구해야 하는 경우에 기존에는 학년별로 인원수 합계를 구하고 별도로 학과별로 인원수 
--합계를 구한 후 UNION 연산을 했음
select * from student;

--[2019-10-01 화]
--union 이용
select grade, count(*)
from student
group by grade
union
select deptno1, count(*)
from student
group by deptno1;

--cf. 학년별, 학과별 인원수
select grade, deptno1, count(*)
from student
group by grade, deptno1
order by grade, deptno1;

--grouping sets
select grade, deptno1, count(*)
from student
group by grouping sets((grade), (deptno1))
order by grade, deptno1;

--rollup
select deptno, position, round(avg(nvl(pay,0)),1) "평균기본급"
from professor
group by rollup(deptno, position)
order by deptno, position;

--grouping sets 을 이용한 rollup과 동일한 상황
select deptno, position, round(avg(nvl(pay,0)),1) "평균기본급"
from professor
group by grouping sets((deptno, position),(deptno),())
order by deptno, position;


--grouping sets 을 이용한 cube와 동일한 상황
select deptno, position, round(avg(nvl(pay,0)),1) "평균기본급"
from professor
group by grouping sets((deptno, position),(deptno),(position),())
order by deptno, position;

--원하는 집계만
select deptno, position, round(avg(nvl(pay,0)),1) "평균기본급"
from professor
group by grouping sets((deptno, position), (position))
order by deptno, position;

--emp에서 부서별, 직급별 sal의 합계 구하기
--[1]group by 이용
select deptno, job, sum(sal)
from emp
group by deptno, job
order by deptno, job;

--[2]세로 출력
select ename, deptno, job, sal,
    decode(job, 'ANALYST', sal),
    decode(job, 'CLERK', sal),
    decode(job, 'MANAGER', sal),
    decode(job, 'PRESIDENT', sal),
    decode(job, 'SALESMAN', sal)
from emp
order by deptno, job;

--
select deptno,
sum(decode(job, 'ANALYST', sal)) "ANALYST",
sum(decode(job, 'CLERK', sal)) "CLERK",
sum(decode(job, 'MANAGER', sal)) "MANAGER",
sum(decode(job, 'PRESIDENT', sal)) "PRESIDENT",
sum(decode(job, 'SALESMAN', sal)) "SALESMAN"
from emp
group by deptno
order by deptno;

select deptno,
count(decode(job, 'ANALYST', sal)) "ANALYST",
count(decode(job, 'CLERK', sal)) "CLERK",
count(decode(job, 'MANAGER', sal)) "MANAGER",
count(decode(job, 'PRESIDENT', sal)) "PRESIDENT",
count(decode(job, 'SALESMAN', sal)) "SALESMAN"
from emp
group by deptno
order by deptno;


select deptno, 
sum(decode(job, 'ANALYST', sal)) "ANALYST",
sum(decode(job, 'CLERK', sal)) "CLERK",
sum(decode(job, 'MANAGER', sal)) "MANAGER",
sum(decode(job, 'PRESIDENT', sal)) "PRESIDENT",
sum(decode(job, 'SALESMAN', sal)) "SALESMAN"
from emp
group by rollup(deptno)
order by deptno;

--월별매출(월별로 price의 합계 구하기)
--[1] group by 이용
select
to_char(regdate,'mm'), sum(price) --extract(month from regdate)도 가능
from pd
group by to_char(regdate,'mm')
order by to_char(regdate,'mm');

--[2]월이 가로가 되도록 출력
select 
sum(decode(to_char(regdate,'mm'),'01', price, 0)) "1월",
sum(decode(to_char(regdate,'mm'),'08', price)) "8월",
sum(decode(to_char(regdate,'mm'),'09', price)) "9월",
sum(price) "전체합계"
from pd;

--panmae 테이블에서 수량(p_qty)이 3개 이상인 데 이터에 대해 판매일(p_date)별, 판매점(p_store) 별로 판매금액(p_total)의 합계 구하기 ? 
--rollup, cube이용하여 소계 출력 ? 
--각각의 경우 grouping함수를 이용해서 요약정보 출력하 기(decode()도 이용)
select p_date, p_store, sum(p_total),
decode(grouping(p_date), 0, to_char(p_date),'[전체]') "날짜",
decode(grouping(p_store), 0, to_char(p_store),'[소계]') "가게"
from panmae
where p_qty>=3
group by rollup(p_date, p_store)
order by p_date, p_store;

select p_date, p_store, sum(p_total),
decode(grouping(p_date), 0, to_char(p_date),'[전체]') "날짜",
decode(grouping(p_store), 0, to_char(p_store),'[소계]') "가게"
from panmae
where p_qty>=3
group by cube(p_date, p_store)
order by p_date, p_store;


-- professor 테이블을 사용하여 교수 중에서 급여(pay)와 보너스 (bonus)를 합친 금액이 가장 많은 경우와 가장 적은 경우, 평균 금액 을 구하시오. ? 
--단, 보너스가 없을 경우는 보너스를 0으로 계산하고, 출력 금액은 모두 소 수점 첫째 자리까지만 나오게 하시오 ? 
--max, min, avg, round, nvl 함수 사용
select max(pay+nvl(bonus, 0)) "최대값" , min(pay+nvl(bonus, 0)) "최소값" , round(avg(pay+nvl(bonus, 0)), 1) "평균"
from professor;


select decode(grouping(deptno),1, 
        decode(grouping(position),0,'[직급별소계]','[전체]'),deptno) "학과", 
   decode(grouping(position),0,position, 
        decode(grouping(deptno),0, '[학과별 소계]','[소계]')) "직급" 
  , round(avg(nvl(pay,0)),1) "평균기본급",
    grouping(deptno), grouping(position)
from professor
group by cube(deptno, position)
order by deptno,position;


