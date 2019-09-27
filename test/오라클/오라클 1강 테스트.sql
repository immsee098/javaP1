
--(1) 학생 테이블에서 전체 데이터 조회하기 (전체 컬럼 가져오기)
select * from student;


--(2)학생 테이블에서 키가 175이상인 학생의 이름(name), 학년(grade), 키(height) 데이터 가져오기.
select name, grade, height from student
where height>=175;


--(3)학과(deptno1)가 201번이고 3학년(grade) 이하의 학생의 이름(name), 아이디(id), 학년(grade)데이터 가져오기.
select name, grade, height from student
where deptno1=201 and grade=3;

 
--(4)교수테이블에서 급여(pay)가 350에서 500사이인 교수의 이름(name), 아이디(id), 급여(pay) 데이터 가져오기
select name, id, pay from professor
where pay between 350 and 500;

 
--(5)교수 테이블에서 직급(position)이 정교수, 조교수인 이름(name), 아이디(id), 직급(position), 급여(pay) 데이터가져오기
select name, id, position, pay from professor
where position like '정교수';

 
--(6) 교수 테이블에서 bonus을 받지 않는 교수의 이름(name), 아이디(id), 직급(position)데이터 가져오기
select name, id, position from professor
where bonus is not null;


--(7) department 테이블에서 deptno, dname, build 컬럼만 조회
--조건 : 학과(dname)에 '정보'라는 단어가 들어간 학과만을 조회하기
select deptno, dname, build from department
where dname like '%정보%';



--(8) emp2 테이블에서 emp_type, position 컬럼을 조회하되 중복된 행(레코드)은 제거
select distinct emp_type, position from emp2;
 


--(9)교수테이블에서 교수의 이름(name), 직급(position),급여(pay), 보너스(bonus), 연봉(pay*12+bonus)  
--데이터 가져오기
--모든 컬럼은 이름, 직급, 급여, 보너스, 연봉으로 별칭을 설정하여 출력한다
select name "이름", position "직급", pay "급여", bonus "보너스", pay*12+bonus "연봉" from professor;



--(10) emp2 테이블을 사용하여 모든 사원들이 '최일도 과장의 연봉은 50000000원입니다.'와 같은 형식으로
--출력되도록 리터럴 문자를 추가하고, 칼럼이름은 "사원의 연봉"이라는 별명으로 출력하기
select name || ' ' || position || '의 연봉은' || pay || '원입니다.' as "사원의 연봉" from emp2;


--(11) professor 테이블을 참조하여 직급이 전임강사인 교수들의 교수번호, 이름, 
--입사일, 학과 번호, 직급을 출력하시오.
select profno, name, hiredate, deptno, position from professor
where position like '전임강사';



--(12) emp2에서 생일이 1985/01/25인 사원을 출력하시오
select * from emp2
where birthday  = to_date('1985-01-25');


--(13) emp2에서 이름이 김 ~ 박 사이인 사원을 조회하시오.
select * from emp2
where name between '김' and '박';



--(14) emp2에서 생일이 1980~1985 사이가 아닌 사원을 출력하시오
select * from emp2
where birthday < '1980-01-01' or birthday > '1981-01-01';



--(15) emp2에서 정규직이 아닌 사원을 출력하시오.
select * from emp2
where emp_type <> '정규직';



--(16) employees에서 email이 O 앞에  2글자, O 뒤에 3 글자가 오는 것만 조회 
select * from employees
where email like '%__O___%';


--(17) employees 에서 사원아이디, 이름 - 성(Steven-King), 입사일, 
--기본급(salary),수당(기본급*commission_pct), 급여(salary+수당) 출력
--모든 컬럼은 별칭을 사용한다
select employee_id as "사원아이디", first_name|| '-' ||last_name as "이름-성", 
hire_date as "입사일", salary "기본급", salary*commission_pct as "수당", 
salary+(salary*commission_pct) as "급여"
from employees
order by "입사일", "기본급" desc;



--(18) student 테이블을 사용하여 2학년이거나 또는 몸무게가 75kg 이상인 
--학생들의 이름과 학년, 키, 몸무게를 조회
select name, grade, height, weight from student
where grade=2 or weight>=75;


--(19)학생 테이블에서 키가 180이하인 학생의 이름(name), 학년(grade), 키(height), 몸무게  데이터 가져오되,
--키가 큰 순서대로, 키가 같을때는 몸무게가 적은 순서대로 
select name, grade, height, weight from student
where height<=180
order by height desc, weight; 


--(20) department 테이블에서 deptno, dname, build 컬럼만 조회
--조건 : 학과(dname)에 '공학'이라는 단어가 들어간 학과만을 조회하기
--정렬 : dname 순으로 오름차순으로 정렬
select deptno, dname, build from department
where dname like '%공학%'
order by dname asc;



--(21) emp 테이블에서 comm의 값이 없는 사원의 이름(ename), job, sal, comm 데이터 가져오기
select ename, job, sal, comm from emp
where comm is null;


--(22) emp 테이블에서 comm의 값이 있는 사원의 데이터 가져오기
select ename, job, sal, comm from emp
where comm is not null;



--(23) employees에서 job_id가 PR_ 가 포함된 것 조회
select * from employees
where job_id like '%PR\_%' escape '\';


--(24) emp2 테이블에서 emp_type, position 컬럼을 조회하되
--중복된 행(레코드)은 제거
select distinct emp_type, position from emp2;


--(25) student 테이블을 참조해서 1전공이 201번인 학생의 이름과 전화번호와 지역번호를 출력. 
--단, 지역번호는 숫자만 나와야 함
select name, tel, substr(tel, 1, 3) as "지역번호"
from student;


--(26) student 테이블과 professor 테이블을 참조하여 301번 학과에 소속되어 있는 학생과 교수들의 학번(교수는 교수번호), 
--이름, 학과 번호를 출력
select studno, name, deptno1 from student
union
select profno, name, deptno from professor;

--(27) 집합 연산자 사용시 주의사항
--select의 칼럼 개수 동일해야함
--위의 칼럼 데이터타입도 동일해야함


--(28) student 테이블에서 1전공이 201번인 학생들의 이름과 학년, 주민번호를 출력하되 
--주민번호의 뒤 7자리는 '#'로 표시되게 출력
select name, grade, replace(jumin, substr(jumin, 7,7), '#######')
from student
where deptno1 = 201;



--(29) test_file 테이블에서  파일명만 추출하기(example.txt, abc.java)
select
substr(filepath, instr(filepath,'\',-1, 1)+1) as "파일명"
from test_file;


