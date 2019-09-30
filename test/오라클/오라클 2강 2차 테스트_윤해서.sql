--[ 오라클 2강 2차]

--(1) test_file 테이블에서  파일명만 추출하기(example.txt, abc.java)
select substr('c:\test\js\example.txt',12),
    substr('d:\css\sample\temp\abc.java',20)
     from dual;

--(2) employees 테이블에서 salary를 100의 자리에서 버림하시오.
--천단위 구분기호도 표시
select TO_CHAR(TRUNC(salary,  3), '99,999') 
from employees;


--(3) 현재일자와 오늘로부터 4년 5개월 6일 7시간 23분 42초 후의 날짜 구하기
select to_char(sysdate , 'yyyy-mm-dd hh24:mi:ss') , 
to_char(add_months(sysdate, 2*12 + 3) + 1 + 2/24 + 10/(24*60) + 5/(24*60*60) ,'yyyy-mm-dd hh24:mi:ss'), 
to_char(sysdate + to_yminterval('04-05') + to_dsinterval('006 07:23:42'),
'yyyy-mm-dd hh24:mi:ss') from dual; 

--(4) professor테이블에서 교수의 입사일 50일 후의 날짜를 구하시오.
select hiredate, hiredate+50
from professor;

--(5) professor테이블에서 교수의 입사후 3개월이 되는 날짜?
select hiredate, add_months(hiredate, 3)
from professor;

--(6) professor테이블에서 교수의 입사후 10년이 되는 날짜?
select hiredate, add_months(hiredate, 3)
from professor;

--(7) 오늘부터 수료일(2019-02-14)까지 남은 일수는?
select sysdate - to_date('2019-02-14')
from dual;

--(8) 2019-08-20 부터 오늘까지 경과된 일수는?
select sysdate - to_date('2019-02-14')
from dual;

--(9) 오늘부터 크리스마스(2019-12-25)까지 남은 달수는? (months_between)
select months_between(sysdate,'2019-12-25')
from dual; 

--(10) professor테이블에서 입사한지 오늘까지 몇일 되었나?

--(11) professor테이블에서 입사한지 오늘까지 몇달 되었나?

--(12) pd테이블에서 상품을 등록한지 몇시간이 지났는지 조회

--(13) 2012-02-07에 해당하는 달의 마지막 날짜는?
select last_day('2012-02-07')
from dual;

--(14) 현재일자를 다음 형식의 문자로 변환해서 출력하시오.
--2019-03-28 14:35:27 목
select TO_CHAR(sysdate, 'yyyy-mm-dd hh24:mi:ss day')
from dual;


--(15) emp 테이블의 hiredate 칼럼을 참조하여 입사일이 5월인 사원의 이름과 
--hiredate, job을 출력
select ename, hiredate, job
from emp
where to_char(hiredate, 'mm')=5;

--(16)emp 테이블에서 job이 CLERK 이나 ANALYST인 사원 조회 (in 이용)
select *
from emp
where job in ('CLERK', 'ANALYST');

--(17) pd 테이블에서 등록일(regdate) 이  2019-09-07 ~ 2019-09-27 일 사이의 데이터만 조회하기
--to_date 함수 이용하기
select * from pd
where regdate between to_date('2019-09-07') and to_date('2019-09-27')+1
order by regdate;


--(18) emp 테이블에서 사원의 이름, 입사일, 급여(sal), 커미션(comm), 연봉(sal*12+comm)  데이터 가져오기
--comm가 null이면 0으로 계산되도록 처리한다 -  nvl 함수 사용하기
select ename, hiredate, sal, comm, sal*12+nvl(comm, 0) as "연봉"
from emp;


--(19) gogak에서 jumin을 이용하여 성별을 출력 (1, 3 이면 남,  2, 4이면 여)
select gname, jumin, case when substr(jumin, 7, 1)='1' then '남'
            when substr(jumin, 7, 1)='2' then '여'
       end "성별"
from gogak; 


--(20) student에서 grade가 1이면 1학년, 2이면 2학년, 3이면 3학년,4이면 4학년이라고 출력
--decode() 이용
select name, grade, case grade when 1 then '1학년'
                               when 2 then '2학년'
                               when 3 then '3학년'
                               when 4 then '4학년'
                        end "학년",
                        case grade when 1 then '1학년'
                                   when 2 then '2학년'
                                   when 3 then '3학년'
                                   else '4학년'
                        end "학년2"
from student;


--(21) emp에서 이름, 입사일, 급여(sal), 부서 정보를 조회하되, 급여는 십의 자리에서 반올림하시오. 
--부서가 20이나 30인 데이터만 조회
select ename, hiredate, round(sal, -2), deptno
from emp;


--(22) emp2 테이블에서 emp_type, position 컬럼을 조회하되
--중복된 행(레코드)은 제거
select distinct emp_type, position
from emp2;


--(23) emp 테이블에서 comm의 값이 없는 사원의 이름(ename), job, sal, comm 데이터 가져오기
select ename, job, sal, comm
from emp
where comm is null;

--(24) department 테이블에서 deptno, dname, build 컬럼만 조회
--조건 : 학과(dname)에 '공학'이라는 단어가 들어간 학과만을 조회하기
--정렬 : dname 순으로 내림차순으로 정렬
select deptno, dname, build from department
where dname like '%공학%'
order by dname asc;


--(25)교수테이블에서 급여(pay)가 350에서 500사이인 교수의 이름(name), 아이디(id), 급여(pay) 데이터 가져오기
select name, id, pay
from professor
where pay between 350 and 500;