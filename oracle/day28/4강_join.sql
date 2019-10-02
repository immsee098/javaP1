--[2010-10-01]
--학생 테이블 (student)과 학과 테이블 (department)을 사용하여 학생이름, 1전공 학과번호 (deptno1), 1전공 학과이 름을 출력하시오.

--오라클 조인
select * from student;
select * from department;

select student.name, student.deptno1, department.dname
from student, department
where student.deptno1 = department.deptno;

select s.name, s.deptno1, d.dname
from student s , department d --별칭이용
where s.deptno1 = d.deptno;

select s.name, s.deptno1, d.dname
from student s join department d --별칭이용
on s.deptno1 = d.deptno;

select s.name, s.deptno1, d.dname
from student s inner join department d --별칭이용 --inner은 생략 가능
on s.deptno1 = d.deptno;

--4학년 학생들의 정보를 조회, 학과명도 출력
select s.name, s.deptno1, d.dname, s.grade
from student s, department d --별칭이용 --inner은 생략 가능
where s.deptno1 = d.deptno
and s.grade=4;

--ansi
select s.name, s.deptno1, d.dname, s.grade
from student s join department d --별칭이용 --inner은 생략 가능
on s.deptno1 = d.deptno
and s.grade=4;

--학생 테이블(student)과 교수 테이블(professor)을 join하여 
--학생이름, 지도교수 번호, 지도교수 이름을 출력하시오
select * from student;
select *from professor;

select s.name, s.profno, p.name
from student s join professor p
on s.profno = p.profno;
--> profno가 null인 것은 안 나온다


select * from employees;
select* from jobs;

select e.first_name, e.job_id, j.job_title 
from employees e join jobs j
on e.job_id = j.job_id;

select e.first_name, e.job_id, j.job_title 
from employees e, jobs j
where e.job_id = j.job_id;

--ansi join
select s.name, d.dname, p.name
from student s join department d 
on s.deptno1 = d.deptno
join professor p
on s.profno=p.profno;


-- emp2 테이블과 학과 p_grade 테이블을 join하여 사원이름, 직 급, 현재연봉, 해당 직급의 연봉의 하한 금액과 상한 금액을 출력하시 오
select * from emp2;
select * from p_grade;
select * from dept2;

select e.name, e.emp_type, e.pay, p.s_pay, p.e_pay
from emp2 e join p_grade p
on e.position = p.position;

select e.name, e.emp_type, e.pay, p.s_pay, p.e_pay, d.area
from emp2 e join p_grade p
on e.position = p.position
join dept2 d
on d.dcode = e.deptno;

--사원정보, 사원의 부서정보, 부서의 지역정보, 지역의 나라정보 조회
select * from employees;
select * from departments;
select *from locations;
select * from countries;

select e.first_name, e.salary, d.department_name, l.city, c.country_name
from employees e, departments d, locations l, countries c 
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id;


--1전공(depton1)이 101번인 학생들의 학생이름과 지도교수 이름을 출력하시오.
select * from student;
select * from professor;

select s.NAME, p.NAME
from student s, professor p
where s.profno=p.profno
and deptno1=101;

select e.name, e.pay, e.position, d.dname
from emp2 e, dept2 d
where e.deptno=d.dcode;

select e.name, e.pay, e.position, d.dname
from emp2 e join dept2 d
on e.deptno=d.dcode;

select * from emp2;
select * from dept2;

select deptno, avg(pay)
from emp2
group by deptno;

select d.dname, avg(nvl(pay,0))
from emp2 e join dept2 d
on e.deptno = d.dcode
group by d.dname
having d.dname like '%영업%';

--emp, dept 테이블에서 부서번호,사원명,직업,부서명,지역 조회 단, 직업(job)이 CLERK인 사원 데이터만 조회
select * from emp;
select * from dept;

select e.empno, e.ename, e.job, d.deptno, d.loc
from emp e join dept d
on e.deptno = d.deptno
where e.job='CLERK';

--student 테이블과 exam_01 테이블을 조회하여 학생들의 학번, 이름, 점수, 학점을 출력하시오 
--(학점은 dcode나 case이용- 90 이상이면 'A', 80이상이면 'B', 70이상이면 'C', 60이상이면'D' 60미만이면 'F' )
select * from student;
select * from exam_01;

select s.NAME, s.studno, e.studno, e.total,
decode((e.total/10), 9, 'A', 8, 'B', 7, 'C', 6, 'D', 'F')  
from student s join exam_01 e
on s.studno = e.STUDNO;

--employees , departments, locations  테이블에서 city별, department_name 별, 
--job_id 별로 그룹화하여 city, department_name, job_id, 인원수, 급여 (salary)합계 구하기
select * from employees;
select * from departments;
select * from locations;

select l.city, d.department_name, e.job_id, count(*), sum(salary)
from employees e join departments d
on e.department_id = d.department_id
join locations l
on l.location_id = d.location_id
group by l.city, d.department_name, e.job_id;


--student 테이블과 professor 테이블을 조인하여 학생이름과 지도교수 이름을 출력하시오. 
--단, 지도교수가 결정되지 않은 학 생의 명단도 함께 출력하시오

select s.*, p.name
from student s, professor p
where s.profno=p.profno; --inner join

select s.*, p.name
from student s, professor p
where s.profno=p.profno(+); --outer join

select s.*, p.name
from student s right join professor p
on s.profno=p.profno; --outer join

-------------
select s.*, p.name
from student s, professor p
where s.profno=p.profno(+)
union
select s.*, p.name
from student s, professor p
where s.profno(+)=p.profno;

select s.*, p.name
from student s full outer join professor p
on s.profno=p.profno;


select s.*, d.DNAME, p.name
from student s, department d, professor p
where s.deptno1=d.deptno
and s.profno=p.profno;

select * from employees;
select * from departments;
select * from locations;

select e.*, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and l.location_id(+) = d.department_id;

select e.*, d.department_name, l.city, c.country_name
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id(+)
and l.location_id(+) = d.department_id
and l.country_id = c.country_id(+)
order by e.department_id desc;

--employees, departments, locations 테이블에서
--city별, department_name별, job_id별로 그룹화하여 안원수, 급여합계 구하기

select l.city, d.department_name, e.job_id, count(*), sum(e.salary)
from employees e, departments d, locations l
where e.department_id=d.department_id(+)
and d.location_id = l.location_id(+)
group by l.city, d.department_name, e.job_id
order by l.city, d.department_name, e.job_id;

select l.city, d.department_name, e.job_id, count(*), sum(e.salary)
from employees e left join departments d
on e.department_id=d.department_id
left join locations l
on d.location_id = l.location_id
group by l.city, d.department_name, e.job_id
order by l.city, d.department_name, e.job_id;

--
select a.*, b.dname "상위부서명"
from dept2 a, dept2 b
where a.pdept=b.dcode
order by a.dcode;
--> 사장실 레코드 포함

select a.*, b.dname "상위부서명"
from dept2 a left join dept2 b
on a.pdept=b.dcode
order by a.dcode;
--> 사장실 레코드 포함

--사원정보와 해당 사원의 직속 상관의 이름을 출력
select e.*, m.first_name "직속 상관"
from employees e, employees m
where e.employee_id(+) = m.manager_id
order by e.employee_id;

--
select * from emp; --14
select * from dept; --4

select e.*, d.*
from emp e, dept d;

select e.*, d.*
from emp e, dept d
order by e.empno; --14*4 = 56

/*
1. emp2, p_grade 테이블에서 name(사원이름),  position(직급), 시작연도 (s_year), 끝연도(e_year)을 조회 ? 
   단, emp2 테이블의 데이터는 전부 출력되도록 할 것

2. EMP Table에 있는 EMPNO와 MGR을 이용하여 서로의 관계를 다음과 같이 출력하라. 
  ‘FORD의 매니저는 JONES’
*/

select *
from emp2 e, 
