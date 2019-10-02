--[ 오라클 4강 ]


--(1) employees , jobs 테이블에서 first_name, salary, job_title 조회하기

select e.first_name, e.salary, j.job_title
from jobs j, employees e
where j.job_id = e.job_id;


--(2) employees , departments, locations  테이블에서 city, department_name, job_id, salary 조회하기
select c.city, b.department_name, a.job_id, a.salary
from employees a  join departments b
on a.department_id=b.department_id
 join locations c
on b.location_id=c.location_id;


--(3) employees , departments, locations  테이블에서 city별, department_name 별, job_id 별로 
--그룹화하여 city, department_name, job_id, 인원수, 급여(salary)합계  구하기
select c.city, b.department_name, a.job_id, count(*) "인원수", 
sum(salary) "급여합계"
from employees a  join departments b
on a.department_id=b.department_id
 join locations c
on b.location_id=c.location_id
group by city, department_name, job_id
order by city, department_name, job_id;


--(4) professor, department 테이블을 조인해서 profno(교수번호), name(이름), hiredate(입사일), dname(학과명) 조회하기
select p.profno, p.name, p.hiredate
from professor p, department d
where p.deptno = d.deptno;


--(5) emp2, dept2 테이블을 조인해서 dname(부서명), name(이름), pay(연봉) 조회하되, pay가 6000만원 이상인 데이터만 조회하기
select *
from emp2;

select *
from dept2;

select d.dname, e.name, e.pay
from emp2 e, dept2 d
where e.deptno = d.dcode
and e.pay>=60000000;


--(6) 학생 이름에 '신'이 들어간 학생들의 이름(name), 학년(grade), 주민번호(jumin), 전화번호(tel), 담당교수명(name) 데이터 가져오기
--student , professor 테이블 조인 (inner join 이용)
select *
from student;

select *
from professor;


--(7) 학생의 이름(name), 학년(grade), 담당교수명(name),학과명(dname) 데이터를 조회
--student , professor,department 테이블 조인 
--담당교수명은 별칭을 교수명으로 준다
--모든 학생이 출력되도록 한다(outer join)


--(8) emp2 테이블과 학과 p_grade 테이블을 join하여 사원이름, 직급, 
--현재연봉, 해당 직급의 연봉의 하한 금액과 상한 금액을  조회
--모든 사원이 출력되도록


--(9) emp, dept 테이블에서 부서이름별 sal의 평균 구하기

--(10) student 테이블과 exam_01 테이블을 조회하여 학생들의 학번, 이름, 점수, 학점을 출력하시오
--(학점은 dcode나 case이용- 90 이상이면'A', 80이상이면 'B', 70이상이면 'C', 60이상이면'D' 
--60미만이면 'F' )
select s.studno, s.name, e.total,
 case trunc(total,-1) when 100 then 'A'
                      when 90 then 'A' 
                      when 80 then 'B'
                      when 70 then 'C'
                      when 60 then 'D'
                      else 'F' end "학점" 
from student s join exam_01 e
on s.studno = e.studno;


--(11) EMP Table에 있는 EMPNO와 MGR을 이용하여 서로의 관계를 다음과 같이 출력하라. 
--‘FORD의 매니저는 JONES’
select *
from emp;

select a.ename, b.ename
from emp a, emp b
where a.empno = b.mgr
and a.ename='FORD';

--(12)학생테이블에서 학과(deptno1)별로 학생의 평균키 구하기
--평균키는 소수 이하 한자리만 나오도록 반올림한다(round 함수 이용)


--(13) 교수테이블에서 학과(deptno)별, 직급(position)별로 급여(pay)의 합 구하기
 

 
--(14) 조인의 종류에는 무엇이 있는지, 나열하고, 각각에 대해 설명하시오.



--(15) panmae 테이블에서 판매일(p_date)별로 판매금액(p_total)의 합계 구하기


--(16) panmae 테이블에서 수량(p_qty)이 3개 이상인 데이터에 대해 판매일(p_date)별, 판매점(p_store)별로 판매금액(p_total)의 합계, 건수 구하기
그 결과에서 건수가 2 이상인 데이터만 조회
select p_date, p_store, sum(p_total),
decode(grouping(p_date), 0, to_char(p_date),'[전체]') "날짜",
decode(grouping(p_store), 0, to_char(p_store),'[소계]') "가게"
from panmae
where p_qty>=3
group by rollup(p_date, p_store)
order by p_date, p_store;

--(17) panmae 테이블에서 상품코드(p_code)별로 판매금액(p_total)의 합계, 수량(p_qty)의 합계, 건수, 판매금액(p_total)의 평균 구하기
그 결과에서 판매금액(p_total)의 합계가 10000 이상이고, 수량(p_qty)의 합계가 15 이상인 데이터만 조회



--(18) panmae 테이블에서 판매점(p_store)별, 상품코드(p_code)별로 판매금액(p_total)의 합계, 평균 구하기
