[ 오라클 1강 ]

1. 데이터베이스(Database, DB)란?
여러 응용시스템들이 공유할 수 있도록 통합,저장된 데이터의 집합
중복을 최소화하고, 다수의 사용자가 공유할 수 있도록 데이터들을 모아둔 시스템
단순히 데이터가 모여 있는 것을 의미하는 것이 아니라 사용자 요구에 따라 필요한 
데이터를 신속하게 검색할 수 있어야 하고 데이터를 추가, 삭제, 수정할 수 있도록 
구성된 데이터의 집합체

2. 데이터베이스 관리시스템 (DataBase Mamanagement System, DBMS)이란?
모든 응용프로그램들이 데이터베이스를 공유할 수 있도록 관리해 주고 
데이터베이스를 유지하기 위한 일련의 소프트웨어 시스템 
데이터를 적절하고 효율적으로 관리하기 위한 체계적인 시스템
예) Oracle, MS SQL Server, mysql, informix, sybase 등


3. 공통으로 들어갈 용어는?
데이터베이스에 사용되는 데이터들은 정해진 형식과 규칙대로 저장되어야 한다. 
이들 데이터를 저장하기 위한 기본 형식을 제공하는 것이 바로 (테이블)이다.

(테이블)은 데이터를 저장하고 추가, 삭제, 수정 하는 등의 기본적인 데이터 관리 기능을 한다.


4. 가장 대표적인 데이터베이스 시스템으로 데이터들을 2차원 구조를 가진 테이블 형태로 
저장하는 특징을 갖는 데이터베이스는?

관계형 데이터베이스(Relational-Database)


5. 데이터베이스의 구조에서  (필드 (Field))는 테이블의 열에 해당되는 것으로 컬럼이라고도 한다
(레코드(Record))는 테이블의 각 행(row)을 의미한다.
(테이블(Table))은 여러 개의 레코드를 담고 있는 논리적인 구조를 말한다.


6. 관계란 업무적인 연관성이다.
 관계는 두 테이블 사이에 존재하며, 관계를 맺고 있는 두 테이블 중 반드시 하나는 
부모 테이블이고 하나는 자식 테이블이다.
 부모 테이블의 (기본키(Primary key))는 자식 테이블에 (외래키(Foreign Key))로 전이 되어진다.


7. (외래키(Foreign key))는 테이블들 간에 관계를 맺고 있을 때 자신의 개체(테이블)내에서 
키의 역할을 하지는 않지만, 다른 개체(테이블)의 기본키와 동일한 값을 가지고 있어서 
다른 개체(테이블)을 참조할 때 사용하는 필드이며,
(기본키(Primary key))는 하나의 행을 다른 행과 유일하게 구별할 수 있도록 해 주는 열을 의미한다.


8. sqlplus 툴에서 다음 각 문장을 실행시키면 어떻게 되나?
SQL>alter user hr account unlock; 

=> hr 사용자 잠김 해제

SQL>alter user hr identified by hr123; 

=> hr123으로 hr의 비밀번호 변경


9. SERVICE_NAME, HOST, PORT 를 확인하기 위해서는 오라클 설정화일을 확인해야 한다.
어떤 폴더에서 어떤 설정화일을 찾아봐야 할까?

listener.ora
tnsnames.ora

C:\oraclexe\app\oracle\product\11.2.0\server\network\ADMIN\


10. cmd 창에서 sys 계정에 접속하려면 어떤 명령을 이용해야 하나?

sqlplus  / as sysdba


11. SQL은 대소문자 구분 (안한다).
데이터는 대소문자 (구분한다).


12. SQL문의 종류 3가지는 DML, DDL, DCL이다.
(DML ( Data Manipulation Language))은 데이터 조작어로
데이터를 조회, 저장, 삭제할 때 사용되는 SQL 문장이다.
SELECT, INSERT, UPDATE, DELETE 문이 이에 해당된다.

(DDL ( Data Definition Language))은 데이터 정의어로
데이터베이스 객체들(테이블, 인덱스, 뷰, 트리거 등)을 생성하는데 사용되는 SQL 문장이다.
CREATE, DROP, ALTER, TRUNCATE 문이 이에 해당된다.

(DCL ( Data Control Language))은 데이터 제어어로
데이터베이스에 있는 데이터에 접근을 제어하는 언어이다.
GRANT, REVOKE 가 이에 해당된다.



13. 다음 쿼리문을 작성하시오

--(1) 학생 테이블에서 전체 데이터 조회하기 (전체 컬럼 가져오기)
select * from student;

--(2)학생 테이블에서 키가 175이상인 학생의 이름(name), 학년(grade), 키(height) 데이터 가져오되,키가 큰 순서대로 
select name,grade,height
from student
where height>=175;


--(3)학과(deptno1)가 201번이고 3학년(grade) 이하의 학생의 이름(name), 아이디(id), 학년(grade)데이터 가져오기.
select name, id,grade
from student 
where deptno1=201 and grade <=3; 
 
--(4)교수테이블에서 급여(pay)가 350에서 500사이인 교수의 이름(name), 아이디(id), 급여(pay) 데이터 가져오기
select name,id,pay
from professor
where pay between 350 and 500;
 
--(5)교수 테이블에서 직급(position)이 정교수, 조교수인 이름(name), 아이디(id), 직급(position), 급여(pay) 데이터가져오기
select name, id, position, pay
from professor
where position in ('정교수','조교수');
 
--(6) 교수 테이블에서 bonus을 받지 않는 교수의 이름(name), 아이디(id), 직급(position)데이터 가져오기
select name, id, position
from professor
where bonus is null; 


--(7) department 테이블에서 deptno, dname, build 컬럼만 조회
--조건 : 학과(dname)에 '정보'라는 단어가 들어간 학과만을 조회하기
--정렬 : dname 순으로 오름차순으로 정렬

select deptno, dname, build from department
where dname like '%정보%';


--(8) emp2 테이블에서 emp_type, position 컬럼을 조회하되 중복된 행(레코드)은 제거
 
 select distinct emp_type, position from  emp2;


--(9)교수테이블에서 교수의 이름(name), 직급(position),급여(pay), 보너스(bonus), 연봉(pay*12+bonus)  
--데이터 가져오기
--모든 컬럼은 이름, 직급, 급여, 보너스, 연봉으로 별칭을 설정하여 출력한다
select name 이름, position 직급, pay 급여, bonus 보너스, pay*12+bonus  as 연봉 
from professor;

--(10) emp2 테이블을 사용하여 모든 사원들이 '최일도 과장의 연봉은 50000000원입니다.'와 같은 형식으로
--출력되도록 리터럴 문자를 추가하고, 칼럼이름은 "사원의 연봉"이라는 별명으로 출력하기

select name || ' ' || position || '의 연봉은 ' || pay || '원입니다.' as "사원의 연봉" 
from emp2;

--(11) professor 테이블을 참조하여 직급이 전임강사인 교수들의 교수번호, 이름, 
--입사일, 학과 번호, 직급을 출력하시오.

select profno, name, hiredate, deptno, position from professor
where position='전임강사';

--(12) emp2에서 생일이 1985/01/25인 사원을 출력하시오
select * from emp2
where birthday='1985-01-25';

--(13) emp2에서 이름이 김 ~ 박 사이인 사원을 조회하시오.
select * from emp2
where name >= '김' and name<= '박';

select * from emp2
where name between '김' and '박';

--(14) emp2에서 생일이 1980~1985 사이가 아닌 사원을 출력하시오
select * from emp2
where birthday <'1980-01-01' or birthday>'1985-12-31';

select * from emp2
where birthday not between '1980-01-01' and '1985-12-31';


--(15) emp2에서 정규직이 아닌 사원을 출력하시오.
select * from emp2
where emp_type != '정규직';


--(16) employees에서 email이 O 앞에  2글자, O 뒤에 3 글자가 오는 것만 조회 
select * from employees
where email like '__O___';



--(17) employees 에서 사원아이디, 이름 - 성(Steven-King), 입사일, 
--기본급(salary),수당(기본급*commission_pct), 급여(salary+수당) 출력
--모든 컬럼은 별칭을 사용한다

select employee_id as "사원아이디", 
first_name || '-' || last_name as "사원이름",
hire_date as "입사일", salary as "기본급",
salary*commission_pct as "수당", 
salary+salary*commission_pct as "급여" 
from employees;


--(18) student 테이블을 사용하여 2학년이거나 또는 몸무게가 75kg 이상인 
--학생들의 이름과 학년, 키, 몸무게를 조회
select name, grade, height, weight from student
where grade=2 or weight>=75;


--(19)학생 테이블에서 키가 180이하인 학생의 이름(name), 학년(grade), 키(height), 몸무게  데이터 가져오되,
--키가 큰 순서대로, 키가 같을때는 몸무게가 적은 순서대로 
select name,grade,height, weight
from student
where height<=180
order by height desc, weight;

--(20) department 테이블에서 deptno, dname, build 컬럼만 조회
--조건 : 학과(dname)에 '공학'이라는 단어가 들어간 학과만을 조회하기
--정렬 : dname 순으로 오름차순으로 정렬
select deptno, dname, build from department
where dname like '%공학%'
order by dname;

--(21) emp 테이블에서 comm의 값이 없는 사원의 이름(ename), job, sal, comm 데이터 가져오기
select ename, job, sal, comm from emp
where comm is null; 

--(22) emp 테이블에서 comm의 값이 있는 사원의 데이터 가져오기
select * from emp
where comm is not null; 

--(23) employees에서 job_id가 PR_ 가 포함된 것 조회
select * from employees
where job_id like '%PR\_%' escape '\';


--(24) emp2 테이블에서 emp_type, position 컬럼을 조회하되
--중복된 행(레코드)은 제거

select distinct emp_type, position from  emp2;

--select emp_type, position from  emp2;

--(25) student 테이블을 참조해서 1전공이 201번인 학생의 이름과 전화번호와 지역번호를 출력. 
--단, 지역번호는 숫자만 나와야 함

select name, tel, instr(tel, ')') as ")위치", 
    substr(tel, 1, instr(tel, ')')-1) 지역번호 from student
where deptno1=201;

--(26) student 테이블과 professor 테이블을 참조하여 301번 학과에 소속되어 있는 학생과 교수들의 학번(교수는 교수번호), 
--이름, 학과 번호를 출력

select '[교수]' as "구분", 
    profno, name, id, hiredate, deptno from professor
where deptno=301
union
select '[학생]' as "구분", 
    studno, name, id, birthday, deptno1 from student
where deptno1=301;

--(27) 집합 연산자 사용시 주의사항
1) (컬럼의 개수)가 일치해야 함
2) (컬럼의 자료형)이 일치해야 함

--(28) student 테이블에서 1전공이 201번인 학생들의 이름과 학년, 주민번호를 출력하되 
--주민번호의 뒤 7자리는 '#'로 표시되게 출력
select name, grade, jumin,
    replace(jumin, substr(jumin,  7), '#######') 
    as "replace2"
from student
where deptno1 = 201;


--(29) test_file 테이블에서  파일명만 추출하기(example.txt, abc.java)
select filepath, 
substr(filepath, instr(filepath, '\', -1)+1) 파일명
from test_file;