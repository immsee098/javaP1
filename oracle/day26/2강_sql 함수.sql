select id, initcap(id) from student; --영문 첫글자만 대문자로

select 'pretty girl', initcap('pretty girl') from dual; --공백뒤도 대문자로

select id, initcap(id), upper(id), lower(id)
from student;

select lower('JAVA') from dual;

select * from emp
where ename = 'SCOTT';

select * from emp
where lower(ename) = 'scott';

--length(), lengthb() --문자열 길이 리턴
--lengthb() 바이트 리턴
--한글 1글자는 2~3바이트


select name, id, length(name) "이름의 길이", lengthb(name) "이름의 바이트수", length(id), lengthb(id)
from student;

--contcat('','') - 두 문자열 연결 함수. 세개이상은 || 사용 

select name || position as "교수이름",
concat(name, position) "concat 이용",
name || '-' || position "||연산자 이용"
from professor;

select concat(name, '-', position)
from professor; --error

--substr() 문자열에서 특정 길이의 문자열을 추출할 때 사용
--substr('문자열', 시작위치, 추출할 글자수)
--시작우치를 -로 하면 뒤에서부터 게산

select substr('abcdefghi', 2,3),
    substr('abcdefghi',6),
    substr('abcdefghi', -5, 2)
from dual;

select substr('java오라클', 5,2),
substr('java오라클',3, 3),
substr('java오라클',6),
substr('java오라클',-3,1)
from dual;

--캐릭터셋 확인
select parameter, value from nls_database_parameters
where parameter like '%CHAR%';

--student 테이블에서 JUMIN 칼럼을 사용하여 1전공이 101번인 학생들의 이름과 생년월일을 출력
select name, substr(jumin, 1, 6) as "생년월일" from student
where deptno1=101;

--student 테이블에서 JUMIN 칼럼을 사용하여 태어난 달이8월인 사람의 이름과 생년월일을 출력
--생년월일 출력
select name, substr(jumin, 1, 6) as "생년월일" from student
where substr(jumin, 4, 1) like '8';

--instr() - 주어진 문자열이나 컬럼에서 특정 글자의 위치를 찾아주는 함수
--instr('문자열', '찾는글자', 시작위치, 몇번째인지)
--몇번째의 기본값은 1

select 'A*B*C', instr('A*B*C', '*'),
    instr('A*B*C', '*', 3), instr('A*B*C','*',3,2) --3번째 위치 이후 2번째로 만나는 *위치
from dual;
--이것도 -<<붙일수잇음 위치에 -붙이면 뒤에서 n번째됨


--student 테이블의 TEL 칼럼을 사용하여 학생의 이름과 전화번호, ')'가 나오는 위치를 출력
select name, tel, instr(tel,')')
from student;

--실습 ) student 테이블을 참조해서 1전공이 101번인 학생의 이름과 전화번호와 지역번호를 출력. 단, 지역번호는 숫자만 나와야 함
select name, tel, substr(tel, 1, 3) as "지역번호"
from student;

select name, substrb(name, 1,3)
from student;

--

select 'c:\test\js\example.txt',
    'd:\css\sample\temp\abc.java' from dual;
    --> 파일명만 추출해보자
   
select substr('c:\test\js\example.txt',12),
    substr('d:\css\sample\temp\abc.java',20),
    substr('c:\test\js\example.txt',20),
    substr('d:\css\sample\temp\abc.java',24)
     from dual;
     
create table test_file(
    no number,
    filepath varchar2(100)
    );
    
    insert into test_file
    values(1, 'c:\test\js\example.txt');
    
    insert into test_file
    values(2, 'd:\css\sample\temp\abc.java');
    
select * from test_file;

select
substr(filepath, instr(filepath,'\',-1, 1)+1) as "파일명",
substr(filepath, instr(filepath,'.')+1) as "확장자명"
from test_file;

--student 테이블에서 1전공이 101번인 학과 학생들의 ID를 총 10자리로 출력하되 왼쪽 빈 자리는 '$'기호로 채우세요
select id, lpad(id, 10, '$')
from student
where deptno1=101;


select dname, lpad(dname, 10, '1'),
lpad(dname, 10, '1234567890')
from dept2;

--student 테이블에서 ID를 12자리로 출력하되 오른쪽 빈 자리에는 '*'기호로 채우세요
select id, rpad(id, 12, '*') from student;

--rtrim() 오른쪽해당문자 제거

select ltrim('javaoracle', 'abcdefghijvw'),
ltrim('javaoracle', 'java'),rtrim('javaoracle', 'oracle'),
rtrim('javaoracle', 'abcelmnopqr'),
'|' || ltrim('              javaoracle'),
rtrim('javaoracle              ') || '|'
from dual;


--DEPT2 테이블에서 DNAME을 출력하되 왼쪽에 '영'이란 글자를 모두 제거하고 출력
select dname, ltrim(dname, '영')
from dept2;

--DEPT2 테이블에서 DNAME을 출력하되 오른쪽 끝에 '부'라는 글자는 제거하고 출력
select dname, rtrim(dname, '부')
from dept2;

--replace('문자열' 또는 컬럼명, '문자1', '문자2')
select replace('javajsp', 'j', 'J'),
replace('javajsp', 'jsp', 'spring') from dual;

--student 테이블에서 학생들의 이름을 출력하되 성 부분은 '#'으로 표시되게 출력
select name, replace(name, substr(name, 1,1), '#')
from student;

--실습) student 테이블에서 1전공이 101번인 학생들의 이름을 출력하되 가운데 글자만 '#'으로 표시되게 출력
select name, replace(name, substr(name, 2,1), '#')
from student;

--실습) student 테이블에서 1전공이 101번인 학생들의 이름과 주민번호를 출력하되 주민번호의 뒤 7자리는 '*'로 표시되게 출력
select name, substr(jumin,7,7), replace(jumin, substr(jumin, 7,7), '*******')
from student;


--실습) student 테이블에서 1전공이 102번인 학생들의 이름과 전화번호, 전화번호에서 국번 부분만 '#' 처리하여 출력. 단, 모든 국번은 3자리로 간주함
select tel, replace(tel,substr(tel, 5,3),'###')
from student
where deptno1=102; 


--[0927]

select 1234.457, trunc(1234.457), trunc(12345.334,1)
from dual;

select first_name, salary, round(salary, -3)
from employees;

select mod(13,4), ceil(12.3), floor(17.85),
power(3,4) from dual;

select sysdate as "현재일자", sysdate+100 "100일 후",
sysdate-100 "100일전", sysdate+1 "하루 후" from dual;

select sysdate, sysdate+2+1/24,--2일 1시간 후
sysdate+2+1/24/(24*60)+10/24*60*60
from dual;

--select sysdate, add_month(sysdate,3)

select sysdate, add_months(sysdate,28) + 1+3/24
from dual;--

select sysdate, sysdate+to_tminterval('02-04') "2년 4개월후",
sysdate + to_dsinterval('1 03:10:20') "1일 3ㅅ기간 10분 20초후"
from dual;

select sysdate -to_date('2019-01-01')  --todate없이 '2019-01-01'를 하면 String으로 취급되어 에러남
from dual;

select to_date('2019-09-27') - to_date('2019-09-26') "내일과 간격"
from dual;

select sysdate - to_date('2019-09-26') "내일과 간격",
to_date('2019-09-28') - sysdate "내일과 간격"
from dual;
--> 1보다 작은 수가 나옴

--시간을 제오한 두 날ㅈ짜 사이의 간격 구하기

select sysdatem trunc(sysdate),
to_date('2019-09-28') - trunc(sysdate) "내일과 간격"
from dual;

--두 날짜 사이의 개월수
--months_between() - 두 날짜 사이의 개월수를 구해줌
select months_between('2019-09-28', '2018-06-27')
from dual;

select sysdate, next_day(sysdate, '월')
from dual;

--last date
-- 주어진 날짜가 속한 달의 가장 마지막을 훌력
select sysdate, last_day(sysdayte)
from dual;

select sysdate, round(sysdate), trunc(sysdate),
round(to_Date('2019-10-01 15:20:45', 'yyyy-mm-dd hh24:mi:ss'))
from dual;

select to_date(hiredate)+90 from emp;
select add_months(hiredate, 12) from emp;
select to_date('2019-12-25') - sysdate from dual;
select months_between('2019-12-25', sysdate) from dual;
select trunc(sysdate) - trunc(hiredate) from emp;
select months_between(sysdate, hiredate) from emp;
select last_day('2016-02-13') from emp;


select 1+'2', 2+'003', '004'
from dual;

select 1+to_number(2), 2+to_number('003') from dual;

select * from student
where birthday>=to_Date('1978-01-01');

--(1-1) to_char(날짜, 패턴) - 날짜를 문자로 변환
select sysdate, to_char(sysdate, 'yyyy'),
    to_char(sysdate, 'mm'), to_char(sysdate, 'dd'),
    to_char(sysdate, 'd'), --요일표기임
    to_char(sysdate, 'year'),
    to_char(sysdate, 'mon'), to_char(sysdate, 'month'),
    to_char(sysdate, 'ddd'), -- 1년중 며칠?
    to_char(sysdate, 'day'), --요일을 한글로
    to_char(sysdate, 'dy'), --요일(월화수~)
    to_char(sysdate, 'q')--분기
    from dual;
    
 select sysdate, to_char(sysdate, 'yyyy-mm-dd'),
 to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss d') from dual;
 
 select name, birthday from student
 where to_char(birthday, 'mm')='03';
 
 --(1,2) to_char(숫자, 패턴) -숫자를 패턴이 적용된 문자로 변황
 select 1234, to_char(1234,'99999'), to_char(1234, '$999999'),
to_char(1234,'L99999'), to_char(1234.56, '$999999.00')
 from dual;
 
--Professor 테이블을 참조하여 101번 학과 교수들의 이름과 연봉을 출력하시오. 단 연봉은
--(pay*12)+bonus 로 계산하고 천 단위 구분기호로 표시하시오.

select name, TO_CHAR(pay, '99,999') as "급여", TO_CHAR((pay*12)+bonus, '99,999') as "연봉" from professor
where deptno=101; 

-- to_date(문자, 패턴) - 문자를 날짜로 변환
select to_date('2019-10-11'),
to_date('2019-09-01','yyyy-mm-dd'),
to_date('2019-09-01','yyyy-mm-dd hh24:mi:ss')
from dual;

select * from professor where hiredate>='1995-01-01'; --자동형변환

select '2019-09-27' - '2019-09-26' from dual; --error

select to_date('2019-09-27') - to_date('2019-09-26') from dual;

--0817~0927까지의 데이터 조회
select * from pd
where regdate between to_date('2019-08-17') and to_date('2019-09-27')+1
order by regdate; 

select * from pd
where regdate >= to_date('2019-08-17') 
and regdate < to_date('2019-09-27 23:59:59', 'yyyy-mm-dd hh24:mi:ss')
order by regdate; 

--등록한지 몇 시간 지났나 조회
select (sysdate - to_date(regdate))*24 from pd;


--to_number -문자를 숫자로 변환
select '10' as "문자", 10 as "숫자1",
to_number('10') as 숫자2, to_number('003')+20 as 숫자3,
'005'+30 as 숫자4
from dual;


--[실습]Professor 테이블을 사용하여 1990년 이전에 입사한 교수명과 입사일,현재 연봉과 10% 인상 후 연봉을 출력하시오.
--연봉은 상여금(bonus)를 제외한 (pay*12)로 계산하고 연봉과 인상 후 연봉은
--천 단위 구분 기호를 추가하여 출력하시오.

select name, hiredate, TO_CHAR(pay*12, '99,999') as "현재연봉", TO_CHAR((pay*12)*1.1, '99,999') as "10% 인상 후 연봉" from professor
where hiredate<'1990-01-01';


--Professor 테이블에서 101번 학과 교수들의 이름과 급여,bonus, 연봉을 출력하시오. 단, 연봉은 (pay*12+bonus)로 계산
--하고 bonus가 없는 교수는 0으로 계산하시오

select name, bonus, hpage, nvl(bonus, 0), nvl(hpage, '홈페이지가 없다')
from professor;

select name, pay, bonus, pay*12+bonus, pay*12+nvl(bonus, 0),
nvl(pay*12+bonus, pay*12)
from professor
where deptno=101;


--nvl2(col1, col2, col3) :col1이 null이 아니면 col2를, null이면 col3출력
select name, bonus, hpage, nvl2(bonus, bonus, 0), nvl2(hpage, hpage, '홈페이지 없음')
from professor;

select name, pay, bonus, pay*12+bonus, pay*12+nvl(bonus, 0),
nvl2(bonus, bonus, pay*12)
from professor
where deptno=101;


-- employees 테이블에서 사원아이디, 이름 - 성(예 : Steven-King), 입사일, 기본급(salary), ? 
--수당(salary*commission_pct), 급여(salary+수당) 조회하 기 / 컬럼 별칭사용
-- 연봉(급여*12) 조회

select employee_id as "사원아이디", first_name|| '-' ||last_name as "이름-성", 
hire_date as "입사일", salary "기본급", salary*nvl(commission_pct, 1) as "수당", 
salary+(salary*nvl(commission_pct, 1)) as "급여"
from employees
order by "입사일", "기본급" desc;


--studentㅔ서 grade가 1이면 1학년 2이면 2학년, 3이면.. 아무튼 4학년까지
select name, grade, decode(grade, 1, '1학년',
                                  2, '2학년',
                                  3, '3학년',
                                  4, '4학년') as "학년",
                    decode(grade, 1, '1학년',
                                  2, '2학년',
                                  3, '3학년',
                                  4, '4학년') as "학년2"
                                  
from student;



--Professor 테이블에서 교수명, 학과번호, 학과명을 출력하되 deptno가 101번인 교수만 컴퓨터 공학과로
--출력하고 101번이 아닌 교수들은 학과명에 아무것도 출력하지 마세요.



--? Professor 테이블에서 교수명, 학과번호, 학과명을 출력하되 deptno가 101번인
--교수만 컴퓨터 공학과로 출력하고 101번이 아닌 교수들은 학과명에 ‘기타학과’로 출력하세요.
select name, deptno, decode(deptno, 101, '컴퓨터 공학과', '기타학과') "학과"
from professor;

--Professor 테이블에서 교수명, 학과명을출력하되 deptno가 101번이면 ‘컴퓨터 공학과’, 
--102번이면 ‘멀티미디어 공학과’, 103번이면 ‘소프트웨어 공학과’, 나머지는 ‘기타학과’로 출력하세요.
select name, deptno, decode(deptno, 101, '컴퓨터 공학과',
                                         102, '멀티미디어 공학과',
                                         103, '소프트웨어 공학과',
                                         '기타학과') "학과"
from professor;


--Professor 테이블에서 교수명, 부서번호를 출력하고, deptno가 101번인 부서중에서 
--이름이 조인형인 교수에게 ‘석좌교수 후보’라고 출력하세요. 나머지는 null 값 출력.
select name, deptno, decode(deptno, 101, decode(name, '조인형', '석좌교슈후보'))
from professor;


--Professor 테이블에서 교수명, 부서번호를 출력하고, deptno가 101번인 부서중에서 
--이름이 조인형인 교수에게 비고란에 ‘석좌교수 후보’라고 출력하세요. 101번 학과의 조인형 교수 외에는 비고
--란에 ‘후보아님’을 출력하고 101번 교수가 아닐 경우는 비고란이 공란이 되도록
select name, deptno, decode(deptno, 101, decode(name, '조인형', '석좌교슈후보', '후보아님'))
from professor;


--Student 테이블을 사용하여 제 1전공(deptno1)이 101번인 학과 학생들의 이름(name)과 주민번호(jumin), 
--성별을 출력하되 성별은 주민번호 칼럼을 이용하여 7번째 숫자가 1일 경우 ‘남자’, 2일 경우 ‘여자’로 출력하세요
select name, jumin, decode(substr(jumin,7,1), 1, '남자',
                                              2, '여자') "성별"
from student;


--Student 테이블에서 제 1전공(deptno1)이 101번인 학생들의 이름(name)과
--전화번호(tel), 지역명을 출력하세요. 지역명은 지역번호가 02는 서울, 031은 경기, 
--051은 부산,052는 울산, 055는 경남으로 출력하세요

select name, tel, decode(substr(tel,1,instr(tel, ')' )-1), '02', '서울',
                                          '031', '경기',
                                          '051', '부산',
                                          '052', '울산',
                                          '055', '경남') "지역"
                                          
                                          from student;

select ename, decode(job, 'CLERK', '사무원',
                   'SALESMAN', '판매원',
                   'MANAGER', '관리자',
                           '기타') "job"
from emp;

                                            