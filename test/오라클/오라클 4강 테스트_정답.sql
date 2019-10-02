--[ 오라클 4강 ]


--(1) employees , jobs 테이블에서 first_name, salary, job_title 조회하기

select e.first_name, e.salary, j.job_title 
from employees e join jobs j
on e.job_id = j.job_id;

--(2) employees , departments, locations  테이블에서 city, department_name, job_id, salary 조회하기
select c.city, b.department_name, a.job_id, a.salary
from employees a, departments b, locations c
where a.department_id=b.department_id
and b.location_id=c.location_id;


select c.city, b.department_name, a.job_id, a.salary
from employees a  join departments b
on a.department_id=b.department_id
 join locations c
on b.location_id=c.location_id;

--(3) employees , departments, locations  테이블에서 city별, department_name 별, job_id 별로 
--그룹화하여 city, department_name, job_id, 인원수, 급여(salary)합계  구하기
select c.city, b.department_name, a.job_id, count(*) "인원수", 
sum(salary) "급여합계"
from employees a, departments b, locations c
where a.department_id=b.department_id
and b.location_id=c.location_id
group by city, department_name, job_id
order by city, department_name, job_id;

select c.city, b.department_name, a.job_id, count(*) "인원수", 
sum(salary) "급여합계"
from employees a join departments b
on a.department_id=b.department_id
left join locations c
on b.location_id=c.location_id
group by city, department_name, job_id
order by city, department_name, job_id;

--(4) professor, department 테이블을 조인해서 profno(교수번호), name(이름), hiredate(입사일), dname(학과명) 조회하기
select p.profno, p.name, p.hiredate, d.dname
from professor p, department d
where p.deptno=d.deptno;

--(5) emp2, dept2 테이블을 조인해서 dname(부서명), name(이름), pay(연봉) 조회하되, pay가 6000만원 이상인 데이터만 조회하기
select d.dname, e.name, e.pay
from emp2 e, dept2 d
where e.deptno=d.dcode
and e.pay >= 60000000;


--(6) 학생 이름에 '신'이 들어간 학생들의 이름(name), 학년(grade), 주민번호(jumin), 전화번호(tel), 담당교수명(name) 데이터 가져오기
--student , professor 테이블 조인 (inner join 이용)
select s.name, s.grade, s.jumin,s.tel, p.name
from student s, professor p 
where s.profno = p.profno
and s.name like '%신%'; 

select s.name, s.grade, s.jumin,s.tel, p.name
from student s join professor p 
on s.profno = p.profno
and s.name like '%신%'; 



--(7) 학생의 이름(name), 학년(grade), 담당교수명(name),학과명(dname) 데이터를 조회
--student , professor,department 테이블 조인 
--담당교수명은 별칭을 교수명으로 준다
--모든 학생이 출력되도록 한다(outer join)

select s.name,s.grade,p.name as 교수명, d.dname 
from student s, professor p, department d
where s.profno=p.profno(+)
and s.deptno1 = d.deptno(+);

select s.name,s.grade,p.name as 교수명, d.dname 
from student s left outer join professor p
on s.profno=p.profno
left join department d
on s.deptno1 = d.deptno;

--(8) emp2 테이블과 학과 p_grade 테이블을 join하여 사원이름, 직급, 
--현재연봉, 해당 직급의 연봉의 하한 금액과 상한 금액을  조회
--모든 사원이 출력되도록
select e.name "사원이름", e.position "직급", 
    e.pay "현재연봉", p.s_pay "하한금액", p.e_pay "상한금액" 
from emp2 e, p_grade p
where e.position=p.position(+);

--[ANSI join]
select e.name "사원이름", e.position "직급", 
    e.pay "현재연봉", p.s_pay "하한금액", p.e_pay "상한금액" 
from emp2 e left join p_grade p
on e.position=p.position;

--(9) emp, dept 테이블에서 부서이름별 sal의 평균 구하기
select d.dname "부서이름", avg(nvl(e.sal,0)) "평균연봉"
from emp e, dept d
where e.deptno=d.deptno
group by d.dname
order by d.dname;

select * from emp;
select * from dept;

--[ANSI join]
select d.dname "부서이름", avg(nvl(e.sal,0)) "평균연봉"
from emp e join dept d
on e.deptno=d.deptno
group by d.dname
order by d.dname;

--(10) student 테이블과 exam_01 테이블을 조회하여 학생들의 학번, 이름, 점수, 학점을 출력하시오
--(학점은 dcode나 case이용- 90 이상이면'A', 80이상이면 'B', 70이상이면 'C', 60이상이면'D' 
--60미만이면 'F' )

select s.studno, s.name, e.total,
 decode(trunc(total,-1), 100, 'A',90,'A',80,'B',70,'C',60,'D','F') "학점" 
from student s join exam_01 e
on s.studno = e.studno;

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
SELECT a.ename "사원이름", b.ename "매니저 이름"
          FROM emp a, emp b
          WHERE a.mgr = b.empno;  


--(12)학생테이블에서 학과(deptno1)별로 학생의 평균키 구하기
--평균키는 소수 이하 한자리만 나오도록 반올림한다(round 함수 이용)
select deptno1,avg(height), round(avg(nvl(height,0)),1) from student 
group by deptno1;


--(13) 교수테이블에서 학과(deptno)별, 직급(position)별로 급여(pay)의 합 구하기
select deptno, position,sum(pay) from professor
group by deptno, position;
 

 
--(14) 조인의 종류에는 무엇이 있는지, 나열하고, 각각에 대해 설명하시오.
내부 조인(Inner Join)-양쪽 테이블에 같은 조건이 존재할 경우의 값만을 가져오는 조인
-join에 참여하는 모든 테이블에 데이터가 존재하는 경우에만 결과값을 출력함
외부 조인(Outer Join)-한쪽 테이블에는 데이터가 있고 한쪽 테이블에 없는 경우에 데이터가 있는 쪽 테이블의 내용을 전부 출력하게 하는 방법
셀프 조인(Self Join)-원하는 데이터가 하나의 테이블에 다 들어 있을 경우, 자기 자신 테이블과 조인하는 것

--(15) panmae 테이블에서 판매일(p_date)별로 판매금액(p_total)의 합계 구하기
select p_date, sum(p_total) from panmae
group by p_date;


--(16) panmae 테이블에서 수량(p_qty)이 3개 이상인 데이터에 대해 판매일(p_date)별, 판매점(p_store)별로 판매금액(p_total)의 합계, 건수 구하기
그 결과에서 건수가 2 이상인 데이터만 조회

select p_date, p_store, sum(p_total), count(*) from panmae
where p_qty>=3
group by p_date, p_store
having count(*) >=2;

--(17) panmae 테이블에서 상품코드(p_code)별로 판매금액(p_total)의 합계, 수량(p_qty)의 합계, 건수, 판매금액(p_total)의 평균 구하기
그 결과에서 판매금액(p_total)의 합계가 10000 이상이고, 수량(p_qty)의 합계가 15 이상인 데이터만 조회

select p_code, sum(p_total), sum(p_qty), count(*) , avg(nvl(p_total, 0)) from panmae
group by p_code
having  sum(p_total)>=10000 and sum(p_qty) >= 15
order by p_code;


--(18) panmae 테이블에서 판매점(p_store)별, 상품코드(p_code)별로 판매금액(p_total)의 합계, 평균 구하기
select p_store, p_code, sum(p_total), sum(p_qty), avg(nvl(p_total, 0)) from panmae
group by p_store, p_code
order by p_store, p_code;

